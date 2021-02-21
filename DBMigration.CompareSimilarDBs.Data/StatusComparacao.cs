using System.ComponentModel.DataAnnotations;

namespace DBMigration.CompareSimilarDBs.Data
{
    public enum StatusComparacao
    {
        [Display(Name="Não iniciada")]
        NaoIniciada = 0,
        [Display(Name = "Em andamento")]
        EmAndamento = 1,
        [Display(Name = "Concluída")]
        Concluida = 2,
        [Display(Name = "Falha")]
        Falha = 3,
    }
}