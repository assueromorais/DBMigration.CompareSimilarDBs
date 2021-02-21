using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

#nullable disable

namespace DBMigration.CompareSimilarDBs.Data
{
    public partial class BaseLegadaGrupo
    {
        public long Id { get; set; }
        [DisplayName("Nome")]
        [Required(ErrorMessage ="Nome do grupo é obrigatório")]
        public string NomeGrupo { get; set; }
        [DisplayName("String de conexão com as bases")]
        [Required(ErrorMessage ="String de conexão é obrigatória")]
        public string ConnectionStringLegadas { get; set; }
        [DisplayName("Prefixo das bases")]
        [Required(ErrorMessage ="Prefixo do nome das bases é obrigatório")]
        public string PrefixoNomeBaseLegadas { get; set; }
        [DisplayName("Regex tabelas à descartar")]
        public string RegexNomeTabelasDescartar { get; set; }
        [DisplayName("Base legada")]
        public virtual ICollection<BaseLegada> BaseLegada { get; set; }
    }
}
