CREATE TABLE [dbo].[ParametrosSiscafw] (
    [IdConselhoCorrente]                       INT             NOT NULL,
    [IndContabilizacao]                        BIT             NULL,
    [IdBancoPadrao]                            INT             NULL,
    [DirArqRemessa]                            VARCHAR (100)   NULL,
    [DirArqRetorno]                            VARCHAR (100)   NULL,
    [DirArqRetornoProc]                        VARCHAR (100)   NULL,
    [DirFotos]                                 VARCHAR (100)   NULL,
    [IncrementoConjunto]                       BIT             NULL,
    [IndIncrementoRegistroProf]                INT             NULL,
    [IndIncrementoRegistroPJ]                  INT             NULL,
    [IndPre_SufNumRegistroProf]                INT             NULL,
    [IndPre_SufNumRegistroPJ]                  INT             NULL,
    [TamanhoNumRegistroProf]                   INT             NULL,
    [TamanhoNumRegistroPJ]                     INT             NULL,
    [ValorMargemRecebPercentual]               BIT             NULL,
    [ValorMargemReceb]                         FLOAT (53)      NULL,
    [CodTratamentoRecebMenor]                  INT             NULL,
    [CodTratamentoRecebMaior]                  INT             NULL,
    [IdProcedAtrasoPadrao]                     INT             NULL,
    [CodPadraoRepasse]                         INT             NULL,
    [TipoLivro]                                INT             NULL,
    [BaseCEP]                                  BIT             NULL,
    [Pagina]                                   VARCHAR (20)    NULL,
    [PaginaAltura]                             FLOAT (53)      NULL,
    [PaginaLargura]                            FLOAT (53)      NULL,
    [PaginaOrientacao]                         FLOAT (53)      NULL,
    [MargemSuperior]                           FLOAT (53)      NULL,
    [MargemInferior]                           FLOAT (53)      NULL,
    [MargemEsquerda]                           FLOAT (53)      NULL,
    [MargemDireita]                            FLOAT (53)      NULL,
    [PzEmissaoBloqueto]                        INT             NULL,
    [IndAtulizReneg]                           BIT             NULL,
    [IdIndiceAtulizReneg]                      INT             NULL,
    [EtiquetaMargemSuperior]                   FLOAT (53)      NULL,
    [EtiquetaMargemLateral]                    FLOAT (53)      NULL,
    [EtiquetaDistanciaVertical]                FLOAT (53)      NULL,
    [EtiquetaDistanciaHorizontal]              FLOAT (53)      NULL,
    [EtiquetaAltura]                           FLOAT (53)      NULL,
    [EtiquetaLargura]                          FLOAT (53)      NULL,
    [QtdeEtiquetasLinha]                       FLOAT (53)      NULL,
    [QtdeEtiquetasColuna]                      FLOAT (53)      NULL,
    [OrigemPagamentoPadrao]                    INT             NULL,
    [SequencialNossoNumero]                    INT             NULL,
    [PercAcrescimoCumulativo]                  FLOAT (53)      NULL,
    [FormaImpressaoCarne]                      INT             NULL,
    [FormaImpressaoBoleto]                     INT             NULL,
    [EtiquetaTamanhoPapel]                     VARCHAR (30)    NULL,
    [Altura_Frame_Processos]                   INT             NULL,
    [Largura_Frame_Processos]                  INT             NULL,
    [IdBancoPadraoWEB]                         INT             NULL,
    [SincronizacaoTiposInscricao]              TEXT            NULL,
    [SincronizacaoSituacoes]                   TEXT            NULL,
    [IdPessoaPadrao]                           INT             NULL,
    [ATIVAATUALIZACAOAUT_SITUACOES]            BIT             NULL,
    [FazLancamentoContabil]                    BIT             NULL,
    [BaixarHistoricoEmissao]                   BIT             NOT NULL,
    [ReiniciaAno]                              INT             NULL,
    [FiscAutoInc]                              INT             NULL,
    [FiscPrefSuf]                              INT             NULL,
    [SequenciaCodigoBarras]                    VARCHAR (50)    NULL,
    [CodigoBarrasSufixo]                       VARCHAR (2)     NULL,
    [CodigoBarrasPrefixo]                      VARCHAR (2)     NULL,
    [ControlarDivAtiva]                        BIT             NULL,
    [TempoLock]                                DATETIME        NULL,
    [CadastrarPessoaPor]                       INT             NULL,
    [tamanhoRodape]                            INT             NULL,
    [OcorrenciasAlterarExcluir]                INT             NULL,
    [FasesAlterarExcluir]                      INT             NULL,
    [UsarNumDoc]                               BIT             NULL,
    [IdModeloDoc]                              INT             NULL,
    [CancelarDivAtiva]                         BIT             NULL,
    [RenegociarDivAtiva]                       BIT             NULL,
    [ControleDividaAtiva]                      INT             NULL,
    [IdUltimoLivro]                            INT             NULL,
    [idCategoriaProf]                          INT             NULL,
    [TramitacoesDataEntrada]                   INT             NULL,
    [campoCabecalhoFisc]                       VARCHAR (50)    NULL,
    [FiscalizacoesNomeDinamico1]               VARCHAR (25)    NULL,
    [FiscalizacoesNomeDinamico2]               VARCHAR (25)    NULL,
    [FiscalizacoesNomeDinamico3]               VARCHAR (25)    NULL,
    [FiscalizacoesCaptionAbaDinamica]          VARCHAR (50)    NULL,
    [FiscalizacaoCaptionAbaDinamicaFisc]       VARCHAR (50)    NULL,
    [FiscalizacaoNomeDinamico1]                VARCHAR (25)    NULL,
    [FiscalizacaoNomeDinamico2]                VARCHAR (25)    NULL,
    [FiscalizacaoNomeDinamico3]                VARCHAR (25)    NULL,
    [FiscalizacaoCaptionAbaDinamica]           VARCHAR (50)    NULL,
    [UsaAnoCorrenteVerifAdimplente]            BIT             CONSTRAINT [DF__Parametro__UsaAn__5C85BE23] DEFAULT ((1)) NULL,
    [IgnorarZerosEsq_Registro]                 BIT             NULL,
    [RegistraDtCredito]                        BIT             CONSTRAINT [DF__Parametro__Regis__39D87308] DEFAULT ((0)) NOT NULL,
    [CriaProcessoInscricao]                    BIT             NULL,
    [IdMoedaPadrao]                            INT             NULL,
    [CadPFMostraEnderecoDivulgacao]            BIT             NULL,
    [TipoProcPagamentoBB]                      INT             CONSTRAINT [DF__Parametro__TipoP__37FB178E] DEFAULT ((1)) NULL,
    [NumeroProcInscricao]                      INT             NULL,
    [GeraAutomaticoArquivoIndividual]          BIT             NULL,
    [AlterarDataInscricaoConselho]             BIT             NULL,
    [VerifNossoNumDuplicDetEmiss]              BIT             NULL,
    [IdProfissionalPresidente]                 INT             NULL,
    [IdProfissionalVice]                       INT             NULL,
    [IdModeloEntregaCarteirinha]               INT             NULL,
    [AssociarCidadeSubRegiao]                  BIT             NULL,
    [ControlaDataTermino]                      BIT             NULL,
    [UtilizaDebitoConta]                       BIT             NULL,
    [SequencialNossoNumeroDebConta]            INT             NULL,
    [PosicaoDivida]                            INT             NULL,
    [BloquetoComDesconto_Individual]           BIT             CONSTRAINT [DF__Parametro__Bloqu__25CCE81B] DEFAULT ((0)) NOT NULL,
    [SugerirDataPgto]                          BIT             NULL,
    [ImpedirDataPgtoFutura]                    BIT             NULL,
    [RenegociacaoViaCertidao]                  BIT             CONSTRAINT [DF__Parametro__Reneg__78A6D297] DEFAULT ((1)) NOT NULL,
    [SugerirDataReferencia]                    BIT             NULL,
    [IncrementarCF]                            BIT             NULL,
    [SequencialCodigoFiscalizador]             INT             NULL,
    [GeraNumeroProcessoPessoas]                BIT             NULL,
    [UtilizaNunProcessoBloqueto]               BIT             NULL,
    [MudancaClassesAtiva]                      BIT             CONSTRAINT [DF_ParametrosSiscafwMudancaClassesAtiva] DEFAULT ((0)) NULL,
    [DiaMesMudancaClasses]                     VARCHAR (5)     CONSTRAINT [DF_ParametrosSiscafwDiaMesMudancaClasses] DEFAULT ('30/11') NULL,
    [ProximoAnoMudancaClasses]                 INT             CONSTRAINT [DF_ParametrosSiscafwProximoAnoMudancaClasses] DEFAULT (datepart(year,getdate())) NULL,
    [bNumerarRen]                              BIT             NULL,
    [NumeroRenegociacao]                       VARCHAR (15)    NULL,
    [TramitacoesProcEnviar]                    INT             NULL,
    [TramitacoesProcReceber]                   INT             NULL,
    [TramitacoesProcAlterar]                   INT             NULL,
    [TramitacoesProcFiltraRespLocal]           BIT             NULL,
    [TramitacoesProcAlterarExt]                INT             NULL,
    [PrioridadePadrao]                         INT             NULL,
    [SituacaoPadrao]                           INT             NULL,
    [SequencialProcesso]                       BIGINT          NULL,
    [AnoProcesso]                              VARCHAR (4)     NULL,
    [NumeracaoUnicaProcesso]                   BIT             NULL,
    [IdCategoriaPadrao]                        INT             NULL,
    [IdTipoInscricaoPadrao]                    INT             NULL,
    [IdMotivoInscricaoPadrao]                  INT             NULL,
    [UtilizarUsuarioPadrao]                    BIT             NULL,
    [UtilizaPesquisaGenerica]                  BIT             NULL,
    [LiberaEnvioTramitacao]                    BIT             NULL,
    [SequencialNumeroCarteira]                 INT             NULL,
    [ResumoDebitoVinculado]                    BIT             NULL,
    [UtilizaSequencialNumeroCarteira]          BIT             NULL,
    [MargemSupBoleto]                          INT             NULL,
    [MargemDirBoleto]                          INT             NULL,
    [MargemInfBoleto]                          INT             NULL,
    [MargemEsqBoleto]                          INT             NULL,
    [CriticaCPFArquivoRemessa]                 BIT             CONSTRAINT [DF_ParametrosSiscafwCriticaCPFArquivoRemessa] DEFAULT ((1)) NULL,
    [SequencialSeuNumero]                      NUMERIC (11)    NULL,
    [AssuntoEmailSuspensao]                    VARCHAR (100)   NULL,
    [TextoEmailSuspensao]                      TEXT            NULL,
    [AssuntoEmailLevantamentoSuspensao]        VARCHAR (100)   NULL,
    [TextoEmailLevantamentoSuspensao]          TEXT            NULL,
    [EnvioEmailSuspensao]                      BIT             CONSTRAINT [DF__Parametro__Envio__19CE29F8] DEFAULT ((1)) NOT NULL,
    [IndPrioridadeBaixaPgto]                   INT             NULL,
    [UsuarioEmailProcesso]                     VARCHAR (100)   NULL,
    [SenhaUsuarioEmailProcesso]                VARCHAR (30)    NULL,
    [LogAtivado]                               BIT             NULL,
    [Assinatura1]                              VARCHAR (100)   NULL,
    [Assinatura2]                              VARCHAR (100)   NULL,
    [Cargo1]                                   VARCHAR (100)   NULL,
    [Cargo2]                                   VARCHAR (100)   NULL,
    [EmailCartirasServidor]                    VARCHAR (100)   NULL,
    [EmailCarteirasPorta]                      VARCHAR (6)     NULL,
    [EmailCartirasUsuario]                     VARCHAR (100)   NULL,
    [EmailCartirasSenha]                       VARCHAR (100)   NULL,
    [EmailCartirasAssunto]                     VARCHAR (100)   NULL,
    [EmailCartirasCorpo]                       TEXT            NULL,
    [OcorrenciaCartirasImpressao]              BIT             NULL,
    [OcorrenciaCartirasEmail]                  BIT             NULL,
    [OcorrenciaCartirasTexto]                  VARCHAR (255)   NULL,
    [OcorrenciaCartirasDetalhes]               INT             NULL,
    [UtilizaAgendaContatos]                    CHAR (1)        CONSTRAINT [DF__Parametro__Utili__510A1BA0] DEFAULT ('N') NULL,
    [EditarCEP]                                BIT             NULL,
    [LocalizarProfPJ]                          INT             NULL,
    [DirArqApreciacao]                         VARCHAR (100)   NULL,
    [DirArqResolucao]                          VARCHAR (100)   NULL,
    [DirModeloResolucao]                       VARCHAR (100)   NULL,
    [GerarSubDiretorioPorBanco]                BIT             NULL,
    [DeParaMudancaAutoSituacao]                TEXT            NULL,
    [ExibirAdimplenciaEmVotacao]               BIT             NULL,
    [ReiniciaAnoProc]                          BIT             NULL,
    [DtVencAnuConsiderarInadimpl]              VARCHAR (4)     NULL,
    [UtilizarAcrescimoRecobranca]              BIT             NULL,
    [DataAlterarValorDA]                       DATETIME        NULL,
    [AceitarPgtoCanceladoArquivoRet]           BIT             NULL,
    [AceitarPgtoPagoArquivoRet]                BIT             DEFAULT ((0)) NOT NULL,
    [NaoBaixarPagoMaior]                       BIT             DEFAULT ((0)) NOT NULL,
    [ValorMargemPagoMaior]                     FLOAT (53)      NULL,
    [DataUltimaAtualizacaoArqThemis]           DATETIME        NULL,
    [DataUltimaAtualizacaoArqAdvatu]           DATETIME        NULL,
    [DataUltimaAtualizacaoArqTJ]               DATETIME        NULL,
    [FlagScriptSituacaoPFPJ]                   BIT             DEFAULT ((0)) NOT NULL,
    [FiscTamanhoSequencial]                    INT             DEFAULT ((6)) NOT NULL,
    [FiscSigla]                                VARCHAR (4)     NULL,
    [FlagScriptSituacaoPFPJ2]                  BIT             DEFAULT ((0)) NOT NULL,
    [AceitaDataFutura]                         BIT             NULL,
    [IgnoraVlrPgSitDeb]                        BIT             DEFAULT ((0)) NOT NULL,
    [EmailCarteirasAutenticaSSL]               BIT             DEFAULT ((0)) NOT NULL,
    [BloquearEdicaoSubRegiao]                  BIT             DEFAULT ((0)) NOT NULL,
    [EmailAutenticaSSL]                        BIT             DEFAULT ((0)) NOT NULL,
    [FltrDebAnoInicial]                        VARCHAR (4)     NULL,
    [FltrDebAnoFinal]                          VARCHAR (4)     NULL,
    [FltrDebVencInicial]                       DATETIME        NULL,
    [FltrDebVencFinal]                         DATETIME        NULL,
    [FltrDebNExibirRenCanc]                    BIT             NULL,
    [FltrDebTipoDeb]                           VARCHAR (2000)  NULL,
    [FltrDebSituacaoDeb]                       VARCHAR (200)   NULL,
    [FltrDebMotivoCanc]                        VARCHAR (200)   NULL,
    [IndUtilizaMsgDtPrevisaoProc]              BIT             DEFAULT ((0)) NOT NULL,
    [TipoExibicaoMsgDtPrevicaoProc]            CHAR (1)        DEFAULT ('D') NULL,
    [PermitirAcesProcInterno]                  BIT             CONSTRAINT [DF_ParametrosSiscafw_PermitirAcesProcInterno] DEFAULT ((0)) NULL,
    [PermitirAcesFiscInterno]                  BIT             CONSTRAINT [DF_ParametrosSiscafw_PermitirAcesFiscInterno] DEFAULT ((0)) NULL,
    [UtilizarIntegracao]                       BIT             DEFAULT ((0)) NOT NULL,
    [IntegracaoProvider]                       VARCHAR (100)   NULL,
    [IntegracaoServidor]                       VARCHAR (250)   NULL,
    [IntegracaoBancoDados]                     VARCHAR (20)    NULL,
    [IntegracaoSchema]                         VARCHAR (20)    NULL,
    [IntegracaoUsuario]                        VARCHAR (30)    NULL,
    [IntegracaoSenha]                          VARCHAR (20)    NULL,
    [AplicarCampoObr]                          BIT             CONSTRAINT [DF_ParametrosSiscafw_AplicarCampoObr] DEFAULT ((0)) NOT NULL,
    [UtilizarAssistenteCadastro]               BIT             DEFAULT ((0)) NOT NULL,
    [DirRel]                                   VARCHAR (100)   NULL,
    [UtilizaControleDigitalizacoes]            BIT             CONSTRAINT [DF_ParametrosSiscafw_UtilizaControleDigitalizacoes] DEFAULT ((0)) NOT NULL,
    [PermitirVinculoProcTipoDif]               BIT             CONSTRAINT [DEF_ParametrosSiscafw_PermitirVinculoProcTipoDif] DEFAULT ((0)) NOT NULL,
    [TramitacaoDataPrevObrig]                  BIT             CONSTRAINT [DEF_ParametrosSiscafw_TramitacaoDataPrevObrig] DEFAULT ((0)) NOT NULL,
    [TramitPermitirDesativarAviso]             BIT             CONSTRAINT [DEF_ParametrosSiscafw_TramitPermitirDesativarAviso] DEFAULT ((1)) NOT NULL,
    [BloquearAlteracaoTramitacao]              BIT             DEFAULT ((0)) NOT NULL,
    [DuplicidadeNR]                            VARCHAR (20)    NULL,
    [ComputadorMalaDireta]                     VARCHAR (240)   NULL,
    [AssinaturaPresidente]                     IMAGE           NULL,
    [AgrupaPeticaoCDA]                         BIT             DEFAULT ((0)) NOT NULL,
    [EmailEnvioErros]                          VARCHAR (150)   NULL,
    [TotalDividaAtivaAtualizada]               FLOAT (53)      DEFAULT ((0)) NULL,
    [ConfigRelatorioFixoXML]                   VARCHAR (8000)  NULL,
    [ExibirAlertaPendBaixa]                    BIT             NULL,
    [ExibirAlertaPendBaixaAPartirDe]           DATETIME        NULL,
    [ConcatenarLocalTrabalho]                  BIT             CONSTRAINT [DEF_ConcatenarLocalTrabalho] DEFAULT ((0)) NULL,
    [NrInfObrigatorio]                         BIT             CONSTRAINT [DF_ParametrosSiscafw_NrInfObrigatorio] DEFAULT ((1)) NULL,
    [NrInfRecebeNrModeloAutoInf]               BIT             CONSTRAINT [DF_ParametrosSiscafw_NrInfRecebeNrModeloAutoInf] DEFAULT ((0)) NULL,
    [DataVerificacaoREN]                       DATETIME        NULL,
    [FormaImpressao]                           BIT             CONSTRAINT [DEF_FormaImpressao_ParametrosSiscafw] DEFAULT ((0)) NOT NULL,
    [idPadraoEtapaProcInscricaoPF]             INT             NULL,
    [idPadraoEtapaProcInscricaoPJ]             INT             NULL,
    [TxtPreviaAcordoRen]                       VARCHAR (250)   NULL,
    [IdTipoDebitoHonorariosAdv]                INT             NULL,
    [ImprimeVersoBoleto]                       BIT             CONSTRAINT [DF_ParametrosSiscafw_ImprimeVersoBoleto] DEFAULT ((0)) NOT NULL,
    [Logomarca]                                IMAGE           NULL,
    [IdTipoDebitoFS]                           INT             NULL,
    [UtilizarVlrAtualizacaoComVlrPrincipal]    BIT             NULL,
    [CNARemoverZeros]                          BIT             CONSTRAINT [DEF_ParametrosSiscafw_CNARemoverZeros] DEFAULT ((0)) NOT NULL,
    [NotCPFDuplicado]                          BIT             CONSTRAINT [DF_ParametrosSiscafw_NotCPFDuplicado] DEFAULT ((0)) NOT NULL,
    [DIV_SituacoesPFPJ]                        BIT             NULL,
    [DIV_TiposInscricao]                       BIT             NULL,
    [DataUltimaBaixaDadosSiscafWeb]            DATETIME        NULL,
    [MostraDataPedidoInscricao]                BIT             NULL,
    [LogoRecibo]                               VARBINARY (MAX) NULL,
    [IdTipoDocumentoAT]                        INT             NULL,
    [IdTipoDocumentoRCA]                       INT             NULL,
    [EmailCopiaBoleto]                         VARCHAR (100)   NULL,
    [InserirLogoNoReciboSiscafw]               BIT             NULL,
    [UtilizarProcAtrasoDebitosDA]              BIT             NULL,
    [UtilizarSelecaoUnicaTipoDef]              BIT             DEFAULT ((0)) NOT NULL,
    [PermitirCadastroTipoDef]                  BIT             DEFAULT ((0)) NOT NULL,
    [CfgSituacaoTpProcesso]                    BIT             CONSTRAINT [DF_ParametrosSiscafw_CfgSituacaoTpProcesso] DEFAULT ((0)) NOT NULL,
    [UtilizarGravarImagem]                     BIT             NULL,
    [ServidorDigitalizacao]                    VARCHAR (35)    NULL,
    [BaseDigitalizacao]                        VARCHAR (35)    NULL,
    [UsuarioBaseDigitalizacao]                 VARCHAR (35)    NULL,
    [SenhaBaseDigitalizacao]                   VARCHAR (35)    NULL,
    [AutenticaWindows]                         BIT             NULL,
    [IdTipoDocumentoRenRCA]                    INT             NULL,
    [IdTipoDocumentoVisto]                     INT             NULL,
    [IdTipoDocumentoRenVisto]                  INT             NULL,
    [IdTipoDocumentoCertReg]                   INT             NULL,
    [IdTipoDocumentoDebParc]                   INT             NULL,
    [IdAssuntoATPF]                            INT             NULL,
    [IdAssuntoATPJ]                            INT             NULL,
    [IdAssuntoRCAPF]                           INT             NULL,
    [IdAssuntoRCAPJ]                           INT             NULL,
    [IdAssuntoRenRCAPF]                        INT             NULL,
    [IdAssuntoRenRCAPJ]                        INT             NULL,
    [IdAssuntoVistoPF]                         INT             NULL,
    [IdAssuntoVistoPJ]                         INT             NULL,
    [IdAssuntoRenVistoPF]                      INT             NULL,
    [IdAssuntoRenVistoPJ]                      INT             NULL,
    [IdAssuntoCertRegPF]                       INT             NULL,
    [IdAssuntoCertRegPJ]                       INT             NULL,
    [IdAssuntoDebParcPF]                       INT             NULL,
    [IdAssuntoDebParcPJ]                       INT             NULL,
    [NumRCAInicial]                            INT             NULL,
    [TipoNumeracaoRCA]                         BIT             CONSTRAINT [DEF_TipoNumeracaoRCA] DEFAULT ((0)) NOT NULL,
    [GeraDebitoAnoInscricao]                   BIT             NULL,
    [GeraDebitoPJPorRespTec]                   BIT             NULL,
    [IdDebitoPJPorRespTec]                     INT             NULL,
    [PriorizaTipoDebito]                       BIT             CONSTRAINT [DF_ParametrosSiscafw_PriorizaTipoDebito] DEFAULT ((0)) NOT NULL,
    [NumVistoInicial]                          INT             NULL,
    [TipoNumeracaoVisto]                       BIT             CONSTRAINT [DEF_TipoNumeracaoVisto] DEFAULT ((0)) NOT NULL,
    [AnoComSufixoRCA]                          INT             NULL,
    [TamanhoNumeroRCA]                         INT             NULL,
    [ResetNumRCA]                              BIT             CONSTRAINT [DEF_ParametrosSiscafw_ResetNumRCA] DEFAULT ((0)) NOT NULL,
    [NumAFTInicial]                            INT             NULL,
    [TipoNumeracaoAFT]                         BIT             CONSTRAINT [DEF_TipoNumeracaoAFT] DEFAULT ((0)) NOT NULL,
    [IdTipoDocumentoAFT]                       INT             NULL,
    [IdTipoDocumentoRenAFT]                    INT             NULL,
    [IdAssuntoAFTPF]                           INT             NULL,
    [IdAssuntoAFTPJ]                           INT             NULL,
    [IdAssuntoRenAFTPF]                        INT             NULL,
    [IdAssuntoRenAFTPJ]                        INT             NULL,
    [AlteraNumeroProcesso]                     BIT             NULL,
    [DirArqDNE_Correios]                       VARCHAR (200)   NULL,
    [NaoExibirOBSEnd]                          BIT             DEFAULT ((0)) NULL,
    [EditarLogradouro]                         BIT             DEFAULT ((0)) NULL,
    [VersaoDNE]                                CHAR (4)        NULL,
    [DNE_Maiusculo]                            BIT             NULL,
    [ExibirInfoExecucaoFiscalPF]               BIT             CONSTRAINT [DF_ParametrosSiscafw_ExibirInfoExecucaoFiscalPF] DEFAULT ((0)) NULL,
    [UsaEmissaoSemRegistro]                    BIT             NULL,
    [Destinatario_Left]                        INT             NULL,
    [Destinatario_Top]                         INT             NULL,
    [HabilitarLayout3Guias]                    BIT             NULL,
    [GerarCadaOpcDescUmaEmissao]               BIT             NULL,
    [PermitirEnderecoCorrespondenciaIgualANao] BIT             NULL,
    [PermitirEndCorrespDesatualizado]          BIT             CONSTRAINT [def_PermitirEndCorrespDesatualizado] DEFAULT ((0)) NOT NULL,
    [ObrigarEnderecoCorrespondencia]           BIT             CONSTRAINT [def_ObrigarEnderecoCorrespondencia] DEFAULT ((0)) NOT NULL,
    [TempoTimeoutConexao]                      INT             NULL,
    [TempoTimeoutConexaoMensagem]              INT             NULL,
    [IdParametrosSiscafw]                      INT             IDENTITY (1, 1) NOT NULL,
    [prec_Assunto]                             TEXT            NULL,
    [prec_IdFormaEntregaDocumento]             INT             NULL,
    [prec_IdNivelDocumento]                    INT             NULL,
    [prec_IdSituacaoDocumento]                 INT             NULL,
    [prec_IdTipoDocumento]                     INT             NULL,
    [prec_IndOrigemDoc]                        CHAR (1)        NULL,
    [TipoDebitoCertidoesPF]                    INT             DEFAULT ((0)) NOT NULL,
    [TipoDebitoCertidoesPJ]                    INT             DEFAULT ((0)) NOT NULL,
    [DiasDataVencimento]                       INT             DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ParametrosSiscafw] PRIMARY KEY CLUSTERED ([IdParametrosSiscafw] ASC),
    CONSTRAINT [FK_IDCategoriaProf_CategoriaProf] FOREIGN KEY ([idCategoriaProf]) REFERENCES [dbo].[CategoriasProf] ([IdCategoriaProf]),
    CONSTRAINT [FK_ParametrosSiscafw_CategoriasProf] FOREIGN KEY ([IdCategoriaPadrao]) REFERENCES [dbo].[CategoriasProf] ([IdCategoriaProf]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoAFTPF] FOREIGN KEY ([IdAssuntoAFTPF]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoAFTPJ] FOREIGN KEY ([IdAssuntoAFTPJ]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoATPF] FOREIGN KEY ([IdAssuntoATPF]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoATPJ] FOREIGN KEY ([IdAssuntoATPJ]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoCertRegPF] FOREIGN KEY ([IdAssuntoCertRegPF]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoCertRegPJ] FOREIGN KEY ([IdAssuntoCertRegPJ]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoDebParcPF] FOREIGN KEY ([IdAssuntoDebParcPF]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoDebParcPJ] FOREIGN KEY ([IdAssuntoDebParcPJ]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoRCAPF] FOREIGN KEY ([IdAssuntoRCAPF]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoRCAPJ] FOREIGN KEY ([IdAssuntoRCAPJ]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoRenAFTPF] FOREIGN KEY ([IdAssuntoRenAFTPF]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoRenAFTPJ] FOREIGN KEY ([IdAssuntoRenAFTPJ]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoRenRCAPF] FOREIGN KEY ([IdAssuntoRenRCAPF]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoRenRCAPJ] FOREIGN KEY ([IdAssuntoRenRCAPJ]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoRenVistoPF] FOREIGN KEY ([IdAssuntoVistoPF]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoRenVistoPJ] FOREIGN KEY ([IdAssuntoVistoPJ]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoVistoPF] FOREIGN KEY ([IdAssuntoVistoPF]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdAssuntoVistoPJ] FOREIGN KEY ([IdAssuntoVistoPJ]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_ParametrosSiscafw_IdTipoDocumentoCertReg] FOREIGN KEY ([IdTipoDocumentoCertReg]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento]),
    CONSTRAINT [FK_ParametrosSiscafw_IdTipoDocumentoDebParc] FOREIGN KEY ([IdTipoDocumentoDebParc]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento]),
    CONSTRAINT [FK_ParametrosSiscafw_IdTipoDocumentoRenAFT] FOREIGN KEY ([IdTipoDocumentoRenAFT]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento]),
    CONSTRAINT [FK_ParametrosSiscafw_IdTipoDocumentoRenRCA] FOREIGN KEY ([IdTipoDocumentoRenRCA]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento]),
    CONSTRAINT [FK_ParametrosSiscafw_IdTipoDocumentoRenVisto] FOREIGN KEY ([IdTipoDocumentoRenVisto]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento]),
    CONSTRAINT [FK_ParametrosSiscafw_IdTipoDocumentoVisto] FOREIGN KEY ([IdTipoDocumentoVisto]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento]),
    CONSTRAINT [FK_ParametrosSiscafw_MotivoInscricao] FOREIGN KEY ([IdMotivoInscricaoPadrao]) REFERENCES [dbo].[MotivoInscricao] ([IdMotivoInscricao]),
    CONSTRAINT [FK_ParametrosSiscafw_Pessoas_Conselho] FOREIGN KEY ([IdConselhoCorrente]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ParametrosSiscafw_TiposInscricao] FOREIGN KEY ([IdTipoInscricaoPadrao]) REFERENCES [dbo].[TiposInscricao] ([IdTipoInscricao]),
    CONSTRAINT [FK_Pessoas_ParametrosSiscafw] FOREIGN KEY ([IdPessoaPadrao]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
CREATE TRIGGER [TrgLog_ParametrosSiscafw] ON [Implanta_CRPAM].[dbo].[ParametrosSiscafw] 
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
SET @TableName = 'ParametrosSiscafw'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConselhoCorrente : «' + RTRIM( ISNULL( CAST (IdConselhoCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndContabilizacao IS NULL THEN ' IndContabilizacao : «Nulo» '
                                              WHEN  IndContabilizacao = 0 THEN ' IndContabilizacao : «Falso» '
                                              WHEN  IndContabilizacao = 1 THEN ' IndContabilizacao : «Verdadeiro» '
                                    END 
                         + '| IdBancoPadrao : «' + RTRIM( ISNULL( CAST (IdBancoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRemessa : «' + RTRIM( ISNULL( CAST (DirArqRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRetorno : «' + RTRIM( ISNULL( CAST (DirArqRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRetornoProc : «' + RTRIM( ISNULL( CAST (DirArqRetornoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirFotos : «' + RTRIM( ISNULL( CAST (DirFotos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncrementoConjunto IS NULL THEN ' IncrementoConjunto : «Nulo» '
                                              WHEN  IncrementoConjunto = 0 THEN ' IncrementoConjunto : «Falso» '
                                              WHEN  IncrementoConjunto = 1 THEN ' IncrementoConjunto : «Verdadeiro» '
                                    END 
                         + '| IndIncrementoRegistroProf : «' + RTRIM( ISNULL( CAST (IndIncrementoRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndIncrementoRegistroPJ : «' + RTRIM( ISNULL( CAST (IndIncrementoRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPre_SufNumRegistroProf : «' + RTRIM( ISNULL( CAST (IndPre_SufNumRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPre_SufNumRegistroPJ : «' + RTRIM( ISNULL( CAST (IndPre_SufNumRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumRegistroProf : «' + RTRIM( ISNULL( CAST (TamanhoNumRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumRegistroPJ : «' + RTRIM( ISNULL( CAST (TamanhoNumRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ValorMargemRecebPercentual IS NULL THEN ' ValorMargemRecebPercentual : «Nulo» '
                                              WHEN  ValorMargemRecebPercentual = 0 THEN ' ValorMargemRecebPercentual : «Falso» '
                                              WHEN  ValorMargemRecebPercentual = 1 THEN ' ValorMargemRecebPercentual : «Verdadeiro» '
                                    END 
                         + '| ValorMargemReceb : «' + RTRIM( ISNULL( CAST (ValorMargemReceb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodTratamentoRecebMenor : «' + RTRIM( ISNULL( CAST (CodTratamentoRecebMenor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodTratamentoRecebMaior : «' + RTRIM( ISNULL( CAST (CodTratamentoRecebMaior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedAtrasoPadrao : «' + RTRIM( ISNULL( CAST (IdProcedAtrasoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodPadraoRepasse : «' + RTRIM( ISNULL( CAST (CodPadraoRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLivro : «' + RTRIM( ISNULL( CAST (TipoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaseCEP IS NULL THEN ' BaseCEP : «Nulo» '
                                              WHEN  BaseCEP = 0 THEN ' BaseCEP : «Falso» '
                                              WHEN  BaseCEP = 1 THEN ' BaseCEP : «Verdadeiro» '
                                    END 
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaAltura : «' + RTRIM( ISNULL( CAST (PaginaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaLargura : «' + RTRIM( ISNULL( CAST (PaginaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaOrientacao : «' + RTRIM( ISNULL( CAST (PaginaOrientacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PzEmissaoBloqueto : «' + RTRIM( ISNULL( CAST (PzEmissaoBloqueto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndAtulizReneg IS NULL THEN ' IndAtulizReneg : «Nulo» '
                                              WHEN  IndAtulizReneg = 0 THEN ' IndAtulizReneg : «Falso» '
                                              WHEN  IndAtulizReneg = 1 THEN ' IndAtulizReneg : «Verdadeiro» '
                                    END 
                         + '| IdIndiceAtulizReneg : «' + RTRIM( ISNULL( CAST (IdIndiceAtulizReneg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemSuperior : «' + RTRIM( ISNULL( CAST (EtiquetaMargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemLateral : «' + RTRIM( ISNULL( CAST (EtiquetaMargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaVertical : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaHorizontal : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaAltura : «' + RTRIM( ISNULL( CAST (EtiquetaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaLargura : «' + RTRIM( ISNULL( CAST (EtiquetaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemPagamentoPadrao : «' + RTRIM( ISNULL( CAST (OrigemPagamentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercAcrescimoCumulativo : «' + RTRIM( ISNULL( CAST (PercAcrescimoCumulativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressaoCarne : «' + RTRIM( ISNULL( CAST (FormaImpressaoCarne AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressaoBoleto : «' + RTRIM( ISNULL( CAST (FormaImpressaoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaTamanhoPapel : «' + RTRIM( ISNULL( CAST (EtiquetaTamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura_Frame_Processos : «' + RTRIM( ISNULL( CAST (Altura_Frame_Processos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura_Frame_Processos : «' + RTRIM( ISNULL( CAST (Largura_Frame_Processos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoPadraoWEB : «' + RTRIM( ISNULL( CAST (IdBancoPadraoWEB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPadrao : «' + RTRIM( ISNULL( CAST (IdPessoaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES IS NULL THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Nulo» '
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES = 0 THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Falso» '
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES = 1 THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FazLancamentoContabil IS NULL THEN ' FazLancamentoContabil : «Nulo» '
                                              WHEN  FazLancamentoContabil = 0 THEN ' FazLancamentoContabil : «Falso» '
                                              WHEN  FazLancamentoContabil = 1 THEN ' FazLancamentoContabil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BaixarHistoricoEmissao IS NULL THEN ' BaixarHistoricoEmissao : «Nulo» '
                                              WHEN  BaixarHistoricoEmissao = 0 THEN ' BaixarHistoricoEmissao : «Falso» '
                                              WHEN  BaixarHistoricoEmissao = 1 THEN ' BaixarHistoricoEmissao : «Verdadeiro» '
                                    END 
                         + '| ReiniciaAno : «' + RTRIM( ISNULL( CAST (ReiniciaAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscAutoInc : «' + RTRIM( ISNULL( CAST (FiscAutoInc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscPrefSuf : «' + RTRIM( ISNULL( CAST (FiscPrefSuf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaCodigoBarras : «' + RTRIM( ISNULL( CAST (SequenciaCodigoBarras AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarrasSufixo : «' + RTRIM( ISNULL( CAST (CodigoBarrasSufixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarrasPrefixo : «' + RTRIM( ISNULL( CAST (CodigoBarrasPrefixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ControlarDivAtiva IS NULL THEN ' ControlarDivAtiva : «Nulo» '
                                              WHEN  ControlarDivAtiva = 0 THEN ' ControlarDivAtiva : «Falso» '
                                              WHEN  ControlarDivAtiva = 1 THEN ' ControlarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| TempoLock : «' + RTRIM( ISNULL( CONVERT (CHAR, TempoLock, 113 ),'Nulo'))+'» '
                         + '| CadastrarPessoaPor : «' + RTRIM( ISNULL( CAST (CadastrarPessoaPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| tamanhoRodape : «' + RTRIM( ISNULL( CAST (tamanhoRodape AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OcorrenciasAlterarExcluir : «' + RTRIM( ISNULL( CAST (OcorrenciasAlterarExcluir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FasesAlterarExcluir : «' + RTRIM( ISNULL( CAST (FasesAlterarExcluir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsarNumDoc IS NULL THEN ' UsarNumDoc : «Nulo» '
                                              WHEN  UsarNumDoc = 0 THEN ' UsarNumDoc : «Falso» '
                                              WHEN  UsarNumDoc = 1 THEN ' UsarNumDoc : «Verdadeiro» '
                                    END 
                         + '| IdModeloDoc : «' + RTRIM( ISNULL( CAST (IdModeloDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CancelarDivAtiva IS NULL THEN ' CancelarDivAtiva : «Nulo» '
                                              WHEN  CancelarDivAtiva = 0 THEN ' CancelarDivAtiva : «Falso» '
                                              WHEN  CancelarDivAtiva = 1 THEN ' CancelarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociarDivAtiva IS NULL THEN ' RenegociarDivAtiva : «Nulo» '
                                              WHEN  RenegociarDivAtiva = 0 THEN ' RenegociarDivAtiva : «Falso» '
                                              WHEN  RenegociarDivAtiva = 1 THEN ' RenegociarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| ControleDividaAtiva : «' + RTRIM( ISNULL( CAST (ControleDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUltimoLivro : «' + RTRIM( ISNULL( CAST (IdUltimoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idCategoriaProf : «' + RTRIM( ISNULL( CAST (idCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesDataEntrada : «' + RTRIM( ISNULL( CAST (TramitacoesDataEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| campoCabecalhoFisc : «' + RTRIM( ISNULL( CAST (campoCabecalhoFisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico1 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico2 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico3 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesCaptionAbaDinamica : «' + RTRIM( ISNULL( CAST (FiscalizacoesCaptionAbaDinamica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoCaptionAbaDinamicaFisc : «' + RTRIM( ISNULL( CAST (FiscalizacaoCaptionAbaDinamicaFisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico1 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico2 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico3 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoCaptionAbaDinamica : «' + RTRIM( ISNULL( CAST (FiscalizacaoCaptionAbaDinamica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAnoCorrenteVerifAdimplente IS NULL THEN ' UsaAnoCorrenteVerifAdimplente : «Nulo» '
                                              WHEN  UsaAnoCorrenteVerifAdimplente = 0 THEN ' UsaAnoCorrenteVerifAdimplente : «Falso» '
                                              WHEN  UsaAnoCorrenteVerifAdimplente = 1 THEN ' UsaAnoCorrenteVerifAdimplente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IgnorarZerosEsq_Registro IS NULL THEN ' IgnorarZerosEsq_Registro : «Nulo» '
                                              WHEN  IgnorarZerosEsq_Registro = 0 THEN ' IgnorarZerosEsq_Registro : «Falso» '
                                              WHEN  IgnorarZerosEsq_Registro = 1 THEN ' IgnorarZerosEsq_Registro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RegistraDtCredito IS NULL THEN ' RegistraDtCredito : «Nulo» '
                                              WHEN  RegistraDtCredito = 0 THEN ' RegistraDtCredito : «Falso» '
                                              WHEN  RegistraDtCredito = 1 THEN ' RegistraDtCredito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CriaProcessoInscricao IS NULL THEN ' CriaProcessoInscricao : «Nulo» '
                                              WHEN  CriaProcessoInscricao = 0 THEN ' CriaProcessoInscricao : «Falso» '
                                              WHEN  CriaProcessoInscricao = 1 THEN ' CriaProcessoInscricao : «Verdadeiro» '
                                    END 
                         + '| IdMoedaPadrao : «' + RTRIM( ISNULL( CAST (IdMoedaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CadPFMostraEnderecoDivulgacao IS NULL THEN ' CadPFMostraEnderecoDivulgacao : «Nulo» '
                                              WHEN  CadPFMostraEnderecoDivulgacao = 0 THEN ' CadPFMostraEnderecoDivulgacao : «Falso» '
                                              WHEN  CadPFMostraEnderecoDivulgacao = 1 THEN ' CadPFMostraEnderecoDivulgacao : «Verdadeiro» '
                                    END 
                         + '| TipoProcPagamentoBB : «' + RTRIM( ISNULL( CAST (TipoProcPagamentoBB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcInscricao : «' + RTRIM( ISNULL( CAST (NumeroProcInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraAutomaticoArquivoIndividual IS NULL THEN ' GeraAutomaticoArquivoIndividual : «Nulo» '
                                              WHEN  GeraAutomaticoArquivoIndividual = 0 THEN ' GeraAutomaticoArquivoIndividual : «Falso» '
                                              WHEN  GeraAutomaticoArquivoIndividual = 1 THEN ' GeraAutomaticoArquivoIndividual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlterarDataInscricaoConselho IS NULL THEN ' AlterarDataInscricaoConselho : «Nulo» '
                                              WHEN  AlterarDataInscricaoConselho = 0 THEN ' AlterarDataInscricaoConselho : «Falso» '
                                              WHEN  AlterarDataInscricaoConselho = 1 THEN ' AlterarDataInscricaoConselho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VerifNossoNumDuplicDetEmiss IS NULL THEN ' VerifNossoNumDuplicDetEmiss : «Nulo» '
                                              WHEN  VerifNossoNumDuplicDetEmiss = 0 THEN ' VerifNossoNumDuplicDetEmiss : «Falso» '
                                              WHEN  VerifNossoNumDuplicDetEmiss = 1 THEN ' VerifNossoNumDuplicDetEmiss : «Verdadeiro» '
                                    END 
                         + '| IdProfissionalPresidente : «' + RTRIM( ISNULL( CAST (IdProfissionalPresidente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalVice : «' + RTRIM( ISNULL( CAST (IdProfissionalVice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModeloEntregaCarteirinha : «' + RTRIM( ISNULL( CAST (IdModeloEntregaCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AssociarCidadeSubRegiao IS NULL THEN ' AssociarCidadeSubRegiao : «Nulo» '
                                              WHEN  AssociarCidadeSubRegiao = 0 THEN ' AssociarCidadeSubRegiao : «Falso» '
                                              WHEN  AssociarCidadeSubRegiao = 1 THEN ' AssociarCidadeSubRegiao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaDataTermino IS NULL THEN ' ControlaDataTermino : «Nulo» '
                                              WHEN  ControlaDataTermino = 0 THEN ' ControlaDataTermino : «Falso» '
                                              WHEN  ControlaDataTermino = 1 THEN ' ControlaDataTermino : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaDebitoConta IS NULL THEN ' UtilizaDebitoConta : «Nulo» '
                                              WHEN  UtilizaDebitoConta = 0 THEN ' UtilizaDebitoConta : «Falso» '
                                              WHEN  UtilizaDebitoConta = 1 THEN ' UtilizaDebitoConta : «Verdadeiro» '
                                    END 
                         + '| SequencialNossoNumeroDebConta : «' + RTRIM( ISNULL( CAST (SequencialNossoNumeroDebConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosicaoDivida : «' + RTRIM( ISNULL( CAST (PosicaoDivida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquetoComDesconto_Individual IS NULL THEN ' BloquetoComDesconto_Individual : «Nulo» '
                                              WHEN  BloquetoComDesconto_Individual = 0 THEN ' BloquetoComDesconto_Individual : «Falso» '
                                              WHEN  BloquetoComDesconto_Individual = 1 THEN ' BloquetoComDesconto_Individual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SugerirDataPgto IS NULL THEN ' SugerirDataPgto : «Nulo» '
                                              WHEN  SugerirDataPgto = 0 THEN ' SugerirDataPgto : «Falso» '
                                              WHEN  SugerirDataPgto = 1 THEN ' SugerirDataPgto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpedirDataPgtoFutura IS NULL THEN ' ImpedirDataPgtoFutura : «Nulo» '
                                              WHEN  ImpedirDataPgtoFutura = 0 THEN ' ImpedirDataPgtoFutura : «Falso» '
                                              WHEN  ImpedirDataPgtoFutura = 1 THEN ' ImpedirDataPgtoFutura : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociacaoViaCertidao IS NULL THEN ' RenegociacaoViaCertidao : «Nulo» '
                                              WHEN  RenegociacaoViaCertidao = 0 THEN ' RenegociacaoViaCertidao : «Falso» '
                                              WHEN  RenegociacaoViaCertidao = 1 THEN ' RenegociacaoViaCertidao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SugerirDataReferencia IS NULL THEN ' SugerirDataReferencia : «Nulo» '
                                              WHEN  SugerirDataReferencia = 0 THEN ' SugerirDataReferencia : «Falso» '
                                              WHEN  SugerirDataReferencia = 1 THEN ' SugerirDataReferencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IncrementarCF IS NULL THEN ' IncrementarCF : «Nulo» '
                                              WHEN  IncrementarCF = 0 THEN ' IncrementarCF : «Falso» '
                                              WHEN  IncrementarCF = 1 THEN ' IncrementarCF : «Verdadeiro» '
                                    END 
                         + '| SequencialCodigoFiscalizador : «' + RTRIM( ISNULL( CAST (SequencialCodigoFiscalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraNumeroProcessoPessoas IS NULL THEN ' GeraNumeroProcessoPessoas : «Nulo» '
                                              WHEN  GeraNumeroProcessoPessoas = 0 THEN ' GeraNumeroProcessoPessoas : «Falso» '
                                              WHEN  GeraNumeroProcessoPessoas = 1 THEN ' GeraNumeroProcessoPessoas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaNunProcessoBloqueto IS NULL THEN ' UtilizaNunProcessoBloqueto : «Nulo» '
                                              WHEN  UtilizaNunProcessoBloqueto = 0 THEN ' UtilizaNunProcessoBloqueto : «Falso» '
                                              WHEN  UtilizaNunProcessoBloqueto = 1 THEN ' UtilizaNunProcessoBloqueto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MudancaClassesAtiva IS NULL THEN ' MudancaClassesAtiva : «Nulo» '
                                              WHEN  MudancaClassesAtiva = 0 THEN ' MudancaClassesAtiva : «Falso» '
                                              WHEN  MudancaClassesAtiva = 1 THEN ' MudancaClassesAtiva : «Verdadeiro» '
                                    END 
                         + '| DiaMesMudancaClasses : «' + RTRIM( ISNULL( CAST (DiaMesMudancaClasses AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximoAnoMudancaClasses : «' + RTRIM( ISNULL( CAST (ProximoAnoMudancaClasses AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bNumerarRen IS NULL THEN ' bNumerarRen : «Nulo» '
                                              WHEN  bNumerarRen = 0 THEN ' bNumerarRen : «Falso» '
                                              WHEN  bNumerarRen = 1 THEN ' bNumerarRen : «Verdadeiro» '
                                    END 
                         + '| NumeroRenegociacao : «' + RTRIM( ISNULL( CAST (NumeroRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcEnviar : «' + RTRIM( ISNULL( CAST (TramitacoesProcEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcReceber : «' + RTRIM( ISNULL( CAST (TramitacoesProcReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcAlterar : «' + RTRIM( ISNULL( CAST (TramitacoesProcAlterar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TramitacoesProcFiltraRespLocal IS NULL THEN ' TramitacoesProcFiltraRespLocal : «Nulo» '
                                              WHEN  TramitacoesProcFiltraRespLocal = 0 THEN ' TramitacoesProcFiltraRespLocal : «Falso» '
                                              WHEN  TramitacoesProcFiltraRespLocal = 1 THEN ' TramitacoesProcFiltraRespLocal : «Verdadeiro» '
                                    END 
                         + '| TramitacoesProcAlterarExt : «' + RTRIM( ISNULL( CAST (TramitacoesProcAlterarExt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrioridadePadrao : «' + RTRIM( ISNULL( CAST (PrioridadePadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoPadrao : «' + RTRIM( ISNULL( CAST (SituacaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialProcesso : «' + RTRIM( ISNULL( CAST (SequencialProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoProcesso : «' + RTRIM( ISNULL( CAST (AnoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumeracaoUnicaProcesso IS NULL THEN ' NumeracaoUnicaProcesso : «Nulo» '
                                              WHEN  NumeracaoUnicaProcesso = 0 THEN ' NumeracaoUnicaProcesso : «Falso» '
                                              WHEN  NumeracaoUnicaProcesso = 1 THEN ' NumeracaoUnicaProcesso : «Verdadeiro» '
                                    END 
                         + '| IdCategoriaPadrao : «' + RTRIM( ISNULL( CAST (IdCategoriaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricaoPadrao : «' + RTRIM( ISNULL( CAST (IdTipoInscricaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoInscricaoPadrao : «' + RTRIM( ISNULL( CAST (IdMotivoInscricaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarUsuarioPadrao IS NULL THEN ' UtilizarUsuarioPadrao : «Nulo» '
                                              WHEN  UtilizarUsuarioPadrao = 0 THEN ' UtilizarUsuarioPadrao : «Falso» '
                                              WHEN  UtilizarUsuarioPadrao = 1 THEN ' UtilizarUsuarioPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaPesquisaGenerica IS NULL THEN ' UtilizaPesquisaGenerica : «Nulo» '
                                              WHEN  UtilizaPesquisaGenerica = 0 THEN ' UtilizaPesquisaGenerica : «Falso» '
                                              WHEN  UtilizaPesquisaGenerica = 1 THEN ' UtilizaPesquisaGenerica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LiberaEnvioTramitacao IS NULL THEN ' LiberaEnvioTramitacao : «Nulo» '
                                              WHEN  LiberaEnvioTramitacao = 0 THEN ' LiberaEnvioTramitacao : «Falso» '
                                              WHEN  LiberaEnvioTramitacao = 1 THEN ' LiberaEnvioTramitacao : «Verdadeiro» '
                                    END 
                         + '| SequencialNumeroCarteira : «' + RTRIM( ISNULL( CAST (SequencialNumeroCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ResumoDebitoVinculado IS NULL THEN ' ResumoDebitoVinculado : «Nulo» '
                                              WHEN  ResumoDebitoVinculado = 0 THEN ' ResumoDebitoVinculado : «Falso» '
                                              WHEN  ResumoDebitoVinculado = 1 THEN ' ResumoDebitoVinculado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaSequencialNumeroCarteira IS NULL THEN ' UtilizaSequencialNumeroCarteira : «Nulo» '
                                              WHEN  UtilizaSequencialNumeroCarteira = 0 THEN ' UtilizaSequencialNumeroCarteira : «Falso» '
                                              WHEN  UtilizaSequencialNumeroCarteira = 1 THEN ' UtilizaSequencialNumeroCarteira : «Verdadeiro» '
                                    END 
                         + '| MargemSupBoleto : «' + RTRIM( ISNULL( CAST (MargemSupBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDirBoleto : «' + RTRIM( ISNULL( CAST (MargemDirBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInfBoleto : «' + RTRIM( ISNULL( CAST (MargemInfBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsqBoleto : «' + RTRIM( ISNULL( CAST (MargemEsqBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CriticaCPFArquivoRemessa IS NULL THEN ' CriticaCPFArquivoRemessa : «Nulo» '
                                              WHEN  CriticaCPFArquivoRemessa = 0 THEN ' CriticaCPFArquivoRemessa : «Falso» '
                                              WHEN  CriticaCPFArquivoRemessa = 1 THEN ' CriticaCPFArquivoRemessa : «Verdadeiro» '
                                    END 
                         + '| SequencialSeuNumero : «' + RTRIM( ISNULL( CAST (SequencialSeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoEmailSuspensao : «' + RTRIM( ISNULL( CAST (AssuntoEmailSuspensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoEmailLevantamentoSuspensao : «' + RTRIM( ISNULL( CAST (AssuntoEmailLevantamentoSuspensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioEmailSuspensao IS NULL THEN ' EnvioEmailSuspensao : «Nulo» '
                                              WHEN  EnvioEmailSuspensao = 0 THEN ' EnvioEmailSuspensao : «Falso» '
                                              WHEN  EnvioEmailSuspensao = 1 THEN ' EnvioEmailSuspensao : «Verdadeiro» '
                                    END 
                         + '| IndPrioridadeBaixaPgto : «' + RTRIM( ISNULL( CAST (IndPrioridadeBaixaPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailProcesso : «' + RTRIM( ISNULL( CAST (UsuarioEmailProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaUsuarioEmailProcesso : «' + RTRIM( ISNULL( CAST (SenhaUsuarioEmailProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LogAtivado IS NULL THEN ' LogAtivado : «Nulo» '
                                              WHEN  LogAtivado = 0 THEN ' LogAtivado : «Falso» '
                                              WHEN  LogAtivado = 1 THEN ' LogAtivado : «Verdadeiro» '
                                    END 
                         + '| Assinatura1 : «' + RTRIM( ISNULL( CAST (Assinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura2 : «' + RTRIM( ISNULL( CAST (Assinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo1 : «' + RTRIM( ISNULL( CAST (Cargo1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo2 : «' + RTRIM( ISNULL( CAST (Cargo2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasServidor : «' + RTRIM( ISNULL( CAST (EmailCartirasServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCarteirasPorta : «' + RTRIM( ISNULL( CAST (EmailCarteirasPorta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasUsuario : «' + RTRIM( ISNULL( CAST (EmailCartirasUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasSenha : «' + RTRIM( ISNULL( CAST (EmailCartirasSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasAssunto : «' + RTRIM( ISNULL( CAST (EmailCartirasAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OcorrenciaCartirasImpressao IS NULL THEN ' OcorrenciaCartirasImpressao : «Nulo» '
                                              WHEN  OcorrenciaCartirasImpressao = 0 THEN ' OcorrenciaCartirasImpressao : «Falso» '
                                              WHEN  OcorrenciaCartirasImpressao = 1 THEN ' OcorrenciaCartirasImpressao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OcorrenciaCartirasEmail IS NULL THEN ' OcorrenciaCartirasEmail : «Nulo» '
                                              WHEN  OcorrenciaCartirasEmail = 0 THEN ' OcorrenciaCartirasEmail : «Falso» '
                                              WHEN  OcorrenciaCartirasEmail = 1 THEN ' OcorrenciaCartirasEmail : «Verdadeiro» '
                                    END 
                         + '| OcorrenciaCartirasTexto : «' + RTRIM( ISNULL( CAST (OcorrenciaCartirasTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OcorrenciaCartirasDetalhes : «' + RTRIM( ISNULL( CAST (OcorrenciaCartirasDetalhes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UtilizaAgendaContatos : «' + RTRIM( ISNULL( CAST (UtilizaAgendaContatos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EditarCEP IS NULL THEN ' EditarCEP : «Nulo» '
                                              WHEN  EditarCEP = 0 THEN ' EditarCEP : «Falso» '
                                              WHEN  EditarCEP = 1 THEN ' EditarCEP : «Verdadeiro» '
                                    END 
                         + '| LocalizarProfPJ : «' + RTRIM( ISNULL( CAST (LocalizarProfPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqApreciacao : «' + RTRIM( ISNULL( CAST (DirArqApreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqResolucao : «' + RTRIM( ISNULL( CAST (DirArqResolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirModeloResolucao : «' + RTRIM( ISNULL( CAST (DirModeloResolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GerarSubDiretorioPorBanco IS NULL THEN ' GerarSubDiretorioPorBanco : «Nulo» '
                                              WHEN  GerarSubDiretorioPorBanco = 0 THEN ' GerarSubDiretorioPorBanco : «Falso» '
                                              WHEN  GerarSubDiretorioPorBanco = 1 THEN ' GerarSubDiretorioPorBanco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirAdimplenciaEmVotacao IS NULL THEN ' ExibirAdimplenciaEmVotacao : «Nulo» '
                                              WHEN  ExibirAdimplenciaEmVotacao = 0 THEN ' ExibirAdimplenciaEmVotacao : «Falso» '
                                              WHEN  ExibirAdimplenciaEmVotacao = 1 THEN ' ExibirAdimplenciaEmVotacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReiniciaAnoProc IS NULL THEN ' ReiniciaAnoProc : «Nulo» '
                                              WHEN  ReiniciaAnoProc = 0 THEN ' ReiniciaAnoProc : «Falso» '
                                              WHEN  ReiniciaAnoProc = 1 THEN ' ReiniciaAnoProc : «Verdadeiro» '
                                    END 
                         + '| DtVencAnuConsiderarInadimpl : «' + RTRIM( ISNULL( CAST (DtVencAnuConsiderarInadimpl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarAcrescimoRecobranca IS NULL THEN ' UtilizarAcrescimoRecobranca : «Nulo» '
                                              WHEN  UtilizarAcrescimoRecobranca = 0 THEN ' UtilizarAcrescimoRecobranca : «Falso» '
                                              WHEN  UtilizarAcrescimoRecobranca = 1 THEN ' UtilizarAcrescimoRecobranca : «Verdadeiro» '
                                    END 
                         + '| DataAlterarValorDA : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlterarValorDA, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AceitarPgtoCanceladoArquivoRet IS NULL THEN ' AceitarPgtoCanceladoArquivoRet : «Nulo» '
                                              WHEN  AceitarPgtoCanceladoArquivoRet = 0 THEN ' AceitarPgtoCanceladoArquivoRet : «Falso» '
                                              WHEN  AceitarPgtoCanceladoArquivoRet = 1 THEN ' AceitarPgtoCanceladoArquivoRet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitarPgtoPagoArquivoRet IS NULL THEN ' AceitarPgtoPagoArquivoRet : «Nulo» '
                                              WHEN  AceitarPgtoPagoArquivoRet = 0 THEN ' AceitarPgtoPagoArquivoRet : «Falso» '
                                              WHEN  AceitarPgtoPagoArquivoRet = 1 THEN ' AceitarPgtoPagoArquivoRet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaoBaixarPagoMaior IS NULL THEN ' NaoBaixarPagoMaior : «Nulo» '
                                              WHEN  NaoBaixarPagoMaior = 0 THEN ' NaoBaixarPagoMaior : «Falso» '
                                              WHEN  NaoBaixarPagoMaior = 1 THEN ' NaoBaixarPagoMaior : «Verdadeiro» '
                                    END 
                         + '| ValorMargemPagoMaior : «' + RTRIM( ISNULL( CAST (ValorMargemPagoMaior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqThemis : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqThemis, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqAdvatu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqAdvatu, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqTJ : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqTJ, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FlagScriptSituacaoPFPJ IS NULL THEN ' FlagScriptSituacaoPFPJ : «Nulo» '
                                              WHEN  FlagScriptSituacaoPFPJ = 0 THEN ' FlagScriptSituacaoPFPJ : «Falso» '
                                              WHEN  FlagScriptSituacaoPFPJ = 1 THEN ' FlagScriptSituacaoPFPJ : «Verdadeiro» '
                                    END 
                         + '| FiscTamanhoSequencial : «' + RTRIM( ISNULL( CAST (FiscTamanhoSequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscSigla : «' + RTRIM( ISNULL( CAST (FiscSigla AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FlagScriptSituacaoPFPJ2 IS NULL THEN ' FlagScriptSituacaoPFPJ2 : «Nulo» '
                                              WHEN  FlagScriptSituacaoPFPJ2 = 0 THEN ' FlagScriptSituacaoPFPJ2 : «Falso» '
                                              WHEN  FlagScriptSituacaoPFPJ2 = 1 THEN ' FlagScriptSituacaoPFPJ2 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitaDataFutura IS NULL THEN ' AceitaDataFutura : «Nulo» '
                                              WHEN  AceitaDataFutura = 0 THEN ' AceitaDataFutura : «Falso» '
                                              WHEN  AceitaDataFutura = 1 THEN ' AceitaDataFutura : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IgnoraVlrPgSitDeb IS NULL THEN ' IgnoraVlrPgSitDeb : «Nulo» '
                                              WHEN  IgnoraVlrPgSitDeb = 0 THEN ' IgnoraVlrPgSitDeb : «Falso» '
                                              WHEN  IgnoraVlrPgSitDeb = 1 THEN ' IgnoraVlrPgSitDeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailCarteirasAutenticaSSL IS NULL THEN ' EmailCarteirasAutenticaSSL : «Nulo» '
                                              WHEN  EmailCarteirasAutenticaSSL = 0 THEN ' EmailCarteirasAutenticaSSL : «Falso» '
                                              WHEN  EmailCarteirasAutenticaSSL = 1 THEN ' EmailCarteirasAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearEdicaoSubRegiao IS NULL THEN ' BloquearEdicaoSubRegiao : «Nulo» '
                                              WHEN  BloquearEdicaoSubRegiao = 0 THEN ' BloquearEdicaoSubRegiao : «Falso» '
                                              WHEN  BloquearEdicaoSubRegiao = 1 THEN ' BloquearEdicaoSubRegiao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| FltrDebAnoInicial : «' + RTRIM( ISNULL( CAST (FltrDebAnoInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebAnoFinal : «' + RTRIM( ISNULL( CAST (FltrDebAnoFinal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebVencInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, FltrDebVencInicial, 113 ),'Nulo'))+'» '
                         + '| FltrDebVencFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, FltrDebVencFinal, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FltrDebNExibirRenCanc IS NULL THEN ' FltrDebNExibirRenCanc : «Nulo» '
                                              WHEN  FltrDebNExibirRenCanc = 0 THEN ' FltrDebNExibirRenCanc : «Falso» '
                                              WHEN  FltrDebNExibirRenCanc = 1 THEN ' FltrDebNExibirRenCanc : «Verdadeiro» '
                                    END 
                         + '| FltrDebTipoDeb : «' + RTRIM( ISNULL( CAST (FltrDebTipoDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebSituacaoDeb : «' + RTRIM( ISNULL( CAST (FltrDebSituacaoDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebMotivoCanc : «' + RTRIM( ISNULL( CAST (FltrDebMotivoCanc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndUtilizaMsgDtPrevisaoProc IS NULL THEN ' IndUtilizaMsgDtPrevisaoProc : «Nulo» '
                                              WHEN  IndUtilizaMsgDtPrevisaoProc = 0 THEN ' IndUtilizaMsgDtPrevisaoProc : «Falso» '
                                              WHEN  IndUtilizaMsgDtPrevisaoProc = 1 THEN ' IndUtilizaMsgDtPrevisaoProc : «Verdadeiro» '
                                    END 
                         + '| TipoExibicaoMsgDtPrevicaoProc : «' + RTRIM( ISNULL( CAST (TipoExibicaoMsgDtPrevicaoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitirAcesProcInterno IS NULL THEN ' PermitirAcesProcInterno : «Nulo» '
                                              WHEN  PermitirAcesProcInterno = 0 THEN ' PermitirAcesProcInterno : «Falso» '
                                              WHEN  PermitirAcesProcInterno = 1 THEN ' PermitirAcesProcInterno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirAcesFiscInterno IS NULL THEN ' PermitirAcesFiscInterno : «Nulo» '
                                              WHEN  PermitirAcesFiscInterno = 0 THEN ' PermitirAcesFiscInterno : «Falso» '
                                              WHEN  PermitirAcesFiscInterno = 1 THEN ' PermitirAcesFiscInterno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarIntegracao IS NULL THEN ' UtilizarIntegracao : «Nulo» '
                                              WHEN  UtilizarIntegracao = 0 THEN ' UtilizarIntegracao : «Falso» '
                                              WHEN  UtilizarIntegracao = 1 THEN ' UtilizarIntegracao : «Verdadeiro» '
                                    END 
                         + '| IntegracaoProvider : «' + RTRIM( ISNULL( CAST (IntegracaoProvider AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoServidor : «' + RTRIM( ISNULL( CAST (IntegracaoServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoBancoDados : «' + RTRIM( ISNULL( CAST (IntegracaoBancoDados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoSchema : «' + RTRIM( ISNULL( CAST (IntegracaoSchema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoUsuario : «' + RTRIM( ISNULL( CAST (IntegracaoUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoSenha : «' + RTRIM( ISNULL( CAST (IntegracaoSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarCampoObr IS NULL THEN ' AplicarCampoObr : «Nulo» '
                                              WHEN  AplicarCampoObr = 0 THEN ' AplicarCampoObr : «Falso» '
                                              WHEN  AplicarCampoObr = 1 THEN ' AplicarCampoObr : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarAssistenteCadastro IS NULL THEN ' UtilizarAssistenteCadastro : «Nulo» '
                                              WHEN  UtilizarAssistenteCadastro = 0 THEN ' UtilizarAssistenteCadastro : «Falso» '
                                              WHEN  UtilizarAssistenteCadastro = 1 THEN ' UtilizarAssistenteCadastro : «Verdadeiro» '
                                    END 
                         + '| DirRel : «' + RTRIM( ISNULL( CAST (DirRel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaControleDigitalizacoes IS NULL THEN ' UtilizaControleDigitalizacoes : «Nulo» '
                                              WHEN  UtilizaControleDigitalizacoes = 0 THEN ' UtilizaControleDigitalizacoes : «Falso» '
                                              WHEN  UtilizaControleDigitalizacoes = 1 THEN ' UtilizaControleDigitalizacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirVinculoProcTipoDif IS NULL THEN ' PermitirVinculoProcTipoDif : «Nulo» '
                                              WHEN  PermitirVinculoProcTipoDif = 0 THEN ' PermitirVinculoProcTipoDif : «Falso» '
                                              WHEN  PermitirVinculoProcTipoDif = 1 THEN ' PermitirVinculoProcTipoDif : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitacaoDataPrevObrig IS NULL THEN ' TramitacaoDataPrevObrig : «Nulo» '
                                              WHEN  TramitacaoDataPrevObrig = 0 THEN ' TramitacaoDataPrevObrig : «Falso» '
                                              WHEN  TramitacaoDataPrevObrig = 1 THEN ' TramitacaoDataPrevObrig : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitPermitirDesativarAviso IS NULL THEN ' TramitPermitirDesativarAviso : «Nulo» '
                                              WHEN  TramitPermitirDesativarAviso = 0 THEN ' TramitPermitirDesativarAviso : «Falso» '
                                              WHEN  TramitPermitirDesativarAviso = 1 THEN ' TramitPermitirDesativarAviso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAlteracaoTramitacao IS NULL THEN ' BloquearAlteracaoTramitacao : «Nulo» '
                                              WHEN  BloquearAlteracaoTramitacao = 0 THEN ' BloquearAlteracaoTramitacao : «Falso» '
                                              WHEN  BloquearAlteracaoTramitacao = 1 THEN ' BloquearAlteracaoTramitacao : «Verdadeiro» '
                                    END 
                         + '| DuplicidadeNR : «' + RTRIM( ISNULL( CAST (DuplicidadeNR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComputadorMalaDireta : «' + RTRIM( ISNULL( CAST (ComputadorMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaPeticaoCDA IS NULL THEN ' AgrupaPeticaoCDA : «Nulo» '
                                              WHEN  AgrupaPeticaoCDA = 0 THEN ' AgrupaPeticaoCDA : «Falso» '
                                              WHEN  AgrupaPeticaoCDA = 1 THEN ' AgrupaPeticaoCDA : «Verdadeiro» '
                                    END 
                         + '| EmailEnvioErros : «' + RTRIM( ISNULL( CAST (EmailEnvioErros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalDividaAtivaAtualizada : «' + RTRIM( ISNULL( CAST (TotalDividaAtivaAtualizada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigRelatorioFixoXML : «' + RTRIM( ISNULL( CAST (ConfigRelatorioFixoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirAlertaPendBaixa IS NULL THEN ' ExibirAlertaPendBaixa : «Nulo» '
                                              WHEN  ExibirAlertaPendBaixa = 0 THEN ' ExibirAlertaPendBaixa : «Falso» '
                                              WHEN  ExibirAlertaPendBaixa = 1 THEN ' ExibirAlertaPendBaixa : «Verdadeiro» '
                                    END 
                         + '| ExibirAlertaPendBaixaAPartirDe : «' + RTRIM( ISNULL( CONVERT (CHAR, ExibirAlertaPendBaixaAPartirDe, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConcatenarLocalTrabalho IS NULL THEN ' ConcatenarLocalTrabalho : «Nulo» '
                                              WHEN  ConcatenarLocalTrabalho = 0 THEN ' ConcatenarLocalTrabalho : «Falso» '
                                              WHEN  ConcatenarLocalTrabalho = 1 THEN ' ConcatenarLocalTrabalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NrInfObrigatorio IS NULL THEN ' NrInfObrigatorio : «Nulo» '
                                              WHEN  NrInfObrigatorio = 0 THEN ' NrInfObrigatorio : «Falso» '
                                              WHEN  NrInfObrigatorio = 1 THEN ' NrInfObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NrInfRecebeNrModeloAutoInf IS NULL THEN ' NrInfRecebeNrModeloAutoInf : «Nulo» '
                                              WHEN  NrInfRecebeNrModeloAutoInf = 0 THEN ' NrInfRecebeNrModeloAutoInf : «Falso» '
                                              WHEN  NrInfRecebeNrModeloAutoInf = 1 THEN ' NrInfRecebeNrModeloAutoInf : «Verdadeiro» '
                                    END 
                         + '| DataVerificacaoREN : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVerificacaoREN, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FormaImpressao IS NULL THEN ' FormaImpressao : «Nulo» '
                                              WHEN  FormaImpressao = 0 THEN ' FormaImpressao : «Falso» '
                                              WHEN  FormaImpressao = 1 THEN ' FormaImpressao : «Verdadeiro» '
                                    END 
                         + '| idPadraoEtapaProcInscricaoPF : «' + RTRIM( ISNULL( CAST (idPadraoEtapaProcInscricaoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idPadraoEtapaProcInscricaoPJ : «' + RTRIM( ISNULL( CAST (idPadraoEtapaProcInscricaoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TxtPreviaAcordoRen : «' + RTRIM( ISNULL( CAST (TxtPreviaAcordoRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebitoHonorariosAdv : «' + RTRIM( ISNULL( CAST (IdTipoDebitoHonorariosAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeVersoBoleto IS NULL THEN ' ImprimeVersoBoleto : «Nulo» '
                                              WHEN  ImprimeVersoBoleto = 0 THEN ' ImprimeVersoBoleto : «Falso» '
                                              WHEN  ImprimeVersoBoleto = 1 THEN ' ImprimeVersoBoleto : «Verdadeiro» '
                                    END 
                         + '| IdTipoDebitoFS : «' + RTRIM( ISNULL( CAST (IdTipoDebitoFS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal IS NULL THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Nulo» '
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal = 0 THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Falso» '
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal = 1 THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNARemoverZeros IS NULL THEN ' CNARemoverZeros : «Nulo» '
                                              WHEN  CNARemoverZeros = 0 THEN ' CNARemoverZeros : «Falso» '
                                              WHEN  CNARemoverZeros = 1 THEN ' CNARemoverZeros : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NotCPFDuplicado IS NULL THEN ' NotCPFDuplicado : «Nulo» '
                                              WHEN  NotCPFDuplicado = 0 THEN ' NotCPFDuplicado : «Falso» '
                                              WHEN  NotCPFDuplicado = 1 THEN ' NotCPFDuplicado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DIV_SituacoesPFPJ IS NULL THEN ' DIV_SituacoesPFPJ : «Nulo» '
                                              WHEN  DIV_SituacoesPFPJ = 0 THEN ' DIV_SituacoesPFPJ : «Falso» '
                                              WHEN  DIV_SituacoesPFPJ = 1 THEN ' DIV_SituacoesPFPJ : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DIV_TiposInscricao IS NULL THEN ' DIV_TiposInscricao : «Nulo» '
                                              WHEN  DIV_TiposInscricao = 0 THEN ' DIV_TiposInscricao : «Falso» '
                                              WHEN  DIV_TiposInscricao = 1 THEN ' DIV_TiposInscricao : «Verdadeiro» '
                                    END 
                         + '| DataUltimaBaixaDadosSiscafWeb : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaBaixaDadosSiscafWeb, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraDataPedidoInscricao IS NULL THEN ' MostraDataPedidoInscricao : «Nulo» '
                                              WHEN  MostraDataPedidoInscricao = 0 THEN ' MostraDataPedidoInscricao : «Falso» '
                                              WHEN  MostraDataPedidoInscricao = 1 THEN ' MostraDataPedidoInscricao : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoAT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRCA : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCopiaBoleto : «' + RTRIM( ISNULL( CAST (EmailCopiaBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InserirLogoNoReciboSiscafw IS NULL THEN ' InserirLogoNoReciboSiscafw : «Nulo» '
                                              WHEN  InserirLogoNoReciboSiscafw = 0 THEN ' InserirLogoNoReciboSiscafw : «Falso» '
                                              WHEN  InserirLogoNoReciboSiscafw = 1 THEN ' InserirLogoNoReciboSiscafw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarProcAtrasoDebitosDA IS NULL THEN ' UtilizarProcAtrasoDebitosDA : «Nulo» '
                                              WHEN  UtilizarProcAtrasoDebitosDA = 0 THEN ' UtilizarProcAtrasoDebitosDA : «Falso» '
                                              WHEN  UtilizarProcAtrasoDebitosDA = 1 THEN ' UtilizarProcAtrasoDebitosDA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarSelecaoUnicaTipoDef IS NULL THEN ' UtilizarSelecaoUnicaTipoDef : «Nulo» '
                                              WHEN  UtilizarSelecaoUnicaTipoDef = 0 THEN ' UtilizarSelecaoUnicaTipoDef : «Falso» '
                                              WHEN  UtilizarSelecaoUnicaTipoDef = 1 THEN ' UtilizarSelecaoUnicaTipoDef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirCadastroTipoDef IS NULL THEN ' PermitirCadastroTipoDef : «Nulo» '
                                              WHEN  PermitirCadastroTipoDef = 0 THEN ' PermitirCadastroTipoDef : «Falso» '
                                              WHEN  PermitirCadastroTipoDef = 1 THEN ' PermitirCadastroTipoDef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CfgSituacaoTpProcesso IS NULL THEN ' CfgSituacaoTpProcesso : «Nulo» '
                                              WHEN  CfgSituacaoTpProcesso = 0 THEN ' CfgSituacaoTpProcesso : «Falso» '
                                              WHEN  CfgSituacaoTpProcesso = 1 THEN ' CfgSituacaoTpProcesso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarGravarImagem IS NULL THEN ' UtilizarGravarImagem : «Nulo» '
                                              WHEN  UtilizarGravarImagem = 0 THEN ' UtilizarGravarImagem : «Falso» '
                                              WHEN  UtilizarGravarImagem = 1 THEN ' UtilizarGravarImagem : «Verdadeiro» '
                                    END 
                         + '| ServidorDigitalizacao : «' + RTRIM( ISNULL( CAST (ServidorDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaseDigitalizacao : «' + RTRIM( ISNULL( CAST (BaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioBaseDigitalizacao : «' + RTRIM( ISNULL( CAST (UsuarioBaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaBaseDigitalizacao : «' + RTRIM( ISNULL( CAST (SenhaBaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaWindows IS NULL THEN ' AutenticaWindows : «Nulo» '
                                              WHEN  AutenticaWindows = 0 THEN ' AutenticaWindows : «Falso» '
                                              WHEN  AutenticaWindows = 1 THEN ' AutenticaWindows : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoRenRCA : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoVisto : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRenVisto : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoCertReg : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoCertReg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoDebParc : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoDebParc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoATPF : «' + RTRIM( ISNULL( CAST (IdAssuntoATPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoATPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoATPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRCAPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRCAPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRCAPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRCAPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenRCAPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenRCAPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenRCAPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenRCAPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoVistoPF : «' + RTRIM( ISNULL( CAST (IdAssuntoVistoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoVistoPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoVistoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenVistoPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenVistoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenVistoPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenVistoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoCertRegPF : «' + RTRIM( ISNULL( CAST (IdAssuntoCertRegPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoCertRegPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoCertRegPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoDebParcPF : «' + RTRIM( ISNULL( CAST (IdAssuntoDebParcPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoDebParcPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoDebParcPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumRCAInicial : «' + RTRIM( ISNULL( CAST (NumRCAInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoRCA IS NULL THEN ' TipoNumeracaoRCA : «Nulo» '
                                              WHEN  TipoNumeracaoRCA = 0 THEN ' TipoNumeracaoRCA : «Falso» '
                                              WHEN  TipoNumeracaoRCA = 1 THEN ' TipoNumeracaoRCA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeraDebitoAnoInscricao IS NULL THEN ' GeraDebitoAnoInscricao : «Nulo» '
                                              WHEN  GeraDebitoAnoInscricao = 0 THEN ' GeraDebitoAnoInscricao : «Falso» '
                                              WHEN  GeraDebitoAnoInscricao = 1 THEN ' GeraDebitoAnoInscricao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeraDebitoPJPorRespTec IS NULL THEN ' GeraDebitoPJPorRespTec : «Nulo» '
                                              WHEN  GeraDebitoPJPorRespTec = 0 THEN ' GeraDebitoPJPorRespTec : «Falso» '
                                              WHEN  GeraDebitoPJPorRespTec = 1 THEN ' GeraDebitoPJPorRespTec : «Verdadeiro» '
                                    END 
                         + '| IdDebitoPJPorRespTec : «' + RTRIM( ISNULL( CAST (IdDebitoPJPorRespTec AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PriorizaTipoDebito IS NULL THEN ' PriorizaTipoDebito : «Nulo» '
                                              WHEN  PriorizaTipoDebito = 0 THEN ' PriorizaTipoDebito : «Falso» '
                                              WHEN  PriorizaTipoDebito = 1 THEN ' PriorizaTipoDebito : «Verdadeiro» '
                                    END 
                         + '| NumVistoInicial : «' + RTRIM( ISNULL( CAST (NumVistoInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoVisto IS NULL THEN ' TipoNumeracaoVisto : «Nulo» '
                                              WHEN  TipoNumeracaoVisto = 0 THEN ' TipoNumeracaoVisto : «Falso» '
                                              WHEN  TipoNumeracaoVisto = 1 THEN ' TipoNumeracaoVisto : «Verdadeiro» '
                                    END 
                         + '| AnoComSufixoRCA : «' + RTRIM( ISNULL( CAST (AnoComSufixoRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumeroRCA : «' + RTRIM( ISNULL( CAST (TamanhoNumeroRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ResetNumRCA IS NULL THEN ' ResetNumRCA : «Nulo» '
                                              WHEN  ResetNumRCA = 0 THEN ' ResetNumRCA : «Falso» '
                                              WHEN  ResetNumRCA = 1 THEN ' ResetNumRCA : «Verdadeiro» '
                                    END 
                         + '| NumAFTInicial : «' + RTRIM( ISNULL( CAST (NumAFTInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoAFT IS NULL THEN ' TipoNumeracaoAFT : «Nulo» '
                                              WHEN  TipoNumeracaoAFT = 0 THEN ' TipoNumeracaoAFT : «Falso» '
                                              WHEN  TipoNumeracaoAFT = 1 THEN ' TipoNumeracaoAFT : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoAFT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAFT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRenAFT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenAFT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoAFTPF : «' + RTRIM( ISNULL( CAST (IdAssuntoAFTPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoAFTPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoAFTPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenAFTPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenAFTPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenAFTPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenAFTPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraNumeroProcesso IS NULL THEN ' AlteraNumeroProcesso : «Nulo» '
                                              WHEN  AlteraNumeroProcesso = 0 THEN ' AlteraNumeroProcesso : «Falso» '
                                              WHEN  AlteraNumeroProcesso = 1 THEN ' AlteraNumeroProcesso : «Verdadeiro» '
                                    END 
                         + '| DirArqDNE_Correios : «' + RTRIM( ISNULL( CAST (DirArqDNE_Correios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoExibirOBSEnd IS NULL THEN ' NaoExibirOBSEnd : «Nulo» '
                                              WHEN  NaoExibirOBSEnd = 0 THEN ' NaoExibirOBSEnd : «Falso» '
                                              WHEN  NaoExibirOBSEnd = 1 THEN ' NaoExibirOBSEnd : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EditarLogradouro IS NULL THEN ' EditarLogradouro : «Nulo» '
                                              WHEN  EditarLogradouro = 0 THEN ' EditarLogradouro : «Falso» '
                                              WHEN  EditarLogradouro = 1 THEN ' EditarLogradouro : «Verdadeiro» '
                                    END 
                         + '| VersaoDNE : «' + RTRIM( ISNULL( CAST (VersaoDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DNE_Maiusculo IS NULL THEN ' DNE_Maiusculo : «Nulo» '
                                              WHEN  DNE_Maiusculo = 0 THEN ' DNE_Maiusculo : «Falso» '
                                              WHEN  DNE_Maiusculo = 1 THEN ' DNE_Maiusculo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirInfoExecucaoFiscalPF IS NULL THEN ' ExibirInfoExecucaoFiscalPF : «Nulo» '
                                              WHEN  ExibirInfoExecucaoFiscalPF = 0 THEN ' ExibirInfoExecucaoFiscalPF : «Falso» '
                                              WHEN  ExibirInfoExecucaoFiscalPF = 1 THEN ' ExibirInfoExecucaoFiscalPF : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaEmissaoSemRegistro IS NULL THEN ' UsaEmissaoSemRegistro : «Nulo» '
                                              WHEN  UsaEmissaoSemRegistro = 0 THEN ' UsaEmissaoSemRegistro : «Falso» '
                                              WHEN  UsaEmissaoSemRegistro = 1 THEN ' UsaEmissaoSemRegistro : «Verdadeiro» '
                                    END 
                         + '| Destinatario_Left : «' + RTRIM( ISNULL( CAST (Destinatario_Left AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destinatario_Top : «' + RTRIM( ISNULL( CAST (Destinatario_Top AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  HabilitarLayout3Guias IS NULL THEN ' HabilitarLayout3Guias : «Nulo» '
                                              WHEN  HabilitarLayout3Guias = 0 THEN ' HabilitarLayout3Guias : «Falso» '
                                              WHEN  HabilitarLayout3Guias = 1 THEN ' HabilitarLayout3Guias : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GerarCadaOpcDescUmaEmissao IS NULL THEN ' GerarCadaOpcDescUmaEmissao : «Nulo» '
                                              WHEN  GerarCadaOpcDescUmaEmissao = 0 THEN ' GerarCadaOpcDescUmaEmissao : «Falso» '
                                              WHEN  GerarCadaOpcDescUmaEmissao = 1 THEN ' GerarCadaOpcDescUmaEmissao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao IS NULL THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Nulo» '
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao = 0 THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Falso» '
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao = 1 THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirEndCorrespDesatualizado IS NULL THEN ' PermitirEndCorrespDesatualizado : «Nulo» '
                                              WHEN  PermitirEndCorrespDesatualizado = 0 THEN ' PermitirEndCorrespDesatualizado : «Falso» '
                                              WHEN  PermitirEndCorrespDesatualizado = 1 THEN ' PermitirEndCorrespDesatualizado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ObrigarEnderecoCorrespondencia IS NULL THEN ' ObrigarEnderecoCorrespondencia : «Nulo» '
                                              WHEN  ObrigarEnderecoCorrespondencia = 0 THEN ' ObrigarEnderecoCorrespondencia : «Falso» '
                                              WHEN  ObrigarEnderecoCorrespondencia = 1 THEN ' ObrigarEnderecoCorrespondencia : «Verdadeiro» '
                                    END 
                         + '| TempoTimeoutConexao : «' + RTRIM( ISNULL( CAST (TempoTimeoutConexao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoTimeoutConexaoMensagem : «' + RTRIM( ISNULL( CAST (TempoTimeoutConexaoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdParametrosSiscafw : «' + RTRIM( ISNULL( CAST (IdParametrosSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdFormaEntregaDocumento : «' + RTRIM( ISNULL( CAST (prec_IdFormaEntregaDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdNivelDocumento : «' + RTRIM( ISNULL( CAST (prec_IdNivelDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (prec_IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdTipoDocumento : «' + RTRIM( ISNULL( CAST (prec_IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IndOrigemDoc : «' + RTRIM( ISNULL( CAST (prec_IndOrigemDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDebitoCertidoesPF : «' + RTRIM( ISNULL( CAST (TipoDebitoCertidoesPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDebitoCertidoesPJ : «' + RTRIM( ISNULL( CAST (TipoDebitoCertidoesPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiasDataVencimento : «' + RTRIM( ISNULL( CAST (DiasDataVencimento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConselhoCorrente : «' + RTRIM( ISNULL( CAST (IdConselhoCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndContabilizacao IS NULL THEN ' IndContabilizacao : «Nulo» '
                                              WHEN  IndContabilizacao = 0 THEN ' IndContabilizacao : «Falso» '
                                              WHEN  IndContabilizacao = 1 THEN ' IndContabilizacao : «Verdadeiro» '
                                    END 
                         + '| IdBancoPadrao : «' + RTRIM( ISNULL( CAST (IdBancoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRemessa : «' + RTRIM( ISNULL( CAST (DirArqRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRetorno : «' + RTRIM( ISNULL( CAST (DirArqRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRetornoProc : «' + RTRIM( ISNULL( CAST (DirArqRetornoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirFotos : «' + RTRIM( ISNULL( CAST (DirFotos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncrementoConjunto IS NULL THEN ' IncrementoConjunto : «Nulo» '
                                              WHEN  IncrementoConjunto = 0 THEN ' IncrementoConjunto : «Falso» '
                                              WHEN  IncrementoConjunto = 1 THEN ' IncrementoConjunto : «Verdadeiro» '
                                    END 
                         + '| IndIncrementoRegistroProf : «' + RTRIM( ISNULL( CAST (IndIncrementoRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndIncrementoRegistroPJ : «' + RTRIM( ISNULL( CAST (IndIncrementoRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPre_SufNumRegistroProf : «' + RTRIM( ISNULL( CAST (IndPre_SufNumRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPre_SufNumRegistroPJ : «' + RTRIM( ISNULL( CAST (IndPre_SufNumRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumRegistroProf : «' + RTRIM( ISNULL( CAST (TamanhoNumRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumRegistroPJ : «' + RTRIM( ISNULL( CAST (TamanhoNumRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ValorMargemRecebPercentual IS NULL THEN ' ValorMargemRecebPercentual : «Nulo» '
                                              WHEN  ValorMargemRecebPercentual = 0 THEN ' ValorMargemRecebPercentual : «Falso» '
                                              WHEN  ValorMargemRecebPercentual = 1 THEN ' ValorMargemRecebPercentual : «Verdadeiro» '
                                    END 
                         + '| ValorMargemReceb : «' + RTRIM( ISNULL( CAST (ValorMargemReceb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodTratamentoRecebMenor : «' + RTRIM( ISNULL( CAST (CodTratamentoRecebMenor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodTratamentoRecebMaior : «' + RTRIM( ISNULL( CAST (CodTratamentoRecebMaior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedAtrasoPadrao : «' + RTRIM( ISNULL( CAST (IdProcedAtrasoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodPadraoRepasse : «' + RTRIM( ISNULL( CAST (CodPadraoRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLivro : «' + RTRIM( ISNULL( CAST (TipoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaseCEP IS NULL THEN ' BaseCEP : «Nulo» '
                                              WHEN  BaseCEP = 0 THEN ' BaseCEP : «Falso» '
                                              WHEN  BaseCEP = 1 THEN ' BaseCEP : «Verdadeiro» '
                                    END 
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaAltura : «' + RTRIM( ISNULL( CAST (PaginaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaLargura : «' + RTRIM( ISNULL( CAST (PaginaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaOrientacao : «' + RTRIM( ISNULL( CAST (PaginaOrientacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PzEmissaoBloqueto : «' + RTRIM( ISNULL( CAST (PzEmissaoBloqueto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndAtulizReneg IS NULL THEN ' IndAtulizReneg : «Nulo» '
                                              WHEN  IndAtulizReneg = 0 THEN ' IndAtulizReneg : «Falso» '
                                              WHEN  IndAtulizReneg = 1 THEN ' IndAtulizReneg : «Verdadeiro» '
                                    END 
                         + '| IdIndiceAtulizReneg : «' + RTRIM( ISNULL( CAST (IdIndiceAtulizReneg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemSuperior : «' + RTRIM( ISNULL( CAST (EtiquetaMargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemLateral : «' + RTRIM( ISNULL( CAST (EtiquetaMargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaVertical : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaHorizontal : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaAltura : «' + RTRIM( ISNULL( CAST (EtiquetaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaLargura : «' + RTRIM( ISNULL( CAST (EtiquetaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemPagamentoPadrao : «' + RTRIM( ISNULL( CAST (OrigemPagamentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercAcrescimoCumulativo : «' + RTRIM( ISNULL( CAST (PercAcrescimoCumulativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressaoCarne : «' + RTRIM( ISNULL( CAST (FormaImpressaoCarne AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressaoBoleto : «' + RTRIM( ISNULL( CAST (FormaImpressaoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaTamanhoPapel : «' + RTRIM( ISNULL( CAST (EtiquetaTamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura_Frame_Processos : «' + RTRIM( ISNULL( CAST (Altura_Frame_Processos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura_Frame_Processos : «' + RTRIM( ISNULL( CAST (Largura_Frame_Processos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoPadraoWEB : «' + RTRIM( ISNULL( CAST (IdBancoPadraoWEB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPadrao : «' + RTRIM( ISNULL( CAST (IdPessoaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES IS NULL THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Nulo» '
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES = 0 THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Falso» '
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES = 1 THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FazLancamentoContabil IS NULL THEN ' FazLancamentoContabil : «Nulo» '
                                              WHEN  FazLancamentoContabil = 0 THEN ' FazLancamentoContabil : «Falso» '
                                              WHEN  FazLancamentoContabil = 1 THEN ' FazLancamentoContabil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BaixarHistoricoEmissao IS NULL THEN ' BaixarHistoricoEmissao : «Nulo» '
                                              WHEN  BaixarHistoricoEmissao = 0 THEN ' BaixarHistoricoEmissao : «Falso» '
                                              WHEN  BaixarHistoricoEmissao = 1 THEN ' BaixarHistoricoEmissao : «Verdadeiro» '
                                    END 
                         + '| ReiniciaAno : «' + RTRIM( ISNULL( CAST (ReiniciaAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscAutoInc : «' + RTRIM( ISNULL( CAST (FiscAutoInc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscPrefSuf : «' + RTRIM( ISNULL( CAST (FiscPrefSuf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaCodigoBarras : «' + RTRIM( ISNULL( CAST (SequenciaCodigoBarras AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarrasSufixo : «' + RTRIM( ISNULL( CAST (CodigoBarrasSufixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarrasPrefixo : «' + RTRIM( ISNULL( CAST (CodigoBarrasPrefixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ControlarDivAtiva IS NULL THEN ' ControlarDivAtiva : «Nulo» '
                                              WHEN  ControlarDivAtiva = 0 THEN ' ControlarDivAtiva : «Falso» '
                                              WHEN  ControlarDivAtiva = 1 THEN ' ControlarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| TempoLock : «' + RTRIM( ISNULL( CONVERT (CHAR, TempoLock, 113 ),'Nulo'))+'» '
                         + '| CadastrarPessoaPor : «' + RTRIM( ISNULL( CAST (CadastrarPessoaPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| tamanhoRodape : «' + RTRIM( ISNULL( CAST (tamanhoRodape AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OcorrenciasAlterarExcluir : «' + RTRIM( ISNULL( CAST (OcorrenciasAlterarExcluir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FasesAlterarExcluir : «' + RTRIM( ISNULL( CAST (FasesAlterarExcluir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsarNumDoc IS NULL THEN ' UsarNumDoc : «Nulo» '
                                              WHEN  UsarNumDoc = 0 THEN ' UsarNumDoc : «Falso» '
                                              WHEN  UsarNumDoc = 1 THEN ' UsarNumDoc : «Verdadeiro» '
                                    END 
                         + '| IdModeloDoc : «' + RTRIM( ISNULL( CAST (IdModeloDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CancelarDivAtiva IS NULL THEN ' CancelarDivAtiva : «Nulo» '
                                              WHEN  CancelarDivAtiva = 0 THEN ' CancelarDivAtiva : «Falso» '
                                              WHEN  CancelarDivAtiva = 1 THEN ' CancelarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociarDivAtiva IS NULL THEN ' RenegociarDivAtiva : «Nulo» '
                                              WHEN  RenegociarDivAtiva = 0 THEN ' RenegociarDivAtiva : «Falso» '
                                              WHEN  RenegociarDivAtiva = 1 THEN ' RenegociarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| ControleDividaAtiva : «' + RTRIM( ISNULL( CAST (ControleDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUltimoLivro : «' + RTRIM( ISNULL( CAST (IdUltimoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idCategoriaProf : «' + RTRIM( ISNULL( CAST (idCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesDataEntrada : «' + RTRIM( ISNULL( CAST (TramitacoesDataEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| campoCabecalhoFisc : «' + RTRIM( ISNULL( CAST (campoCabecalhoFisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico1 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico2 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico3 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesCaptionAbaDinamica : «' + RTRIM( ISNULL( CAST (FiscalizacoesCaptionAbaDinamica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoCaptionAbaDinamicaFisc : «' + RTRIM( ISNULL( CAST (FiscalizacaoCaptionAbaDinamicaFisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico1 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico2 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico3 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoCaptionAbaDinamica : «' + RTRIM( ISNULL( CAST (FiscalizacaoCaptionAbaDinamica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAnoCorrenteVerifAdimplente IS NULL THEN ' UsaAnoCorrenteVerifAdimplente : «Nulo» '
                                              WHEN  UsaAnoCorrenteVerifAdimplente = 0 THEN ' UsaAnoCorrenteVerifAdimplente : «Falso» '
                                              WHEN  UsaAnoCorrenteVerifAdimplente = 1 THEN ' UsaAnoCorrenteVerifAdimplente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IgnorarZerosEsq_Registro IS NULL THEN ' IgnorarZerosEsq_Registro : «Nulo» '
                                              WHEN  IgnorarZerosEsq_Registro = 0 THEN ' IgnorarZerosEsq_Registro : «Falso» '
                                              WHEN  IgnorarZerosEsq_Registro = 1 THEN ' IgnorarZerosEsq_Registro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RegistraDtCredito IS NULL THEN ' RegistraDtCredito : «Nulo» '
                                              WHEN  RegistraDtCredito = 0 THEN ' RegistraDtCredito : «Falso» '
                                              WHEN  RegistraDtCredito = 1 THEN ' RegistraDtCredito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CriaProcessoInscricao IS NULL THEN ' CriaProcessoInscricao : «Nulo» '
                                              WHEN  CriaProcessoInscricao = 0 THEN ' CriaProcessoInscricao : «Falso» '
                                              WHEN  CriaProcessoInscricao = 1 THEN ' CriaProcessoInscricao : «Verdadeiro» '
                                    END 
                         + '| IdMoedaPadrao : «' + RTRIM( ISNULL( CAST (IdMoedaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CadPFMostraEnderecoDivulgacao IS NULL THEN ' CadPFMostraEnderecoDivulgacao : «Nulo» '
                                              WHEN  CadPFMostraEnderecoDivulgacao = 0 THEN ' CadPFMostraEnderecoDivulgacao : «Falso» '
                                              WHEN  CadPFMostraEnderecoDivulgacao = 1 THEN ' CadPFMostraEnderecoDivulgacao : «Verdadeiro» '
                                    END 
                         + '| TipoProcPagamentoBB : «' + RTRIM( ISNULL( CAST (TipoProcPagamentoBB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcInscricao : «' + RTRIM( ISNULL( CAST (NumeroProcInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraAutomaticoArquivoIndividual IS NULL THEN ' GeraAutomaticoArquivoIndividual : «Nulo» '
                                              WHEN  GeraAutomaticoArquivoIndividual = 0 THEN ' GeraAutomaticoArquivoIndividual : «Falso» '
                                              WHEN  GeraAutomaticoArquivoIndividual = 1 THEN ' GeraAutomaticoArquivoIndividual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlterarDataInscricaoConselho IS NULL THEN ' AlterarDataInscricaoConselho : «Nulo» '
                                              WHEN  AlterarDataInscricaoConselho = 0 THEN ' AlterarDataInscricaoConselho : «Falso» '
                                              WHEN  AlterarDataInscricaoConselho = 1 THEN ' AlterarDataInscricaoConselho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VerifNossoNumDuplicDetEmiss IS NULL THEN ' VerifNossoNumDuplicDetEmiss : «Nulo» '
                                              WHEN  VerifNossoNumDuplicDetEmiss = 0 THEN ' VerifNossoNumDuplicDetEmiss : «Falso» '
                                              WHEN  VerifNossoNumDuplicDetEmiss = 1 THEN ' VerifNossoNumDuplicDetEmiss : «Verdadeiro» '
                                    END 
                         + '| IdProfissionalPresidente : «' + RTRIM( ISNULL( CAST (IdProfissionalPresidente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalVice : «' + RTRIM( ISNULL( CAST (IdProfissionalVice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModeloEntregaCarteirinha : «' + RTRIM( ISNULL( CAST (IdModeloEntregaCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AssociarCidadeSubRegiao IS NULL THEN ' AssociarCidadeSubRegiao : «Nulo» '
                                              WHEN  AssociarCidadeSubRegiao = 0 THEN ' AssociarCidadeSubRegiao : «Falso» '
                                              WHEN  AssociarCidadeSubRegiao = 1 THEN ' AssociarCidadeSubRegiao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaDataTermino IS NULL THEN ' ControlaDataTermino : «Nulo» '
                                              WHEN  ControlaDataTermino = 0 THEN ' ControlaDataTermino : «Falso» '
                                              WHEN  ControlaDataTermino = 1 THEN ' ControlaDataTermino : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaDebitoConta IS NULL THEN ' UtilizaDebitoConta : «Nulo» '
                                              WHEN  UtilizaDebitoConta = 0 THEN ' UtilizaDebitoConta : «Falso» '
                                              WHEN  UtilizaDebitoConta = 1 THEN ' UtilizaDebitoConta : «Verdadeiro» '
                                    END 
                         + '| SequencialNossoNumeroDebConta : «' + RTRIM( ISNULL( CAST (SequencialNossoNumeroDebConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosicaoDivida : «' + RTRIM( ISNULL( CAST (PosicaoDivida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquetoComDesconto_Individual IS NULL THEN ' BloquetoComDesconto_Individual : «Nulo» '
                                              WHEN  BloquetoComDesconto_Individual = 0 THEN ' BloquetoComDesconto_Individual : «Falso» '
                                              WHEN  BloquetoComDesconto_Individual = 1 THEN ' BloquetoComDesconto_Individual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SugerirDataPgto IS NULL THEN ' SugerirDataPgto : «Nulo» '
                                              WHEN  SugerirDataPgto = 0 THEN ' SugerirDataPgto : «Falso» '
                                              WHEN  SugerirDataPgto = 1 THEN ' SugerirDataPgto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpedirDataPgtoFutura IS NULL THEN ' ImpedirDataPgtoFutura : «Nulo» '
                                              WHEN  ImpedirDataPgtoFutura = 0 THEN ' ImpedirDataPgtoFutura : «Falso» '
                                              WHEN  ImpedirDataPgtoFutura = 1 THEN ' ImpedirDataPgtoFutura : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociacaoViaCertidao IS NULL THEN ' RenegociacaoViaCertidao : «Nulo» '
                                              WHEN  RenegociacaoViaCertidao = 0 THEN ' RenegociacaoViaCertidao : «Falso» '
                                              WHEN  RenegociacaoViaCertidao = 1 THEN ' RenegociacaoViaCertidao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SugerirDataReferencia IS NULL THEN ' SugerirDataReferencia : «Nulo» '
                                              WHEN  SugerirDataReferencia = 0 THEN ' SugerirDataReferencia : «Falso» '
                                              WHEN  SugerirDataReferencia = 1 THEN ' SugerirDataReferencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IncrementarCF IS NULL THEN ' IncrementarCF : «Nulo» '
                                              WHEN  IncrementarCF = 0 THEN ' IncrementarCF : «Falso» '
                                              WHEN  IncrementarCF = 1 THEN ' IncrementarCF : «Verdadeiro» '
                                    END 
                         + '| SequencialCodigoFiscalizador : «' + RTRIM( ISNULL( CAST (SequencialCodigoFiscalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraNumeroProcessoPessoas IS NULL THEN ' GeraNumeroProcessoPessoas : «Nulo» '
                                              WHEN  GeraNumeroProcessoPessoas = 0 THEN ' GeraNumeroProcessoPessoas : «Falso» '
                                              WHEN  GeraNumeroProcessoPessoas = 1 THEN ' GeraNumeroProcessoPessoas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaNunProcessoBloqueto IS NULL THEN ' UtilizaNunProcessoBloqueto : «Nulo» '
                                              WHEN  UtilizaNunProcessoBloqueto = 0 THEN ' UtilizaNunProcessoBloqueto : «Falso» '
                                              WHEN  UtilizaNunProcessoBloqueto = 1 THEN ' UtilizaNunProcessoBloqueto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MudancaClassesAtiva IS NULL THEN ' MudancaClassesAtiva : «Nulo» '
                                              WHEN  MudancaClassesAtiva = 0 THEN ' MudancaClassesAtiva : «Falso» '
                                              WHEN  MudancaClassesAtiva = 1 THEN ' MudancaClassesAtiva : «Verdadeiro» '
                                    END 
                         + '| DiaMesMudancaClasses : «' + RTRIM( ISNULL( CAST (DiaMesMudancaClasses AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximoAnoMudancaClasses : «' + RTRIM( ISNULL( CAST (ProximoAnoMudancaClasses AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bNumerarRen IS NULL THEN ' bNumerarRen : «Nulo» '
                                              WHEN  bNumerarRen = 0 THEN ' bNumerarRen : «Falso» '
                                              WHEN  bNumerarRen = 1 THEN ' bNumerarRen : «Verdadeiro» '
                                    END 
                         + '| NumeroRenegociacao : «' + RTRIM( ISNULL( CAST (NumeroRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcEnviar : «' + RTRIM( ISNULL( CAST (TramitacoesProcEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcReceber : «' + RTRIM( ISNULL( CAST (TramitacoesProcReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcAlterar : «' + RTRIM( ISNULL( CAST (TramitacoesProcAlterar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TramitacoesProcFiltraRespLocal IS NULL THEN ' TramitacoesProcFiltraRespLocal : «Nulo» '
                                              WHEN  TramitacoesProcFiltraRespLocal = 0 THEN ' TramitacoesProcFiltraRespLocal : «Falso» '
                                              WHEN  TramitacoesProcFiltraRespLocal = 1 THEN ' TramitacoesProcFiltraRespLocal : «Verdadeiro» '
                                    END 
                         + '| TramitacoesProcAlterarExt : «' + RTRIM( ISNULL( CAST (TramitacoesProcAlterarExt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrioridadePadrao : «' + RTRIM( ISNULL( CAST (PrioridadePadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoPadrao : «' + RTRIM( ISNULL( CAST (SituacaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialProcesso : «' + RTRIM( ISNULL( CAST (SequencialProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoProcesso : «' + RTRIM( ISNULL( CAST (AnoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumeracaoUnicaProcesso IS NULL THEN ' NumeracaoUnicaProcesso : «Nulo» '
                                              WHEN  NumeracaoUnicaProcesso = 0 THEN ' NumeracaoUnicaProcesso : «Falso» '
                                              WHEN  NumeracaoUnicaProcesso = 1 THEN ' NumeracaoUnicaProcesso : «Verdadeiro» '
                                    END 
                         + '| IdCategoriaPadrao : «' + RTRIM( ISNULL( CAST (IdCategoriaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricaoPadrao : «' + RTRIM( ISNULL( CAST (IdTipoInscricaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoInscricaoPadrao : «' + RTRIM( ISNULL( CAST (IdMotivoInscricaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarUsuarioPadrao IS NULL THEN ' UtilizarUsuarioPadrao : «Nulo» '
                                              WHEN  UtilizarUsuarioPadrao = 0 THEN ' UtilizarUsuarioPadrao : «Falso» '
                                              WHEN  UtilizarUsuarioPadrao = 1 THEN ' UtilizarUsuarioPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaPesquisaGenerica IS NULL THEN ' UtilizaPesquisaGenerica : «Nulo» '
                                              WHEN  UtilizaPesquisaGenerica = 0 THEN ' UtilizaPesquisaGenerica : «Falso» '
                                              WHEN  UtilizaPesquisaGenerica = 1 THEN ' UtilizaPesquisaGenerica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LiberaEnvioTramitacao IS NULL THEN ' LiberaEnvioTramitacao : «Nulo» '
                                              WHEN  LiberaEnvioTramitacao = 0 THEN ' LiberaEnvioTramitacao : «Falso» '
                                              WHEN  LiberaEnvioTramitacao = 1 THEN ' LiberaEnvioTramitacao : «Verdadeiro» '
                                    END 
                         + '| SequencialNumeroCarteira : «' + RTRIM( ISNULL( CAST (SequencialNumeroCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ResumoDebitoVinculado IS NULL THEN ' ResumoDebitoVinculado : «Nulo» '
                                              WHEN  ResumoDebitoVinculado = 0 THEN ' ResumoDebitoVinculado : «Falso» '
                                              WHEN  ResumoDebitoVinculado = 1 THEN ' ResumoDebitoVinculado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaSequencialNumeroCarteira IS NULL THEN ' UtilizaSequencialNumeroCarteira : «Nulo» '
                                              WHEN  UtilizaSequencialNumeroCarteira = 0 THEN ' UtilizaSequencialNumeroCarteira : «Falso» '
                                              WHEN  UtilizaSequencialNumeroCarteira = 1 THEN ' UtilizaSequencialNumeroCarteira : «Verdadeiro» '
                                    END 
                         + '| MargemSupBoleto : «' + RTRIM( ISNULL( CAST (MargemSupBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDirBoleto : «' + RTRIM( ISNULL( CAST (MargemDirBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInfBoleto : «' + RTRIM( ISNULL( CAST (MargemInfBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsqBoleto : «' + RTRIM( ISNULL( CAST (MargemEsqBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CriticaCPFArquivoRemessa IS NULL THEN ' CriticaCPFArquivoRemessa : «Nulo» '
                                              WHEN  CriticaCPFArquivoRemessa = 0 THEN ' CriticaCPFArquivoRemessa : «Falso» '
                                              WHEN  CriticaCPFArquivoRemessa = 1 THEN ' CriticaCPFArquivoRemessa : «Verdadeiro» '
                                    END 
                         + '| SequencialSeuNumero : «' + RTRIM( ISNULL( CAST (SequencialSeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoEmailSuspensao : «' + RTRIM( ISNULL( CAST (AssuntoEmailSuspensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoEmailLevantamentoSuspensao : «' + RTRIM( ISNULL( CAST (AssuntoEmailLevantamentoSuspensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioEmailSuspensao IS NULL THEN ' EnvioEmailSuspensao : «Nulo» '
                                              WHEN  EnvioEmailSuspensao = 0 THEN ' EnvioEmailSuspensao : «Falso» '
                                              WHEN  EnvioEmailSuspensao = 1 THEN ' EnvioEmailSuspensao : «Verdadeiro» '
                                    END 
                         + '| IndPrioridadeBaixaPgto : «' + RTRIM( ISNULL( CAST (IndPrioridadeBaixaPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailProcesso : «' + RTRIM( ISNULL( CAST (UsuarioEmailProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaUsuarioEmailProcesso : «' + RTRIM( ISNULL( CAST (SenhaUsuarioEmailProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LogAtivado IS NULL THEN ' LogAtivado : «Nulo» '
                                              WHEN  LogAtivado = 0 THEN ' LogAtivado : «Falso» '
                                              WHEN  LogAtivado = 1 THEN ' LogAtivado : «Verdadeiro» '
                                    END 
                         + '| Assinatura1 : «' + RTRIM( ISNULL( CAST (Assinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura2 : «' + RTRIM( ISNULL( CAST (Assinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo1 : «' + RTRIM( ISNULL( CAST (Cargo1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo2 : «' + RTRIM( ISNULL( CAST (Cargo2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasServidor : «' + RTRIM( ISNULL( CAST (EmailCartirasServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCarteirasPorta : «' + RTRIM( ISNULL( CAST (EmailCarteirasPorta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasUsuario : «' + RTRIM( ISNULL( CAST (EmailCartirasUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasSenha : «' + RTRIM( ISNULL( CAST (EmailCartirasSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasAssunto : «' + RTRIM( ISNULL( CAST (EmailCartirasAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OcorrenciaCartirasImpressao IS NULL THEN ' OcorrenciaCartirasImpressao : «Nulo» '
                                              WHEN  OcorrenciaCartirasImpressao = 0 THEN ' OcorrenciaCartirasImpressao : «Falso» '
                                              WHEN  OcorrenciaCartirasImpressao = 1 THEN ' OcorrenciaCartirasImpressao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OcorrenciaCartirasEmail IS NULL THEN ' OcorrenciaCartirasEmail : «Nulo» '
                                              WHEN  OcorrenciaCartirasEmail = 0 THEN ' OcorrenciaCartirasEmail : «Falso» '
                                              WHEN  OcorrenciaCartirasEmail = 1 THEN ' OcorrenciaCartirasEmail : «Verdadeiro» '
                                    END 
                         + '| OcorrenciaCartirasTexto : «' + RTRIM( ISNULL( CAST (OcorrenciaCartirasTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OcorrenciaCartirasDetalhes : «' + RTRIM( ISNULL( CAST (OcorrenciaCartirasDetalhes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UtilizaAgendaContatos : «' + RTRIM( ISNULL( CAST (UtilizaAgendaContatos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EditarCEP IS NULL THEN ' EditarCEP : «Nulo» '
                                              WHEN  EditarCEP = 0 THEN ' EditarCEP : «Falso» '
                                              WHEN  EditarCEP = 1 THEN ' EditarCEP : «Verdadeiro» '
                                    END 
                         + '| LocalizarProfPJ : «' + RTRIM( ISNULL( CAST (LocalizarProfPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqApreciacao : «' + RTRIM( ISNULL( CAST (DirArqApreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqResolucao : «' + RTRIM( ISNULL( CAST (DirArqResolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirModeloResolucao : «' + RTRIM( ISNULL( CAST (DirModeloResolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GerarSubDiretorioPorBanco IS NULL THEN ' GerarSubDiretorioPorBanco : «Nulo» '
                                              WHEN  GerarSubDiretorioPorBanco = 0 THEN ' GerarSubDiretorioPorBanco : «Falso» '
                                              WHEN  GerarSubDiretorioPorBanco = 1 THEN ' GerarSubDiretorioPorBanco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirAdimplenciaEmVotacao IS NULL THEN ' ExibirAdimplenciaEmVotacao : «Nulo» '
                                              WHEN  ExibirAdimplenciaEmVotacao = 0 THEN ' ExibirAdimplenciaEmVotacao : «Falso» '
                                              WHEN  ExibirAdimplenciaEmVotacao = 1 THEN ' ExibirAdimplenciaEmVotacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReiniciaAnoProc IS NULL THEN ' ReiniciaAnoProc : «Nulo» '
                                              WHEN  ReiniciaAnoProc = 0 THEN ' ReiniciaAnoProc : «Falso» '
                                              WHEN  ReiniciaAnoProc = 1 THEN ' ReiniciaAnoProc : «Verdadeiro» '
                                    END 
                         + '| DtVencAnuConsiderarInadimpl : «' + RTRIM( ISNULL( CAST (DtVencAnuConsiderarInadimpl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarAcrescimoRecobranca IS NULL THEN ' UtilizarAcrescimoRecobranca : «Nulo» '
                                              WHEN  UtilizarAcrescimoRecobranca = 0 THEN ' UtilizarAcrescimoRecobranca : «Falso» '
                                              WHEN  UtilizarAcrescimoRecobranca = 1 THEN ' UtilizarAcrescimoRecobranca : «Verdadeiro» '
                                    END 
                         + '| DataAlterarValorDA : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlterarValorDA, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AceitarPgtoCanceladoArquivoRet IS NULL THEN ' AceitarPgtoCanceladoArquivoRet : «Nulo» '
                                              WHEN  AceitarPgtoCanceladoArquivoRet = 0 THEN ' AceitarPgtoCanceladoArquivoRet : «Falso» '
                                              WHEN  AceitarPgtoCanceladoArquivoRet = 1 THEN ' AceitarPgtoCanceladoArquivoRet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitarPgtoPagoArquivoRet IS NULL THEN ' AceitarPgtoPagoArquivoRet : «Nulo» '
                                              WHEN  AceitarPgtoPagoArquivoRet = 0 THEN ' AceitarPgtoPagoArquivoRet : «Falso» '
                                              WHEN  AceitarPgtoPagoArquivoRet = 1 THEN ' AceitarPgtoPagoArquivoRet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaoBaixarPagoMaior IS NULL THEN ' NaoBaixarPagoMaior : «Nulo» '
                                              WHEN  NaoBaixarPagoMaior = 0 THEN ' NaoBaixarPagoMaior : «Falso» '
                                              WHEN  NaoBaixarPagoMaior = 1 THEN ' NaoBaixarPagoMaior : «Verdadeiro» '
                                    END 
                         + '| ValorMargemPagoMaior : «' + RTRIM( ISNULL( CAST (ValorMargemPagoMaior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqThemis : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqThemis, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqAdvatu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqAdvatu, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqTJ : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqTJ, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FlagScriptSituacaoPFPJ IS NULL THEN ' FlagScriptSituacaoPFPJ : «Nulo» '
                                              WHEN  FlagScriptSituacaoPFPJ = 0 THEN ' FlagScriptSituacaoPFPJ : «Falso» '
                                              WHEN  FlagScriptSituacaoPFPJ = 1 THEN ' FlagScriptSituacaoPFPJ : «Verdadeiro» '
                                    END 
                         + '| FiscTamanhoSequencial : «' + RTRIM( ISNULL( CAST (FiscTamanhoSequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscSigla : «' + RTRIM( ISNULL( CAST (FiscSigla AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FlagScriptSituacaoPFPJ2 IS NULL THEN ' FlagScriptSituacaoPFPJ2 : «Nulo» '
                                              WHEN  FlagScriptSituacaoPFPJ2 = 0 THEN ' FlagScriptSituacaoPFPJ2 : «Falso» '
                                              WHEN  FlagScriptSituacaoPFPJ2 = 1 THEN ' FlagScriptSituacaoPFPJ2 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitaDataFutura IS NULL THEN ' AceitaDataFutura : «Nulo» '
                                              WHEN  AceitaDataFutura = 0 THEN ' AceitaDataFutura : «Falso» '
                                              WHEN  AceitaDataFutura = 1 THEN ' AceitaDataFutura : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IgnoraVlrPgSitDeb IS NULL THEN ' IgnoraVlrPgSitDeb : «Nulo» '
                                              WHEN  IgnoraVlrPgSitDeb = 0 THEN ' IgnoraVlrPgSitDeb : «Falso» '
                                              WHEN  IgnoraVlrPgSitDeb = 1 THEN ' IgnoraVlrPgSitDeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailCarteirasAutenticaSSL IS NULL THEN ' EmailCarteirasAutenticaSSL : «Nulo» '
                                              WHEN  EmailCarteirasAutenticaSSL = 0 THEN ' EmailCarteirasAutenticaSSL : «Falso» '
                                              WHEN  EmailCarteirasAutenticaSSL = 1 THEN ' EmailCarteirasAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearEdicaoSubRegiao IS NULL THEN ' BloquearEdicaoSubRegiao : «Nulo» '
                                              WHEN  BloquearEdicaoSubRegiao = 0 THEN ' BloquearEdicaoSubRegiao : «Falso» '
                                              WHEN  BloquearEdicaoSubRegiao = 1 THEN ' BloquearEdicaoSubRegiao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| FltrDebAnoInicial : «' + RTRIM( ISNULL( CAST (FltrDebAnoInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebAnoFinal : «' + RTRIM( ISNULL( CAST (FltrDebAnoFinal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebVencInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, FltrDebVencInicial, 113 ),'Nulo'))+'» '
                         + '| FltrDebVencFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, FltrDebVencFinal, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FltrDebNExibirRenCanc IS NULL THEN ' FltrDebNExibirRenCanc : «Nulo» '
                                              WHEN  FltrDebNExibirRenCanc = 0 THEN ' FltrDebNExibirRenCanc : «Falso» '
                                              WHEN  FltrDebNExibirRenCanc = 1 THEN ' FltrDebNExibirRenCanc : «Verdadeiro» '
                                    END 
                         + '| FltrDebTipoDeb : «' + RTRIM( ISNULL( CAST (FltrDebTipoDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebSituacaoDeb : «' + RTRIM( ISNULL( CAST (FltrDebSituacaoDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebMotivoCanc : «' + RTRIM( ISNULL( CAST (FltrDebMotivoCanc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndUtilizaMsgDtPrevisaoProc IS NULL THEN ' IndUtilizaMsgDtPrevisaoProc : «Nulo» '
                                              WHEN  IndUtilizaMsgDtPrevisaoProc = 0 THEN ' IndUtilizaMsgDtPrevisaoProc : «Falso» '
                                              WHEN  IndUtilizaMsgDtPrevisaoProc = 1 THEN ' IndUtilizaMsgDtPrevisaoProc : «Verdadeiro» '
                                    END 
                         + '| TipoExibicaoMsgDtPrevicaoProc : «' + RTRIM( ISNULL( CAST (TipoExibicaoMsgDtPrevicaoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitirAcesProcInterno IS NULL THEN ' PermitirAcesProcInterno : «Nulo» '
                                              WHEN  PermitirAcesProcInterno = 0 THEN ' PermitirAcesProcInterno : «Falso» '
                                              WHEN  PermitirAcesProcInterno = 1 THEN ' PermitirAcesProcInterno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirAcesFiscInterno IS NULL THEN ' PermitirAcesFiscInterno : «Nulo» '
                                              WHEN  PermitirAcesFiscInterno = 0 THEN ' PermitirAcesFiscInterno : «Falso» '
                                              WHEN  PermitirAcesFiscInterno = 1 THEN ' PermitirAcesFiscInterno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarIntegracao IS NULL THEN ' UtilizarIntegracao : «Nulo» '
                                              WHEN  UtilizarIntegracao = 0 THEN ' UtilizarIntegracao : «Falso» '
                                              WHEN  UtilizarIntegracao = 1 THEN ' UtilizarIntegracao : «Verdadeiro» '
                                    END 
                         + '| IntegracaoProvider : «' + RTRIM( ISNULL( CAST (IntegracaoProvider AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoServidor : «' + RTRIM( ISNULL( CAST (IntegracaoServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoBancoDados : «' + RTRIM( ISNULL( CAST (IntegracaoBancoDados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoSchema : «' + RTRIM( ISNULL( CAST (IntegracaoSchema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoUsuario : «' + RTRIM( ISNULL( CAST (IntegracaoUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoSenha : «' + RTRIM( ISNULL( CAST (IntegracaoSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarCampoObr IS NULL THEN ' AplicarCampoObr : «Nulo» '
                                              WHEN  AplicarCampoObr = 0 THEN ' AplicarCampoObr : «Falso» '
                                              WHEN  AplicarCampoObr = 1 THEN ' AplicarCampoObr : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarAssistenteCadastro IS NULL THEN ' UtilizarAssistenteCadastro : «Nulo» '
                                              WHEN  UtilizarAssistenteCadastro = 0 THEN ' UtilizarAssistenteCadastro : «Falso» '
                                              WHEN  UtilizarAssistenteCadastro = 1 THEN ' UtilizarAssistenteCadastro : «Verdadeiro» '
                                    END 
                         + '| DirRel : «' + RTRIM( ISNULL( CAST (DirRel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaControleDigitalizacoes IS NULL THEN ' UtilizaControleDigitalizacoes : «Nulo» '
                                              WHEN  UtilizaControleDigitalizacoes = 0 THEN ' UtilizaControleDigitalizacoes : «Falso» '
                                              WHEN  UtilizaControleDigitalizacoes = 1 THEN ' UtilizaControleDigitalizacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirVinculoProcTipoDif IS NULL THEN ' PermitirVinculoProcTipoDif : «Nulo» '
                                              WHEN  PermitirVinculoProcTipoDif = 0 THEN ' PermitirVinculoProcTipoDif : «Falso» '
                                              WHEN  PermitirVinculoProcTipoDif = 1 THEN ' PermitirVinculoProcTipoDif : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitacaoDataPrevObrig IS NULL THEN ' TramitacaoDataPrevObrig : «Nulo» '
                                              WHEN  TramitacaoDataPrevObrig = 0 THEN ' TramitacaoDataPrevObrig : «Falso» '
                                              WHEN  TramitacaoDataPrevObrig = 1 THEN ' TramitacaoDataPrevObrig : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitPermitirDesativarAviso IS NULL THEN ' TramitPermitirDesativarAviso : «Nulo» '
                                              WHEN  TramitPermitirDesativarAviso = 0 THEN ' TramitPermitirDesativarAviso : «Falso» '
                                              WHEN  TramitPermitirDesativarAviso = 1 THEN ' TramitPermitirDesativarAviso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAlteracaoTramitacao IS NULL THEN ' BloquearAlteracaoTramitacao : «Nulo» '
                                              WHEN  BloquearAlteracaoTramitacao = 0 THEN ' BloquearAlteracaoTramitacao : «Falso» '
                                              WHEN  BloquearAlteracaoTramitacao = 1 THEN ' BloquearAlteracaoTramitacao : «Verdadeiro» '
                                    END 
                         + '| DuplicidadeNR : «' + RTRIM( ISNULL( CAST (DuplicidadeNR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComputadorMalaDireta : «' + RTRIM( ISNULL( CAST (ComputadorMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaPeticaoCDA IS NULL THEN ' AgrupaPeticaoCDA : «Nulo» '
                                              WHEN  AgrupaPeticaoCDA = 0 THEN ' AgrupaPeticaoCDA : «Falso» '
                                              WHEN  AgrupaPeticaoCDA = 1 THEN ' AgrupaPeticaoCDA : «Verdadeiro» '
                                    END 
                         + '| EmailEnvioErros : «' + RTRIM( ISNULL( CAST (EmailEnvioErros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalDividaAtivaAtualizada : «' + RTRIM( ISNULL( CAST (TotalDividaAtivaAtualizada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigRelatorioFixoXML : «' + RTRIM( ISNULL( CAST (ConfigRelatorioFixoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirAlertaPendBaixa IS NULL THEN ' ExibirAlertaPendBaixa : «Nulo» '
                                              WHEN  ExibirAlertaPendBaixa = 0 THEN ' ExibirAlertaPendBaixa : «Falso» '
                                              WHEN  ExibirAlertaPendBaixa = 1 THEN ' ExibirAlertaPendBaixa : «Verdadeiro» '
                                    END 
                         + '| ExibirAlertaPendBaixaAPartirDe : «' + RTRIM( ISNULL( CONVERT (CHAR, ExibirAlertaPendBaixaAPartirDe, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConcatenarLocalTrabalho IS NULL THEN ' ConcatenarLocalTrabalho : «Nulo» '
                                              WHEN  ConcatenarLocalTrabalho = 0 THEN ' ConcatenarLocalTrabalho : «Falso» '
                                              WHEN  ConcatenarLocalTrabalho = 1 THEN ' ConcatenarLocalTrabalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NrInfObrigatorio IS NULL THEN ' NrInfObrigatorio : «Nulo» '
                                              WHEN  NrInfObrigatorio = 0 THEN ' NrInfObrigatorio : «Falso» '
                                              WHEN  NrInfObrigatorio = 1 THEN ' NrInfObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NrInfRecebeNrModeloAutoInf IS NULL THEN ' NrInfRecebeNrModeloAutoInf : «Nulo» '
                                              WHEN  NrInfRecebeNrModeloAutoInf = 0 THEN ' NrInfRecebeNrModeloAutoInf : «Falso» '
                                              WHEN  NrInfRecebeNrModeloAutoInf = 1 THEN ' NrInfRecebeNrModeloAutoInf : «Verdadeiro» '
                                    END 
                         + '| DataVerificacaoREN : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVerificacaoREN, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FormaImpressao IS NULL THEN ' FormaImpressao : «Nulo» '
                                              WHEN  FormaImpressao = 0 THEN ' FormaImpressao : «Falso» '
                                              WHEN  FormaImpressao = 1 THEN ' FormaImpressao : «Verdadeiro» '
                                    END 
                         + '| idPadraoEtapaProcInscricaoPF : «' + RTRIM( ISNULL( CAST (idPadraoEtapaProcInscricaoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idPadraoEtapaProcInscricaoPJ : «' + RTRIM( ISNULL( CAST (idPadraoEtapaProcInscricaoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TxtPreviaAcordoRen : «' + RTRIM( ISNULL( CAST (TxtPreviaAcordoRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebitoHonorariosAdv : «' + RTRIM( ISNULL( CAST (IdTipoDebitoHonorariosAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeVersoBoleto IS NULL THEN ' ImprimeVersoBoleto : «Nulo» '
                                              WHEN  ImprimeVersoBoleto = 0 THEN ' ImprimeVersoBoleto : «Falso» '
                                              WHEN  ImprimeVersoBoleto = 1 THEN ' ImprimeVersoBoleto : «Verdadeiro» '
                                    END 
                         + '| IdTipoDebitoFS : «' + RTRIM( ISNULL( CAST (IdTipoDebitoFS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal IS NULL THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Nulo» '
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal = 0 THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Falso» '
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal = 1 THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNARemoverZeros IS NULL THEN ' CNARemoverZeros : «Nulo» '
                                              WHEN  CNARemoverZeros = 0 THEN ' CNARemoverZeros : «Falso» '
                                              WHEN  CNARemoverZeros = 1 THEN ' CNARemoverZeros : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NotCPFDuplicado IS NULL THEN ' NotCPFDuplicado : «Nulo» '
                                              WHEN  NotCPFDuplicado = 0 THEN ' NotCPFDuplicado : «Falso» '
                                              WHEN  NotCPFDuplicado = 1 THEN ' NotCPFDuplicado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DIV_SituacoesPFPJ IS NULL THEN ' DIV_SituacoesPFPJ : «Nulo» '
                                              WHEN  DIV_SituacoesPFPJ = 0 THEN ' DIV_SituacoesPFPJ : «Falso» '
                                              WHEN  DIV_SituacoesPFPJ = 1 THEN ' DIV_SituacoesPFPJ : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DIV_TiposInscricao IS NULL THEN ' DIV_TiposInscricao : «Nulo» '
                                              WHEN  DIV_TiposInscricao = 0 THEN ' DIV_TiposInscricao : «Falso» '
                                              WHEN  DIV_TiposInscricao = 1 THEN ' DIV_TiposInscricao : «Verdadeiro» '
                                    END 
                         + '| DataUltimaBaixaDadosSiscafWeb : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaBaixaDadosSiscafWeb, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraDataPedidoInscricao IS NULL THEN ' MostraDataPedidoInscricao : «Nulo» '
                                              WHEN  MostraDataPedidoInscricao = 0 THEN ' MostraDataPedidoInscricao : «Falso» '
                                              WHEN  MostraDataPedidoInscricao = 1 THEN ' MostraDataPedidoInscricao : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoAT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRCA : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCopiaBoleto : «' + RTRIM( ISNULL( CAST (EmailCopiaBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InserirLogoNoReciboSiscafw IS NULL THEN ' InserirLogoNoReciboSiscafw : «Nulo» '
                                              WHEN  InserirLogoNoReciboSiscafw = 0 THEN ' InserirLogoNoReciboSiscafw : «Falso» '
                                              WHEN  InserirLogoNoReciboSiscafw = 1 THEN ' InserirLogoNoReciboSiscafw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarProcAtrasoDebitosDA IS NULL THEN ' UtilizarProcAtrasoDebitosDA : «Nulo» '
                                              WHEN  UtilizarProcAtrasoDebitosDA = 0 THEN ' UtilizarProcAtrasoDebitosDA : «Falso» '
                                              WHEN  UtilizarProcAtrasoDebitosDA = 1 THEN ' UtilizarProcAtrasoDebitosDA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarSelecaoUnicaTipoDef IS NULL THEN ' UtilizarSelecaoUnicaTipoDef : «Nulo» '
                                              WHEN  UtilizarSelecaoUnicaTipoDef = 0 THEN ' UtilizarSelecaoUnicaTipoDef : «Falso» '
                                              WHEN  UtilizarSelecaoUnicaTipoDef = 1 THEN ' UtilizarSelecaoUnicaTipoDef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirCadastroTipoDef IS NULL THEN ' PermitirCadastroTipoDef : «Nulo» '
                                              WHEN  PermitirCadastroTipoDef = 0 THEN ' PermitirCadastroTipoDef : «Falso» '
                                              WHEN  PermitirCadastroTipoDef = 1 THEN ' PermitirCadastroTipoDef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CfgSituacaoTpProcesso IS NULL THEN ' CfgSituacaoTpProcesso : «Nulo» '
                                              WHEN  CfgSituacaoTpProcesso = 0 THEN ' CfgSituacaoTpProcesso : «Falso» '
                                              WHEN  CfgSituacaoTpProcesso = 1 THEN ' CfgSituacaoTpProcesso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarGravarImagem IS NULL THEN ' UtilizarGravarImagem : «Nulo» '
                                              WHEN  UtilizarGravarImagem = 0 THEN ' UtilizarGravarImagem : «Falso» '
                                              WHEN  UtilizarGravarImagem = 1 THEN ' UtilizarGravarImagem : «Verdadeiro» '
                                    END 
                         + '| ServidorDigitalizacao : «' + RTRIM( ISNULL( CAST (ServidorDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaseDigitalizacao : «' + RTRIM( ISNULL( CAST (BaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioBaseDigitalizacao : «' + RTRIM( ISNULL( CAST (UsuarioBaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaBaseDigitalizacao : «' + RTRIM( ISNULL( CAST (SenhaBaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaWindows IS NULL THEN ' AutenticaWindows : «Nulo» '
                                              WHEN  AutenticaWindows = 0 THEN ' AutenticaWindows : «Falso» '
                                              WHEN  AutenticaWindows = 1 THEN ' AutenticaWindows : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoRenRCA : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoVisto : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRenVisto : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoCertReg : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoCertReg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoDebParc : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoDebParc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoATPF : «' + RTRIM( ISNULL( CAST (IdAssuntoATPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoATPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoATPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRCAPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRCAPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRCAPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRCAPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenRCAPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenRCAPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenRCAPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenRCAPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoVistoPF : «' + RTRIM( ISNULL( CAST (IdAssuntoVistoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoVistoPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoVistoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenVistoPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenVistoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenVistoPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenVistoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoCertRegPF : «' + RTRIM( ISNULL( CAST (IdAssuntoCertRegPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoCertRegPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoCertRegPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoDebParcPF : «' + RTRIM( ISNULL( CAST (IdAssuntoDebParcPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoDebParcPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoDebParcPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumRCAInicial : «' + RTRIM( ISNULL( CAST (NumRCAInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoRCA IS NULL THEN ' TipoNumeracaoRCA : «Nulo» '
                                              WHEN  TipoNumeracaoRCA = 0 THEN ' TipoNumeracaoRCA : «Falso» '
                                              WHEN  TipoNumeracaoRCA = 1 THEN ' TipoNumeracaoRCA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeraDebitoAnoInscricao IS NULL THEN ' GeraDebitoAnoInscricao : «Nulo» '
                                              WHEN  GeraDebitoAnoInscricao = 0 THEN ' GeraDebitoAnoInscricao : «Falso» '
                                              WHEN  GeraDebitoAnoInscricao = 1 THEN ' GeraDebitoAnoInscricao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeraDebitoPJPorRespTec IS NULL THEN ' GeraDebitoPJPorRespTec : «Nulo» '
                                              WHEN  GeraDebitoPJPorRespTec = 0 THEN ' GeraDebitoPJPorRespTec : «Falso» '
                                              WHEN  GeraDebitoPJPorRespTec = 1 THEN ' GeraDebitoPJPorRespTec : «Verdadeiro» '
                                    END 
                         + '| IdDebitoPJPorRespTec : «' + RTRIM( ISNULL( CAST (IdDebitoPJPorRespTec AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PriorizaTipoDebito IS NULL THEN ' PriorizaTipoDebito : «Nulo» '
                                              WHEN  PriorizaTipoDebito = 0 THEN ' PriorizaTipoDebito : «Falso» '
                                              WHEN  PriorizaTipoDebito = 1 THEN ' PriorizaTipoDebito : «Verdadeiro» '
                                    END 
                         + '| NumVistoInicial : «' + RTRIM( ISNULL( CAST (NumVistoInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoVisto IS NULL THEN ' TipoNumeracaoVisto : «Nulo» '
                                              WHEN  TipoNumeracaoVisto = 0 THEN ' TipoNumeracaoVisto : «Falso» '
                                              WHEN  TipoNumeracaoVisto = 1 THEN ' TipoNumeracaoVisto : «Verdadeiro» '
                                    END 
                         + '| AnoComSufixoRCA : «' + RTRIM( ISNULL( CAST (AnoComSufixoRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumeroRCA : «' + RTRIM( ISNULL( CAST (TamanhoNumeroRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ResetNumRCA IS NULL THEN ' ResetNumRCA : «Nulo» '
                                              WHEN  ResetNumRCA = 0 THEN ' ResetNumRCA : «Falso» '
                                              WHEN  ResetNumRCA = 1 THEN ' ResetNumRCA : «Verdadeiro» '
                                    END 
                         + '| NumAFTInicial : «' + RTRIM( ISNULL( CAST (NumAFTInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoAFT IS NULL THEN ' TipoNumeracaoAFT : «Nulo» '
                                              WHEN  TipoNumeracaoAFT = 0 THEN ' TipoNumeracaoAFT : «Falso» '
                                              WHEN  TipoNumeracaoAFT = 1 THEN ' TipoNumeracaoAFT : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoAFT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAFT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRenAFT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenAFT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoAFTPF : «' + RTRIM( ISNULL( CAST (IdAssuntoAFTPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoAFTPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoAFTPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenAFTPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenAFTPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenAFTPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenAFTPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraNumeroProcesso IS NULL THEN ' AlteraNumeroProcesso : «Nulo» '
                                              WHEN  AlteraNumeroProcesso = 0 THEN ' AlteraNumeroProcesso : «Falso» '
                                              WHEN  AlteraNumeroProcesso = 1 THEN ' AlteraNumeroProcesso : «Verdadeiro» '
                                    END 
                         + '| DirArqDNE_Correios : «' + RTRIM( ISNULL( CAST (DirArqDNE_Correios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoExibirOBSEnd IS NULL THEN ' NaoExibirOBSEnd : «Nulo» '
                                              WHEN  NaoExibirOBSEnd = 0 THEN ' NaoExibirOBSEnd : «Falso» '
                                              WHEN  NaoExibirOBSEnd = 1 THEN ' NaoExibirOBSEnd : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EditarLogradouro IS NULL THEN ' EditarLogradouro : «Nulo» '
                                              WHEN  EditarLogradouro = 0 THEN ' EditarLogradouro : «Falso» '
                                              WHEN  EditarLogradouro = 1 THEN ' EditarLogradouro : «Verdadeiro» '
                                    END 
                         + '| VersaoDNE : «' + RTRIM( ISNULL( CAST (VersaoDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DNE_Maiusculo IS NULL THEN ' DNE_Maiusculo : «Nulo» '
                                              WHEN  DNE_Maiusculo = 0 THEN ' DNE_Maiusculo : «Falso» '
                                              WHEN  DNE_Maiusculo = 1 THEN ' DNE_Maiusculo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirInfoExecucaoFiscalPF IS NULL THEN ' ExibirInfoExecucaoFiscalPF : «Nulo» '
                                              WHEN  ExibirInfoExecucaoFiscalPF = 0 THEN ' ExibirInfoExecucaoFiscalPF : «Falso» '
                                              WHEN  ExibirInfoExecucaoFiscalPF = 1 THEN ' ExibirInfoExecucaoFiscalPF : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaEmissaoSemRegistro IS NULL THEN ' UsaEmissaoSemRegistro : «Nulo» '
                                              WHEN  UsaEmissaoSemRegistro = 0 THEN ' UsaEmissaoSemRegistro : «Falso» '
                                              WHEN  UsaEmissaoSemRegistro = 1 THEN ' UsaEmissaoSemRegistro : «Verdadeiro» '
                                    END 
                         + '| Destinatario_Left : «' + RTRIM( ISNULL( CAST (Destinatario_Left AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destinatario_Top : «' + RTRIM( ISNULL( CAST (Destinatario_Top AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  HabilitarLayout3Guias IS NULL THEN ' HabilitarLayout3Guias : «Nulo» '
                                              WHEN  HabilitarLayout3Guias = 0 THEN ' HabilitarLayout3Guias : «Falso» '
                                              WHEN  HabilitarLayout3Guias = 1 THEN ' HabilitarLayout3Guias : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GerarCadaOpcDescUmaEmissao IS NULL THEN ' GerarCadaOpcDescUmaEmissao : «Nulo» '
                                              WHEN  GerarCadaOpcDescUmaEmissao = 0 THEN ' GerarCadaOpcDescUmaEmissao : «Falso» '
                                              WHEN  GerarCadaOpcDescUmaEmissao = 1 THEN ' GerarCadaOpcDescUmaEmissao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao IS NULL THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Nulo» '
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao = 0 THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Falso» '
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao = 1 THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirEndCorrespDesatualizado IS NULL THEN ' PermitirEndCorrespDesatualizado : «Nulo» '
                                              WHEN  PermitirEndCorrespDesatualizado = 0 THEN ' PermitirEndCorrespDesatualizado : «Falso» '
                                              WHEN  PermitirEndCorrespDesatualizado = 1 THEN ' PermitirEndCorrespDesatualizado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ObrigarEnderecoCorrespondencia IS NULL THEN ' ObrigarEnderecoCorrespondencia : «Nulo» '
                                              WHEN  ObrigarEnderecoCorrespondencia = 0 THEN ' ObrigarEnderecoCorrespondencia : «Falso» '
                                              WHEN  ObrigarEnderecoCorrespondencia = 1 THEN ' ObrigarEnderecoCorrespondencia : «Verdadeiro» '
                                    END 
                         + '| TempoTimeoutConexao : «' + RTRIM( ISNULL( CAST (TempoTimeoutConexao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoTimeoutConexaoMensagem : «' + RTRIM( ISNULL( CAST (TempoTimeoutConexaoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdParametrosSiscafw : «' + RTRIM( ISNULL( CAST (IdParametrosSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdFormaEntregaDocumento : «' + RTRIM( ISNULL( CAST (prec_IdFormaEntregaDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdNivelDocumento : «' + RTRIM( ISNULL( CAST (prec_IdNivelDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (prec_IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdTipoDocumento : «' + RTRIM( ISNULL( CAST (prec_IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IndOrigemDoc : «' + RTRIM( ISNULL( CAST (prec_IndOrigemDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDebitoCertidoesPF : «' + RTRIM( ISNULL( CAST (TipoDebitoCertidoesPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDebitoCertidoesPJ : «' + RTRIM( ISNULL( CAST (TipoDebitoCertidoesPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiasDataVencimento : «' + RTRIM( ISNULL( CAST (DiasDataVencimento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConselhoCorrente : «' + RTRIM( ISNULL( CAST (IdConselhoCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndContabilizacao IS NULL THEN ' IndContabilizacao : «Nulo» '
                                              WHEN  IndContabilizacao = 0 THEN ' IndContabilizacao : «Falso» '
                                              WHEN  IndContabilizacao = 1 THEN ' IndContabilizacao : «Verdadeiro» '
                                    END 
                         + '| IdBancoPadrao : «' + RTRIM( ISNULL( CAST (IdBancoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRemessa : «' + RTRIM( ISNULL( CAST (DirArqRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRetorno : «' + RTRIM( ISNULL( CAST (DirArqRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRetornoProc : «' + RTRIM( ISNULL( CAST (DirArqRetornoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirFotos : «' + RTRIM( ISNULL( CAST (DirFotos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncrementoConjunto IS NULL THEN ' IncrementoConjunto : «Nulo» '
                                              WHEN  IncrementoConjunto = 0 THEN ' IncrementoConjunto : «Falso» '
                                              WHEN  IncrementoConjunto = 1 THEN ' IncrementoConjunto : «Verdadeiro» '
                                    END 
                         + '| IndIncrementoRegistroProf : «' + RTRIM( ISNULL( CAST (IndIncrementoRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndIncrementoRegistroPJ : «' + RTRIM( ISNULL( CAST (IndIncrementoRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPre_SufNumRegistroProf : «' + RTRIM( ISNULL( CAST (IndPre_SufNumRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPre_SufNumRegistroPJ : «' + RTRIM( ISNULL( CAST (IndPre_SufNumRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumRegistroProf : «' + RTRIM( ISNULL( CAST (TamanhoNumRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumRegistroPJ : «' + RTRIM( ISNULL( CAST (TamanhoNumRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ValorMargemRecebPercentual IS NULL THEN ' ValorMargemRecebPercentual : «Nulo» '
                                              WHEN  ValorMargemRecebPercentual = 0 THEN ' ValorMargemRecebPercentual : «Falso» '
                                              WHEN  ValorMargemRecebPercentual = 1 THEN ' ValorMargemRecebPercentual : «Verdadeiro» '
                                    END 
                         + '| ValorMargemReceb : «' + RTRIM( ISNULL( CAST (ValorMargemReceb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodTratamentoRecebMenor : «' + RTRIM( ISNULL( CAST (CodTratamentoRecebMenor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodTratamentoRecebMaior : «' + RTRIM( ISNULL( CAST (CodTratamentoRecebMaior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedAtrasoPadrao : «' + RTRIM( ISNULL( CAST (IdProcedAtrasoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodPadraoRepasse : «' + RTRIM( ISNULL( CAST (CodPadraoRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLivro : «' + RTRIM( ISNULL( CAST (TipoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaseCEP IS NULL THEN ' BaseCEP : «Nulo» '
                                              WHEN  BaseCEP = 0 THEN ' BaseCEP : «Falso» '
                                              WHEN  BaseCEP = 1 THEN ' BaseCEP : «Verdadeiro» '
                                    END 
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaAltura : «' + RTRIM( ISNULL( CAST (PaginaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaLargura : «' + RTRIM( ISNULL( CAST (PaginaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaOrientacao : «' + RTRIM( ISNULL( CAST (PaginaOrientacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PzEmissaoBloqueto : «' + RTRIM( ISNULL( CAST (PzEmissaoBloqueto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndAtulizReneg IS NULL THEN ' IndAtulizReneg : «Nulo» '
                                              WHEN  IndAtulizReneg = 0 THEN ' IndAtulizReneg : «Falso» '
                                              WHEN  IndAtulizReneg = 1 THEN ' IndAtulizReneg : «Verdadeiro» '
                                    END 
                         + '| IdIndiceAtulizReneg : «' + RTRIM( ISNULL( CAST (IdIndiceAtulizReneg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemSuperior : «' + RTRIM( ISNULL( CAST (EtiquetaMargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemLateral : «' + RTRIM( ISNULL( CAST (EtiquetaMargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaVertical : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaHorizontal : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaAltura : «' + RTRIM( ISNULL( CAST (EtiquetaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaLargura : «' + RTRIM( ISNULL( CAST (EtiquetaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemPagamentoPadrao : «' + RTRIM( ISNULL( CAST (OrigemPagamentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercAcrescimoCumulativo : «' + RTRIM( ISNULL( CAST (PercAcrescimoCumulativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressaoCarne : «' + RTRIM( ISNULL( CAST (FormaImpressaoCarne AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressaoBoleto : «' + RTRIM( ISNULL( CAST (FormaImpressaoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaTamanhoPapel : «' + RTRIM( ISNULL( CAST (EtiquetaTamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura_Frame_Processos : «' + RTRIM( ISNULL( CAST (Altura_Frame_Processos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura_Frame_Processos : «' + RTRIM( ISNULL( CAST (Largura_Frame_Processos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoPadraoWEB : «' + RTRIM( ISNULL( CAST (IdBancoPadraoWEB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPadrao : «' + RTRIM( ISNULL( CAST (IdPessoaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES IS NULL THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Nulo» '
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES = 0 THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Falso» '
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES = 1 THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FazLancamentoContabil IS NULL THEN ' FazLancamentoContabil : «Nulo» '
                                              WHEN  FazLancamentoContabil = 0 THEN ' FazLancamentoContabil : «Falso» '
                                              WHEN  FazLancamentoContabil = 1 THEN ' FazLancamentoContabil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BaixarHistoricoEmissao IS NULL THEN ' BaixarHistoricoEmissao : «Nulo» '
                                              WHEN  BaixarHistoricoEmissao = 0 THEN ' BaixarHistoricoEmissao : «Falso» '
                                              WHEN  BaixarHistoricoEmissao = 1 THEN ' BaixarHistoricoEmissao : «Verdadeiro» '
                                    END 
                         + '| ReiniciaAno : «' + RTRIM( ISNULL( CAST (ReiniciaAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscAutoInc : «' + RTRIM( ISNULL( CAST (FiscAutoInc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscPrefSuf : «' + RTRIM( ISNULL( CAST (FiscPrefSuf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaCodigoBarras : «' + RTRIM( ISNULL( CAST (SequenciaCodigoBarras AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarrasSufixo : «' + RTRIM( ISNULL( CAST (CodigoBarrasSufixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarrasPrefixo : «' + RTRIM( ISNULL( CAST (CodigoBarrasPrefixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ControlarDivAtiva IS NULL THEN ' ControlarDivAtiva : «Nulo» '
                                              WHEN  ControlarDivAtiva = 0 THEN ' ControlarDivAtiva : «Falso» '
                                              WHEN  ControlarDivAtiva = 1 THEN ' ControlarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| TempoLock : «' + RTRIM( ISNULL( CONVERT (CHAR, TempoLock, 113 ),'Nulo'))+'» '
                         + '| CadastrarPessoaPor : «' + RTRIM( ISNULL( CAST (CadastrarPessoaPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| tamanhoRodape : «' + RTRIM( ISNULL( CAST (tamanhoRodape AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OcorrenciasAlterarExcluir : «' + RTRIM( ISNULL( CAST (OcorrenciasAlterarExcluir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FasesAlterarExcluir : «' + RTRIM( ISNULL( CAST (FasesAlterarExcluir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsarNumDoc IS NULL THEN ' UsarNumDoc : «Nulo» '
                                              WHEN  UsarNumDoc = 0 THEN ' UsarNumDoc : «Falso» '
                                              WHEN  UsarNumDoc = 1 THEN ' UsarNumDoc : «Verdadeiro» '
                                    END 
                         + '| IdModeloDoc : «' + RTRIM( ISNULL( CAST (IdModeloDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CancelarDivAtiva IS NULL THEN ' CancelarDivAtiva : «Nulo» '
                                              WHEN  CancelarDivAtiva = 0 THEN ' CancelarDivAtiva : «Falso» '
                                              WHEN  CancelarDivAtiva = 1 THEN ' CancelarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociarDivAtiva IS NULL THEN ' RenegociarDivAtiva : «Nulo» '
                                              WHEN  RenegociarDivAtiva = 0 THEN ' RenegociarDivAtiva : «Falso» '
                                              WHEN  RenegociarDivAtiva = 1 THEN ' RenegociarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| ControleDividaAtiva : «' + RTRIM( ISNULL( CAST (ControleDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUltimoLivro : «' + RTRIM( ISNULL( CAST (IdUltimoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idCategoriaProf : «' + RTRIM( ISNULL( CAST (idCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesDataEntrada : «' + RTRIM( ISNULL( CAST (TramitacoesDataEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| campoCabecalhoFisc : «' + RTRIM( ISNULL( CAST (campoCabecalhoFisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico1 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico2 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico3 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesCaptionAbaDinamica : «' + RTRIM( ISNULL( CAST (FiscalizacoesCaptionAbaDinamica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoCaptionAbaDinamicaFisc : «' + RTRIM( ISNULL( CAST (FiscalizacaoCaptionAbaDinamicaFisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico1 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico2 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico3 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoCaptionAbaDinamica : «' + RTRIM( ISNULL( CAST (FiscalizacaoCaptionAbaDinamica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAnoCorrenteVerifAdimplente IS NULL THEN ' UsaAnoCorrenteVerifAdimplente : «Nulo» '
                                              WHEN  UsaAnoCorrenteVerifAdimplente = 0 THEN ' UsaAnoCorrenteVerifAdimplente : «Falso» '
                                              WHEN  UsaAnoCorrenteVerifAdimplente = 1 THEN ' UsaAnoCorrenteVerifAdimplente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IgnorarZerosEsq_Registro IS NULL THEN ' IgnorarZerosEsq_Registro : «Nulo» '
                                              WHEN  IgnorarZerosEsq_Registro = 0 THEN ' IgnorarZerosEsq_Registro : «Falso» '
                                              WHEN  IgnorarZerosEsq_Registro = 1 THEN ' IgnorarZerosEsq_Registro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RegistraDtCredito IS NULL THEN ' RegistraDtCredito : «Nulo» '
                                              WHEN  RegistraDtCredito = 0 THEN ' RegistraDtCredito : «Falso» '
                                              WHEN  RegistraDtCredito = 1 THEN ' RegistraDtCredito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CriaProcessoInscricao IS NULL THEN ' CriaProcessoInscricao : «Nulo» '
                                              WHEN  CriaProcessoInscricao = 0 THEN ' CriaProcessoInscricao : «Falso» '
                                              WHEN  CriaProcessoInscricao = 1 THEN ' CriaProcessoInscricao : «Verdadeiro» '
                                    END 
                         + '| IdMoedaPadrao : «' + RTRIM( ISNULL( CAST (IdMoedaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CadPFMostraEnderecoDivulgacao IS NULL THEN ' CadPFMostraEnderecoDivulgacao : «Nulo» '
                                              WHEN  CadPFMostraEnderecoDivulgacao = 0 THEN ' CadPFMostraEnderecoDivulgacao : «Falso» '
                                              WHEN  CadPFMostraEnderecoDivulgacao = 1 THEN ' CadPFMostraEnderecoDivulgacao : «Verdadeiro» '
                                    END 
                         + '| TipoProcPagamentoBB : «' + RTRIM( ISNULL( CAST (TipoProcPagamentoBB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcInscricao : «' + RTRIM( ISNULL( CAST (NumeroProcInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraAutomaticoArquivoIndividual IS NULL THEN ' GeraAutomaticoArquivoIndividual : «Nulo» '
                                              WHEN  GeraAutomaticoArquivoIndividual = 0 THEN ' GeraAutomaticoArquivoIndividual : «Falso» '
                                              WHEN  GeraAutomaticoArquivoIndividual = 1 THEN ' GeraAutomaticoArquivoIndividual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlterarDataInscricaoConselho IS NULL THEN ' AlterarDataInscricaoConselho : «Nulo» '
                                              WHEN  AlterarDataInscricaoConselho = 0 THEN ' AlterarDataInscricaoConselho : «Falso» '
                                              WHEN  AlterarDataInscricaoConselho = 1 THEN ' AlterarDataInscricaoConselho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VerifNossoNumDuplicDetEmiss IS NULL THEN ' VerifNossoNumDuplicDetEmiss : «Nulo» '
                                              WHEN  VerifNossoNumDuplicDetEmiss = 0 THEN ' VerifNossoNumDuplicDetEmiss : «Falso» '
                                              WHEN  VerifNossoNumDuplicDetEmiss = 1 THEN ' VerifNossoNumDuplicDetEmiss : «Verdadeiro» '
                                    END 
                         + '| IdProfissionalPresidente : «' + RTRIM( ISNULL( CAST (IdProfissionalPresidente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalVice : «' + RTRIM( ISNULL( CAST (IdProfissionalVice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModeloEntregaCarteirinha : «' + RTRIM( ISNULL( CAST (IdModeloEntregaCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AssociarCidadeSubRegiao IS NULL THEN ' AssociarCidadeSubRegiao : «Nulo» '
                                              WHEN  AssociarCidadeSubRegiao = 0 THEN ' AssociarCidadeSubRegiao : «Falso» '
                                              WHEN  AssociarCidadeSubRegiao = 1 THEN ' AssociarCidadeSubRegiao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaDataTermino IS NULL THEN ' ControlaDataTermino : «Nulo» '
                                              WHEN  ControlaDataTermino = 0 THEN ' ControlaDataTermino : «Falso» '
                                              WHEN  ControlaDataTermino = 1 THEN ' ControlaDataTermino : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaDebitoConta IS NULL THEN ' UtilizaDebitoConta : «Nulo» '
                                              WHEN  UtilizaDebitoConta = 0 THEN ' UtilizaDebitoConta : «Falso» '
                                              WHEN  UtilizaDebitoConta = 1 THEN ' UtilizaDebitoConta : «Verdadeiro» '
                                    END 
                         + '| SequencialNossoNumeroDebConta : «' + RTRIM( ISNULL( CAST (SequencialNossoNumeroDebConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosicaoDivida : «' + RTRIM( ISNULL( CAST (PosicaoDivida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquetoComDesconto_Individual IS NULL THEN ' BloquetoComDesconto_Individual : «Nulo» '
                                              WHEN  BloquetoComDesconto_Individual = 0 THEN ' BloquetoComDesconto_Individual : «Falso» '
                                              WHEN  BloquetoComDesconto_Individual = 1 THEN ' BloquetoComDesconto_Individual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SugerirDataPgto IS NULL THEN ' SugerirDataPgto : «Nulo» '
                                              WHEN  SugerirDataPgto = 0 THEN ' SugerirDataPgto : «Falso» '
                                              WHEN  SugerirDataPgto = 1 THEN ' SugerirDataPgto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpedirDataPgtoFutura IS NULL THEN ' ImpedirDataPgtoFutura : «Nulo» '
                                              WHEN  ImpedirDataPgtoFutura = 0 THEN ' ImpedirDataPgtoFutura : «Falso» '
                                              WHEN  ImpedirDataPgtoFutura = 1 THEN ' ImpedirDataPgtoFutura : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociacaoViaCertidao IS NULL THEN ' RenegociacaoViaCertidao : «Nulo» '
                                              WHEN  RenegociacaoViaCertidao = 0 THEN ' RenegociacaoViaCertidao : «Falso» '
                                              WHEN  RenegociacaoViaCertidao = 1 THEN ' RenegociacaoViaCertidao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SugerirDataReferencia IS NULL THEN ' SugerirDataReferencia : «Nulo» '
                                              WHEN  SugerirDataReferencia = 0 THEN ' SugerirDataReferencia : «Falso» '
                                              WHEN  SugerirDataReferencia = 1 THEN ' SugerirDataReferencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IncrementarCF IS NULL THEN ' IncrementarCF : «Nulo» '
                                              WHEN  IncrementarCF = 0 THEN ' IncrementarCF : «Falso» '
                                              WHEN  IncrementarCF = 1 THEN ' IncrementarCF : «Verdadeiro» '
                                    END 
                         + '| SequencialCodigoFiscalizador : «' + RTRIM( ISNULL( CAST (SequencialCodigoFiscalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraNumeroProcessoPessoas IS NULL THEN ' GeraNumeroProcessoPessoas : «Nulo» '
                                              WHEN  GeraNumeroProcessoPessoas = 0 THEN ' GeraNumeroProcessoPessoas : «Falso» '
                                              WHEN  GeraNumeroProcessoPessoas = 1 THEN ' GeraNumeroProcessoPessoas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaNunProcessoBloqueto IS NULL THEN ' UtilizaNunProcessoBloqueto : «Nulo» '
                                              WHEN  UtilizaNunProcessoBloqueto = 0 THEN ' UtilizaNunProcessoBloqueto : «Falso» '
                                              WHEN  UtilizaNunProcessoBloqueto = 1 THEN ' UtilizaNunProcessoBloqueto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MudancaClassesAtiva IS NULL THEN ' MudancaClassesAtiva : «Nulo» '
                                              WHEN  MudancaClassesAtiva = 0 THEN ' MudancaClassesAtiva : «Falso» '
                                              WHEN  MudancaClassesAtiva = 1 THEN ' MudancaClassesAtiva : «Verdadeiro» '
                                    END 
                         + '| DiaMesMudancaClasses : «' + RTRIM( ISNULL( CAST (DiaMesMudancaClasses AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximoAnoMudancaClasses : «' + RTRIM( ISNULL( CAST (ProximoAnoMudancaClasses AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bNumerarRen IS NULL THEN ' bNumerarRen : «Nulo» '
                                              WHEN  bNumerarRen = 0 THEN ' bNumerarRen : «Falso» '
                                              WHEN  bNumerarRen = 1 THEN ' bNumerarRen : «Verdadeiro» '
                                    END 
                         + '| NumeroRenegociacao : «' + RTRIM( ISNULL( CAST (NumeroRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcEnviar : «' + RTRIM( ISNULL( CAST (TramitacoesProcEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcReceber : «' + RTRIM( ISNULL( CAST (TramitacoesProcReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcAlterar : «' + RTRIM( ISNULL( CAST (TramitacoesProcAlterar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TramitacoesProcFiltraRespLocal IS NULL THEN ' TramitacoesProcFiltraRespLocal : «Nulo» '
                                              WHEN  TramitacoesProcFiltraRespLocal = 0 THEN ' TramitacoesProcFiltraRespLocal : «Falso» '
                                              WHEN  TramitacoesProcFiltraRespLocal = 1 THEN ' TramitacoesProcFiltraRespLocal : «Verdadeiro» '
                                    END 
                         + '| TramitacoesProcAlterarExt : «' + RTRIM( ISNULL( CAST (TramitacoesProcAlterarExt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrioridadePadrao : «' + RTRIM( ISNULL( CAST (PrioridadePadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoPadrao : «' + RTRIM( ISNULL( CAST (SituacaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialProcesso : «' + RTRIM( ISNULL( CAST (SequencialProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoProcesso : «' + RTRIM( ISNULL( CAST (AnoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumeracaoUnicaProcesso IS NULL THEN ' NumeracaoUnicaProcesso : «Nulo» '
                                              WHEN  NumeracaoUnicaProcesso = 0 THEN ' NumeracaoUnicaProcesso : «Falso» '
                                              WHEN  NumeracaoUnicaProcesso = 1 THEN ' NumeracaoUnicaProcesso : «Verdadeiro» '
                                    END 
                         + '| IdCategoriaPadrao : «' + RTRIM( ISNULL( CAST (IdCategoriaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricaoPadrao : «' + RTRIM( ISNULL( CAST (IdTipoInscricaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoInscricaoPadrao : «' + RTRIM( ISNULL( CAST (IdMotivoInscricaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarUsuarioPadrao IS NULL THEN ' UtilizarUsuarioPadrao : «Nulo» '
                                              WHEN  UtilizarUsuarioPadrao = 0 THEN ' UtilizarUsuarioPadrao : «Falso» '
                                              WHEN  UtilizarUsuarioPadrao = 1 THEN ' UtilizarUsuarioPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaPesquisaGenerica IS NULL THEN ' UtilizaPesquisaGenerica : «Nulo» '
                                              WHEN  UtilizaPesquisaGenerica = 0 THEN ' UtilizaPesquisaGenerica : «Falso» '
                                              WHEN  UtilizaPesquisaGenerica = 1 THEN ' UtilizaPesquisaGenerica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LiberaEnvioTramitacao IS NULL THEN ' LiberaEnvioTramitacao : «Nulo» '
                                              WHEN  LiberaEnvioTramitacao = 0 THEN ' LiberaEnvioTramitacao : «Falso» '
                                              WHEN  LiberaEnvioTramitacao = 1 THEN ' LiberaEnvioTramitacao : «Verdadeiro» '
                                    END 
                         + '| SequencialNumeroCarteira : «' + RTRIM( ISNULL( CAST (SequencialNumeroCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ResumoDebitoVinculado IS NULL THEN ' ResumoDebitoVinculado : «Nulo» '
                                              WHEN  ResumoDebitoVinculado = 0 THEN ' ResumoDebitoVinculado : «Falso» '
                                              WHEN  ResumoDebitoVinculado = 1 THEN ' ResumoDebitoVinculado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaSequencialNumeroCarteira IS NULL THEN ' UtilizaSequencialNumeroCarteira : «Nulo» '
                                              WHEN  UtilizaSequencialNumeroCarteira = 0 THEN ' UtilizaSequencialNumeroCarteira : «Falso» '
                                              WHEN  UtilizaSequencialNumeroCarteira = 1 THEN ' UtilizaSequencialNumeroCarteira : «Verdadeiro» '
                                    END 
                         + '| MargemSupBoleto : «' + RTRIM( ISNULL( CAST (MargemSupBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDirBoleto : «' + RTRIM( ISNULL( CAST (MargemDirBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInfBoleto : «' + RTRIM( ISNULL( CAST (MargemInfBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsqBoleto : «' + RTRIM( ISNULL( CAST (MargemEsqBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CriticaCPFArquivoRemessa IS NULL THEN ' CriticaCPFArquivoRemessa : «Nulo» '
                                              WHEN  CriticaCPFArquivoRemessa = 0 THEN ' CriticaCPFArquivoRemessa : «Falso» '
                                              WHEN  CriticaCPFArquivoRemessa = 1 THEN ' CriticaCPFArquivoRemessa : «Verdadeiro» '
                                    END 
                         + '| SequencialSeuNumero : «' + RTRIM( ISNULL( CAST (SequencialSeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoEmailSuspensao : «' + RTRIM( ISNULL( CAST (AssuntoEmailSuspensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoEmailLevantamentoSuspensao : «' + RTRIM( ISNULL( CAST (AssuntoEmailLevantamentoSuspensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioEmailSuspensao IS NULL THEN ' EnvioEmailSuspensao : «Nulo» '
                                              WHEN  EnvioEmailSuspensao = 0 THEN ' EnvioEmailSuspensao : «Falso» '
                                              WHEN  EnvioEmailSuspensao = 1 THEN ' EnvioEmailSuspensao : «Verdadeiro» '
                                    END 
                         + '| IndPrioridadeBaixaPgto : «' + RTRIM( ISNULL( CAST (IndPrioridadeBaixaPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailProcesso : «' + RTRIM( ISNULL( CAST (UsuarioEmailProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaUsuarioEmailProcesso : «' + RTRIM( ISNULL( CAST (SenhaUsuarioEmailProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LogAtivado IS NULL THEN ' LogAtivado : «Nulo» '
                                              WHEN  LogAtivado = 0 THEN ' LogAtivado : «Falso» '
                                              WHEN  LogAtivado = 1 THEN ' LogAtivado : «Verdadeiro» '
                                    END 
                         + '| Assinatura1 : «' + RTRIM( ISNULL( CAST (Assinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura2 : «' + RTRIM( ISNULL( CAST (Assinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo1 : «' + RTRIM( ISNULL( CAST (Cargo1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo2 : «' + RTRIM( ISNULL( CAST (Cargo2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasServidor : «' + RTRIM( ISNULL( CAST (EmailCartirasServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCarteirasPorta : «' + RTRIM( ISNULL( CAST (EmailCarteirasPorta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasUsuario : «' + RTRIM( ISNULL( CAST (EmailCartirasUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasSenha : «' + RTRIM( ISNULL( CAST (EmailCartirasSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasAssunto : «' + RTRIM( ISNULL( CAST (EmailCartirasAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OcorrenciaCartirasImpressao IS NULL THEN ' OcorrenciaCartirasImpressao : «Nulo» '
                                              WHEN  OcorrenciaCartirasImpressao = 0 THEN ' OcorrenciaCartirasImpressao : «Falso» '
                                              WHEN  OcorrenciaCartirasImpressao = 1 THEN ' OcorrenciaCartirasImpressao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OcorrenciaCartirasEmail IS NULL THEN ' OcorrenciaCartirasEmail : «Nulo» '
                                              WHEN  OcorrenciaCartirasEmail = 0 THEN ' OcorrenciaCartirasEmail : «Falso» '
                                              WHEN  OcorrenciaCartirasEmail = 1 THEN ' OcorrenciaCartirasEmail : «Verdadeiro» '
                                    END 
                         + '| OcorrenciaCartirasTexto : «' + RTRIM( ISNULL( CAST (OcorrenciaCartirasTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OcorrenciaCartirasDetalhes : «' + RTRIM( ISNULL( CAST (OcorrenciaCartirasDetalhes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UtilizaAgendaContatos : «' + RTRIM( ISNULL( CAST (UtilizaAgendaContatos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EditarCEP IS NULL THEN ' EditarCEP : «Nulo» '
                                              WHEN  EditarCEP = 0 THEN ' EditarCEP : «Falso» '
                                              WHEN  EditarCEP = 1 THEN ' EditarCEP : «Verdadeiro» '
                                    END 
                         + '| LocalizarProfPJ : «' + RTRIM( ISNULL( CAST (LocalizarProfPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqApreciacao : «' + RTRIM( ISNULL( CAST (DirArqApreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqResolucao : «' + RTRIM( ISNULL( CAST (DirArqResolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirModeloResolucao : «' + RTRIM( ISNULL( CAST (DirModeloResolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GerarSubDiretorioPorBanco IS NULL THEN ' GerarSubDiretorioPorBanco : «Nulo» '
                                              WHEN  GerarSubDiretorioPorBanco = 0 THEN ' GerarSubDiretorioPorBanco : «Falso» '
                                              WHEN  GerarSubDiretorioPorBanco = 1 THEN ' GerarSubDiretorioPorBanco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirAdimplenciaEmVotacao IS NULL THEN ' ExibirAdimplenciaEmVotacao : «Nulo» '
                                              WHEN  ExibirAdimplenciaEmVotacao = 0 THEN ' ExibirAdimplenciaEmVotacao : «Falso» '
                                              WHEN  ExibirAdimplenciaEmVotacao = 1 THEN ' ExibirAdimplenciaEmVotacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReiniciaAnoProc IS NULL THEN ' ReiniciaAnoProc : «Nulo» '
                                              WHEN  ReiniciaAnoProc = 0 THEN ' ReiniciaAnoProc : «Falso» '
                                              WHEN  ReiniciaAnoProc = 1 THEN ' ReiniciaAnoProc : «Verdadeiro» '
                                    END 
                         + '| DtVencAnuConsiderarInadimpl : «' + RTRIM( ISNULL( CAST (DtVencAnuConsiderarInadimpl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarAcrescimoRecobranca IS NULL THEN ' UtilizarAcrescimoRecobranca : «Nulo» '
                                              WHEN  UtilizarAcrescimoRecobranca = 0 THEN ' UtilizarAcrescimoRecobranca : «Falso» '
                                              WHEN  UtilizarAcrescimoRecobranca = 1 THEN ' UtilizarAcrescimoRecobranca : «Verdadeiro» '
                                    END 
                         + '| DataAlterarValorDA : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlterarValorDA, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AceitarPgtoCanceladoArquivoRet IS NULL THEN ' AceitarPgtoCanceladoArquivoRet : «Nulo» '
                                              WHEN  AceitarPgtoCanceladoArquivoRet = 0 THEN ' AceitarPgtoCanceladoArquivoRet : «Falso» '
                                              WHEN  AceitarPgtoCanceladoArquivoRet = 1 THEN ' AceitarPgtoCanceladoArquivoRet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitarPgtoPagoArquivoRet IS NULL THEN ' AceitarPgtoPagoArquivoRet : «Nulo» '
                                              WHEN  AceitarPgtoPagoArquivoRet = 0 THEN ' AceitarPgtoPagoArquivoRet : «Falso» '
                                              WHEN  AceitarPgtoPagoArquivoRet = 1 THEN ' AceitarPgtoPagoArquivoRet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaoBaixarPagoMaior IS NULL THEN ' NaoBaixarPagoMaior : «Nulo» '
                                              WHEN  NaoBaixarPagoMaior = 0 THEN ' NaoBaixarPagoMaior : «Falso» '
                                              WHEN  NaoBaixarPagoMaior = 1 THEN ' NaoBaixarPagoMaior : «Verdadeiro» '
                                    END 
                         + '| ValorMargemPagoMaior : «' + RTRIM( ISNULL( CAST (ValorMargemPagoMaior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqThemis : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqThemis, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqAdvatu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqAdvatu, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqTJ : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqTJ, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FlagScriptSituacaoPFPJ IS NULL THEN ' FlagScriptSituacaoPFPJ : «Nulo» '
                                              WHEN  FlagScriptSituacaoPFPJ = 0 THEN ' FlagScriptSituacaoPFPJ : «Falso» '
                                              WHEN  FlagScriptSituacaoPFPJ = 1 THEN ' FlagScriptSituacaoPFPJ : «Verdadeiro» '
                                    END 
                         + '| FiscTamanhoSequencial : «' + RTRIM( ISNULL( CAST (FiscTamanhoSequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscSigla : «' + RTRIM( ISNULL( CAST (FiscSigla AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FlagScriptSituacaoPFPJ2 IS NULL THEN ' FlagScriptSituacaoPFPJ2 : «Nulo» '
                                              WHEN  FlagScriptSituacaoPFPJ2 = 0 THEN ' FlagScriptSituacaoPFPJ2 : «Falso» '
                                              WHEN  FlagScriptSituacaoPFPJ2 = 1 THEN ' FlagScriptSituacaoPFPJ2 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitaDataFutura IS NULL THEN ' AceitaDataFutura : «Nulo» '
                                              WHEN  AceitaDataFutura = 0 THEN ' AceitaDataFutura : «Falso» '
                                              WHEN  AceitaDataFutura = 1 THEN ' AceitaDataFutura : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IgnoraVlrPgSitDeb IS NULL THEN ' IgnoraVlrPgSitDeb : «Nulo» '
                                              WHEN  IgnoraVlrPgSitDeb = 0 THEN ' IgnoraVlrPgSitDeb : «Falso» '
                                              WHEN  IgnoraVlrPgSitDeb = 1 THEN ' IgnoraVlrPgSitDeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailCarteirasAutenticaSSL IS NULL THEN ' EmailCarteirasAutenticaSSL : «Nulo» '
                                              WHEN  EmailCarteirasAutenticaSSL = 0 THEN ' EmailCarteirasAutenticaSSL : «Falso» '
                                              WHEN  EmailCarteirasAutenticaSSL = 1 THEN ' EmailCarteirasAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearEdicaoSubRegiao IS NULL THEN ' BloquearEdicaoSubRegiao : «Nulo» '
                                              WHEN  BloquearEdicaoSubRegiao = 0 THEN ' BloquearEdicaoSubRegiao : «Falso» '
                                              WHEN  BloquearEdicaoSubRegiao = 1 THEN ' BloquearEdicaoSubRegiao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| FltrDebAnoInicial : «' + RTRIM( ISNULL( CAST (FltrDebAnoInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebAnoFinal : «' + RTRIM( ISNULL( CAST (FltrDebAnoFinal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebVencInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, FltrDebVencInicial, 113 ),'Nulo'))+'» '
                         + '| FltrDebVencFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, FltrDebVencFinal, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FltrDebNExibirRenCanc IS NULL THEN ' FltrDebNExibirRenCanc : «Nulo» '
                                              WHEN  FltrDebNExibirRenCanc = 0 THEN ' FltrDebNExibirRenCanc : «Falso» '
                                              WHEN  FltrDebNExibirRenCanc = 1 THEN ' FltrDebNExibirRenCanc : «Verdadeiro» '
                                    END 
                         + '| FltrDebTipoDeb : «' + RTRIM( ISNULL( CAST (FltrDebTipoDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebSituacaoDeb : «' + RTRIM( ISNULL( CAST (FltrDebSituacaoDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebMotivoCanc : «' + RTRIM( ISNULL( CAST (FltrDebMotivoCanc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndUtilizaMsgDtPrevisaoProc IS NULL THEN ' IndUtilizaMsgDtPrevisaoProc : «Nulo» '
                                              WHEN  IndUtilizaMsgDtPrevisaoProc = 0 THEN ' IndUtilizaMsgDtPrevisaoProc : «Falso» '
                                              WHEN  IndUtilizaMsgDtPrevisaoProc = 1 THEN ' IndUtilizaMsgDtPrevisaoProc : «Verdadeiro» '
                                    END 
                         + '| TipoExibicaoMsgDtPrevicaoProc : «' + RTRIM( ISNULL( CAST (TipoExibicaoMsgDtPrevicaoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitirAcesProcInterno IS NULL THEN ' PermitirAcesProcInterno : «Nulo» '
                                              WHEN  PermitirAcesProcInterno = 0 THEN ' PermitirAcesProcInterno : «Falso» '
                                              WHEN  PermitirAcesProcInterno = 1 THEN ' PermitirAcesProcInterno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirAcesFiscInterno IS NULL THEN ' PermitirAcesFiscInterno : «Nulo» '
                                              WHEN  PermitirAcesFiscInterno = 0 THEN ' PermitirAcesFiscInterno : «Falso» '
                                              WHEN  PermitirAcesFiscInterno = 1 THEN ' PermitirAcesFiscInterno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarIntegracao IS NULL THEN ' UtilizarIntegracao : «Nulo» '
                                              WHEN  UtilizarIntegracao = 0 THEN ' UtilizarIntegracao : «Falso» '
                                              WHEN  UtilizarIntegracao = 1 THEN ' UtilizarIntegracao : «Verdadeiro» '
                                    END 
                         + '| IntegracaoProvider : «' + RTRIM( ISNULL( CAST (IntegracaoProvider AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoServidor : «' + RTRIM( ISNULL( CAST (IntegracaoServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoBancoDados : «' + RTRIM( ISNULL( CAST (IntegracaoBancoDados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoSchema : «' + RTRIM( ISNULL( CAST (IntegracaoSchema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoUsuario : «' + RTRIM( ISNULL( CAST (IntegracaoUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoSenha : «' + RTRIM( ISNULL( CAST (IntegracaoSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarCampoObr IS NULL THEN ' AplicarCampoObr : «Nulo» '
                                              WHEN  AplicarCampoObr = 0 THEN ' AplicarCampoObr : «Falso» '
                                              WHEN  AplicarCampoObr = 1 THEN ' AplicarCampoObr : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarAssistenteCadastro IS NULL THEN ' UtilizarAssistenteCadastro : «Nulo» '
                                              WHEN  UtilizarAssistenteCadastro = 0 THEN ' UtilizarAssistenteCadastro : «Falso» '
                                              WHEN  UtilizarAssistenteCadastro = 1 THEN ' UtilizarAssistenteCadastro : «Verdadeiro» '
                                    END 
                         + '| DirRel : «' + RTRIM( ISNULL( CAST (DirRel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaControleDigitalizacoes IS NULL THEN ' UtilizaControleDigitalizacoes : «Nulo» '
                                              WHEN  UtilizaControleDigitalizacoes = 0 THEN ' UtilizaControleDigitalizacoes : «Falso» '
                                              WHEN  UtilizaControleDigitalizacoes = 1 THEN ' UtilizaControleDigitalizacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirVinculoProcTipoDif IS NULL THEN ' PermitirVinculoProcTipoDif : «Nulo» '
                                              WHEN  PermitirVinculoProcTipoDif = 0 THEN ' PermitirVinculoProcTipoDif : «Falso» '
                                              WHEN  PermitirVinculoProcTipoDif = 1 THEN ' PermitirVinculoProcTipoDif : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitacaoDataPrevObrig IS NULL THEN ' TramitacaoDataPrevObrig : «Nulo» '
                                              WHEN  TramitacaoDataPrevObrig = 0 THEN ' TramitacaoDataPrevObrig : «Falso» '
                                              WHEN  TramitacaoDataPrevObrig = 1 THEN ' TramitacaoDataPrevObrig : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitPermitirDesativarAviso IS NULL THEN ' TramitPermitirDesativarAviso : «Nulo» '
                                              WHEN  TramitPermitirDesativarAviso = 0 THEN ' TramitPermitirDesativarAviso : «Falso» '
                                              WHEN  TramitPermitirDesativarAviso = 1 THEN ' TramitPermitirDesativarAviso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAlteracaoTramitacao IS NULL THEN ' BloquearAlteracaoTramitacao : «Nulo» '
                                              WHEN  BloquearAlteracaoTramitacao = 0 THEN ' BloquearAlteracaoTramitacao : «Falso» '
                                              WHEN  BloquearAlteracaoTramitacao = 1 THEN ' BloquearAlteracaoTramitacao : «Verdadeiro» '
                                    END 
                         + '| DuplicidadeNR : «' + RTRIM( ISNULL( CAST (DuplicidadeNR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComputadorMalaDireta : «' + RTRIM( ISNULL( CAST (ComputadorMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaPeticaoCDA IS NULL THEN ' AgrupaPeticaoCDA : «Nulo» '
                                              WHEN  AgrupaPeticaoCDA = 0 THEN ' AgrupaPeticaoCDA : «Falso» '
                                              WHEN  AgrupaPeticaoCDA = 1 THEN ' AgrupaPeticaoCDA : «Verdadeiro» '
                                    END 
                         + '| EmailEnvioErros : «' + RTRIM( ISNULL( CAST (EmailEnvioErros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalDividaAtivaAtualizada : «' + RTRIM( ISNULL( CAST (TotalDividaAtivaAtualizada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigRelatorioFixoXML : «' + RTRIM( ISNULL( CAST (ConfigRelatorioFixoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirAlertaPendBaixa IS NULL THEN ' ExibirAlertaPendBaixa : «Nulo» '
                                              WHEN  ExibirAlertaPendBaixa = 0 THEN ' ExibirAlertaPendBaixa : «Falso» '
                                              WHEN  ExibirAlertaPendBaixa = 1 THEN ' ExibirAlertaPendBaixa : «Verdadeiro» '
                                    END 
                         + '| ExibirAlertaPendBaixaAPartirDe : «' + RTRIM( ISNULL( CONVERT (CHAR, ExibirAlertaPendBaixaAPartirDe, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConcatenarLocalTrabalho IS NULL THEN ' ConcatenarLocalTrabalho : «Nulo» '
                                              WHEN  ConcatenarLocalTrabalho = 0 THEN ' ConcatenarLocalTrabalho : «Falso» '
                                              WHEN  ConcatenarLocalTrabalho = 1 THEN ' ConcatenarLocalTrabalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NrInfObrigatorio IS NULL THEN ' NrInfObrigatorio : «Nulo» '
                                              WHEN  NrInfObrigatorio = 0 THEN ' NrInfObrigatorio : «Falso» '
                                              WHEN  NrInfObrigatorio = 1 THEN ' NrInfObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NrInfRecebeNrModeloAutoInf IS NULL THEN ' NrInfRecebeNrModeloAutoInf : «Nulo» '
                                              WHEN  NrInfRecebeNrModeloAutoInf = 0 THEN ' NrInfRecebeNrModeloAutoInf : «Falso» '
                                              WHEN  NrInfRecebeNrModeloAutoInf = 1 THEN ' NrInfRecebeNrModeloAutoInf : «Verdadeiro» '
                                    END 
                         + '| DataVerificacaoREN : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVerificacaoREN, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FormaImpressao IS NULL THEN ' FormaImpressao : «Nulo» '
                                              WHEN  FormaImpressao = 0 THEN ' FormaImpressao : «Falso» '
                                              WHEN  FormaImpressao = 1 THEN ' FormaImpressao : «Verdadeiro» '
                                    END 
                         + '| idPadraoEtapaProcInscricaoPF : «' + RTRIM( ISNULL( CAST (idPadraoEtapaProcInscricaoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idPadraoEtapaProcInscricaoPJ : «' + RTRIM( ISNULL( CAST (idPadraoEtapaProcInscricaoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TxtPreviaAcordoRen : «' + RTRIM( ISNULL( CAST (TxtPreviaAcordoRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebitoHonorariosAdv : «' + RTRIM( ISNULL( CAST (IdTipoDebitoHonorariosAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeVersoBoleto IS NULL THEN ' ImprimeVersoBoleto : «Nulo» '
                                              WHEN  ImprimeVersoBoleto = 0 THEN ' ImprimeVersoBoleto : «Falso» '
                                              WHEN  ImprimeVersoBoleto = 1 THEN ' ImprimeVersoBoleto : «Verdadeiro» '
                                    END 
                         + '| IdTipoDebitoFS : «' + RTRIM( ISNULL( CAST (IdTipoDebitoFS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal IS NULL THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Nulo» '
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal = 0 THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Falso» '
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal = 1 THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNARemoverZeros IS NULL THEN ' CNARemoverZeros : «Nulo» '
                                              WHEN  CNARemoverZeros = 0 THEN ' CNARemoverZeros : «Falso» '
                                              WHEN  CNARemoverZeros = 1 THEN ' CNARemoverZeros : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NotCPFDuplicado IS NULL THEN ' NotCPFDuplicado : «Nulo» '
                                              WHEN  NotCPFDuplicado = 0 THEN ' NotCPFDuplicado : «Falso» '
                                              WHEN  NotCPFDuplicado = 1 THEN ' NotCPFDuplicado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DIV_SituacoesPFPJ IS NULL THEN ' DIV_SituacoesPFPJ : «Nulo» '
                                              WHEN  DIV_SituacoesPFPJ = 0 THEN ' DIV_SituacoesPFPJ : «Falso» '
                                              WHEN  DIV_SituacoesPFPJ = 1 THEN ' DIV_SituacoesPFPJ : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DIV_TiposInscricao IS NULL THEN ' DIV_TiposInscricao : «Nulo» '
                                              WHEN  DIV_TiposInscricao = 0 THEN ' DIV_TiposInscricao : «Falso» '
                                              WHEN  DIV_TiposInscricao = 1 THEN ' DIV_TiposInscricao : «Verdadeiro» '
                                    END 
                         + '| DataUltimaBaixaDadosSiscafWeb : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaBaixaDadosSiscafWeb, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraDataPedidoInscricao IS NULL THEN ' MostraDataPedidoInscricao : «Nulo» '
                                              WHEN  MostraDataPedidoInscricao = 0 THEN ' MostraDataPedidoInscricao : «Falso» '
                                              WHEN  MostraDataPedidoInscricao = 1 THEN ' MostraDataPedidoInscricao : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoAT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRCA : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCopiaBoleto : «' + RTRIM( ISNULL( CAST (EmailCopiaBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InserirLogoNoReciboSiscafw IS NULL THEN ' InserirLogoNoReciboSiscafw : «Nulo» '
                                              WHEN  InserirLogoNoReciboSiscafw = 0 THEN ' InserirLogoNoReciboSiscafw : «Falso» '
                                              WHEN  InserirLogoNoReciboSiscafw = 1 THEN ' InserirLogoNoReciboSiscafw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarProcAtrasoDebitosDA IS NULL THEN ' UtilizarProcAtrasoDebitosDA : «Nulo» '
                                              WHEN  UtilizarProcAtrasoDebitosDA = 0 THEN ' UtilizarProcAtrasoDebitosDA : «Falso» '
                                              WHEN  UtilizarProcAtrasoDebitosDA = 1 THEN ' UtilizarProcAtrasoDebitosDA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarSelecaoUnicaTipoDef IS NULL THEN ' UtilizarSelecaoUnicaTipoDef : «Nulo» '
                                              WHEN  UtilizarSelecaoUnicaTipoDef = 0 THEN ' UtilizarSelecaoUnicaTipoDef : «Falso» '
                                              WHEN  UtilizarSelecaoUnicaTipoDef = 1 THEN ' UtilizarSelecaoUnicaTipoDef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirCadastroTipoDef IS NULL THEN ' PermitirCadastroTipoDef : «Nulo» '
                                              WHEN  PermitirCadastroTipoDef = 0 THEN ' PermitirCadastroTipoDef : «Falso» '
                                              WHEN  PermitirCadastroTipoDef = 1 THEN ' PermitirCadastroTipoDef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CfgSituacaoTpProcesso IS NULL THEN ' CfgSituacaoTpProcesso : «Nulo» '
                                              WHEN  CfgSituacaoTpProcesso = 0 THEN ' CfgSituacaoTpProcesso : «Falso» '
                                              WHEN  CfgSituacaoTpProcesso = 1 THEN ' CfgSituacaoTpProcesso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarGravarImagem IS NULL THEN ' UtilizarGravarImagem : «Nulo» '
                                              WHEN  UtilizarGravarImagem = 0 THEN ' UtilizarGravarImagem : «Falso» '
                                              WHEN  UtilizarGravarImagem = 1 THEN ' UtilizarGravarImagem : «Verdadeiro» '
                                    END 
                         + '| ServidorDigitalizacao : «' + RTRIM( ISNULL( CAST (ServidorDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaseDigitalizacao : «' + RTRIM( ISNULL( CAST (BaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioBaseDigitalizacao : «' + RTRIM( ISNULL( CAST (UsuarioBaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaBaseDigitalizacao : «' + RTRIM( ISNULL( CAST (SenhaBaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaWindows IS NULL THEN ' AutenticaWindows : «Nulo» '
                                              WHEN  AutenticaWindows = 0 THEN ' AutenticaWindows : «Falso» '
                                              WHEN  AutenticaWindows = 1 THEN ' AutenticaWindows : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoRenRCA : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoVisto : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRenVisto : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoCertReg : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoCertReg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoDebParc : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoDebParc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoATPF : «' + RTRIM( ISNULL( CAST (IdAssuntoATPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoATPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoATPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRCAPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRCAPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRCAPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRCAPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenRCAPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenRCAPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenRCAPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenRCAPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoVistoPF : «' + RTRIM( ISNULL( CAST (IdAssuntoVistoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoVistoPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoVistoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenVistoPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenVistoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenVistoPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenVistoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoCertRegPF : «' + RTRIM( ISNULL( CAST (IdAssuntoCertRegPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoCertRegPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoCertRegPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoDebParcPF : «' + RTRIM( ISNULL( CAST (IdAssuntoDebParcPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoDebParcPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoDebParcPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumRCAInicial : «' + RTRIM( ISNULL( CAST (NumRCAInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoRCA IS NULL THEN ' TipoNumeracaoRCA : «Nulo» '
                                              WHEN  TipoNumeracaoRCA = 0 THEN ' TipoNumeracaoRCA : «Falso» '
                                              WHEN  TipoNumeracaoRCA = 1 THEN ' TipoNumeracaoRCA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeraDebitoAnoInscricao IS NULL THEN ' GeraDebitoAnoInscricao : «Nulo» '
                                              WHEN  GeraDebitoAnoInscricao = 0 THEN ' GeraDebitoAnoInscricao : «Falso» '
                                              WHEN  GeraDebitoAnoInscricao = 1 THEN ' GeraDebitoAnoInscricao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeraDebitoPJPorRespTec IS NULL THEN ' GeraDebitoPJPorRespTec : «Nulo» '
                                              WHEN  GeraDebitoPJPorRespTec = 0 THEN ' GeraDebitoPJPorRespTec : «Falso» '
                                              WHEN  GeraDebitoPJPorRespTec = 1 THEN ' GeraDebitoPJPorRespTec : «Verdadeiro» '
                                    END 
                         + '| IdDebitoPJPorRespTec : «' + RTRIM( ISNULL( CAST (IdDebitoPJPorRespTec AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PriorizaTipoDebito IS NULL THEN ' PriorizaTipoDebito : «Nulo» '
                                              WHEN  PriorizaTipoDebito = 0 THEN ' PriorizaTipoDebito : «Falso» '
                                              WHEN  PriorizaTipoDebito = 1 THEN ' PriorizaTipoDebito : «Verdadeiro» '
                                    END 
                         + '| NumVistoInicial : «' + RTRIM( ISNULL( CAST (NumVistoInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoVisto IS NULL THEN ' TipoNumeracaoVisto : «Nulo» '
                                              WHEN  TipoNumeracaoVisto = 0 THEN ' TipoNumeracaoVisto : «Falso» '
                                              WHEN  TipoNumeracaoVisto = 1 THEN ' TipoNumeracaoVisto : «Verdadeiro» '
                                    END 
                         + '| AnoComSufixoRCA : «' + RTRIM( ISNULL( CAST (AnoComSufixoRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumeroRCA : «' + RTRIM( ISNULL( CAST (TamanhoNumeroRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ResetNumRCA IS NULL THEN ' ResetNumRCA : «Nulo» '
                                              WHEN  ResetNumRCA = 0 THEN ' ResetNumRCA : «Falso» '
                                              WHEN  ResetNumRCA = 1 THEN ' ResetNumRCA : «Verdadeiro» '
                                    END 
                         + '| NumAFTInicial : «' + RTRIM( ISNULL( CAST (NumAFTInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoAFT IS NULL THEN ' TipoNumeracaoAFT : «Nulo» '
                                              WHEN  TipoNumeracaoAFT = 0 THEN ' TipoNumeracaoAFT : «Falso» '
                                              WHEN  TipoNumeracaoAFT = 1 THEN ' TipoNumeracaoAFT : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoAFT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAFT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRenAFT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenAFT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoAFTPF : «' + RTRIM( ISNULL( CAST (IdAssuntoAFTPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoAFTPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoAFTPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenAFTPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenAFTPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenAFTPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenAFTPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraNumeroProcesso IS NULL THEN ' AlteraNumeroProcesso : «Nulo» '
                                              WHEN  AlteraNumeroProcesso = 0 THEN ' AlteraNumeroProcesso : «Falso» '
                                              WHEN  AlteraNumeroProcesso = 1 THEN ' AlteraNumeroProcesso : «Verdadeiro» '
                                    END 
                         + '| DirArqDNE_Correios : «' + RTRIM( ISNULL( CAST (DirArqDNE_Correios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoExibirOBSEnd IS NULL THEN ' NaoExibirOBSEnd : «Nulo» '
                                              WHEN  NaoExibirOBSEnd = 0 THEN ' NaoExibirOBSEnd : «Falso» '
                                              WHEN  NaoExibirOBSEnd = 1 THEN ' NaoExibirOBSEnd : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EditarLogradouro IS NULL THEN ' EditarLogradouro : «Nulo» '
                                              WHEN  EditarLogradouro = 0 THEN ' EditarLogradouro : «Falso» '
                                              WHEN  EditarLogradouro = 1 THEN ' EditarLogradouro : «Verdadeiro» '
                                    END 
                         + '| VersaoDNE : «' + RTRIM( ISNULL( CAST (VersaoDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DNE_Maiusculo IS NULL THEN ' DNE_Maiusculo : «Nulo» '
                                              WHEN  DNE_Maiusculo = 0 THEN ' DNE_Maiusculo : «Falso» '
                                              WHEN  DNE_Maiusculo = 1 THEN ' DNE_Maiusculo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirInfoExecucaoFiscalPF IS NULL THEN ' ExibirInfoExecucaoFiscalPF : «Nulo» '
                                              WHEN  ExibirInfoExecucaoFiscalPF = 0 THEN ' ExibirInfoExecucaoFiscalPF : «Falso» '
                                              WHEN  ExibirInfoExecucaoFiscalPF = 1 THEN ' ExibirInfoExecucaoFiscalPF : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaEmissaoSemRegistro IS NULL THEN ' UsaEmissaoSemRegistro : «Nulo» '
                                              WHEN  UsaEmissaoSemRegistro = 0 THEN ' UsaEmissaoSemRegistro : «Falso» '
                                              WHEN  UsaEmissaoSemRegistro = 1 THEN ' UsaEmissaoSemRegistro : «Verdadeiro» '
                                    END 
                         + '| Destinatario_Left : «' + RTRIM( ISNULL( CAST (Destinatario_Left AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destinatario_Top : «' + RTRIM( ISNULL( CAST (Destinatario_Top AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  HabilitarLayout3Guias IS NULL THEN ' HabilitarLayout3Guias : «Nulo» '
                                              WHEN  HabilitarLayout3Guias = 0 THEN ' HabilitarLayout3Guias : «Falso» '
                                              WHEN  HabilitarLayout3Guias = 1 THEN ' HabilitarLayout3Guias : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GerarCadaOpcDescUmaEmissao IS NULL THEN ' GerarCadaOpcDescUmaEmissao : «Nulo» '
                                              WHEN  GerarCadaOpcDescUmaEmissao = 0 THEN ' GerarCadaOpcDescUmaEmissao : «Falso» '
                                              WHEN  GerarCadaOpcDescUmaEmissao = 1 THEN ' GerarCadaOpcDescUmaEmissao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao IS NULL THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Nulo» '
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao = 0 THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Falso» '
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao = 1 THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirEndCorrespDesatualizado IS NULL THEN ' PermitirEndCorrespDesatualizado : «Nulo» '
                                              WHEN  PermitirEndCorrespDesatualizado = 0 THEN ' PermitirEndCorrespDesatualizado : «Falso» '
                                              WHEN  PermitirEndCorrespDesatualizado = 1 THEN ' PermitirEndCorrespDesatualizado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ObrigarEnderecoCorrespondencia IS NULL THEN ' ObrigarEnderecoCorrespondencia : «Nulo» '
                                              WHEN  ObrigarEnderecoCorrespondencia = 0 THEN ' ObrigarEnderecoCorrespondencia : «Falso» '
                                              WHEN  ObrigarEnderecoCorrespondencia = 1 THEN ' ObrigarEnderecoCorrespondencia : «Verdadeiro» '
                                    END 
                         + '| TempoTimeoutConexao : «' + RTRIM( ISNULL( CAST (TempoTimeoutConexao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoTimeoutConexaoMensagem : «' + RTRIM( ISNULL( CAST (TempoTimeoutConexaoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdParametrosSiscafw : «' + RTRIM( ISNULL( CAST (IdParametrosSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdFormaEntregaDocumento : «' + RTRIM( ISNULL( CAST (prec_IdFormaEntregaDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdNivelDocumento : «' + RTRIM( ISNULL( CAST (prec_IdNivelDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (prec_IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdTipoDocumento : «' + RTRIM( ISNULL( CAST (prec_IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IndOrigemDoc : «' + RTRIM( ISNULL( CAST (prec_IndOrigemDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDebitoCertidoesPF : «' + RTRIM( ISNULL( CAST (TipoDebitoCertidoesPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDebitoCertidoesPJ : «' + RTRIM( ISNULL( CAST (TipoDebitoCertidoesPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiasDataVencimento : «' + RTRIM( ISNULL( CAST (DiasDataVencimento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConselhoCorrente : «' + RTRIM( ISNULL( CAST (IdConselhoCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndContabilizacao IS NULL THEN ' IndContabilizacao : «Nulo» '
                                              WHEN  IndContabilizacao = 0 THEN ' IndContabilizacao : «Falso» '
                                              WHEN  IndContabilizacao = 1 THEN ' IndContabilizacao : «Verdadeiro» '
                                    END 
                         + '| IdBancoPadrao : «' + RTRIM( ISNULL( CAST (IdBancoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRemessa : «' + RTRIM( ISNULL( CAST (DirArqRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRetorno : «' + RTRIM( ISNULL( CAST (DirArqRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqRetornoProc : «' + RTRIM( ISNULL( CAST (DirArqRetornoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirFotos : «' + RTRIM( ISNULL( CAST (DirFotos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncrementoConjunto IS NULL THEN ' IncrementoConjunto : «Nulo» '
                                              WHEN  IncrementoConjunto = 0 THEN ' IncrementoConjunto : «Falso» '
                                              WHEN  IncrementoConjunto = 1 THEN ' IncrementoConjunto : «Verdadeiro» '
                                    END 
                         + '| IndIncrementoRegistroProf : «' + RTRIM( ISNULL( CAST (IndIncrementoRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndIncrementoRegistroPJ : «' + RTRIM( ISNULL( CAST (IndIncrementoRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPre_SufNumRegistroProf : «' + RTRIM( ISNULL( CAST (IndPre_SufNumRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPre_SufNumRegistroPJ : «' + RTRIM( ISNULL( CAST (IndPre_SufNumRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumRegistroProf : «' + RTRIM( ISNULL( CAST (TamanhoNumRegistroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumRegistroPJ : «' + RTRIM( ISNULL( CAST (TamanhoNumRegistroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ValorMargemRecebPercentual IS NULL THEN ' ValorMargemRecebPercentual : «Nulo» '
                                              WHEN  ValorMargemRecebPercentual = 0 THEN ' ValorMargemRecebPercentual : «Falso» '
                                              WHEN  ValorMargemRecebPercentual = 1 THEN ' ValorMargemRecebPercentual : «Verdadeiro» '
                                    END 
                         + '| ValorMargemReceb : «' + RTRIM( ISNULL( CAST (ValorMargemReceb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodTratamentoRecebMenor : «' + RTRIM( ISNULL( CAST (CodTratamentoRecebMenor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodTratamentoRecebMaior : «' + RTRIM( ISNULL( CAST (CodTratamentoRecebMaior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedAtrasoPadrao : «' + RTRIM( ISNULL( CAST (IdProcedAtrasoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodPadraoRepasse : «' + RTRIM( ISNULL( CAST (CodPadraoRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLivro : «' + RTRIM( ISNULL( CAST (TipoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaseCEP IS NULL THEN ' BaseCEP : «Nulo» '
                                              WHEN  BaseCEP = 0 THEN ' BaseCEP : «Falso» '
                                              WHEN  BaseCEP = 1 THEN ' BaseCEP : «Verdadeiro» '
                                    END 
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaAltura : «' + RTRIM( ISNULL( CAST (PaginaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaLargura : «' + RTRIM( ISNULL( CAST (PaginaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaOrientacao : «' + RTRIM( ISNULL( CAST (PaginaOrientacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PzEmissaoBloqueto : «' + RTRIM( ISNULL( CAST (PzEmissaoBloqueto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndAtulizReneg IS NULL THEN ' IndAtulizReneg : «Nulo» '
                                              WHEN  IndAtulizReneg = 0 THEN ' IndAtulizReneg : «Falso» '
                                              WHEN  IndAtulizReneg = 1 THEN ' IndAtulizReneg : «Verdadeiro» '
                                    END 
                         + '| IdIndiceAtulizReneg : «' + RTRIM( ISNULL( CAST (IdIndiceAtulizReneg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemSuperior : «' + RTRIM( ISNULL( CAST (EtiquetaMargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemLateral : «' + RTRIM( ISNULL( CAST (EtiquetaMargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaVertical : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaHorizontal : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaAltura : «' + RTRIM( ISNULL( CAST (EtiquetaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaLargura : «' + RTRIM( ISNULL( CAST (EtiquetaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemPagamentoPadrao : «' + RTRIM( ISNULL( CAST (OrigemPagamentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercAcrescimoCumulativo : «' + RTRIM( ISNULL( CAST (PercAcrescimoCumulativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressaoCarne : «' + RTRIM( ISNULL( CAST (FormaImpressaoCarne AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressaoBoleto : «' + RTRIM( ISNULL( CAST (FormaImpressaoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaTamanhoPapel : «' + RTRIM( ISNULL( CAST (EtiquetaTamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura_Frame_Processos : «' + RTRIM( ISNULL( CAST (Altura_Frame_Processos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura_Frame_Processos : «' + RTRIM( ISNULL( CAST (Largura_Frame_Processos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoPadraoWEB : «' + RTRIM( ISNULL( CAST (IdBancoPadraoWEB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPadrao : «' + RTRIM( ISNULL( CAST (IdPessoaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES IS NULL THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Nulo» '
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES = 0 THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Falso» '
                                              WHEN  ATIVAATUALIZACAOAUT_SITUACOES = 1 THEN ' ATIVAATUALIZACAOAUT_SITUACOES : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FazLancamentoContabil IS NULL THEN ' FazLancamentoContabil : «Nulo» '
                                              WHEN  FazLancamentoContabil = 0 THEN ' FazLancamentoContabil : «Falso» '
                                              WHEN  FazLancamentoContabil = 1 THEN ' FazLancamentoContabil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BaixarHistoricoEmissao IS NULL THEN ' BaixarHistoricoEmissao : «Nulo» '
                                              WHEN  BaixarHistoricoEmissao = 0 THEN ' BaixarHistoricoEmissao : «Falso» '
                                              WHEN  BaixarHistoricoEmissao = 1 THEN ' BaixarHistoricoEmissao : «Verdadeiro» '
                                    END 
                         + '| ReiniciaAno : «' + RTRIM( ISNULL( CAST (ReiniciaAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscAutoInc : «' + RTRIM( ISNULL( CAST (FiscAutoInc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscPrefSuf : «' + RTRIM( ISNULL( CAST (FiscPrefSuf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaCodigoBarras : «' + RTRIM( ISNULL( CAST (SequenciaCodigoBarras AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarrasSufixo : «' + RTRIM( ISNULL( CAST (CodigoBarrasSufixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarrasPrefixo : «' + RTRIM( ISNULL( CAST (CodigoBarrasPrefixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ControlarDivAtiva IS NULL THEN ' ControlarDivAtiva : «Nulo» '
                                              WHEN  ControlarDivAtiva = 0 THEN ' ControlarDivAtiva : «Falso» '
                                              WHEN  ControlarDivAtiva = 1 THEN ' ControlarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| TempoLock : «' + RTRIM( ISNULL( CONVERT (CHAR, TempoLock, 113 ),'Nulo'))+'» '
                         + '| CadastrarPessoaPor : «' + RTRIM( ISNULL( CAST (CadastrarPessoaPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| tamanhoRodape : «' + RTRIM( ISNULL( CAST (tamanhoRodape AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OcorrenciasAlterarExcluir : «' + RTRIM( ISNULL( CAST (OcorrenciasAlterarExcluir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FasesAlterarExcluir : «' + RTRIM( ISNULL( CAST (FasesAlterarExcluir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsarNumDoc IS NULL THEN ' UsarNumDoc : «Nulo» '
                                              WHEN  UsarNumDoc = 0 THEN ' UsarNumDoc : «Falso» '
                                              WHEN  UsarNumDoc = 1 THEN ' UsarNumDoc : «Verdadeiro» '
                                    END 
                         + '| IdModeloDoc : «' + RTRIM( ISNULL( CAST (IdModeloDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CancelarDivAtiva IS NULL THEN ' CancelarDivAtiva : «Nulo» '
                                              WHEN  CancelarDivAtiva = 0 THEN ' CancelarDivAtiva : «Falso» '
                                              WHEN  CancelarDivAtiva = 1 THEN ' CancelarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociarDivAtiva IS NULL THEN ' RenegociarDivAtiva : «Nulo» '
                                              WHEN  RenegociarDivAtiva = 0 THEN ' RenegociarDivAtiva : «Falso» '
                                              WHEN  RenegociarDivAtiva = 1 THEN ' RenegociarDivAtiva : «Verdadeiro» '
                                    END 
                         + '| ControleDividaAtiva : «' + RTRIM( ISNULL( CAST (ControleDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUltimoLivro : «' + RTRIM( ISNULL( CAST (IdUltimoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idCategoriaProf : «' + RTRIM( ISNULL( CAST (idCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesDataEntrada : «' + RTRIM( ISNULL( CAST (TramitacoesDataEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| campoCabecalhoFisc : «' + RTRIM( ISNULL( CAST (campoCabecalhoFisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico1 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico2 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesNomeDinamico3 : «' + RTRIM( ISNULL( CAST (FiscalizacoesNomeDinamico3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacoesCaptionAbaDinamica : «' + RTRIM( ISNULL( CAST (FiscalizacoesCaptionAbaDinamica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoCaptionAbaDinamicaFisc : «' + RTRIM( ISNULL( CAST (FiscalizacaoCaptionAbaDinamicaFisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico1 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico2 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoNomeDinamico3 : «' + RTRIM( ISNULL( CAST (FiscalizacaoNomeDinamico3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscalizacaoCaptionAbaDinamica : «' + RTRIM( ISNULL( CAST (FiscalizacaoCaptionAbaDinamica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAnoCorrenteVerifAdimplente IS NULL THEN ' UsaAnoCorrenteVerifAdimplente : «Nulo» '
                                              WHEN  UsaAnoCorrenteVerifAdimplente = 0 THEN ' UsaAnoCorrenteVerifAdimplente : «Falso» '
                                              WHEN  UsaAnoCorrenteVerifAdimplente = 1 THEN ' UsaAnoCorrenteVerifAdimplente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IgnorarZerosEsq_Registro IS NULL THEN ' IgnorarZerosEsq_Registro : «Nulo» '
                                              WHEN  IgnorarZerosEsq_Registro = 0 THEN ' IgnorarZerosEsq_Registro : «Falso» '
                                              WHEN  IgnorarZerosEsq_Registro = 1 THEN ' IgnorarZerosEsq_Registro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RegistraDtCredito IS NULL THEN ' RegistraDtCredito : «Nulo» '
                                              WHEN  RegistraDtCredito = 0 THEN ' RegistraDtCredito : «Falso» '
                                              WHEN  RegistraDtCredito = 1 THEN ' RegistraDtCredito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CriaProcessoInscricao IS NULL THEN ' CriaProcessoInscricao : «Nulo» '
                                              WHEN  CriaProcessoInscricao = 0 THEN ' CriaProcessoInscricao : «Falso» '
                                              WHEN  CriaProcessoInscricao = 1 THEN ' CriaProcessoInscricao : «Verdadeiro» '
                                    END 
                         + '| IdMoedaPadrao : «' + RTRIM( ISNULL( CAST (IdMoedaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CadPFMostraEnderecoDivulgacao IS NULL THEN ' CadPFMostraEnderecoDivulgacao : «Nulo» '
                                              WHEN  CadPFMostraEnderecoDivulgacao = 0 THEN ' CadPFMostraEnderecoDivulgacao : «Falso» '
                                              WHEN  CadPFMostraEnderecoDivulgacao = 1 THEN ' CadPFMostraEnderecoDivulgacao : «Verdadeiro» '
                                    END 
                         + '| TipoProcPagamentoBB : «' + RTRIM( ISNULL( CAST (TipoProcPagamentoBB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcInscricao : «' + RTRIM( ISNULL( CAST (NumeroProcInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraAutomaticoArquivoIndividual IS NULL THEN ' GeraAutomaticoArquivoIndividual : «Nulo» '
                                              WHEN  GeraAutomaticoArquivoIndividual = 0 THEN ' GeraAutomaticoArquivoIndividual : «Falso» '
                                              WHEN  GeraAutomaticoArquivoIndividual = 1 THEN ' GeraAutomaticoArquivoIndividual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlterarDataInscricaoConselho IS NULL THEN ' AlterarDataInscricaoConselho : «Nulo» '
                                              WHEN  AlterarDataInscricaoConselho = 0 THEN ' AlterarDataInscricaoConselho : «Falso» '
                                              WHEN  AlterarDataInscricaoConselho = 1 THEN ' AlterarDataInscricaoConselho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VerifNossoNumDuplicDetEmiss IS NULL THEN ' VerifNossoNumDuplicDetEmiss : «Nulo» '
                                              WHEN  VerifNossoNumDuplicDetEmiss = 0 THEN ' VerifNossoNumDuplicDetEmiss : «Falso» '
                                              WHEN  VerifNossoNumDuplicDetEmiss = 1 THEN ' VerifNossoNumDuplicDetEmiss : «Verdadeiro» '
                                    END 
                         + '| IdProfissionalPresidente : «' + RTRIM( ISNULL( CAST (IdProfissionalPresidente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalVice : «' + RTRIM( ISNULL( CAST (IdProfissionalVice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModeloEntregaCarteirinha : «' + RTRIM( ISNULL( CAST (IdModeloEntregaCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AssociarCidadeSubRegiao IS NULL THEN ' AssociarCidadeSubRegiao : «Nulo» '
                                              WHEN  AssociarCidadeSubRegiao = 0 THEN ' AssociarCidadeSubRegiao : «Falso» '
                                              WHEN  AssociarCidadeSubRegiao = 1 THEN ' AssociarCidadeSubRegiao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaDataTermino IS NULL THEN ' ControlaDataTermino : «Nulo» '
                                              WHEN  ControlaDataTermino = 0 THEN ' ControlaDataTermino : «Falso» '
                                              WHEN  ControlaDataTermino = 1 THEN ' ControlaDataTermino : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaDebitoConta IS NULL THEN ' UtilizaDebitoConta : «Nulo» '
                                              WHEN  UtilizaDebitoConta = 0 THEN ' UtilizaDebitoConta : «Falso» '
                                              WHEN  UtilizaDebitoConta = 1 THEN ' UtilizaDebitoConta : «Verdadeiro» '
                                    END 
                         + '| SequencialNossoNumeroDebConta : «' + RTRIM( ISNULL( CAST (SequencialNossoNumeroDebConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosicaoDivida : «' + RTRIM( ISNULL( CAST (PosicaoDivida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquetoComDesconto_Individual IS NULL THEN ' BloquetoComDesconto_Individual : «Nulo» '
                                              WHEN  BloquetoComDesconto_Individual = 0 THEN ' BloquetoComDesconto_Individual : «Falso» '
                                              WHEN  BloquetoComDesconto_Individual = 1 THEN ' BloquetoComDesconto_Individual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SugerirDataPgto IS NULL THEN ' SugerirDataPgto : «Nulo» '
                                              WHEN  SugerirDataPgto = 0 THEN ' SugerirDataPgto : «Falso» '
                                              WHEN  SugerirDataPgto = 1 THEN ' SugerirDataPgto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpedirDataPgtoFutura IS NULL THEN ' ImpedirDataPgtoFutura : «Nulo» '
                                              WHEN  ImpedirDataPgtoFutura = 0 THEN ' ImpedirDataPgtoFutura : «Falso» '
                                              WHEN  ImpedirDataPgtoFutura = 1 THEN ' ImpedirDataPgtoFutura : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociacaoViaCertidao IS NULL THEN ' RenegociacaoViaCertidao : «Nulo» '
                                              WHEN  RenegociacaoViaCertidao = 0 THEN ' RenegociacaoViaCertidao : «Falso» '
                                              WHEN  RenegociacaoViaCertidao = 1 THEN ' RenegociacaoViaCertidao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SugerirDataReferencia IS NULL THEN ' SugerirDataReferencia : «Nulo» '
                                              WHEN  SugerirDataReferencia = 0 THEN ' SugerirDataReferencia : «Falso» '
                                              WHEN  SugerirDataReferencia = 1 THEN ' SugerirDataReferencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IncrementarCF IS NULL THEN ' IncrementarCF : «Nulo» '
                                              WHEN  IncrementarCF = 0 THEN ' IncrementarCF : «Falso» '
                                              WHEN  IncrementarCF = 1 THEN ' IncrementarCF : «Verdadeiro» '
                                    END 
                         + '| SequencialCodigoFiscalizador : «' + RTRIM( ISNULL( CAST (SequencialCodigoFiscalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraNumeroProcessoPessoas IS NULL THEN ' GeraNumeroProcessoPessoas : «Nulo» '
                                              WHEN  GeraNumeroProcessoPessoas = 0 THEN ' GeraNumeroProcessoPessoas : «Falso» '
                                              WHEN  GeraNumeroProcessoPessoas = 1 THEN ' GeraNumeroProcessoPessoas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaNunProcessoBloqueto IS NULL THEN ' UtilizaNunProcessoBloqueto : «Nulo» '
                                              WHEN  UtilizaNunProcessoBloqueto = 0 THEN ' UtilizaNunProcessoBloqueto : «Falso» '
                                              WHEN  UtilizaNunProcessoBloqueto = 1 THEN ' UtilizaNunProcessoBloqueto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MudancaClassesAtiva IS NULL THEN ' MudancaClassesAtiva : «Nulo» '
                                              WHEN  MudancaClassesAtiva = 0 THEN ' MudancaClassesAtiva : «Falso» '
                                              WHEN  MudancaClassesAtiva = 1 THEN ' MudancaClassesAtiva : «Verdadeiro» '
                                    END 
                         + '| DiaMesMudancaClasses : «' + RTRIM( ISNULL( CAST (DiaMesMudancaClasses AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximoAnoMudancaClasses : «' + RTRIM( ISNULL( CAST (ProximoAnoMudancaClasses AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bNumerarRen IS NULL THEN ' bNumerarRen : «Nulo» '
                                              WHEN  bNumerarRen = 0 THEN ' bNumerarRen : «Falso» '
                                              WHEN  bNumerarRen = 1 THEN ' bNumerarRen : «Verdadeiro» '
                                    END 
                         + '| NumeroRenegociacao : «' + RTRIM( ISNULL( CAST (NumeroRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcEnviar : «' + RTRIM( ISNULL( CAST (TramitacoesProcEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcReceber : «' + RTRIM( ISNULL( CAST (TramitacoesProcReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TramitacoesProcAlterar : «' + RTRIM( ISNULL( CAST (TramitacoesProcAlterar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TramitacoesProcFiltraRespLocal IS NULL THEN ' TramitacoesProcFiltraRespLocal : «Nulo» '
                                              WHEN  TramitacoesProcFiltraRespLocal = 0 THEN ' TramitacoesProcFiltraRespLocal : «Falso» '
                                              WHEN  TramitacoesProcFiltraRespLocal = 1 THEN ' TramitacoesProcFiltraRespLocal : «Verdadeiro» '
                                    END 
                         + '| TramitacoesProcAlterarExt : «' + RTRIM( ISNULL( CAST (TramitacoesProcAlterarExt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrioridadePadrao : «' + RTRIM( ISNULL( CAST (PrioridadePadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoPadrao : «' + RTRIM( ISNULL( CAST (SituacaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialProcesso : «' + RTRIM( ISNULL( CAST (SequencialProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoProcesso : «' + RTRIM( ISNULL( CAST (AnoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumeracaoUnicaProcesso IS NULL THEN ' NumeracaoUnicaProcesso : «Nulo» '
                                              WHEN  NumeracaoUnicaProcesso = 0 THEN ' NumeracaoUnicaProcesso : «Falso» '
                                              WHEN  NumeracaoUnicaProcesso = 1 THEN ' NumeracaoUnicaProcesso : «Verdadeiro» '
                                    END 
                         + '| IdCategoriaPadrao : «' + RTRIM( ISNULL( CAST (IdCategoriaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricaoPadrao : «' + RTRIM( ISNULL( CAST (IdTipoInscricaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoInscricaoPadrao : «' + RTRIM( ISNULL( CAST (IdMotivoInscricaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarUsuarioPadrao IS NULL THEN ' UtilizarUsuarioPadrao : «Nulo» '
                                              WHEN  UtilizarUsuarioPadrao = 0 THEN ' UtilizarUsuarioPadrao : «Falso» '
                                              WHEN  UtilizarUsuarioPadrao = 1 THEN ' UtilizarUsuarioPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaPesquisaGenerica IS NULL THEN ' UtilizaPesquisaGenerica : «Nulo» '
                                              WHEN  UtilizaPesquisaGenerica = 0 THEN ' UtilizaPesquisaGenerica : «Falso» '
                                              WHEN  UtilizaPesquisaGenerica = 1 THEN ' UtilizaPesquisaGenerica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LiberaEnvioTramitacao IS NULL THEN ' LiberaEnvioTramitacao : «Nulo» '
                                              WHEN  LiberaEnvioTramitacao = 0 THEN ' LiberaEnvioTramitacao : «Falso» '
                                              WHEN  LiberaEnvioTramitacao = 1 THEN ' LiberaEnvioTramitacao : «Verdadeiro» '
                                    END 
                         + '| SequencialNumeroCarteira : «' + RTRIM( ISNULL( CAST (SequencialNumeroCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ResumoDebitoVinculado IS NULL THEN ' ResumoDebitoVinculado : «Nulo» '
                                              WHEN  ResumoDebitoVinculado = 0 THEN ' ResumoDebitoVinculado : «Falso» '
                                              WHEN  ResumoDebitoVinculado = 1 THEN ' ResumoDebitoVinculado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaSequencialNumeroCarteira IS NULL THEN ' UtilizaSequencialNumeroCarteira : «Nulo» '
                                              WHEN  UtilizaSequencialNumeroCarteira = 0 THEN ' UtilizaSequencialNumeroCarteira : «Falso» '
                                              WHEN  UtilizaSequencialNumeroCarteira = 1 THEN ' UtilizaSequencialNumeroCarteira : «Verdadeiro» '
                                    END 
                         + '| MargemSupBoleto : «' + RTRIM( ISNULL( CAST (MargemSupBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDirBoleto : «' + RTRIM( ISNULL( CAST (MargemDirBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInfBoleto : «' + RTRIM( ISNULL( CAST (MargemInfBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsqBoleto : «' + RTRIM( ISNULL( CAST (MargemEsqBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CriticaCPFArquivoRemessa IS NULL THEN ' CriticaCPFArquivoRemessa : «Nulo» '
                                              WHEN  CriticaCPFArquivoRemessa = 0 THEN ' CriticaCPFArquivoRemessa : «Falso» '
                                              WHEN  CriticaCPFArquivoRemessa = 1 THEN ' CriticaCPFArquivoRemessa : «Verdadeiro» '
                                    END 
                         + '| SequencialSeuNumero : «' + RTRIM( ISNULL( CAST (SequencialSeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoEmailSuspensao : «' + RTRIM( ISNULL( CAST (AssuntoEmailSuspensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoEmailLevantamentoSuspensao : «' + RTRIM( ISNULL( CAST (AssuntoEmailLevantamentoSuspensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioEmailSuspensao IS NULL THEN ' EnvioEmailSuspensao : «Nulo» '
                                              WHEN  EnvioEmailSuspensao = 0 THEN ' EnvioEmailSuspensao : «Falso» '
                                              WHEN  EnvioEmailSuspensao = 1 THEN ' EnvioEmailSuspensao : «Verdadeiro» '
                                    END 
                         + '| IndPrioridadeBaixaPgto : «' + RTRIM( ISNULL( CAST (IndPrioridadeBaixaPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmailProcesso : «' + RTRIM( ISNULL( CAST (UsuarioEmailProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaUsuarioEmailProcesso : «' + RTRIM( ISNULL( CAST (SenhaUsuarioEmailProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LogAtivado IS NULL THEN ' LogAtivado : «Nulo» '
                                              WHEN  LogAtivado = 0 THEN ' LogAtivado : «Falso» '
                                              WHEN  LogAtivado = 1 THEN ' LogAtivado : «Verdadeiro» '
                                    END 
                         + '| Assinatura1 : «' + RTRIM( ISNULL( CAST (Assinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura2 : «' + RTRIM( ISNULL( CAST (Assinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo1 : «' + RTRIM( ISNULL( CAST (Cargo1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo2 : «' + RTRIM( ISNULL( CAST (Cargo2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasServidor : «' + RTRIM( ISNULL( CAST (EmailCartirasServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCarteirasPorta : «' + RTRIM( ISNULL( CAST (EmailCarteirasPorta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasUsuario : «' + RTRIM( ISNULL( CAST (EmailCartirasUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasSenha : «' + RTRIM( ISNULL( CAST (EmailCartirasSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCartirasAssunto : «' + RTRIM( ISNULL( CAST (EmailCartirasAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OcorrenciaCartirasImpressao IS NULL THEN ' OcorrenciaCartirasImpressao : «Nulo» '
                                              WHEN  OcorrenciaCartirasImpressao = 0 THEN ' OcorrenciaCartirasImpressao : «Falso» '
                                              WHEN  OcorrenciaCartirasImpressao = 1 THEN ' OcorrenciaCartirasImpressao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OcorrenciaCartirasEmail IS NULL THEN ' OcorrenciaCartirasEmail : «Nulo» '
                                              WHEN  OcorrenciaCartirasEmail = 0 THEN ' OcorrenciaCartirasEmail : «Falso» '
                                              WHEN  OcorrenciaCartirasEmail = 1 THEN ' OcorrenciaCartirasEmail : «Verdadeiro» '
                                    END 
                         + '| OcorrenciaCartirasTexto : «' + RTRIM( ISNULL( CAST (OcorrenciaCartirasTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OcorrenciaCartirasDetalhes : «' + RTRIM( ISNULL( CAST (OcorrenciaCartirasDetalhes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UtilizaAgendaContatos : «' + RTRIM( ISNULL( CAST (UtilizaAgendaContatos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EditarCEP IS NULL THEN ' EditarCEP : «Nulo» '
                                              WHEN  EditarCEP = 0 THEN ' EditarCEP : «Falso» '
                                              WHEN  EditarCEP = 1 THEN ' EditarCEP : «Verdadeiro» '
                                    END 
                         + '| LocalizarProfPJ : «' + RTRIM( ISNULL( CAST (LocalizarProfPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqApreciacao : «' + RTRIM( ISNULL( CAST (DirArqApreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirArqResolucao : «' + RTRIM( ISNULL( CAST (DirArqResolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DirModeloResolucao : «' + RTRIM( ISNULL( CAST (DirModeloResolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GerarSubDiretorioPorBanco IS NULL THEN ' GerarSubDiretorioPorBanco : «Nulo» '
                                              WHEN  GerarSubDiretorioPorBanco = 0 THEN ' GerarSubDiretorioPorBanco : «Falso» '
                                              WHEN  GerarSubDiretorioPorBanco = 1 THEN ' GerarSubDiretorioPorBanco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirAdimplenciaEmVotacao IS NULL THEN ' ExibirAdimplenciaEmVotacao : «Nulo» '
                                              WHEN  ExibirAdimplenciaEmVotacao = 0 THEN ' ExibirAdimplenciaEmVotacao : «Falso» '
                                              WHEN  ExibirAdimplenciaEmVotacao = 1 THEN ' ExibirAdimplenciaEmVotacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReiniciaAnoProc IS NULL THEN ' ReiniciaAnoProc : «Nulo» '
                                              WHEN  ReiniciaAnoProc = 0 THEN ' ReiniciaAnoProc : «Falso» '
                                              WHEN  ReiniciaAnoProc = 1 THEN ' ReiniciaAnoProc : «Verdadeiro» '
                                    END 
                         + '| DtVencAnuConsiderarInadimpl : «' + RTRIM( ISNULL( CAST (DtVencAnuConsiderarInadimpl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarAcrescimoRecobranca IS NULL THEN ' UtilizarAcrescimoRecobranca : «Nulo» '
                                              WHEN  UtilizarAcrescimoRecobranca = 0 THEN ' UtilizarAcrescimoRecobranca : «Falso» '
                                              WHEN  UtilizarAcrescimoRecobranca = 1 THEN ' UtilizarAcrescimoRecobranca : «Verdadeiro» '
                                    END 
                         + '| DataAlterarValorDA : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlterarValorDA, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AceitarPgtoCanceladoArquivoRet IS NULL THEN ' AceitarPgtoCanceladoArquivoRet : «Nulo» '
                                              WHEN  AceitarPgtoCanceladoArquivoRet = 0 THEN ' AceitarPgtoCanceladoArquivoRet : «Falso» '
                                              WHEN  AceitarPgtoCanceladoArquivoRet = 1 THEN ' AceitarPgtoCanceladoArquivoRet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitarPgtoPagoArquivoRet IS NULL THEN ' AceitarPgtoPagoArquivoRet : «Nulo» '
                                              WHEN  AceitarPgtoPagoArquivoRet = 0 THEN ' AceitarPgtoPagoArquivoRet : «Falso» '
                                              WHEN  AceitarPgtoPagoArquivoRet = 1 THEN ' AceitarPgtoPagoArquivoRet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaoBaixarPagoMaior IS NULL THEN ' NaoBaixarPagoMaior : «Nulo» '
                                              WHEN  NaoBaixarPagoMaior = 0 THEN ' NaoBaixarPagoMaior : «Falso» '
                                              WHEN  NaoBaixarPagoMaior = 1 THEN ' NaoBaixarPagoMaior : «Verdadeiro» '
                                    END 
                         + '| ValorMargemPagoMaior : «' + RTRIM( ISNULL( CAST (ValorMargemPagoMaior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqThemis : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqThemis, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqAdvatu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqAdvatu, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacaoArqTJ : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacaoArqTJ, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FlagScriptSituacaoPFPJ IS NULL THEN ' FlagScriptSituacaoPFPJ : «Nulo» '
                                              WHEN  FlagScriptSituacaoPFPJ = 0 THEN ' FlagScriptSituacaoPFPJ : «Falso» '
                                              WHEN  FlagScriptSituacaoPFPJ = 1 THEN ' FlagScriptSituacaoPFPJ : «Verdadeiro» '
                                    END 
                         + '| FiscTamanhoSequencial : «' + RTRIM( ISNULL( CAST (FiscTamanhoSequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiscSigla : «' + RTRIM( ISNULL( CAST (FiscSigla AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FlagScriptSituacaoPFPJ2 IS NULL THEN ' FlagScriptSituacaoPFPJ2 : «Nulo» '
                                              WHEN  FlagScriptSituacaoPFPJ2 = 0 THEN ' FlagScriptSituacaoPFPJ2 : «Falso» '
                                              WHEN  FlagScriptSituacaoPFPJ2 = 1 THEN ' FlagScriptSituacaoPFPJ2 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitaDataFutura IS NULL THEN ' AceitaDataFutura : «Nulo» '
                                              WHEN  AceitaDataFutura = 0 THEN ' AceitaDataFutura : «Falso» '
                                              WHEN  AceitaDataFutura = 1 THEN ' AceitaDataFutura : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IgnoraVlrPgSitDeb IS NULL THEN ' IgnoraVlrPgSitDeb : «Nulo» '
                                              WHEN  IgnoraVlrPgSitDeb = 0 THEN ' IgnoraVlrPgSitDeb : «Falso» '
                                              WHEN  IgnoraVlrPgSitDeb = 1 THEN ' IgnoraVlrPgSitDeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailCarteirasAutenticaSSL IS NULL THEN ' EmailCarteirasAutenticaSSL : «Nulo» '
                                              WHEN  EmailCarteirasAutenticaSSL = 0 THEN ' EmailCarteirasAutenticaSSL : «Falso» '
                                              WHEN  EmailCarteirasAutenticaSSL = 1 THEN ' EmailCarteirasAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearEdicaoSubRegiao IS NULL THEN ' BloquearEdicaoSubRegiao : «Nulo» '
                                              WHEN  BloquearEdicaoSubRegiao = 0 THEN ' BloquearEdicaoSubRegiao : «Falso» '
                                              WHEN  BloquearEdicaoSubRegiao = 1 THEN ' BloquearEdicaoSubRegiao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| FltrDebAnoInicial : «' + RTRIM( ISNULL( CAST (FltrDebAnoInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebAnoFinal : «' + RTRIM( ISNULL( CAST (FltrDebAnoFinal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebVencInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, FltrDebVencInicial, 113 ),'Nulo'))+'» '
                         + '| FltrDebVencFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, FltrDebVencFinal, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FltrDebNExibirRenCanc IS NULL THEN ' FltrDebNExibirRenCanc : «Nulo» '
                                              WHEN  FltrDebNExibirRenCanc = 0 THEN ' FltrDebNExibirRenCanc : «Falso» '
                                              WHEN  FltrDebNExibirRenCanc = 1 THEN ' FltrDebNExibirRenCanc : «Verdadeiro» '
                                    END 
                         + '| FltrDebTipoDeb : «' + RTRIM( ISNULL( CAST (FltrDebTipoDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebSituacaoDeb : «' + RTRIM( ISNULL( CAST (FltrDebSituacaoDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FltrDebMotivoCanc : «' + RTRIM( ISNULL( CAST (FltrDebMotivoCanc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndUtilizaMsgDtPrevisaoProc IS NULL THEN ' IndUtilizaMsgDtPrevisaoProc : «Nulo» '
                                              WHEN  IndUtilizaMsgDtPrevisaoProc = 0 THEN ' IndUtilizaMsgDtPrevisaoProc : «Falso» '
                                              WHEN  IndUtilizaMsgDtPrevisaoProc = 1 THEN ' IndUtilizaMsgDtPrevisaoProc : «Verdadeiro» '
                                    END 
                         + '| TipoExibicaoMsgDtPrevicaoProc : «' + RTRIM( ISNULL( CAST (TipoExibicaoMsgDtPrevicaoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitirAcesProcInterno IS NULL THEN ' PermitirAcesProcInterno : «Nulo» '
                                              WHEN  PermitirAcesProcInterno = 0 THEN ' PermitirAcesProcInterno : «Falso» '
                                              WHEN  PermitirAcesProcInterno = 1 THEN ' PermitirAcesProcInterno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirAcesFiscInterno IS NULL THEN ' PermitirAcesFiscInterno : «Nulo» '
                                              WHEN  PermitirAcesFiscInterno = 0 THEN ' PermitirAcesFiscInterno : «Falso» '
                                              WHEN  PermitirAcesFiscInterno = 1 THEN ' PermitirAcesFiscInterno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarIntegracao IS NULL THEN ' UtilizarIntegracao : «Nulo» '
                                              WHEN  UtilizarIntegracao = 0 THEN ' UtilizarIntegracao : «Falso» '
                                              WHEN  UtilizarIntegracao = 1 THEN ' UtilizarIntegracao : «Verdadeiro» '
                                    END 
                         + '| IntegracaoProvider : «' + RTRIM( ISNULL( CAST (IntegracaoProvider AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoServidor : «' + RTRIM( ISNULL( CAST (IntegracaoServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoBancoDados : «' + RTRIM( ISNULL( CAST (IntegracaoBancoDados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoSchema : «' + RTRIM( ISNULL( CAST (IntegracaoSchema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoUsuario : «' + RTRIM( ISNULL( CAST (IntegracaoUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntegracaoSenha : «' + RTRIM( ISNULL( CAST (IntegracaoSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarCampoObr IS NULL THEN ' AplicarCampoObr : «Nulo» '
                                              WHEN  AplicarCampoObr = 0 THEN ' AplicarCampoObr : «Falso» '
                                              WHEN  AplicarCampoObr = 1 THEN ' AplicarCampoObr : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarAssistenteCadastro IS NULL THEN ' UtilizarAssistenteCadastro : «Nulo» '
                                              WHEN  UtilizarAssistenteCadastro = 0 THEN ' UtilizarAssistenteCadastro : «Falso» '
                                              WHEN  UtilizarAssistenteCadastro = 1 THEN ' UtilizarAssistenteCadastro : «Verdadeiro» '
                                    END 
                         + '| DirRel : «' + RTRIM( ISNULL( CAST (DirRel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaControleDigitalizacoes IS NULL THEN ' UtilizaControleDigitalizacoes : «Nulo» '
                                              WHEN  UtilizaControleDigitalizacoes = 0 THEN ' UtilizaControleDigitalizacoes : «Falso» '
                                              WHEN  UtilizaControleDigitalizacoes = 1 THEN ' UtilizaControleDigitalizacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirVinculoProcTipoDif IS NULL THEN ' PermitirVinculoProcTipoDif : «Nulo» '
                                              WHEN  PermitirVinculoProcTipoDif = 0 THEN ' PermitirVinculoProcTipoDif : «Falso» '
                                              WHEN  PermitirVinculoProcTipoDif = 1 THEN ' PermitirVinculoProcTipoDif : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitacaoDataPrevObrig IS NULL THEN ' TramitacaoDataPrevObrig : «Nulo» '
                                              WHEN  TramitacaoDataPrevObrig = 0 THEN ' TramitacaoDataPrevObrig : «Falso» '
                                              WHEN  TramitacaoDataPrevObrig = 1 THEN ' TramitacaoDataPrevObrig : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitPermitirDesativarAviso IS NULL THEN ' TramitPermitirDesativarAviso : «Nulo» '
                                              WHEN  TramitPermitirDesativarAviso = 0 THEN ' TramitPermitirDesativarAviso : «Falso» '
                                              WHEN  TramitPermitirDesativarAviso = 1 THEN ' TramitPermitirDesativarAviso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAlteracaoTramitacao IS NULL THEN ' BloquearAlteracaoTramitacao : «Nulo» '
                                              WHEN  BloquearAlteracaoTramitacao = 0 THEN ' BloquearAlteracaoTramitacao : «Falso» '
                                              WHEN  BloquearAlteracaoTramitacao = 1 THEN ' BloquearAlteracaoTramitacao : «Verdadeiro» '
                                    END 
                         + '| DuplicidadeNR : «' + RTRIM( ISNULL( CAST (DuplicidadeNR AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComputadorMalaDireta : «' + RTRIM( ISNULL( CAST (ComputadorMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgrupaPeticaoCDA IS NULL THEN ' AgrupaPeticaoCDA : «Nulo» '
                                              WHEN  AgrupaPeticaoCDA = 0 THEN ' AgrupaPeticaoCDA : «Falso» '
                                              WHEN  AgrupaPeticaoCDA = 1 THEN ' AgrupaPeticaoCDA : «Verdadeiro» '
                                    END 
                         + '| EmailEnvioErros : «' + RTRIM( ISNULL( CAST (EmailEnvioErros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalDividaAtivaAtualizada : «' + RTRIM( ISNULL( CAST (TotalDividaAtivaAtualizada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigRelatorioFixoXML : «' + RTRIM( ISNULL( CAST (ConfigRelatorioFixoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirAlertaPendBaixa IS NULL THEN ' ExibirAlertaPendBaixa : «Nulo» '
                                              WHEN  ExibirAlertaPendBaixa = 0 THEN ' ExibirAlertaPendBaixa : «Falso» '
                                              WHEN  ExibirAlertaPendBaixa = 1 THEN ' ExibirAlertaPendBaixa : «Verdadeiro» '
                                    END 
                         + '| ExibirAlertaPendBaixaAPartirDe : «' + RTRIM( ISNULL( CONVERT (CHAR, ExibirAlertaPendBaixaAPartirDe, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConcatenarLocalTrabalho IS NULL THEN ' ConcatenarLocalTrabalho : «Nulo» '
                                              WHEN  ConcatenarLocalTrabalho = 0 THEN ' ConcatenarLocalTrabalho : «Falso» '
                                              WHEN  ConcatenarLocalTrabalho = 1 THEN ' ConcatenarLocalTrabalho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NrInfObrigatorio IS NULL THEN ' NrInfObrigatorio : «Nulo» '
                                              WHEN  NrInfObrigatorio = 0 THEN ' NrInfObrigatorio : «Falso» '
                                              WHEN  NrInfObrigatorio = 1 THEN ' NrInfObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NrInfRecebeNrModeloAutoInf IS NULL THEN ' NrInfRecebeNrModeloAutoInf : «Nulo» '
                                              WHEN  NrInfRecebeNrModeloAutoInf = 0 THEN ' NrInfRecebeNrModeloAutoInf : «Falso» '
                                              WHEN  NrInfRecebeNrModeloAutoInf = 1 THEN ' NrInfRecebeNrModeloAutoInf : «Verdadeiro» '
                                    END 
                         + '| DataVerificacaoREN : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVerificacaoREN, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FormaImpressao IS NULL THEN ' FormaImpressao : «Nulo» '
                                              WHEN  FormaImpressao = 0 THEN ' FormaImpressao : «Falso» '
                                              WHEN  FormaImpressao = 1 THEN ' FormaImpressao : «Verdadeiro» '
                                    END 
                         + '| idPadraoEtapaProcInscricaoPF : «' + RTRIM( ISNULL( CAST (idPadraoEtapaProcInscricaoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idPadraoEtapaProcInscricaoPJ : «' + RTRIM( ISNULL( CAST (idPadraoEtapaProcInscricaoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TxtPreviaAcordoRen : «' + RTRIM( ISNULL( CAST (TxtPreviaAcordoRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebitoHonorariosAdv : «' + RTRIM( ISNULL( CAST (IdTipoDebitoHonorariosAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeVersoBoleto IS NULL THEN ' ImprimeVersoBoleto : «Nulo» '
                                              WHEN  ImprimeVersoBoleto = 0 THEN ' ImprimeVersoBoleto : «Falso» '
                                              WHEN  ImprimeVersoBoleto = 1 THEN ' ImprimeVersoBoleto : «Verdadeiro» '
                                    END 
                         + '| IdTipoDebitoFS : «' + RTRIM( ISNULL( CAST (IdTipoDebitoFS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal IS NULL THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Nulo» '
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal = 0 THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Falso» '
                                              WHEN  UtilizarVlrAtualizacaoComVlrPrincipal = 1 THEN ' UtilizarVlrAtualizacaoComVlrPrincipal : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNARemoverZeros IS NULL THEN ' CNARemoverZeros : «Nulo» '
                                              WHEN  CNARemoverZeros = 0 THEN ' CNARemoverZeros : «Falso» '
                                              WHEN  CNARemoverZeros = 1 THEN ' CNARemoverZeros : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NotCPFDuplicado IS NULL THEN ' NotCPFDuplicado : «Nulo» '
                                              WHEN  NotCPFDuplicado = 0 THEN ' NotCPFDuplicado : «Falso» '
                                              WHEN  NotCPFDuplicado = 1 THEN ' NotCPFDuplicado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DIV_SituacoesPFPJ IS NULL THEN ' DIV_SituacoesPFPJ : «Nulo» '
                                              WHEN  DIV_SituacoesPFPJ = 0 THEN ' DIV_SituacoesPFPJ : «Falso» '
                                              WHEN  DIV_SituacoesPFPJ = 1 THEN ' DIV_SituacoesPFPJ : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DIV_TiposInscricao IS NULL THEN ' DIV_TiposInscricao : «Nulo» '
                                              WHEN  DIV_TiposInscricao = 0 THEN ' DIV_TiposInscricao : «Falso» '
                                              WHEN  DIV_TiposInscricao = 1 THEN ' DIV_TiposInscricao : «Verdadeiro» '
                                    END 
                         + '| DataUltimaBaixaDadosSiscafWeb : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaBaixaDadosSiscafWeb, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraDataPedidoInscricao IS NULL THEN ' MostraDataPedidoInscricao : «Nulo» '
                                              WHEN  MostraDataPedidoInscricao = 0 THEN ' MostraDataPedidoInscricao : «Falso» '
                                              WHEN  MostraDataPedidoInscricao = 1 THEN ' MostraDataPedidoInscricao : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoAT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRCA : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailCopiaBoleto : «' + RTRIM( ISNULL( CAST (EmailCopiaBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InserirLogoNoReciboSiscafw IS NULL THEN ' InserirLogoNoReciboSiscafw : «Nulo» '
                                              WHEN  InserirLogoNoReciboSiscafw = 0 THEN ' InserirLogoNoReciboSiscafw : «Falso» '
                                              WHEN  InserirLogoNoReciboSiscafw = 1 THEN ' InserirLogoNoReciboSiscafw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarProcAtrasoDebitosDA IS NULL THEN ' UtilizarProcAtrasoDebitosDA : «Nulo» '
                                              WHEN  UtilizarProcAtrasoDebitosDA = 0 THEN ' UtilizarProcAtrasoDebitosDA : «Falso» '
                                              WHEN  UtilizarProcAtrasoDebitosDA = 1 THEN ' UtilizarProcAtrasoDebitosDA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarSelecaoUnicaTipoDef IS NULL THEN ' UtilizarSelecaoUnicaTipoDef : «Nulo» '
                                              WHEN  UtilizarSelecaoUnicaTipoDef = 0 THEN ' UtilizarSelecaoUnicaTipoDef : «Falso» '
                                              WHEN  UtilizarSelecaoUnicaTipoDef = 1 THEN ' UtilizarSelecaoUnicaTipoDef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirCadastroTipoDef IS NULL THEN ' PermitirCadastroTipoDef : «Nulo» '
                                              WHEN  PermitirCadastroTipoDef = 0 THEN ' PermitirCadastroTipoDef : «Falso» '
                                              WHEN  PermitirCadastroTipoDef = 1 THEN ' PermitirCadastroTipoDef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CfgSituacaoTpProcesso IS NULL THEN ' CfgSituacaoTpProcesso : «Nulo» '
                                              WHEN  CfgSituacaoTpProcesso = 0 THEN ' CfgSituacaoTpProcesso : «Falso» '
                                              WHEN  CfgSituacaoTpProcesso = 1 THEN ' CfgSituacaoTpProcesso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizarGravarImagem IS NULL THEN ' UtilizarGravarImagem : «Nulo» '
                                              WHEN  UtilizarGravarImagem = 0 THEN ' UtilizarGravarImagem : «Falso» '
                                              WHEN  UtilizarGravarImagem = 1 THEN ' UtilizarGravarImagem : «Verdadeiro» '
                                    END 
                         + '| ServidorDigitalizacao : «' + RTRIM( ISNULL( CAST (ServidorDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaseDigitalizacao : «' + RTRIM( ISNULL( CAST (BaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioBaseDigitalizacao : «' + RTRIM( ISNULL( CAST (UsuarioBaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaBaseDigitalizacao : «' + RTRIM( ISNULL( CAST (SenhaBaseDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaWindows IS NULL THEN ' AutenticaWindows : «Nulo» '
                                              WHEN  AutenticaWindows = 0 THEN ' AutenticaWindows : «Falso» '
                                              WHEN  AutenticaWindows = 1 THEN ' AutenticaWindows : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoRenRCA : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoVisto : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRenVisto : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoCertReg : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoCertReg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoDebParc : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoDebParc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoATPF : «' + RTRIM( ISNULL( CAST (IdAssuntoATPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoATPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoATPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRCAPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRCAPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRCAPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRCAPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenRCAPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenRCAPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenRCAPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenRCAPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoVistoPF : «' + RTRIM( ISNULL( CAST (IdAssuntoVistoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoVistoPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoVistoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenVistoPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenVistoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenVistoPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenVistoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoCertRegPF : «' + RTRIM( ISNULL( CAST (IdAssuntoCertRegPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoCertRegPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoCertRegPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoDebParcPF : «' + RTRIM( ISNULL( CAST (IdAssuntoDebParcPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoDebParcPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoDebParcPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumRCAInicial : «' + RTRIM( ISNULL( CAST (NumRCAInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoRCA IS NULL THEN ' TipoNumeracaoRCA : «Nulo» '
                                              WHEN  TipoNumeracaoRCA = 0 THEN ' TipoNumeracaoRCA : «Falso» '
                                              WHEN  TipoNumeracaoRCA = 1 THEN ' TipoNumeracaoRCA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeraDebitoAnoInscricao IS NULL THEN ' GeraDebitoAnoInscricao : «Nulo» '
                                              WHEN  GeraDebitoAnoInscricao = 0 THEN ' GeraDebitoAnoInscricao : «Falso» '
                                              WHEN  GeraDebitoAnoInscricao = 1 THEN ' GeraDebitoAnoInscricao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GeraDebitoPJPorRespTec IS NULL THEN ' GeraDebitoPJPorRespTec : «Nulo» '
                                              WHEN  GeraDebitoPJPorRespTec = 0 THEN ' GeraDebitoPJPorRespTec : «Falso» '
                                              WHEN  GeraDebitoPJPorRespTec = 1 THEN ' GeraDebitoPJPorRespTec : «Verdadeiro» '
                                    END 
                         + '| IdDebitoPJPorRespTec : «' + RTRIM( ISNULL( CAST (IdDebitoPJPorRespTec AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PriorizaTipoDebito IS NULL THEN ' PriorizaTipoDebito : «Nulo» '
                                              WHEN  PriorizaTipoDebito = 0 THEN ' PriorizaTipoDebito : «Falso» '
                                              WHEN  PriorizaTipoDebito = 1 THEN ' PriorizaTipoDebito : «Verdadeiro» '
                                    END 
                         + '| NumVistoInicial : «' + RTRIM( ISNULL( CAST (NumVistoInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoVisto IS NULL THEN ' TipoNumeracaoVisto : «Nulo» '
                                              WHEN  TipoNumeracaoVisto = 0 THEN ' TipoNumeracaoVisto : «Falso» '
                                              WHEN  TipoNumeracaoVisto = 1 THEN ' TipoNumeracaoVisto : «Verdadeiro» '
                                    END 
                         + '| AnoComSufixoRCA : «' + RTRIM( ISNULL( CAST (AnoComSufixoRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumeroRCA : «' + RTRIM( ISNULL( CAST (TamanhoNumeroRCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ResetNumRCA IS NULL THEN ' ResetNumRCA : «Nulo» '
                                              WHEN  ResetNumRCA = 0 THEN ' ResetNumRCA : «Falso» '
                                              WHEN  ResetNumRCA = 1 THEN ' ResetNumRCA : «Verdadeiro» '
                                    END 
                         + '| NumAFTInicial : «' + RTRIM( ISNULL( CAST (NumAFTInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TipoNumeracaoAFT IS NULL THEN ' TipoNumeracaoAFT : «Nulo» '
                                              WHEN  TipoNumeracaoAFT = 0 THEN ' TipoNumeracaoAFT : «Falso» '
                                              WHEN  TipoNumeracaoAFT = 1 THEN ' TipoNumeracaoAFT : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoAFT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAFT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoRenAFT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoRenAFT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoAFTPF : «' + RTRIM( ISNULL( CAST (IdAssuntoAFTPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoAFTPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoAFTPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenAFTPF : «' + RTRIM( ISNULL( CAST (IdAssuntoRenAFTPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssuntoRenAFTPJ : «' + RTRIM( ISNULL( CAST (IdAssuntoRenAFTPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraNumeroProcesso IS NULL THEN ' AlteraNumeroProcesso : «Nulo» '
                                              WHEN  AlteraNumeroProcesso = 0 THEN ' AlteraNumeroProcesso : «Falso» '
                                              WHEN  AlteraNumeroProcesso = 1 THEN ' AlteraNumeroProcesso : «Verdadeiro» '
                                    END 
                         + '| DirArqDNE_Correios : «' + RTRIM( ISNULL( CAST (DirArqDNE_Correios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoExibirOBSEnd IS NULL THEN ' NaoExibirOBSEnd : «Nulo» '
                                              WHEN  NaoExibirOBSEnd = 0 THEN ' NaoExibirOBSEnd : «Falso» '
                                              WHEN  NaoExibirOBSEnd = 1 THEN ' NaoExibirOBSEnd : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EditarLogradouro IS NULL THEN ' EditarLogradouro : «Nulo» '
                                              WHEN  EditarLogradouro = 0 THEN ' EditarLogradouro : «Falso» '
                                              WHEN  EditarLogradouro = 1 THEN ' EditarLogradouro : «Verdadeiro» '
                                    END 
                         + '| VersaoDNE : «' + RTRIM( ISNULL( CAST (VersaoDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DNE_Maiusculo IS NULL THEN ' DNE_Maiusculo : «Nulo» '
                                              WHEN  DNE_Maiusculo = 0 THEN ' DNE_Maiusculo : «Falso» '
                                              WHEN  DNE_Maiusculo = 1 THEN ' DNE_Maiusculo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirInfoExecucaoFiscalPF IS NULL THEN ' ExibirInfoExecucaoFiscalPF : «Nulo» '
                                              WHEN  ExibirInfoExecucaoFiscalPF = 0 THEN ' ExibirInfoExecucaoFiscalPF : «Falso» '
                                              WHEN  ExibirInfoExecucaoFiscalPF = 1 THEN ' ExibirInfoExecucaoFiscalPF : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaEmissaoSemRegistro IS NULL THEN ' UsaEmissaoSemRegistro : «Nulo» '
                                              WHEN  UsaEmissaoSemRegistro = 0 THEN ' UsaEmissaoSemRegistro : «Falso» '
                                              WHEN  UsaEmissaoSemRegistro = 1 THEN ' UsaEmissaoSemRegistro : «Verdadeiro» '
                                    END 
                         + '| Destinatario_Left : «' + RTRIM( ISNULL( CAST (Destinatario_Left AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destinatario_Top : «' + RTRIM( ISNULL( CAST (Destinatario_Top AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  HabilitarLayout3Guias IS NULL THEN ' HabilitarLayout3Guias : «Nulo» '
                                              WHEN  HabilitarLayout3Guias = 0 THEN ' HabilitarLayout3Guias : «Falso» '
                                              WHEN  HabilitarLayout3Guias = 1 THEN ' HabilitarLayout3Guias : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GerarCadaOpcDescUmaEmissao IS NULL THEN ' GerarCadaOpcDescUmaEmissao : «Nulo» '
                                              WHEN  GerarCadaOpcDescUmaEmissao = 0 THEN ' GerarCadaOpcDescUmaEmissao : «Falso» '
                                              WHEN  GerarCadaOpcDescUmaEmissao = 1 THEN ' GerarCadaOpcDescUmaEmissao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao IS NULL THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Nulo» '
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao = 0 THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Falso» '
                                              WHEN  PermitirEnderecoCorrespondenciaIgualANao = 1 THEN ' PermitirEnderecoCorrespondenciaIgualANao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirEndCorrespDesatualizado IS NULL THEN ' PermitirEndCorrespDesatualizado : «Nulo» '
                                              WHEN  PermitirEndCorrespDesatualizado = 0 THEN ' PermitirEndCorrespDesatualizado : «Falso» '
                                              WHEN  PermitirEndCorrespDesatualizado = 1 THEN ' PermitirEndCorrespDesatualizado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ObrigarEnderecoCorrespondencia IS NULL THEN ' ObrigarEnderecoCorrespondencia : «Nulo» '
                                              WHEN  ObrigarEnderecoCorrespondencia = 0 THEN ' ObrigarEnderecoCorrespondencia : «Falso» '
                                              WHEN  ObrigarEnderecoCorrespondencia = 1 THEN ' ObrigarEnderecoCorrespondencia : «Verdadeiro» '
                                    END 
                         + '| TempoTimeoutConexao : «' + RTRIM( ISNULL( CAST (TempoTimeoutConexao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoTimeoutConexaoMensagem : «' + RTRIM( ISNULL( CAST (TempoTimeoutConexaoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdParametrosSiscafw : «' + RTRIM( ISNULL( CAST (IdParametrosSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdFormaEntregaDocumento : «' + RTRIM( ISNULL( CAST (prec_IdFormaEntregaDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdNivelDocumento : «' + RTRIM( ISNULL( CAST (prec_IdNivelDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (prec_IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IdTipoDocumento : «' + RTRIM( ISNULL( CAST (prec_IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| prec_IndOrigemDoc : «' + RTRIM( ISNULL( CAST (prec_IndOrigemDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDebitoCertidoesPF : «' + RTRIM( ISNULL( CAST (TipoDebitoCertidoesPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDebitoCertidoesPJ : «' + RTRIM( ISNULL( CAST (TipoDebitoCertidoesPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiasDataVencimento : «' + RTRIM( ISNULL( CAST (DiasDataVencimento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
