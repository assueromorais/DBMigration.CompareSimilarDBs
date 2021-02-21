CREATE TABLE [dbo].[TiposIdentidadePFPJ] (
    [IdTipoIdentidadePFPJ] INT           IDENTITY (1, 1) NOT NULL,
    [Titulo]               VARCHAR (100) NULL,
    [TipoPessoa]           CHAR (1)      NULL,
    [FrenteVerso]          BIT           CONSTRAINT [DEF_TiposIdentidadePFPJ_PossuiVerso] DEFAULT ((0)) NULL,
    [ModeloFrente]         IMAGE         NULL,
    [ModeloVerso]          IMAGE         NULL,
    [SelectSQL]            TEXT          NULL,
    CONSTRAINT [PK_TiposIdentidadePFPJ] PRIMARY KEY CLUSTERED ([IdTipoIdentidadePFPJ] ASC)
);

