CREATE TABLE [dbo].[Configuracoes] (
    [SeparadorExportacaotxt]                 VARCHAR (5)    NULL,
    [AgrupaCredito]                          BIT            NOT NULL,
    [ReceitaUnitaria]                        BIT            NOT NULL,
    [DigitosGrupo]                           INT            NOT NULL,
    [UnidadeNivel1]                          INT            NOT NULL,
    [UnidadeNivel2]                          INT            NOT NULL,
    [UnidadeNivel3]                          INT            NOT NULL,
    [PrefixoOC]                              VARCHAR (6)    NULL,
    [SufixoOC]                               VARCHAR (6)    NULL,
    [IncrementoOC]                           INT            NOT NULL,
    [PrefixoOS]                              VARCHAR (6)    NULL,
    [SufixoOS]                               VARCHAR (6)    NULL,
    [IncrementoOS]                           INT            NOT NULL,
    [PrefixoCS]                              VARCHAR (6)    NULL,
    [SufixoCS]                               VARCHAR (6)    NULL,
    [IncrementoCS]                           INT            NOT NULL,
    [PrefixoContrato]                        VARCHAR (6)    NULL,
    [SufixoContrato]                         VARCHAR (6)    NULL,
    [IncrementoContrato]                     INT            NOT NULL,
    [PrefixoLicitacao]                       VARCHAR (6)    NULL,
    [SufixoLicitacao]                        VARCHAR (6)    NULL,
    [IncrementoLicitacao]                    INT            NOT NULL,
    [PrefixoBemMovel]                        VARCHAR (6)    NULL,
    [SufixoBemMovel]                         VARCHAR (6)    NULL,
    [IncrementoBemMovel]                     INT            NOT NULL,
    [PrefixoBemImovel]                       VARCHAR (6)    NULL,
    [SufixoBemImovel]                        VARCHAR (6)    NULL,
    [IncrementoBemImovel]                    INT            NOT NULL,
    [ServidorCotacao]                        VARCHAR (100)  NULL,
    [UsuarioCotacao]                         VARCHAR (100)  NULL,
    [SenhaCotacao]                           VARCHAR (100)  NULL,
    [HostCotacao]                            VARCHAR (30)   NULL,
    [PortaCotacao]                           VARCHAR (3)    NULL,
    [EmailCotacao]                           VARCHAR (50)   NULL,
    [LinkCotacao]                            VARCHAR (50)   NULL,
    [CodigoBarraAutomatico]                  BIT            NOT NULL,
    [PrefixoCodigoBarra]                     CHAR (1)       NULL,
    [SufixoCodigoBarra]                      CHAR (1)       NULL,
    [TerminadorCodigoBarra]                  CHAR (1)       NULL,
    [SeparadorCampos]                        CHAR (1)       NULL,
    [FormatoData]                            VARCHAR (10)   NULL,
    [DiretorioArquivos]                      VARCHAR (50)   NULL,
    [SeparadorData]                          CHAR (1)       NULL,
    [OrcamentoCCustoporConta]                BIT            NOT NULL,
    [TextoSup]                               TEXT           NULL,
    [TextoInf]                               TEXT           NULL,
    [HistoricoCusto]                         TEXT           NULL,
    [PrefixoCertificacao]                    VARCHAR (5)    NULL,
    [PrefixoItem]                            VARCHAR (20)   NULL,
    [SufixoItem]                             VARCHAR (20)   NULL,
    [IncrementoItem]                         INT            NOT NULL,
    [TransferePagamentos]                    BIT            NOT NULL,
    [TransfereRecebimentos]                  BIT            NOT NULL,
    [TransfereRestos]                        BIT            NOT NULL,
    [DataContabilInicial]                    DATETIME       NULL,
    [DataContabilFinal]                      DATETIME       NULL,
    [ImprimeSaldo]                           BIT            NOT NULL,
    [SaldoObrigatorio]                       BIT            NOT NULL,
    [PreEmpenho]                             BIT            NOT NULL,
    [MostraRestos]                           BIT            NOT NULL,
    [MostraDadosBanco]                       BIT            NOT NULL,
    [TituloNota]                             VARCHAR (30)   NULL,
    [TituloBaixa]                            VARCHAR (30)   NULL,
    [Controlar]                              VARCHAR (12)   NULL,
    [NomePersonalizado]                      VARCHAR (20)   NULL,
    [IdTipoPagamentoFolha]                   INT            NULL,
    [PermitePagamentoAvulso]                 BIT            NOT NULL,
    [TransfereMovimentosFinanceiros]         BIT            NOT NULL,
    [Endereco]                               TEXT           NULL,
    [ImprimeEndereco]                        BIT            NOT NULL,
    [DataContabilizacaoPagamento]            DATETIME       NULL,
    [DataContabilizacaoReceita]              DATETIME       NULL,
    [DataContabilizacaoRestos]               DATETIME       NULL,
    [DataContabilizacaoFinanceiro]           DATETIME       NULL,
    [CriaCentroCustoEmpenho]                 BIT            NULL,
    [CalcularCustoReceitaAntes]              BIT            NOT NULL,
    [IdTipoPagamentoReceita]                 INT            NULL,
    [UsaCustoFixoVariado]                    BIT            NULL,
    [PathUpdate]                             VARCHAR (250)  NULL,
    [PathArquivos]                           VARCHAR (250)  NULL,
    [TravamentoCCustoPagamento]              BIT            NOT NULL,
    [MostaCentroCustoNotaOrcamentaria]       BIT            NULL,
    [AtestoNotaOrcamentaria]                 TEXT           NULL,
    [ServidorSiscafWeb]                      VARCHAR (50)   NULL,
    [UsuarioSiscafWeb]                       VARCHAR (30)   NULL,
    [SenhaSiscafWeb]                         VARCHAR (20)   NULL,
    [IdTipoMovimentoFolha]                   INT            NULL,
    [IdPessoaMovimentoFolha]                 INT            NULL,
    [VersaoBanco]                            INT            NULL,
    [PathBackup]                             VARCHAR (255)  NULL,
    [AgendamentoBackup]                      VARCHAR (50)   NULL,
    [UltimaExecucaoAgBackup]                 DATETIME       NULL,
    [PathAuditoria]                          VARCHAR (255)  NULL,
    [AgendamentoAuditoria]                   VARCHAR (50)   NULL,
    [UltimaExecucaoAgAuditoria]              DATETIME       NULL,
    [AlteraHistorico]                        BIT            NULL,
    [MostraDataImpressaoBaixaPag]            BIT            NULL,
    [Servidor]                               VARCHAR (15)   NULL,
    [IdUsuario]                              INT            NULL,
    [AplicarRepasse]                         BIT            NULL,
    [CriaPagamentoRepasseRec]                BIT            NULL,
    [IdTipoPagamentoRepasse]                 INT            NULL,
    [AgrupaCreditoSipro]                     INT            NULL,
    [AgrupaPagamentoCusto]                   BIT            NULL,
    [MostraOcorrencia]                       BIT            NULL,
    [IntegraSiproAgenda]                     BIT            NULL,
    [TransfContasPagar]                      BIT            NULL,
    [TransfContasReceber]                    BIT            NULL,
    [TransfMovimentoFinanceiro]              BIT            NULL,
    [MostraLancSiscontwFluxoCaixa]           BIT            NULL,
    [ImagemConselho]                         IMAGE          NULL,
    [ImagemBanco]                            IMAGE          NULL,
    [ExibeImagensRelacaoCredito]             BIT            CONSTRAINT [DF__Configura__Exibe__32F66B4F] DEFAULT ((0)) NOT NULL,
    [NumeroControleDRISS]                    INT            NULL,
    [PathUpdateViaLogon]                     VARCHAR (200)  NULL,
    [AcessoCC]                               VARCHAR (20)   NULL,
    [DataAcessoCC]                           VARCHAR (20)   NULL,
    [DataLimiteCC]                           VARCHAR (20)   NULL,
    [MostrarFavorecidoCustoReceita]          BIT            CONSTRAINT [DF__configura__Mostr__2E86BBED] DEFAULT ((0)) NULL,
    [IdPessoaFavorecido]                     INT            NULL,
    [MostraVlBaseImpImpressaoBaixaPag]       BIT            NOT NULL,
    [QtdeUsuariosTransferidos]               INT            NULL,
    [ImpressaoFrenteVerso]                   BIT            NULL,
    [Eventual]                               INT            NULL,
    [DataTransfContasPagar]                  DATETIME       NULL,
    [DataTransfContasReceber]                DATETIME       NULL,
    [DataTransfMovimentoFinanceiro]          DATETIME       NULL,
    [DES]                                    BIT            CONSTRAINT [DF__Configuraco__DES__10A1534B] DEFAULT ((0)) NULL,
    [PrevRecolhimentoTributo]                BIT            CONSTRAINT [DF__Configura__PrevR__1471E42F] DEFAULT ((0)) NULL,
    [PathArquivosExportacao]                 VARCHAR (250)  NULL,
    [UtilizaRelacaoCredNumerada]             BIT            CONSTRAINT [DF__Configura__Utili__1EA559DF] DEFAULT ((0)) NULL,
    [PrefixoRC]                              VARCHAR (6)    NULL,
    [SufixoRC]                               VARCHAR (6)    NULL,
    [IncrementoRC]                           INT            NULL,
    [UtilizaRelacaoCredNumeradaProcesso]     BIT            CONSTRAINT [DF__Configura__Utili__1D897A79] DEFAULT ((0)) NULL,
    [CobrancaCompartilhadaDefaultReceita]    BIT            CONSTRAINT [DF__Configura__Cobra__3284975F] DEFAULT ((1)) NOT NULL,
    [IdPessoaTransferenciaReceita]           INT            NULL,
    [IdTipoPagamentoTransferenciaReceita]    INT            NULL,
    [IdTipoMovimentoFinanceiroTransfReceita] INT            NULL,
    [TextoRodape]                            TEXT           NULL,
    [Logomarca]                              IMAGE          NULL,
    [IdPessoaPrestacao]                      INT            NULL,
    [IdTipoPagPrestacao]                     INT            NULL,
    [IdTipoMovFinPrestacao]                  INT            NULL,
    [CFPS]                                   BIT            NULL,
    [DataAlteracaoLancFinanceiroInicial]     DATETIME       NULL,
    [DataAlteracaoLancFinanceiroFinal]       DATETIME       NULL,
    [IdEstadoConservacaoPadrao]              INT            NULL,
    [ServidorEmail]                          VARCHAR (60)   NULL,
    [PortaEmail]                             INT            NULL,
    [UsuarioEmail]                           VARCHAR (100)  NULL,
    [SenhaEmail]                             VARCHAR (30)   NULL,
    [AssinaturaRCredito1]                    VARCHAR (400)  NULL,
    [AssinaturaRCredito2]                    VARCHAR (400)  NULL,
    [AssinaturaRCredito3]                    VARCHAR (400)  NULL,
    [AssinaturaRCredito4]                    VARCHAR (400)  NULL,
    [IncluirHistEmpenho]                     BIT            CONSTRAINT [DF__Configura__Inclu__73E21D7A] DEFAULT ((0)) NULL,
    [DataLimiteProcesso]                     VARCHAR (20)   NULL,
    [DataAcessoProcesso]                     VARCHAR (20)   NULL,
    [AcessoProcesso]                         VARCHAR (20)   NULL,
    [DataLimiteFiscalizacao]                 VARCHAR (20)   NULL,
    [DataAcessoFiscalizacao]                 VARCHAR (20)   NULL,
    [AcessoFiscalizacao]                     VARCHAR (20)   NULL,
    [imprimeDataHoraRel]                     BIT            NULL,
    [PathArquivosSG]                         VARCHAR (250)  NULL,
    [IdTipoMovFinRecRealizar]                INT            NULL,
    [IdTipoPgtoRecRealizar]                  INT            NULL,
    [IdPessoaRecRealizar]                    INT            NULL,
    [IdTipoMovFinRecRealizarCartao]          INT            NULL,
    [UsuarioEmailCotacao]                    VARCHAR (100)  NULL,
    [SenhaEmailCotacao]                      VARCHAR (150)  NULL,
    [ServidorRequerAutenticacao]             BIT            NULL,
    [CPFCNPJObrigatorio]                     BIT            NULL,
    [DataCriaUsuarioSql]                     DATETIME       NULL,
    [HistoricoCustoRecRealiz]                TEXT           NULL,
    [IdTipoPagamentoRecRealiz]               INT            NULL,
    [IdPessoaFavorecidoRecRealiz]            INT            NULL,
    [ManterArquivoRetorno]                   BIT            NULL,
    [ExibirLogoReduzidoNoCabecalho]          BIT            NULL,
    [LogomarcaReduzidaRelatorios]            IMAGE          NULL,
    [ExibirApenasLogoNoCabecalho]            BIT            NULL,
    [AtualizaMovimentoFolha]                 BIT            NULL,
    [AtualizaPagamentoFolha]                 BIT            NULL,
    [AtualizaPrevReceita]                    BIT            NULL,
    [ExibirObjetoSocialCRC]                  BIT            NULL,
    [TextoRodapeCRC]                         TEXT           NULL,
    [UtilizaRodapePadraoCRC]                 BIT            NULL,
    [IdsContaDespesaPessoal]                 TEXT           NULL,
    [IdCCCustoReceita]                       INT            NULL,
    [IdCCCustoRepasseReceita]                INT            NULL,
    [IdContaCustodia]                        INT            NULL,
    [IdContaTransfReceita]                   INT            NULL,
    [IdContaDevolucaoRecARealizar]           INT            NULL,
    [IdContaCreditoAnulacaoRP]               INT            NULL,
    [IdContaDebitoPatAnulacaoRP]             INT            NULL,
    [IdContaCreditoPatAnulacaoRP]            INT            NULL,
    [NomeBanco]                              VARCHAR (200)  NULL,
    [LogExterno]                             INT            NULL,
    [ExibeLogoCantoEsquerdo]                 BIT            NULL,
    [UtilizaLogoRelatoriosSISCONT]           BIT            NULL,
    [ExibirLogoNotasEmpenhoSIPRO]            BIT            NULL,
    [BandejaImpEmpenho]                      VARCHAR (25)   NULL,
    [BandejaImpPreEmpenho]                   VARCHAR (25)   NULL,
    [VisualizarImpEmpenho]                   BIT            NULL,
    [ParametroImpFrenteVerso]                INT            NULL,
    [Assinatura1ADR]                         TEXT           NULL,
    [Assinatura2ADR]                         TEXT           NULL,
    [Assinatura3ADR]                         TEXT           NULL,
    [Assinatura4ADR]                         TEXT           NULL,
    [PrefixoPDR]                             VARCHAR (6)    NULL,
    [SufixoPDR]                              VARCHAR (6)    NULL,
    [IncrementoPDR]                          INT            NULL,
    [PrefixoDDR]                             VARCHAR (6)    NULL,
    [SufixoDDR]                              VARCHAR (6)    NULL,
    [IncrementoDDR]                          INT            NULL,
    [TributaImportacao]                      BIT            DEFAULT ((0)) NULL,
    [BloquearAjustesPessoasSiproSG]          BIT            NULL,
    [BloquearPessoasSiproSG]                 BIT            NULL,
    [EmailCopiaSG]                           VARCHAR (1000) NULL,
    [EmailAutenticaSSL]                      BIT            DEFAULT ((0)) NOT NULL,
    [UtilizaPagamentoAssociacoes]            BIT            NULL,
    [PrestacaoContasFavorecidoDoEmpenho]     BIT            CONSTRAINT [DF_ConfiguracoesSG_PrestacaoContasFavorecidoDoEmpenho] DEFAULT ((1)) NOT NULL,
    [IncluirHistRestosEmpenho]               BIT            NULL,
    [ServidorFTP]                            VARCHAR (100)  NULL,
    [UsuarioFTP]                             VARCHAR (30)   NULL,
    [SenhaFTP]                               VARCHAR (30)   NULL,
    [PastaFTP]                               VARCHAR (50)   NULL,
    [UtilizaAlertaCertificacao]              BIT            DEFAULT ((0)) NOT NULL,
    [EmailOrigem]                            VARCHAR (150)  NULL,
    [UsaAutorizacaoImpressao]                BIT            NULL,
    [EmailAutorizacaoImpressao]              VARCHAR (50)   NULL,
    [URLSAD]                                 VARCHAR (250)  NULL,
    [PCEnderecoWSDL]                         VARCHAR (400)  NULL,
    [TempoAtualizacaoMSG]                    INT            DEFAULT ((3)) NULL,
    [LiqEnderecoWSDL]                        VARCHAR (400)  NULL,
    [LancEnderecoWSDL]                       VARCHAR (400)  NULL,
    [ImportaFolhaCentroCusto11Char]          BIT            NULL,
    [ServidorRequerAutenticacaoSSL]          BIT            DEFAULT ((0)) NOT NULL,
    [InicializarMSGcomWindows]               BIT            DEFAULT ((0)) NOT NULL,
    [ScriptLogExecutado]                     BIT            DEFAULT ((0)) NOT NULL,
    [EnderecoHttpSiscafweb]                  VARCHAR (500)  NULL,
    [TipoCliente]                            VARCHAR (100)  CONSTRAINT [DEF_Configuracoes_TipoCliente] DEFAULT ('0,1') NOT NULL,
    [BoletimCaixaHistoricoPadrao]            TEXT           NULL,
    [BoletimCaixaAssinatura1]                VARCHAR (1000) NULL,
    [BoletimCaixaAssinatura2]                VARCHAR (1000) NULL,
    [BoletimCaixaAssinatura3]                VARCHAR (1000) NULL,
    [BoletimCaixaAssinatura4]                VARCHAR (1000) NULL,
    [AlertaBackup]                           BIT            CONSTRAINT [DF_Configuracoes_AlertaBackup] DEFAULT ((1)) NOT NULL,
    [DataAlertaBackup]                       DATETIME       NULL,
    [ServidorEmailUsLogon]                   VARCHAR (60)   NULL,
    [PortaEmailUsLogon]                      INT            NULL,
    [UsuarioEmailUsLogon]                    VARCHAR (100)  NULL,
    [SenhaEmailUsLogon]                      VARCHAR (30)   NULL,
    [EmailAutenticaSSLUsLogon]               BIT            CONSTRAINT [DF_Configuracoes_EmailAutenticaSSLUsLogon] DEFAULT ((0)) NOT NULL,
    [ScriptCEPExecutado]                     BIT            DEFAULT ((0)) NOT NULL,
    [EmailAuthenticationMethod]              TINYINT        NULL,
    [EnvioEmailLimiteQtd]                    SMALLINT       NULL,
    [EnvioEmailLimiteTempo]                  DATETIME       NULL,
    CONSTRAINT [FK_Configuracoes_Pessoas_IdPessoaRecRealizar] FOREIGN KEY ([IdPessoaRecRealizar]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Configuracoes_TiposMovimentoFinanceiro_IdTipoMovFinRecRealizar] FOREIGN KEY ([IdTipoMovFinRecRealizar]) REFERENCES [dbo].[TiposMovimentoFinanceiro] ([IdTipoMovimentoFinanceiro]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Configuracoes_TiposMovimentoFinanceiro_IdTipoMovFinRecRealizarCartao] FOREIGN KEY ([IdTipoMovFinRecRealizarCartao]) REFERENCES [dbo].[TiposMovimentoFinanceiro] ([IdTipoMovimentoFinanceiro]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Configuracoes_TiposPagamentos] FOREIGN KEY ([IdTipoPagamentoFolha]) REFERENCES [dbo].[TiposPagamentos] ([IdTipoPagamento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Configuracoes_TiposPagamentos_IdTipoPgtoRecRealizar] FOREIGN KEY ([IdTipoPgtoRecRealizar]) REFERENCES [dbo].[TiposPagamentos] ([IdTipoPagamento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Configuracoes_TiposPagamentos1] FOREIGN KEY ([IdTipoPagamentoRepasse]) REFERENCES [dbo].[TiposPagamentos] ([IdTipoPagamento]),
    CONSTRAINT [FK_ConfiguracoesIdPessoaFavorecidoRecRealiz_Pessoas] FOREIGN KEY ([IdPessoaFavorecidoRecRealiz]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_ConfiguracoesIdTipoPagamentoRecRealiz_TiposPagamentos] FOREIGN KEY ([IdTipoPagamentoRecRealiz]) REFERENCES [dbo].[TiposPagamentos] ([IdTipoPagamento])
);


GO
CREATE TRIGGER [TrgLog_Configuracoes] ON [Implanta_CRPAM].[dbo].[Configuracoes] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'Configuracoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'SeparadorExportacaotxt : «' + RTRIM( ISNULL( CAST (SeparadorExportacaotxt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaCredito IS NULL THEN ' AgrupaCredito : «Nulo» '
                                              WHEN  AgrupaCredito = 0 THEN ' AgrupaCredito : «Falso» '
                                              WHEN  AgrupaCredito = 1 THEN ' AgrupaCredito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReceitaUnitaria IS NULL THEN ' ReceitaUnitaria : «Nulo» '
                                              WHEN  ReceitaUnitaria = 0 THEN ' ReceitaUnitaria : «Falso» '
                                              WHEN  ReceitaUnitaria = 1 THEN ' ReceitaUnitaria : «Verdadeiro» '
                                    END 
                         + '| DigitosGrupo : «' + RTRIM( ISNULL( CAST (DigitosGrupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel1 : «' + RTRIM( ISNULL( CAST (UnidadeNivel1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel2 : «' + RTRIM( ISNULL( CAST (UnidadeNivel2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel3 : «' + RTRIM( ISNULL( CAST (UnidadeNivel3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoOC : «' + RTRIM( ISNULL( CAST (PrefixoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoOC : «' + RTRIM( ISNULL( CAST (SufixoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoOC : «' + RTRIM( ISNULL( CAST (IncrementoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoOS : «' + RTRIM( ISNULL( CAST (PrefixoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoOS : «' + RTRIM( ISNULL( CAST (SufixoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoOS : «' + RTRIM( ISNULL( CAST (IncrementoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoCS : «' + RTRIM( ISNULL( CAST (PrefixoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoCS : «' + RTRIM( ISNULL( CAST (SufixoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoCS : «' + RTRIM( ISNULL( CAST (IncrementoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoContrato : «' + RTRIM( ISNULL( CAST (PrefixoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoContrato : «' + RTRIM( ISNULL( CAST (SufixoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoContrato : «' + RTRIM( ISNULL( CAST (IncrementoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoLicitacao : «' + RTRIM( ISNULL( CAST (PrefixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoLicitacao : «' + RTRIM( ISNULL( CAST (SufixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoLicitacao : «' + RTRIM( ISNULL( CAST (IncrementoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoBemMovel : «' + RTRIM( ISNULL( CAST (PrefixoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoBemMovel : «' + RTRIM( ISNULL( CAST (SufixoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoBemMovel : «' + RTRIM( ISNULL( CAST (IncrementoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoBemImovel : «' + RTRIM( ISNULL( CAST (PrefixoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoBemImovel : «' + RTRIM( ISNULL( CAST (SufixoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoBemImovel : «' + RTRIM( ISNULL( CAST (IncrementoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorCotacao : «' + RTRIM( ISNULL( CAST (ServidorCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioCotacao : «' + RTRIM( ISNULL( CAST (UsuarioCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaCotacao : «' + RTRIM( ISNULL( CAST (SenhaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostCotacao : «' + RTRIM( ISNULL( CAST (HostCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaCotacao : «' + RTRIM( ISNULL( CAST (PortaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCotacao : «' + RTRIM( ISNULL( CAST (EmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinkCotacao : «' + RTRIM( ISNULL( CAST (LinkCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CodigoBarraAutomatico IS NULL THEN ' CodigoBarraAutomatico : «Nulo» '
                                              WHEN  CodigoBarraAutomatico = 0 THEN ' CodigoBarraAutomatico : «Falso» '
                                              WHEN  CodigoBarraAutomatico = 1 THEN ' CodigoBarraAutomatico : «Verdadeiro» '
                                    END 
                         + '| PrefixoCodigoBarra : «' + RTRIM( ISNULL( CAST (PrefixoCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoCodigoBarra : «' + RTRIM( ISNULL( CAST (SufixoCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TerminadorCodigoBarra : «' + RTRIM( ISNULL( CAST (TerminadorCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeparadorCampos : «' + RTRIM( ISNULL( CAST (SeparadorCampos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormatoData : «' + RTRIM( ISNULL( CAST (FormatoData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiretorioArquivos : «' + RTRIM( ISNULL( CAST (DiretorioArquivos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeparadorData : «' + RTRIM( ISNULL( CAST (SeparadorData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OrcamentoCCustoporConta IS NULL THEN ' OrcamentoCCustoporConta : «Nulo» '
                                              WHEN  OrcamentoCCustoporConta = 0 THEN ' OrcamentoCCustoporConta : «Falso» '
                                              WHEN  OrcamentoCCustoporConta = 1 THEN ' OrcamentoCCustoporConta : «Verdadeiro» '
                                    END 
                         + '| PrefixoCertificacao : «' + RTRIM( ISNULL( CAST (PrefixoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoItem : «' + RTRIM( ISNULL( CAST (PrefixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoItem : «' + RTRIM( ISNULL( CAST (SufixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoItem : «' + RTRIM( ISNULL( CAST (IncrementoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TransferePagamentos IS NULL THEN ' TransferePagamentos : «Nulo» '
                                              WHEN  TransferePagamentos = 0 THEN ' TransferePagamentos : «Falso» '
                                              WHEN  TransferePagamentos = 1 THEN ' TransferePagamentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereRecebimentos IS NULL THEN ' TransfereRecebimentos : «Nulo» '
                                              WHEN  TransfereRecebimentos = 0 THEN ' TransfereRecebimentos : «Falso» '
                                              WHEN  TransfereRecebimentos = 1 THEN ' TransfereRecebimentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereRestos IS NULL THEN ' TransfereRestos : «Nulo» '
                                              WHEN  TransfereRestos = 0 THEN ' TransfereRestos : «Falso» '
                                              WHEN  TransfereRestos = 1 THEN ' TransfereRestos : «Verdadeiro» '
                                    END 
                         + '| DataContabilInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilInicial, 113 ),'Nulo'))+'» '
                         + '| DataContabilFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilFinal, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeSaldo IS NULL THEN ' ImprimeSaldo : «Nulo» '
                                              WHEN  ImprimeSaldo = 0 THEN ' ImprimeSaldo : «Falso» '
                                              WHEN  ImprimeSaldo = 1 THEN ' ImprimeSaldo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SaldoObrigatorio IS NULL THEN ' SaldoObrigatorio : «Nulo» '
                                              WHEN  SaldoObrigatorio = 0 THEN ' SaldoObrigatorio : «Falso» '
                                              WHEN  SaldoObrigatorio = 1 THEN ' SaldoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PreEmpenho IS NULL THEN ' PreEmpenho : «Nulo» '
                                              WHEN  PreEmpenho = 0 THEN ' PreEmpenho : «Falso» '
                                              WHEN  PreEmpenho = 1 THEN ' PreEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraRestos IS NULL THEN ' MostraRestos : «Nulo» '
                                              WHEN  MostraRestos = 0 THEN ' MostraRestos : «Falso» '
                                              WHEN  MostraRestos = 1 THEN ' MostraRestos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraDadosBanco IS NULL THEN ' MostraDadosBanco : «Nulo» '
                                              WHEN  MostraDadosBanco = 0 THEN ' MostraDadosBanco : «Falso» '
                                              WHEN  MostraDadosBanco = 1 THEN ' MostraDadosBanco : «Verdadeiro» '
                                    END 
                         + '| TituloNota : «' + RTRIM( ISNULL( CAST (TituloNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloBaixa : «' + RTRIM( ISNULL( CAST (TituloBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Controlar : «' + RTRIM( ISNULL( CAST (Controlar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamentoFolha : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoAvulso IS NULL THEN ' PermitePagamentoAvulso : «Nulo» '
                                              WHEN  PermitePagamentoAvulso = 0 THEN ' PermitePagamentoAvulso : «Falso» '
                                              WHEN  PermitePagamentoAvulso = 1 THEN ' PermitePagamentoAvulso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereMovimentosFinanceiros IS NULL THEN ' TransfereMovimentosFinanceiros : «Nulo» '
                                              WHEN  TransfereMovimentosFinanceiros = 0 THEN ' TransfereMovimentosFinanceiros : «Falso» '
                                              WHEN  TransfereMovimentosFinanceiros = 1 THEN ' TransfereMovimentosFinanceiros : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeEndereco IS NULL THEN ' ImprimeEndereco : «Nulo» '
                                              WHEN  ImprimeEndereco = 0 THEN ' ImprimeEndereco : «Falso» '
                                              WHEN  ImprimeEndereco = 1 THEN ' ImprimeEndereco : «Verdadeiro» '
                                    END 
                         + '| DataContabilizacaoPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPagamento, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoReceita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoReceita, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoRestos : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoRestos, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CriaCentroCustoEmpenho IS NULL THEN ' CriaCentroCustoEmpenho : «Nulo» '
                                              WHEN  CriaCentroCustoEmpenho = 0 THEN ' CriaCentroCustoEmpenho : «Falso» '
                                              WHEN  CriaCentroCustoEmpenho = 1 THEN ' CriaCentroCustoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CalcularCustoReceitaAntes IS NULL THEN ' CalcularCustoReceitaAntes : «Nulo» '
                                              WHEN  CalcularCustoReceitaAntes = 0 THEN ' CalcularCustoReceitaAntes : «Falso» '
                                              WHEN  CalcularCustoReceitaAntes = 1 THEN ' CalcularCustoReceitaAntes : «Verdadeiro» '
                                    END 
                         + '| IdTipoPagamentoReceita : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaCustoFixoVariado IS NULL THEN ' UsaCustoFixoVariado : «Nulo» '
                                              WHEN  UsaCustoFixoVariado = 0 THEN ' UsaCustoFixoVariado : «Falso» '
                                              WHEN  UsaCustoFixoVariado = 1 THEN ' UsaCustoFixoVariado : «Verdadeiro» '
                                    END 
                         + '| PathUpdate : «' + RTRIM( ISNULL( CAST (PathUpdate AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathArquivos : «' + RTRIM( ISNULL( CAST (PathArquivos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPagamento IS NULL THEN ' TravamentoCCustoPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoPagamento = 0 THEN ' TravamentoCCustoPagamento : «Falso» '
                                              WHEN  TravamentoCCustoPagamento = 1 THEN ' TravamentoCCustoPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostaCentroCustoNotaOrcamentaria IS NULL THEN ' MostaCentroCustoNotaOrcamentaria : «Nulo» '
                                              WHEN  MostaCentroCustoNotaOrcamentaria = 0 THEN ' MostaCentroCustoNotaOrcamentaria : «Falso» '
                                              WHEN  MostaCentroCustoNotaOrcamentaria = 1 THEN ' MostaCentroCustoNotaOrcamentaria : «Verdadeiro» '
                                    END 
                         + '| ServidorSiscafWeb : «' + RTRIM( ISNULL( CAST (ServidorSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioSiscafWeb : «' + RTRIM( ISNULL( CAST (UsuarioSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaSiscafWeb : «' + RTRIM( ISNULL( CAST (SenhaSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFolha : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaMovimentoFolha : «' + RTRIM( ISNULL( CAST (IdPessoaMovimentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoBanco : «' + RTRIM( ISNULL( CAST (VersaoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathBackup : «' + RTRIM( ISNULL( CAST (PathBackup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgendamentoBackup : «' + RTRIM( ISNULL( CAST (AgendamentoBackup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaExecucaoAgBackup : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaExecucaoAgBackup, 113 ),'Nulo'))+'» '
                         + '| PathAuditoria : «' + RTRIM( ISNULL( CAST (PathAuditoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgendamentoAuditoria : «' + RTRIM( ISNULL( CAST (AgendamentoAuditoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaExecucaoAgAuditoria : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaExecucaoAgAuditoria, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraHistorico IS NULL THEN ' AlteraHistorico : «Nulo» '
                                              WHEN  AlteraHistorico = 0 THEN ' AlteraHistorico : «Falso» '
                                              WHEN  AlteraHistorico = 1 THEN ' AlteraHistorico : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraDataImpressaoBaixaPag IS NULL THEN ' MostraDataImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraDataImpressaoBaixaPag = 0 THEN ' MostraDataImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraDataImpressaoBaixaPag = 1 THEN ' MostraDataImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarRepasse IS NULL THEN ' AplicarRepasse : «Nulo» '
                                              WHEN  AplicarRepasse = 0 THEN ' AplicarRepasse : «Falso» '
                                              WHEN  AplicarRepasse = 1 THEN ' AplicarRepasse : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CriaPagamentoRepasseRec IS NULL THEN ' CriaPagamentoRepasseRec : «Nulo» '
                                              WHEN  CriaPagamentoRepasseRec = 0 THEN ' CriaPagamentoRepasseRec : «Falso» '
                                              WHEN  CriaPagamentoRepasseRec = 1 THEN ' CriaPagamentoRepasseRec : «Verdadeiro» '
                                    END 
                         + '| IdTipoPagamentoRepasse : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgrupaCreditoSipro : «' + RTRIM( ISNULL( CAST (AgrupaCreditoSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaPagamentoCusto IS NULL THEN ' AgrupaPagamentoCusto : «Nulo» '
                                              WHEN  AgrupaPagamentoCusto = 0 THEN ' AgrupaPagamentoCusto : «Falso» '
                                              WHEN  AgrupaPagamentoCusto = 1 THEN ' AgrupaPagamentoCusto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraOcorrencia IS NULL THEN ' MostraOcorrencia : «Nulo» '
                                              WHEN  MostraOcorrencia = 0 THEN ' MostraOcorrencia : «Falso» '
                                              WHEN  MostraOcorrencia = 1 THEN ' MostraOcorrencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IntegraSiproAgenda IS NULL THEN ' IntegraSiproAgenda : «Nulo» '
                                              WHEN  IntegraSiproAgenda = 0 THEN ' IntegraSiproAgenda : «Falso» '
                                              WHEN  IntegraSiproAgenda = 1 THEN ' IntegraSiproAgenda : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfContasPagar IS NULL THEN ' TransfContasPagar : «Nulo» '
                                              WHEN  TransfContasPagar = 0 THEN ' TransfContasPagar : «Falso» '
                                              WHEN  TransfContasPagar = 1 THEN ' TransfContasPagar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfContasReceber IS NULL THEN ' TransfContasReceber : «Nulo» '
                                              WHEN  TransfContasReceber = 0 THEN ' TransfContasReceber : «Falso» '
                                              WHEN  TransfContasReceber = 1 THEN ' TransfContasReceber : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfMovimentoFinanceiro IS NULL THEN ' TransfMovimentoFinanceiro : «Nulo» '
                                              WHEN  TransfMovimentoFinanceiro = 0 THEN ' TransfMovimentoFinanceiro : «Falso» '
                                              WHEN  TransfMovimentoFinanceiro = 1 THEN ' TransfMovimentoFinanceiro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraLancSiscontwFluxoCaixa IS NULL THEN ' MostraLancSiscontwFluxoCaixa : «Nulo» '
                                              WHEN  MostraLancSiscontwFluxoCaixa = 0 THEN ' MostraLancSiscontwFluxoCaixa : «Falso» '
                                              WHEN  MostraLancSiscontwFluxoCaixa = 1 THEN ' MostraLancSiscontwFluxoCaixa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeImagensRelacaoCredito IS NULL THEN ' ExibeImagensRelacaoCredito : «Nulo» '
                                              WHEN  ExibeImagensRelacaoCredito = 0 THEN ' ExibeImagensRelacaoCredito : «Falso» '
                                              WHEN  ExibeImagensRelacaoCredito = 1 THEN ' ExibeImagensRelacaoCredito : «Verdadeiro» '
                                    END 
                         + '| NumeroControleDRISS : «' + RTRIM( ISNULL( CAST (NumeroControleDRISS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathUpdateViaLogon : «' + RTRIM( ISNULL( CAST (PathUpdateViaLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoCC : «' + RTRIM( ISNULL( CAST (AcessoCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoCC : «' + RTRIM( ISNULL( CAST (DataAcessoCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteCC : «' + RTRIM( ISNULL( CAST (DataLimiteCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostrarFavorecidoCustoReceita IS NULL THEN ' MostrarFavorecidoCustoReceita : «Nulo» '
                                              WHEN  MostrarFavorecidoCustoReceita = 0 THEN ' MostrarFavorecidoCustoReceita : «Falso» '
                                              WHEN  MostrarFavorecidoCustoReceita = 1 THEN ' MostrarFavorecidoCustoReceita : «Verdadeiro» '
                                    END 
                         + '| IdPessoaFavorecido : «' + RTRIM( ISNULL( CAST (IdPessoaFavorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag IS NULL THEN ' MostraVlBaseImpImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 0 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 1 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| QtdeUsuariosTransferidos : «' + RTRIM( ISNULL( CAST (QtdeUsuariosTransferidos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImpressaoFrenteVerso IS NULL THEN ' ImpressaoFrenteVerso : «Nulo» '
                                              WHEN  ImpressaoFrenteVerso = 0 THEN ' ImpressaoFrenteVerso : «Falso» '
                                              WHEN  ImpressaoFrenteVerso = 1 THEN ' ImpressaoFrenteVerso : «Verdadeiro» '
                                    END 
                         + '| Eventual : «' + RTRIM( ISNULL( CAST (Eventual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTransfContasPagar : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfContasPagar, 113 ),'Nulo'))+'» '
                         + '| DataTransfContasReceber : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfContasReceber, 113 ),'Nulo'))+'» '
                         + '| DataTransfMovimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfMovimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DES IS NULL THEN ' DES : «Nulo» '
                                              WHEN  DES = 0 THEN ' DES : «Falso» '
                                              WHEN  DES = 1 THEN ' DES : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PrevRecolhimentoTributo IS NULL THEN ' PrevRecolhimentoTributo : «Nulo» '
                                              WHEN  PrevRecolhimentoTributo = 0 THEN ' PrevRecolhimentoTributo : «Falso» '
                                              WHEN  PrevRecolhimentoTributo = 1 THEN ' PrevRecolhimentoTributo : «Verdadeiro» '
                                    END 
                         + '| PathArquivosExportacao : «' + RTRIM( ISNULL( CAST (PathArquivosExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRelacaoCredNumerada IS NULL THEN ' UtilizaRelacaoCredNumerada : «Nulo» '
                                              WHEN  UtilizaRelacaoCredNumerada = 0 THEN ' UtilizaRelacaoCredNumerada : «Falso» '
                                              WHEN  UtilizaRelacaoCredNumerada = 1 THEN ' UtilizaRelacaoCredNumerada : «Verdadeiro» '
                                    END 
                         + '| PrefixoRC : «' + RTRIM( ISNULL( CAST (PrefixoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoRC : «' + RTRIM( ISNULL( CAST (SufixoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoRC : «' + RTRIM( ISNULL( CAST (IncrementoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso IS NULL THEN ' UtilizaRelacaoCredNumeradaProcesso : «Nulo» '
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso = 0 THEN ' UtilizaRelacaoCredNumeradaProcesso : «Falso» '
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso = 1 THEN ' UtilizaRelacaoCredNumeradaProcesso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CobrancaCompartilhadaDefaultReceita IS NULL THEN ' CobrancaCompartilhadaDefaultReceita : «Nulo» '
                                              WHEN  CobrancaCompartilhadaDefaultReceita = 0 THEN ' CobrancaCompartilhadaDefaultReceita : «Falso» '
                                              WHEN  CobrancaCompartilhadaDefaultReceita = 1 THEN ' CobrancaCompartilhadaDefaultReceita : «Verdadeiro» '
                                    END 
                         + '| IdPessoaTransferenciaReceita : «' + RTRIM( ISNULL( CAST (IdPessoaTransferenciaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamentoTransferenciaReceita : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoTransferenciaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFinanceiroTransfReceita : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFinanceiroTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPrestacao : «' + RTRIM( ISNULL( CAST (IdPessoaPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagPrestacao : «' + RTRIM( ISNULL( CAST (IdTipoPagPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinPrestacao : «' + RTRIM( ISNULL( CAST (IdTipoMovFinPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CFPS IS NULL THEN ' CFPS : «Nulo» '
                                              WHEN  CFPS = 0 THEN ' CFPS : «Falso» '
                                              WHEN  CFPS = 1 THEN ' CFPS : «Verdadeiro» '
                                    END 
                         + '| DataAlteracaoLancFinanceiroInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracaoLancFinanceiroInicial, 113 ),'Nulo'))+'» '
                         + '| DataAlteracaoLancFinanceiroFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracaoLancFinanceiroFinal, 113 ),'Nulo'))+'» '
                         + '| IdEstadoConservacaoPadrao : «' + RTRIM( ISNULL( CAST (IdEstadoConservacaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorEmail : «' + RTRIM( ISNULL( CAST (ServidorEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEmail : «' + RTRIM( ISNULL( CAST (PortaEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmail : «' + RTRIM( ISNULL( CAST (UsuarioEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmail : «' + RTRIM( ISNULL( CAST (SenhaEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito1 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito2 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito3 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito4 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncluirHistEmpenho IS NULL THEN ' IncluirHistEmpenho : «Nulo» '
                                              WHEN  IncluirHistEmpenho = 0 THEN ' IncluirHistEmpenho : «Falso» '
                                              WHEN  IncluirHistEmpenho = 1 THEN ' IncluirHistEmpenho : «Verdadeiro» '
                                    END 
                         + '| DataLimiteProcesso : «' + RTRIM( ISNULL( CAST (DataLimiteProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoProcesso : «' + RTRIM( ISNULL( CAST (DataAcessoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoProcesso : «' + RTRIM( ISNULL( CAST (AcessoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteFiscalizacao : «' + RTRIM( ISNULL( CAST (DataLimiteFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoFiscalizacao : «' + RTRIM( ISNULL( CAST (DataAcessoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoFiscalizacao : «' + RTRIM( ISNULL( CAST (AcessoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  imprimeDataHoraRel IS NULL THEN ' imprimeDataHoraRel : «Nulo» '
                                              WHEN  imprimeDataHoraRel = 0 THEN ' imprimeDataHoraRel : «Falso» '
                                              WHEN  imprimeDataHoraRel = 1 THEN ' imprimeDataHoraRel : «Verdadeiro» '
                                    END 
                         + '| PathArquivosSG : «' + RTRIM( ISNULL( CAST (PathArquivosSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinRecRealizar : «' + RTRIM( ISNULL( CAST (IdTipoMovFinRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPgtoRecRealizar : «' + RTRIM( ISNULL( CAST (IdTipoPgtoRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaRecRealizar : «' + RTRIM( ISNULL( CAST (IdPessoaRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinRecRealizarCartao : «' + RTRIM( ISNULL( CAST (IdTipoMovFinRecRealizarCartao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailCotacao : «' + RTRIM( ISNULL( CAST (UsuarioEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmailCotacao : «' + RTRIM( ISNULL( CAST (SenhaEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ServidorRequerAutenticacao IS NULL THEN ' ServidorRequerAutenticacao : «Nulo» '
                                              WHEN  ServidorRequerAutenticacao = 0 THEN ' ServidorRequerAutenticacao : «Falso» '
                                              WHEN  ServidorRequerAutenticacao = 1 THEN ' ServidorRequerAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CPFCNPJObrigatorio IS NULL THEN ' CPFCNPJObrigatorio : «Nulo» '
                                              WHEN  CPFCNPJObrigatorio = 0 THEN ' CPFCNPJObrigatorio : «Falso» '
                                              WHEN  CPFCNPJObrigatorio = 1 THEN ' CPFCNPJObrigatorio : «Verdadeiro» '
                                    END 
                         + '| DataCriaUsuarioSql : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriaUsuarioSql, 113 ),'Nulo'))+'» '
                         + '| IdTipoPagamentoRecRealiz : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaFavorecidoRecRealiz : «' + RTRIM( ISNULL( CAST (IdPessoaFavorecidoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ManterArquivoRetorno IS NULL THEN ' ManterArquivoRetorno : «Nulo» '
                                              WHEN  ManterArquivoRetorno = 0 THEN ' ManterArquivoRetorno : «Falso» '
                                              WHEN  ManterArquivoRetorno = 1 THEN ' ManterArquivoRetorno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirLogoReduzidoNoCabecalho IS NULL THEN ' ExibirLogoReduzidoNoCabecalho : «Nulo» '
                                              WHEN  ExibirLogoReduzidoNoCabecalho = 0 THEN ' ExibirLogoReduzidoNoCabecalho : «Falso» '
                                              WHEN  ExibirLogoReduzidoNoCabecalho = 1 THEN ' ExibirLogoReduzidoNoCabecalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirApenasLogoNoCabecalho IS NULL THEN ' ExibirApenasLogoNoCabecalho : «Nulo» '
                                              WHEN  ExibirApenasLogoNoCabecalho = 0 THEN ' ExibirApenasLogoNoCabecalho : «Falso» '
                                              WHEN  ExibirApenasLogoNoCabecalho = 1 THEN ' ExibirApenasLogoNoCabecalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaMovimentoFolha IS NULL THEN ' AtualizaMovimentoFolha : «Nulo» '
                                              WHEN  AtualizaMovimentoFolha = 0 THEN ' AtualizaMovimentoFolha : «Falso» '
                                              WHEN  AtualizaMovimentoFolha = 1 THEN ' AtualizaMovimentoFolha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaPagamentoFolha IS NULL THEN ' AtualizaPagamentoFolha : «Nulo» '
                                              WHEN  AtualizaPagamentoFolha = 0 THEN ' AtualizaPagamentoFolha : «Falso» '
                                              WHEN  AtualizaPagamentoFolha = 1 THEN ' AtualizaPagamentoFolha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaPrevReceita IS NULL THEN ' AtualizaPrevReceita : «Nulo» '
                                              WHEN  AtualizaPrevReceita = 0 THEN ' AtualizaPrevReceita : «Falso» '
                                              WHEN  AtualizaPrevReceita = 1 THEN ' AtualizaPrevReceita : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirObjetoSocialCRC IS NULL THEN ' ExibirObjetoSocialCRC : «Nulo» '
                                              WHEN  ExibirObjetoSocialCRC = 0 THEN ' ExibirObjetoSocialCRC : «Falso» '
                                              WHEN  ExibirObjetoSocialCRC = 1 THEN ' ExibirObjetoSocialCRC : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaRodapePadraoCRC IS NULL THEN ' UtilizaRodapePadraoCRC : «Nulo» '
                                              WHEN  UtilizaRodapePadraoCRC = 0 THEN ' UtilizaRodapePadraoCRC : «Falso» '
                                              WHEN  UtilizaRodapePadraoCRC = 1 THEN ' UtilizaRodapePadraoCRC : «Verdadeiro» '
                                    END 
                         + '| IdCCCustoReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRepasseReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoRepasseReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustodia : «' + RTRIM( ISNULL( CAST (IdContaCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaTransfReceita : «' + RTRIM( ISNULL( CAST (IdContaTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDevolucaoRecARealizar : «' + RTRIM( ISNULL( CAST (IdContaDevolucaoRecARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebitoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaDebitoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogExterno : «' + RTRIM( ISNULL( CAST (LogExterno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeLogoCantoEsquerdo IS NULL THEN ' ExibeLogoCantoEsquerdo : «Nulo» '
                                              WHEN  ExibeLogoCantoEsquerdo = 0 THEN ' ExibeLogoCantoEsquerdo : «Falso» '
                                              WHEN  ExibeLogoCantoEsquerdo = 1 THEN ' ExibeLogoCantoEsquerdo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaLogoRelatoriosSISCONT IS NULL THEN ' UtilizaLogoRelatoriosSISCONT : «Nulo» '
                                              WHEN  UtilizaLogoRelatoriosSISCONT = 0 THEN ' UtilizaLogoRelatoriosSISCONT : «Falso» '
                                              WHEN  UtilizaLogoRelatoriosSISCONT = 1 THEN ' UtilizaLogoRelatoriosSISCONT : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO IS NULL THEN ' ExibirLogoNotasEmpenhoSIPRO : «Nulo» '
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO = 0 THEN ' ExibirLogoNotasEmpenhoSIPRO : «Falso» '
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO = 1 THEN ' ExibirLogoNotasEmpenhoSIPRO : «Verdadeiro» '
                                    END 
                         + '| BandejaImpEmpenho : «' + RTRIM( ISNULL( CAST (BandejaImpEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BandejaImpPreEmpenho : «' + RTRIM( ISNULL( CAST (BandejaImpPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizarImpEmpenho IS NULL THEN ' VisualizarImpEmpenho : «Nulo» '
                                              WHEN  VisualizarImpEmpenho = 0 THEN ' VisualizarImpEmpenho : «Falso» '
                                              WHEN  VisualizarImpEmpenho = 1 THEN ' VisualizarImpEmpenho : «Verdadeiro» '
                                    END 
                         + '| ParametroImpFrenteVerso : «' + RTRIM( ISNULL( CAST (ParametroImpFrenteVerso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoPDR : «' + RTRIM( ISNULL( CAST (PrefixoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoPDR : «' + RTRIM( ISNULL( CAST (SufixoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoPDR : «' + RTRIM( ISNULL( CAST (IncrementoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoDDR : «' + RTRIM( ISNULL( CAST (PrefixoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoDDR : «' + RTRIM( ISNULL( CAST (SufixoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoDDR : «' + RTRIM( ISNULL( CAST (IncrementoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TributaImportacao IS NULL THEN ' TributaImportacao : «Nulo» '
                                              WHEN  TributaImportacao = 0 THEN ' TributaImportacao : «Falso» '
                                              WHEN  TributaImportacao = 1 THEN ' TributaImportacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAjustesPessoasSiproSG IS NULL THEN ' BloquearAjustesPessoasSiproSG : «Nulo» '
                                              WHEN  BloquearAjustesPessoasSiproSG = 0 THEN ' BloquearAjustesPessoasSiproSG : «Falso» '
                                              WHEN  BloquearAjustesPessoasSiproSG = 1 THEN ' BloquearAjustesPessoasSiproSG : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearPessoasSiproSG IS NULL THEN ' BloquearPessoasSiproSG : «Nulo» '
                                              WHEN  BloquearPessoasSiproSG = 0 THEN ' BloquearPessoasSiproSG : «Falso» '
                                              WHEN  BloquearPessoasSiproSG = 1 THEN ' BloquearPessoasSiproSG : «Verdadeiro» '
                                    END 
                         + '| EmailCopiaSG : «' + RTRIM( ISNULL( CAST (EmailCopiaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaPagamentoAssociacoes IS NULL THEN ' UtilizaPagamentoAssociacoes : «Nulo» '
                                              WHEN  UtilizaPagamentoAssociacoes = 0 THEN ' UtilizaPagamentoAssociacoes : «Falso» '
                                              WHEN  UtilizaPagamentoAssociacoes = 1 THEN ' UtilizaPagamentoAssociacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho IS NULL THEN ' PrestacaoContasFavorecidoDoEmpenho : «Nulo» '
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho = 0 THEN ' PrestacaoContasFavorecidoDoEmpenho : «Falso» '
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho = 1 THEN ' PrestacaoContasFavorecidoDoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IncluirHistRestosEmpenho IS NULL THEN ' IncluirHistRestosEmpenho : «Nulo» '
                                              WHEN  IncluirHistRestosEmpenho = 0 THEN ' IncluirHistRestosEmpenho : «Falso» '
                                              WHEN  IncluirHistRestosEmpenho = 1 THEN ' IncluirHistRestosEmpenho : «Verdadeiro» '
                                    END 
                         + '| ServidorFTP : «' + RTRIM( ISNULL( CAST (ServidorFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PastaFTP : «' + RTRIM( ISNULL( CAST (PastaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaAlertaCertificacao IS NULL THEN ' UtilizaAlertaCertificacao : «Nulo» '
                                              WHEN  UtilizaAlertaCertificacao = 0 THEN ' UtilizaAlertaCertificacao : «Falso» '
                                              WHEN  UtilizaAlertaCertificacao = 1 THEN ' UtilizaAlertaCertificacao : «Verdadeiro» '
                                    END 
                         + '| EmailOrigem : «' + RTRIM( ISNULL( CAST (EmailOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAutorizacaoImpressao IS NULL THEN ' UsaAutorizacaoImpressao : «Nulo» '
                                              WHEN  UsaAutorizacaoImpressao = 0 THEN ' UsaAutorizacaoImpressao : «Falso» '
                                              WHEN  UsaAutorizacaoImpressao = 1 THEN ' UsaAutorizacaoImpressao : «Verdadeiro» '
                                    END 
                         + '| EmailAutorizacaoImpressao : «' + RTRIM( ISNULL( CAST (EmailAutorizacaoImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLSAD : «' + RTRIM( ISNULL( CAST (URLSAD AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PCEnderecoWSDL : «' + RTRIM( ISNULL( CAST (PCEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAtualizacaoMSG : «' + RTRIM( ISNULL( CAST (TempoAtualizacaoMSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LiqEnderecoWSDL : «' + RTRIM( ISNULL( CAST (LiqEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LancEnderecoWSDL : «' + RTRIM( ISNULL( CAST (LancEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImportaFolhaCentroCusto11Char IS NULL THEN ' ImportaFolhaCentroCusto11Char : «Nulo» '
                                              WHEN  ImportaFolhaCentroCusto11Char = 0 THEN ' ImportaFolhaCentroCusto11Char : «Falso» '
                                              WHEN  ImportaFolhaCentroCusto11Char = 1 THEN ' ImportaFolhaCentroCusto11Char : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ServidorRequerAutenticacaoSSL IS NULL THEN ' ServidorRequerAutenticacaoSSL : «Nulo» '
                                              WHEN  ServidorRequerAutenticacaoSSL = 0 THEN ' ServidorRequerAutenticacaoSSL : «Falso» '
                                              WHEN  ServidorRequerAutenticacaoSSL = 1 THEN ' ServidorRequerAutenticacaoSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  InicializarMSGcomWindows IS NULL THEN ' InicializarMSGcomWindows : «Nulo» '
                                              WHEN  InicializarMSGcomWindows = 0 THEN ' InicializarMSGcomWindows : «Falso» '
                                              WHEN  InicializarMSGcomWindows = 1 THEN ' InicializarMSGcomWindows : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ScriptLogExecutado IS NULL THEN ' ScriptLogExecutado : «Nulo» '
                                              WHEN  ScriptLogExecutado = 0 THEN ' ScriptLogExecutado : «Falso» '
                                              WHEN  ScriptLogExecutado = 1 THEN ' ScriptLogExecutado : «Verdadeiro» '
                                    END 
                         + '| EnderecoHttpSiscafweb : «' + RTRIM( ISNULL( CAST (EnderecoHttpSiscafweb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCliente : «' + RTRIM( ISNULL( CAST (TipoCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura1 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura2 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura3 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura4 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaBackup IS NULL THEN ' AlertaBackup : «Nulo» '
                                              WHEN  AlertaBackup = 0 THEN ' AlertaBackup : «Falso» '
                                              WHEN  AlertaBackup = 1 THEN ' AlertaBackup : «Verdadeiro» '
                                    END 
                         + '| DataAlertaBackup : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlertaBackup, 113 ),'Nulo'))+'» '
                         + '| ServidorEmailUsLogon : «' + RTRIM( ISNULL( CAST (ServidorEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEmailUsLogon : «' + RTRIM( ISNULL( CAST (PortaEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailUsLogon : «' + RTRIM( ISNULL( CAST (UsuarioEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmailUsLogon : «' + RTRIM( ISNULL( CAST (SenhaEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSLUsLogon IS NULL THEN ' EmailAutenticaSSLUsLogon : «Nulo» '
                                              WHEN  EmailAutenticaSSLUsLogon = 0 THEN ' EmailAutenticaSSLUsLogon : «Falso» '
                                              WHEN  EmailAutenticaSSLUsLogon = 1 THEN ' EmailAutenticaSSLUsLogon : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ScriptCEPExecutado IS NULL THEN ' ScriptCEPExecutado : «Nulo» '
                                              WHEN  ScriptCEPExecutado = 0 THEN ' ScriptCEPExecutado : «Falso» '
                                              WHEN  ScriptCEPExecutado = 1 THEN ' ScriptCEPExecutado : «Verdadeiro» '
                                    END 
                         + '| EmailAuthenticationMethod : «' + RTRIM( ISNULL( CAST (EmailAuthenticationMethod AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnvioEmailLimiteQtd : «' + RTRIM( ISNULL( CAST (EnvioEmailLimiteQtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnvioEmailLimiteTempo : «' + RTRIM( ISNULL( CONVERT (CHAR, EnvioEmailLimiteTempo, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'SeparadorExportacaotxt : «' + RTRIM( ISNULL( CAST (SeparadorExportacaotxt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaCredito IS NULL THEN ' AgrupaCredito : «Nulo» '
                                              WHEN  AgrupaCredito = 0 THEN ' AgrupaCredito : «Falso» '
                                              WHEN  AgrupaCredito = 1 THEN ' AgrupaCredito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReceitaUnitaria IS NULL THEN ' ReceitaUnitaria : «Nulo» '
                                              WHEN  ReceitaUnitaria = 0 THEN ' ReceitaUnitaria : «Falso» '
                                              WHEN  ReceitaUnitaria = 1 THEN ' ReceitaUnitaria : «Verdadeiro» '
                                    END 
                         + '| DigitosGrupo : «' + RTRIM( ISNULL( CAST (DigitosGrupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel1 : «' + RTRIM( ISNULL( CAST (UnidadeNivel1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel2 : «' + RTRIM( ISNULL( CAST (UnidadeNivel2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel3 : «' + RTRIM( ISNULL( CAST (UnidadeNivel3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoOC : «' + RTRIM( ISNULL( CAST (PrefixoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoOC : «' + RTRIM( ISNULL( CAST (SufixoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoOC : «' + RTRIM( ISNULL( CAST (IncrementoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoOS : «' + RTRIM( ISNULL( CAST (PrefixoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoOS : «' + RTRIM( ISNULL( CAST (SufixoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoOS : «' + RTRIM( ISNULL( CAST (IncrementoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoCS : «' + RTRIM( ISNULL( CAST (PrefixoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoCS : «' + RTRIM( ISNULL( CAST (SufixoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoCS : «' + RTRIM( ISNULL( CAST (IncrementoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoContrato : «' + RTRIM( ISNULL( CAST (PrefixoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoContrato : «' + RTRIM( ISNULL( CAST (SufixoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoContrato : «' + RTRIM( ISNULL( CAST (IncrementoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoLicitacao : «' + RTRIM( ISNULL( CAST (PrefixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoLicitacao : «' + RTRIM( ISNULL( CAST (SufixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoLicitacao : «' + RTRIM( ISNULL( CAST (IncrementoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoBemMovel : «' + RTRIM( ISNULL( CAST (PrefixoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoBemMovel : «' + RTRIM( ISNULL( CAST (SufixoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoBemMovel : «' + RTRIM( ISNULL( CAST (IncrementoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoBemImovel : «' + RTRIM( ISNULL( CAST (PrefixoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoBemImovel : «' + RTRIM( ISNULL( CAST (SufixoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoBemImovel : «' + RTRIM( ISNULL( CAST (IncrementoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorCotacao : «' + RTRIM( ISNULL( CAST (ServidorCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioCotacao : «' + RTRIM( ISNULL( CAST (UsuarioCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaCotacao : «' + RTRIM( ISNULL( CAST (SenhaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostCotacao : «' + RTRIM( ISNULL( CAST (HostCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaCotacao : «' + RTRIM( ISNULL( CAST (PortaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCotacao : «' + RTRIM( ISNULL( CAST (EmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinkCotacao : «' + RTRIM( ISNULL( CAST (LinkCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CodigoBarraAutomatico IS NULL THEN ' CodigoBarraAutomatico : «Nulo» '
                                              WHEN  CodigoBarraAutomatico = 0 THEN ' CodigoBarraAutomatico : «Falso» '
                                              WHEN  CodigoBarraAutomatico = 1 THEN ' CodigoBarraAutomatico : «Verdadeiro» '
                                    END 
                         + '| PrefixoCodigoBarra : «' + RTRIM( ISNULL( CAST (PrefixoCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoCodigoBarra : «' + RTRIM( ISNULL( CAST (SufixoCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TerminadorCodigoBarra : «' + RTRIM( ISNULL( CAST (TerminadorCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeparadorCampos : «' + RTRIM( ISNULL( CAST (SeparadorCampos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormatoData : «' + RTRIM( ISNULL( CAST (FormatoData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiretorioArquivos : «' + RTRIM( ISNULL( CAST (DiretorioArquivos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeparadorData : «' + RTRIM( ISNULL( CAST (SeparadorData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OrcamentoCCustoporConta IS NULL THEN ' OrcamentoCCustoporConta : «Nulo» '
                                              WHEN  OrcamentoCCustoporConta = 0 THEN ' OrcamentoCCustoporConta : «Falso» '
                                              WHEN  OrcamentoCCustoporConta = 1 THEN ' OrcamentoCCustoporConta : «Verdadeiro» '
                                    END 
                         + '| PrefixoCertificacao : «' + RTRIM( ISNULL( CAST (PrefixoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoItem : «' + RTRIM( ISNULL( CAST (PrefixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoItem : «' + RTRIM( ISNULL( CAST (SufixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoItem : «' + RTRIM( ISNULL( CAST (IncrementoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TransferePagamentos IS NULL THEN ' TransferePagamentos : «Nulo» '
                                              WHEN  TransferePagamentos = 0 THEN ' TransferePagamentos : «Falso» '
                                              WHEN  TransferePagamentos = 1 THEN ' TransferePagamentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereRecebimentos IS NULL THEN ' TransfereRecebimentos : «Nulo» '
                                              WHEN  TransfereRecebimentos = 0 THEN ' TransfereRecebimentos : «Falso» '
                                              WHEN  TransfereRecebimentos = 1 THEN ' TransfereRecebimentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereRestos IS NULL THEN ' TransfereRestos : «Nulo» '
                                              WHEN  TransfereRestos = 0 THEN ' TransfereRestos : «Falso» '
                                              WHEN  TransfereRestos = 1 THEN ' TransfereRestos : «Verdadeiro» '
                                    END 
                         + '| DataContabilInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilInicial, 113 ),'Nulo'))+'» '
                         + '| DataContabilFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilFinal, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeSaldo IS NULL THEN ' ImprimeSaldo : «Nulo» '
                                              WHEN  ImprimeSaldo = 0 THEN ' ImprimeSaldo : «Falso» '
                                              WHEN  ImprimeSaldo = 1 THEN ' ImprimeSaldo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SaldoObrigatorio IS NULL THEN ' SaldoObrigatorio : «Nulo» '
                                              WHEN  SaldoObrigatorio = 0 THEN ' SaldoObrigatorio : «Falso» '
                                              WHEN  SaldoObrigatorio = 1 THEN ' SaldoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PreEmpenho IS NULL THEN ' PreEmpenho : «Nulo» '
                                              WHEN  PreEmpenho = 0 THEN ' PreEmpenho : «Falso» '
                                              WHEN  PreEmpenho = 1 THEN ' PreEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraRestos IS NULL THEN ' MostraRestos : «Nulo» '
                                              WHEN  MostraRestos = 0 THEN ' MostraRestos : «Falso» '
                                              WHEN  MostraRestos = 1 THEN ' MostraRestos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraDadosBanco IS NULL THEN ' MostraDadosBanco : «Nulo» '
                                              WHEN  MostraDadosBanco = 0 THEN ' MostraDadosBanco : «Falso» '
                                              WHEN  MostraDadosBanco = 1 THEN ' MostraDadosBanco : «Verdadeiro» '
                                    END 
                         + '| TituloNota : «' + RTRIM( ISNULL( CAST (TituloNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloBaixa : «' + RTRIM( ISNULL( CAST (TituloBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Controlar : «' + RTRIM( ISNULL( CAST (Controlar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamentoFolha : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoAvulso IS NULL THEN ' PermitePagamentoAvulso : «Nulo» '
                                              WHEN  PermitePagamentoAvulso = 0 THEN ' PermitePagamentoAvulso : «Falso» '
                                              WHEN  PermitePagamentoAvulso = 1 THEN ' PermitePagamentoAvulso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereMovimentosFinanceiros IS NULL THEN ' TransfereMovimentosFinanceiros : «Nulo» '
                                              WHEN  TransfereMovimentosFinanceiros = 0 THEN ' TransfereMovimentosFinanceiros : «Falso» '
                                              WHEN  TransfereMovimentosFinanceiros = 1 THEN ' TransfereMovimentosFinanceiros : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeEndereco IS NULL THEN ' ImprimeEndereco : «Nulo» '
                                              WHEN  ImprimeEndereco = 0 THEN ' ImprimeEndereco : «Falso» '
                                              WHEN  ImprimeEndereco = 1 THEN ' ImprimeEndereco : «Verdadeiro» '
                                    END 
                         + '| DataContabilizacaoPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPagamento, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoReceita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoReceita, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoRestos : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoRestos, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CriaCentroCustoEmpenho IS NULL THEN ' CriaCentroCustoEmpenho : «Nulo» '
                                              WHEN  CriaCentroCustoEmpenho = 0 THEN ' CriaCentroCustoEmpenho : «Falso» '
                                              WHEN  CriaCentroCustoEmpenho = 1 THEN ' CriaCentroCustoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CalcularCustoReceitaAntes IS NULL THEN ' CalcularCustoReceitaAntes : «Nulo» '
                                              WHEN  CalcularCustoReceitaAntes = 0 THEN ' CalcularCustoReceitaAntes : «Falso» '
                                              WHEN  CalcularCustoReceitaAntes = 1 THEN ' CalcularCustoReceitaAntes : «Verdadeiro» '
                                    END 
                         + '| IdTipoPagamentoReceita : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaCustoFixoVariado IS NULL THEN ' UsaCustoFixoVariado : «Nulo» '
                                              WHEN  UsaCustoFixoVariado = 0 THEN ' UsaCustoFixoVariado : «Falso» '
                                              WHEN  UsaCustoFixoVariado = 1 THEN ' UsaCustoFixoVariado : «Verdadeiro» '
                                    END 
                         + '| PathUpdate : «' + RTRIM( ISNULL( CAST (PathUpdate AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathArquivos : «' + RTRIM( ISNULL( CAST (PathArquivos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPagamento IS NULL THEN ' TravamentoCCustoPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoPagamento = 0 THEN ' TravamentoCCustoPagamento : «Falso» '
                                              WHEN  TravamentoCCustoPagamento = 1 THEN ' TravamentoCCustoPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostaCentroCustoNotaOrcamentaria IS NULL THEN ' MostaCentroCustoNotaOrcamentaria : «Nulo» '
                                              WHEN  MostaCentroCustoNotaOrcamentaria = 0 THEN ' MostaCentroCustoNotaOrcamentaria : «Falso» '
                                              WHEN  MostaCentroCustoNotaOrcamentaria = 1 THEN ' MostaCentroCustoNotaOrcamentaria : «Verdadeiro» '
                                    END 
                         + '| ServidorSiscafWeb : «' + RTRIM( ISNULL( CAST (ServidorSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioSiscafWeb : «' + RTRIM( ISNULL( CAST (UsuarioSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaSiscafWeb : «' + RTRIM( ISNULL( CAST (SenhaSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFolha : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaMovimentoFolha : «' + RTRIM( ISNULL( CAST (IdPessoaMovimentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoBanco : «' + RTRIM( ISNULL( CAST (VersaoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathBackup : «' + RTRIM( ISNULL( CAST (PathBackup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgendamentoBackup : «' + RTRIM( ISNULL( CAST (AgendamentoBackup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaExecucaoAgBackup : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaExecucaoAgBackup, 113 ),'Nulo'))+'» '
                         + '| PathAuditoria : «' + RTRIM( ISNULL( CAST (PathAuditoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgendamentoAuditoria : «' + RTRIM( ISNULL( CAST (AgendamentoAuditoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaExecucaoAgAuditoria : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaExecucaoAgAuditoria, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraHistorico IS NULL THEN ' AlteraHistorico : «Nulo» '
                                              WHEN  AlteraHistorico = 0 THEN ' AlteraHistorico : «Falso» '
                                              WHEN  AlteraHistorico = 1 THEN ' AlteraHistorico : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraDataImpressaoBaixaPag IS NULL THEN ' MostraDataImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraDataImpressaoBaixaPag = 0 THEN ' MostraDataImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraDataImpressaoBaixaPag = 1 THEN ' MostraDataImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarRepasse IS NULL THEN ' AplicarRepasse : «Nulo» '
                                              WHEN  AplicarRepasse = 0 THEN ' AplicarRepasse : «Falso» '
                                              WHEN  AplicarRepasse = 1 THEN ' AplicarRepasse : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CriaPagamentoRepasseRec IS NULL THEN ' CriaPagamentoRepasseRec : «Nulo» '
                                              WHEN  CriaPagamentoRepasseRec = 0 THEN ' CriaPagamentoRepasseRec : «Falso» '
                                              WHEN  CriaPagamentoRepasseRec = 1 THEN ' CriaPagamentoRepasseRec : «Verdadeiro» '
                                    END 
                         + '| IdTipoPagamentoRepasse : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgrupaCreditoSipro : «' + RTRIM( ISNULL( CAST (AgrupaCreditoSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaPagamentoCusto IS NULL THEN ' AgrupaPagamentoCusto : «Nulo» '
                                              WHEN  AgrupaPagamentoCusto = 0 THEN ' AgrupaPagamentoCusto : «Falso» '
                                              WHEN  AgrupaPagamentoCusto = 1 THEN ' AgrupaPagamentoCusto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraOcorrencia IS NULL THEN ' MostraOcorrencia : «Nulo» '
                                              WHEN  MostraOcorrencia = 0 THEN ' MostraOcorrencia : «Falso» '
                                              WHEN  MostraOcorrencia = 1 THEN ' MostraOcorrencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IntegraSiproAgenda IS NULL THEN ' IntegraSiproAgenda : «Nulo» '
                                              WHEN  IntegraSiproAgenda = 0 THEN ' IntegraSiproAgenda : «Falso» '
                                              WHEN  IntegraSiproAgenda = 1 THEN ' IntegraSiproAgenda : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfContasPagar IS NULL THEN ' TransfContasPagar : «Nulo» '
                                              WHEN  TransfContasPagar = 0 THEN ' TransfContasPagar : «Falso» '
                                              WHEN  TransfContasPagar = 1 THEN ' TransfContasPagar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfContasReceber IS NULL THEN ' TransfContasReceber : «Nulo» '
                                              WHEN  TransfContasReceber = 0 THEN ' TransfContasReceber : «Falso» '
                                              WHEN  TransfContasReceber = 1 THEN ' TransfContasReceber : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfMovimentoFinanceiro IS NULL THEN ' TransfMovimentoFinanceiro : «Nulo» '
                                              WHEN  TransfMovimentoFinanceiro = 0 THEN ' TransfMovimentoFinanceiro : «Falso» '
                                              WHEN  TransfMovimentoFinanceiro = 1 THEN ' TransfMovimentoFinanceiro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraLancSiscontwFluxoCaixa IS NULL THEN ' MostraLancSiscontwFluxoCaixa : «Nulo» '
                                              WHEN  MostraLancSiscontwFluxoCaixa = 0 THEN ' MostraLancSiscontwFluxoCaixa : «Falso» '
                                              WHEN  MostraLancSiscontwFluxoCaixa = 1 THEN ' MostraLancSiscontwFluxoCaixa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeImagensRelacaoCredito IS NULL THEN ' ExibeImagensRelacaoCredito : «Nulo» '
                                              WHEN  ExibeImagensRelacaoCredito = 0 THEN ' ExibeImagensRelacaoCredito : «Falso» '
                                              WHEN  ExibeImagensRelacaoCredito = 1 THEN ' ExibeImagensRelacaoCredito : «Verdadeiro» '
                                    END 
                         + '| NumeroControleDRISS : «' + RTRIM( ISNULL( CAST (NumeroControleDRISS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathUpdateViaLogon : «' + RTRIM( ISNULL( CAST (PathUpdateViaLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoCC : «' + RTRIM( ISNULL( CAST (AcessoCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoCC : «' + RTRIM( ISNULL( CAST (DataAcessoCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteCC : «' + RTRIM( ISNULL( CAST (DataLimiteCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostrarFavorecidoCustoReceita IS NULL THEN ' MostrarFavorecidoCustoReceita : «Nulo» '
                                              WHEN  MostrarFavorecidoCustoReceita = 0 THEN ' MostrarFavorecidoCustoReceita : «Falso» '
                                              WHEN  MostrarFavorecidoCustoReceita = 1 THEN ' MostrarFavorecidoCustoReceita : «Verdadeiro» '
                                    END 
                         + '| IdPessoaFavorecido : «' + RTRIM( ISNULL( CAST (IdPessoaFavorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag IS NULL THEN ' MostraVlBaseImpImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 0 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 1 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| QtdeUsuariosTransferidos : «' + RTRIM( ISNULL( CAST (QtdeUsuariosTransferidos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImpressaoFrenteVerso IS NULL THEN ' ImpressaoFrenteVerso : «Nulo» '
                                              WHEN  ImpressaoFrenteVerso = 0 THEN ' ImpressaoFrenteVerso : «Falso» '
                                              WHEN  ImpressaoFrenteVerso = 1 THEN ' ImpressaoFrenteVerso : «Verdadeiro» '
                                    END 
                         + '| Eventual : «' + RTRIM( ISNULL( CAST (Eventual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTransfContasPagar : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfContasPagar, 113 ),'Nulo'))+'» '
                         + '| DataTransfContasReceber : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfContasReceber, 113 ),'Nulo'))+'» '
                         + '| DataTransfMovimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfMovimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DES IS NULL THEN ' DES : «Nulo» '
                                              WHEN  DES = 0 THEN ' DES : «Falso» '
                                              WHEN  DES = 1 THEN ' DES : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PrevRecolhimentoTributo IS NULL THEN ' PrevRecolhimentoTributo : «Nulo» '
                                              WHEN  PrevRecolhimentoTributo = 0 THEN ' PrevRecolhimentoTributo : «Falso» '
                                              WHEN  PrevRecolhimentoTributo = 1 THEN ' PrevRecolhimentoTributo : «Verdadeiro» '
                                    END 
                         + '| PathArquivosExportacao : «' + RTRIM( ISNULL( CAST (PathArquivosExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRelacaoCredNumerada IS NULL THEN ' UtilizaRelacaoCredNumerada : «Nulo» '
                                              WHEN  UtilizaRelacaoCredNumerada = 0 THEN ' UtilizaRelacaoCredNumerada : «Falso» '
                                              WHEN  UtilizaRelacaoCredNumerada = 1 THEN ' UtilizaRelacaoCredNumerada : «Verdadeiro» '
                                    END 
                         + '| PrefixoRC : «' + RTRIM( ISNULL( CAST (PrefixoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoRC : «' + RTRIM( ISNULL( CAST (SufixoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoRC : «' + RTRIM( ISNULL( CAST (IncrementoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso IS NULL THEN ' UtilizaRelacaoCredNumeradaProcesso : «Nulo» '
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso = 0 THEN ' UtilizaRelacaoCredNumeradaProcesso : «Falso» '
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso = 1 THEN ' UtilizaRelacaoCredNumeradaProcesso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CobrancaCompartilhadaDefaultReceita IS NULL THEN ' CobrancaCompartilhadaDefaultReceita : «Nulo» '
                                              WHEN  CobrancaCompartilhadaDefaultReceita = 0 THEN ' CobrancaCompartilhadaDefaultReceita : «Falso» '
                                              WHEN  CobrancaCompartilhadaDefaultReceita = 1 THEN ' CobrancaCompartilhadaDefaultReceita : «Verdadeiro» '
                                    END 
                         + '| IdPessoaTransferenciaReceita : «' + RTRIM( ISNULL( CAST (IdPessoaTransferenciaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamentoTransferenciaReceita : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoTransferenciaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFinanceiroTransfReceita : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFinanceiroTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPrestacao : «' + RTRIM( ISNULL( CAST (IdPessoaPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagPrestacao : «' + RTRIM( ISNULL( CAST (IdTipoPagPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinPrestacao : «' + RTRIM( ISNULL( CAST (IdTipoMovFinPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CFPS IS NULL THEN ' CFPS : «Nulo» '
                                              WHEN  CFPS = 0 THEN ' CFPS : «Falso» '
                                              WHEN  CFPS = 1 THEN ' CFPS : «Verdadeiro» '
                                    END 
                         + '| DataAlteracaoLancFinanceiroInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracaoLancFinanceiroInicial, 113 ),'Nulo'))+'» '
                         + '| DataAlteracaoLancFinanceiroFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracaoLancFinanceiroFinal, 113 ),'Nulo'))+'» '
                         + '| IdEstadoConservacaoPadrao : «' + RTRIM( ISNULL( CAST (IdEstadoConservacaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorEmail : «' + RTRIM( ISNULL( CAST (ServidorEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEmail : «' + RTRIM( ISNULL( CAST (PortaEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmail : «' + RTRIM( ISNULL( CAST (UsuarioEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmail : «' + RTRIM( ISNULL( CAST (SenhaEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito1 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito2 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito3 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito4 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncluirHistEmpenho IS NULL THEN ' IncluirHistEmpenho : «Nulo» '
                                              WHEN  IncluirHistEmpenho = 0 THEN ' IncluirHistEmpenho : «Falso» '
                                              WHEN  IncluirHistEmpenho = 1 THEN ' IncluirHistEmpenho : «Verdadeiro» '
                                    END 
                         + '| DataLimiteProcesso : «' + RTRIM( ISNULL( CAST (DataLimiteProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoProcesso : «' + RTRIM( ISNULL( CAST (DataAcessoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoProcesso : «' + RTRIM( ISNULL( CAST (AcessoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteFiscalizacao : «' + RTRIM( ISNULL( CAST (DataLimiteFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoFiscalizacao : «' + RTRIM( ISNULL( CAST (DataAcessoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoFiscalizacao : «' + RTRIM( ISNULL( CAST (AcessoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  imprimeDataHoraRel IS NULL THEN ' imprimeDataHoraRel : «Nulo» '
                                              WHEN  imprimeDataHoraRel = 0 THEN ' imprimeDataHoraRel : «Falso» '
                                              WHEN  imprimeDataHoraRel = 1 THEN ' imprimeDataHoraRel : «Verdadeiro» '
                                    END 
                         + '| PathArquivosSG : «' + RTRIM( ISNULL( CAST (PathArquivosSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinRecRealizar : «' + RTRIM( ISNULL( CAST (IdTipoMovFinRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPgtoRecRealizar : «' + RTRIM( ISNULL( CAST (IdTipoPgtoRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaRecRealizar : «' + RTRIM( ISNULL( CAST (IdPessoaRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinRecRealizarCartao : «' + RTRIM( ISNULL( CAST (IdTipoMovFinRecRealizarCartao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailCotacao : «' + RTRIM( ISNULL( CAST (UsuarioEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmailCotacao : «' + RTRIM( ISNULL( CAST (SenhaEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ServidorRequerAutenticacao IS NULL THEN ' ServidorRequerAutenticacao : «Nulo» '
                                              WHEN  ServidorRequerAutenticacao = 0 THEN ' ServidorRequerAutenticacao : «Falso» '
                                              WHEN  ServidorRequerAutenticacao = 1 THEN ' ServidorRequerAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CPFCNPJObrigatorio IS NULL THEN ' CPFCNPJObrigatorio : «Nulo» '
                                              WHEN  CPFCNPJObrigatorio = 0 THEN ' CPFCNPJObrigatorio : «Falso» '
                                              WHEN  CPFCNPJObrigatorio = 1 THEN ' CPFCNPJObrigatorio : «Verdadeiro» '
                                    END 
                         + '| DataCriaUsuarioSql : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriaUsuarioSql, 113 ),'Nulo'))+'» '
                         + '| IdTipoPagamentoRecRealiz : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaFavorecidoRecRealiz : «' + RTRIM( ISNULL( CAST (IdPessoaFavorecidoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ManterArquivoRetorno IS NULL THEN ' ManterArquivoRetorno : «Nulo» '
                                              WHEN  ManterArquivoRetorno = 0 THEN ' ManterArquivoRetorno : «Falso» '
                                              WHEN  ManterArquivoRetorno = 1 THEN ' ManterArquivoRetorno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirLogoReduzidoNoCabecalho IS NULL THEN ' ExibirLogoReduzidoNoCabecalho : «Nulo» '
                                              WHEN  ExibirLogoReduzidoNoCabecalho = 0 THEN ' ExibirLogoReduzidoNoCabecalho : «Falso» '
                                              WHEN  ExibirLogoReduzidoNoCabecalho = 1 THEN ' ExibirLogoReduzidoNoCabecalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirApenasLogoNoCabecalho IS NULL THEN ' ExibirApenasLogoNoCabecalho : «Nulo» '
                                              WHEN  ExibirApenasLogoNoCabecalho = 0 THEN ' ExibirApenasLogoNoCabecalho : «Falso» '
                                              WHEN  ExibirApenasLogoNoCabecalho = 1 THEN ' ExibirApenasLogoNoCabecalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaMovimentoFolha IS NULL THEN ' AtualizaMovimentoFolha : «Nulo» '
                                              WHEN  AtualizaMovimentoFolha = 0 THEN ' AtualizaMovimentoFolha : «Falso» '
                                              WHEN  AtualizaMovimentoFolha = 1 THEN ' AtualizaMovimentoFolha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaPagamentoFolha IS NULL THEN ' AtualizaPagamentoFolha : «Nulo» '
                                              WHEN  AtualizaPagamentoFolha = 0 THEN ' AtualizaPagamentoFolha : «Falso» '
                                              WHEN  AtualizaPagamentoFolha = 1 THEN ' AtualizaPagamentoFolha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaPrevReceita IS NULL THEN ' AtualizaPrevReceita : «Nulo» '
                                              WHEN  AtualizaPrevReceita = 0 THEN ' AtualizaPrevReceita : «Falso» '
                                              WHEN  AtualizaPrevReceita = 1 THEN ' AtualizaPrevReceita : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirObjetoSocialCRC IS NULL THEN ' ExibirObjetoSocialCRC : «Nulo» '
                                              WHEN  ExibirObjetoSocialCRC = 0 THEN ' ExibirObjetoSocialCRC : «Falso» '
                                              WHEN  ExibirObjetoSocialCRC = 1 THEN ' ExibirObjetoSocialCRC : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaRodapePadraoCRC IS NULL THEN ' UtilizaRodapePadraoCRC : «Nulo» '
                                              WHEN  UtilizaRodapePadraoCRC = 0 THEN ' UtilizaRodapePadraoCRC : «Falso» '
                                              WHEN  UtilizaRodapePadraoCRC = 1 THEN ' UtilizaRodapePadraoCRC : «Verdadeiro» '
                                    END 
                         + '| IdCCCustoReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRepasseReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoRepasseReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustodia : «' + RTRIM( ISNULL( CAST (IdContaCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaTransfReceita : «' + RTRIM( ISNULL( CAST (IdContaTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDevolucaoRecARealizar : «' + RTRIM( ISNULL( CAST (IdContaDevolucaoRecARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebitoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaDebitoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogExterno : «' + RTRIM( ISNULL( CAST (LogExterno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeLogoCantoEsquerdo IS NULL THEN ' ExibeLogoCantoEsquerdo : «Nulo» '
                                              WHEN  ExibeLogoCantoEsquerdo = 0 THEN ' ExibeLogoCantoEsquerdo : «Falso» '
                                              WHEN  ExibeLogoCantoEsquerdo = 1 THEN ' ExibeLogoCantoEsquerdo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaLogoRelatoriosSISCONT IS NULL THEN ' UtilizaLogoRelatoriosSISCONT : «Nulo» '
                                              WHEN  UtilizaLogoRelatoriosSISCONT = 0 THEN ' UtilizaLogoRelatoriosSISCONT : «Falso» '
                                              WHEN  UtilizaLogoRelatoriosSISCONT = 1 THEN ' UtilizaLogoRelatoriosSISCONT : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO IS NULL THEN ' ExibirLogoNotasEmpenhoSIPRO : «Nulo» '
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO = 0 THEN ' ExibirLogoNotasEmpenhoSIPRO : «Falso» '
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO = 1 THEN ' ExibirLogoNotasEmpenhoSIPRO : «Verdadeiro» '
                                    END 
                         + '| BandejaImpEmpenho : «' + RTRIM( ISNULL( CAST (BandejaImpEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BandejaImpPreEmpenho : «' + RTRIM( ISNULL( CAST (BandejaImpPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizarImpEmpenho IS NULL THEN ' VisualizarImpEmpenho : «Nulo» '
                                              WHEN  VisualizarImpEmpenho = 0 THEN ' VisualizarImpEmpenho : «Falso» '
                                              WHEN  VisualizarImpEmpenho = 1 THEN ' VisualizarImpEmpenho : «Verdadeiro» '
                                    END 
                         + '| ParametroImpFrenteVerso : «' + RTRIM( ISNULL( CAST (ParametroImpFrenteVerso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoPDR : «' + RTRIM( ISNULL( CAST (PrefixoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoPDR : «' + RTRIM( ISNULL( CAST (SufixoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoPDR : «' + RTRIM( ISNULL( CAST (IncrementoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoDDR : «' + RTRIM( ISNULL( CAST (PrefixoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoDDR : «' + RTRIM( ISNULL( CAST (SufixoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoDDR : «' + RTRIM( ISNULL( CAST (IncrementoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TributaImportacao IS NULL THEN ' TributaImportacao : «Nulo» '
                                              WHEN  TributaImportacao = 0 THEN ' TributaImportacao : «Falso» '
                                              WHEN  TributaImportacao = 1 THEN ' TributaImportacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAjustesPessoasSiproSG IS NULL THEN ' BloquearAjustesPessoasSiproSG : «Nulo» '
                                              WHEN  BloquearAjustesPessoasSiproSG = 0 THEN ' BloquearAjustesPessoasSiproSG : «Falso» '
                                              WHEN  BloquearAjustesPessoasSiproSG = 1 THEN ' BloquearAjustesPessoasSiproSG : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearPessoasSiproSG IS NULL THEN ' BloquearPessoasSiproSG : «Nulo» '
                                              WHEN  BloquearPessoasSiproSG = 0 THEN ' BloquearPessoasSiproSG : «Falso» '
                                              WHEN  BloquearPessoasSiproSG = 1 THEN ' BloquearPessoasSiproSG : «Verdadeiro» '
                                    END 
                         + '| EmailCopiaSG : «' + RTRIM( ISNULL( CAST (EmailCopiaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaPagamentoAssociacoes IS NULL THEN ' UtilizaPagamentoAssociacoes : «Nulo» '
                                              WHEN  UtilizaPagamentoAssociacoes = 0 THEN ' UtilizaPagamentoAssociacoes : «Falso» '
                                              WHEN  UtilizaPagamentoAssociacoes = 1 THEN ' UtilizaPagamentoAssociacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho IS NULL THEN ' PrestacaoContasFavorecidoDoEmpenho : «Nulo» '
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho = 0 THEN ' PrestacaoContasFavorecidoDoEmpenho : «Falso» '
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho = 1 THEN ' PrestacaoContasFavorecidoDoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IncluirHistRestosEmpenho IS NULL THEN ' IncluirHistRestosEmpenho : «Nulo» '
                                              WHEN  IncluirHistRestosEmpenho = 0 THEN ' IncluirHistRestosEmpenho : «Falso» '
                                              WHEN  IncluirHistRestosEmpenho = 1 THEN ' IncluirHistRestosEmpenho : «Verdadeiro» '
                                    END 
                         + '| ServidorFTP : «' + RTRIM( ISNULL( CAST (ServidorFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PastaFTP : «' + RTRIM( ISNULL( CAST (PastaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaAlertaCertificacao IS NULL THEN ' UtilizaAlertaCertificacao : «Nulo» '
                                              WHEN  UtilizaAlertaCertificacao = 0 THEN ' UtilizaAlertaCertificacao : «Falso» '
                                              WHEN  UtilizaAlertaCertificacao = 1 THEN ' UtilizaAlertaCertificacao : «Verdadeiro» '
                                    END 
                         + '| EmailOrigem : «' + RTRIM( ISNULL( CAST (EmailOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAutorizacaoImpressao IS NULL THEN ' UsaAutorizacaoImpressao : «Nulo» '
                                              WHEN  UsaAutorizacaoImpressao = 0 THEN ' UsaAutorizacaoImpressao : «Falso» '
                                              WHEN  UsaAutorizacaoImpressao = 1 THEN ' UsaAutorizacaoImpressao : «Verdadeiro» '
                                    END 
                         + '| EmailAutorizacaoImpressao : «' + RTRIM( ISNULL( CAST (EmailAutorizacaoImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLSAD : «' + RTRIM( ISNULL( CAST (URLSAD AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PCEnderecoWSDL : «' + RTRIM( ISNULL( CAST (PCEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAtualizacaoMSG : «' + RTRIM( ISNULL( CAST (TempoAtualizacaoMSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LiqEnderecoWSDL : «' + RTRIM( ISNULL( CAST (LiqEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LancEnderecoWSDL : «' + RTRIM( ISNULL( CAST (LancEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImportaFolhaCentroCusto11Char IS NULL THEN ' ImportaFolhaCentroCusto11Char : «Nulo» '
                                              WHEN  ImportaFolhaCentroCusto11Char = 0 THEN ' ImportaFolhaCentroCusto11Char : «Falso» '
                                              WHEN  ImportaFolhaCentroCusto11Char = 1 THEN ' ImportaFolhaCentroCusto11Char : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ServidorRequerAutenticacaoSSL IS NULL THEN ' ServidorRequerAutenticacaoSSL : «Nulo» '
                                              WHEN  ServidorRequerAutenticacaoSSL = 0 THEN ' ServidorRequerAutenticacaoSSL : «Falso» '
                                              WHEN  ServidorRequerAutenticacaoSSL = 1 THEN ' ServidorRequerAutenticacaoSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  InicializarMSGcomWindows IS NULL THEN ' InicializarMSGcomWindows : «Nulo» '
                                              WHEN  InicializarMSGcomWindows = 0 THEN ' InicializarMSGcomWindows : «Falso» '
                                              WHEN  InicializarMSGcomWindows = 1 THEN ' InicializarMSGcomWindows : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ScriptLogExecutado IS NULL THEN ' ScriptLogExecutado : «Nulo» '
                                              WHEN  ScriptLogExecutado = 0 THEN ' ScriptLogExecutado : «Falso» '
                                              WHEN  ScriptLogExecutado = 1 THEN ' ScriptLogExecutado : «Verdadeiro» '
                                    END 
                         + '| EnderecoHttpSiscafweb : «' + RTRIM( ISNULL( CAST (EnderecoHttpSiscafweb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCliente : «' + RTRIM( ISNULL( CAST (TipoCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura1 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura2 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura3 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura4 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaBackup IS NULL THEN ' AlertaBackup : «Nulo» '
                                              WHEN  AlertaBackup = 0 THEN ' AlertaBackup : «Falso» '
                                              WHEN  AlertaBackup = 1 THEN ' AlertaBackup : «Verdadeiro» '
                                    END 
                         + '| DataAlertaBackup : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlertaBackup, 113 ),'Nulo'))+'» '
                         + '| ServidorEmailUsLogon : «' + RTRIM( ISNULL( CAST (ServidorEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEmailUsLogon : «' + RTRIM( ISNULL( CAST (PortaEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailUsLogon : «' + RTRIM( ISNULL( CAST (UsuarioEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmailUsLogon : «' + RTRIM( ISNULL( CAST (SenhaEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSLUsLogon IS NULL THEN ' EmailAutenticaSSLUsLogon : «Nulo» '
                                              WHEN  EmailAutenticaSSLUsLogon = 0 THEN ' EmailAutenticaSSLUsLogon : «Falso» '
                                              WHEN  EmailAutenticaSSLUsLogon = 1 THEN ' EmailAutenticaSSLUsLogon : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ScriptCEPExecutado IS NULL THEN ' ScriptCEPExecutado : «Nulo» '
                                              WHEN  ScriptCEPExecutado = 0 THEN ' ScriptCEPExecutado : «Falso» '
                                              WHEN  ScriptCEPExecutado = 1 THEN ' ScriptCEPExecutado : «Verdadeiro» '
                                    END 
                         + '| EmailAuthenticationMethod : «' + RTRIM( ISNULL( CAST (EmailAuthenticationMethod AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnvioEmailLimiteQtd : «' + RTRIM( ISNULL( CAST (EnvioEmailLimiteQtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnvioEmailLimiteTempo : «' + RTRIM( ISNULL( CONVERT (CHAR, EnvioEmailLimiteTempo, 113 ),'Nulo'))+'» ' FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'SeparadorExportacaotxt : «' + RTRIM( ISNULL( CAST (SeparadorExportacaotxt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaCredito IS NULL THEN ' AgrupaCredito : «Nulo» '
                                              WHEN  AgrupaCredito = 0 THEN ' AgrupaCredito : «Falso» '
                                              WHEN  AgrupaCredito = 1 THEN ' AgrupaCredito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReceitaUnitaria IS NULL THEN ' ReceitaUnitaria : «Nulo» '
                                              WHEN  ReceitaUnitaria = 0 THEN ' ReceitaUnitaria : «Falso» '
                                              WHEN  ReceitaUnitaria = 1 THEN ' ReceitaUnitaria : «Verdadeiro» '
                                    END 
                         + '| DigitosGrupo : «' + RTRIM( ISNULL( CAST (DigitosGrupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel1 : «' + RTRIM( ISNULL( CAST (UnidadeNivel1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel2 : «' + RTRIM( ISNULL( CAST (UnidadeNivel2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel3 : «' + RTRIM( ISNULL( CAST (UnidadeNivel3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoOC : «' + RTRIM( ISNULL( CAST (PrefixoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoOC : «' + RTRIM( ISNULL( CAST (SufixoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoOC : «' + RTRIM( ISNULL( CAST (IncrementoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoOS : «' + RTRIM( ISNULL( CAST (PrefixoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoOS : «' + RTRIM( ISNULL( CAST (SufixoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoOS : «' + RTRIM( ISNULL( CAST (IncrementoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoCS : «' + RTRIM( ISNULL( CAST (PrefixoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoCS : «' + RTRIM( ISNULL( CAST (SufixoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoCS : «' + RTRIM( ISNULL( CAST (IncrementoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoContrato : «' + RTRIM( ISNULL( CAST (PrefixoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoContrato : «' + RTRIM( ISNULL( CAST (SufixoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoContrato : «' + RTRIM( ISNULL( CAST (IncrementoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoLicitacao : «' + RTRIM( ISNULL( CAST (PrefixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoLicitacao : «' + RTRIM( ISNULL( CAST (SufixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoLicitacao : «' + RTRIM( ISNULL( CAST (IncrementoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoBemMovel : «' + RTRIM( ISNULL( CAST (PrefixoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoBemMovel : «' + RTRIM( ISNULL( CAST (SufixoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoBemMovel : «' + RTRIM( ISNULL( CAST (IncrementoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoBemImovel : «' + RTRIM( ISNULL( CAST (PrefixoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoBemImovel : «' + RTRIM( ISNULL( CAST (SufixoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoBemImovel : «' + RTRIM( ISNULL( CAST (IncrementoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorCotacao : «' + RTRIM( ISNULL( CAST (ServidorCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioCotacao : «' + RTRIM( ISNULL( CAST (UsuarioCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaCotacao : «' + RTRIM( ISNULL( CAST (SenhaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostCotacao : «' + RTRIM( ISNULL( CAST (HostCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaCotacao : «' + RTRIM( ISNULL( CAST (PortaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCotacao : «' + RTRIM( ISNULL( CAST (EmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinkCotacao : «' + RTRIM( ISNULL( CAST (LinkCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CodigoBarraAutomatico IS NULL THEN ' CodigoBarraAutomatico : «Nulo» '
                                              WHEN  CodigoBarraAutomatico = 0 THEN ' CodigoBarraAutomatico : «Falso» '
                                              WHEN  CodigoBarraAutomatico = 1 THEN ' CodigoBarraAutomatico : «Verdadeiro» '
                                    END 
                         + '| PrefixoCodigoBarra : «' + RTRIM( ISNULL( CAST (PrefixoCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoCodigoBarra : «' + RTRIM( ISNULL( CAST (SufixoCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TerminadorCodigoBarra : «' + RTRIM( ISNULL( CAST (TerminadorCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeparadorCampos : «' + RTRIM( ISNULL( CAST (SeparadorCampos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormatoData : «' + RTRIM( ISNULL( CAST (FormatoData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiretorioArquivos : «' + RTRIM( ISNULL( CAST (DiretorioArquivos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeparadorData : «' + RTRIM( ISNULL( CAST (SeparadorData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OrcamentoCCustoporConta IS NULL THEN ' OrcamentoCCustoporConta : «Nulo» '
                                              WHEN  OrcamentoCCustoporConta = 0 THEN ' OrcamentoCCustoporConta : «Falso» '
                                              WHEN  OrcamentoCCustoporConta = 1 THEN ' OrcamentoCCustoporConta : «Verdadeiro» '
                                    END 
                         + '| PrefixoCertificacao : «' + RTRIM( ISNULL( CAST (PrefixoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoItem : «' + RTRIM( ISNULL( CAST (PrefixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoItem : «' + RTRIM( ISNULL( CAST (SufixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoItem : «' + RTRIM( ISNULL( CAST (IncrementoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TransferePagamentos IS NULL THEN ' TransferePagamentos : «Nulo» '
                                              WHEN  TransferePagamentos = 0 THEN ' TransferePagamentos : «Falso» '
                                              WHEN  TransferePagamentos = 1 THEN ' TransferePagamentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereRecebimentos IS NULL THEN ' TransfereRecebimentos : «Nulo» '
                                              WHEN  TransfereRecebimentos = 0 THEN ' TransfereRecebimentos : «Falso» '
                                              WHEN  TransfereRecebimentos = 1 THEN ' TransfereRecebimentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereRestos IS NULL THEN ' TransfereRestos : «Nulo» '
                                              WHEN  TransfereRestos = 0 THEN ' TransfereRestos : «Falso» '
                                              WHEN  TransfereRestos = 1 THEN ' TransfereRestos : «Verdadeiro» '
                                    END 
                         + '| DataContabilInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilInicial, 113 ),'Nulo'))+'» '
                         + '| DataContabilFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilFinal, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeSaldo IS NULL THEN ' ImprimeSaldo : «Nulo» '
                                              WHEN  ImprimeSaldo = 0 THEN ' ImprimeSaldo : «Falso» '
                                              WHEN  ImprimeSaldo = 1 THEN ' ImprimeSaldo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SaldoObrigatorio IS NULL THEN ' SaldoObrigatorio : «Nulo» '
                                              WHEN  SaldoObrigatorio = 0 THEN ' SaldoObrigatorio : «Falso» '
                                              WHEN  SaldoObrigatorio = 1 THEN ' SaldoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PreEmpenho IS NULL THEN ' PreEmpenho : «Nulo» '
                                              WHEN  PreEmpenho = 0 THEN ' PreEmpenho : «Falso» '
                                              WHEN  PreEmpenho = 1 THEN ' PreEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraRestos IS NULL THEN ' MostraRestos : «Nulo» '
                                              WHEN  MostraRestos = 0 THEN ' MostraRestos : «Falso» '
                                              WHEN  MostraRestos = 1 THEN ' MostraRestos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraDadosBanco IS NULL THEN ' MostraDadosBanco : «Nulo» '
                                              WHEN  MostraDadosBanco = 0 THEN ' MostraDadosBanco : «Falso» '
                                              WHEN  MostraDadosBanco = 1 THEN ' MostraDadosBanco : «Verdadeiro» '
                                    END 
                         + '| TituloNota : «' + RTRIM( ISNULL( CAST (TituloNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloBaixa : «' + RTRIM( ISNULL( CAST (TituloBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Controlar : «' + RTRIM( ISNULL( CAST (Controlar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamentoFolha : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoAvulso IS NULL THEN ' PermitePagamentoAvulso : «Nulo» '
                                              WHEN  PermitePagamentoAvulso = 0 THEN ' PermitePagamentoAvulso : «Falso» '
                                              WHEN  PermitePagamentoAvulso = 1 THEN ' PermitePagamentoAvulso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereMovimentosFinanceiros IS NULL THEN ' TransfereMovimentosFinanceiros : «Nulo» '
                                              WHEN  TransfereMovimentosFinanceiros = 0 THEN ' TransfereMovimentosFinanceiros : «Falso» '
                                              WHEN  TransfereMovimentosFinanceiros = 1 THEN ' TransfereMovimentosFinanceiros : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeEndereco IS NULL THEN ' ImprimeEndereco : «Nulo» '
                                              WHEN  ImprimeEndereco = 0 THEN ' ImprimeEndereco : «Falso» '
                                              WHEN  ImprimeEndereco = 1 THEN ' ImprimeEndereco : «Verdadeiro» '
                                    END 
                         + '| DataContabilizacaoPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPagamento, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoReceita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoReceita, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoRestos : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoRestos, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CriaCentroCustoEmpenho IS NULL THEN ' CriaCentroCustoEmpenho : «Nulo» '
                                              WHEN  CriaCentroCustoEmpenho = 0 THEN ' CriaCentroCustoEmpenho : «Falso» '
                                              WHEN  CriaCentroCustoEmpenho = 1 THEN ' CriaCentroCustoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CalcularCustoReceitaAntes IS NULL THEN ' CalcularCustoReceitaAntes : «Nulo» '
                                              WHEN  CalcularCustoReceitaAntes = 0 THEN ' CalcularCustoReceitaAntes : «Falso» '
                                              WHEN  CalcularCustoReceitaAntes = 1 THEN ' CalcularCustoReceitaAntes : «Verdadeiro» '
                                    END 
                         + '| IdTipoPagamentoReceita : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaCustoFixoVariado IS NULL THEN ' UsaCustoFixoVariado : «Nulo» '
                                              WHEN  UsaCustoFixoVariado = 0 THEN ' UsaCustoFixoVariado : «Falso» '
                                              WHEN  UsaCustoFixoVariado = 1 THEN ' UsaCustoFixoVariado : «Verdadeiro» '
                                    END 
                         + '| PathUpdate : «' + RTRIM( ISNULL( CAST (PathUpdate AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathArquivos : «' + RTRIM( ISNULL( CAST (PathArquivos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPagamento IS NULL THEN ' TravamentoCCustoPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoPagamento = 0 THEN ' TravamentoCCustoPagamento : «Falso» '
                                              WHEN  TravamentoCCustoPagamento = 1 THEN ' TravamentoCCustoPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostaCentroCustoNotaOrcamentaria IS NULL THEN ' MostaCentroCustoNotaOrcamentaria : «Nulo» '
                                              WHEN  MostaCentroCustoNotaOrcamentaria = 0 THEN ' MostaCentroCustoNotaOrcamentaria : «Falso» '
                                              WHEN  MostaCentroCustoNotaOrcamentaria = 1 THEN ' MostaCentroCustoNotaOrcamentaria : «Verdadeiro» '
                                    END 
                         + '| ServidorSiscafWeb : «' + RTRIM( ISNULL( CAST (ServidorSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioSiscafWeb : «' + RTRIM( ISNULL( CAST (UsuarioSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaSiscafWeb : «' + RTRIM( ISNULL( CAST (SenhaSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFolha : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaMovimentoFolha : «' + RTRIM( ISNULL( CAST (IdPessoaMovimentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoBanco : «' + RTRIM( ISNULL( CAST (VersaoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathBackup : «' + RTRIM( ISNULL( CAST (PathBackup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgendamentoBackup : «' + RTRIM( ISNULL( CAST (AgendamentoBackup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaExecucaoAgBackup : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaExecucaoAgBackup, 113 ),'Nulo'))+'» '
                         + '| PathAuditoria : «' + RTRIM( ISNULL( CAST (PathAuditoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgendamentoAuditoria : «' + RTRIM( ISNULL( CAST (AgendamentoAuditoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaExecucaoAgAuditoria : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaExecucaoAgAuditoria, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraHistorico IS NULL THEN ' AlteraHistorico : «Nulo» '
                                              WHEN  AlteraHistorico = 0 THEN ' AlteraHistorico : «Falso» '
                                              WHEN  AlteraHistorico = 1 THEN ' AlteraHistorico : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraDataImpressaoBaixaPag IS NULL THEN ' MostraDataImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraDataImpressaoBaixaPag = 0 THEN ' MostraDataImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraDataImpressaoBaixaPag = 1 THEN ' MostraDataImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarRepasse IS NULL THEN ' AplicarRepasse : «Nulo» '
                                              WHEN  AplicarRepasse = 0 THEN ' AplicarRepasse : «Falso» '
                                              WHEN  AplicarRepasse = 1 THEN ' AplicarRepasse : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CriaPagamentoRepasseRec IS NULL THEN ' CriaPagamentoRepasseRec : «Nulo» '
                                              WHEN  CriaPagamentoRepasseRec = 0 THEN ' CriaPagamentoRepasseRec : «Falso» '
                                              WHEN  CriaPagamentoRepasseRec = 1 THEN ' CriaPagamentoRepasseRec : «Verdadeiro» '
                                    END 
                         + '| IdTipoPagamentoRepasse : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgrupaCreditoSipro : «' + RTRIM( ISNULL( CAST (AgrupaCreditoSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaPagamentoCusto IS NULL THEN ' AgrupaPagamentoCusto : «Nulo» '
                                              WHEN  AgrupaPagamentoCusto = 0 THEN ' AgrupaPagamentoCusto : «Falso» '
                                              WHEN  AgrupaPagamentoCusto = 1 THEN ' AgrupaPagamentoCusto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraOcorrencia IS NULL THEN ' MostraOcorrencia : «Nulo» '
                                              WHEN  MostraOcorrencia = 0 THEN ' MostraOcorrencia : «Falso» '
                                              WHEN  MostraOcorrencia = 1 THEN ' MostraOcorrencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IntegraSiproAgenda IS NULL THEN ' IntegraSiproAgenda : «Nulo» '
                                              WHEN  IntegraSiproAgenda = 0 THEN ' IntegraSiproAgenda : «Falso» '
                                              WHEN  IntegraSiproAgenda = 1 THEN ' IntegraSiproAgenda : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfContasPagar IS NULL THEN ' TransfContasPagar : «Nulo» '
                                              WHEN  TransfContasPagar = 0 THEN ' TransfContasPagar : «Falso» '
                                              WHEN  TransfContasPagar = 1 THEN ' TransfContasPagar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfContasReceber IS NULL THEN ' TransfContasReceber : «Nulo» '
                                              WHEN  TransfContasReceber = 0 THEN ' TransfContasReceber : «Falso» '
                                              WHEN  TransfContasReceber = 1 THEN ' TransfContasReceber : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfMovimentoFinanceiro IS NULL THEN ' TransfMovimentoFinanceiro : «Nulo» '
                                              WHEN  TransfMovimentoFinanceiro = 0 THEN ' TransfMovimentoFinanceiro : «Falso» '
                                              WHEN  TransfMovimentoFinanceiro = 1 THEN ' TransfMovimentoFinanceiro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraLancSiscontwFluxoCaixa IS NULL THEN ' MostraLancSiscontwFluxoCaixa : «Nulo» '
                                              WHEN  MostraLancSiscontwFluxoCaixa = 0 THEN ' MostraLancSiscontwFluxoCaixa : «Falso» '
                                              WHEN  MostraLancSiscontwFluxoCaixa = 1 THEN ' MostraLancSiscontwFluxoCaixa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeImagensRelacaoCredito IS NULL THEN ' ExibeImagensRelacaoCredito : «Nulo» '
                                              WHEN  ExibeImagensRelacaoCredito = 0 THEN ' ExibeImagensRelacaoCredito : «Falso» '
                                              WHEN  ExibeImagensRelacaoCredito = 1 THEN ' ExibeImagensRelacaoCredito : «Verdadeiro» '
                                    END 
                         + '| NumeroControleDRISS : «' + RTRIM( ISNULL( CAST (NumeroControleDRISS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathUpdateViaLogon : «' + RTRIM( ISNULL( CAST (PathUpdateViaLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoCC : «' + RTRIM( ISNULL( CAST (AcessoCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoCC : «' + RTRIM( ISNULL( CAST (DataAcessoCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteCC : «' + RTRIM( ISNULL( CAST (DataLimiteCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostrarFavorecidoCustoReceita IS NULL THEN ' MostrarFavorecidoCustoReceita : «Nulo» '
                                              WHEN  MostrarFavorecidoCustoReceita = 0 THEN ' MostrarFavorecidoCustoReceita : «Falso» '
                                              WHEN  MostrarFavorecidoCustoReceita = 1 THEN ' MostrarFavorecidoCustoReceita : «Verdadeiro» '
                                    END 
                         + '| IdPessoaFavorecido : «' + RTRIM( ISNULL( CAST (IdPessoaFavorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag IS NULL THEN ' MostraVlBaseImpImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 0 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 1 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| QtdeUsuariosTransferidos : «' + RTRIM( ISNULL( CAST (QtdeUsuariosTransferidos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImpressaoFrenteVerso IS NULL THEN ' ImpressaoFrenteVerso : «Nulo» '
                                              WHEN  ImpressaoFrenteVerso = 0 THEN ' ImpressaoFrenteVerso : «Falso» '
                                              WHEN  ImpressaoFrenteVerso = 1 THEN ' ImpressaoFrenteVerso : «Verdadeiro» '
                                    END 
                         + '| Eventual : «' + RTRIM( ISNULL( CAST (Eventual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTransfContasPagar : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfContasPagar, 113 ),'Nulo'))+'» '
                         + '| DataTransfContasReceber : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfContasReceber, 113 ),'Nulo'))+'» '
                         + '| DataTransfMovimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfMovimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DES IS NULL THEN ' DES : «Nulo» '
                                              WHEN  DES = 0 THEN ' DES : «Falso» '
                                              WHEN  DES = 1 THEN ' DES : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PrevRecolhimentoTributo IS NULL THEN ' PrevRecolhimentoTributo : «Nulo» '
                                              WHEN  PrevRecolhimentoTributo = 0 THEN ' PrevRecolhimentoTributo : «Falso» '
                                              WHEN  PrevRecolhimentoTributo = 1 THEN ' PrevRecolhimentoTributo : «Verdadeiro» '
                                    END 
                         + '| PathArquivosExportacao : «' + RTRIM( ISNULL( CAST (PathArquivosExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRelacaoCredNumerada IS NULL THEN ' UtilizaRelacaoCredNumerada : «Nulo» '
                                              WHEN  UtilizaRelacaoCredNumerada = 0 THEN ' UtilizaRelacaoCredNumerada : «Falso» '
                                              WHEN  UtilizaRelacaoCredNumerada = 1 THEN ' UtilizaRelacaoCredNumerada : «Verdadeiro» '
                                    END 
                         + '| PrefixoRC : «' + RTRIM( ISNULL( CAST (PrefixoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoRC : «' + RTRIM( ISNULL( CAST (SufixoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoRC : «' + RTRIM( ISNULL( CAST (IncrementoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso IS NULL THEN ' UtilizaRelacaoCredNumeradaProcesso : «Nulo» '
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso = 0 THEN ' UtilizaRelacaoCredNumeradaProcesso : «Falso» '
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso = 1 THEN ' UtilizaRelacaoCredNumeradaProcesso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CobrancaCompartilhadaDefaultReceita IS NULL THEN ' CobrancaCompartilhadaDefaultReceita : «Nulo» '
                                              WHEN  CobrancaCompartilhadaDefaultReceita = 0 THEN ' CobrancaCompartilhadaDefaultReceita : «Falso» '
                                              WHEN  CobrancaCompartilhadaDefaultReceita = 1 THEN ' CobrancaCompartilhadaDefaultReceita : «Verdadeiro» '
                                    END 
                         + '| IdPessoaTransferenciaReceita : «' + RTRIM( ISNULL( CAST (IdPessoaTransferenciaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamentoTransferenciaReceita : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoTransferenciaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFinanceiroTransfReceita : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFinanceiroTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPrestacao : «' + RTRIM( ISNULL( CAST (IdPessoaPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagPrestacao : «' + RTRIM( ISNULL( CAST (IdTipoPagPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinPrestacao : «' + RTRIM( ISNULL( CAST (IdTipoMovFinPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CFPS IS NULL THEN ' CFPS : «Nulo» '
                                              WHEN  CFPS = 0 THEN ' CFPS : «Falso» '
                                              WHEN  CFPS = 1 THEN ' CFPS : «Verdadeiro» '
                                    END 
                         + '| DataAlteracaoLancFinanceiroInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracaoLancFinanceiroInicial, 113 ),'Nulo'))+'» '
                         + '| DataAlteracaoLancFinanceiroFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracaoLancFinanceiroFinal, 113 ),'Nulo'))+'» '
                         + '| IdEstadoConservacaoPadrao : «' + RTRIM( ISNULL( CAST (IdEstadoConservacaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorEmail : «' + RTRIM( ISNULL( CAST (ServidorEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEmail : «' + RTRIM( ISNULL( CAST (PortaEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmail : «' + RTRIM( ISNULL( CAST (UsuarioEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmail : «' + RTRIM( ISNULL( CAST (SenhaEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito1 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito2 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito3 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito4 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncluirHistEmpenho IS NULL THEN ' IncluirHistEmpenho : «Nulo» '
                                              WHEN  IncluirHistEmpenho = 0 THEN ' IncluirHistEmpenho : «Falso» '
                                              WHEN  IncluirHistEmpenho = 1 THEN ' IncluirHistEmpenho : «Verdadeiro» '
                                    END 
                         + '| DataLimiteProcesso : «' + RTRIM( ISNULL( CAST (DataLimiteProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoProcesso : «' + RTRIM( ISNULL( CAST (DataAcessoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoProcesso : «' + RTRIM( ISNULL( CAST (AcessoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteFiscalizacao : «' + RTRIM( ISNULL( CAST (DataLimiteFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoFiscalizacao : «' + RTRIM( ISNULL( CAST (DataAcessoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoFiscalizacao : «' + RTRIM( ISNULL( CAST (AcessoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  imprimeDataHoraRel IS NULL THEN ' imprimeDataHoraRel : «Nulo» '
                                              WHEN  imprimeDataHoraRel = 0 THEN ' imprimeDataHoraRel : «Falso» '
                                              WHEN  imprimeDataHoraRel = 1 THEN ' imprimeDataHoraRel : «Verdadeiro» '
                                    END 
                         + '| PathArquivosSG : «' + RTRIM( ISNULL( CAST (PathArquivosSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinRecRealizar : «' + RTRIM( ISNULL( CAST (IdTipoMovFinRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPgtoRecRealizar : «' + RTRIM( ISNULL( CAST (IdTipoPgtoRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaRecRealizar : «' + RTRIM( ISNULL( CAST (IdPessoaRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinRecRealizarCartao : «' + RTRIM( ISNULL( CAST (IdTipoMovFinRecRealizarCartao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailCotacao : «' + RTRIM( ISNULL( CAST (UsuarioEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmailCotacao : «' + RTRIM( ISNULL( CAST (SenhaEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ServidorRequerAutenticacao IS NULL THEN ' ServidorRequerAutenticacao : «Nulo» '
                                              WHEN  ServidorRequerAutenticacao = 0 THEN ' ServidorRequerAutenticacao : «Falso» '
                                              WHEN  ServidorRequerAutenticacao = 1 THEN ' ServidorRequerAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CPFCNPJObrigatorio IS NULL THEN ' CPFCNPJObrigatorio : «Nulo» '
                                              WHEN  CPFCNPJObrigatorio = 0 THEN ' CPFCNPJObrigatorio : «Falso» '
                                              WHEN  CPFCNPJObrigatorio = 1 THEN ' CPFCNPJObrigatorio : «Verdadeiro» '
                                    END 
                         + '| DataCriaUsuarioSql : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriaUsuarioSql, 113 ),'Nulo'))+'» '
                         + '| IdTipoPagamentoRecRealiz : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaFavorecidoRecRealiz : «' + RTRIM( ISNULL( CAST (IdPessoaFavorecidoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ManterArquivoRetorno IS NULL THEN ' ManterArquivoRetorno : «Nulo» '
                                              WHEN  ManterArquivoRetorno = 0 THEN ' ManterArquivoRetorno : «Falso» '
                                              WHEN  ManterArquivoRetorno = 1 THEN ' ManterArquivoRetorno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirLogoReduzidoNoCabecalho IS NULL THEN ' ExibirLogoReduzidoNoCabecalho : «Nulo» '
                                              WHEN  ExibirLogoReduzidoNoCabecalho = 0 THEN ' ExibirLogoReduzidoNoCabecalho : «Falso» '
                                              WHEN  ExibirLogoReduzidoNoCabecalho = 1 THEN ' ExibirLogoReduzidoNoCabecalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirApenasLogoNoCabecalho IS NULL THEN ' ExibirApenasLogoNoCabecalho : «Nulo» '
                                              WHEN  ExibirApenasLogoNoCabecalho = 0 THEN ' ExibirApenasLogoNoCabecalho : «Falso» '
                                              WHEN  ExibirApenasLogoNoCabecalho = 1 THEN ' ExibirApenasLogoNoCabecalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaMovimentoFolha IS NULL THEN ' AtualizaMovimentoFolha : «Nulo» '
                                              WHEN  AtualizaMovimentoFolha = 0 THEN ' AtualizaMovimentoFolha : «Falso» '
                                              WHEN  AtualizaMovimentoFolha = 1 THEN ' AtualizaMovimentoFolha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaPagamentoFolha IS NULL THEN ' AtualizaPagamentoFolha : «Nulo» '
                                              WHEN  AtualizaPagamentoFolha = 0 THEN ' AtualizaPagamentoFolha : «Falso» '
                                              WHEN  AtualizaPagamentoFolha = 1 THEN ' AtualizaPagamentoFolha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaPrevReceita IS NULL THEN ' AtualizaPrevReceita : «Nulo» '
                                              WHEN  AtualizaPrevReceita = 0 THEN ' AtualizaPrevReceita : «Falso» '
                                              WHEN  AtualizaPrevReceita = 1 THEN ' AtualizaPrevReceita : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirObjetoSocialCRC IS NULL THEN ' ExibirObjetoSocialCRC : «Nulo» '
                                              WHEN  ExibirObjetoSocialCRC = 0 THEN ' ExibirObjetoSocialCRC : «Falso» '
                                              WHEN  ExibirObjetoSocialCRC = 1 THEN ' ExibirObjetoSocialCRC : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaRodapePadraoCRC IS NULL THEN ' UtilizaRodapePadraoCRC : «Nulo» '
                                              WHEN  UtilizaRodapePadraoCRC = 0 THEN ' UtilizaRodapePadraoCRC : «Falso» '
                                              WHEN  UtilizaRodapePadraoCRC = 1 THEN ' UtilizaRodapePadraoCRC : «Verdadeiro» '
                                    END 
                         + '| IdCCCustoReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRepasseReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoRepasseReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustodia : «' + RTRIM( ISNULL( CAST (IdContaCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaTransfReceita : «' + RTRIM( ISNULL( CAST (IdContaTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDevolucaoRecARealizar : «' + RTRIM( ISNULL( CAST (IdContaDevolucaoRecARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebitoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaDebitoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogExterno : «' + RTRIM( ISNULL( CAST (LogExterno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeLogoCantoEsquerdo IS NULL THEN ' ExibeLogoCantoEsquerdo : «Nulo» '
                                              WHEN  ExibeLogoCantoEsquerdo = 0 THEN ' ExibeLogoCantoEsquerdo : «Falso» '
                                              WHEN  ExibeLogoCantoEsquerdo = 1 THEN ' ExibeLogoCantoEsquerdo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaLogoRelatoriosSISCONT IS NULL THEN ' UtilizaLogoRelatoriosSISCONT : «Nulo» '
                                              WHEN  UtilizaLogoRelatoriosSISCONT = 0 THEN ' UtilizaLogoRelatoriosSISCONT : «Falso» '
                                              WHEN  UtilizaLogoRelatoriosSISCONT = 1 THEN ' UtilizaLogoRelatoriosSISCONT : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO IS NULL THEN ' ExibirLogoNotasEmpenhoSIPRO : «Nulo» '
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO = 0 THEN ' ExibirLogoNotasEmpenhoSIPRO : «Falso» '
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO = 1 THEN ' ExibirLogoNotasEmpenhoSIPRO : «Verdadeiro» '
                                    END 
                         + '| BandejaImpEmpenho : «' + RTRIM( ISNULL( CAST (BandejaImpEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BandejaImpPreEmpenho : «' + RTRIM( ISNULL( CAST (BandejaImpPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizarImpEmpenho IS NULL THEN ' VisualizarImpEmpenho : «Nulo» '
                                              WHEN  VisualizarImpEmpenho = 0 THEN ' VisualizarImpEmpenho : «Falso» '
                                              WHEN  VisualizarImpEmpenho = 1 THEN ' VisualizarImpEmpenho : «Verdadeiro» '
                                    END 
                         + '| ParametroImpFrenteVerso : «' + RTRIM( ISNULL( CAST (ParametroImpFrenteVerso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoPDR : «' + RTRIM( ISNULL( CAST (PrefixoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoPDR : «' + RTRIM( ISNULL( CAST (SufixoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoPDR : «' + RTRIM( ISNULL( CAST (IncrementoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoDDR : «' + RTRIM( ISNULL( CAST (PrefixoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoDDR : «' + RTRIM( ISNULL( CAST (SufixoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoDDR : «' + RTRIM( ISNULL( CAST (IncrementoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TributaImportacao IS NULL THEN ' TributaImportacao : «Nulo» '
                                              WHEN  TributaImportacao = 0 THEN ' TributaImportacao : «Falso» '
                                              WHEN  TributaImportacao = 1 THEN ' TributaImportacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAjustesPessoasSiproSG IS NULL THEN ' BloquearAjustesPessoasSiproSG : «Nulo» '
                                              WHEN  BloquearAjustesPessoasSiproSG = 0 THEN ' BloquearAjustesPessoasSiproSG : «Falso» '
                                              WHEN  BloquearAjustesPessoasSiproSG = 1 THEN ' BloquearAjustesPessoasSiproSG : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearPessoasSiproSG IS NULL THEN ' BloquearPessoasSiproSG : «Nulo» '
                                              WHEN  BloquearPessoasSiproSG = 0 THEN ' BloquearPessoasSiproSG : «Falso» '
                                              WHEN  BloquearPessoasSiproSG = 1 THEN ' BloquearPessoasSiproSG : «Verdadeiro» '
                                    END 
                         + '| EmailCopiaSG : «' + RTRIM( ISNULL( CAST (EmailCopiaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaPagamentoAssociacoes IS NULL THEN ' UtilizaPagamentoAssociacoes : «Nulo» '
                                              WHEN  UtilizaPagamentoAssociacoes = 0 THEN ' UtilizaPagamentoAssociacoes : «Falso» '
                                              WHEN  UtilizaPagamentoAssociacoes = 1 THEN ' UtilizaPagamentoAssociacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho IS NULL THEN ' PrestacaoContasFavorecidoDoEmpenho : «Nulo» '
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho = 0 THEN ' PrestacaoContasFavorecidoDoEmpenho : «Falso» '
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho = 1 THEN ' PrestacaoContasFavorecidoDoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IncluirHistRestosEmpenho IS NULL THEN ' IncluirHistRestosEmpenho : «Nulo» '
                                              WHEN  IncluirHistRestosEmpenho = 0 THEN ' IncluirHistRestosEmpenho : «Falso» '
                                              WHEN  IncluirHistRestosEmpenho = 1 THEN ' IncluirHistRestosEmpenho : «Verdadeiro» '
                                    END 
                         + '| ServidorFTP : «' + RTRIM( ISNULL( CAST (ServidorFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PastaFTP : «' + RTRIM( ISNULL( CAST (PastaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaAlertaCertificacao IS NULL THEN ' UtilizaAlertaCertificacao : «Nulo» '
                                              WHEN  UtilizaAlertaCertificacao = 0 THEN ' UtilizaAlertaCertificacao : «Falso» '
                                              WHEN  UtilizaAlertaCertificacao = 1 THEN ' UtilizaAlertaCertificacao : «Verdadeiro» '
                                    END 
                         + '| EmailOrigem : «' + RTRIM( ISNULL( CAST (EmailOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAutorizacaoImpressao IS NULL THEN ' UsaAutorizacaoImpressao : «Nulo» '
                                              WHEN  UsaAutorizacaoImpressao = 0 THEN ' UsaAutorizacaoImpressao : «Falso» '
                                              WHEN  UsaAutorizacaoImpressao = 1 THEN ' UsaAutorizacaoImpressao : «Verdadeiro» '
                                    END 
                         + '| EmailAutorizacaoImpressao : «' + RTRIM( ISNULL( CAST (EmailAutorizacaoImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLSAD : «' + RTRIM( ISNULL( CAST (URLSAD AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PCEnderecoWSDL : «' + RTRIM( ISNULL( CAST (PCEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAtualizacaoMSG : «' + RTRIM( ISNULL( CAST (TempoAtualizacaoMSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LiqEnderecoWSDL : «' + RTRIM( ISNULL( CAST (LiqEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LancEnderecoWSDL : «' + RTRIM( ISNULL( CAST (LancEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImportaFolhaCentroCusto11Char IS NULL THEN ' ImportaFolhaCentroCusto11Char : «Nulo» '
                                              WHEN  ImportaFolhaCentroCusto11Char = 0 THEN ' ImportaFolhaCentroCusto11Char : «Falso» '
                                              WHEN  ImportaFolhaCentroCusto11Char = 1 THEN ' ImportaFolhaCentroCusto11Char : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ServidorRequerAutenticacaoSSL IS NULL THEN ' ServidorRequerAutenticacaoSSL : «Nulo» '
                                              WHEN  ServidorRequerAutenticacaoSSL = 0 THEN ' ServidorRequerAutenticacaoSSL : «Falso» '
                                              WHEN  ServidorRequerAutenticacaoSSL = 1 THEN ' ServidorRequerAutenticacaoSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  InicializarMSGcomWindows IS NULL THEN ' InicializarMSGcomWindows : «Nulo» '
                                              WHEN  InicializarMSGcomWindows = 0 THEN ' InicializarMSGcomWindows : «Falso» '
                                              WHEN  InicializarMSGcomWindows = 1 THEN ' InicializarMSGcomWindows : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ScriptLogExecutado IS NULL THEN ' ScriptLogExecutado : «Nulo» '
                                              WHEN  ScriptLogExecutado = 0 THEN ' ScriptLogExecutado : «Falso» '
                                              WHEN  ScriptLogExecutado = 1 THEN ' ScriptLogExecutado : «Verdadeiro» '
                                    END 
                         + '| EnderecoHttpSiscafweb : «' + RTRIM( ISNULL( CAST (EnderecoHttpSiscafweb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCliente : «' + RTRIM( ISNULL( CAST (TipoCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura1 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura2 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura3 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura4 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaBackup IS NULL THEN ' AlertaBackup : «Nulo» '
                                              WHEN  AlertaBackup = 0 THEN ' AlertaBackup : «Falso» '
                                              WHEN  AlertaBackup = 1 THEN ' AlertaBackup : «Verdadeiro» '
                                    END 
                         + '| DataAlertaBackup : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlertaBackup, 113 ),'Nulo'))+'» '
                         + '| ServidorEmailUsLogon : «' + RTRIM( ISNULL( CAST (ServidorEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEmailUsLogon : «' + RTRIM( ISNULL( CAST (PortaEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailUsLogon : «' + RTRIM( ISNULL( CAST (UsuarioEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmailUsLogon : «' + RTRIM( ISNULL( CAST (SenhaEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSLUsLogon IS NULL THEN ' EmailAutenticaSSLUsLogon : «Nulo» '
                                              WHEN  EmailAutenticaSSLUsLogon = 0 THEN ' EmailAutenticaSSLUsLogon : «Falso» '
                                              WHEN  EmailAutenticaSSLUsLogon = 1 THEN ' EmailAutenticaSSLUsLogon : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ScriptCEPExecutado IS NULL THEN ' ScriptCEPExecutado : «Nulo» '
                                              WHEN  ScriptCEPExecutado = 0 THEN ' ScriptCEPExecutado : «Falso» '
                                              WHEN  ScriptCEPExecutado = 1 THEN ' ScriptCEPExecutado : «Verdadeiro» '
                                    END 
                         + '| EmailAuthenticationMethod : «' + RTRIM( ISNULL( CAST (EmailAuthenticationMethod AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnvioEmailLimiteQtd : «' + RTRIM( ISNULL( CAST (EnvioEmailLimiteQtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnvioEmailLimiteTempo : «' + RTRIM( ISNULL( CONVERT (CHAR, EnvioEmailLimiteTempo, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'SeparadorExportacaotxt : «' + RTRIM( ISNULL( CAST (SeparadorExportacaotxt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaCredito IS NULL THEN ' AgrupaCredito : «Nulo» '
                                              WHEN  AgrupaCredito = 0 THEN ' AgrupaCredito : «Falso» '
                                              WHEN  AgrupaCredito = 1 THEN ' AgrupaCredito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReceitaUnitaria IS NULL THEN ' ReceitaUnitaria : «Nulo» '
                                              WHEN  ReceitaUnitaria = 0 THEN ' ReceitaUnitaria : «Falso» '
                                              WHEN  ReceitaUnitaria = 1 THEN ' ReceitaUnitaria : «Verdadeiro» '
                                    END 
                         + '| DigitosGrupo : «' + RTRIM( ISNULL( CAST (DigitosGrupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel1 : «' + RTRIM( ISNULL( CAST (UnidadeNivel1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel2 : «' + RTRIM( ISNULL( CAST (UnidadeNivel2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeNivel3 : «' + RTRIM( ISNULL( CAST (UnidadeNivel3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoOC : «' + RTRIM( ISNULL( CAST (PrefixoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoOC : «' + RTRIM( ISNULL( CAST (SufixoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoOC : «' + RTRIM( ISNULL( CAST (IncrementoOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoOS : «' + RTRIM( ISNULL( CAST (PrefixoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoOS : «' + RTRIM( ISNULL( CAST (SufixoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoOS : «' + RTRIM( ISNULL( CAST (IncrementoOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoCS : «' + RTRIM( ISNULL( CAST (PrefixoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoCS : «' + RTRIM( ISNULL( CAST (SufixoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoCS : «' + RTRIM( ISNULL( CAST (IncrementoCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoContrato : «' + RTRIM( ISNULL( CAST (PrefixoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoContrato : «' + RTRIM( ISNULL( CAST (SufixoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoContrato : «' + RTRIM( ISNULL( CAST (IncrementoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoLicitacao : «' + RTRIM( ISNULL( CAST (PrefixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoLicitacao : «' + RTRIM( ISNULL( CAST (SufixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoLicitacao : «' + RTRIM( ISNULL( CAST (IncrementoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoBemMovel : «' + RTRIM( ISNULL( CAST (PrefixoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoBemMovel : «' + RTRIM( ISNULL( CAST (SufixoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoBemMovel : «' + RTRIM( ISNULL( CAST (IncrementoBemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoBemImovel : «' + RTRIM( ISNULL( CAST (PrefixoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoBemImovel : «' + RTRIM( ISNULL( CAST (SufixoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoBemImovel : «' + RTRIM( ISNULL( CAST (IncrementoBemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorCotacao : «' + RTRIM( ISNULL( CAST (ServidorCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioCotacao : «' + RTRIM( ISNULL( CAST (UsuarioCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaCotacao : «' + RTRIM( ISNULL( CAST (SenhaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostCotacao : «' + RTRIM( ISNULL( CAST (HostCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaCotacao : «' + RTRIM( ISNULL( CAST (PortaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCotacao : «' + RTRIM( ISNULL( CAST (EmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinkCotacao : «' + RTRIM( ISNULL( CAST (LinkCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CodigoBarraAutomatico IS NULL THEN ' CodigoBarraAutomatico : «Nulo» '
                                              WHEN  CodigoBarraAutomatico = 0 THEN ' CodigoBarraAutomatico : «Falso» '
                                              WHEN  CodigoBarraAutomatico = 1 THEN ' CodigoBarraAutomatico : «Verdadeiro» '
                                    END 
                         + '| PrefixoCodigoBarra : «' + RTRIM( ISNULL( CAST (PrefixoCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoCodigoBarra : «' + RTRIM( ISNULL( CAST (SufixoCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TerminadorCodigoBarra : «' + RTRIM( ISNULL( CAST (TerminadorCodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeparadorCampos : «' + RTRIM( ISNULL( CAST (SeparadorCampos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormatoData : «' + RTRIM( ISNULL( CAST (FormatoData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiretorioArquivos : «' + RTRIM( ISNULL( CAST (DiretorioArquivos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeparadorData : «' + RTRIM( ISNULL( CAST (SeparadorData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OrcamentoCCustoporConta IS NULL THEN ' OrcamentoCCustoporConta : «Nulo» '
                                              WHEN  OrcamentoCCustoporConta = 0 THEN ' OrcamentoCCustoporConta : «Falso» '
                                              WHEN  OrcamentoCCustoporConta = 1 THEN ' OrcamentoCCustoporConta : «Verdadeiro» '
                                    END 
                         + '| PrefixoCertificacao : «' + RTRIM( ISNULL( CAST (PrefixoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoItem : «' + RTRIM( ISNULL( CAST (PrefixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoItem : «' + RTRIM( ISNULL( CAST (SufixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoItem : «' + RTRIM( ISNULL( CAST (IncrementoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TransferePagamentos IS NULL THEN ' TransferePagamentos : «Nulo» '
                                              WHEN  TransferePagamentos = 0 THEN ' TransferePagamentos : «Falso» '
                                              WHEN  TransferePagamentos = 1 THEN ' TransferePagamentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereRecebimentos IS NULL THEN ' TransfereRecebimentos : «Nulo» '
                                              WHEN  TransfereRecebimentos = 0 THEN ' TransfereRecebimentos : «Falso» '
                                              WHEN  TransfereRecebimentos = 1 THEN ' TransfereRecebimentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereRestos IS NULL THEN ' TransfereRestos : «Nulo» '
                                              WHEN  TransfereRestos = 0 THEN ' TransfereRestos : «Falso» '
                                              WHEN  TransfereRestos = 1 THEN ' TransfereRestos : «Verdadeiro» '
                                    END 
                         + '| DataContabilInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilInicial, 113 ),'Nulo'))+'» '
                         + '| DataContabilFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilFinal, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeSaldo IS NULL THEN ' ImprimeSaldo : «Nulo» '
                                              WHEN  ImprimeSaldo = 0 THEN ' ImprimeSaldo : «Falso» '
                                              WHEN  ImprimeSaldo = 1 THEN ' ImprimeSaldo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SaldoObrigatorio IS NULL THEN ' SaldoObrigatorio : «Nulo» '
                                              WHEN  SaldoObrigatorio = 0 THEN ' SaldoObrigatorio : «Falso» '
                                              WHEN  SaldoObrigatorio = 1 THEN ' SaldoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PreEmpenho IS NULL THEN ' PreEmpenho : «Nulo» '
                                              WHEN  PreEmpenho = 0 THEN ' PreEmpenho : «Falso» '
                                              WHEN  PreEmpenho = 1 THEN ' PreEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraRestos IS NULL THEN ' MostraRestos : «Nulo» '
                                              WHEN  MostraRestos = 0 THEN ' MostraRestos : «Falso» '
                                              WHEN  MostraRestos = 1 THEN ' MostraRestos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraDadosBanco IS NULL THEN ' MostraDadosBanco : «Nulo» '
                                              WHEN  MostraDadosBanco = 0 THEN ' MostraDadosBanco : «Falso» '
                                              WHEN  MostraDadosBanco = 1 THEN ' MostraDadosBanco : «Verdadeiro» '
                                    END 
                         + '| TituloNota : «' + RTRIM( ISNULL( CAST (TituloNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloBaixa : «' + RTRIM( ISNULL( CAST (TituloBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Controlar : «' + RTRIM( ISNULL( CAST (Controlar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamentoFolha : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoAvulso IS NULL THEN ' PermitePagamentoAvulso : «Nulo» '
                                              WHEN  PermitePagamentoAvulso = 0 THEN ' PermitePagamentoAvulso : «Falso» '
                                              WHEN  PermitePagamentoAvulso = 1 THEN ' PermitePagamentoAvulso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfereMovimentosFinanceiros IS NULL THEN ' TransfereMovimentosFinanceiros : «Nulo» '
                                              WHEN  TransfereMovimentosFinanceiros = 0 THEN ' TransfereMovimentosFinanceiros : «Falso» '
                                              WHEN  TransfereMovimentosFinanceiros = 1 THEN ' TransfereMovimentosFinanceiros : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeEndereco IS NULL THEN ' ImprimeEndereco : «Nulo» '
                                              WHEN  ImprimeEndereco = 0 THEN ' ImprimeEndereco : «Falso» '
                                              WHEN  ImprimeEndereco = 1 THEN ' ImprimeEndereco : «Verdadeiro» '
                                    END 
                         + '| DataContabilizacaoPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPagamento, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoReceita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoReceita, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoRestos : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoRestos, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CriaCentroCustoEmpenho IS NULL THEN ' CriaCentroCustoEmpenho : «Nulo» '
                                              WHEN  CriaCentroCustoEmpenho = 0 THEN ' CriaCentroCustoEmpenho : «Falso» '
                                              WHEN  CriaCentroCustoEmpenho = 1 THEN ' CriaCentroCustoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CalcularCustoReceitaAntes IS NULL THEN ' CalcularCustoReceitaAntes : «Nulo» '
                                              WHEN  CalcularCustoReceitaAntes = 0 THEN ' CalcularCustoReceitaAntes : «Falso» '
                                              WHEN  CalcularCustoReceitaAntes = 1 THEN ' CalcularCustoReceitaAntes : «Verdadeiro» '
                                    END 
                         + '| IdTipoPagamentoReceita : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaCustoFixoVariado IS NULL THEN ' UsaCustoFixoVariado : «Nulo» '
                                              WHEN  UsaCustoFixoVariado = 0 THEN ' UsaCustoFixoVariado : «Falso» '
                                              WHEN  UsaCustoFixoVariado = 1 THEN ' UsaCustoFixoVariado : «Verdadeiro» '
                                    END 
                         + '| PathUpdate : «' + RTRIM( ISNULL( CAST (PathUpdate AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathArquivos : «' + RTRIM( ISNULL( CAST (PathArquivos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPagamento IS NULL THEN ' TravamentoCCustoPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoPagamento = 0 THEN ' TravamentoCCustoPagamento : «Falso» '
                                              WHEN  TravamentoCCustoPagamento = 1 THEN ' TravamentoCCustoPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostaCentroCustoNotaOrcamentaria IS NULL THEN ' MostaCentroCustoNotaOrcamentaria : «Nulo» '
                                              WHEN  MostaCentroCustoNotaOrcamentaria = 0 THEN ' MostaCentroCustoNotaOrcamentaria : «Falso» '
                                              WHEN  MostaCentroCustoNotaOrcamentaria = 1 THEN ' MostaCentroCustoNotaOrcamentaria : «Verdadeiro» '
                                    END 
                         + '| ServidorSiscafWeb : «' + RTRIM( ISNULL( CAST (ServidorSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioSiscafWeb : «' + RTRIM( ISNULL( CAST (UsuarioSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaSiscafWeb : «' + RTRIM( ISNULL( CAST (SenhaSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFolha : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaMovimentoFolha : «' + RTRIM( ISNULL( CAST (IdPessoaMovimentoFolha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoBanco : «' + RTRIM( ISNULL( CAST (VersaoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathBackup : «' + RTRIM( ISNULL( CAST (PathBackup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgendamentoBackup : «' + RTRIM( ISNULL( CAST (AgendamentoBackup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaExecucaoAgBackup : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaExecucaoAgBackup, 113 ),'Nulo'))+'» '
                         + '| PathAuditoria : «' + RTRIM( ISNULL( CAST (PathAuditoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgendamentoAuditoria : «' + RTRIM( ISNULL( CAST (AgendamentoAuditoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaExecucaoAgAuditoria : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaExecucaoAgAuditoria, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraHistorico IS NULL THEN ' AlteraHistorico : «Nulo» '
                                              WHEN  AlteraHistorico = 0 THEN ' AlteraHistorico : «Falso» '
                                              WHEN  AlteraHistorico = 1 THEN ' AlteraHistorico : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraDataImpressaoBaixaPag IS NULL THEN ' MostraDataImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraDataImpressaoBaixaPag = 0 THEN ' MostraDataImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraDataImpressaoBaixaPag = 1 THEN ' MostraDataImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarRepasse IS NULL THEN ' AplicarRepasse : «Nulo» '
                                              WHEN  AplicarRepasse = 0 THEN ' AplicarRepasse : «Falso» '
                                              WHEN  AplicarRepasse = 1 THEN ' AplicarRepasse : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CriaPagamentoRepasseRec IS NULL THEN ' CriaPagamentoRepasseRec : «Nulo» '
                                              WHEN  CriaPagamentoRepasseRec = 0 THEN ' CriaPagamentoRepasseRec : «Falso» '
                                              WHEN  CriaPagamentoRepasseRec = 1 THEN ' CriaPagamentoRepasseRec : «Verdadeiro» '
                                    END 
                         + '| IdTipoPagamentoRepasse : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgrupaCreditoSipro : «' + RTRIM( ISNULL( CAST (AgrupaCreditoSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaPagamentoCusto IS NULL THEN ' AgrupaPagamentoCusto : «Nulo» '
                                              WHEN  AgrupaPagamentoCusto = 0 THEN ' AgrupaPagamentoCusto : «Falso» '
                                              WHEN  AgrupaPagamentoCusto = 1 THEN ' AgrupaPagamentoCusto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraOcorrencia IS NULL THEN ' MostraOcorrencia : «Nulo» '
                                              WHEN  MostraOcorrencia = 0 THEN ' MostraOcorrencia : «Falso» '
                                              WHEN  MostraOcorrencia = 1 THEN ' MostraOcorrencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IntegraSiproAgenda IS NULL THEN ' IntegraSiproAgenda : «Nulo» '
                                              WHEN  IntegraSiproAgenda = 0 THEN ' IntegraSiproAgenda : «Falso» '
                                              WHEN  IntegraSiproAgenda = 1 THEN ' IntegraSiproAgenda : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfContasPagar IS NULL THEN ' TransfContasPagar : «Nulo» '
                                              WHEN  TransfContasPagar = 0 THEN ' TransfContasPagar : «Falso» '
                                              WHEN  TransfContasPagar = 1 THEN ' TransfContasPagar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfContasReceber IS NULL THEN ' TransfContasReceber : «Nulo» '
                                              WHEN  TransfContasReceber = 0 THEN ' TransfContasReceber : «Falso» '
                                              WHEN  TransfContasReceber = 1 THEN ' TransfContasReceber : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TransfMovimentoFinanceiro IS NULL THEN ' TransfMovimentoFinanceiro : «Nulo» '
                                              WHEN  TransfMovimentoFinanceiro = 0 THEN ' TransfMovimentoFinanceiro : «Falso» '
                                              WHEN  TransfMovimentoFinanceiro = 1 THEN ' TransfMovimentoFinanceiro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraLancSiscontwFluxoCaixa IS NULL THEN ' MostraLancSiscontwFluxoCaixa : «Nulo» '
                                              WHEN  MostraLancSiscontwFluxoCaixa = 0 THEN ' MostraLancSiscontwFluxoCaixa : «Falso» '
                                              WHEN  MostraLancSiscontwFluxoCaixa = 1 THEN ' MostraLancSiscontwFluxoCaixa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeImagensRelacaoCredito IS NULL THEN ' ExibeImagensRelacaoCredito : «Nulo» '
                                              WHEN  ExibeImagensRelacaoCredito = 0 THEN ' ExibeImagensRelacaoCredito : «Falso» '
                                              WHEN  ExibeImagensRelacaoCredito = 1 THEN ' ExibeImagensRelacaoCredito : «Verdadeiro» '
                                    END 
                         + '| NumeroControleDRISS : «' + RTRIM( ISNULL( CAST (NumeroControleDRISS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathUpdateViaLogon : «' + RTRIM( ISNULL( CAST (PathUpdateViaLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoCC : «' + RTRIM( ISNULL( CAST (AcessoCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoCC : «' + RTRIM( ISNULL( CAST (DataAcessoCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteCC : «' + RTRIM( ISNULL( CAST (DataLimiteCC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostrarFavorecidoCustoReceita IS NULL THEN ' MostrarFavorecidoCustoReceita : «Nulo» '
                                              WHEN  MostrarFavorecidoCustoReceita = 0 THEN ' MostrarFavorecidoCustoReceita : «Falso» '
                                              WHEN  MostrarFavorecidoCustoReceita = 1 THEN ' MostrarFavorecidoCustoReceita : «Verdadeiro» '
                                    END 
                         + '| IdPessoaFavorecido : «' + RTRIM( ISNULL( CAST (IdPessoaFavorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag IS NULL THEN ' MostraVlBaseImpImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 0 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 1 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| QtdeUsuariosTransferidos : «' + RTRIM( ISNULL( CAST (QtdeUsuariosTransferidos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImpressaoFrenteVerso IS NULL THEN ' ImpressaoFrenteVerso : «Nulo» '
                                              WHEN  ImpressaoFrenteVerso = 0 THEN ' ImpressaoFrenteVerso : «Falso» '
                                              WHEN  ImpressaoFrenteVerso = 1 THEN ' ImpressaoFrenteVerso : «Verdadeiro» '
                                    END 
                         + '| Eventual : «' + RTRIM( ISNULL( CAST (Eventual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTransfContasPagar : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfContasPagar, 113 ),'Nulo'))+'» '
                         + '| DataTransfContasReceber : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfContasReceber, 113 ),'Nulo'))+'» '
                         + '| DataTransfMovimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTransfMovimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DES IS NULL THEN ' DES : «Nulo» '
                                              WHEN  DES = 0 THEN ' DES : «Falso» '
                                              WHEN  DES = 1 THEN ' DES : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PrevRecolhimentoTributo IS NULL THEN ' PrevRecolhimentoTributo : «Nulo» '
                                              WHEN  PrevRecolhimentoTributo = 0 THEN ' PrevRecolhimentoTributo : «Falso» '
                                              WHEN  PrevRecolhimentoTributo = 1 THEN ' PrevRecolhimentoTributo : «Verdadeiro» '
                                    END 
                         + '| PathArquivosExportacao : «' + RTRIM( ISNULL( CAST (PathArquivosExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRelacaoCredNumerada IS NULL THEN ' UtilizaRelacaoCredNumerada : «Nulo» '
                                              WHEN  UtilizaRelacaoCredNumerada = 0 THEN ' UtilizaRelacaoCredNumerada : «Falso» '
                                              WHEN  UtilizaRelacaoCredNumerada = 1 THEN ' UtilizaRelacaoCredNumerada : «Verdadeiro» '
                                    END 
                         + '| PrefixoRC : «' + RTRIM( ISNULL( CAST (PrefixoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoRC : «' + RTRIM( ISNULL( CAST (SufixoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoRC : «' + RTRIM( ISNULL( CAST (IncrementoRC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso IS NULL THEN ' UtilizaRelacaoCredNumeradaProcesso : «Nulo» '
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso = 0 THEN ' UtilizaRelacaoCredNumeradaProcesso : «Falso» '
                                              WHEN  UtilizaRelacaoCredNumeradaProcesso = 1 THEN ' UtilizaRelacaoCredNumeradaProcesso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CobrancaCompartilhadaDefaultReceita IS NULL THEN ' CobrancaCompartilhadaDefaultReceita : «Nulo» '
                                              WHEN  CobrancaCompartilhadaDefaultReceita = 0 THEN ' CobrancaCompartilhadaDefaultReceita : «Falso» '
                                              WHEN  CobrancaCompartilhadaDefaultReceita = 1 THEN ' CobrancaCompartilhadaDefaultReceita : «Verdadeiro» '
                                    END 
                         + '| IdPessoaTransferenciaReceita : «' + RTRIM( ISNULL( CAST (IdPessoaTransferenciaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamentoTransferenciaReceita : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoTransferenciaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFinanceiroTransfReceita : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFinanceiroTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPrestacao : «' + RTRIM( ISNULL( CAST (IdPessoaPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagPrestacao : «' + RTRIM( ISNULL( CAST (IdTipoPagPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinPrestacao : «' + RTRIM( ISNULL( CAST (IdTipoMovFinPrestacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CFPS IS NULL THEN ' CFPS : «Nulo» '
                                              WHEN  CFPS = 0 THEN ' CFPS : «Falso» '
                                              WHEN  CFPS = 1 THEN ' CFPS : «Verdadeiro» '
                                    END 
                         + '| DataAlteracaoLancFinanceiroInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracaoLancFinanceiroInicial, 113 ),'Nulo'))+'» '
                         + '| DataAlteracaoLancFinanceiroFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracaoLancFinanceiroFinal, 113 ),'Nulo'))+'» '
                         + '| IdEstadoConservacaoPadrao : «' + RTRIM( ISNULL( CAST (IdEstadoConservacaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorEmail : «' + RTRIM( ISNULL( CAST (ServidorEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEmail : «' + RTRIM( ISNULL( CAST (PortaEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmail : «' + RTRIM( ISNULL( CAST (UsuarioEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmail : «' + RTRIM( ISNULL( CAST (SenhaEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito1 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito2 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito3 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssinaturaRCredito4 : «' + RTRIM( ISNULL( CAST (AssinaturaRCredito4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncluirHistEmpenho IS NULL THEN ' IncluirHistEmpenho : «Nulo» '
                                              WHEN  IncluirHistEmpenho = 0 THEN ' IncluirHistEmpenho : «Falso» '
                                              WHEN  IncluirHistEmpenho = 1 THEN ' IncluirHistEmpenho : «Verdadeiro» '
                                    END 
                         + '| DataLimiteProcesso : «' + RTRIM( ISNULL( CAST (DataLimiteProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoProcesso : «' + RTRIM( ISNULL( CAST (DataAcessoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoProcesso : «' + RTRIM( ISNULL( CAST (AcessoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteFiscalizacao : «' + RTRIM( ISNULL( CAST (DataLimiteFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoFiscalizacao : «' + RTRIM( ISNULL( CAST (DataAcessoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoFiscalizacao : «' + RTRIM( ISNULL( CAST (AcessoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  imprimeDataHoraRel IS NULL THEN ' imprimeDataHoraRel : «Nulo» '
                                              WHEN  imprimeDataHoraRel = 0 THEN ' imprimeDataHoraRel : «Falso» '
                                              WHEN  imprimeDataHoraRel = 1 THEN ' imprimeDataHoraRel : «Verdadeiro» '
                                    END 
                         + '| PathArquivosSG : «' + RTRIM( ISNULL( CAST (PathArquivosSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinRecRealizar : «' + RTRIM( ISNULL( CAST (IdTipoMovFinRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPgtoRecRealizar : «' + RTRIM( ISNULL( CAST (IdTipoPgtoRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaRecRealizar : «' + RTRIM( ISNULL( CAST (IdPessoaRecRealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovFinRecRealizarCartao : «' + RTRIM( ISNULL( CAST (IdTipoMovFinRecRealizarCartao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailCotacao : «' + RTRIM( ISNULL( CAST (UsuarioEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmailCotacao : «' + RTRIM( ISNULL( CAST (SenhaEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ServidorRequerAutenticacao IS NULL THEN ' ServidorRequerAutenticacao : «Nulo» '
                                              WHEN  ServidorRequerAutenticacao = 0 THEN ' ServidorRequerAutenticacao : «Falso» '
                                              WHEN  ServidorRequerAutenticacao = 1 THEN ' ServidorRequerAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CPFCNPJObrigatorio IS NULL THEN ' CPFCNPJObrigatorio : «Nulo» '
                                              WHEN  CPFCNPJObrigatorio = 0 THEN ' CPFCNPJObrigatorio : «Falso» '
                                              WHEN  CPFCNPJObrigatorio = 1 THEN ' CPFCNPJObrigatorio : «Verdadeiro» '
                                    END 
                         + '| DataCriaUsuarioSql : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriaUsuarioSql, 113 ),'Nulo'))+'» '
                         + '| IdTipoPagamentoRecRealiz : «' + RTRIM( ISNULL( CAST (IdTipoPagamentoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaFavorecidoRecRealiz : «' + RTRIM( ISNULL( CAST (IdPessoaFavorecidoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ManterArquivoRetorno IS NULL THEN ' ManterArquivoRetorno : «Nulo» '
                                              WHEN  ManterArquivoRetorno = 0 THEN ' ManterArquivoRetorno : «Falso» '
                                              WHEN  ManterArquivoRetorno = 1 THEN ' ManterArquivoRetorno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirLogoReduzidoNoCabecalho IS NULL THEN ' ExibirLogoReduzidoNoCabecalho : «Nulo» '
                                              WHEN  ExibirLogoReduzidoNoCabecalho = 0 THEN ' ExibirLogoReduzidoNoCabecalho : «Falso» '
                                              WHEN  ExibirLogoReduzidoNoCabecalho = 1 THEN ' ExibirLogoReduzidoNoCabecalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirApenasLogoNoCabecalho IS NULL THEN ' ExibirApenasLogoNoCabecalho : «Nulo» '
                                              WHEN  ExibirApenasLogoNoCabecalho = 0 THEN ' ExibirApenasLogoNoCabecalho : «Falso» '
                                              WHEN  ExibirApenasLogoNoCabecalho = 1 THEN ' ExibirApenasLogoNoCabecalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaMovimentoFolha IS NULL THEN ' AtualizaMovimentoFolha : «Nulo» '
                                              WHEN  AtualizaMovimentoFolha = 0 THEN ' AtualizaMovimentoFolha : «Falso» '
                                              WHEN  AtualizaMovimentoFolha = 1 THEN ' AtualizaMovimentoFolha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaPagamentoFolha IS NULL THEN ' AtualizaPagamentoFolha : «Nulo» '
                                              WHEN  AtualizaPagamentoFolha = 0 THEN ' AtualizaPagamentoFolha : «Falso» '
                                              WHEN  AtualizaPagamentoFolha = 1 THEN ' AtualizaPagamentoFolha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaPrevReceita IS NULL THEN ' AtualizaPrevReceita : «Nulo» '
                                              WHEN  AtualizaPrevReceita = 0 THEN ' AtualizaPrevReceita : «Falso» '
                                              WHEN  AtualizaPrevReceita = 1 THEN ' AtualizaPrevReceita : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirObjetoSocialCRC IS NULL THEN ' ExibirObjetoSocialCRC : «Nulo» '
                                              WHEN  ExibirObjetoSocialCRC = 0 THEN ' ExibirObjetoSocialCRC : «Falso» '
                                              WHEN  ExibirObjetoSocialCRC = 1 THEN ' ExibirObjetoSocialCRC : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaRodapePadraoCRC IS NULL THEN ' UtilizaRodapePadraoCRC : «Nulo» '
                                              WHEN  UtilizaRodapePadraoCRC = 0 THEN ' UtilizaRodapePadraoCRC : «Falso» '
                                              WHEN  UtilizaRodapePadraoCRC = 1 THEN ' UtilizaRodapePadraoCRC : «Verdadeiro» '
                                    END 
                         + '| IdCCCustoReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRepasseReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoRepasseReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustodia : «' + RTRIM( ISNULL( CAST (IdContaCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaTransfReceita : «' + RTRIM( ISNULL( CAST (IdContaTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDevolucaoRecARealizar : «' + RTRIM( ISNULL( CAST (IdContaDevolucaoRecARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebitoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaDebitoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogExterno : «' + RTRIM( ISNULL( CAST (LogExterno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeLogoCantoEsquerdo IS NULL THEN ' ExibeLogoCantoEsquerdo : «Nulo» '
                                              WHEN  ExibeLogoCantoEsquerdo = 0 THEN ' ExibeLogoCantoEsquerdo : «Falso» '
                                              WHEN  ExibeLogoCantoEsquerdo = 1 THEN ' ExibeLogoCantoEsquerdo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaLogoRelatoriosSISCONT IS NULL THEN ' UtilizaLogoRelatoriosSISCONT : «Nulo» '
                                              WHEN  UtilizaLogoRelatoriosSISCONT = 0 THEN ' UtilizaLogoRelatoriosSISCONT : «Falso» '
                                              WHEN  UtilizaLogoRelatoriosSISCONT = 1 THEN ' UtilizaLogoRelatoriosSISCONT : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO IS NULL THEN ' ExibirLogoNotasEmpenhoSIPRO : «Nulo» '
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO = 0 THEN ' ExibirLogoNotasEmpenhoSIPRO : «Falso» '
                                              WHEN  ExibirLogoNotasEmpenhoSIPRO = 1 THEN ' ExibirLogoNotasEmpenhoSIPRO : «Verdadeiro» '
                                    END 
                         + '| BandejaImpEmpenho : «' + RTRIM( ISNULL( CAST (BandejaImpEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BandejaImpPreEmpenho : «' + RTRIM( ISNULL( CAST (BandejaImpPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizarImpEmpenho IS NULL THEN ' VisualizarImpEmpenho : «Nulo» '
                                              WHEN  VisualizarImpEmpenho = 0 THEN ' VisualizarImpEmpenho : «Falso» '
                                              WHEN  VisualizarImpEmpenho = 1 THEN ' VisualizarImpEmpenho : «Verdadeiro» '
                                    END 
                         + '| ParametroImpFrenteVerso : «' + RTRIM( ISNULL( CAST (ParametroImpFrenteVerso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoPDR : «' + RTRIM( ISNULL( CAST (PrefixoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoPDR : «' + RTRIM( ISNULL( CAST (SufixoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoPDR : «' + RTRIM( ISNULL( CAST (IncrementoPDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoDDR : «' + RTRIM( ISNULL( CAST (PrefixoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoDDR : «' + RTRIM( ISNULL( CAST (SufixoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoDDR : «' + RTRIM( ISNULL( CAST (IncrementoDDR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TributaImportacao IS NULL THEN ' TributaImportacao : «Nulo» '
                                              WHEN  TributaImportacao = 0 THEN ' TributaImportacao : «Falso» '
                                              WHEN  TributaImportacao = 1 THEN ' TributaImportacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAjustesPessoasSiproSG IS NULL THEN ' BloquearAjustesPessoasSiproSG : «Nulo» '
                                              WHEN  BloquearAjustesPessoasSiproSG = 0 THEN ' BloquearAjustesPessoasSiproSG : «Falso» '
                                              WHEN  BloquearAjustesPessoasSiproSG = 1 THEN ' BloquearAjustesPessoasSiproSG : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearPessoasSiproSG IS NULL THEN ' BloquearPessoasSiproSG : «Nulo» '
                                              WHEN  BloquearPessoasSiproSG = 0 THEN ' BloquearPessoasSiproSG : «Falso» '
                                              WHEN  BloquearPessoasSiproSG = 1 THEN ' BloquearPessoasSiproSG : «Verdadeiro» '
                                    END 
                         + '| EmailCopiaSG : «' + RTRIM( ISNULL( CAST (EmailCopiaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaPagamentoAssociacoes IS NULL THEN ' UtilizaPagamentoAssociacoes : «Nulo» '
                                              WHEN  UtilizaPagamentoAssociacoes = 0 THEN ' UtilizaPagamentoAssociacoes : «Falso» '
                                              WHEN  UtilizaPagamentoAssociacoes = 1 THEN ' UtilizaPagamentoAssociacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho IS NULL THEN ' PrestacaoContasFavorecidoDoEmpenho : «Nulo» '
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho = 0 THEN ' PrestacaoContasFavorecidoDoEmpenho : «Falso» '
                                              WHEN  PrestacaoContasFavorecidoDoEmpenho = 1 THEN ' PrestacaoContasFavorecidoDoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IncluirHistRestosEmpenho IS NULL THEN ' IncluirHistRestosEmpenho : «Nulo» '
                                              WHEN  IncluirHistRestosEmpenho = 0 THEN ' IncluirHistRestosEmpenho : «Falso» '
                                              WHEN  IncluirHistRestosEmpenho = 1 THEN ' IncluirHistRestosEmpenho : «Verdadeiro» '
                                    END 
                         + '| ServidorFTP : «' + RTRIM( ISNULL( CAST (ServidorFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PastaFTP : «' + RTRIM( ISNULL( CAST (PastaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaAlertaCertificacao IS NULL THEN ' UtilizaAlertaCertificacao : «Nulo» '
                                              WHEN  UtilizaAlertaCertificacao = 0 THEN ' UtilizaAlertaCertificacao : «Falso» '
                                              WHEN  UtilizaAlertaCertificacao = 1 THEN ' UtilizaAlertaCertificacao : «Verdadeiro» '
                                    END 
                         + '| EmailOrigem : «' + RTRIM( ISNULL( CAST (EmailOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAutorizacaoImpressao IS NULL THEN ' UsaAutorizacaoImpressao : «Nulo» '
                                              WHEN  UsaAutorizacaoImpressao = 0 THEN ' UsaAutorizacaoImpressao : «Falso» '
                                              WHEN  UsaAutorizacaoImpressao = 1 THEN ' UsaAutorizacaoImpressao : «Verdadeiro» '
                                    END 
                         + '| EmailAutorizacaoImpressao : «' + RTRIM( ISNULL( CAST (EmailAutorizacaoImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLSAD : «' + RTRIM( ISNULL( CAST (URLSAD AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PCEnderecoWSDL : «' + RTRIM( ISNULL( CAST (PCEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAtualizacaoMSG : «' + RTRIM( ISNULL( CAST (TempoAtualizacaoMSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LiqEnderecoWSDL : «' + RTRIM( ISNULL( CAST (LiqEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LancEnderecoWSDL : «' + RTRIM( ISNULL( CAST (LancEnderecoWSDL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImportaFolhaCentroCusto11Char IS NULL THEN ' ImportaFolhaCentroCusto11Char : «Nulo» '
                                              WHEN  ImportaFolhaCentroCusto11Char = 0 THEN ' ImportaFolhaCentroCusto11Char : «Falso» '
                                              WHEN  ImportaFolhaCentroCusto11Char = 1 THEN ' ImportaFolhaCentroCusto11Char : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ServidorRequerAutenticacaoSSL IS NULL THEN ' ServidorRequerAutenticacaoSSL : «Nulo» '
                                              WHEN  ServidorRequerAutenticacaoSSL = 0 THEN ' ServidorRequerAutenticacaoSSL : «Falso» '
                                              WHEN  ServidorRequerAutenticacaoSSL = 1 THEN ' ServidorRequerAutenticacaoSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  InicializarMSGcomWindows IS NULL THEN ' InicializarMSGcomWindows : «Nulo» '
                                              WHEN  InicializarMSGcomWindows = 0 THEN ' InicializarMSGcomWindows : «Falso» '
                                              WHEN  InicializarMSGcomWindows = 1 THEN ' InicializarMSGcomWindows : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ScriptLogExecutado IS NULL THEN ' ScriptLogExecutado : «Nulo» '
                                              WHEN  ScriptLogExecutado = 0 THEN ' ScriptLogExecutado : «Falso» '
                                              WHEN  ScriptLogExecutado = 1 THEN ' ScriptLogExecutado : «Verdadeiro» '
                                    END 
                         + '| EnderecoHttpSiscafweb : «' + RTRIM( ISNULL( CAST (EnderecoHttpSiscafweb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCliente : «' + RTRIM( ISNULL( CAST (TipoCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura1 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura2 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura3 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BoletimCaixaAssinatura4 : «' + RTRIM( ISNULL( CAST (BoletimCaixaAssinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaBackup IS NULL THEN ' AlertaBackup : «Nulo» '
                                              WHEN  AlertaBackup = 0 THEN ' AlertaBackup : «Falso» '
                                              WHEN  AlertaBackup = 1 THEN ' AlertaBackup : «Verdadeiro» '
                                    END 
                         + '| DataAlertaBackup : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlertaBackup, 113 ),'Nulo'))+'» '
                         + '| ServidorEmailUsLogon : «' + RTRIM( ISNULL( CAST (ServidorEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEmailUsLogon : «' + RTRIM( ISNULL( CAST (PortaEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailUsLogon : «' + RTRIM( ISNULL( CAST (UsuarioEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmailUsLogon : «' + RTRIM( ISNULL( CAST (SenhaEmailUsLogon AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSLUsLogon IS NULL THEN ' EmailAutenticaSSLUsLogon : «Nulo» '
                                              WHEN  EmailAutenticaSSLUsLogon = 0 THEN ' EmailAutenticaSSLUsLogon : «Falso» '
                                              WHEN  EmailAutenticaSSLUsLogon = 1 THEN ' EmailAutenticaSSLUsLogon : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ScriptCEPExecutado IS NULL THEN ' ScriptCEPExecutado : «Nulo» '
                                              WHEN  ScriptCEPExecutado = 0 THEN ' ScriptCEPExecutado : «Falso» '
                                              WHEN  ScriptCEPExecutado = 1 THEN ' ScriptCEPExecutado : «Verdadeiro» '
                                    END 
                         + '| EmailAuthenticationMethod : «' + RTRIM( ISNULL( CAST (EmailAuthenticationMethod AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnvioEmailLimiteQtd : «' + RTRIM( ISNULL( CAST (EnvioEmailLimiteQtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnvioEmailLimiteTempo : «' + RTRIM( ISNULL( CONVERT (CHAR, EnvioEmailLimiteTempo, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
