USE [DBMigration.CompareSimilarDBs.Modelo]
GO
/****** Object:  Table [dbo].[BaseLegada]    Script Date: 21/02/2021 14:17:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaseLegada](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](255) NOT NULL,
	[StatusMigracao] [bigint] NULL,
	[LinkRespostorio] [varchar](255) NULL,
	[Tamanho] [float] NULL,
	[DataUltimaEstatistica] [datetime] NULL,
	[BaseLegadaGrupo] [bigint] NOT NULL,
 CONSTRAINT [PK_BaseLegada] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BaseLegadaGrupo]    Script Date: 21/02/2021 14:17:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaseLegadaGrupo](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[NomeGrupo] [varchar](200) NOT NULL,
	[ConnectionStringLegadas] [varchar](500) NOT NULL,
	[PrefixoNomeBaseLegadas] [varchar](100) NOT NULL,
	[RegexNomeTabelasDescartar] [varchar](250) NULL,
 CONSTRAINT [PK_BaseLegadaGrupo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComparacaoBases]    Script Date: 21/02/2021 14:17:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComparacaoBases](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[BaseAlvo] [bigint] NOT NULL,
	[BaseFonte] [bigint] NOT NULL,
	[XmlOutCompare] [xml] NULL,
	[DataComparacao] [datetime] NOT NULL,
	[StatusComparacao] [int] NULL,
	[MensagemFalha] [text] NULL,
	[TempoComparacaoEmMinutos] [float] NULL,
 CONSTRAINT [PK_BaseComparacao] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComparacaoBasesElemento]    Script Date: 21/02/2021 14:17:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComparacaoBasesElemento](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TipoElemento] [char](1) NOT NULL,
	[TipoOcorrencia] [char](1) NOT NULL,
	[ElementoPai] [bigint] NULL,
	[ComparacaoBases] [bigint] NOT NULL,
	[Nome] [varchar](255) NOT NULL,
	[XmlOutCompare] [xml] NULL,
	[Tamanho] [float] NULL,
	[TotalRegistros] [int] NULL,
 CONSTRAINT [PK_BaseComparacaoElemento] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ParametroLegadas]    Script Date: 21/02/2021 14:17:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParametroLegadas](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DescartarTabelasVazias] [bit] NOT NULL,
	[RegexNomeTabelasDescartar] [varchar](250) NULL,
 CONSTRAINT [PK_ParametroLegadas] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusMigracao]    Script Date: 21/02/2021 14:17:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusMigracao](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](255) NOT NULL,
 CONSTRAINT [PK_StatusMigracao] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ComparacaoBases]  WITH CHECK ADD  CONSTRAINT [FK_BaseComparacao_BaseComparacao_Fonte] FOREIGN KEY([BaseFonte])
REFERENCES [dbo].[BaseLegada] ([ID])
GO
ALTER TABLE [dbo].[ComparacaoBases] CHECK CONSTRAINT [FK_BaseComparacao_BaseComparacao_Fonte]
GO
ALTER TABLE [dbo].[ComparacaoBases]  WITH CHECK ADD  CONSTRAINT [FK_BaseComparacao_BaseLegada_Alvo] FOREIGN KEY([BaseAlvo])
REFERENCES [dbo].[BaseLegada] ([ID])
GO
ALTER TABLE [dbo].[ComparacaoBases] CHECK CONSTRAINT [FK_BaseComparacao_BaseLegada_Alvo]
GO
ALTER TABLE [dbo].[ComparacaoBasesElemento]  WITH CHECK ADD  CONSTRAINT [FK_BaseComparacaoElemento_BaseComparacao] FOREIGN KEY([ComparacaoBases])
REFERENCES [dbo].[ComparacaoBases] ([ID])
GO
ALTER TABLE [dbo].[ComparacaoBasesElemento] CHECK CONSTRAINT [FK_BaseComparacaoElemento_BaseComparacao]
GO
ALTER TABLE [dbo].[ComparacaoBasesElemento]  WITH CHECK ADD  CONSTRAINT [FK_BaseComparacaoElemento_BaseComparacaoElemento1] FOREIGN KEY([ElementoPai])
REFERENCES [dbo].[ComparacaoBasesElemento] ([ID])
GO
ALTER TABLE [dbo].[ComparacaoBasesElemento] CHECK CONSTRAINT [FK_BaseComparacaoElemento_BaseComparacaoElemento1]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de elemento do banco de dados: T=Tabela, C=Coluna' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ComparacaoBasesElemento', @level2type=N'COLUMN',@level2name=N'TipoElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de ocorrência: I = Inclusão, A = Alteração, E = Exclusão' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ComparacaoBasesElemento', @level2type=N'COLUMN',@level2name=N'TipoOcorrencia'
GO
