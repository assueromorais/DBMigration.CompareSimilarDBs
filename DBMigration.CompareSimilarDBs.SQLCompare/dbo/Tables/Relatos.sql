CREATE TABLE [dbo].[Relatos] (
    [IdRelato]   INT            IDENTITY (1, 1) NOT NULL,
    [Modelo]     VARCHAR (50)   NOT NULL,
    [Texto]      VARCHAR (4000) NOT NULL,
    [TipoModelo] CHAR (1)       NOT NULL,
    CONSTRAINT [PK_Relatos] PRIMARY KEY CLUSTERED ([IdRelato] ASC)
);

