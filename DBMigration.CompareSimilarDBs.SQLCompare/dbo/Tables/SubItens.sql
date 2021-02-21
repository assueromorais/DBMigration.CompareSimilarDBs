CREATE TABLE [dbo].[SubItens] (
    [IdSubItem]         INT          IDENTITY (1, 1) NOT NULL,
    [IdItem]            INT          NOT NULL,
    [DataCadastramento] DATETIME     NOT NULL,
    [NomeSubItem]       VARCHAR (60) NOT NULL,
    [Descricao]         TEXT         NULL,
    [CodigoBarra]       VARCHAR (30) NULL,
    [Ativo]             BIT          NULL,
    [Localizacao]       TEXT         NULL,
    CONSTRAINT [PK_SubItens] PRIMARY KEY NONCLUSTERED ([IdSubItem] ASC),
    CONSTRAINT [FK_SubItens_Itens] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[Itens] ([IdItem]) NOT FOR REPLICATION
);

