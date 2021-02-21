CREATE TABLE [dbo].[TipoRepresentacao] (
    [IdTipoRepresentacao] INT           IDENTITY (1, 1) NOT NULL,
    [TipoRepresentacao]   NVARCHAR (50) NULL,
    CONSTRAINT [PK_TipoRepresentacao] PRIMARY KEY CLUSTERED ([IdTipoRepresentacao] ASC)
);

