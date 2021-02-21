CREATE TABLE [dbo].[SetoresAtuacao] (
    [IdSetorAtuacao] INT          IDENTITY (1, 1) NOT NULL,
    [SetorAtuacao]   VARCHAR (50) NULL,
    [Desativado]     BIT          CONSTRAINT [DF_SetoresAtuacaoDesativado] DEFAULT ((0)) NULL,
    [TipoPessoa]     CHAR (1)     DEFAULT ('A') NOT NULL,
    CONSTRAINT [PK_SetoresAtuacao] PRIMARY KEY CLUSTERED ([IdSetorAtuacao] ASC)
);

