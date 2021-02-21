CREATE TABLE [dbo].[ProcessosTabela1] (
    [IdTabela1Proc]       INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]           VARCHAR (150) NULL,
    [IndApresentacaoTela] BIT           NULL,
    [IdTipoProcesso]      INT           NULL,
    [Desativado]          BIT           CONSTRAINT [DF_ProcessosTabela1Desativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Processo1Tabela1] PRIMARY KEY CLUSTERED ([IdTabela1Proc] ASC),
    CONSTRAINT [FK_ProcessosTabela1_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso]) ON DELETE CASCADE ON UPDATE CASCADE
);

