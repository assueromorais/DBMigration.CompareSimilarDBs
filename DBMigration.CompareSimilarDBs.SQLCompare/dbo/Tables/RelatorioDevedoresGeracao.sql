CREATE TABLE [dbo].[RelatorioDevedoresGeracao] (
    [IdRelatorio]       INT      NOT NULL,
    [DataGeracao]       DATETIME DEFAULT (getdate()) NOT NULL,
    [Status]            BIT      NOT NULL,
    [ContagemDevedores] INT      NULL,
    [ValorDevido]       MONEY    NULL,
    CONSTRAINT [PK_RelatorioDevedoresGeracao] PRIMARY KEY CLUSTERED ([IdRelatorio] ASC) WITH (FILLFACTOR = 80)
);

