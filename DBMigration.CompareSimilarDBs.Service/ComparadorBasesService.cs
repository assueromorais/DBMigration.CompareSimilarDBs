//using DBMigration.CompareSimilarDBs.Data;
//using Microsoft.Extensions.Configuration;
//using Microsoft.Extensions.Hosting;
//using Microsoft.Extensions.Logging;
//using System;
//using System.IO;
//using System.Linq;
//using System.Threading;
//using System.Threading.Tasks;
//using System.Xml;

//namespace Micracao.ComparadorBasesLegadas.Service
//{
//    public class ComparadorBasesService : BackgroundService
//    {
//        private readonly ILogger<ComparadorBasesService> _logger;
//        private readonly MigracaoComparadorBasesLegadasContext _context;

//        private const string xPathTargetElement = ".//Target";
//        private const string xPathSourceElement = ".//Source";
//        public IConfiguration configuration { get; }

//        public ComparacaoBases ComparacaoBases { get; set; }

//        public ComparadorBasesService(MigracaoComparadorBasesLegadasContext context, ILogger<ComparadorBasesService> logger, IConfiguration configuration)
//        {
//            _context = context;
//            _logger = logger;
//            this.configuration = configuration;
//        }

//        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
//        {
//            if (!stoppingToken.IsCancellationRequested)
//            {
//                CompararECriarComparacoes(ComparacaoBases);
//            }
//        }
//        private void CompararECriarComparacoes(ComparacaoBases comparacaoBases)
//        {
//            BaseLegada baseAlvo = _context.BaseLegada.Find(comparacaoBases.BaseAlvo);
//            BaseLegada baseFonte = _context.BaseLegada.Find(comparacaoBases.BaseFonte);
//            string tempPath = Path.GetTempPath();
//            string prefixo = $"{tempPath}Compare_{baseFonte.Nome}_{baseAlvo.Nome}";
//            string xmlOutPutFile = $"{prefixo}_out.xml";
//            string scmpFileTemp = $"{prefixo}.scmp";
//            string scmpFileModel = $"{Environment.CurrentDirectory}\\Compare_Model.scmp";
//            System.IO.File.Copy(scmpFileModel, scmpFileTemp, true);
//            AlterarBasesArquivoSCMP(scmpFileTemp, baseFonte.Nome, baseAlvo.Nome);
//            GerarArquivoComparacaoSQL(scmpFileTemp, xmlOutPutFile);
//            comparacaoBases = ExtrairInformacoesComparacaoDeXML(xmlOutPutFile, comparacaoBases);
//            comparacaoBases = CalcularDiferencasEntreBases(comparacaoBases);
//            // Exclui os elementos de comparação, se existir, para refazer a comparação existente.
//            _context.ComparacaoBasesElementos.RemoveRange(_context.ComparacaoBasesElementos.Where(cbe => cbe.ComparacaoBases == comparacaoBases.Id));
//            _context.ComparacaoBases.Update(comparacaoBases);
//            _context.SaveChangesAsync();
//        }

//        /// <summary>
//        /// Verifica quantos elementos (tabelas e colunas) faltam no alvo comparando com a fonte e vice e versa.
//        /// </summary>
//        /// <param name="comparacaoBases"></param>
//        /// <returns></returns>
//        private ComparacaoBases CalcularDiferencasEntreBases(ComparacaoBases comparacaoBases)
//        {
//            //comparacaoBases. comparacaoBases.ComparacaoBasesElementos.Where();
//            return comparacaoBases;
//        }

//        private void GerarArquivoComparacaoSQL(string scmpFileTemp, string xmlOutPutFile)
//        {
//            //using PowerShell ps = System.Management.Automation.PowerShell.Create();
//            //ps.AddScript($"& 'C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\MSBuild\\Current\\Bin\\MSBuild.exe'");
//            //ps.AddParameter($"'D:\\Fontes\\GIT\\BRC.Migracao.Schema.Impanta\\BRC.Migracao.Schema.Impanta\\BRC.Migracao.Schema.Impanta.sqlproj' /t:SqlSchemaCompare /p:SqlScmpFilePath='{scmpFileTemp}' /p:xmlOutput='{xmlOutPutFile}' /p:Deploy='true'");
//            //var pipelineObjects = await ps.InvokeAsync().ConfigureAwait(false);

//            var startInfo = new System.Diagnostics.ProcessStartInfo();
//            startInfo.FileName = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\MSBuild\\Current\\Bin\\MSBuild.exe";
//            startInfo.Arguments = $"D:\\Fontes\\GIT\\BRC.Migracao.Schema.Impanta\\BRC.Migracao.Schema.Impanta\\BRC.Migracao.Schema.Impanta.sqlproj /t:SqlSchemaCompare /p:SqlScmpFilePath=\"{scmpFileTemp}\" /p:xmlOutput=\"{xmlOutPutFile}\" /p:Deploy=true";
//            startInfo.UseShellExecute = false;

//            //WARNING!!! If the powershell script outputs lots of data, this code could hang
//            //You will need to output using a stream reader and purge the contents from time to time
//            startInfo.RedirectStandardOutput = !startInfo.UseShellExecute;
//            startInfo.RedirectStandardError = !startInfo.UseShellExecute;

//            startInfo.CreateNoWindow = true;
//            startInfo.RedirectStandardError = true;
//            startInfo.RedirectStandardOutput = true;
//            //startInfo.CreateNoWindow = true;
//            var process = new System.Diagnostics.Process();
//            process.StartInfo = startInfo;
//            process.Start();
//            process.WaitForExit();
//            if (process.ExitCode == 1)
//            {
//                var output = process.StandardOutput;
//                var strOutput = output.ReadToEnd();
//                throw new Exception($"Falha ao executar a comparação (build) das bases. Mensagem: \n{strOutput}");
//            }
//        }

//        private void AlterarBasesArquivoSCMP(string scmpFileTemp, string baseFonteNome, string baseAlvoNome)
//        {
//            string connectionStringLegada = configuration.GetConnectionString("sqlserverLegadas");
//            string conteudo = System.IO.File.ReadAllText(scmpFileTemp);
//            conteudo = conteudo.Replace("##CONNECTIONSTRINGSOURCE##", $"{connectionStringLegada.Replace("master", baseFonteNome)}");
//            conteudo = conteudo.Replace("##CONNECTIONSTRINGTARGET##", $"{connectionStringLegada.Replace("master", baseAlvoNome)}");
//            System.IO.File.WriteAllText(scmpFileTemp, conteudo);
//        }

//        private ComparacaoBases ExtrairInformacoesComparacaoDeXML(string xmlFileOut, ComparacaoBases comparacaoBases)
//        {
//            var settings = new XmlReaderSettings();
//            settings.IgnoreWhitespace = true;
//            string stringConteudo = System.IO.File.ReadAllText(xmlFileOut);
//            var xmlDocument = new XmlDocument();
//            xmlDocument.LoadXml(stringConteudo);
//            XmlNodeList elementsGroup = xmlDocument.SelectNodes("//Result/Group");
//            var nsmgr = new XmlNamespaceManager(xmlDocument.NameTable);
//            nsmgr.AddNamespace("entry", "urn:newbooks-schema");
//            string tagNomeElemento;

//            foreach (XmlNode elementGroup in elementsGroup)
//            {
//                TipoOcorrencia tipoOcorrencia = ObterTipoOcorrenciaPorValueGroup(elementGroup.Attributes["Value"].Value);
//                tagNomeElemento = tipoOcorrencia == TipoOcorrencia.Exclusao ? xPathTargetElement : xPathSourceElement;
//                // Entra nas 'tabelas'
//                foreach (XmlNode entry in elementGroup.ChildNodes)
//                {

//                    if (entry.Attributes["Name"].Value.ToLower() == "table")
//                    {
//                        // Salva os dados da tabela
//                        var comparacaoBasesElemento = new ComparacaoBasesElemento();
//                        comparacaoBasesElemento.ComparacaoBases = comparacaoBases.Id;
//                        comparacaoBasesElemento.TipoElemento = ((char)TipoElemento.Tabela).ToString();
//                        comparacaoBasesElemento.TipoOcorrencia = ((char)tipoOcorrencia).ToString();
//                        comparacaoBasesElemento.XmlOutCompare = entry.InnerXml;
//                        comparacaoBasesElemento.Nome = entry.SelectSingleNode(tagNomeElemento).InnerText;
//                        // Se existir, recupera as entradas de colunas da tabela
//                        foreach (XmlNode childrenEntry in entry.SelectNodes(".//Entry/Children/Entry[@Name='Column']"))
//                        {
//                            var comparacaoBasesElementoFilho = new ComparacaoBasesElemento();
//                            comparacaoBasesElementoFilho.ComparacaoBases = comparacaoBases.Id;
//                            comparacaoBasesElementoFilho.TipoElemento = ((char)TipoElemento.Coluna).ToString();
//                            string nomeColuna = childrenEntry.SelectSingleNode(xPathTargetElement).InnerText;
//                            bool colunaExisteNoAlvo = true;
//                            if (string.IsNullOrWhiteSpace(nomeColuna))
//                            {
//                                nomeColuna = childrenEntry.SelectSingleNode(xPathSourceElement).InnerText;
//                                colunaExisteNoAlvo = false;
//                            }
//                            if (tipoOcorrencia != TipoOcorrencia.Alteracao)
//                            {
//                                // Fora ocorrência de alteração da tabela, a ocorrência da coluna é a mesma da tabela
//                                comparacaoBasesElementoFilho.TipoOcorrencia = ((char)tipoOcorrencia).ToString();
//                            }
//                            else
//                            {
//                                // Se ocorrência da tabela é de alteração, tem que verificar de q lado a coluna existe.
//                                comparacaoBasesElementoFilho.TipoOcorrencia = ((char)(colunaExisteNoAlvo ? TipoOcorrencia.Exclusao : TipoOcorrencia.Inclusao)).ToString();
//                            }
//                            comparacaoBasesElementoFilho.XmlOutCompare = childrenEntry.InnerXml;
//                            comparacaoBasesElementoFilho.Nome = nomeColuna;
//                            comparacaoBasesElementoFilho.ElementoPaiNavigation = comparacaoBasesElemento;
//                            comparacaoBasesElementoFilho.ComparacaoBasesNavigation = comparacaoBases;
//                            comparacaoBasesElemento.InverseElementoPaiNavigation.Add(comparacaoBasesElementoFilho);
//                        }
//                        comparacaoBasesElemento.ComparacaoBasesNavigation = comparacaoBases;
//                        comparacaoBases.ComparacaoBasesElementos.Add(comparacaoBasesElemento);
//                    }
//                }
//            }
//            comparacaoBases.XmlOutCompare = stringConteudo;
//            return comparacaoBases;
//        }

//        private static TipoOcorrencia ObterTipoOcorrenciaPorValueGroup(string groupValueAttribute)
//        {
//            switch (groupValueAttribute.Trim().ToLower())
//            {
//                case "delete":
//                    return TipoOcorrencia.Exclusao;
//                case "add":
//                    return TipoOcorrencia.Inclusao;
//                case "change":
//                    return TipoOcorrencia.Alteracao;
//                default:
//                    return TipoOcorrencia.Alteracao;
//            }
//        }

//    }
//}
