CREATE TABLE [dbo].[SubAreas] (
    [IdSubArea]     INT          IDENTITY (1, 1) NOT NULL,
    [IdCentroCusto] INT          NULL,
    [CodSubArea]    VARCHAR (15) NULL,
    [SubArea]       VARCHAR (60) NULL,
    CONSTRAINT [PK_DetalheCCusto] PRIMARY KEY CLUSTERED ([IdSubArea] ASC),
    CONSTRAINT [FK_SubAreas_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto])
);

