using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

#nullable disable

namespace DBMigration.CompareSimilarDBs.Data
{
    public partial class ComparacaoBasesElemento
    {
        public ComparacaoBasesElemento()
        {
            InverseElementoPaiNavigation = new HashSet<ComparacaoBasesElemento>();
        }

        public long Id { get; set; }
        public string TipoElemento { get; set; }
        public string TipoOcorrencia { get; set; }
        public long? ElementoPai { get; set; }
        public long ComparacaoBases { get; set; }
        public string Nome { get; set; }
        [NotMapped]
        public string XmlOutCompare { get; set; }
        public double? Tamanho { get; set; }
        public int? TotalRegistros { get; set; }

        public virtual ComparacaoBases ComparacaoBasesNavigation { get; set; }
        public virtual ComparacaoBasesElemento ElementoPaiNavigation { get; set; }
        public virtual ICollection<ComparacaoBasesElemento> InverseElementoPaiNavigation { get; set; }
    }
}
