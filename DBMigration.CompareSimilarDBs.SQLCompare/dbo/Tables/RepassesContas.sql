CREATE TABLE [dbo].[RepassesContas] (
    [IdRepasseConta]      INT           IDENTITY (1, 1) NOT NULL,
    [IdRepasse]           INT           NOT NULL,
    [IdConta]             INT           NOT NULL,
    [ValorPercRepasse]    MONEY         NOT NULL,
    [E_Percentual]        BIT           NULL,
    [HistoricoRepasse]    TEXT          NULL,
    [AplicarSobreRepasse] VARCHAR (100) NULL,
    [Desativado]          BIT           CONSTRAINT [DF_RepassesContas_Desativado] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_RepassesContas] PRIMARY KEY CLUSTERED ([IdRepasseConta] ASC),
    CONSTRAINT [FK_RepassesContas_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_RepassesContas_Repasses] FOREIGN KEY ([IdRepasse]) REFERENCES [dbo].[Repasses] ([IdRepasse])
);

