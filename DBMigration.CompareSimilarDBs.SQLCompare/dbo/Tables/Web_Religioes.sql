CREATE TABLE [dbo].[Web_Religioes] (
    [IdWeb_Religiao]  INT          IDENTITY (1, 1) NOT NULL,
    [IdReligiao]      INT          NOT NULL,
    [Religiao]        VARCHAR (40) NULL,
    [IndCriacaoWeb]   BIT          CONSTRAINT [DF_ReligioesIndCriacaoWeb_WEB] DEFAULT ((0)) NULL,
    [DataBaixa]       DATETIME     NULL,
    [DataAtualizacao] DATETIME     NULL,
    [E_Impedido]      BIT          NULL,
    [IndCricacaoWeb]  BIT          CONSTRAINT [DF_ReligioesIndCricacaoWeb_WEB] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Web_Religioes] PRIMARY KEY CLUSTERED ([IdWeb_Religiao] ASC)
);

