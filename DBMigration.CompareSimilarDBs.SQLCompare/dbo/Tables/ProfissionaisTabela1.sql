CREATE TABLE [dbo].[ProfissionaisTabela1] (
    [idTabela1Profission] INT          IDENTITY (1, 1) NOT NULL,
    [Descricao]           VARCHAR (40) NULL,
    CONSTRAINT [PK_ProfissionaisTabela1] PRIMARY KEY CLUSTERED ([idTabela1Profission] ASC)
);

