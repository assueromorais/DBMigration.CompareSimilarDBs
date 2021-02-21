CREATE TABLE [dbo].[TiposDesconto_ParcelasDebito] (
    [IdTipoDesconto]        INT        NOT NULL,
    [IdConfigParcelaDebito] INT        NOT NULL,
    [ValorDesconto]         FLOAT (53) NOT NULL,
    [E_Percentual]          BIT        NULL,
    CONSTRAINT [PK_TiposDesconto_ParcelasDebito] PRIMARY KEY CLUSTERED ([IdTipoDesconto] ASC, [IdConfigParcelaDebito] ASC),
    CONSTRAINT [FK_TiposDesconto_ParcelasDebito_ConfigParcelasDebito] FOREIGN KEY ([IdConfigParcelaDebito]) REFERENCES [dbo].[ConfigParcelasDebito] ([IdConfigParcelaDebito]),
    CONSTRAINT [FK_TiposDesconto_ParcelasDebito_TiposDesconto] FOREIGN KEY ([IdTipoDesconto]) REFERENCES [dbo].[TiposDesconto] ([IdTipoDesconto])
);

