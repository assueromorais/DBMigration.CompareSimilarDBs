CREATE TABLE [dbo].[TrechosVoos] (
    [IdTrechoVoo]              INT      IDENTITY (1, 1) NOT NULL,
    [IdVoo]                    INT      NOT NULL,
    [QtdEscalas]               INT      NULL,
    [IdPessoaAeroportoPartida] INT      NULL,
    [HoraPartida]              DATETIME NULL,
    [IdPessoaAeroportoChegada] INT      NULL,
    [HoraChegada]              DATETIME NULL,
    [TrechoAtivo]              BIT      CONSTRAINT [DF_TrechosVoos_TrechoAtivo] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_Trechos] PRIMARY KEY CLUSTERED ([IdTrechoVoo] ASC),
    CONSTRAINT [FK_Trechos_Voos] FOREIGN KEY ([IdVoo]) REFERENCES [dbo].[Voos] ([IdVoo]),
    CONSTRAINT [FK_TrechosVoos_Aeroportos] FOREIGN KEY ([IdPessoaAeroportoPartida]) REFERENCES [dbo].[Aeroportos] ([IdPessoaAeroporto]),
    CONSTRAINT [FK_TrechosVoos_Aeroportos1] FOREIGN KEY ([IdPessoaAeroportoChegada]) REFERENCES [dbo].[Aeroportos] ([IdPessoaAeroporto])
);

