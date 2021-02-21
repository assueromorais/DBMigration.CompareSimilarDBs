CREATE TABLE [dbo].[SerasaTiposInscricao] (
    [IdSerasaTipo]  INT          IDENTITY (1, 1) NOT NULL,
    [Codigo]        CHAR (1)     NULL,
    [TipoInscricao] VARCHAR (30) NULL,
    CONSTRAINT [PK_SerasaTiposInscricao_IdSerasaSituacao] PRIMARY KEY CLUSTERED ([IdSerasaTipo] ASC)
);

