CREATE TABLE [dbo].[ProcessosSelos] (
    [IdProcessoSelo] INT           IDENTITY (1, 1) NOT NULL,
    [Tipo]           INT           NULL,
    [EnderecoSite]   VARCHAR (250) NULL,
    [Plenaria]       VARCHAR (100) NULL,
    [DataPlenaria]   DATETIME      NULL,
    [Validade]       DATETIME      NULL,
    [IdProcesso]     INT           NOT NULL,
    CONSTRAINT [PK_ProcessosSelos_IdProcessoSelo] PRIMARY KEY CLUSTERED ([IdProcessoSelo] ASC),
    CONSTRAINT [FK_ProcessosSelos_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso])
);

