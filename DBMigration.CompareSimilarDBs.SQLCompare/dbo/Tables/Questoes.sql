CREATE TABLE [dbo].[Questoes] (
    [IdQuestao]        INT           IDENTITY (1, 1) NOT NULL,
    [IdPesquisa]       INT           NOT NULL,
    [IdQuadroQuestoes] INT           NULL,
    [TextoQuestao]     VARCHAR (255) NOT NULL,
    [TipoResposta]     VARCHAR (1)   NOT NULL,
    [Objetivo]         TEXT          NULL,
    [Ordem]            INT           NULL,
    [PermiteME]        BIT           NULL,
    CONSTRAINT [PK_Questoes] PRIMARY KEY CLUSTERED ([IdQuestao] ASC),
    CONSTRAINT [FK_Questoes_Pesquisa] FOREIGN KEY ([IdPesquisa]) REFERENCES [dbo].[Pesquisas] ([IdPesquisa]),
    CONSTRAINT [FK_Questoes_QuadroQuestoes] FOREIGN KEY ([IdQuadroQuestoes]) REFERENCES [dbo].[QuadrosQuestoes] ([IdQuadroQuestoes])
);


GO
ALTER TABLE [dbo].[Questoes] NOCHECK CONSTRAINT [FK_Questoes_QuadroQuestoes];

