CREATE TABLE [dbo].[TiposInscricao] (
    [IdTipoInscricao]       INT          IDENTITY (1, 1) NOT NULL,
    [TipoInscricao]         VARCHAR (20) NOT NULL,
    [SiglaTipoInscricao]    VARCHAR (5)  NULL,
    [IndicativoPagamento]   BIT          NOT NULL,
    [PercentualDesconto]    FLOAT (53)   NULL,
    [Sincroniza]            BIT          CONSTRAINT [DF__TiposInsc__Sincr__5EAAD05B] DEFAULT ((0)) NULL,
    [Desativado]            BIT          CONSTRAINT [DF_TiposInscricaoDesativado] DEFAULT ((0)) NULL,
    [TipoInscricaoPF]       BIT          DEFAULT ((0)) NOT NULL,
    [IdSerasaTipo]          INT          NULL,
    [UnidadeValidade]       VARCHAR (1)  NULL,
    [ValidadeSituacao]      FLOAT (53)   NULL,
    [NExibirPreCadastroWeb] BIT          NULL,
    CONSTRAINT [PK_TiposInscricao] PRIMARY KEY CLUSTERED ([IdTipoInscricao] ASC),
    CONSTRAINT [FK_TiposInscricao_IdSerasaTipo] FOREIGN KEY ([IdSerasaTipo]) REFERENCES [dbo].[SerasaTiposInscricao] ([IdSerasaTipo])
);

