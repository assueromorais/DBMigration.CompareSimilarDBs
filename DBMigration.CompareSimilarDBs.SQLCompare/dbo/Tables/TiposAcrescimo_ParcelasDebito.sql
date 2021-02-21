CREATE TABLE [dbo].[TiposAcrescimo_ParcelasDebito] (
    [IdTipoAcrescimo]       INT        NOT NULL,
    [IdConfigParcelaDebito] INT        NOT NULL,
    [ValorAcrescimo]        FLOAT (53) NOT NULL,
    [E_Percentual]          BIT        NULL,
    CONSTRAINT [PK_TiposAcrescimo_ParcelasDebito] PRIMARY KEY CLUSTERED ([IdTipoAcrescimo] ASC, [IdConfigParcelaDebito] ASC),
    CONSTRAINT [FK_TiposAcrescimo_ParcelasDebito_ConfigParcelasDebito] FOREIGN KEY ([IdConfigParcelaDebito]) REFERENCES [dbo].[ConfigParcelasDebito] ([IdConfigParcelaDebito]) NOT FOR REPLICATION,
    CONSTRAINT [FK_TiposAcrescimo_ParcelasDebito_TiposAcrescimo] FOREIGN KEY ([IdTipoAcrescimo]) REFERENCES [dbo].[TiposAcrescimo] ([IdTipoAcrescimo]) NOT FOR REPLICATION
);

