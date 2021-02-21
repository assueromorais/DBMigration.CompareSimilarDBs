CREATE TABLE [dbo].[WEB_Atividades] (
    [IdWeb_Atividade]  INT          IDENTITY (1, 1) NOT NULL,
    [IdAtividade]      INT          NOT NULL,
    [NomeAtividade]    VARCHAR (40) NOT NULL,
    [IdGrupoAtividade] INT          NULL,
    [Desativado]       BIT          CONSTRAINT [DF_WEB_AtividadesDesativado] DEFAULT ((0)) NULL,
    [DataBaixa]        DATETIME     NULL,
    [E_Impedido]       BIT          NULL,
    [IndCriacaoWeb]    BIT          CONSTRAINT [DF_AtividadesIndCriacaoWeb_WEB] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Web_Atividades] PRIMARY KEY NONCLUSTERED ([IdWeb_Atividade] ASC)
);

