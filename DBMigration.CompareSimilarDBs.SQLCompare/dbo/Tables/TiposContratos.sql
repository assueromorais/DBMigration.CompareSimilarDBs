CREATE TABLE [dbo].[TiposContratos] (
    [IdTipoContrato]     INT          IDENTITY (1, 1) NOT NULL,
    [TipoContrato]       VARCHAR (30) NOT NULL,
    [PrefixoContrato]    VARCHAR (6)  NULL,
    [SufixoContrato]     VARCHAR (6)  NULL,
    [IncrementoContrato] INT          NULL,
    CONSTRAINT [PK_TiposContratos] PRIMARY KEY CLUSTERED ([IdTipoContrato] ASC)
);

