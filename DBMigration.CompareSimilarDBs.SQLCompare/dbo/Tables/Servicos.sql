CREATE TABLE [dbo].[Servicos] (
    [IdServico]          INT          IDENTITY (1, 1) NOT NULL,
    [Descricao]          VARCHAR (60) NULL,
    [DescricaoDetalhada] TEXT         NULL,
    [Desativado]         BIT          DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Servicos] PRIMARY KEY CLUSTERED ([IdServico] ASC)
);

