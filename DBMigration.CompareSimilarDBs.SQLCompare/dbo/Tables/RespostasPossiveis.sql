CREATE TABLE [dbo].[RespostasPossiveis] (
    [IdRespostaPossivel] INT           IDENTITY (1, 1) NOT NULL,
    [IdQuestao]          INT           NOT NULL,
    [TextoResposta]      VARCHAR (100) NULL,
    [Ordem]              INT           NULL,
    CONSTRAINT [PK_RespostasPossiveis] PRIMARY KEY CLUSTERED ([IdRespostaPossivel] ASC),
    CONSTRAINT [FK_RespostasPossiveis_Questoes] FOREIGN KEY ([IdQuestao]) REFERENCES [dbo].[Questoes] ([IdQuestao])
);

