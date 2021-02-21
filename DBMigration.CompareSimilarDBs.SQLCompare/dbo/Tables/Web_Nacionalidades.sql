CREATE TABLE [dbo].[Web_Nacionalidades] (
    [IdWeb_Nacionalidade] INT          IDENTITY (1, 1) NOT NULL,
    [IdNacionalidade]     INT          NOT NULL,
    [Nacionalidade]       VARCHAR (30) NULL,
    [IndCriacaoWeb]       BIT          CONSTRAINT [DF_NacionalidadesIndCriacaoWeb_WEB] DEFAULT ((0)) NULL,
    [DataBaixa]           DATETIME     NULL,
    [DataAtualizacao]     DATETIME     NULL,
    [E_Impedido]          BIT          NULL,
    [IndCricacaoWeb]      BIT          CONSTRAINT [DF_NacionalidadesIndCricacaoWeb_WEB] DEFAULT ((0)) NOT NULL,
    [Desativado]          BIT          CONSTRAINT [DF_NacionalidadesDesativado_WEB] DEFAULT ((0)) NULL,
    [Pais]                VARCHAR (50) NULL,
    CONSTRAINT [PK_Web_Nacionalidades] PRIMARY KEY CLUSTERED ([IdWeb_Nacionalidade] ASC)
);

