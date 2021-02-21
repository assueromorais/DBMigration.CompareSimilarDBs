CREATE TABLE [dbo].[PlanoContasAssociativa] (
    [IdPlanoContasAssociativo] INT          IDENTITY (1, 1) NOT NULL,
    [CodSIC]                   VARCHAR (2)  NULL,
    [UF]                       CHAR (2)     NULL,
    [CodConta]                 VARCHAR (18) NULL,
    [NomeConta]                VARCHAR (50) NULL,
    [IdConta]                  INT          NULL,
    CONSTRAINT [PK_PlanoContasAssociativa] PRIMARY KEY CLUSTERED ([IdPlanoContasAssociativo] ASC),
    CONSTRAINT [FK_PlanoContasAssociativa_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);

