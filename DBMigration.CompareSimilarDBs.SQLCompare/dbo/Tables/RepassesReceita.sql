CREATE TABLE [dbo].[RepassesReceita] (
    [IdRepasseReceita]     INT           IDENTITY (1, 1) NOT NULL,
    [IdReceita]            INT           NOT NULL,
    [IdRepasseConta]       INT           NULL,
    [IdRepasse]            INT           NOT NULL,
    [IdContaRepasse]       INT           NOT NULL,
    [IdPagamento]          INT           NULL,
    [ValorRepasse]         MONEY         NOT NULL,
    [E_Percentual]         BIT           NULL,
    [HistoricoRepasse]     TEXT          NULL,
    [AplicadoSobreRepasse] VARCHAR (100) NULL,
    [ValorPercRepasse]     MONEY         NULL,
    [ValorBaseRepasse]     MONEY         NOT NULL,
    [RegistraLog]          BIT           DEFAULT ('1') NULL,
    CONSTRAINT [PK_RepassesReceita_1] PRIMARY KEY CLUSTERED ([IdRepasseReceita] ASC),
    CONSTRAINT [FK_RepassesReceita_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_RepassesReceita_PlanoContas] FOREIGN KEY ([IdContaRepasse]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_RepassesReceita_Receitas] FOREIGN KEY ([IdReceita]) REFERENCES [dbo].[Receitas] ([IdReceita]),
    CONSTRAINT [FK_RepassesReceita_Repasses] FOREIGN KEY ([IdRepasse]) REFERENCES [dbo].[Repasses] ([IdRepasse]),
    CONSTRAINT [FK_RepassesReceita_RepassesContas] FOREIGN KEY ([IdRepasseConta]) REFERENCES [dbo].[RepassesContas] ([IdRepasseConta])
);


GO
ALTER TABLE [dbo].[RepassesReceita] NOCHECK CONSTRAINT [FK_RepassesReceita_Pagamentos];


GO
CREATE NONCLUSTERED INDEX [IX_RepassesReceita_IdContaRepasse]
    ON [dbo].[RepassesReceita]([IdContaRepasse] ASC);


GO
CREATE STATISTICS [STAT_RepassesReceita_E_Percentual_IdContaRepasse]
    ON [dbo].[RepassesReceita]([E_Percentual], [IdContaRepasse]);

