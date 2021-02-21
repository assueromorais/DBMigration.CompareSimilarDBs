﻿CREATE TABLE [dbo].[PassagensAereasEmitidas] (
    [IdPassagemAereaEmitida]          INT           IDENTITY (1, 1) NOT NULL,
    [IdTrechoPessoaSolicitacaoViagem] INT           NULL,
    [IdPessoaCompanhia]               INT           NULL,
    [NumVoo]                          INT           NULL,
    [DataPartida]                     DATETIME      NULL,
    [HoraPartida]                     DATETIME      NULL,
    [IdPessoaAeroportoPartida]        INT           NULL,
    [HoraChegada]                     DATETIME      NULL,
    [IdPessoaAeroportoChegada]        INT           NULL,
    [QtdEscalas]                      INT           NULL,
    [Localizador]                     VARCHAR (20)  NULL,
    [Ida]                             BIT           NULL,
    [IdPagamento]                     INT           NULL,
    [IdPassagemRemarcada]             INT           NULL,
    [HistoricoBilhete]                TEXT          NULL,
    [IdStatusPassagem]                INT           NULL,
    [ETicket]                         VARCHAR (100) NULL,
    [IdProcessoSolicitacaoViagem]     INT           NULL,
    [HotelChegada]                    VARCHAR (100) NULL,
    [DataVolta]                       DATETIME      NULL,
    [HoraPartidaVolta]                DATETIME      NULL,
    [HoraChegadaVolta]                DATETIME      NULL,
    [NumVooVolta]                     INT           NULL,
    [NumeroBilhete]                   VARCHAR (100) NULL,
    [AssentoIda]                      VARCHAR (10)  NULL,
    [AssentoVolta]                    VARCHAR (10)  NULL,
    [NaoRecolherImposto]              BIT           NULL,
    [VooInternacional]                BIT           NULL,
    [Situacao]                        CHAR (1)      NULL,
    [Observacoes]                     TEXT          NULL,
    [Conta]                           VARCHAR (50)  NULL,
    [ContaStr]                        VARCHAR (300) NULL,
    [ContaCodigo]                     VARCHAR (100) NULL,
    [DataEmissao]                     DATETIME      NULL,
    CONSTRAINT [PK_PassagensEmitidas] PRIMARY KEY CLUSTERED ([IdPassagemAereaEmitida] ASC),
    CONSTRAINT [FK_PassagensAereasEmitidas_IdProcessoSolicitacaoViagem] FOREIGN KEY ([IdProcessoSolicitacaoViagem]) REFERENCES [dbo].[ProcessosSolicitacaoViagem] ([IdProcessoSolicitacaoViagem]),
    CONSTRAINT [FK_PassagensAereasEmitidas_StatusPassagem] FOREIGN KEY ([IdStatusPassagem]) REFERENCES [dbo].[StatusPassagem] ([IdStatusPassagem]),
    CONSTRAINT [FK_PassagensEmitidas_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_PassagensEmitidas_PassagensEmitidas] FOREIGN KEY ([IdPassagemRemarcada]) REFERENCES [dbo].[PassagensAereasEmitidas] ([IdPassagemAereaEmitida]),
    CONSTRAINT [FK_TrechosPassagensEmitidas_TrechosPessoasSolicitacoesViagem] FOREIGN KEY ([IdTrechoPessoaSolicitacaoViagem]) REFERENCES [dbo].[TrechosPessoasSolicitacoesViagem] ([IdTrechoPessoaSolicitacaoViagem])
);
