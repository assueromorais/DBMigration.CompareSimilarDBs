CREATE TABLE [dbo].[UnidadesCentroCustosAno] (
    [IdUnidadeCentroCustoAno] INT         IDENTITY (1, 1) NOT NULL,
    [Exercicio]               VARCHAR (4) NULL,
    [IdCentroCusto]           INT         NOT NULL,
    [IdUnidade]               INT         NOT NULL,
    [IdSubArea]               INT         NULL,
    CONSTRAINT [PK_UnidadesCentroCustosAno] PRIMARY KEY CLUSTERED ([IdUnidadeCentroCustoAno] ASC),
    CONSTRAINT [FK_UnidadesCentroCustosAno_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_UnidadesCentroCustosAno_SubAreas] FOREIGN KEY ([IdSubArea]) REFERENCES [dbo].[SubAreas] ([IdSubArea]),
    CONSTRAINT [FK_UnidadesCentroCustosAno_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);

