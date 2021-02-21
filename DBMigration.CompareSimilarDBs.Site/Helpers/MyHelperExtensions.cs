using Microsoft.AspNetCore.Mvc.Rendering;

namespace Micracao.ComparadorBasesLegadas
{
    public static class MyHelperExtensions
    {
        public static string GetCssClass(this IHtmlHelper helper, DBMigration.CompareSimilarDBs.Data.StatusComparacao? status)
        {
            // Make sure this mirrors values in RegistrationStatus enum!
            switch (status)
            {
                case DBMigration.CompareSimilarDBs.Data.StatusComparacao.NaoIniciada:
                    return "table-warning";
                case DBMigration.CompareSimilarDBs.Data.StatusComparacao.EmAndamento:
                    return "table-active";
                case DBMigration.CompareSimilarDBs.Data.StatusComparacao.Concluida:
                    return "table-success";
                case DBMigration.CompareSimilarDBs.Data.StatusComparacao.Falha:
                    return "table-danger";
                default:
                    return null;
            }
        }
        public static string GetCssClass(this IHtmlHelper helper, string status)
        {
            // Make sure this mirrors values in RegistrationStatus enum!
            switch (status?.Trim().ToLower())
            {
                case "não iniciada":
                    return "table-warning";
                case "em andamento":
                    return "table-success";
                case "concluída":
                    return "table-active";
                case "suspensa":
                    return "table-danger";
                default:
                    return null;
            }
        }
    }
}
