CREATE TABLE [dbo].[SetoresResponsabilidade] (
    [IdSetorResponsabilidade] INT          IDENTITY (1, 1) NOT NULL,
    [SetorResponsabilidade]   VARCHAR (40) NULL,
    CONSTRAINT [PK_Setoresesponsabilidade] PRIMARY KEY CLUSTERED ([IdSetorResponsabilidade] ASC)
);

