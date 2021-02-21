CREATE TABLE [dbo].[ProcessosTabela3] (
    [IdTabela3Proc]  INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]      VARCHAR (150) NULL,
    [IdTipoProcesso] INT           NULL,
    [Desativado]     BIT           CONSTRAINT [DF_ProcessosTabela3Desativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Processos1Tabela3] PRIMARY KEY CLUSTERED ([IdTabela3Proc] ASC),
    CONSTRAINT [FK_ProcessosTabela3_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso]) ON DELETE CASCADE ON UPDATE CASCADE
);

