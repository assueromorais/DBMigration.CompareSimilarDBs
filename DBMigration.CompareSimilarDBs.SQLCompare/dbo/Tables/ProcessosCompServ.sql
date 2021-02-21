CREATE TABLE [dbo].[ProcessosCompServ] (
    [IdProcesso]             INT           IDENTITY (1, 1) NOT NULL,
    [IdContrato]             INT           NULL,
    [IdLicitacao]            INT           NULL,
    [NumeroProcesso]         VARCHAR (20)  NOT NULL,
    [DataInicio]             DATETIME      NOT NULL,
    [Descricao]              TEXT          NOT NULL,
    [AutorizadoContrato]     BIT           NULL,
    [AutorizadoLicitacao]    BIT           NULL,
    [Situacao]               INT           NOT NULL,
    [DataCancelamento]       DATETIME      NULL,
    [Justificativa]          TEXT          NULL,
    [Observacao]             TEXT          NULL,
    [NumeroProtocolo]        VARCHAR (20)  NULL,
    [IdModalidadeCompra]     INT           NULL,
    [IdResponsavelComprador] INT           NULL,
    [NumeroAutorizacao]      NVARCHAR (20) NULL,
    CONSTRAINT [PK_ProcessosCompServ] PRIMARY KEY CLUSTERED ([IdProcesso] ASC),
    CONSTRAINT [FK_ProcessosCompServ_Contratos] FOREIGN KEY ([IdContrato]) REFERENCES [dbo].[Contratos] ([IdContrato]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ProcessosCompServ_Licitacoes] FOREIGN KEY ([IdLicitacao]) REFERENCES [dbo].[Licitacoes] ([IdLicitacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ProcessosCompServ_ModalidadesCompra] FOREIGN KEY ([IdModalidadeCompra]) REFERENCES [dbo].[ModalidadesCompra] ([IdModalidadeCompra]),
    CONSTRAINT [FK_ProcessosCompServ_Responsaveis] FOREIGN KEY ([IdResponsavelComprador]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel])
);


GO
ALTER TABLE [dbo].[ProcessosCompServ] NOCHECK CONSTRAINT [FK_ProcessosCompServ_Contratos];


GO
ALTER TABLE [dbo].[ProcessosCompServ] NOCHECK CONSTRAINT [FK_ProcessosCompServ_Licitacoes];

