CREATE TABLE [dbo].[SelecaoCNAB] (
    [IdSelecao]              INT          IDENTITY (1, 1) NOT NULL,
    [IdUsuario]              INT          NULL,
    [PeriodoDe]              DATETIME     NULL,
    [PeriodoAte]             DATETIME     NULL,
    [ContaDe]                VARCHAR (18) NULL,
    [ContaAte]               VARCHAR (18) NULL,
    [DataGeracaoPagamento]   DATETIME     NULL,
    [NomeBanco]              VARCHAR (60) NULL,
    [PagamentosSelecionados] TEXT         NULL,
    [DataGeracao]            DATETIME     NULL,
    [TotalArquivo]           MONEY        NULL,
    CONSTRAINT [PK_SelecaoCNAB] PRIMARY KEY CLUSTERED ([IdSelecao] ASC),
    CONSTRAINT [FK_SelecaoCNAB_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);

