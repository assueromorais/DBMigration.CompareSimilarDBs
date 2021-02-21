CREATE TABLE [dbo].[TiposLicitacoes] (
    [IdTipoLicitacao] INT          IDENTITY (1, 1) NOT NULL,
    [TipoLicitacao]   VARCHAR (30) NOT NULL,
    [IdModalidade]    INT          NOT NULL,
    [PrazoTotal]      INT          NOT NULL,
    CONSTRAINT [PK_TiposLicitacoes] PRIMARY KEY CLUSTERED ([IdTipoLicitacao] ASC),
    CONSTRAINT [FK_TiposLicitacoes_Modalidades] FOREIGN KEY ([IdModalidade]) REFERENCES [dbo].[Modalidades] ([IdModalidade]) NOT FOR REPLICATION
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TiposLicitacoesTipoLicitacao]
    ON [dbo].[TiposLicitacoes]([TipoLicitacao] ASC);

