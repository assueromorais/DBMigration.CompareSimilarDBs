CREATE TABLE [dbo].[RelacoesCreditos] (
    [IdRelacaoCredito]    INT          IDENTITY (1, 1) NOT NULL,
    [NumRelacaoCredito]   VARCHAR (20) NULL,
    [ValorRelacaoCredito] MONEY        NULL,
    [DataRelacaoCredito]  DATETIME     NULL,
    [Conciliado]          BIT          CONSTRAINT [DF__RelacoesC__Conci__28FB2D25] DEFAULT ((0)) NULL,
    [InicioPeriodo]       DATETIME     NULL,
    [FimPeriodo]          DATETIME     NULL,
    [TotalizarFavorecido] BIT          NULL,
    [ExibirRetencoes]     BIT          NULL,
    CONSTRAINT [PK_RelacoesCredito] PRIMARY KEY CLUSTERED ([IdRelacaoCredito] ASC)
);

