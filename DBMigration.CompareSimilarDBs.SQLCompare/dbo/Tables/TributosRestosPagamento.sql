CREATE TABLE [dbo].[TributosRestosPagamento] (
    [IdTributosRestosPagamento] INT   IDENTITY (1, 1) NOT NULL,
    [IdRestosPagamento]         INT   NOT NULL,
    [IdTributo]                 INT   NOT NULL,
    [ValorTributo]              MONEY NOT NULL,
    [IdFormaPagamento]          INT   NULL,
    [IdPessoaTributo]           INT   NULL,
    [BaseCalculo]               MONEY NULL,
    CONSTRAINT [PK_TributosRestosPagamento] PRIMARY KEY CLUSTERED ([IdTributosRestosPagamento] ASC),
    CONSTRAINT [FK_TributosRestosPagamento_FormasPagamento] FOREIGN KEY ([IdFormaPagamento]) REFERENCES [dbo].[FormasPagamento] ([IdFormaPagamento]),
    CONSTRAINT [FK_TributosRestosPagamento_Pessoas] FOREIGN KEY ([IdPessoaTributo]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_TributosRestosPagamento_RestosPagamento] FOREIGN KEY ([IdRestosPagamento]) REFERENCES [dbo].[RestosPagamento] ([IdRestosPagamento]),
    CONSTRAINT [FK_TributosRestosPagamento_Tributos] FOREIGN KEY ([IdTributo]) REFERENCES [dbo].[Tributos] ([IdTributo])
);

