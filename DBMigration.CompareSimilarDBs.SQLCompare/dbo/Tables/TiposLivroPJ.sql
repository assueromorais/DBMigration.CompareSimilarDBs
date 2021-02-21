CREATE TABLE [dbo].[TiposLivroPJ] (
    [IdTipoLivroPJ] INT          IDENTITY (1, 1) NOT NULL,
    [TipoLivroPJ]   VARCHAR (50) NOT NULL,
    [Desativado]    BIT          CONSTRAINT [DF_TiposLivroPJDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TiposLivroPJ] PRIMARY KEY CLUSTERED ([IdTipoLivroPJ] ASC)
);

