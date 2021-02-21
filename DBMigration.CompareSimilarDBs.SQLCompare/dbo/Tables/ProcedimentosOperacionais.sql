CREATE TABLE [dbo].[ProcedimentosOperacionais] (
    [IdProcedimentoOperacional] INT          IDENTITY (1, 1) NOT NULL,
    [ProcedimentoOperacional]   VARCHAR (50) NULL,
    [TipoPessoa]                INT          NULL,
    [E_Automatico]              BIT          NULL,
    [IdEventoCobranca]          INT          NULL,
    [AmbienteExecucao]          CHAR (1)     CONSTRAINT [DF__Procedime__Ambie__1771AB91] DEFAULT ('D') NULL,
    [HabilitaReativacao]        BIT          CONSTRAINT [DF_ProcedimentosOperacionais_HabilitaReativacao] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ProcedimentosOperacionais] PRIMARY KEY CLUSTERED ([IdProcedimentoOperacional] ASC),
    CONSTRAINT [FK_ProcedimentosOperacionais_EventosCobranca] FOREIGN KEY ([IdEventoCobranca]) REFERENCES [dbo].[EventosCobranca] ([IdEventoCobranca])
);

