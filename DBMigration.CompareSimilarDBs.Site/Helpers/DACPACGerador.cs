using Microsoft.Extensions.Configuration;
using System;
using System.Data.SqlClient;
using System.Text;
using System.Threading;

namespace Micracao.ComparadorBasesLegadas.Helpers
{
    public class DACPACGerador
    {
        IConfiguration configuration;
        public DACPACGerador(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public string GerarArquivoDacPacDeBase(string nomeDaBase, string connectionStringBase, bool sobrescreverSeExistir = false)
        {
            string diretorioDACPACs = configuration.GetSection("DirectoryDACPAC").Value;
            string arquivoDACPACGerado = diretorioDACPACs + nomeDaBase + ".dacpac";
            if (sobrescreverSeExistir || !System.IO.File.Exists(arquivoDACPACGerado))
            {
                var process = new System.Diagnostics.Process();
                string sqlPackageExe = configuration.GetSection("SqlPackage").Value;
                var csb = new SqlConnectionStringBuilder(connectionStringBase);

                var startInfo = new System.Diagnostics.ProcessStartInfo
                {

                    WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden,
                    FileName = sqlPackageExe,
                    Arguments = @$"/TargetFile:{arquivoDACPACGerado} /Action:Extract /SourceServerName:{csb.DataSource} /SourceDatabaseName:{nomeDaBase} /SourceUser:{csb.UserID} /SourcePassword:""{csb.Password}"" /p:IgnoreExtendedProperties=false /p:IgnorePermissions=true /p:IgnoreUserLoginMappings=true"
                };
                startInfo.UseShellExecute = false;
                startInfo.RedirectStandardOutput = !startInfo.UseShellExecute;
                startInfo.RedirectStandardError = !startInfo.UseShellExecute;
                process.StartInfo = startInfo;
                var output = new StringBuilder();
                var error = new StringBuilder();
                int timeout = 300000;
                using var outputWaitHandle = new AutoResetEvent(false);
                using var errorWaitHandle = new AutoResetEvent(false);
                process.OutputDataReceived += (sender, e) =>
                {
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
                    if (process.ExitCode == 1)
                    {
                        throw new Exception($"Falha ao executar a geração do DACPAC da base '{nomeDaBase}'. Mensagem: \n{error}");
                    }
                }
            }
            return arquivoDACPACGerado;
        }

    }
}
