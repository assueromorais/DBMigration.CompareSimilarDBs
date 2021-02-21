CREATE TABLE [dbo].[Web_DotacoesLog] (
    [Identificador]      INT          NOT NULL,
    [IdConta]            INT          NULL,
    [Valor]              MONEY        NULL,
    [IdCentroCusto]      INT          NULL,
    [DataDotacao]        DATETIME     NULL,
    [Analitica]          BIT          NULL,
    [UsuarioResponsavel] VARCHAR (30) NULL,
    [DataOperacao]       DATETIME     NULL
);

