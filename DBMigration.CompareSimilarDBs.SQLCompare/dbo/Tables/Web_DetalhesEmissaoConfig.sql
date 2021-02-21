CREATE TABLE [dbo].[Web_DetalhesEmissaoConfig] (
    [IdWeb_DetalhesEmissaoConfig] INT            IDENTITY (1, 1) NOT NULL,
    [IdDetalheEmissaoConfig]      INT            NOT NULL,
    [IdDetalheEmissao]            INT            NOT NULL,
    [CodMulta]                    TINYINT        NULL,
    [ValorMulta]                  MONEY          NULL,
    [CodJuros]                    TINYINT        NULL,
    [ValorJuros]                  MONEY          NULL,
    [AtualizacaoWeb]              VARCHAR (5000) NULL,
    [IndAtualizacao]              BIT            NULL,
    [DataBaixa]                   DATETIME       NULL
);

