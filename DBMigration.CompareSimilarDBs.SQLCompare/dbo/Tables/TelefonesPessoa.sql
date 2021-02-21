CREATE TABLE [dbo].[TelefonesPessoa] (
    [IdTelefonePessoa] INT           IDENTITY (1, 1) NOT NULL,
    [IdPessoa]         INT           NOT NULL,
    [DddTelefone]      NVARCHAR (3)  NULL,
    [NumeroTelefone]   NVARCHAR (14) NOT NULL,
    [Ramal]            NVARCHAR (4)  NULL,
    [Complemento]      NVARCHAR (30) NULL,
    [Tipo]             NCHAR (1)     NULL,
    CONSTRAINT [PK_TelefonesPessoa] PRIMARY KEY CLUSTERED ([IdTelefonePessoa] ASC),
    CONSTRAINT [FK_TelefonesPessoa_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);

