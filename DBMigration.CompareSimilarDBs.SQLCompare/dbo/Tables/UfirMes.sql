CREATE TABLE [dbo].[UfirMes] (
    [Ano]   VARCHAR (4) NOT NULL,
    [Mes]   VARCHAR (2) NOT NULL,
    [Valor] MONEY       NULL,
    CONSTRAINT [PK_UfirMes] PRIMARY KEY CLUSTERED ([Ano] ASC, [Mes] ASC)
);

