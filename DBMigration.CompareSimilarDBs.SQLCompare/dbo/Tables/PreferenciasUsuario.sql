CREATE TABLE [dbo].[PreferenciasUsuario] (
    [IdPreferenciaUsuario] INT           IDENTITY (1, 1) NOT NULL,
    [Campo]                VARCHAR (250) NULL,
    [Valor]                VARCHAR (250) NULL,
    [IdUsuario]            INT           NULL,
    CONSTRAINT [PK_PreferenciasUsuario] PRIMARY KEY CLUSTERED ([IdPreferenciaUsuario] ASC),
    CONSTRAINT [FK_PreferenciasUsuario_Usuario] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);

