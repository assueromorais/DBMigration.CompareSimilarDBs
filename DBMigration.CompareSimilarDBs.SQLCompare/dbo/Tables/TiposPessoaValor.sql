CREATE TABLE [dbo].[TiposPessoaValor] (
    [IdTipoPessoaValor] INT           IDENTITY (1, 1) NOT NULL,
    [IdTipoPessoa]      INT           NULL,
    [Data]              DATETIME      NULL,
    [IdTipoDespesa]     INT           NULL,
    [IdConta]           INT           NULL,
    [Valor]             MONEY         NULL,
    [ValorInterior]     MONEY         NULL,
    [IdMoeda]           INT           NULL,
    [ContaPadrao]       VARCHAR (50)  NULL,
    [ContaPadraoStr]    VARCHAR (300) NULL,
    [ContaPadraoCodigo] VARCHAR (100) NULL,
    CONSTRAINT [PK_TiposPessoaValor] PRIMARY KEY CLUSTERED ([IdTipoPessoaValor] ASC),
    CONSTRAINT [FK_TiposPessoaValor_Moeda_IdMoeda] FOREIGN KEY ([IdMoeda]) REFERENCES [dbo].[Moedas] ([IdMoeda]),
    CONSTRAINT [FK_TiposPessoaValor_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_TiposPessoaValor_TiposDespesas] FOREIGN KEY ([IdTipoDespesa]) REFERENCES [dbo].[TiposDespesas] ([IdTipoDespesa]),
    CONSTRAINT [FK_TiposPessoaValor_TiposPessoa] FOREIGN KEY ([IdTipoPessoa]) REFERENCES [dbo].[TiposPessoa] ([IdTipoPessoa])
);

