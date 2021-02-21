CREATE TABLE [dbo].[RamosAtividadeContas] (
    [IdRamoAtividade] INT         NOT NULL,
    [IdConta]         INT         NOT NULL,
    [Exercicio]       VARCHAR (4) NULL,
    CONSTRAINT [PK_RamosAtividadeContas] PRIMARY KEY CLUSTERED ([IdRamoAtividade] ASC, [IdConta] ASC),
    CONSTRAINT [FK_RamosAtividadeContas_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_RamosAtividadeContas_RamosAtividade] FOREIGN KEY ([IdRamoAtividade]) REFERENCES [dbo].[RamosAtividade] ([IdRamoAtividade])
);

