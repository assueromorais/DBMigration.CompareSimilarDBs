CREATE TABLE [dbo].[RequisicaoEndAtualCF] (
    [IdRequisicaoEndAtualCF] INT           IDENTITY (1, 1) NOT NULL,
    [Registro]               VARCHAR (20)  NOT NULL,
    [NomeProfissional]       VARCHAR (100) NOT NULL,
    [CPF]                    VARCHAR (11)  NULL,
    [DataNascimento]         DATETIME      NULL,
    [NomeMae]                VARCHAR (50)  NULL,
    [idSetorSolicitante]     INT           NOT NULL,
    [DataSolicitacao]        DATETIME      NOT NULL,
    [SituacaoFiscal]         VARCHAR (40)  NULL,
    [EnderecoAtual]          VARCHAR (60)  NULL,
    [CEP_Atual]              VARCHAR (9)   NULL,
    [BairroCidade]           VARCHAR (80)  NULL,
    [UF]                     CHAR (2)      NULL,
    [Situacao]               INT           NOT NULL,
    [DataSituacao]           DATETIME      NOT NULL,
    CONSTRAINT [PK_RequisicaoEndAtualCF] PRIMARY KEY CLUSTERED ([IdRequisicaoEndAtualCF] ASC)
);

