CREATE TABLE [dbo].[TiposNotificacao] (
    [idTipoNotificacao] INT          IDENTITY (1, 1) NOT NULL,
    [TipoNotificacao]   VARCHAR (40) NOT NULL,
    [Desativado]        BIT          CONSTRAINT [DF_TiposNotificacaoDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TipoNotificao] PRIMARY KEY CLUSTERED ([idTipoNotificacao] ASC)
);

