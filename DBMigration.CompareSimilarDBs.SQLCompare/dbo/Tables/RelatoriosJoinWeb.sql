CREATE TABLE [dbo].[RelatoriosJoinWeb] (
    [IdJoin]    INT            IDENTITY (1, 1) NOT NULL,
    [IdSistema] INT            NOT NULL,
    [Codigo]    NVARCHAR (5)   NULL,
    [Descricao] NVARCHAR (500) NULL,
    CONSTRAINT [PK_RelatoriosJoinWeb] PRIMARY KEY CLUSTERED ([IdJoin] ASC)
);

