CREATE TABLE [dbo].[SolicitacaoCarteira] (
    [IdSolicitacaoCarteira] INT      IDENTITY (1, 1) NOT NULL,
    [DataSolicitacao]       DATETIME NOT NULL,
    CONSTRAINT [PK_SolicitacaoCarteira] PRIMARY KEY CLUSTERED ([IdSolicitacaoCarteira] ASC)
);

