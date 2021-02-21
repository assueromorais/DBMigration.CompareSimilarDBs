CREATE TABLE [dbo].[Pesquisas] (
    [IdPesquisa]             INT           IDENTITY (1, 1) NOT NULL,
    [NomePesquisa]           VARCHAR (100) NOT NULL,
    [DataInicialPesquisa]    DATETIME      NULL,
    [DataFinalPesquisa]      DATETIME      NULL,
    [Objetivo]               TEXT          NULL,
    [Observacao]             TEXT          NULL,
    [Responsavel]            VARCHAR (40)  NULL,
    [PublicoAlvo]            CHAR (1)      NULL,
    [Senha]                  VARCHAR (6)   NULL,
    [Desativada]             BIT           NULL,
    [Bloqueada]              BIT           NULL,
    [PermiteResponderNVezes] BIT           CONSTRAINT [DF_Pesquisas_PermiteResponderNVezes] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Pesquisas] PRIMARY KEY CLUSTERED ([IdPesquisa] ASC)
);

