CREATE TABLE [dbo].[tblObjetosBanco] (
    [IdObj]            INT            IDENTITY (1, 1) NOT NULL,
    [NomeObj]          NVARCHAR (200) NOT NULL,
    [TipoObj]          NVARCHAR (2)   NOT NULL,
    [ScriptGeracaoObj] NVARCHAR (MAX) NOT NULL,
    [DataCriacaoObj]   DATETIME       NOT NULL,
    [DataAlteracaoObj] DATETIME       NULL,
    [VersaoDatInicial] INT            NOT NULL,
    [VersaoDatAtual]   INT            NOT NULL,
    [TipoClienteDat]   NVARCHAR (50)  NOT NULL,
    [Executa]          BIT            NULL,
    [Excluido]         BIT            NULL,
    CONSTRAINT [PK_tblObjetosBanco] PRIMARY KEY CLUSTERED ([IdObj] ASC)
);

