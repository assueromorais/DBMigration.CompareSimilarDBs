CREATE TABLE [dbo].[TiposDigitalizacao] (
    [IdTipoDigitalizao]     INT          IDENTITY (1, 1) NOT NULL,
    [IdModuloDigitalizacao] INT          NOT NULL,
    [Descricao]             VARCHAR (60) NOT NULL,
    [Largura]               INT          NOT NULL,
    [Altura]                INT          NOT NULL,
    [Funcao]                VARCHAR (60) NULL,
    [MultiplasPaginas]      BIT          CONSTRAINT [DF_TiposDigitalizacao_MultiplasPaginas] DEFAULT ((0)) NULL,
    [Desabilitado]          BIT          CONSTRAINT [DF_TiposDigitalizacao_Desabilitado] DEFAULT ((0)) NULL,
    [Exclusivo]             INT          NULL,
    [ExibeImagens]          BIT          CONSTRAINT [DF_TiposDigitalizacao_ExibeImagens] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_TiposDigitalizacao] PRIMARY KEY CLUSTERED ([IdTipoDigitalizao] ASC),
    CONSTRAINT [FK_TiposDigitalizacao_ModulosDigitalizacao] FOREIGN KEY ([IdModuloDigitalizacao]) REFERENCES [dbo].[ModulosDigitalizacao] ([IdModuloDigitalizacao])
);

