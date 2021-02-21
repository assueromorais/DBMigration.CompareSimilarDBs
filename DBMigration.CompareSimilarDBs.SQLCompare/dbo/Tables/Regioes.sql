CREATE TABLE [dbo].[Regioes] (
    [IdRegiao]  INT          IDENTITY (1, 1) NOT NULL,
    [Descricao] VARCHAR (40) NOT NULL,
    CONSTRAINT [PK_Regioes] PRIMARY KEY CLUSTERED ([IdRegiao] ASC)
);

