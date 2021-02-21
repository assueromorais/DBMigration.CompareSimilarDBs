CREATE TABLE [dbo].[Processo_Debitos] (
    [IdProcesso] INT NOT NULL,
    [IdDebito]   INT NOT NULL,
    CONSTRAINT [PK_Processo_Debitos] PRIMARY KEY CLUSTERED ([IdProcesso] ASC, [IdDebito] ASC),
    CONSTRAINT [FK_Processo_Debitos_Debitos] FOREIGN KEY ([IdDebito]) REFERENCES [dbo].[Debitos] ([IdDebito]),
    CONSTRAINT [FK_Processo_Debitos_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso])
);


GO
ALTER TABLE [dbo].[Processo_Debitos] NOCHECK CONSTRAINT [FK_Processo_Debitos_Debitos];


GO
ALTER TABLE [dbo].[Processo_Debitos] NOCHECK CONSTRAINT [FK_Processo_Debitos_Processos];

