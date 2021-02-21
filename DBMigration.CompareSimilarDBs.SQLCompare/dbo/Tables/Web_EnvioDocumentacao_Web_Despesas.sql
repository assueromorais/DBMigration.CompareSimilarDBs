CREATE TABLE [dbo].[Web_EnvioDocumentacao_Web_Despesas] (
    [IdEnvioDocumentacao] INT NOT NULL,
    [IdDespesaWeb]        INT NOT NULL,
    CONSTRAINT [PK_Web_EnvioDocumentacao_Web_Despesas] PRIMARY KEY CLUSTERED ([IdEnvioDocumentacao] ASC, [IdDespesaWeb] ASC)
);

