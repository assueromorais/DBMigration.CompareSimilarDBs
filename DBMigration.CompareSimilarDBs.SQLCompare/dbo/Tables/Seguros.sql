CREATE TABLE [dbo].[Seguros] (
    [IdSeguro]          INT          IDENTITY (1, 1) NOT NULL,
    [IdItem]            INT          NOT NULL,
    [TipoBem]           VARCHAR (1)  NOT NULL,
    [IdTipoSeguro]      INT          NOT NULL,
    [IdPessoa]          INT          NOT NULL,
    [Apolice]           VARCHAR (20) NOT NULL,
    [ValorSeguro]       MONEY        NOT NULL,
    [Premio]            MONEY        NOT NULL,
    [DataInicialSeguro] DATETIME     NOT NULL,
    [DataFinalSeguro]   DATETIME     NOT NULL,
    [Detalhes]          TEXT         NULL,
    CONSTRAINT [PK_Seguros] PRIMARY KEY NONCLUSTERED ([IdSeguro] ASC),
    CONSTRAINT [FK_Seguros_ItensImoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensImoveis] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Seguros_ItensMoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensMoveis] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Seguros_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Seguros_TiposSeguros] FOREIGN KEY ([IdTipoSeguro]) REFERENCES [dbo].[TiposSeguros] ([IdTipoSeguro]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Seguros] NOCHECK CONSTRAINT [FK_Seguros_ItensImoveis];


GO
ALTER TABLE [dbo].[Seguros] NOCHECK CONSTRAINT [FK_Seguros_ItensMoveis];

