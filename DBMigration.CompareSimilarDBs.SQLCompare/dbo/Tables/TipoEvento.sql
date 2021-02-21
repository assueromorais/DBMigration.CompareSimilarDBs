CREATE TABLE [dbo].[TipoEvento] (
    [IdTipoEvento] INT           IDENTITY (1, 1) NOT NULL,
    [TipoEvento]   NVARCHAR (50) NULL,
    [LimiteFaltas] INT           NULL,
    CONSTRAINT [PK_TipoEvento] PRIMARY KEY CLUSTERED ([IdTipoEvento] ASC)
);

