﻿CREATE TABLE [dbo].[ParametrosSisdocUsuario] (
    [IdParametroSisdocUsuario] INT           IDENTITY (1, 1) NOT NULL,
    [IdUsuario]                INT           NULL,
    [IdTipoDocPadrao]          INT           NULL,
    [IdSituacaoPadrao]         INT           NULL,
    [IndOrigemPadrao]          CHAR (3)      NULL,
    [IdTipoDocFiltro]          INT           NULL,
    [IdSituacaoFiltro]         INT           NULL,
    [IndOrigemFiltro]          CHAR (3)      NULL,
    [IndDataFiltro]            INT           NULL,
    [DataFiltroDe]             DATETIME      NULL,
    [DataFiltroAte]            DATETIME      NULL,
    [IndDataSaidaFiltro]       INT           NULL,
    [DataSaidaFiltroDe]        DATETIME      NULL,
    [DataSaidaFiltroAte]       DATETIME      NULL,
    [OrdemNavegacao]           VARCHAR (80)  NULL,
    [OrdemAbas]                VARCHAR (80)  NULL,
    [CaminhoEletronicoPadrao]  VARCHAR (100) NULL,
    [IdDepartamentoPadrao]     INT           NULL,
    [PrioridadePadrao]         INT           NULL,
    [SituacaoPadrao]           INT           NULL,
    [IdSituacaoPadraoPesquisa] INT           NULL,
    [IdTipoDocPadraoPesquisa]  INT           NULL,
    [IndOrigemPadraoPesquisa]  CHAR (3)      NULL,
    CONSTRAINT [PK_ParametrosSisdocUsuario] PRIMARY KEY CLUSTERED ([IdParametroSisdocUsuario] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_ParametrosSisdocUsuario_SituacoesDocumento_Filtro] FOREIGN KEY ([IdSituacaoFiltro]) REFERENCES [dbo].[SituacoesDocumento] ([IdSituacaoDocumento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ParametrosSisdocUsuario_SituacoesDocumento_Padrao] FOREIGN KEY ([IdSituacaoPadrao]) REFERENCES [dbo].[SituacoesDocumento] ([IdSituacaoDocumento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ParametrosSisdocUsuario_TiposDocumentos_Filtro] FOREIGN KEY ([IdTipoDocFiltro]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ParametrosSisdocUsuario_TiposDocumentos_Padrao] FOREIGN KEY ([IdTipoDocPadrao]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ParametrosSisDocUsuario_Unidades] FOREIGN KEY ([IdDepartamentoPadrao]) REFERENCES [dbo].[Departamentos] ([IdDepto])
);
