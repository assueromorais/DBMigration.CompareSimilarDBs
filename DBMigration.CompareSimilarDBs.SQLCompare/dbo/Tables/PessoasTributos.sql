CREATE TABLE [dbo].[PessoasTributos] (
    [IdPessoa]        INT         NOT NULL,
    [IdRamoAtividade] INT         NOT NULL,
    [IdConta]         INT         NOT NULL,
    [IdTributo]       INT         NOT NULL,
    [Exercicio]       VARCHAR (4) NULL,
    [IdPessoaTributo] INT         IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_PessoasTributos] PRIMARY KEY CLUSTERED ([IdPessoaTributo] ASC),
    CONSTRAINT [FK_PessoasTributos_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);

