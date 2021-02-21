CREATE TABLE [dbo].[Profissoes] (
    [IdProfissao] INT           IDENTITY (1, 1) NOT NULL,
    [Profissao]   VARCHAR (100) NOT NULL,
    [Desativado]  BIT           CONSTRAINT [DEF_ProfissoesDesativado] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Profissao] PRIMARY KEY CLUSTERED ([IdProfissao] ASC)
);

