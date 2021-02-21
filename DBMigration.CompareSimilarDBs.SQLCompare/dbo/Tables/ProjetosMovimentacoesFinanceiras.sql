CREATE TABLE [dbo].[ProjetosMovimentacoesFinanceiras] (
    [IdProjetoMovimentacaoFinanceira] INT           IDENTITY (1, 1) NOT NULL,
    [Nome]                            VARCHAR (100) NULL,
    [Descricao]                       TEXT          NULL,
    [Convenio]                        VARCHAR (20)  NULL,
    [Data]                            DATETIME      NULL,
    CONSTRAINT [PK_ProjetoMovimentacaoFinanceira] PRIMARY KEY CLUSTERED ([IdProjetoMovimentacaoFinanceira] ASC)
);

