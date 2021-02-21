CREATE TABLE [dbo].[TipoPenalizacao] (
    [IdTipoPenalizacao] INT          IDENTITY (1, 1) NOT NULL,
    [TipoPenalizacao]   VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_TipoPenalizacao] PRIMARY KEY CLUSTERED ([IdTipoPenalizacao] ASC)
);

