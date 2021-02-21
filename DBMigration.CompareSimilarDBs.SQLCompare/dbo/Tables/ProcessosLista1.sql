CREATE TABLE [dbo].[ProcessosLista1] (
    [IdProcessoLista1] INT          IDENTITY (1, 1) NOT NULL,
    [Descricao]        VARCHAR (80) NOT NULL,
    [IdTipoProcesso]   INT          NOT NULL,
    [Desativado]       BIT          NULL,
    CONSTRAINT [PK_ProcessosLista1] PRIMARY KEY CLUSTERED ([IdProcessoLista1] ASC),
    CONSTRAINT [FK_ProcessosLista1_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso])
);

