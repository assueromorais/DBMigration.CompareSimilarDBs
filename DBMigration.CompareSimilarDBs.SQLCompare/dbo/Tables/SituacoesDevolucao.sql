CREATE TABLE [dbo].[SituacoesDevolucao] (
    [IdSituacaoDevolucao] INT           IDENTITY (1, 1) NOT NULL,
    [SituacaoDevolucao]   NVARCHAR (25) NULL,
    CONSTRAINT [PK_SituacaoDevolucao] PRIMARY KEY CLUSTERED ([IdSituacaoDevolucao] ASC)
);

