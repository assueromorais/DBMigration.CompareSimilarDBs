CREATE TABLE [dbo].[PessoaCCustoAutorizacao] (
    [IdPessoaSispad] INT NOT NULL,
    [IdCentroCusto]  INT NOT NULL,
    CONSTRAINT [PK_PessoaCCustoAutorizacao_1] PRIMARY KEY CLUSTERED ([IdPessoaSispad] ASC, [IdCentroCusto] ASC),
    CONSTRAINT [FK_PessoaCCustoAutorizacao_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_PessoaCCustoAutorizacao_PessoasSispad] FOREIGN KEY ([IdPessoaSispad]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad])
);

