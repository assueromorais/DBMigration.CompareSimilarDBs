using System;
using System.Collections.Generic;

#nullable disable

namespace DBMigration.CompareSimilarDBs.Data
{
    public partial class StatusMigracao
    {
        public StatusMigracao()
        {
            BaseLegada = new HashSet<BaseLegada>();
        }

        public long Id { get; set; }
        public string Nome { get; set; }

        public virtual ICollection<BaseLegada> BaseLegada { get; set; }
    }
}
