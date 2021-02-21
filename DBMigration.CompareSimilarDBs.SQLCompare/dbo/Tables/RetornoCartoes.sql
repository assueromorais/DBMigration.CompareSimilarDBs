CREATE TABLE [dbo].[RetornoCartoes] (
    [IdRetornoCartao]      INT           IDENTITY (1, 1) NOT NULL,
    [DataOperacao]         DATETIME      NULL,
    [DataCredito]          DATETIME      NULL,
    [NumEstabelecimento]   VARCHAR (10)  NULL,
    [NumResumo]            VARCHAR (10)  NULL,
    [QtdComprovantes]      INT           NULL,
    [Descricao]            VARCHAR (250) NULL,
    [ValorBruto]           MONEY         NULL,
    [ValorLiquido]         MONEY         NULL,
    [Bandeira]             VARCHAR (50)  NULL,
    [Operacao]             VARCHAR (10)  NULL,
    [IdControleArquivoCob] INT           NULL,
    CONSTRAINT [PK_RetornoCartoes] PRIMARY KEY CLUSTERED ([IdRetornoCartao] ASC),
    CONSTRAINT [FK_RetornoCartoes_ControleArquivosCobranca] FOREIGN KEY ([IdControleArquivoCob]) REFERENCES [dbo].[ControleArquivosCobranca] ([IdControleArquivoCob])
);

