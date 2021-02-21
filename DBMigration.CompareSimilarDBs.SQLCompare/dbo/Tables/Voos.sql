CREATE TABLE [dbo].[Voos] (
    [IdVoo]             INT          IDENTITY (1, 1) NOT NULL,
    [IdPessoaCompanhia] INT          NULL,
    [NumVoo]            VARCHAR (10) NULL,
    [VooAtivo]          BIT          NULL,
    [SEG]               BIT          NULL,
    [TER]               BIT          NULL,
    [QUA]               BIT          NULL,
    [QUI]               BIT          NULL,
    [SEX]               BIT          NULL,
    [SAB]               BIT          NULL,
    [DOM]               BIT          NULL,
    CONSTRAINT [PK_Voos] PRIMARY KEY CLUSTERED ([IdVoo] ASC),
    CONSTRAINT [FK_Voos_Companhias] FOREIGN KEY ([IdPessoaCompanhia]) REFERENCES [dbo].[Companhias] ([IdPessoaCompanhia])
);

