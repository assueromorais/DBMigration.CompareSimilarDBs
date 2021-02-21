CREATE TABLE [dbo].[SerasaSituacoes] (
    [IdSerasaSituacao] INT          IDENTITY (1, 1) NOT NULL,
    [Codigo]           CHAR (2)     NULL,
    [Situacao]         VARCHAR (30) NULL,
    CONSTRAINT [PK_SerasaSituacoes_IdSerasaSituacao] PRIMARY KEY CLUSTERED ([IdSerasaSituacao] ASC)
);

