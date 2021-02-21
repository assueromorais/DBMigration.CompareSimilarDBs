CREATE TABLE [dbo].[PesosValoresCorrespondencias] (
    [IdPesosValores]     INT   IDENTITY (1, 1) NOT NULL,
    [IdFormaNotificacao] INT   NOT NULL,
    [PesoInicial]        MONEY NULL,
    [PesoFinal]          MONEY NULL,
    [Valor]              MONEY NULL,
    CONSTRAINT [PK_PesosValoresCorrespondencias] PRIMARY KEY CLUSTERED ([IdPesosValores] ASC),
    CONSTRAINT [FK_PesosValoresCorrespondencias_FormasNotificacao] FOREIGN KEY ([IdFormaNotificacao]) REFERENCES [dbo].[FormasNotificacao] ([IdFormaNotificacao])
);

