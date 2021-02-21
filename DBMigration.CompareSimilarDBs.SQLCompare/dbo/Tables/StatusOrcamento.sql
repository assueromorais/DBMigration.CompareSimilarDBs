CREATE TABLE [dbo].[StatusOrcamento] (
    [Identificador]        INT      IDENTITY (1, 1) NOT NULL,
    [IdCentroCusto]        INT      NOT NULL,
    [Ano]                  INT      NOT NULL,
    [Status]               CHAR (1) NOT NULL,
    [IdUsuarioFinalizacao] INT      NOT NULL,
    [DataFinalizacao]      DATETIME NULL,
    CONSTRAINT [PK_StatusOrcamento] PRIMARY KEY CLUSTERED ([Identificador] ASC)
);

