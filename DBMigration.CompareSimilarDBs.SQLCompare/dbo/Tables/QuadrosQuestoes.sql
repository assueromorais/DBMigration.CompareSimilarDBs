CREATE TABLE [dbo].[QuadrosQuestoes] (
    [IdQuadroQuestoes]   INT           IDENTITY (1, 1) NOT NULL,
    [IdPesquisa]         INT           NOT NULL,
    [NomeQuadroQuestoes] VARCHAR (255) NULL,
    [Objetivo]           TEXT          NULL,
    [Ordem]              INT           NULL,
    CONSTRAINT [PK_QuadrosQuestoes] PRIMARY KEY CLUSTERED ([IdQuadroQuestoes] ASC),
    CONSTRAINT [FK_QuadroQuestoes_Pesquisa] FOREIGN KEY ([IdPesquisa]) REFERENCES [dbo].[Pesquisas] ([IdPesquisa])
);

