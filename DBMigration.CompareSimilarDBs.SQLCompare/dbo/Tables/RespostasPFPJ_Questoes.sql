CREATE TABLE [dbo].[RespostasPFPJ_Questoes] (
    [IdRespostaPFPJ]       INT           NOT NULL,
    [IdQuestao]            INT           NOT NULL,
    [IdRespostaObjetiva]   INT           NULL,
    [RespostaSubjetiva]    TEXT          NULL,
    [ComplementoResposta]  TEXT          NULL,
    [IdRespostaObjetivaME] VARCHAR (255) NULL,
    CONSTRAINT [FK_RespostasPFPJ_Questoes_Questoes] FOREIGN KEY ([IdQuestao]) REFERENCES [dbo].[Questoes] ([IdQuestao]),
    CONSTRAINT [FK_RespostasPFPJ_Questoes_RespostasPossiveis] FOREIGN KEY ([IdRespostaObjetiva]) REFERENCES [dbo].[RespostasPossiveis] ([IdRespostaPossivel]),
    CONSTRAINT [RespostasPFPJ_RespostasPFPJ_Questoes_FK] FOREIGN KEY ([IdRespostaPFPJ]) REFERENCES [dbo].[RespostasPFPJ] ([IdRespostaPFPJ]) NOT FOR REPLICATION
);

