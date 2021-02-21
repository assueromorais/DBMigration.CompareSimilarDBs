using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

#nullable disable

namespace DBMigration.CompareSimilarDBs.Data
{
    public partial class ComparacaoBases
    {
        public ComparacaoBases()
        {
            ComparacaoBasesElementos = new HashSet<ComparacaoBasesElemento>();
        }

        public long Id { get; set; }
        [DisplayName("Base alvo (nova)")]
        public long BaseAlvo { get; set; }
        [DisplayName("Base de referência")]
        public long BaseFonte { get; set; }
        [DisplayName("XML de comparação")]
        [NotMapped]
        public string XmlOutCompare { get; set; }
        [DisplayName("Data")]
        public DateTime DataComparacao { get; set; }
        [DisplayName("Status")]
        public StatusComparacao? StatusComparacao { get; set; }
        [DisplayName("Mensagem de falha")]
        public string MensagemFalha { get; set; }

        [DisplayName("Tempo (em minutos)")]
        [DisplayFormat(DataFormatString = "{0:0.00}", ApplyFormatInEditMode = true)]
        public double? TempoComparacaoEmMinutos { get; set; }
        [DisplayName("Base alvo (nova)")]
        public virtual BaseLegada BaseAlvoNavigation { get; set; }
        [DisplayName("Base de referência")]
        public virtual BaseLegada BaseFonteNavigation { get; set; }
        public virtual ICollection<ComparacaoBasesElemento> ComparacaoBasesElementos { get; set; }
    }
}
