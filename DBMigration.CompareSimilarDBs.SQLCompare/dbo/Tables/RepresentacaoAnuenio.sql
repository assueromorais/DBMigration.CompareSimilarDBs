CREATE TABLE [dbo].[RepresentacaoAnuenio] (
    [IdRepresentacaoAnuenio]         INT      IDENTITY (1, 1) NOT NULL,
    [IdRepresentacao]                INT      NOT NULL,
    [IdSituacaoRepresentacaoAnuenio] INT      NULL,
    [Ano]                            INT      NULL,
    [DataInicio]                     DATETIME NULL,
    [DataTermino]                    DATETIME NULL,
    [Observacao]                     NTEXT    NULL,
    CONSTRAINT [PK_RepresentacaoAnuenio] PRIMARY KEY CLUSTERED ([IdRepresentacaoAnuenio] ASC),
    CONSTRAINT [FK_RepresentacaoAnuenio_Representacao] FOREIGN KEY ([IdRepresentacaoAnuenio]) REFERENCES [dbo].[Representacao] ([IdRepresentacao]),
    CONSTRAINT [FK_RepresentacaoAnuenio_SituacaoRepresentacaoAnuenio] FOREIGN KEY ([IdSituacaoRepresentacaoAnuenio]) REFERENCES [dbo].[SituacaoRepresentacaoAnuenio] ([IdSituacaoRepresentacaoAnuenio])
);

