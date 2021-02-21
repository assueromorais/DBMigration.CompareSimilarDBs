CREATE TABLE [dbo].[Propostas] (
    [IdProposta]       INT   IDENTITY (1, 1) NOT NULL,
    [IdPessoa]         INT   NOT NULL,
    [Valor]            MONEY NULL,
    [PontoTecnico]     INT   NULL,
    [IdListaLicitacao] INT   NOT NULL,
    CONSTRAINT [PK_Propostas] PRIMARY KEY CLUSTERED ([IdProposta] ASC),
    CONSTRAINT [FK_Propostas_ListaLicitacoes] FOREIGN KEY ([IdListaLicitacao]) REFERENCES [dbo].[ListaLicitacoes] ([IdListaLicitacao]),
    CONSTRAINT [FK_Propostas_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION
);

