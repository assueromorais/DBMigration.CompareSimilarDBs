CREATE TABLE [dbo].[Debitos] (
    [IdDebito]                      INT            IDENTITY (1, 1) NOT NULL,
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
    [IdTipoPagamento]               INT            NULL,
    [DataAtualizacao]               DATETIME       NULL,
    [Desconto]                      MONEY          NULL,
    [IdFiscalizacao]                INT            NULL,
    [IdDebitoOld]                   INT            NULL,
    [IdPessoa]                      INT            NULL,
    [IdMotivoCancelamento]          INT            NULL,
    [DataDeposito]                  DATETIME       NULL,
    [RegistraLog]                   BIT            CONSTRAINT [DF__Debitos__Registr__0347582D] DEFAULT ((1)) NULL,
    [DataCredito]                   DATETIME       NULL,
    [IdProcedimentoOperacional]     INT            NULL,
    [TipoDividaAtiva]               INT            NULL,
    [DataUltimaAtualizacao]         DATETIME       NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (150)  NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60)   NULL,
    [NPossuiCotaUnica]              BIT            CONSTRAINT [DF__Debitos__NPossui__72A7A767] DEFAULT ((0)) NOT NULL,
    [ExecTriggerNPossuiCotaUnica]   BIT            CONSTRAINT [DF__Debitos__ExecTri__739BCBA0] DEFAULT ((1)) NOT NULL,
    [IdDividaAtiva]                 INT            NULL,
    [Bacalhau]                      BIT            NULL,
    [GeracaoColetiva]               BIT            CONSTRAINT [DF__Debitos__Geracao__15728C0E] DEFAULT ((0)) NOT NULL,
    [AutorizaDebitoConta]           BIT            CONSTRAINT [DF__Debitos__Autoriz__0C0D1618] DEFAULT ((0)) NOT NULL,
    [UsuarioRen]                    VARCHAR (30)   NULL,
    [DepartamentoRen]               VARCHAR (60)   NULL,
    [NumeroRenegociacao]            VARCHAR (15)   NULL,
    [SeuNumero]                     CHAR (11)      NULL,
    [E_Estagiario]                  BIT            NULL,
    [Acrescimos]                    MONEY          CONSTRAINT [DF__Debitos__Acresci__54B0C11C] DEFAULT ((0)) NULL,
    [PagoPorBaixaDebCancelado]      BIT            NULL,
    [IdDebitoOrigem]                INT            NULL,
    [NumConjRenegHistorico]         INT            NULL,
    [NumConjParcelasRen]            INT            NULL,
    [CategoriaCriacao]              VARCHAR (100)  NULL,
    [InscricaoCriacao]              VARCHAR (100)  NULL,
    [DataUltimoPgto]                DATETIME       NULL,
    [DataUltimoCredito]             DATETIME       NULL,
    [AtualizacaoWeb]                VARCHAR (8000) NULL,
    [Recred]                        BIT            CONSTRAINT [DF_Debitos_Recred] DEFAULT ((0)) NOT NULL,
    [Protestado]                    BIT            CONSTRAINT [DEF_Debitos_Protestado] DEFAULT ((0)) NOT NULL,
    [ProtestadoData]                DATETIME       NULL,
    [ProtestadoUsuario]             VARCHAR (60)   NULL,
    CONSTRAINT [PK_Debitos] PRIMARY KEY NONCLUSTERED ([IdDebito] ASC),
    CONSTRAINT [FK_Debitos_ArquivosPagamento] FOREIGN KEY ([IdArquivoPagamento]) REFERENCES [dbo].[ArquivosRetornoBanco] ([IdArquivoRetorno]),
    CONSTRAINT [FK_Debitos_AutosInfracao] FOREIGN KEY ([IdAutoInfracao]) REFERENCES [dbo].[AutosInfracao] ([IdAutoInfracao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Debitos_ConfigGeracaoDebito] FOREIGN KEY ([IdConfigGeracaoDebito]) REFERENCES [dbo].[ConfigGeracaoDebito] ([IdConfigGeracaoDebito]),
    CONSTRAINT [FK_Debitos_Moedas] FOREIGN KEY ([IdMoeda]) REFERENCES [dbo].[Moedas] ([IdMoeda]),
    CONSTRAINT [FK_Debitos_MotivosCancelamento] FOREIGN KEY ([IdMotivoCancelamento]) REFERENCES [dbo].[MotivosCancelamento] ([IdMotivoCancelamento]),
    CONSTRAINT [FK_Debitos_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Debitos_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_Debitos_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_DEBITOS_SituacaoDebito] FOREIGN KEY ([IdSituacaoAtual]) REFERENCES [dbo].[SituacoesDebito] ([IdSituacaoDebito]),
    CONSTRAINT [FK_Debitos_TiposDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito]),
    CONSTRAINT [FK_Debitos_TiposPagamentos] FOREIGN KEY ([IdTipoPagamento]) REFERENCES [dbo].[TiposPagamentos] ([IdTipoPagamento]),
    CONSTRAINT [FK_Fiscalizacoes_Debitos] FOREIGN KEY ([IdFiscalizacao]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao])
);


GO
CREATE NONCLUSTERED INDEX [_ix_Debitos_IdDebito_NossoNumero_IdPessoaJuridica_DataPgto]
    ON [dbo].[Debitos]([IdDebito] ASC, [NossoNumero] ASC, [IdPessoaJuridica] ASC, [DataPgto] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ConfigGeracaoDebito]
    ON [dbo].[Debitos]([IdConfigGeracaoDebito] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Debitos_DataReferencia]
    ON [dbo].[Debitos]([DataReferencia] ASC);


GO
CREATE NONCLUSTERED INDEX [_ix_Debitos_NossoNumero]
    ON [dbo].[Debitos]([NossoNumero] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DebitosDataCredito]
    ON [dbo].[Debitos]([DataCredito] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DebitosDataPagto]
    ON [dbo].[Debitos]([DataPgto] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DebitosDataUltAtualizacao]
    ON [dbo].[Debitos]([DataUltimaAtualizacao] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DebitosIdPessoa]
    ON [dbo].[Debitos]([IdPessoa] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DebitosIdPessoaJuridica]
    ON [dbo].[Debitos]([IdPessoaJuridica] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DebitosIdAutoInfracao]
    ON [dbo].[Debitos]([IdAutoInfracao] ASC);


GO
CREATE NONCLUSTERED INDEX [_IX_DebitosIdProfissional]
    ON [dbo].[Debitos]([IdProfissional] ASC);


GO
CREATE TRIGGER [TrgLog_Debitos] ON [Implanta_CRPAM].[dbo].[Debitos] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
DECLARE 	@RegistraLogI	BIT 
DECLARE 	@RegistraLogD	BIT 
SELECT @RegistraLogI = RegistraLog FROM INSERTED 
SELECT @RegistraLogD = RegistraLog FROM DELETED 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'Debitos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAtual : «' + RTRIM( ISNULL( CAST (IdSituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoPagamento : «' + RTRIM( ISNULL( CAST (IdArquivoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| DataRepasse : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRepasse, 113 ),'Nulo'))+'» '
                         + '| DataPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgto, 113 ),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DocumentoPgto : «' + RTRIM( ISNULL( CAST (DocumentoPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpEmissaoConjunta : «' + RTRIM( ISNULL( CAST (TpEmissaoConjunta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpCompDespesas : «' + RTRIM( ISNULL( CAST (TpCompDespesas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjReneg : «' + RTRIM( ISNULL( CAST (NumConjReneg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjTpDebito : «' + RTRIM( ISNULL( CAST (NumConjTpDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjEmissao : «' + RTRIM( ISNULL( CAST (NumConjEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Emitido IS NULL THEN ' Emitido : «Nulo» '
                                              WHEN  Emitido = 0 THEN ' Emitido : «Falso» '
                                              WHEN  Emitido = 1 THEN ' Emitido : «Verdadeiro» '
                                    END 
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoOld : «' + RTRIM( ISNULL( CAST (IdDebitoOld AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoCancelamento : «' + RTRIM( ISNULL( CAST (IdMotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDeposito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDeposito, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| IdProcedimentoOperacional : «' + RTRIM( ISNULL( CAST (IdProcedimentoOperacional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDividaAtiva : «' + RTRIM( ISNULL( CAST (TipoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NPossuiCotaUnica IS NULL THEN ' NPossuiCotaUnica : «Nulo» '
                                              WHEN  NPossuiCotaUnica = 0 THEN ' NPossuiCotaUnica : «Falso» '
                                              WHEN  NPossuiCotaUnica = 1 THEN ' NPossuiCotaUnica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExecTriggerNPossuiCotaUnica IS NULL THEN ' ExecTriggerNPossuiCotaUnica : «Nulo» '
                                              WHEN  ExecTriggerNPossuiCotaUnica = 0 THEN ' ExecTriggerNPossuiCotaUnica : «Falso» '
                                              WHEN  ExecTriggerNPossuiCotaUnica = 1 THEN ' ExecTriggerNPossuiCotaUnica : «Verdadeiro» '
                                    END 
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Bacalhau IS NULL THEN ' Bacalhau : «Nulo» '
                                              WHEN  Bacalhau = 0 THEN ' Bacalhau : «Falso» '
                                              WHEN  Bacalhau = 1 THEN ' Bacalhau : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeracaoColetiva IS NULL THEN ' GeracaoColetiva : «Nulo» '
                                              WHEN  GeracaoColetiva = 0 THEN ' GeracaoColetiva : «Falso» '
                                              WHEN  GeracaoColetiva = 1 THEN ' GeracaoColetiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta IS NULL THEN ' AutorizaDebitoConta : «Nulo» '
                                              WHEN  AutorizaDebitoConta = 0 THEN ' AutorizaDebitoConta : «Falso» '
                                              WHEN  AutorizaDebitoConta = 1 THEN ' AutorizaDebitoConta : «Verdadeiro» '
                                    END 
                         + '| UsuarioRen : «' + RTRIM( ISNULL( CAST (UsuarioRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoRen : «' + RTRIM( ISNULL( CAST (DepartamentoRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRenegociacao : «' + RTRIM( ISNULL( CAST (NumeroRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Estagiario IS NULL THEN ' E_Estagiario : «Nulo» '
                                              WHEN  E_Estagiario = 0 THEN ' E_Estagiario : «Falso» '
                                              WHEN  E_Estagiario = 1 THEN ' E_Estagiario : «Verdadeiro» '
                                    END 
                         + '| Acrescimos : «' + RTRIM( ISNULL( CAST (Acrescimos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PagoPorBaixaDebCancelado IS NULL THEN ' PagoPorBaixaDebCancelado : «Nulo» '
                                              WHEN  PagoPorBaixaDebCancelado = 0 THEN ' PagoPorBaixaDebCancelado : «Falso» '
                                              WHEN  PagoPorBaixaDebCancelado = 1 THEN ' PagoPorBaixaDebCancelado : «Verdadeiro» '
                                    END 
                         + '| IdDebitoOrigem : «' + RTRIM( ISNULL( CAST (IdDebitoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjRenegHistorico : «' + RTRIM( ISNULL( CAST (NumConjRenegHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjParcelasRen : «' + RTRIM( ISNULL( CAST (NumConjParcelasRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CategoriaCriacao : «' + RTRIM( ISNULL( CAST (CategoriaCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoCriacao : «' + RTRIM( ISNULL( CAST (InscricaoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimoPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimoPgto, 113 ),'Nulo'))+'» '
                         + '| DataUltimoCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimoCredito, 113 ),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recred IS NULL THEN ' Recred : «Nulo» '
                                              WHEN  Recred = 0 THEN ' Recred : «Falso» '
                                              WHEN  Recred = 1 THEN ' Recred : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Protestado IS NULL THEN ' Protestado : «Nulo» '
                                              WHEN  Protestado = 0 THEN ' Protestado : «Falso» '
                                              WHEN  Protestado = 1 THEN ' Protestado : «Verdadeiro» '
                                    END 
                         + '| ProtestadoData : «' + RTRIM( ISNULL( CONVERT (CHAR, ProtestadoData, 113 ),'Nulo'))+'» '
                         + '| ProtestadoUsuario : «' + RTRIM( ISNULL( CAST (ProtestadoUsuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAtual : «' + RTRIM( ISNULL( CAST (IdSituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoPagamento : «' + RTRIM( ISNULL( CAST (IdArquivoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| DataRepasse : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRepasse, 113 ),'Nulo'))+'» '
                         + '| DataPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgto, 113 ),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DocumentoPgto : «' + RTRIM( ISNULL( CAST (DocumentoPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpEmissaoConjunta : «' + RTRIM( ISNULL( CAST (TpEmissaoConjunta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpCompDespesas : «' + RTRIM( ISNULL( CAST (TpCompDespesas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjReneg : «' + RTRIM( ISNULL( CAST (NumConjReneg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjTpDebito : «' + RTRIM( ISNULL( CAST (NumConjTpDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjEmissao : «' + RTRIM( ISNULL( CAST (NumConjEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Emitido IS NULL THEN ' Emitido : «Nulo» '
                                              WHEN  Emitido = 0 THEN ' Emitido : «Falso» '
                                              WHEN  Emitido = 1 THEN ' Emitido : «Verdadeiro» '
                                    END 
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoOld : «' + RTRIM( ISNULL( CAST (IdDebitoOld AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoCancelamento : «' + RTRIM( ISNULL( CAST (IdMotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDeposito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDeposito, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| IdProcedimentoOperacional : «' + RTRIM( ISNULL( CAST (IdProcedimentoOperacional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDividaAtiva : «' + RTRIM( ISNULL( CAST (TipoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NPossuiCotaUnica IS NULL THEN ' NPossuiCotaUnica : «Nulo» '
                                              WHEN  NPossuiCotaUnica = 0 THEN ' NPossuiCotaUnica : «Falso» '
                                              WHEN  NPossuiCotaUnica = 1 THEN ' NPossuiCotaUnica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExecTriggerNPossuiCotaUnica IS NULL THEN ' ExecTriggerNPossuiCotaUnica : «Nulo» '
                                              WHEN  ExecTriggerNPossuiCotaUnica = 0 THEN ' ExecTriggerNPossuiCotaUnica : «Falso» '
                                              WHEN  ExecTriggerNPossuiCotaUnica = 1 THEN ' ExecTriggerNPossuiCotaUnica : «Verdadeiro» '
                                    END 
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Bacalhau IS NULL THEN ' Bacalhau : «Nulo» '
                                              WHEN  Bacalhau = 0 THEN ' Bacalhau : «Falso» '
                                              WHEN  Bacalhau = 1 THEN ' Bacalhau : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeracaoColetiva IS NULL THEN ' GeracaoColetiva : «Nulo» '
                                              WHEN  GeracaoColetiva = 0 THEN ' GeracaoColetiva : «Falso» '
                                              WHEN  GeracaoColetiva = 1 THEN ' GeracaoColetiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta IS NULL THEN ' AutorizaDebitoConta : «Nulo» '
                                              WHEN  AutorizaDebitoConta = 0 THEN ' AutorizaDebitoConta : «Falso» '
                                              WHEN  AutorizaDebitoConta = 1 THEN ' AutorizaDebitoConta : «Verdadeiro» '
                                    END 
                         + '| UsuarioRen : «' + RTRIM( ISNULL( CAST (UsuarioRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoRen : «' + RTRIM( ISNULL( CAST (DepartamentoRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRenegociacao : «' + RTRIM( ISNULL( CAST (NumeroRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Estagiario IS NULL THEN ' E_Estagiario : «Nulo» '
                                              WHEN  E_Estagiario = 0 THEN ' E_Estagiario : «Falso» '
                                              WHEN  E_Estagiario = 1 THEN ' E_Estagiario : «Verdadeiro» '
                                    END 
                         + '| Acrescimos : «' + RTRIM( ISNULL( CAST (Acrescimos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PagoPorBaixaDebCancelado IS NULL THEN ' PagoPorBaixaDebCancelado : «Nulo» '
                                              WHEN  PagoPorBaixaDebCancelado = 0 THEN ' PagoPorBaixaDebCancelado : «Falso» '
                                              WHEN  PagoPorBaixaDebCancelado = 1 THEN ' PagoPorBaixaDebCancelado : «Verdadeiro» '
                                    END 
                         + '| IdDebitoOrigem : «' + RTRIM( ISNULL( CAST (IdDebitoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjRenegHistorico : «' + RTRIM( ISNULL( CAST (NumConjRenegHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjParcelasRen : «' + RTRIM( ISNULL( CAST (NumConjParcelasRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CategoriaCriacao : «' + RTRIM( ISNULL( CAST (CategoriaCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoCriacao : «' + RTRIM( ISNULL( CAST (InscricaoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimoPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimoPgto, 113 ),'Nulo'))+'» '
                         + '| DataUltimoCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimoCredito, 113 ),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recred IS NULL THEN ' Recred : «Nulo» '
                                              WHEN  Recred = 0 THEN ' Recred : «Falso» '
                                              WHEN  Recred = 1 THEN ' Recred : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Protestado IS NULL THEN ' Protestado : «Nulo» '
                                              WHEN  Protestado = 0 THEN ' Protestado : «Falso» '
                                              WHEN  Protestado = 1 THEN ' Protestado : «Verdadeiro» '
                                    END 
                         + '| ProtestadoData : «' + RTRIM( ISNULL( CONVERT (CHAR, ProtestadoData, 113 ),'Nulo'))+'» '
                         + '| ProtestadoUsuario : «' + RTRIM( ISNULL( CAST (ProtestadoUsuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
 END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
AND @RegistraLogI = 1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAtual : «' + RTRIM( ISNULL( CAST (IdSituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoPagamento : «' + RTRIM( ISNULL( CAST (IdArquivoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| DataRepasse : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRepasse, 113 ),'Nulo'))+'» '
                         + '| DataPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgto, 113 ),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DocumentoPgto : «' + RTRIM( ISNULL( CAST (DocumentoPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpEmissaoConjunta : «' + RTRIM( ISNULL( CAST (TpEmissaoConjunta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpCompDespesas : «' + RTRIM( ISNULL( CAST (TpCompDespesas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjReneg : «' + RTRIM( ISNULL( CAST (NumConjReneg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjTpDebito : «' + RTRIM( ISNULL( CAST (NumConjTpDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjEmissao : «' + RTRIM( ISNULL( CAST (NumConjEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Emitido IS NULL THEN ' Emitido : «Nulo» '
                                              WHEN  Emitido = 0 THEN ' Emitido : «Falso» '
                                              WHEN  Emitido = 1 THEN ' Emitido : «Verdadeiro» '
                                    END 
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoOld : «' + RTRIM( ISNULL( CAST (IdDebitoOld AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoCancelamento : «' + RTRIM( ISNULL( CAST (IdMotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDeposito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDeposito, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| IdProcedimentoOperacional : «' + RTRIM( ISNULL( CAST (IdProcedimentoOperacional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDividaAtiva : «' + RTRIM( ISNULL( CAST (TipoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NPossuiCotaUnica IS NULL THEN ' NPossuiCotaUnica : «Nulo» '
                                              WHEN  NPossuiCotaUnica = 0 THEN ' NPossuiCotaUnica : «Falso» '
                                              WHEN  NPossuiCotaUnica = 1 THEN ' NPossuiCotaUnica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExecTriggerNPossuiCotaUnica IS NULL THEN ' ExecTriggerNPossuiCotaUnica : «Nulo» '
                                              WHEN  ExecTriggerNPossuiCotaUnica = 0 THEN ' ExecTriggerNPossuiCotaUnica : «Falso» '
                                              WHEN  ExecTriggerNPossuiCotaUnica = 1 THEN ' ExecTriggerNPossuiCotaUnica : «Verdadeiro» '
                                    END 
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Bacalhau IS NULL THEN ' Bacalhau : «Nulo» '
                                              WHEN  Bacalhau = 0 THEN ' Bacalhau : «Falso» '
                                              WHEN  Bacalhau = 1 THEN ' Bacalhau : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeracaoColetiva IS NULL THEN ' GeracaoColetiva : «Nulo» '
                                              WHEN  GeracaoColetiva = 0 THEN ' GeracaoColetiva : «Falso» '
                                              WHEN  GeracaoColetiva = 1 THEN ' GeracaoColetiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta IS NULL THEN ' AutorizaDebitoConta : «Nulo» '
                                              WHEN  AutorizaDebitoConta = 0 THEN ' AutorizaDebitoConta : «Falso» '
                                              WHEN  AutorizaDebitoConta = 1 THEN ' AutorizaDebitoConta : «Verdadeiro» '
                                    END 
                         + '| UsuarioRen : «' + RTRIM( ISNULL( CAST (UsuarioRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoRen : «' + RTRIM( ISNULL( CAST (DepartamentoRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRenegociacao : «' + RTRIM( ISNULL( CAST (NumeroRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Estagiario IS NULL THEN ' E_Estagiario : «Nulo» '
                                              WHEN  E_Estagiario = 0 THEN ' E_Estagiario : «Falso» '
                                              WHEN  E_Estagiario = 1 THEN ' E_Estagiario : «Verdadeiro» '
                                    END 
                         + '| Acrescimos : «' + RTRIM( ISNULL( CAST (Acrescimos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PagoPorBaixaDebCancelado IS NULL THEN ' PagoPorBaixaDebCancelado : «Nulo» '
                                              WHEN  PagoPorBaixaDebCancelado = 0 THEN ' PagoPorBaixaDebCancelado : «Falso» '
                                              WHEN  PagoPorBaixaDebCancelado = 1 THEN ' PagoPorBaixaDebCancelado : «Verdadeiro» '
                                    END 
                         + '| IdDebitoOrigem : «' + RTRIM( ISNULL( CAST (IdDebitoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjRenegHistorico : «' + RTRIM( ISNULL( CAST (NumConjRenegHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjParcelasRen : «' + RTRIM( ISNULL( CAST (NumConjParcelasRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CategoriaCriacao : «' + RTRIM( ISNULL( CAST (CategoriaCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoCriacao : «' + RTRIM( ISNULL( CAST (InscricaoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimoPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimoPgto, 113 ),'Nulo'))+'» '
                         + '| DataUltimoCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimoCredito, 113 ),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recred IS NULL THEN ' Recred : «Nulo» '
                                              WHEN  Recred = 0 THEN ' Recred : «Falso» '
                                              WHEN  Recred = 1 THEN ' Recred : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Protestado IS NULL THEN ' Protestado : «Nulo» '
                                              WHEN  Protestado = 0 THEN ' Protestado : «Falso» '
                                              WHEN  Protestado = 1 THEN ' Protestado : «Verdadeiro» '
                                    END 
                         + '| ProtestadoData : «' + RTRIM( ISNULL( CONVERT (CHAR, ProtestadoData, 113 ),'Nulo'))+'» '
                         + '| ProtestadoUsuario : «' + RTRIM( ISNULL( CAST (ProtestadoUsuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAtual : «' + RTRIM( ISNULL( CAST (IdSituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoPagamento : «' + RTRIM( ISNULL( CAST (IdArquivoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| DataRepasse : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRepasse, 113 ),'Nulo'))+'» '
                         + '| DataPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgto, 113 ),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DocumentoPgto : «' + RTRIM( ISNULL( CAST (DocumentoPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpEmissaoConjunta : «' + RTRIM( ISNULL( CAST (TpEmissaoConjunta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpCompDespesas : «' + RTRIM( ISNULL( CAST (TpCompDespesas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjReneg : «' + RTRIM( ISNULL( CAST (NumConjReneg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjTpDebito : «' + RTRIM( ISNULL( CAST (NumConjTpDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjEmissao : «' + RTRIM( ISNULL( CAST (NumConjEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Emitido IS NULL THEN ' Emitido : «Nulo» '
                                              WHEN  Emitido = 0 THEN ' Emitido : «Falso» '
                                              WHEN  Emitido = 1 THEN ' Emitido : «Verdadeiro» '
                                    END 
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoOld : «' + RTRIM( ISNULL( CAST (IdDebitoOld AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoCancelamento : «' + RTRIM( ISNULL( CAST (IdMotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDeposito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDeposito, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| IdProcedimentoOperacional : «' + RTRIM( ISNULL( CAST (IdProcedimentoOperacional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDividaAtiva : «' + RTRIM( ISNULL( CAST (TipoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NPossuiCotaUnica IS NULL THEN ' NPossuiCotaUnica : «Nulo» '
                                              WHEN  NPossuiCotaUnica = 0 THEN ' NPossuiCotaUnica : «Falso» '
                                              WHEN  NPossuiCotaUnica = 1 THEN ' NPossuiCotaUnica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExecTriggerNPossuiCotaUnica IS NULL THEN ' ExecTriggerNPossuiCotaUnica : «Nulo» '
                                              WHEN  ExecTriggerNPossuiCotaUnica = 0 THEN ' ExecTriggerNPossuiCotaUnica : «Falso» '
                                              WHEN  ExecTriggerNPossuiCotaUnica = 1 THEN ' ExecTriggerNPossuiCotaUnica : «Verdadeiro» '
                                    END 
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Bacalhau IS NULL THEN ' Bacalhau : «Nulo» '
                                              WHEN  Bacalhau = 0 THEN ' Bacalhau : «Falso» '
                                              WHEN  Bacalhau = 1 THEN ' Bacalhau : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeracaoColetiva IS NULL THEN ' GeracaoColetiva : «Nulo» '
                                              WHEN  GeracaoColetiva = 0 THEN ' GeracaoColetiva : «Falso» '
                                              WHEN  GeracaoColetiva = 1 THEN ' GeracaoColetiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta IS NULL THEN ' AutorizaDebitoConta : «Nulo» '
                                              WHEN  AutorizaDebitoConta = 0 THEN ' AutorizaDebitoConta : «Falso» '
                                              WHEN  AutorizaDebitoConta = 1 THEN ' AutorizaDebitoConta : «Verdadeiro» '
                                    END 
                         + '| UsuarioRen : «' + RTRIM( ISNULL( CAST (UsuarioRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoRen : «' + RTRIM( ISNULL( CAST (DepartamentoRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRenegociacao : «' + RTRIM( ISNULL( CAST (NumeroRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Estagiario IS NULL THEN ' E_Estagiario : «Nulo» '
                                              WHEN  E_Estagiario = 0 THEN ' E_Estagiario : «Falso» '
                                              WHEN  E_Estagiario = 1 THEN ' E_Estagiario : «Verdadeiro» '
                                    END 
                         + '| Acrescimos : «' + RTRIM( ISNULL( CAST (Acrescimos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PagoPorBaixaDebCancelado IS NULL THEN ' PagoPorBaixaDebCancelado : «Nulo» '
                                              WHEN  PagoPorBaixaDebCancelado = 0 THEN ' PagoPorBaixaDebCancelado : «Falso» '
                                              WHEN  PagoPorBaixaDebCancelado = 1 THEN ' PagoPorBaixaDebCancelado : «Verdadeiro» '
                                    END 
                         + '| IdDebitoOrigem : «' + RTRIM( ISNULL( CAST (IdDebitoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjRenegHistorico : «' + RTRIM( ISNULL( CAST (NumConjRenegHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumConjParcelasRen : «' + RTRIM( ISNULL( CAST (NumConjParcelasRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CategoriaCriacao : «' + RTRIM( ISNULL( CAST (CategoriaCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoCriacao : «' + RTRIM( ISNULL( CAST (InscricaoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimoPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimoPgto, 113 ),'Nulo'))+'» '
                         + '| DataUltimoCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimoCredito, 113 ),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recred IS NULL THEN ' Recred : «Nulo» '
                                              WHEN  Recred = 0 THEN ' Recred : «Falso» '
                                              WHEN  Recred = 1 THEN ' Recred : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Protestado IS NULL THEN ' Protestado : «Nulo» '
                                              WHEN  Protestado = 0 THEN ' Protestado : «Falso» '
                                              WHEN  Protestado = 1 THEN ' Protestado : «Verdadeiro» '
                                    END 
                         + '| ProtestadoData : «' + RTRIM( ISNULL( CONVERT (CHAR, ProtestadoData, 113 ),'Nulo'))+'» '
                         + '| ProtestadoUsuario : «' + RTRIM( ISNULL( CAST (ProtestadoUsuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 

GO
/* OC.229595
* Criado por Wesley Silva
* 
*/
CREATE TRIGGER [dbo].[Trg_Debitos_SituacoesDebito]
ON [dbo].[Debitos] 
   AFTER INSERT, UPDATE
AS
BEGIN
	IF 
	    UPDATE (IdSituacaoAtual)
	
	BEGIN
		DECLARE @Depto               VARCHAR(60),
		        @IdDebito            INT,
		        @IdSituacaoAtual     INT
		
		SELECT @Depto = d.NomeDepto
		FROM   Departamentos d
		       INNER JOIN Usuarios u
		            ON  d.IdDepto = u.IdDepartamento
		WHERE  u.NomeUsuario = HOST_NAME()		
		
		SELECT @IdDebito = MIN(IdDebito)
		FROM   INSERTED
		
		WHILE @IdDebito IS NOT NULL
		BEGIN
		    SELECT @IdSituacaoAtual = IdSituacaoAtual
		    FROM   INSERTED
		    WHERE  IdDebito = @IdDebito
		    
		    IF NOT EXISTS(
		           SELECT TOP 1 1
		           FROM   dbo.Debitos_SituacoesDebito dsd
		           WHERE  dsd.IdDebito = @IdDebito
		                  AND dsd.IdSituacaoDebito = @IdSituacaoAtual
		                  AND dsd.DataSituacao = (
		                          SELECT MAX(dsd2.DataSituacao)
		                          FROM   dbo.Debitos_SituacoesDebito dsd2
		                          WHERE  dsd2.IdDebito = dsd.IdDebito
		                      )
		       )
		    BEGIN
		        INSERT INTO dbo.Debitos_SituacoesDebito
		          (
		            IdDebito,
		            IdSituacaoDebito,
		            DataSituacao,
		            UsuarioUltimaAtualizacao,
		            DepartamentoUltimaAtualizacao
		          )
		        SELECT i.IdDebito,
		               i.IdSituacaoAtual,
		               CASE 
		                    WHEN EXISTS(
		                             SELECT TOP 1 1
		                             FROM   DELETED d
		                             WHERE  d.IdDebito = i.IdDebito
		                         ) THEN GETDATE()
		                    ELSE ISNULL(i.DataGeracao, GETDATE())
		               END,
		               ISNULL(i.UsuarioUltimaAtualizacao, HOST_NAME()),
		               ISNULL(i.DepartamentoUltimaAtualizacao, @Depto)
		        FROM   INSERTED i
		        WHERE  i.IdDebito = @IdDebito
		    END
		    
		    SELECT @IdDebito = MIN(IdDebito)
		    FROM   INSERTED
		    WHERE  IdDebito > @IdDebito
		END
	END
END

GO
/*Ocorr. 57841 - Seila*/

CREATE TRIGGER [dbo].[Trg_DebitosAutosInfracao_Usuario] ON [dbo].[Debitos] 
	FOR INSERT,
		UPDATE,
		DELETE
AS
SET NOCOUNT ON
IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
	BEGIN		
		UPDATE
			A	
		SET
			A.DataUltimaAtualizacao = GETDATE(),
			A.UsuarioUltimaAtualizacao = HOST_NAME(),
			A.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			INSERTED I
			JOIN AutosInfracao A ON A.IdAutoInfracao = I.IdAutoInfracao			
	END
ELSE IF EXISTS (SELECT TOP 1 1 FROM DELETED)
	BEGIN		
		UPDATE
			A	
		SET
			A.DataUltimaAtualizacao = GETDATE(),
			A.UsuarioUltimaAtualizacao = HOST_NAME(),
			A.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			DELETED D
			JOIN AutosInfracao A ON A.IdAutoInfracao = D.IdAutoInfracao				
	END	 
SET NOCOUNT OFF

GO
/*Oc.115065 - Seila*/

CREATE TRIGGER [dbo].[Trg_Debitos_TrataCotaUnica] ON [dbo].[Debitos] 
FOR --INSERT, 
UPDATE, DELETE 
AS

SET NOCOUNT ON

Declare @Qtde_Inserted int, @Qtde_Deleted int, @Executa smallint

Select @Qtde_Inserted=isnull (count(*),0) FROM INSERTED 
Select @Qtde_Deleted=isnull (count(*),0) FROM DELETED 

Set @Executa = 1

 -- Alteração de registro
IF @Qtde_Inserted > 0 and @Qtde_Deleted > 0 and (Update(NumeroParcela) or Update(IdSituacaoAtual)) Set @Executa = 0
IF @Qtde_Inserted = 0 and @Qtde_Deleted > 0  Set @Executa = 0

-- Para continuação do processamento da trigger é necessário que o número da parcela zero esteja sendo alterado ou
-- que a parcela zero esteja sendo alterada para a situação cancelada.

IF @Executa = 0 and @Qtde_Inserted > 0 
Begin
	IF Update(NumeroParcela) 
	Begin
	-- Verificação para saber se o número da parcela zero está sendo alterada para outro número
			IF Exists (Select 1 From inserted t1,deleted t2	
			           Where t1.iddebito = t2.IdDebito and 
			                (t1.NumeroParcela = 0 OR t2.NumeroParcela = 0))
    
				Set @Executa = 0
			Else
				Set @Executa = 1
	End

	-- Verificação para saber se situação da parcela zero está sendo alterada para cancelada.
	IF Update(IdSituacaoAtual) 
	Begin
		IF Exists (Select 1 From INSERTED t1 Where t1.NumeroParcela = 0)
			 Set @Executa = 0
		Else
			 Set @Executa = 1
	End
End

IF @Executa = 0 
Begin
	CREATE TABLE #TABTEMP_REGISTROS_ALTERADOS (
	Id_Identificacao int,
	tipo char(2),
	NumConjTpDebito int,
	NumConjReneg int,
	NPossuiCotaUnica smallint,
	IdTipoDebito smallint	)

	-- Serão tratados todos os registros cuja a parcela 0 tenha sua situação alterada para cancelada
	INSERT INTO #TABTEMP_REGISTROS_ALTERADOS (Id_Identificacao,tipo,NumConjTpDebito,NumConjReneg,NPossuiCotaUnica,IdTipoDebito)
	SELECT DISTINCT 
	Id_Identificacao = Case 
						   When IdProfissional is not null then IdProfissional 
						   When IdPessoaJuridica is not null then IdPessoaJuridica else IdPessoa end, 
	Tipo = CASE 
    						 When IdProfissional IS NOT NULL then 'PF'
    						 When IdPessoaJuridica IS NOT NULL then 'PJ' else 'PP' end,                      
	NumConjTpDebito,NumConjReneg,
	NPossuiCotaUnica = Case when IdSituacaoAtual in (9,12) then 1 else 0 end,
	IdTipoDebito
	FROM INSERTED 
	WHERE NumeroParcela = 0  AND
		 (NumConjTpDebito IS NOT NULL OR NumConjReneg IS NOT NULL) 

	-- Serão também tratados todos os registros cuja a parcela 0 tenha sido alterado para qualquer outro número
	IF Update(NumeroParcela) 
	Begin
		INSERT INTO #TABTEMP_REGISTROS_ALTERADOS (Id_Identificacao,tipo,NumConjTpDebito,NumConjReneg,NPossuiCotaUnica,IdTipoDebito)
		SELECT DISTINCT 
		Id_Identificacao = Case 
							   When t1.IdProfissional is not null then t1.IdProfissional 
							   When t1.IdPessoaJuridica is not null then t1.IdPessoaJuridica else t1.IdPessoa end, 
		Tipo = CASE 
    							 When t1.IdProfissional IS NOT NULL then 'PF'
    							 When t1.IdPessoaJuridica IS NOT NULL then 'PJ' else 'PP' end,                      
		t1.NumConjTpDebito,t1.NumConjReneg,
		NPossuiCotaUnica=1,
		t1.IdTipoDebito
		FROM inserted t1,
			 deleted t2 
		WHERE t1.iddebito = t2.IdDebito and 
			  t1.NumeroParcela <> 0 and t2.NumeroParcela = 0 AND
			 (t1.NumConjTpDebito IS NOT NULL OR t1.NumConjReneg IS NOT NULL) 
	End
	
	-- Serão também tratados todos os registros cuja a parcela 0 tenha sido excluída
	IF @Qtde_Inserted = 0 and @Qtde_Deleted > 0  
	Begin
		INSERT INTO #TABTEMP_REGISTROS_ALTERADOS (Id_Identificacao,tipo,NumConjTpDebito,NumConjReneg,NPossuiCotaUnica,IdTipoDebito)
		SELECT DISTINCT 
		Id_Identificacao = Case 
							   When IdProfissional is not null then IdProfissional 
							   When IdPessoaJuridica is not null then IdPessoaJuridica else IdPessoa end, 
		Tipo = CASE 
    						  When IdProfissional IS NOT NULL then 'PF'
    						  When IdPessoaJuridica IS NOT NULL then 'PJ' else 'PP' end,                      
		NumConjTpDebito,NumConjReneg,
		NPossuiCotaUnica=1,
		IdTipoDebito
		FROM DELETED 
		WHERE NumeroParcela = 0 AND
			 (NumConjTpDebito IS NOT NULL OR NumConjReneg IS NOT NULL) 
	
	End
End

IF @Executa = 0 
Begin

	-- Disabilita as trigger TrgLog_Debitos e Trg_Debitos_Usuario
	/*IF EXISTS (SELECT name FROM sysobjects WHERE name = 'TrgLog_Debitos' AND type = 'TR') 
	    alter table debitos disable trigger TrgLog_Debitos

	IF EXISTS (SELECT name FROM sysobjects WHERE name = 'Trg_Debitos_Usuario' AND type = 'TR') 
	   alter table debitos disable trigger Trg_Debitos_Usuario*/
	
	-- Tratamento para Pessoa Fisica
	IF	Exists (Select top 1 1 from #TABTEMP_REGISTROS_ALTERADOS WHERE tipo = 'PF')
	Begin
	
		-- Atualização de todos os registros exceto renegociação e recobrança
		UPDATE Debitos SET
			NPossuiCotaUnica = t1.NPossuiCotaUnica,
			ExecTriggerNPossuiCotaUnica = 0
		FROM #TABTEMP_REGISTROS_ALTERADOS t1,
			 Debitos t2
		WHERE t1.NumConjTpDebito IS NOT NULL and
			  t1.Id_Identificacao = t2.IdProfissional  and
			  t1.NumConjTpDebito = t2.NumConjTpDebito and
			  t2.IdTipoDebito NOT IN (2, 10) and
			  t1.IdTipoDebito NOT IN (2, 10) 
			  
		-- Atualização dos registros de renegociação e recobrança
		UPDATE Debitos SET
			NPossuiCotaUnica = t1.NPossuiCotaUnica,
			ExecTriggerNPossuiCotaUnica = 0
		FROM #TABTEMP_REGISTROS_ALTERADOS t1,
			 Debitos t2
		WHERE t1.NumConjReneg IS NOT NULL and
			  t1.Id_Identificacao = t2.IdProfissional  and
			  t1.NumConjReneg = t2.NumConjReneg and
			  t2.IdTipoDebito IN (2, 10) and
			  t1.IdTipoDebito IN (2, 10) 
	
	End     

	-- Tratamento para Pessoa Juridica
	IF Exists (Select top 1 1 from #TABTEMP_REGISTROS_ALTERADOS WHERE tipo = 'PJ')
	Begin
		-- Atualização de todos os registros exceto renegociação e recobrança
		UPDATE Debitos SET
			NPossuiCotaUnica = t1.NPossuiCotaUnica,
			ExecTriggerNPossuiCotaUnica = 0
		FROM #TABTEMP_REGISTROS_ALTERADOS t1,
			 Debitos t2
		WHERE t1.NumConjTpDebito IS NOT NULL and
			  t1.Id_Identificacao = t2.IdPessoaJuridica  and
			  t1.NumConjTpDebito = t2.NumConjTpDebito and
			  t2.IdTipoDebito NOT IN (2, 10) and
			  t1.IdTipoDebito NOT IN (2, 10)
			  
		-- Atualização dos registros de renegociação e recobrança
		UPDATE Debitos SET
			NPossuiCotaUnica= t1.NPossuiCotaUnica,
			ExecTriggerNPossuiCotaUnica = 0
		FROM #TABTEMP_REGISTROS_ALTERADOS t1,
			 Debitos t2
		WHERE t1.NumConjReneg IS NOT NULL and
			  t1.Id_Identificacao = t2.IdPessoaJuridica  and
			  t1.NumConjReneg = t2.NumConjReneg and
			  t2.IdTipoDebito IN (2, 10) and
			  t1.IdTipoDebito IN (2, 10) 
	End     

	-- Tratamento para Outras Pessoas  
	IF Exists (Select top 1 1 from #TABTEMP_REGISTROS_ALTERADOS WHERE tipo = 'PP')
	Begin
		-- Atualização de todos os registros exceto renegociação e recobrança
		UPDATE Debitos SET
			NPossuiCotaUnica = t1.NPossuiCotaUnica,
			ExecTriggerNPossuiCotaUnica = 0
		FROM #TABTEMP_REGISTROS_ALTERADOS t1,
			 Debitos t2
		WHERE t1.NumConjTpDebito IS NOT NULL and
			  t1.Id_Identificacao = t2.IdPessoa  and
			  t1.NumConjTpDebito = t2.NumConjTpDebito and
			  t2.IdTipoDebito NOT IN (2, 10) and
			  t1.IdTipoDebito NOT IN (2, 10)
			  
		-- Atualização dos registros de renegociação e recobrança
		UPDATE Debitos SET
			NPossuiCotaUnica = t1.NPossuiCotaUnica,
			ExecTriggerNPossuiCotaUnica = 0
		FROM #TABTEMP_REGISTROS_ALTERADOS t1,
			 Debitos t2
		WHERE t1.NumConjReneg IS NOT NULL and
			  t1.Id_Identificacao = t2.IdPessoa  and
			  t1.NumConjReneg = t2.NumConjReneg and
			  t2.IdTipoDebito IN (2, 10) and
			  t1.IdTipoDebito IN (2, 10)
			  
			  
	End     

	-- Reabilita as trigger TrgLog_Debitos e Trg_Debitos_Usuario
	/*	IF EXISTS (SELECT name FROM sysobjects WHERE name = 'TrgLog_Debitos' AND type = 'TR') 
			alter table debitos enable trigger TrgLog_Debitos
			
		IF EXISTS (SELECT name FROM sysobjects WHERE name = 'Trg_Debitos_Usuario' AND type = 'TR') 
			alter table debitos enable trigger Trg_Debitos_Usuario*/
End 


GO


/*Alterada pelo Nelson em 15/07/2011 - Ocorr. 79704*/

CREATE TRIGGER [dbo].[Trg_Debitos_Usuario] ON [dbo].[Debitos] FOR INSERT, UPDATE
AS
--
DECLARE @IdDebito integer
DECLARE @Depto    varchar(60)
DECLARE @RegistraLogI integer
DECLARE @RegistraLogD integer

/* Recupera informações do débito */
SELECT @IdDebito = IdDebito,
       @RegistraLogI = RegistraLog 
  FROM inserted
  
/* Recupera informações de log */  
SELECT @RegistraLogD = RegistraLog 
  FROM deleted      

/* Loga alterações */
IF /*(@IdDebito > 0) AND*/(@RegistraLogI = 1)  AND (@RegistraLogD IS NULL OR @RegistraLogD = 1)
BEGIN
	
	/* Recupera departamento */
	SELECT @Depto = NomeDepto
		FROM Departamentos
				 INNER JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
	 WHERE NomeUsuario = host_name()

	/* Loga alteração do débito */
	UPDATE Debitos SET
				DataUltimaAtualizacao = GetDate(),
				UsuarioUltimaAtualizacao = host_name(),
				DepartamentoUltimaAtualizacao = @Depto,
				RegistraLog = 1
	WHERE IdDebito IN (SELECT t1.IdDebito from inserted t1)  
END 
