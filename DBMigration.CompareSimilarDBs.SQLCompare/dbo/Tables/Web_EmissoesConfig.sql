﻿CREATE TABLE [dbo].[Web_EmissoesConfig] (
    [IdWeb_EmissoesConfig]      INT            IDENTITY (1, 1) NOT NULL,
    [IdEmissaoConfig]           INT            NULL,
    [Titulo]                    VARCHAR (200)  NULL,
    [DATA]                      DATETIME       CONSTRAINT [DF_EmissoesConfig_Data_WEB] DEFAULT (getdate()) NOT NULL,
    [Status]                    TINYINT        CONSTRAINT [DF_EmissoesConfig_Status_WEB] DEFAULT ((0)) NULL,
    [Usuario]                   VARCHAR (35)   NULL,
    [TipoPessoa]                TINYINT        NULL,
    [Coletiva]                  BIT            CONSTRAINT [DF_EmissoesConfig_Coletiva_WEB] DEFAULT ((0)) NOT NULL,
    [GerarNossoNumero]          BIT            NOT NULL,
    [EmissaoComDesconto]        INT            CONSTRAINT [DF_EmissoesConfigEmissaoComDesconto_WEB] DEFAULT ((0)) NOT NULL,
    [EmissaoWeb]                BIT            CONSTRAINT [DF_EmissoesConfig_EmissaoWeb_WEB] DEFAULT ((0)) NOT NULL,
    [IdBanco]                   INT            NOT NULL,
    [IdContaCorrente]           INT            NULL,
    [IdConvenio]                INT            NULL,
    [EmissaoComRegistro]        BIT            NULL,
    [TipoEmissao]               INT            NOT NULL,
    [TipoComposicao]            INT            NOT NULL,
    [TipoDivisaoDesp]           INT            NOT NULL,
    [ValorDespBanco]            MONEY          NULL,
    [ValorDespPostal]           MONEY          NULL,
    [ValorDespAdv]              MONEY          NULL,
    [IdentificarDebitoNoBoleto] BIT            NULL,
    [ExibirComposicaoDebito]    BIT            NULL,
    [DataVencimentoBoleto]      DATETIME       NULL,
    [DataAtualizacao]           DATETIME       NULL,
    [NaoReceberAposVencimento]  BIT            NULL,
    [IdProcedimentoAtraso]      INT            NULL,
    [CodProtesto]               TINYINT        NULL,
    [QtdDiasProtesto]           SMALLINT       NULL,
    [CodBaixa]                  TINYINT        NULL,
    [QtdDiasBaixa]              SMALLINT       NULL,
    [Mensagem]                  VARCHAR (4000) NULL,
    [Instrucao]                 VARCHAR (1000) NULL,
    [Chave]                     VARCHAR (38)   CONSTRAINT [DF_EmissoesConfigChave_WEB] DEFAULT (newid()) NULL,
    [InserirRTF_File]           BIT            NULL,
    [IdRelatorio]               INT            NULL,
    [ErroMsg]                   VARCHAR (2048) NULL,
    [AtualizacaoWeb]            VARCHAR (5000) NULL,
    [IndAtualizacao]            BIT            NULL,
    [DataBaixa]                 DATETIME       NULL,
    [IndicarDebitosEmAberto]    BIT            CONSTRAINT [DF_EmissoesConfig_IndicarDebitosEmAberto_WEB] DEFAULT ((0)) NOT NULL
);
