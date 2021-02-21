using DBMigration.CompareSimilarDBs.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
namespace Micracao.ComparadorBasesLegadas.Service
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureServices((hostContext, services) =>
                {
                    services.AddDbContext<DBMigrationCompareSimilarDBsContext>(options => options.UseLazyLoadingProxies().UseSqlServer(hostContext.Configuration.GetConnectionString("sqlserver")));
                });
    }
}
