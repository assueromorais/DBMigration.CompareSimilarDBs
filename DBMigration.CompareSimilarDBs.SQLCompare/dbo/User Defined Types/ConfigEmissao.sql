﻿CREATE TYPE [dbo].[ConfigEmissao] AS TABLE (
    [Chave]                     UNIQUEIDENTIFIER NULL,
    [Titulo]                    VARCHAR (200)    NULL,
    [TipoPessoa]                TINYINT          NULL,
    [IdRelatorio]               INT              NULL,
    [IdBanco]                   INT              NULL,
    [IdContaCorrente]           INT              NULL,
    [IdConvenio]                INT              NULL,
    [TipoEmissao]               INT              NULL,
    [TipoComposicao]            INT              NULL,
    [TipoDivisaoDesp]           INT              NULL,
    [GerarNossoNumero]          BIT              NULL,
    [EmissaoComDesconto]        INT              NULL,
    [EmissaoWeb]                BIT              NULL,
    [ValorDespBanco]            MONEY            NULL,
    [ValorDespPostal]           MONEY            NULL,
    [ValorDespAdv]              MONEY            NULL,
    [DataVencimentoBoleto]      DATETIME         NULL,
    [DataAtualizacao]           DATETIME         NULL,
    [NaoReceberAposVencimento]  BIT              NULL,
    [IdProcedimentoAtraso]      INT              NULL,
    [IdentificarDebitoNoBoleto] BIT              NULL,
    [IndicarDebitosEmAberto]    BIT              NULL,
    [InserirRTF_File]           BIT              NULL,
    [ExibirComposicaoDebito]    BIT              NULL,
    [Mensagem]                  VARCHAR (4000)   NULL,
    [Instrucao]                 VARCHAR (1000)   NULL);

