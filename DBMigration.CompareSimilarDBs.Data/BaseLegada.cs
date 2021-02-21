using System;
using System.Collections.Generic;
using System.ComponentModel;

#nullable disable

namespace DBMigration.CompareSimilarDBs.Data
{
    public partial class BaseLegada
    {
        public BaseLegada()
        {
            ComparacaoBasisBaseAlvoNavigations = new HashSet<ComparacaoBases>();
            ComparacaoBasisBaseFonteNavigations = new HashSet<ComparacaoBases>();
        }

        public long Id { get; set; }
        public string Nome { get; set; }
        [DisplayName("Status da migração")]
        public long? StatusMigracao { get; set; }
        [DisplayName("Repositório GIT")]
        public string LinkRespostorio { get; set; }
        [DisplayName("Tamanho (KB)")]
        public double? Tamanho { get; set; }
        [DisplayName("Última estatística")]
        public DateTime? DataUltimaEstatistica { get; set; }
        public virtual StatusMigracao StatusMigracaoNavigation { get; set; }
        public long? BaseLegadaGrupo { get; set; }
        [DisplayName("Base legada")]
        public virtual BaseLegadaGrupo BaseLegadaGrupoNavigation { get; set; }
        public virtual ICollection<ComparacaoBases> ComparacaoBasisBaseAlvoNavigations { get; set; }
        public virtual ICollection<ComparacaoBases> ComparacaoBasisBaseFonteNavigations { get; set; }
    }
}
