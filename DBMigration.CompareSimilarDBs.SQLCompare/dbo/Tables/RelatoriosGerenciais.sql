CREATE TABLE [dbo].[RelatoriosGerenciais] (
    [IdRelatorioGerencial]     INT           IDENTITY (1, 1) NOT NULL,
    [NomeRelatorioGerencial]   VARCHAR (50)  NULL,
    [TituloRelatorioGerencial] VARCHAR (250) NULL,
    [PreEmpenho]               BIT           NULL,
    [TotalizarContas]          BIT           NULL,
    CONSTRAINT [PK_RelatoriosGerenciais] PRIMARY KEY CLUSTERED ([IdRelatorioGerencial] ASC)
);

