using DBMigration.CompareSimilarDBs.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Xml;

namespace Micracao.ComparadorBasesLegadas.Helpers
{
    public class ComparadorBases
    {
        private object lockObject = new object();
        private const string xPathTargetElement = ".//Target";
        private const string xPathSourceElement = ".//Source";
        public IConfiguration configuration { get; }

        public ComparadorBases(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public void ExecuteAsync(CancellationToken stoppingToken, ComparacaoBases ComparacaoBases)
        {
            if (!stoppingToken.IsCancellationRequested)
            {
                _ = Task.Run(() => { CompararECriarComparacoes(ComparacaoBases); }, stoppingToken);
            }
        }

        public void Execute(ComparacaoBases ComparacaoBases)
        {
            CompararECriarComparacoes(ComparacaoBases);
        }

        private void CompararECriarComparacoes(ComparacaoBases comparacaoBases)
        {
            var contexto = new DBMigrationCompareSimilarDBsContext();
            DateTime dataInicio = DateTime.Now;
            BaseLegada baseAlvo = contexto.BaseLegada.Include(bl => bl.BaseLegadaGrupoNavigation).FirstOrDefault(bl => bl.Id == comparacaoBases.BaseAlvo);
            BaseLegada baseFonte = contexto.BaseLegada.Find(comparacaoBases.BaseFonte);
            string tempPath = Path.GetTempPath();
            string prefixo = $"{tempPath}Compare_{baseFonte.Nome}_{baseAlvo.Nome}";
            string xmlOutPutFile = $"{prefixo}_out.xml";
            try
            {
                contexto.ComparacaoBasesElementos.RemoveRange(contexto.ComparacaoBasesElementos.Where(cbe => cbe.ComparacaoBases == comparacaoBases.Id));
                GerarArquivoComparacaoSQL(baseFonte.Nome, baseAlvo.Nome, xmlOutPutFile, baseAlvo.BaseLegadaGrupoNavigation.ConnectionStringLegadas);
                comparacaoBases = ExtrairInformacoesComparacaoDeXML(xmlOutPutFile, comparacaoBases);
                // Exclui os elementos da comparação, se existir, para refazer a comparação existente.
                comparacaoBases.StatusComparacao = StatusComparacao.Concluida;
                comparacaoBases.DataComparacao = DateTime.Now;
            }
            catch (Exception ex)
            {
                comparacaoBases.StatusComparacao = StatusComparacao.Falha;
                comparacaoBases.MensagemFalha = ex.Message;
            }
            comparacaoBases.TempoComparacaoEmMinutos = (DateTime.Now - dataInicio).TotalMinutes;
            lock (lockObject)
            {
                contexto.ComparacaoBases.Update(comparacaoBases);
                _ = contexto.SaveChangesAsync();
            }
        }

        private void GerarArquivoComparacaoSQL(string nomeBaseFonte, string nomeBaseAlvo, string xmlOutPutFile, string connectionStringBasesLegadas)
        {
            if (File.Exists(xmlOutPutFile))
                return;
            string diretorioDACPACs = configuration.GetSection("DirectoryDACPAC").Value;
            new DACPACGerador(configuration).GerarArquivoDacPacDeBase(nomeBaseFonte, connectionStringBasesLegadas);
            new DACPACGerador(configuration).GerarArquivoDacPacDeBase(nomeBaseAlvo, connectionStringBasesLegadas);
            var startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.FileName = $"{configuration.GetSection("MSBuildExeFile").Value}";
            startInfo.Arguments = $"{configuration.GetSection("SchemaCompareProjectCSProjFile").Value} /t:SqlSchemaCompare /p:CmdLineInMemoryStorage=TRUE /p:source=\"{diretorioDACPACs}{nomeBaseFonte}.dacpac\" /p:target=\"{diretorioDACPACs}{nomeBaseAlvo}.dacpac\" /p:xmlOutput=\"{xmlOutPutFile}\" /p:Deploy=false /p:CmdLineInMemoryStorage=TRUE /t:Build  /p:DropObjectsNotInSource=True /p:DropIndexesNotInSource=True /p:TreatVerificationErrorsAsWarnings=true /p:IgnoreExtendedProperties=true /p:IgnoreColumnCollation=true /p:IgnoreColumnOrder=true /p:IgnoreComments=true /p:IgnoreIncrement=true /p:IgnoreTableOptions=true /p:IgnoreUserSettingsObjects=true /p:AllowDropBlockingAssemblies=false /p:IgnoreIndexOptions=true /p:ExcludeObjectType=ServerTriggers /p:ExcludeObjectType=Users /p:ExcludeObjectType=Views /p:ExcludeObjectType=Logins /p:ExcludeObjectType=StoredProcedures /p:ExcludeObjectType=DatabaseTriggers /p:ExcludeObjectType=Assemblies /p:ExcludeObjectType=Permissions /p:ExcludeObjectType=Queues /p:ExcludeObjectType=XmlSchemaCollections /p:ExcludeObjectType=Trigger";
            startInfo.UseShellExecute = false;
            //WARNING!!! If the powershell script outputs lots of data, this code could hang
            //You will need to output using a stream reader and purge the contents from time to time
            startInfo.RedirectStandardOutput = !startInfo.UseShellExecute;
            startInfo.RedirectStandardError = !startInfo.UseShellExecute;
            var process = new System.Diagnostics.Process();
            process.StartInfo = startInfo;
            var output = new StringBuilder();
            var error = new StringBuilder();
            int timeout = 300000;
            using var outputWaitHandle = new AutoResetEvent(false);
            using var errorWaitHandle = new AutoResetEvent(false);
            process.OutputDataReceived += (sender, e) =>
            {
                lock (lockObject)
                    if (e.Data == null)
                    {
                        outputWaitHandle.Set();
                    }
                    else
                    {
                        output.AppendLine(e.Data);
                    }
            };
            process.ErrorDataReceived += (sender, e) =>
            {
                lock (lockObject)
                    if (e.Data == null)
                    {
                        errorWaitHandle.Set();
                    }
                    else
                    {
                        error.AppendLine(e.Data);
                    }
            };

            process.Start();
            process.BeginOutputReadLine();
            process.BeginErrorReadLine();

            if (process.WaitForExit(timeout) && outputWaitHandle.WaitOne(timeout) && errorWaitHandle.WaitOne(timeout))
            {
                // Process completed. Check process.ExitCode here.
                if (process.ExitCode == 1)
                {
                    throw new Exception($"Falha ao executar a comparação (build) das bases. Mensagem: \n{error}");
                }
            }
            else
            {
                // Timed out.
            }
        }

        private ComparacaoBases ExtrairInformacoesComparacaoDeXML(string xmlFileOut, ComparacaoBases comparacaoBases)
        {
            var settings = new XmlReaderSettings();
            settings.IgnoreWhitespace = true;
            string stringConteudo = File.ReadAllText(xmlFileOut);
            var xmlDocument = new XmlDocument();
            xmlDocument.LoadXml(stringConteudo);
            XmlNodeList elementsGroup = xmlDocument.SelectNodes("//Result/Group");
            var nsmgr = new XmlNamespaceManager(xmlDocument.NameTable);
            nsmgr.AddNamespace("entry", "urn:newbooks-schema");
            string tagNomeElemento;

            foreach (XmlNode elementGroup in elementsGroup)
            {
                TipoOcorrencia tipoOcorrencia = ObterTipoOcorrenciaPorValueGroup(elementGroup.Attributes["Value"].Value);
                tagNomeElemento = tipoOcorrencia == TipoOcorrencia.Exclusao ? xPathTargetElement : xPathSourceElement;
                // Entra nas 'tabelas'
                XmlNodeList elementosTabelas = elementGroup.SelectNodes(".//Entry[@Name='Table'][@Type='TopLevelElement']");
                foreach (XmlNode entry in elementosTabelas)
                {

                    // Salva os dados da tabela
                    var comparacaoBasesElemento = new ComparacaoBasesElemento();
                    comparacaoBasesElemento.ComparacaoBases = comparacaoBases.Id;
                    comparacaoBasesElemento.TipoElemento = ((char)TipoElemento.Tabela).ToString();
                    comparacaoBasesElemento.TipoOcorrencia = ((char)tipoOcorrencia).ToString();
                    comparacaoBasesElemento.XmlOutCompare = entry.OuterXml;
                    comparacaoBasesElemento.Nome = entry.SelectSingleNode(tagNomeElemento).InnerText;
                    // Se existir, recupera as entradas de colunas da tabela
                    XmlNodeList elementosColunas = entry.SelectNodes(".//Entry/Children/Entry[@Name='Column'][@Type='Element']");
                    foreach (XmlNode childrenEntry in elementosColunas)
                    {
                        var comparacaoBasesElementoFilho = new ComparacaoBasesElemento();
                        comparacaoBasesElementoFilho.ComparacaoBases = comparacaoBases.Id;
                        comparacaoBasesElementoFilho.TipoElemento = ((char)TipoElemento.Coluna).ToString();
                        string nomeColuna = childrenEntry.SelectSingleNode(xPathTargetElement).InnerText;
                        bool colunaExisteNoAlvo = true;
                        if (string.IsNullOrWhiteSpace(nomeColuna))
                        {
                            nomeColuna = childrenEntry.SelectSingleNode(xPathSourceElement).InnerText;
                            colunaExisteNoAlvo = false;
                        }
                        if (tipoOcorrencia != TipoOcorrencia.Alteracao)
                        {
                            // Fora ocorrência de alteração da tabela, a ocorrência da coluna é a mesma da tabela
                            comparacaoBasesElementoFilho.TipoOcorrencia = ((char)tipoOcorrencia).ToString();
                        }
                        else
                        {
                            // Se ocorrência da tabela é de alteração, tem que verificar de q lado a coluna existe.
                            comparacaoBasesElementoFilho.TipoOcorrencia = ((char)(colunaExisteNoAlvo ? TipoOcorrencia.Exclusao : TipoOcorrencia.Inclusao)).ToString();
                        }
                        comparacaoBasesElementoFilho.XmlOutCompare = childrenEntry.OuterXml;
                        comparacaoBasesElementoFilho.Nome = nomeColuna;
                        comparacaoBasesElemento.InverseElementoPaiNavigation.Add(comparacaoBasesElementoFilho);
                    }
                    comparacaoBasesElemento.ComparacaoBasesNavigation = comparacaoBases;
                    // Só adiciona elemento de alteração (tabela) se possuir elmentos filhos (colunas modificadas)
                    if (comparacaoBasesElemento.TipoOcorrencia != "A" || comparacaoBasesElemento.InverseElementoPaiNavigation.Count > 0)
                        comparacaoBases.ComparacaoBasesElementos.Add(comparacaoBasesElemento);
                }
            }
            comparacaoBases.XmlOutCompare = stringConteudo;
            return comparacaoBases;
        }

        private static TipoOcorrencia ObterTipoOcorrenciaPorValueGroup(string groupValueAttribute)
        {
            switch (groupValueAttribute.Trim().ToLower())
            {
                case "delete":
                    return TipoOcorrencia.Exclusao;
                case "add":
                    return TipoOcorrencia.Inclusao;
                default:
                    return TipoOcorrencia.Alteracao;
            }
        }

    }
}
