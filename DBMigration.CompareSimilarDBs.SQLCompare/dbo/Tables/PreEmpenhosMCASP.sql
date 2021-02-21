CREATE TABLE [dbo].[PreEmpenhosMCASP] (
    [IdPreEmpenhoMCASP] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [Numero]            INT              NOT NULL,
    [Valor]             NUMERIC (18, 2)  DEFAULT ((0)) NOT NULL,
    [Data]              DATETIME         NOT NULL,
    PRIMARY KEY CLUSTERED ([IdPreEmpenhoMCASP] ASC)
);

