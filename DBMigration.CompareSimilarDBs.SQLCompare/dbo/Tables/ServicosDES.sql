CREATE TABLE [dbo].[ServicosDES] (
    [IdServico]  INT           IDENTITY (1, 1) NOT NULL,
    [CodServico] VARCHAR (5)   NULL,
    [Servico]    VARCHAR (250) NULL,
    CONSTRAINT [PK_ServicosDES] PRIMARY KEY CLUSTERED ([IdServico] ASC)
);

