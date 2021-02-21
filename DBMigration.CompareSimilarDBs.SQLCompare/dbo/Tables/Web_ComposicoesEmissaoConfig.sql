CREATE TABLE [dbo].[Web_ComposicoesEmissaoConfig] (
    [IdWeb_ComposicoesEmissaoConfig] INT            IDENTITY (1, 1) NOT NULL,
    [IdComposicaoEmissaoConfig]      INT            NOT NULL,
    [IdComposicaoEmissao]            INT            NOT NULL,
    [CodDesconto1]                   TINYINT        NULL,
    [DataDesconto1]                  DATETIME       NULL,
    [ValorDesconto1]                 MONEY          NULL,
    [CodDesconto2]                   TINYINT        NULL,
    [DataDesconto2]                  DATETIME       NULL,
    [ValorDesconto2]                 MONEY          NULL,
    [CodDesconto3]                   TINYINT        NULL,
    [DataDesconto3]                  DATETIME       NULL,
    [ValorDesconto3]                 MONEY          NULL,
    [AtualizacaoWeb]                 VARCHAR (5000) NULL,
    [IndAtualizacao]                 BIT            NULL,
    [DataBaixa]                      DATETIME       NULL
);

