CREATE TABLE [dbo].[ProcessosDevolucaoReceita] (
    [IdProcessoDevolucaoReceita] INT          IDENTITY (1, 1) NOT NULL,
    [NumeroProcesso]             VARCHAR (50) NULL,
    [DataProcesso]               DATETIME     NULL,
    CONSTRAINT [PK_ProcessosDevolucaoReceita] PRIMARY KEY CLUSTERED ([IdProcessoDevolucaoReceita] ASC)
);

