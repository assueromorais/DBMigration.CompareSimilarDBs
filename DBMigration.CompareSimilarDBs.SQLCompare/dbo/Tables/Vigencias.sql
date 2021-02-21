CREATE TABLE [dbo].[Vigencias] (
    [IdVigencia]            INT      IDENTITY (1, 1) NOT NULL,
    [IdFaixaCapital]        INT      NULL,
    [DataInicialVigencia]   DATETIME NULL,
    [DataFinalVigencia]     DATETIME NULL,
    [Valor]                 MONEY    NULL,
    [AplicarDuodecimo]      BIT      NULL,
    [IdTipoDebito]          INT      NOT NULL,
    [IdDadosPFPJ]           INT      NULL,
    [PrazoVencimento]       INT      NULL,
    [NumParcelas]           INT      NULL,
    [TipoParcelamento]      CHAR (2) NULL,
    [DataBaseCalc]          CHAR (1) NULL,
    [idConfigGeracaoDebito] INT      NULL,
    CONSTRAINT [PK_Vigencias] PRIMARY KEY CLUSTERED ([IdVigencia] ASC),
    CONSTRAINT [FK_Vigencias_ConfigGerDebito] FOREIGN KEY ([idConfigGeracaoDebito]) REFERENCES [dbo].[ConfigGeracaoDebito] ([IdConfigGeracaoDebito]),
    CONSTRAINT [FK_Vigencias_DadosPFPJ] FOREIGN KEY ([IdDadosPFPJ]) REFERENCES [dbo].[DadosPFPJ] ([IdDadosPFPJ]),
    CONSTRAINT [FK_Vigencias_FaixasCapital] FOREIGN KEY ([IdFaixaCapital]) REFERENCES [dbo].[FaixasCapital] ([IdFaixaCapital]),
    CONSTRAINT [FK_Vigencias_TiposDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito])
);

