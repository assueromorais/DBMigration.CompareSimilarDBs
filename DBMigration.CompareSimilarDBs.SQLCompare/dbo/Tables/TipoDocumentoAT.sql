CREATE TABLE [dbo].[TipoDocumentoAT] (
    [IdTipoDocumentoAT] INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]         VARCHAR (250) NULL,
    [Desativado]        BIT           CONSTRAINT [DEF_TipoDocumentoAT_Desativado] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_TipoDocumentoAT] PRIMARY KEY CLUSTERED ([IdTipoDocumentoAT] ASC)
);

