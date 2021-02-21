CREATE TABLE [dbo].[UploadImagensPreCadastro] (
    [IdUploadImagensPreCadastro] INT            IDENTITY (1, 1) NOT NULL,
    [TipoImagem]                 VARCHAR (100)  NULL,
    [Upload]                     BIT            CONSTRAINT [DEF_UploadImagensPreCadastro_Upload] DEFAULT ((0)) NOT NULL,
    [Obrigatorio]                BIT            CONSTRAINT [DEF_UploadImagensPreCadastro_Obrigatorio] DEFAULT ((0)) NOT NULL,
    [DocumentoSisdoc]            BIT            CONSTRAINT [DEF_UploadImagensPreCadastro_DocumentoSisdoc] DEFAULT ((1)) NOT NULL,
    [Descricao]                  VARCHAR (8000) NULL,
    CONSTRAINT [PK_UploadImagensPreCadastro] PRIMARY KEY CLUSTERED ([IdUploadImagensPreCadastro] ASC)
);

