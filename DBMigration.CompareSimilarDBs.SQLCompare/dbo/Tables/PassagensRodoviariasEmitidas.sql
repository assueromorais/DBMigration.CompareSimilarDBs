CREATE TABLE [dbo].[PassagensRodoviariasEmitidas] (
    [IdPassagemRodoviariaEmitida]          INT          IDENTITY (1, 1) NOT NULL,
    [IdTrechoPessoaSolicitacaoViagem]      INT          NOT NULL,
    [IdPessoaCompanhia]                    INT          NULL,
    [DataPartida]                          DATETIME     NULL,
    [HoraPartida]                          DATETIME     NULL,
    [IdCidadePartida]                      INT          NULL,
    [HoraChegada]                          DATETIME     NULL,
    [IdCidadeChegada]                      INT          NULL,
    [StatusPassagemEmitida]                VARCHAR (20) NULL,
    [Ida]                                  BIT          NULL,
    [IdPagamento]                          INT          NULL,
    [IdPassagemRodoviariaEmitidaRemarcada] INT          NULL,
    [DataChegada]                          DATETIME     NULL,
    CONSTRAINT [PK_PassagensRodoviariasEmitidas] PRIMARY KEY CLUSTERED ([IdPassagemRodoviariaEmitida] ASC),
    CONSTRAINT [FK_PassagensRodoviariasEmitidas_Cidades] FOREIGN KEY ([IdCidadePartida]) REFERENCES [dbo].[Cidades] ([IdCidade]),
    CONSTRAINT [FK_PassagensRodoviariasEmitidas_Cidades1] FOREIGN KEY ([IdCidadeChegada]) REFERENCES [dbo].[Cidades] ([IdCidade]),
    CONSTRAINT [FK_PassagensRodoviariasEmitidas_Companhias] FOREIGN KEY ([IdPessoaCompanhia]) REFERENCES [dbo].[Companhias] ([IdPessoaCompanhia]),
    CONSTRAINT [FK_PassagensRodoviariasEmitidas_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_PassagensRodoviariasEmitidas_PassagensRodoviariasEmitidas] FOREIGN KEY ([IdPassagemRodoviariaEmitidaRemarcada]) REFERENCES [dbo].[PassagensRodoviariasEmitidas] ([IdPassagemRodoviariaEmitida]),
    CONSTRAINT [FK_PassagensRodoviariasEmitidas_TrechosPessoasSolicitacoesViagem] FOREIGN KEY ([IdTrechoPessoaSolicitacaoViagem]) REFERENCES [dbo].[TrechosPessoasSolicitacoesViagem] ([IdTrechoPessoaSolicitacaoViagem])
);

