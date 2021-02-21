CREATE TABLE [dbo].[ProcedimentosColetivos] (
    [IdProcedimentoColetivo] INT          IDENTITY (1, 1) NOT NULL,
    [ProcedimentoColetivo]   VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_ProcedimentosColetivos] PRIMARY KEY CLUSTERED ([IdProcedimentoColetivo] ASC)
);

