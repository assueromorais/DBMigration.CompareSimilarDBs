using System;
using System.Collections.Generic;

#nullable disable

namespace DBMigration.CompareSimilarDBs.Data
{
    public partial class ParametroLegada
    {
        public decimal Id { get; set; }
        public bool DescartarTabelasVazias { get; set; }
        public string RegexNomeTabelasDescartar { get; set; }
    }
}
