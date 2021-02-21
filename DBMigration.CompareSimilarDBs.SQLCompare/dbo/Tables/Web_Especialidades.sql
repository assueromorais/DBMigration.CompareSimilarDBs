CREATE TABLE [dbo].[Web_Especialidades] (
    [IdWeb_Especialidade] INT          IDENTITY (1, 1) NOT NULL,
    [IdEspecialidade]     INT          NOT NULL,
    [NomeEspecialidade]   VARCHAR (40) NULL,
    [IndCriacaoWeb]       BIT          CONSTRAINT [DF_EspecialidadesIndCriacaoWeb_WEB] DEFAULT ((0)) NULL,
    [DataBaixa]           DATETIME     NULL,
    [DataAtualizacao]     DATETIME     NULL,
    [E_Impedido]          BIT          NULL,
    [Sigla]               VARCHAR (5)  NULL,
    [Desativado]          BIT          CONSTRAINT [DF_EspecialidadesDesativado_WEB] DEFAULT ((0)) NULL,
    [IndCricacaoWeb]      BIT          CONSTRAINT [DF_EspecialidadesIndCricacaoWeb_WEB] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Web_Especialidades] PRIMARY KEY CLUSTERED ([IdWeb_Especialidade] ASC)
);

