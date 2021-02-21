CREATE TABLE [dbo].[Web_Bairros] (
    [IdWeb_Bairro]    INT          IDENTITY (1, 1) NOT NULL,
    [IdBairro]        INT          NOT NULL,
    [NomeBairro]      VARCHAR (50) NULL,
    [IndCriacaoWeb]   BIT          CONSTRAINT [DF_BairrosIndCriacaoWeb_WEB] DEFAULT ((0)) NULL,
    [DataBaixa]       DATETIME     NULL,
    [DataAtualizacao] DATETIME     NULL,
    [E_Impedido]      BIT          NULL,
    [IndCricacaoWeb]  BIT          CONSTRAINT [DF_BairrosIndCricacaoWeb_WEB] DEFAULT ((0)) NOT NULL,
    [Desativado]      BIT          CONSTRAINT [DF_BairrosDesativado_WEB] DEFAULT ((0)) NULL,
    [IdCidade]        INT          NULL,
    [IdBairroDNE]     INT          NULL,
    CONSTRAINT [PK_Web_Bairros] PRIMARY KEY CLUSTERED ([IdWeb_Bairro] ASC)
);

