CREATE TABLE [dbo].[SituacaoRepresentacaoAnuenio] (
    [IdSituacaoRepresentacaoAnuenio] INT           IDENTITY (1, 1) NOT NULL,
    [SituacaoRepresentacaoAnuenio]   NVARCHAR (50) NULL,
    CONSTRAINT [PK_SituacaoRepresentacaoAnuenio] PRIMARY KEY CLUSTERED ([IdSituacaoRepresentacaoAnuenio] ASC)
);

