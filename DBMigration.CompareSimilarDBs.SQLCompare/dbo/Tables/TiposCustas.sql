CREATE TABLE [dbo].[TiposCustas] (
    [IdTipoCusta] INT           IDENTITY (1, 1) NOT NULL,
    [TipoCusta]   VARCHAR (100) NOT NULL,
    [Desativado]  BIT           CONSTRAINT [DF_TiposCustas_Desativado] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_TiposCustas] PRIMARY KEY CLUSTERED ([IdTipoCusta] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TiposCustas]
    ON [dbo].[TiposCustas]([TipoCusta] ASC);

