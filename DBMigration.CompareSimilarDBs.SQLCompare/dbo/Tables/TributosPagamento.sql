CREATE TABLE [dbo].[TributosPagamento] (
    [IdTributosPagamento] INT   IDENTITY (1, 1) NOT NULL,
    [IdPagamento]         INT   NOT NULL,
    [IdTributo]           INT   NOT NULL,
    [ValorTributo]        MONEY NOT NULL,
    [IdFormaPagamento]    INT   NULL,
    [IdPessoaTributo]     INT   NULL,
    [BaseCalculo]         MONEY NULL,
    CONSTRAINT [PK_TributosPagamento] PRIMARY KEY CLUSTERED ([IdTributosPagamento] ASC),
    CONSTRAINT [FK_TributosPagamento_FormasPagamento] FOREIGN KEY ([IdFormaPagamento]) REFERENCES [dbo].[FormasPagamento] ([IdFormaPagamento]),
    CONSTRAINT [FK_TributosPagamento_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_TributosPagamento_Pessoas] FOREIGN KEY ([IdPessoaTributo]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_TributosPagamento_Tributos] FOREIGN KEY ([IdTributo]) REFERENCES [dbo].[Tributos] ([IdTributo])
);

