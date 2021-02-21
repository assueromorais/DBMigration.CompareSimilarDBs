CREATE TABLE [dbo].[ProcessosTabela4] (
    [IdTabela4Proc]  INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]      VARCHAR (150) NULL,
    [IdTipoProcesso] INT           NULL,
    [Desativado]     BIT           CONSTRAINT [DF_ProcessosTabela4Desativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Processos1Tabela4] PRIMARY KEY CLUSTERED ([IdTabela4Proc] ASC),
    CONSTRAINT [FK_ProcessosTabela4_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso]) ON DELETE CASCADE ON UPDATE CASCADE
);

