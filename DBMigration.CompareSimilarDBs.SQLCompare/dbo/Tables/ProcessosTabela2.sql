CREATE TABLE [dbo].[ProcessosTabela2] (
    [IdTabela2Proc]  INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]      VARCHAR (150) NULL,
    [IdTipoProcesso] INT           NULL,
    [Desativado]     BIT           CONSTRAINT [DF_ProcessosTabela2Desativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Processos1Tabela2] PRIMARY KEY CLUSTERED ([IdTabela2Proc] ASC),
    CONSTRAINT [FK_ProcessosTabela2_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso]) ON DELETE CASCADE ON UPDATE CASCADE
);

