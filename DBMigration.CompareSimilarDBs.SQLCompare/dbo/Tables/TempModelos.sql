CREATE TABLE [dbo].[TempModelos] (
    [IdTempModelo] INT   IDENTITY (1, 1) NOT NULL,
    [Modelo]       IMAGE NULL,
    CONSTRAINT [PK_TempModelos] PRIMARY KEY CLUSTERED ([IdTempModelo] ASC)
);

