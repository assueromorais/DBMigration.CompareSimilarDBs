CREATE TABLE [dbo].[ProfissionaisPesquisaWeb] (
    [IdProfissionalPesquisaWeb] INT           IDENTITY (1, 1) NOT NULL,
    [IdProfissional]            INT           NOT NULL,
    [Nome]                      VARCHAR (150) NULL,
    [NomeMae]                   VARCHAR (150) NULL,
    [NomePai]                   VARCHAR (150) NULL,
    [RG]                        VARCHAR (20)  NULL,
    [DataExpedicao]             DATETIME      NULL
);

