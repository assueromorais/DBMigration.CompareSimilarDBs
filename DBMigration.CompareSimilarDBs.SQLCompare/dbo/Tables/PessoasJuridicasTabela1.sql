CREATE TABLE [dbo].[PessoasJuridicasTabela1] (
    [idTabela1PJ] INT          IDENTITY (1, 1) NOT NULL,
    [Descricao]   VARCHAR (40) NULL,
    CONSTRAINT [PK_PessoasJuridicasTabela1] PRIMARY KEY CLUSTERED ([idTabela1PJ] ASC)
);

