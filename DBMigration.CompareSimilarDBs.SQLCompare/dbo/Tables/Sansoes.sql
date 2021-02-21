CREATE TABLE [dbo].[Sansoes] (
    [IdSansao]   INT           IDENTITY (1, 1) NOT NULL,
    [Sansao]     VARCHAR (500) NULL,
    [Desativado] BIT           CONSTRAINT [DF_SansoesDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Sansao] PRIMARY KEY CLUSTERED ([IdSansao] ASC)
);

