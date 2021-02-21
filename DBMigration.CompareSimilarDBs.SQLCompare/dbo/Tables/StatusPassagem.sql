CREATE TABLE [dbo].[StatusPassagem] (
    [IdStatusPassagem] INT           IDENTITY (1, 1) NOT NULL,
    [StatusPassagem]   NVARCHAR (50) NULL,
    CONSTRAINT [PK_StatusPassagem] PRIMARY KEY CLUSTERED ([IdStatusPassagem] ASC)
);

