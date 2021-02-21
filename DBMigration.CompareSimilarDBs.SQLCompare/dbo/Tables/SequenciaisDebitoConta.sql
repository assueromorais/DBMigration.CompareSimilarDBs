CREATE TABLE [dbo].[SequenciaisDebitoConta] (
    [IdSequencialDebitoConta]      INT IDENTITY (1, 1) NOT NULL,
    [IdContaCorrente]              INT NOT NULL,
    [SequencialRemessaDebitoConta] INT CONSTRAINT [DF_SequenciaisDebitoConta_SequencialRemessaDebitoConta] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_SequenciaisDebitoConta] PRIMARY KEY CLUSTERED ([IdSequencialDebitoConta] ASC),
    CONSTRAINT [FK_SequenciaisDebitoConta_ContasCorrentes] FOREIGN KEY ([IdContaCorrente]) REFERENCES [dbo].[ContasCorrentes] ([IdContaCorrente])
);

