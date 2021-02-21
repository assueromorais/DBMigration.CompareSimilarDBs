CREATE TABLE [dbo].[PontosTecnicos] (
    [IdPontoTecnico] INT IDENTITY (1, 1) NOT NULL,
    [IdLicitacao]    INT NOT NULL,
    CONSTRAINT [PK_PontosTecnicos] PRIMARY KEY CLUSTERED ([IdPontoTecnico] ASC),
    CONSTRAINT [FK_PontoTecnico_Licitacoes] FOREIGN KEY ([IdLicitacao]) REFERENCES [dbo].[Licitacoes] ([IdLicitacao]) NOT FOR REPLICATION
);

