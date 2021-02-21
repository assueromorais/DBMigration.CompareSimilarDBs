CREATE TABLE [dbo].[TabelasPadronizacao] (
    [IdTabelaPadronizacao] INT           IDENTITY (1, 1) NOT NULL,
    [NomeTabela]           VARCHAR (100) NOT NULL,
    [NomeExibicao]         VARCHAR (100) NOT NULL,
    [CampoPK]              VARCHAR (100) NOT NULL,
    [NomeTabelaMestre]     VARCHAR (100) NULL,
    [Convertido]           BIT           CONSTRAINT [DF__TabelasPa__Conve__0D1418AF] DEFAULT ((0)) NULL,
    [ApenasExibicao]       BIT           CONSTRAINT [DF__TabelasPa__Apena__459868F4] DEFAULT ((0)) NULL,
    [ValorAgrupado]        BIT           CONSTRAINT [DF__TabelasPa__Valor__3C32F2FE] DEFAULT ((0)) NULL,
    [WhereSQL]             VARCHAR (200) NULL,
    [TipoPessoa]           INT           NULL,
    CONSTRAINT [Pk_TabelasPadronizacao] PRIMARY KEY CLUSTERED ([IdTabelaPadronizacao] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_TabelasPadronizacao_NomeExibicao]
    ON [dbo].[TabelasPadronizacao]([NomeExibicao] ASC);

