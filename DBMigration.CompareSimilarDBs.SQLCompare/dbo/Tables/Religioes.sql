CREATE TABLE [dbo].[Religioes] (
    [idReligiao]     INT          IDENTITY (1, 1) NOT NULL,
    [Religiao]       VARCHAR (40) NOT NULL,
    [IndCricacaoWeb] BIT          CONSTRAINT [DF_ReligioesIndCricacaoWeb] DEFAULT ((0)) NULL,
    [IndCriacaoWeb]  BIT          CONSTRAINT [DF_ReligioesIndCriacaoWeb] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Religioes] PRIMARY KEY CLUSTERED ([idReligiao] ASC)
);

