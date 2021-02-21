CREATE TABLE [dbo].[Web_Cidades] (
    [IdWeb_Cidade]                   INT          IDENTITY (1, 1) NOT NULL,
    [IdCidade]                       INT          NOT NULL,
    [NomeCidade]                     VARCHAR (50) NULL,
    [IndCriacaoWeb]                  BIT          CONSTRAINT [DF_CidadesIndCriacaoWeb_WEB] DEFAULT ((0)) NULL,
    [DataBaixa]                      DATETIME     NULL,
    [DataAtualizacao]                DATETIME     NULL,
    [E_Impedido]                     BIT          NULL,
    [IndCricacaoWeb]                 BIT          CONSTRAINT [DF_CidadesIndCricacaoWeb_WEB] DEFAULT ((0)) NOT NULL,
    [CodCidade]                      INT          NULL,
    [IdSubregiao]                    INT          NULL,
    [Desativado]                     BIT          CONSTRAINT [DF_CidadesDesativado_WEB] DEFAULT ((0)) NULL,
    [NomeCidadeAbreviadoCarteiraEst] VARCHAR (30) NULL,
    [E_Capital]                      BIT          NULL,
    [IdRegiao]                       INT          NULL,
    [E_Comarca]                      BIT          CONSTRAINT [DFCidadesEComarca_WEB] DEFAULT ((0)) NOT NULL,
    [idComarca]                      INT          NULL,
    [IdEstado]                       INT          NULL,
    [IdRegiaoAdministrativa]         INT          NULL,
    [IdCidadeDNE]                    INT          NULL,
    [CEP]                            VARCHAR (8)  NULL,
    CONSTRAINT [PK_Web_Cidades] PRIMARY KEY CLUSTERED ([IdWeb_Cidade] ASC)
);

