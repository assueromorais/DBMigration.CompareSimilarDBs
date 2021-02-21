CREATE TABLE [dbo].[ValoresTributos] (
    [IdTributo]    INT      NOT NULL,
    [Data]         DATETIME NOT NULL,
    [Valor]        MONEY    NOT NULL,
    [ValorBase]    MONEY    NOT NULL,
    [ValorDeducao] MONEY    NOT NULL,
    CONSTRAINT [PK_ValoresTributos] PRIMARY KEY CLUSTERED ([IdTributo] ASC, [Data] ASC, [ValorBase] ASC)
);

