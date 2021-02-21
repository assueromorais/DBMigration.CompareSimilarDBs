CREATE TABLE [dbo].[RegioesAdministrativas] (
    [IdRegiaoAdministrativa] INT           IDENTITY (1, 1) NOT NULL,
    [RegiaoAdministrativa]   VARCHAR (100) NOT NULL,
    [IdPessoaDelegacia]      INT           NULL,
    [Desativado]             BIT           CONSTRAINT [DEF_TipoProcessoDesativado] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_RegioesAdministrativas] PRIMARY KEY CLUSTERED ([IdRegiaoAdministrativa] ASC),
    CONSTRAINT [FK_IdRegiaoAdministrativa_Pessoas] FOREIGN KEY ([IdPessoaDelegacia]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);

