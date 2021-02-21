CREATE TABLE [dbo].[TiposPessoa_Pessoas] (
    [IdTipoPessoa] INT NOT NULL,
    [IdPessoa]     INT NOT NULL,
    CONSTRAINT [PK_TiposPessoa_Pessoas] PRIMARY KEY CLUSTERED ([IdTipoPessoa] ASC, [IdPessoa] ASC),
    CONSTRAINT [FK_TiposPessoa_Pessoas_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_TiposPessoa_Pessoas_TiposPessoa] FOREIGN KEY ([IdTipoPessoa]) REFERENCES [dbo].[TiposPessoa] ([IdTipoPessoa]) NOT FOR REPLICATION
);

