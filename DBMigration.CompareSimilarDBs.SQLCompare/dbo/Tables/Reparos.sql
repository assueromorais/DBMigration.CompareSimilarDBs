CREATE TABLE [dbo].[Reparos] (
    [IdReparo]                INT         IDENTITY (1, 1) NOT NULL,
    [IdOrdem]                 INT         NULL,
    [IdItem]                  INT         NOT NULL,
    [TipoBem]                 VARCHAR (1) NOT NULL,
    [DataReparo]              DATETIME    NOT NULL,
    [DuracaoGarantia]         INT         NULL,
    [IdMedidaDuracaoGarantia] INT         NULL,
    [DataInicialServico]      DATETIME    NULL,
    [DataFinalServico]        DATETIME    NULL,
    [DiasInoperantes]         INT         NULL,
    [ValorTotal]              MONEY       NULL,
    [ValorUnitario]           MONEY       NULL,
    [Quilometragem]           INT         NULL,
    [DescricaoReparo]         TEXT        NULL,
    [ValorManutencao]         MONEY       NULL,
    CONSTRAINT [PK_Reparos] PRIMARY KEY CLUSTERED ([IdReparo] ASC),
    CONSTRAINT [FK_Reparos_ItensImoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensImoveis] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Reparos_ItensMoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensMoveis] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Reparos_MedidasGarantia] FOREIGN KEY ([IdMedidaDuracaoGarantia]) REFERENCES [dbo].[MedidasGarantia] ([IdMedidaDuracaoGarantia]),
    CONSTRAINT [FK_Reparos_Ordens] FOREIGN KEY ([IdOrdem]) REFERENCES [dbo].[Ordens] ([IdOrdem]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Reparos] NOCHECK CONSTRAINT [FK_Reparos_ItensImoveis];


GO
ALTER TABLE [dbo].[Reparos] NOCHECK CONSTRAINT [FK_Reparos_ItensMoveis];


GO
ALTER TABLE [dbo].[Reparos] NOCHECK CONSTRAINT [FK_Reparos_Ordens];

