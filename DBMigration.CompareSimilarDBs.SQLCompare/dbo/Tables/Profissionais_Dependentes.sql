CREATE TABLE [dbo].[Profissionais_Dependentes] (
    [IdDependenteProfissional] INT   IDENTITY (1, 1) NOT NULL,
    [IdProfissionalDependente] INT   NULL,
    [IdProfissional]           INT   NULL,
    [IdPessoaDependente]       INT   NULL,
    [IdGrauDependente]         INT   NULL,
    [Valor]                    MONEY DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Profissionais_Dependentes] PRIMARY KEY CLUSTERED ([IdDependenteProfissional] ASC),
    CONSTRAINT [FK_Profissionais_Dependentes_Grau_Dependentes] FOREIGN KEY ([IdGrauDependente]) REFERENCES [dbo].[Grau_Dependentes] ([IdGrauDependente]),
    CONSTRAINT [FK_Profissionais_Dependentes_Pessoas] FOREIGN KEY ([IdPessoaDependente]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_Profissionais_Dependentes_Profissionais] FOREIGN KEY ([IdProfissionalDependente]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
ALTER TABLE [dbo].[Profissionais_Dependentes] NOCHECK CONSTRAINT [FK_Profissionais_Dependentes_Grau_Dependentes];


GO
ALTER TABLE [dbo].[Profissionais_Dependentes] NOCHECK CONSTRAINT [FK_Profissionais_Dependentes_Pessoas];


GO
ALTER TABLE [dbo].[Profissionais_Dependentes] NOCHECK CONSTRAINT [FK_Profissionais_Dependentes_Profissionais];

