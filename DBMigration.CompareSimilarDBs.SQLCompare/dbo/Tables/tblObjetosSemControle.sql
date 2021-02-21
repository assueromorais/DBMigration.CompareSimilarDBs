CREATE TABLE [dbo].[tblObjetosSemControle] (
    [IdObj]            INT            IDENTITY (1, 1) NOT NULL,
    [NomeObj]          NVARCHAR (200) NOT NULL,
    [ScriptGeracaoObj] NVARCHAR (MAX) NOT NULL,
    [DataCriacaoObj]   DATETIME       NOT NULL,
    CONSTRAINT [PK_tblObjetosSemControle] PRIMARY KEY CLUSTERED ([IdObj] ASC)
);

