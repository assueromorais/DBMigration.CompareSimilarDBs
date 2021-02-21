CREATE TABLE [dbo].[Unidades] (
    [IdUnidade]          INT          IDENTITY (1, 1) NOT NULL,
    [NomeUnidade]        VARCHAR (60) NOT NULL,
    [CodigoUnidade]      VARCHAR (9)  NOT NULL,
    [SiglaUnidade]       VARCHAR (15) NULL,
    [Endereco]           VARCHAR (60) NULL,
    [NomeBairro]         VARCHAR (35) NULL,
    [NomeCidade]         VARCHAR (30) NULL,
    [CEP]                VARCHAR (9)  NULL,
    [NomeContato]        VARCHAR (60) NULL,
    [TelefoneContato]    VARCHAR (40) NULL,
    [Desativado]         BIT          CONSTRAINT [DF__Unidades__Desati__3ED2FDA6] DEFAULT ((0)) NULL,
    [E_Inspetoria]       BIT          NULL,
    [IdCentroCusto]      INT          NULL,
    [E_Camara]           BIT          NULL,
    [E_Comissao]         BIT          NULL,
    [E_GrupoTrabalho]    BIT          NULL,
    [SiglaUF]            VARCHAR (2)  NULL,
    [Email]              VARCHAR (60) NULL,
    [E_ConselhoRegional] BIT          NULL,
    CONSTRAINT [PK_Unidades] PRIMARY KEY NONCLUSTERED ([IdUnidade] ASC)
);

