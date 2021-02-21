CREATE TABLE [dbo].[SituacoesTramitacao] (
    [IdSituacaoTramitacao] INT          IDENTITY (1, 1) NOT NULL,
    [SituacaoTramitacao]   VARCHAR (40) NOT NULL,
    [Desativado]           BIT          CONSTRAINT [DF_SituacoesTramitacaoDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SituacoesTramitacao] PRIMARY KEY CLUSTERED ([IdSituacaoTramitacao] ASC)
);

