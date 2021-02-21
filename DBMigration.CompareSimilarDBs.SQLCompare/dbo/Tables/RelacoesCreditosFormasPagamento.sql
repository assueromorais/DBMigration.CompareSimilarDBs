CREATE TABLE [dbo].[RelacoesCreditosFormasPagamento] (
    [IdRelacaoCredito] INT          NOT NULL,
    [IdFormaPagamento] INT          NOT NULL,
    [Status]           TEXT         NULL,
    [Banco]            VARCHAR (20) NULL,
    [Agencia]          VARCHAR (20) NULL,
    [Conta]            VARCHAR (20) NULL,
    [IdFormaCredito]   INT          NULL,
    CONSTRAINT [PK_RelacoesCreditosFormasPagamento] PRIMARY KEY CLUSTERED ([IdRelacaoCredito] ASC, [IdFormaPagamento] ASC),
    CONSTRAINT [FK_RelacoesCreditosFormasPagamento_RelacoesCreditos] FOREIGN KEY ([IdRelacaoCredito]) REFERENCES [dbo].[RelacoesCreditos] ([IdRelacaoCredito])
);

