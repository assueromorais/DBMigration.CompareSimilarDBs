﻿CREATE TABLE [dbo].[Web_Debitos] (
    [IdWeb_Debitos]                 INT            IDENTITY (1, 1) NOT NULL,
    [IdDebito]                      INT            NOT NULL,
    [IdProfissional]                INT            NULL,
    [IdPessoaJuridica]              INT            NULL,
    [IdTipoDebito]                  INT            NOT NULL,
    [IdSituacaoAtual]               INT            NULL,
    [IdArquivoPagamento]            INT            NULL,
    [IdAutoInfracao]                INT            NULL,
    [IdMoeda]                       INT            NOT NULL,
    [IdConfigGeracaoDebito]         INT            NULL,
    [NossoNumero]                   VARCHAR (20)   NULL,
    [DataGeracao]                   DATETIME       NULL,
    [DataVencimento]                DATETIME       NOT NULL,
    [DataReferencia]                DATETIME       NULL,
    [DataRepasse]                   DATETIME       NULL,
    [DataPgto]                      DATETIME       NULL,
    [ValorDevido]                   MONEY          NULL,
    [ValorPago]                     MONEY          NULL,
    [NumeroParcela]                 INT            NULL,
    [PercentualRepasse]             FLOAT (53)     NULL,
    [DocumentoPgto]                 VARCHAR (20)   NULL,
    [ContaCorrente]                 VARCHAR (23)   NULL,
    [TpEmissaoConjunta]             INT            NULL,
    [TpCompDespesas]                INT            NULL,
    [NumConjReneg]                  INT            NULL,
    [NumConjTpDebito]               INT            NULL,
    [NumConjEmissao]                INT            NULL,
    [ObsDebito]                     TEXT           NULL,
    [CodBanco]                      VARCHAR (3)    NULL,
    [CodAgencia]                    VARCHAR (4)    NULL,
    [CodOperacao]                   VARCHAR (3)    NULL,
    [CodCC_Conv_Ced]                VARCHAR (16)   NULL,
    [Emitido]                       BIT            NOT NULL,
    [NumeroDocumento]               INT            NULL,
    [IdDebitoOld]                   INT            NULL,
    [IdTipoPagamento]               INT            NULL,
    [DataAtualizacao]               DATETIME       NULL,
    [Desconto]                      MONEY          NULL,
    [AtualizacaoWeb]                VARCHAR (5000) NULL,
    [IndAtualizacao]                BIT            NULL,
    [DataBaixa]                     DATETIME       NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35)   NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60)   NULL,
    [IdFiscalizacao]                INT            NULL,
    [IdPessoa]                      INT            NULL,
    [IdMotivoCancelamento]          INT            NULL,
    [DataDeposito]                  DATETIME       NULL,
    [RegistraLog]                   BIT            CONSTRAINT [DF__Debitos__Registr__0347582D_WEB] DEFAULT ((1)) NULL,
    [DataCredito]                   DATETIME       NULL,
    [IdProcedimentoOperacional]     INT            NULL,
    [TipoDividaAtiva]               INT            NULL,
    [DataUltimaAtualizacao]         DATETIME       NULL,
    [NPossuiCotaUnica]              BIT            CONSTRAINT [DF__Debitos__NPossui__72A7A767_WEB] DEFAULT ((0)) NOT NULL,
    [ExecTriggerNPossuiCotaUnica]   BIT            CONSTRAINT [DF__Debitos__ExecTri__739BCBA0_WEB] DEFAULT ((1)) NOT NULL,
    [IdDividaAtiva]                 INT            NULL,
    [Bacalhau]                      BIT            NULL,
    [GeracaoColetiva]               BIT            CONSTRAINT [DF__Debitos__Geracao__15728C0E_WEB] DEFAULT ((0)) NOT NULL,
    [AutorizaDebitoConta]           BIT            CONSTRAINT [DF__Debitos__Autoriz__0C0D1618_WEB] DEFAULT ((0)) NOT NULL,
    [UsuarioRen]                    VARCHAR (30)   NULL,
    [DepartamentoRen]               VARCHAR (60)   NULL,
    [NumeroRenegociacao]            VARCHAR (15)   NULL,
    [SeuNumero]                     CHAR (11)      NULL,
    [E_Estagiario]                  BIT            NULL,
    [Acrescimos]                    MONEY          CONSTRAINT [DF__Debitos__Acresci__54B0C11C_WEB] DEFAULT ((0)) NULL,
    [PagoPorBaixaDebCancelado]      BIT            NULL,
    [IdDebitoOrigem]                INT            NULL,
    [NumConjRenegHistorico]         INT            NULL,
    [NumConjParcelasRen]            INT            NULL,
    [CategoriaCriacao]              VARCHAR (100)  NULL,
    [InscricaoCriacao]              VARCHAR (100)  NULL,
    [DataUltimoPgto]                DATETIME       NULL,
    [DataUltimoCredito]             DATETIME       NULL,
    [Recred]                        BIT            CONSTRAINT [DF_Debitos_Recred_WEB] DEFAULT ((0)) NOT NULL,
    [Protestado]                    BIT            CONSTRAINT [DEF_Debitos_Protestado_WEB] DEFAULT ((0)) NOT NULL,
    [ProtestadoData]                DATETIME       NULL,
    [ProtestadoUsuario]             VARCHAR (60)   NULL
);

