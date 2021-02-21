using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace DBMigration.CompareSimilarDBs.Data
{
    public partial class DBMigrationCompareSimilarDBsContext : DbContext
    {
        public DBMigrationCompareSimilarDBsContext()
        {
        }

        public DBMigrationCompareSimilarDBsContext(DbContextOptions<DBMigrationCompareSimilarDBsContext> options)
            : base(options)
        {
        }

        public virtual DbSet<BaseLegadaGrupo> BaseLegadaGrupos { get; set; }
        public virtual DbSet<BaseLegada> BaseLegada { get; set; }
        public virtual DbSet<ComparacaoBasesElemento> ComparacaoBasesElementos { get; set; }
        public virtual DbSet<ComparacaoBases> ComparacaoBases { get; set; }
        public virtual DbSet<ParametroLegada> ParametroLegadas { get; set; }
        public virtual DbSet<StatusMigracao> StatusMigracaos { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=DESKTOP-5FJ38JA;Database=Migracao.ComparadorBasesLegadas;Trusted_Connection=True;MultipleActiveResultSets=true;User ID=sa;Password=123Mudar;");
                optionsBuilder.ConfigureWarnings(w => w.Ignore(CoreEventId.LazyLoadOnDisposedContextWarning));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BaseLegadaGrupo>(entity =>
            {
                entity.ToTable("BaseLegadaGrupo");
                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.ConnectionStringLegadas)
                    .IsRequired()
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.NomeGrupo)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.PrefixoNomeBaseLegadas)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.RegexNomeTabelasDescartar)
                    .HasMaxLength(250)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<BaseLegada>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.DataUltimaEstatistica).HasColumnType("datetime");

                entity.Property(e => e.LinkRespostorio)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Nome)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.HasOne(d => d.StatusMigracaoNavigation)
                    .WithMany(p => p.BaseLegada)
                    .HasForeignKey(d => d.StatusMigracao)
                    .HasConstraintName("FK_BaseLegada_StatusMigracao");

                entity.HasOne(d => d.BaseLegadaGrupoNavigation)
                    .WithMany(p => p.BaseLegada)
                    .HasForeignKey(d => d.BaseLegadaGrupo)
                    .HasConstraintName("FK_BaseLegada_BaseLegadaGrupo");
            });

            modelBuilder.Entity<ComparacaoBasesElemento>(entity =>
            {
                entity.ToTable("ComparacaoBasesElemento");

                entity.HasIndex(e => new { e.ElementoPai, e.TipoElemento, e.TipoOcorrencia }, "IX_ComparacaoBasesElemento");

                entity.HasIndex(e => e.ElementoPai, "IX_ComparacaoBasesElemento_1");

                entity.HasIndex(e => new { e.TipoElemento, e.TipoOcorrencia }, "IX_ComparacaoBasesElemento_2");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Nome)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.TipoElemento)
                    .IsRequired()
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .IsFixedLength(true)
                    .HasComment("Tipo de elemento do banco de dados: T=Tabela, C=Coluna");

                entity.Property(e => e.TipoOcorrencia)
                    .IsRequired()
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .IsFixedLength(true)
                    .HasComment("Tipo de ocorrência: I = Inclusão, A = Alteração, E = Exclusão");

                //entity.Property(e => e.XmlOutCompare).HasColumnType("xml");
                entity.Property(e => e.TotalRegistros).IsFixedLength(true);

                entity.HasOne(d => d.ComparacaoBasesNavigation)
                    .WithMany(p => p.ComparacaoBasesElementos)
                    .HasForeignKey(d => d.ComparacaoBases)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BaseComparacaoElemento_BaseComparacao");

                entity.HasOne(d => d.ElementoPaiNavigation)
                    .WithMany(p => p.InverseElementoPaiNavigation)
                    .HasForeignKey(d => d.ElementoPai)
                    .HasConstraintName("FK_BaseComparacaoElemento_BaseComparacaoElemento1");
            });

            modelBuilder.Entity<ComparacaoBases>(entity =>
            {
                entity.HasIndex(e => new { e.BaseAlvo, e.BaseFonte }, "IX_ComparacaoBases");

                entity.HasIndex(e => e.BaseAlvo, "IX_ComparacaoBases_1");

                entity.HasIndex(e => e.BaseFonte, "IX_ComparacaoBases_2");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.DataComparacao).HasColumnType("datetime");

                entity.Property(e => e.MensagemFalha).HasColumnType("text");

                entity.Property(e => e.XmlOutCompare).HasColumnType("xml");

                entity.HasOne(d => d.BaseAlvoNavigation)
                    .WithMany(p => p.ComparacaoBasisBaseAlvoNavigations)
                    .HasForeignKey(d => d.BaseAlvo)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BaseComparacao_BaseLegada_Alvo");

                entity.HasOne(d => d.BaseFonteNavigation)
                    .WithMany(p => p.ComparacaoBasisBaseFonteNavigations)
                    .HasForeignKey(d => d.BaseFonte)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BaseComparacao_BaseComparacao_Fonte");
            });

            modelBuilder.Entity<ParametroLegada>(entity =>
            {
                entity.Property(e => e.Id)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("ID");

                entity.Property(e => e.RegexNomeTabelasDescartar)
                    .HasMaxLength(250)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<StatusMigracao>(entity =>
            {
                entity.ToTable("StatusMigracao");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Nome)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
