CREATE TABLE [dbo].[RecRealizDebitos] (
    [IdRecRealizDebito]  INT IDENTITY (1, 1) NOT NULL,
    [IdReceitaARealizar] INT NULL,
    [IdComposicaoDebito] INT NULL,
    [IdDebito]           INT NULL,
    CONSTRAINT [PK_RecRealizDebitos] PRIMARY KEY CLUSTERED ([IdRecRealizDebito] ASC),
    CONSTRAINT [FK_RecRealizDebitos_ComposicoesDebito] FOREIGN KEY ([IdComposicaoDebito]) REFERENCES [dbo].[ComposicoesDebito] ([IdComposicaoDebito]),
    CONSTRAINT [FK_RecRealizDebitos_Debitos] FOREIGN KEY ([IdDebito]) REFERENCES [dbo].[Debitos] ([IdDebito]),
    CONSTRAINT [FK_RecRealizDebitos_ReceitasARealizar] FOREIGN KEY ([IdReceitaARealizar]) REFERENCES [dbo].[ReceitasARealizar] ([IdReceitaARealizar])
);

