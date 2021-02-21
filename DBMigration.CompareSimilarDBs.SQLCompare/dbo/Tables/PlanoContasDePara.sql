CREATE TABLE [dbo].[PlanoContasDePara] (
    [IdPlanoContasDepara] INT              IDENTITY (1, 1) NOT NULL,
    [IdConta]             INT              NOT NULL,
    [IdContaMCASP]        UNIQUEIDENTIFIER NULL,
    [NomeContaMCASP]      VARCHAR (50)     NULL,
    [CodContaMCASP]       VARCHAR (27)     NULL,
    CONSTRAINT [IX_PlanoContasDeParaIdContaIdContaMCASP] UNIQUE NONCLUSTERED ([IdConta] ASC, [IdContaMCASP] ASC)
);

