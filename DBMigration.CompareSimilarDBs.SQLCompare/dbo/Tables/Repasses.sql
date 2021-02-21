CREATE TABLE [dbo].[Repasses] (
    [IdRepasse]              INT          IDENTITY (1, 1) NOT NULL,
    [NomeRepasse]            VARCHAR (60) NOT NULL,
    [IdContaRepasse]         INT          NOT NULL,
    [IdContaProvisaoRepasse] INT          NULL,
    CONSTRAINT [PK_Repasses] PRIMARY KEY CLUSTERED ([IdRepasse] ASC),
    CONSTRAINT [FK_RepassesProvisaoRepasse_PlanoContas] FOREIGN KEY ([IdContaProvisaoRepasse]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);

