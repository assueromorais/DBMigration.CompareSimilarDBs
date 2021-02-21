CREATE TABLE [dbo].[SituacoesDivAtiva] (
    [IdDividaAtiva]    INT      NOT NULL,
    [SituacaoDivAtiva] INT      NOT NULL,
    [Data]             DATETIME NULL,
    [TipoDividaAtiva]  INT      NOT NULL,
    [Desativado]       BIT      CONSTRAINT [DF_SituacoesDivAtivaDesativado] DEFAULT ((0)) NULL,
    [Protestada]       BIT      CONSTRAINT [DF_SituacoesDivAtiva_Protestada] DEFAULT ((0)) NOT NULL,
    [DataProtesto]     DATETIME NULL,
    CONSTRAINT [FK_DivAtiva_SituacoesDivAtiva_DividaAtiva] FOREIGN KEY ([IdDividaAtiva]) REFERENCES [dbo].[DividaAtiva] ([IdDividaAtiva])
);

