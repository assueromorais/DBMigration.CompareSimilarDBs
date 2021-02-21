CREATE TABLE [dbo].[ProcessosTabela5] (
    [IdTabela5Proc]  INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]      VARCHAR (150) NULL,
    [IdTipoProcesso] INT           NULL,
    [Desativado]     BIT           CONSTRAINT [DF_ProcessosTabela5Desativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Processos1Tabela5] PRIMARY KEY CLUSTERED ([IdTabela5Proc] ASC),
    CONSTRAINT [FK_ProcessosTabela5_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso]) ON DELETE CASCADE ON UPDATE CASCADE
);

