CREATE TABLE [dbo].[ParametrosSiscafWeb] (
    [IdConfigWeb]                              INT            NOT NULL,
    [IdConselhoProprietario]                   INT            NULL,
    [PathLogo]                                 VARCHAR (200)  NULL,
    [FundoCor]                                 VARCHAR (10)   NULL,
    [FundoImg]                                 VARCHAR (200)  NULL,
    [LinkVoltar]                               VARCHAR (50)   NULL,
    [TamLetra]                                 TINYINT        NULL,
    [TipoLetra]                                VARCHAR (20)   NULL,
    [CorLetra]                                 VARCHAR (10)   NULL,
    [EstiloCSS]                                TINYINT        NULL,
    [NomeConselho]                             VARCHAR (200)  NULL,
    [IndMostraProf]                            BIT            NULL,
    [CompletaZero]                             INT            NULL,
    [FormaTrocaSenha]                          INT            NULL,
    [ConfigAtiva]                              BIT            NULL,
    [IdContaCorrente]                          INT            NULL,
    [SequencialNossoNumero]                    INT            NULL,
    [InicioNossoNum]                           INT            NULL,
    [FimNossoNum]                              INT            NULL,
    [DataUltimaSincronizacao]                  DATETIME       NULL,
    [TelaInicialPesquisa]                      INT            NULL,
    [ColunasCriterioPesquisaPF]                VARCHAR (500)  NULL,
    [ColunasCriterioPesquisaPJ]                VARCHAR (500)  NULL,
    [ComparaDados_CamposDisponiveis]           VARCHAR (500)  NULL,
    [ComparaDados_CamposSelecionados]          VARCHAR (500)  NULL,
    [txtTelaPesquisaCompleta]                  VARCHAR (300)  NULL,
    [ExibirEspecialidades]                     BIT            NULL,
    [MaxEspecialidedes]                        INT            NULL,
    [ExibirAreaAtuacao]                        BIT            NULL,
    [MaxAreaAtuacao]                           INT            NULL,
    [ExibirCurso_Nivel]                        BIT            NULL,
    [MaxCurso_Nivel]                           INT            NULL,
    [ResultadoPesquisa_Coluna1_PF]             VARCHAR (1000) NULL,
    [ResultadoPesquisa_Coluna2_PF]             VARCHAR (50)   NULL,
    [ResultadoPesquisa_Coluna3_PF]             VARCHAR (50)   NULL,
    [ResultadoPesquisa_Coluna4_PF]             VARCHAR (50)   NULL,
    [ResultadoPesquisa_Coluna1_PJ]             VARCHAR (1000) NULL,
    [ResultadoPesquisa_Coluna2_PJ]             VARCHAR (50)   NULL,
    [ResultadoPesquisa_Coluna3_PJ]             VARCHAR (50)   NULL,
    [ResultadoPesquisa_Coluna4_PJ]             VARCHAR (50)   NULL,
    [TpControleAcessoProfWeb]                  INT            NULL,
    [CamposComparacaoLoginPF]                  VARCHAR (300)  NULL,
    [CamposComparacaoLoginPJ]                  VARCHAR (300)  NULL,
    [MsgTelaLoginConselho]                     VARCHAR (300)  NULL,
    [MsgTelaLoginPF]                           VARCHAR (300)  NULL,
    [MsgTelaLoginPJ]                           VARCHAR (300)  NULL,
    [MsgTelaLoginDireto]                       VARCHAR (300)  NULL,
    [TpControleAcessoPF]                       INT            NULL,
    [TpControleAcessoPJ]                       INT            NULL,
    [txtRodapeTelaResultadoPesquisa_PF]        VARCHAR (135)  NULL,
    [txtRodapeTelaResultadoPesquisa_PJ]        VARCHAR (135)  NULL,
    [DesprezarCampoNuloLoginPf]                BIT            NULL,
    [QuantCampoNuloLoginPf]                    INT            NULL,
    [DesprezarCampoNuloLoginPj]                BIT            NULL,
    [QuantCampoNuloLoginPj]                    INT            NULL,
    [MsgPreInscProf]                           TEXT           NULL,
    [MsgPreInscPJ]                             TEXT           NULL,
    [MensagemPaginaInicial]                    TEXT           NULL,
    [siglaConselho]                            VARCHAR (10)   NULL,
    [DescontoVlrBoleto]                        MONEY          NULL,
    [AcrescimoVlrBoleto]                       MONEY          NULL,
    [RenegociarAnoCorrente]                    BIT            NULL,
    [RenegociarAnoCorrenteMenor]               INT            NULL,
    [QtdDiasRenInicio]                         INT            NULL,
    [Acrescimo]                                FLOAT (53)     NULL,
    [DespBancarias]                            FLOAT (53)     NULL,
    [DespAdv]                                  FLOAT (53)     NULL,
    [CampoValidacaoLoginPf]                    VARCHAR (50)   NULL,
    [CampoValidacaoLoginPj]                    VARCHAR (50)   NULL,
    [BBConvenioComercioEletronico]             VARCHAR (10)   NULL,
    [BBConvenioCobranca]                       VARCHAR (10)   NULL,
    [BBRefTran]                                INT            NOT NULL,
    [linkPF1]                                  VARCHAR (200)  NULL,
    [TextolinkPF1]                             VARCHAR (50)   NULL,
    [linkPF2]                                  VARCHAR (200)  NULL,
    [TextolinkPF2]                             VARCHAR (50)   NULL,
    [linkPF3]                                  VARCHAR (200)  NULL,
    [TextolinkPF3]                             VARCHAR (50)   NULL,
    [linkPJ1]                                  VARCHAR (200)  NULL,
    [TextolinkPJ1]                             VARCHAR (50)   NULL,
    [linkPJ2]                                  VARCHAR (200)  NULL,
    [TextolinkPJ2]                             VARCHAR (50)   NULL,
    [linkPJ3]                                  VARCHAR (200)  NULL,
    [TextolinkPJ3]                             VARCHAR (50)   NULL,
    [BloquearRenDA_PF]                         BIT            NULL,
    [BloquearRenDA_PJ]                         BIT            NULL,
    [MsgBloqueioRenDA_PF]                      VARCHAR (1000) NULL,
    [MsgBloqueioRenDA_PJ]                      VARCHAR (1000) NULL,
    [MsgParaRegistroConselho]                  VARCHAR (200)  NULL,
    [MsgParaRegistroConselhoPJ]                VARCHAR (200)  NULL,
    [UtilizarEnderecoTrabalho]                 BIT            NULL,
    [Email]                                    VARCHAR (150)  NULL,
    [ExibirDebitosPagos]                       BIT            NULL,
    [txtTelaPesquisaPersonalizada]             VARCHAR (5000) NULL,
    [SequencialNumeroDocumento]                BIGINT         NULL,
    [BBPagamentoEletronico]                    BIGINT         NULL,
    [CompararCPF_CNPJ]                         BIT            NULL,
    [TiposDebitoRenegociacao]                  VARCHAR (1000) NULL,
    [MsgCamposComparacaoLoginPF]               VARCHAR (400)  NULL,
    [DesprezarZeroEsquerdaRegPf]               BIT            DEFAULT ((0)) NOT NULL,
    [DesprezarZeroEsquerdaRegPj]               BIT            DEFAULT ((0)) NOT NULL,
    [visualizarDocumentos]                     BIT            DEFAULT ((0)) NOT NULL,
    [DescontoRenegociacao]                     FLOAT (53)     DEFAULT ((0)) NOT NULL,
    [AplicarDescontoSobreValorDivida]          BIT            DEFAULT ((0)) NOT NULL,
    [NaoCobrarEncargosSobreParcelaInicial]     BIT            DEFAULT ((0)) NOT NULL,
    [LimiteDataRenegociacaoMesCorrente]        BIT            DEFAULT ((0)) NOT NULL,
    [PathComercioEletronico]                   VARCHAR (50)   NULL,
    [bloquearDebitosDividaAtivaAdministrativa] BIT            DEFAULT ((0)) NOT NULL,
    [BloquearDebitosDividaAtivaExecutiva]      BIT            DEFAULT ((0)) NOT NULL,
    [RenegociarDebitosVencer]                  BIT            DEFAULT ((0)) NOT NULL,
    [DocumentoDigitalART]                      BIT            DEFAULT ((0)) NOT NULL,
    [ExibeDadosPJValidadeCertidoes]            BIT            DEFAULT ((0)) NOT NULL,
    [InstrucoesExperienciaProfissional]        VARCHAR (2000) NULL,
    [CompararCampo5]                           INT            NULL,
    [CompararCampo6]                           INT            NULL,
    [CompararDataNac]                          INT            NULL,
    [CompararNomeMae]                          INT            NULL,
    [CompararRegistro]                         INT            NULL,
    [FuncoesDisponiveisPJ]                     INT            NULL,
    [FuncoesDisponiveisrPF]                    INT            NULL,
    [DocumentosSisdocWEB]                      BIT            NULL,
    [MsgCertidaoInexistente]                   VARCHAR (2000) NULL,
    [SituacaoAtualBloqueioLogin]               VARCHAR (2000) NULL,
    [MensagemSituacaoAtualBloqueioLogin]       VARCHAR (2000) NULL,
    [BloquearDebitosProtestados]               BIT            DEFAULT ((0)) NOT NULL,
    [TipoParcelamentoRenegociacao]             VARCHAR (2000) CONSTRAINT [DF_ParametrosSiscafWeb_TipoParcelamentoRenegociacao] DEFAULT ('JSP') NULL
);


GO
CREATE TRIGGER [TrgLog_ParametrosSiscafWeb] ON [Implanta_CRPAM].[dbo].[ParametrosSiscafWeb] 
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
SET @TableName = 'ParametrosSiscafWeb'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigWeb : «' + RTRIM( ISNULL( CAST (IdConfigWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselhoProprietario : «' + RTRIM( ISNULL( CAST (IdConselhoProprietario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathLogo : «' + RTRIM( ISNULL( CAST (PathLogo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FundoCor : «' + RTRIM( ISNULL( CAST (FundoCor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FundoImg : «' + RTRIM( ISNULL( CAST (FundoImg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinkVoltar : «' + RTRIM( ISNULL( CAST (LinkVoltar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamLetra : «' + RTRIM( ISNULL( CAST (TamLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLetra : «' + RTRIM( ISNULL( CAST (TipoLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorLetra : «' + RTRIM( ISNULL( CAST (CorLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstiloCSS : «' + RTRIM( ISNULL( CAST (EstiloCSS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConselho : «' + RTRIM( ISNULL( CAST (NomeConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndMostraProf IS NULL THEN ' IndMostraProf : «Nulo» '
                                              WHEN  IndMostraProf = 0 THEN ' IndMostraProf : «Falso» '
                                              WHEN  IndMostraProf = 1 THEN ' IndMostraProf : «Verdadeiro» '
                                    END 
                         + '| CompletaZero : «' + RTRIM( ISNULL( CAST (CompletaZero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaTrocaSenha : «' + RTRIM( ISNULL( CAST (FormaTrocaSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigAtiva IS NULL THEN ' ConfigAtiva : «Nulo» '
                                              WHEN  ConfigAtiva = 0 THEN ' ConfigAtiva : «Falso» '
                                              WHEN  ConfigAtiva = 1 THEN ' ConfigAtiva : «Verdadeiro» '
                                    END 
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNum : «' + RTRIM( ISNULL( CAST (InicioNossoNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNum : «' + RTRIM( ISNULL( CAST (FimNossoNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaSincronizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaSincronizacao, 113 ),'Nulo'))+'» '
                         + '| TelaInicialPesquisa : «' + RTRIM( ISNULL( CAST (TelaInicialPesquisa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ColunasCriterioPesquisaPF : «' + RTRIM( ISNULL( CAST (ColunasCriterioPesquisaPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ColunasCriterioPesquisaPJ : «' + RTRIM( ISNULL( CAST (ColunasCriterioPesquisaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComparaDados_CamposDisponiveis : «' + RTRIM( ISNULL( CAST (ComparaDados_CamposDisponiveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComparaDados_CamposSelecionados : «' + RTRIM( ISNULL( CAST (ComparaDados_CamposSelecionados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtTelaPesquisaCompleta : «' + RTRIM( ISNULL( CAST (txtTelaPesquisaCompleta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirEspecialidades IS NULL THEN ' ExibirEspecialidades : «Nulo» '
                                              WHEN  ExibirEspecialidades = 0 THEN ' ExibirEspecialidades : «Falso» '
                                              WHEN  ExibirEspecialidades = 1 THEN ' ExibirEspecialidades : «Verdadeiro» '
                                    END 
                         + '| MaxEspecialidedes : «' + RTRIM( ISNULL( CAST (MaxEspecialidedes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirAreaAtuacao IS NULL THEN ' ExibirAreaAtuacao : «Nulo» '
                                              WHEN  ExibirAreaAtuacao = 0 THEN ' ExibirAreaAtuacao : «Falso» '
                                              WHEN  ExibirAreaAtuacao = 1 THEN ' ExibirAreaAtuacao : «Verdadeiro» '
                                    END 
                         + '| MaxAreaAtuacao : «' + RTRIM( ISNULL( CAST (MaxAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirCurso_Nivel IS NULL THEN ' ExibirCurso_Nivel : «Nulo» '
                                              WHEN  ExibirCurso_Nivel = 0 THEN ' ExibirCurso_Nivel : «Falso» '
                                              WHEN  ExibirCurso_Nivel = 1 THEN ' ExibirCurso_Nivel : «Verdadeiro» '
                                    END 
                         + '| MaxCurso_Nivel : «' + RTRIM( ISNULL( CAST (MaxCurso_Nivel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna1_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna1_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna2_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna2_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna3_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna3_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna4_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna4_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna1_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna1_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna2_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna2_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna3_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna3_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna4_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna4_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoProfWeb : «' + RTRIM( ISNULL( CAST (TpControleAcessoProfWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CamposComparacaoLoginPF : «' + RTRIM( ISNULL( CAST (CamposComparacaoLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CamposComparacaoLoginPJ : «' + RTRIM( ISNULL( CAST (CamposComparacaoLoginPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginConselho : «' + RTRIM( ISNULL( CAST (MsgTelaLoginConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginPF : «' + RTRIM( ISNULL( CAST (MsgTelaLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginPJ : «' + RTRIM( ISNULL( CAST (MsgTelaLoginPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginDireto : «' + RTRIM( ISNULL( CAST (MsgTelaLoginDireto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoPF : «' + RTRIM( ISNULL( CAST (TpControleAcessoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoPJ : «' + RTRIM( ISNULL( CAST (TpControleAcessoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtRodapeTelaResultadoPesquisa_PF : «' + RTRIM( ISNULL( CAST (txtRodapeTelaResultadoPesquisa_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtRodapeTelaResultadoPesquisa_PJ : «' + RTRIM( ISNULL( CAST (txtRodapeTelaResultadoPesquisa_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarCampoNuloLoginPf IS NULL THEN ' DesprezarCampoNuloLoginPf : «Nulo» '
                                              WHEN  DesprezarCampoNuloLoginPf = 0 THEN ' DesprezarCampoNuloLoginPf : «Falso» '
                                              WHEN  DesprezarCampoNuloLoginPf = 1 THEN ' DesprezarCampoNuloLoginPf : «Verdadeiro» '
                                    END 
                         + '| QuantCampoNuloLoginPf : «' + RTRIM( ISNULL( CAST (QuantCampoNuloLoginPf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarCampoNuloLoginPj IS NULL THEN ' DesprezarCampoNuloLoginPj : «Nulo» '
                                              WHEN  DesprezarCampoNuloLoginPj = 0 THEN ' DesprezarCampoNuloLoginPj : «Falso» '
                                              WHEN  DesprezarCampoNuloLoginPj = 1 THEN ' DesprezarCampoNuloLoginPj : «Verdadeiro» '
                                    END 
                         + '| QuantCampoNuloLoginPj : «' + RTRIM( ISNULL( CAST (QuantCampoNuloLoginPj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglaConselho : «' + RTRIM( ISNULL( CAST (siglaConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoVlrBoleto : «' + RTRIM( ISNULL( CAST (DescontoVlrBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcrescimoVlrBoleto : «' + RTRIM( ISNULL( CAST (AcrescimoVlrBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RenegociarAnoCorrente IS NULL THEN ' RenegociarAnoCorrente : «Nulo» '
                                              WHEN  RenegociarAnoCorrente = 0 THEN ' RenegociarAnoCorrente : «Falso» '
                                              WHEN  RenegociarAnoCorrente = 1 THEN ' RenegociarAnoCorrente : «Verdadeiro» '
                                    END 
                         + '| RenegociarAnoCorrenteMenor : «' + RTRIM( ISNULL( CAST (RenegociarAnoCorrenteMenor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasRenInicio : «' + RTRIM( ISNULL( CAST (QtdDiasRenInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Acrescimo : «' + RTRIM( ISNULL( CAST (Acrescimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DespBancarias : «' + RTRIM( ISNULL( CAST (DespBancarias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DespAdv : «' + RTRIM( ISNULL( CAST (DespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoValidacaoLoginPf : «' + RTRIM( ISNULL( CAST (CampoValidacaoLoginPf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoValidacaoLoginPj : «' + RTRIM( ISNULL( CAST (CampoValidacaoLoginPj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBConvenioComercioEletronico : «' + RTRIM( ISNULL( CAST (BBConvenioComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBConvenioCobranca : «' + RTRIM( ISNULL( CAST (BBConvenioCobranca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBRefTran : «' + RTRIM( ISNULL( CAST (BBRefTran AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF1 : «' + RTRIM( ISNULL( CAST (linkPF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF1 : «' + RTRIM( ISNULL( CAST (TextolinkPF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF2 : «' + RTRIM( ISNULL( CAST (linkPF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF2 : «' + RTRIM( ISNULL( CAST (TextolinkPF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF3 : «' + RTRIM( ISNULL( CAST (linkPF3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF3 : «' + RTRIM( ISNULL( CAST (TextolinkPF3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ1 : «' + RTRIM( ISNULL( CAST (linkPJ1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ1 : «' + RTRIM( ISNULL( CAST (TextolinkPJ1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ2 : «' + RTRIM( ISNULL( CAST (linkPJ2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ2 : «' + RTRIM( ISNULL( CAST (TextolinkPJ2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ3 : «' + RTRIM( ISNULL( CAST (linkPJ3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ3 : «' + RTRIM( ISNULL( CAST (TextolinkPJ3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquearRenDA_PF IS NULL THEN ' BloquearRenDA_PF : «Nulo» '
                                              WHEN  BloquearRenDA_PF = 0 THEN ' BloquearRenDA_PF : «Falso» '
                                              WHEN  BloquearRenDA_PF = 1 THEN ' BloquearRenDA_PF : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearRenDA_PJ IS NULL THEN ' BloquearRenDA_PJ : «Nulo» '
                                              WHEN  BloquearRenDA_PJ = 0 THEN ' BloquearRenDA_PJ : «Falso» '
                                              WHEN  BloquearRenDA_PJ = 1 THEN ' BloquearRenDA_PJ : «Verdadeiro» '
                                    END 
                         + '| MsgBloqueioRenDA_PF : «' + RTRIM( ISNULL( CAST (MsgBloqueioRenDA_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgBloqueioRenDA_PJ : «' + RTRIM( ISNULL( CAST (MsgBloqueioRenDA_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgParaRegistroConselho : «' + RTRIM( ISNULL( CAST (MsgParaRegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgParaRegistroConselhoPJ : «' + RTRIM( ISNULL( CAST (MsgParaRegistroConselhoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarEnderecoTrabalho IS NULL THEN ' UtilizarEnderecoTrabalho : «Nulo» '
                                              WHEN  UtilizarEnderecoTrabalho = 0 THEN ' UtilizarEnderecoTrabalho : «Falso» '
                                              WHEN  UtilizarEnderecoTrabalho = 1 THEN ' UtilizarEnderecoTrabalho : «Verdadeiro» '
                                    END 
                         + '| Email : «' + RTRIM( ISNULL( CAST (Email AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirDebitosPagos IS NULL THEN ' ExibirDebitosPagos : «Nulo» '
                                              WHEN  ExibirDebitosPagos = 0 THEN ' ExibirDebitosPagos : «Falso» '
                                              WHEN  ExibirDebitosPagos = 1 THEN ' ExibirDebitosPagos : «Verdadeiro» '
                                    END 
                         + '| txtTelaPesquisaPersonalizada : «' + RTRIM( ISNULL( CAST (txtTelaPesquisaPersonalizada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNumeroDocumento : «' + RTRIM( ISNULL( CAST (SequencialNumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBPagamentoEletronico : «' + RTRIM( ISNULL( CAST (BBPagamentoEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CompararCPF_CNPJ IS NULL THEN ' CompararCPF_CNPJ : «Nulo» '
                                              WHEN  CompararCPF_CNPJ = 0 THEN ' CompararCPF_CNPJ : «Falso» '
                                              WHEN  CompararCPF_CNPJ = 1 THEN ' CompararCPF_CNPJ : «Verdadeiro» '
                                    END 
                         + '| TiposDebitoRenegociacao : «' + RTRIM( ISNULL( CAST (TiposDebitoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgCamposComparacaoLoginPF : «' + RTRIM( ISNULL( CAST (MsgCamposComparacaoLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarZeroEsquerdaRegPf IS NULL THEN ' DesprezarZeroEsquerdaRegPf : «Nulo» '
                                              WHEN  DesprezarZeroEsquerdaRegPf = 0 THEN ' DesprezarZeroEsquerdaRegPf : «Falso» '
                                              WHEN  DesprezarZeroEsquerdaRegPf = 1 THEN ' DesprezarZeroEsquerdaRegPf : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DesprezarZeroEsquerdaRegPj IS NULL THEN ' DesprezarZeroEsquerdaRegPj : «Nulo» '
                                              WHEN  DesprezarZeroEsquerdaRegPj = 0 THEN ' DesprezarZeroEsquerdaRegPj : «Falso» '
                                              WHEN  DesprezarZeroEsquerdaRegPj = 1 THEN ' DesprezarZeroEsquerdaRegPj : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  visualizarDocumentos IS NULL THEN ' visualizarDocumentos : «Nulo» '
                                              WHEN  visualizarDocumentos = 0 THEN ' visualizarDocumentos : «Falso» '
                                              WHEN  visualizarDocumentos = 1 THEN ' visualizarDocumentos : «Verdadeiro» '
                                    END 
                         + '| DescontoRenegociacao : «' + RTRIM( ISNULL( CAST (DescontoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarDescontoSobreValorDivida IS NULL THEN ' AplicarDescontoSobreValorDivida : «Nulo» '
                                              WHEN  AplicarDescontoSobreValorDivida = 0 THEN ' AplicarDescontoSobreValorDivida : «Falso» '
                                              WHEN  AplicarDescontoSobreValorDivida = 1 THEN ' AplicarDescontoSobreValorDivida : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial IS NULL THEN ' NaoCobrarEncargosSobreParcelaInicial : «Nulo» '
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial = 0 THEN ' NaoCobrarEncargosSobreParcelaInicial : «Falso» '
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial = 1 THEN ' NaoCobrarEncargosSobreParcelaInicial : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LimiteDataRenegociacaoMesCorrente IS NULL THEN ' LimiteDataRenegociacaoMesCorrente : «Nulo» '
                                              WHEN  LimiteDataRenegociacaoMesCorrente = 0 THEN ' LimiteDataRenegociacaoMesCorrente : «Falso» '
                                              WHEN  LimiteDataRenegociacaoMesCorrente = 1 THEN ' LimiteDataRenegociacaoMesCorrente : «Verdadeiro» '
                                    END 
                         + '| PathComercioEletronico : «' + RTRIM( ISNULL( CAST (PathComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa IS NULL THEN ' bloquearDebitosDividaAtivaAdministrativa : «Nulo» '
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa = 0 THEN ' bloquearDebitosDividaAtivaAdministrativa : «Falso» '
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa = 1 THEN ' bloquearDebitosDividaAtivaAdministrativa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearDebitosDividaAtivaExecutiva IS NULL THEN ' BloquearDebitosDividaAtivaExecutiva : «Nulo» '
                                              WHEN  BloquearDebitosDividaAtivaExecutiva = 0 THEN ' BloquearDebitosDividaAtivaExecutiva : «Falso» '
                                              WHEN  BloquearDebitosDividaAtivaExecutiva = 1 THEN ' BloquearDebitosDividaAtivaExecutiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociarDebitosVencer IS NULL THEN ' RenegociarDebitosVencer : «Nulo» '
                                              WHEN  RenegociarDebitosVencer = 0 THEN ' RenegociarDebitosVencer : «Falso» '
                                              WHEN  RenegociarDebitosVencer = 1 THEN ' RenegociarDebitosVencer : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DocumentoDigitalART IS NULL THEN ' DocumentoDigitalART : «Nulo» '
                                              WHEN  DocumentoDigitalART = 0 THEN ' DocumentoDigitalART : «Falso» '
                                              WHEN  DocumentoDigitalART = 1 THEN ' DocumentoDigitalART : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeDadosPJValidadeCertidoes IS NULL THEN ' ExibeDadosPJValidadeCertidoes : «Nulo» '
                                              WHEN  ExibeDadosPJValidadeCertidoes = 0 THEN ' ExibeDadosPJValidadeCertidoes : «Falso» '
                                              WHEN  ExibeDadosPJValidadeCertidoes = 1 THEN ' ExibeDadosPJValidadeCertidoes : «Verdadeiro» '
                                    END 
                         + '| InstrucoesExperienciaProfissional : «' + RTRIM( ISNULL( CAST (InstrucoesExperienciaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararCampo5 : «' + RTRIM( ISNULL( CAST (CompararCampo5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararCampo6 : «' + RTRIM( ISNULL( CAST (CompararCampo6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararDataNac : «' + RTRIM( ISNULL( CAST (CompararDataNac AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararNomeMae : «' + RTRIM( ISNULL( CAST (CompararNomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararRegistro : «' + RTRIM( ISNULL( CAST (CompararRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FuncoesDisponiveisPJ : «' + RTRIM( ISNULL( CAST (FuncoesDisponiveisPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FuncoesDisponiveisrPF : «' + RTRIM( ISNULL( CAST (FuncoesDisponiveisrPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DocumentosSisdocWEB IS NULL THEN ' DocumentosSisdocWEB : «Nulo» '
                                              WHEN  DocumentosSisdocWEB = 0 THEN ' DocumentosSisdocWEB : «Falso» '
                                              WHEN  DocumentosSisdocWEB = 1 THEN ' DocumentosSisdocWEB : «Verdadeiro» '
                                    END 
                         + '| MsgCertidaoInexistente : «' + RTRIM( ISNULL( CAST (MsgCertidaoInexistente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoAtualBloqueioLogin : «' + RTRIM( ISNULL( CAST (SituacaoAtualBloqueioLogin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MensagemSituacaoAtualBloqueioLogin : «' + RTRIM( ISNULL( CAST (MensagemSituacaoAtualBloqueioLogin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquearDebitosProtestados IS NULL THEN ' BloquearDebitosProtestados : «Nulo» '
                                              WHEN  BloquearDebitosProtestados = 0 THEN ' BloquearDebitosProtestados : «Falso» '
                                              WHEN  BloquearDebitosProtestados = 1 THEN ' BloquearDebitosProtestados : «Verdadeiro» '
                                    END 
                         + '| TipoParcelamentoRenegociacao : «' + RTRIM( ISNULL( CAST (TipoParcelamentoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigWeb : «' + RTRIM( ISNULL( CAST (IdConfigWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselhoProprietario : «' + RTRIM( ISNULL( CAST (IdConselhoProprietario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathLogo : «' + RTRIM( ISNULL( CAST (PathLogo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FundoCor : «' + RTRIM( ISNULL( CAST (FundoCor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FundoImg : «' + RTRIM( ISNULL( CAST (FundoImg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinkVoltar : «' + RTRIM( ISNULL( CAST (LinkVoltar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamLetra : «' + RTRIM( ISNULL( CAST (TamLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLetra : «' + RTRIM( ISNULL( CAST (TipoLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorLetra : «' + RTRIM( ISNULL( CAST (CorLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstiloCSS : «' + RTRIM( ISNULL( CAST (EstiloCSS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConselho : «' + RTRIM( ISNULL( CAST (NomeConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndMostraProf IS NULL THEN ' IndMostraProf : «Nulo» '
                                              WHEN  IndMostraProf = 0 THEN ' IndMostraProf : «Falso» '
                                              WHEN  IndMostraProf = 1 THEN ' IndMostraProf : «Verdadeiro» '
                                    END 
                         + '| CompletaZero : «' + RTRIM( ISNULL( CAST (CompletaZero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaTrocaSenha : «' + RTRIM( ISNULL( CAST (FormaTrocaSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigAtiva IS NULL THEN ' ConfigAtiva : «Nulo» '
                                              WHEN  ConfigAtiva = 0 THEN ' ConfigAtiva : «Falso» '
                                              WHEN  ConfigAtiva = 1 THEN ' ConfigAtiva : «Verdadeiro» '
                                    END 
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNum : «' + RTRIM( ISNULL( CAST (InicioNossoNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNum : «' + RTRIM( ISNULL( CAST (FimNossoNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaSincronizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaSincronizacao, 113 ),'Nulo'))+'» '
                         + '| TelaInicialPesquisa : «' + RTRIM( ISNULL( CAST (TelaInicialPesquisa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ColunasCriterioPesquisaPF : «' + RTRIM( ISNULL( CAST (ColunasCriterioPesquisaPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ColunasCriterioPesquisaPJ : «' + RTRIM( ISNULL( CAST (ColunasCriterioPesquisaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComparaDados_CamposDisponiveis : «' + RTRIM( ISNULL( CAST (ComparaDados_CamposDisponiveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComparaDados_CamposSelecionados : «' + RTRIM( ISNULL( CAST (ComparaDados_CamposSelecionados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtTelaPesquisaCompleta : «' + RTRIM( ISNULL( CAST (txtTelaPesquisaCompleta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirEspecialidades IS NULL THEN ' ExibirEspecialidades : «Nulo» '
                                              WHEN  ExibirEspecialidades = 0 THEN ' ExibirEspecialidades : «Falso» '
                                              WHEN  ExibirEspecialidades = 1 THEN ' ExibirEspecialidades : «Verdadeiro» '
                                    END 
                         + '| MaxEspecialidedes : «' + RTRIM( ISNULL( CAST (MaxEspecialidedes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirAreaAtuacao IS NULL THEN ' ExibirAreaAtuacao : «Nulo» '
                                              WHEN  ExibirAreaAtuacao = 0 THEN ' ExibirAreaAtuacao : «Falso» '
                                              WHEN  ExibirAreaAtuacao = 1 THEN ' ExibirAreaAtuacao : «Verdadeiro» '
                                    END 
                         + '| MaxAreaAtuacao : «' + RTRIM( ISNULL( CAST (MaxAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirCurso_Nivel IS NULL THEN ' ExibirCurso_Nivel : «Nulo» '
                                              WHEN  ExibirCurso_Nivel = 0 THEN ' ExibirCurso_Nivel : «Falso» '
                                              WHEN  ExibirCurso_Nivel = 1 THEN ' ExibirCurso_Nivel : «Verdadeiro» '
                                    END 
                         + '| MaxCurso_Nivel : «' + RTRIM( ISNULL( CAST (MaxCurso_Nivel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna1_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna1_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna2_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna2_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna3_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna3_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna4_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna4_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna1_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna1_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna2_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna2_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna3_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna3_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna4_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna4_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoProfWeb : «' + RTRIM( ISNULL( CAST (TpControleAcessoProfWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CamposComparacaoLoginPF : «' + RTRIM( ISNULL( CAST (CamposComparacaoLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CamposComparacaoLoginPJ : «' + RTRIM( ISNULL( CAST (CamposComparacaoLoginPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginConselho : «' + RTRIM( ISNULL( CAST (MsgTelaLoginConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginPF : «' + RTRIM( ISNULL( CAST (MsgTelaLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginPJ : «' + RTRIM( ISNULL( CAST (MsgTelaLoginPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginDireto : «' + RTRIM( ISNULL( CAST (MsgTelaLoginDireto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoPF : «' + RTRIM( ISNULL( CAST (TpControleAcessoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoPJ : «' + RTRIM( ISNULL( CAST (TpControleAcessoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtRodapeTelaResultadoPesquisa_PF : «' + RTRIM( ISNULL( CAST (txtRodapeTelaResultadoPesquisa_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtRodapeTelaResultadoPesquisa_PJ : «' + RTRIM( ISNULL( CAST (txtRodapeTelaResultadoPesquisa_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarCampoNuloLoginPf IS NULL THEN ' DesprezarCampoNuloLoginPf : «Nulo» '
                                              WHEN  DesprezarCampoNuloLoginPf = 0 THEN ' DesprezarCampoNuloLoginPf : «Falso» '
                                              WHEN  DesprezarCampoNuloLoginPf = 1 THEN ' DesprezarCampoNuloLoginPf : «Verdadeiro» '
                                    END 
                         + '| QuantCampoNuloLoginPf : «' + RTRIM( ISNULL( CAST (QuantCampoNuloLoginPf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarCampoNuloLoginPj IS NULL THEN ' DesprezarCampoNuloLoginPj : «Nulo» '
                                              WHEN  DesprezarCampoNuloLoginPj = 0 THEN ' DesprezarCampoNuloLoginPj : «Falso» '
                                              WHEN  DesprezarCampoNuloLoginPj = 1 THEN ' DesprezarCampoNuloLoginPj : «Verdadeiro» '
                                    END 
                         + '| QuantCampoNuloLoginPj : «' + RTRIM( ISNULL( CAST (QuantCampoNuloLoginPj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglaConselho : «' + RTRIM( ISNULL( CAST (siglaConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoVlrBoleto : «' + RTRIM( ISNULL( CAST (DescontoVlrBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcrescimoVlrBoleto : «' + RTRIM( ISNULL( CAST (AcrescimoVlrBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RenegociarAnoCorrente IS NULL THEN ' RenegociarAnoCorrente : «Nulo» '
                                              WHEN  RenegociarAnoCorrente = 0 THEN ' RenegociarAnoCorrente : «Falso» '
                                              WHEN  RenegociarAnoCorrente = 1 THEN ' RenegociarAnoCorrente : «Verdadeiro» '
                                    END 
                         + '| RenegociarAnoCorrenteMenor : «' + RTRIM( ISNULL( CAST (RenegociarAnoCorrenteMenor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasRenInicio : «' + RTRIM( ISNULL( CAST (QtdDiasRenInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Acrescimo : «' + RTRIM( ISNULL( CAST (Acrescimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DespBancarias : «' + RTRIM( ISNULL( CAST (DespBancarias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DespAdv : «' + RTRIM( ISNULL( CAST (DespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoValidacaoLoginPf : «' + RTRIM( ISNULL( CAST (CampoValidacaoLoginPf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoValidacaoLoginPj : «' + RTRIM( ISNULL( CAST (CampoValidacaoLoginPj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBConvenioComercioEletronico : «' + RTRIM( ISNULL( CAST (BBConvenioComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBConvenioCobranca : «' + RTRIM( ISNULL( CAST (BBConvenioCobranca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBRefTran : «' + RTRIM( ISNULL( CAST (BBRefTran AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF1 : «' + RTRIM( ISNULL( CAST (linkPF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF1 : «' + RTRIM( ISNULL( CAST (TextolinkPF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF2 : «' + RTRIM( ISNULL( CAST (linkPF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF2 : «' + RTRIM( ISNULL( CAST (TextolinkPF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF3 : «' + RTRIM( ISNULL( CAST (linkPF3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF3 : «' + RTRIM( ISNULL( CAST (TextolinkPF3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ1 : «' + RTRIM( ISNULL( CAST (linkPJ1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ1 : «' + RTRIM( ISNULL( CAST (TextolinkPJ1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ2 : «' + RTRIM( ISNULL( CAST (linkPJ2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ2 : «' + RTRIM( ISNULL( CAST (TextolinkPJ2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ3 : «' + RTRIM( ISNULL( CAST (linkPJ3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ3 : «' + RTRIM( ISNULL( CAST (TextolinkPJ3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquearRenDA_PF IS NULL THEN ' BloquearRenDA_PF : «Nulo» '
                                              WHEN  BloquearRenDA_PF = 0 THEN ' BloquearRenDA_PF : «Falso» '
                                              WHEN  BloquearRenDA_PF = 1 THEN ' BloquearRenDA_PF : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearRenDA_PJ IS NULL THEN ' BloquearRenDA_PJ : «Nulo» '
                                              WHEN  BloquearRenDA_PJ = 0 THEN ' BloquearRenDA_PJ : «Falso» '
                                              WHEN  BloquearRenDA_PJ = 1 THEN ' BloquearRenDA_PJ : «Verdadeiro» '
                                    END 
                         + '| MsgBloqueioRenDA_PF : «' + RTRIM( ISNULL( CAST (MsgBloqueioRenDA_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgBloqueioRenDA_PJ : «' + RTRIM( ISNULL( CAST (MsgBloqueioRenDA_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgParaRegistroConselho : «' + RTRIM( ISNULL( CAST (MsgParaRegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgParaRegistroConselhoPJ : «' + RTRIM( ISNULL( CAST (MsgParaRegistroConselhoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarEnderecoTrabalho IS NULL THEN ' UtilizarEnderecoTrabalho : «Nulo» '
                                              WHEN  UtilizarEnderecoTrabalho = 0 THEN ' UtilizarEnderecoTrabalho : «Falso» '
                                              WHEN  UtilizarEnderecoTrabalho = 1 THEN ' UtilizarEnderecoTrabalho : «Verdadeiro» '
                                    END 
                         + '| Email : «' + RTRIM( ISNULL( CAST (Email AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirDebitosPagos IS NULL THEN ' ExibirDebitosPagos : «Nulo» '
                                              WHEN  ExibirDebitosPagos = 0 THEN ' ExibirDebitosPagos : «Falso» '
                                              WHEN  ExibirDebitosPagos = 1 THEN ' ExibirDebitosPagos : «Verdadeiro» '
                                    END 
                         + '| txtTelaPesquisaPersonalizada : «' + RTRIM( ISNULL( CAST (txtTelaPesquisaPersonalizada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNumeroDocumento : «' + RTRIM( ISNULL( CAST (SequencialNumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBPagamentoEletronico : «' + RTRIM( ISNULL( CAST (BBPagamentoEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CompararCPF_CNPJ IS NULL THEN ' CompararCPF_CNPJ : «Nulo» '
                                              WHEN  CompararCPF_CNPJ = 0 THEN ' CompararCPF_CNPJ : «Falso» '
                                              WHEN  CompararCPF_CNPJ = 1 THEN ' CompararCPF_CNPJ : «Verdadeiro» '
                                    END 
                         + '| TiposDebitoRenegociacao : «' + RTRIM( ISNULL( CAST (TiposDebitoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgCamposComparacaoLoginPF : «' + RTRIM( ISNULL( CAST (MsgCamposComparacaoLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarZeroEsquerdaRegPf IS NULL THEN ' DesprezarZeroEsquerdaRegPf : «Nulo» '
                                              WHEN  DesprezarZeroEsquerdaRegPf = 0 THEN ' DesprezarZeroEsquerdaRegPf : «Falso» '
                                              WHEN  DesprezarZeroEsquerdaRegPf = 1 THEN ' DesprezarZeroEsquerdaRegPf : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DesprezarZeroEsquerdaRegPj IS NULL THEN ' DesprezarZeroEsquerdaRegPj : «Nulo» '
                                              WHEN  DesprezarZeroEsquerdaRegPj = 0 THEN ' DesprezarZeroEsquerdaRegPj : «Falso» '
                                              WHEN  DesprezarZeroEsquerdaRegPj = 1 THEN ' DesprezarZeroEsquerdaRegPj : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  visualizarDocumentos IS NULL THEN ' visualizarDocumentos : «Nulo» '
                                              WHEN  visualizarDocumentos = 0 THEN ' visualizarDocumentos : «Falso» '
                                              WHEN  visualizarDocumentos = 1 THEN ' visualizarDocumentos : «Verdadeiro» '
                                    END 
                         + '| DescontoRenegociacao : «' + RTRIM( ISNULL( CAST (DescontoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarDescontoSobreValorDivida IS NULL THEN ' AplicarDescontoSobreValorDivida : «Nulo» '
                                              WHEN  AplicarDescontoSobreValorDivida = 0 THEN ' AplicarDescontoSobreValorDivida : «Falso» '
                                              WHEN  AplicarDescontoSobreValorDivida = 1 THEN ' AplicarDescontoSobreValorDivida : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial IS NULL THEN ' NaoCobrarEncargosSobreParcelaInicial : «Nulo» '
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial = 0 THEN ' NaoCobrarEncargosSobreParcelaInicial : «Falso» '
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial = 1 THEN ' NaoCobrarEncargosSobreParcelaInicial : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LimiteDataRenegociacaoMesCorrente IS NULL THEN ' LimiteDataRenegociacaoMesCorrente : «Nulo» '
                                              WHEN  LimiteDataRenegociacaoMesCorrente = 0 THEN ' LimiteDataRenegociacaoMesCorrente : «Falso» '
                                              WHEN  LimiteDataRenegociacaoMesCorrente = 1 THEN ' LimiteDataRenegociacaoMesCorrente : «Verdadeiro» '
                                    END 
                         + '| PathComercioEletronico : «' + RTRIM( ISNULL( CAST (PathComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa IS NULL THEN ' bloquearDebitosDividaAtivaAdministrativa : «Nulo» '
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa = 0 THEN ' bloquearDebitosDividaAtivaAdministrativa : «Falso» '
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa = 1 THEN ' bloquearDebitosDividaAtivaAdministrativa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearDebitosDividaAtivaExecutiva IS NULL THEN ' BloquearDebitosDividaAtivaExecutiva : «Nulo» '
                                              WHEN  BloquearDebitosDividaAtivaExecutiva = 0 THEN ' BloquearDebitosDividaAtivaExecutiva : «Falso» '
                                              WHEN  BloquearDebitosDividaAtivaExecutiva = 1 THEN ' BloquearDebitosDividaAtivaExecutiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociarDebitosVencer IS NULL THEN ' RenegociarDebitosVencer : «Nulo» '
                                              WHEN  RenegociarDebitosVencer = 0 THEN ' RenegociarDebitosVencer : «Falso» '
                                              WHEN  RenegociarDebitosVencer = 1 THEN ' RenegociarDebitosVencer : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DocumentoDigitalART IS NULL THEN ' DocumentoDigitalART : «Nulo» '
                                              WHEN  DocumentoDigitalART = 0 THEN ' DocumentoDigitalART : «Falso» '
                                              WHEN  DocumentoDigitalART = 1 THEN ' DocumentoDigitalART : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeDadosPJValidadeCertidoes IS NULL THEN ' ExibeDadosPJValidadeCertidoes : «Nulo» '
                                              WHEN  ExibeDadosPJValidadeCertidoes = 0 THEN ' ExibeDadosPJValidadeCertidoes : «Falso» '
                                              WHEN  ExibeDadosPJValidadeCertidoes = 1 THEN ' ExibeDadosPJValidadeCertidoes : «Verdadeiro» '
                                    END 
                         + '| InstrucoesExperienciaProfissional : «' + RTRIM( ISNULL( CAST (InstrucoesExperienciaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararCampo5 : «' + RTRIM( ISNULL( CAST (CompararCampo5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararCampo6 : «' + RTRIM( ISNULL( CAST (CompararCampo6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararDataNac : «' + RTRIM( ISNULL( CAST (CompararDataNac AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararNomeMae : «' + RTRIM( ISNULL( CAST (CompararNomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararRegistro : «' + RTRIM( ISNULL( CAST (CompararRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FuncoesDisponiveisPJ : «' + RTRIM( ISNULL( CAST (FuncoesDisponiveisPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FuncoesDisponiveisrPF : «' + RTRIM( ISNULL( CAST (FuncoesDisponiveisrPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DocumentosSisdocWEB IS NULL THEN ' DocumentosSisdocWEB : «Nulo» '
                                              WHEN  DocumentosSisdocWEB = 0 THEN ' DocumentosSisdocWEB : «Falso» '
                                              WHEN  DocumentosSisdocWEB = 1 THEN ' DocumentosSisdocWEB : «Verdadeiro» '
                                    END 
                         + '| MsgCertidaoInexistente : «' + RTRIM( ISNULL( CAST (MsgCertidaoInexistente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoAtualBloqueioLogin : «' + RTRIM( ISNULL( CAST (SituacaoAtualBloqueioLogin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MensagemSituacaoAtualBloqueioLogin : «' + RTRIM( ISNULL( CAST (MensagemSituacaoAtualBloqueioLogin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquearDebitosProtestados IS NULL THEN ' BloquearDebitosProtestados : «Nulo» '
                                              WHEN  BloquearDebitosProtestados = 0 THEN ' BloquearDebitosProtestados : «Falso» '
                                              WHEN  BloquearDebitosProtestados = 1 THEN ' BloquearDebitosProtestados : «Verdadeiro» '
                                    END 
                         + '| TipoParcelamentoRenegociacao : «' + RTRIM( ISNULL( CAST (TipoParcelamentoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigWeb : «' + RTRIM( ISNULL( CAST (IdConfigWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselhoProprietario : «' + RTRIM( ISNULL( CAST (IdConselhoProprietario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathLogo : «' + RTRIM( ISNULL( CAST (PathLogo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FundoCor : «' + RTRIM( ISNULL( CAST (FundoCor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FundoImg : «' + RTRIM( ISNULL( CAST (FundoImg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinkVoltar : «' + RTRIM( ISNULL( CAST (LinkVoltar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamLetra : «' + RTRIM( ISNULL( CAST (TamLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLetra : «' + RTRIM( ISNULL( CAST (TipoLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorLetra : «' + RTRIM( ISNULL( CAST (CorLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstiloCSS : «' + RTRIM( ISNULL( CAST (EstiloCSS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConselho : «' + RTRIM( ISNULL( CAST (NomeConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndMostraProf IS NULL THEN ' IndMostraProf : «Nulo» '
                                              WHEN  IndMostraProf = 0 THEN ' IndMostraProf : «Falso» '
                                              WHEN  IndMostraProf = 1 THEN ' IndMostraProf : «Verdadeiro» '
                                    END 
                         + '| CompletaZero : «' + RTRIM( ISNULL( CAST (CompletaZero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaTrocaSenha : «' + RTRIM( ISNULL( CAST (FormaTrocaSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigAtiva IS NULL THEN ' ConfigAtiva : «Nulo» '
                                              WHEN  ConfigAtiva = 0 THEN ' ConfigAtiva : «Falso» '
                                              WHEN  ConfigAtiva = 1 THEN ' ConfigAtiva : «Verdadeiro» '
                                    END 
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNum : «' + RTRIM( ISNULL( CAST (InicioNossoNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNum : «' + RTRIM( ISNULL( CAST (FimNossoNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaSincronizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaSincronizacao, 113 ),'Nulo'))+'» '
                         + '| TelaInicialPesquisa : «' + RTRIM( ISNULL( CAST (TelaInicialPesquisa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ColunasCriterioPesquisaPF : «' + RTRIM( ISNULL( CAST (ColunasCriterioPesquisaPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ColunasCriterioPesquisaPJ : «' + RTRIM( ISNULL( CAST (ColunasCriterioPesquisaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComparaDados_CamposDisponiveis : «' + RTRIM( ISNULL( CAST (ComparaDados_CamposDisponiveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComparaDados_CamposSelecionados : «' + RTRIM( ISNULL( CAST (ComparaDados_CamposSelecionados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtTelaPesquisaCompleta : «' + RTRIM( ISNULL( CAST (txtTelaPesquisaCompleta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirEspecialidades IS NULL THEN ' ExibirEspecialidades : «Nulo» '
                                              WHEN  ExibirEspecialidades = 0 THEN ' ExibirEspecialidades : «Falso» '
                                              WHEN  ExibirEspecialidades = 1 THEN ' ExibirEspecialidades : «Verdadeiro» '
                                    END 
                         + '| MaxEspecialidedes : «' + RTRIM( ISNULL( CAST (MaxEspecialidedes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirAreaAtuacao IS NULL THEN ' ExibirAreaAtuacao : «Nulo» '
                                              WHEN  ExibirAreaAtuacao = 0 THEN ' ExibirAreaAtuacao : «Falso» '
                                              WHEN  ExibirAreaAtuacao = 1 THEN ' ExibirAreaAtuacao : «Verdadeiro» '
                                    END 
                         + '| MaxAreaAtuacao : «' + RTRIM( ISNULL( CAST (MaxAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirCurso_Nivel IS NULL THEN ' ExibirCurso_Nivel : «Nulo» '
                                              WHEN  ExibirCurso_Nivel = 0 THEN ' ExibirCurso_Nivel : «Falso» '
                                              WHEN  ExibirCurso_Nivel = 1 THEN ' ExibirCurso_Nivel : «Verdadeiro» '
                                    END 
                         + '| MaxCurso_Nivel : «' + RTRIM( ISNULL( CAST (MaxCurso_Nivel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna1_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna1_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna2_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna2_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna3_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna3_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna4_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna4_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna1_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna1_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna2_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna2_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna3_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna3_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna4_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna4_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoProfWeb : «' + RTRIM( ISNULL( CAST (TpControleAcessoProfWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CamposComparacaoLoginPF : «' + RTRIM( ISNULL( CAST (CamposComparacaoLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CamposComparacaoLoginPJ : «' + RTRIM( ISNULL( CAST (CamposComparacaoLoginPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginConselho : «' + RTRIM( ISNULL( CAST (MsgTelaLoginConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginPF : «' + RTRIM( ISNULL( CAST (MsgTelaLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginPJ : «' + RTRIM( ISNULL( CAST (MsgTelaLoginPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginDireto : «' + RTRIM( ISNULL( CAST (MsgTelaLoginDireto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoPF : «' + RTRIM( ISNULL( CAST (TpControleAcessoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoPJ : «' + RTRIM( ISNULL( CAST (TpControleAcessoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtRodapeTelaResultadoPesquisa_PF : «' + RTRIM( ISNULL( CAST (txtRodapeTelaResultadoPesquisa_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtRodapeTelaResultadoPesquisa_PJ : «' + RTRIM( ISNULL( CAST (txtRodapeTelaResultadoPesquisa_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarCampoNuloLoginPf IS NULL THEN ' DesprezarCampoNuloLoginPf : «Nulo» '
                                              WHEN  DesprezarCampoNuloLoginPf = 0 THEN ' DesprezarCampoNuloLoginPf : «Falso» '
                                              WHEN  DesprezarCampoNuloLoginPf = 1 THEN ' DesprezarCampoNuloLoginPf : «Verdadeiro» '
                                    END 
                         + '| QuantCampoNuloLoginPf : «' + RTRIM( ISNULL( CAST (QuantCampoNuloLoginPf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarCampoNuloLoginPj IS NULL THEN ' DesprezarCampoNuloLoginPj : «Nulo» '
                                              WHEN  DesprezarCampoNuloLoginPj = 0 THEN ' DesprezarCampoNuloLoginPj : «Falso» '
                                              WHEN  DesprezarCampoNuloLoginPj = 1 THEN ' DesprezarCampoNuloLoginPj : «Verdadeiro» '
                                    END 
                         + '| QuantCampoNuloLoginPj : «' + RTRIM( ISNULL( CAST (QuantCampoNuloLoginPj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglaConselho : «' + RTRIM( ISNULL( CAST (siglaConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoVlrBoleto : «' + RTRIM( ISNULL( CAST (DescontoVlrBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcrescimoVlrBoleto : «' + RTRIM( ISNULL( CAST (AcrescimoVlrBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RenegociarAnoCorrente IS NULL THEN ' RenegociarAnoCorrente : «Nulo» '
                                              WHEN  RenegociarAnoCorrente = 0 THEN ' RenegociarAnoCorrente : «Falso» '
                                              WHEN  RenegociarAnoCorrente = 1 THEN ' RenegociarAnoCorrente : «Verdadeiro» '
                                    END 
                         + '| RenegociarAnoCorrenteMenor : «' + RTRIM( ISNULL( CAST (RenegociarAnoCorrenteMenor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasRenInicio : «' + RTRIM( ISNULL( CAST (QtdDiasRenInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Acrescimo : «' + RTRIM( ISNULL( CAST (Acrescimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DespBancarias : «' + RTRIM( ISNULL( CAST (DespBancarias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DespAdv : «' + RTRIM( ISNULL( CAST (DespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoValidacaoLoginPf : «' + RTRIM( ISNULL( CAST (CampoValidacaoLoginPf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoValidacaoLoginPj : «' + RTRIM( ISNULL( CAST (CampoValidacaoLoginPj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBConvenioComercioEletronico : «' + RTRIM( ISNULL( CAST (BBConvenioComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBConvenioCobranca : «' + RTRIM( ISNULL( CAST (BBConvenioCobranca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBRefTran : «' + RTRIM( ISNULL( CAST (BBRefTran AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF1 : «' + RTRIM( ISNULL( CAST (linkPF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF1 : «' + RTRIM( ISNULL( CAST (TextolinkPF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF2 : «' + RTRIM( ISNULL( CAST (linkPF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF2 : «' + RTRIM( ISNULL( CAST (TextolinkPF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF3 : «' + RTRIM( ISNULL( CAST (linkPF3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF3 : «' + RTRIM( ISNULL( CAST (TextolinkPF3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ1 : «' + RTRIM( ISNULL( CAST (linkPJ1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ1 : «' + RTRIM( ISNULL( CAST (TextolinkPJ1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ2 : «' + RTRIM( ISNULL( CAST (linkPJ2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ2 : «' + RTRIM( ISNULL( CAST (TextolinkPJ2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ3 : «' + RTRIM( ISNULL( CAST (linkPJ3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ3 : «' + RTRIM( ISNULL( CAST (TextolinkPJ3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquearRenDA_PF IS NULL THEN ' BloquearRenDA_PF : «Nulo» '
                                              WHEN  BloquearRenDA_PF = 0 THEN ' BloquearRenDA_PF : «Falso» '
                                              WHEN  BloquearRenDA_PF = 1 THEN ' BloquearRenDA_PF : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearRenDA_PJ IS NULL THEN ' BloquearRenDA_PJ : «Nulo» '
                                              WHEN  BloquearRenDA_PJ = 0 THEN ' BloquearRenDA_PJ : «Falso» '
                                              WHEN  BloquearRenDA_PJ = 1 THEN ' BloquearRenDA_PJ : «Verdadeiro» '
                                    END 
                         + '| MsgBloqueioRenDA_PF : «' + RTRIM( ISNULL( CAST (MsgBloqueioRenDA_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgBloqueioRenDA_PJ : «' + RTRIM( ISNULL( CAST (MsgBloqueioRenDA_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgParaRegistroConselho : «' + RTRIM( ISNULL( CAST (MsgParaRegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgParaRegistroConselhoPJ : «' + RTRIM( ISNULL( CAST (MsgParaRegistroConselhoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarEnderecoTrabalho IS NULL THEN ' UtilizarEnderecoTrabalho : «Nulo» '
                                              WHEN  UtilizarEnderecoTrabalho = 0 THEN ' UtilizarEnderecoTrabalho : «Falso» '
                                              WHEN  UtilizarEnderecoTrabalho = 1 THEN ' UtilizarEnderecoTrabalho : «Verdadeiro» '
                                    END 
                         + '| Email : «' + RTRIM( ISNULL( CAST (Email AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirDebitosPagos IS NULL THEN ' ExibirDebitosPagos : «Nulo» '
                                              WHEN  ExibirDebitosPagos = 0 THEN ' ExibirDebitosPagos : «Falso» '
                                              WHEN  ExibirDebitosPagos = 1 THEN ' ExibirDebitosPagos : «Verdadeiro» '
                                    END 
                         + '| txtTelaPesquisaPersonalizada : «' + RTRIM( ISNULL( CAST (txtTelaPesquisaPersonalizada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNumeroDocumento : «' + RTRIM( ISNULL( CAST (SequencialNumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBPagamentoEletronico : «' + RTRIM( ISNULL( CAST (BBPagamentoEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CompararCPF_CNPJ IS NULL THEN ' CompararCPF_CNPJ : «Nulo» '
                                              WHEN  CompararCPF_CNPJ = 0 THEN ' CompararCPF_CNPJ : «Falso» '
                                              WHEN  CompararCPF_CNPJ = 1 THEN ' CompararCPF_CNPJ : «Verdadeiro» '
                                    END 
                         + '| TiposDebitoRenegociacao : «' + RTRIM( ISNULL( CAST (TiposDebitoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgCamposComparacaoLoginPF : «' + RTRIM( ISNULL( CAST (MsgCamposComparacaoLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarZeroEsquerdaRegPf IS NULL THEN ' DesprezarZeroEsquerdaRegPf : «Nulo» '
                                              WHEN  DesprezarZeroEsquerdaRegPf = 0 THEN ' DesprezarZeroEsquerdaRegPf : «Falso» '
                                              WHEN  DesprezarZeroEsquerdaRegPf = 1 THEN ' DesprezarZeroEsquerdaRegPf : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DesprezarZeroEsquerdaRegPj IS NULL THEN ' DesprezarZeroEsquerdaRegPj : «Nulo» '
                                              WHEN  DesprezarZeroEsquerdaRegPj = 0 THEN ' DesprezarZeroEsquerdaRegPj : «Falso» '
                                              WHEN  DesprezarZeroEsquerdaRegPj = 1 THEN ' DesprezarZeroEsquerdaRegPj : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  visualizarDocumentos IS NULL THEN ' visualizarDocumentos : «Nulo» '
                                              WHEN  visualizarDocumentos = 0 THEN ' visualizarDocumentos : «Falso» '
                                              WHEN  visualizarDocumentos = 1 THEN ' visualizarDocumentos : «Verdadeiro» '
                                    END 
                         + '| DescontoRenegociacao : «' + RTRIM( ISNULL( CAST (DescontoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarDescontoSobreValorDivida IS NULL THEN ' AplicarDescontoSobreValorDivida : «Nulo» '
                                              WHEN  AplicarDescontoSobreValorDivida = 0 THEN ' AplicarDescontoSobreValorDivida : «Falso» '
                                              WHEN  AplicarDescontoSobreValorDivida = 1 THEN ' AplicarDescontoSobreValorDivida : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial IS NULL THEN ' NaoCobrarEncargosSobreParcelaInicial : «Nulo» '
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial = 0 THEN ' NaoCobrarEncargosSobreParcelaInicial : «Falso» '
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial = 1 THEN ' NaoCobrarEncargosSobreParcelaInicial : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LimiteDataRenegociacaoMesCorrente IS NULL THEN ' LimiteDataRenegociacaoMesCorrente : «Nulo» '
                                              WHEN  LimiteDataRenegociacaoMesCorrente = 0 THEN ' LimiteDataRenegociacaoMesCorrente : «Falso» '
                                              WHEN  LimiteDataRenegociacaoMesCorrente = 1 THEN ' LimiteDataRenegociacaoMesCorrente : «Verdadeiro» '
                                    END 
                         + '| PathComercioEletronico : «' + RTRIM( ISNULL( CAST (PathComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa IS NULL THEN ' bloquearDebitosDividaAtivaAdministrativa : «Nulo» '
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa = 0 THEN ' bloquearDebitosDividaAtivaAdministrativa : «Falso» '
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa = 1 THEN ' bloquearDebitosDividaAtivaAdministrativa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearDebitosDividaAtivaExecutiva IS NULL THEN ' BloquearDebitosDividaAtivaExecutiva : «Nulo» '
                                              WHEN  BloquearDebitosDividaAtivaExecutiva = 0 THEN ' BloquearDebitosDividaAtivaExecutiva : «Falso» '
                                              WHEN  BloquearDebitosDividaAtivaExecutiva = 1 THEN ' BloquearDebitosDividaAtivaExecutiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociarDebitosVencer IS NULL THEN ' RenegociarDebitosVencer : «Nulo» '
                                              WHEN  RenegociarDebitosVencer = 0 THEN ' RenegociarDebitosVencer : «Falso» '
                                              WHEN  RenegociarDebitosVencer = 1 THEN ' RenegociarDebitosVencer : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DocumentoDigitalART IS NULL THEN ' DocumentoDigitalART : «Nulo» '
                                              WHEN  DocumentoDigitalART = 0 THEN ' DocumentoDigitalART : «Falso» '
                                              WHEN  DocumentoDigitalART = 1 THEN ' DocumentoDigitalART : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeDadosPJValidadeCertidoes IS NULL THEN ' ExibeDadosPJValidadeCertidoes : «Nulo» '
                                              WHEN  ExibeDadosPJValidadeCertidoes = 0 THEN ' ExibeDadosPJValidadeCertidoes : «Falso» '
                                              WHEN  ExibeDadosPJValidadeCertidoes = 1 THEN ' ExibeDadosPJValidadeCertidoes : «Verdadeiro» '
                                    END 
                         + '| InstrucoesExperienciaProfissional : «' + RTRIM( ISNULL( CAST (InstrucoesExperienciaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararCampo5 : «' + RTRIM( ISNULL( CAST (CompararCampo5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararCampo6 : «' + RTRIM( ISNULL( CAST (CompararCampo6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararDataNac : «' + RTRIM( ISNULL( CAST (CompararDataNac AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararNomeMae : «' + RTRIM( ISNULL( CAST (CompararNomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararRegistro : «' + RTRIM( ISNULL( CAST (CompararRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FuncoesDisponiveisPJ : «' + RTRIM( ISNULL( CAST (FuncoesDisponiveisPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FuncoesDisponiveisrPF : «' + RTRIM( ISNULL( CAST (FuncoesDisponiveisrPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DocumentosSisdocWEB IS NULL THEN ' DocumentosSisdocWEB : «Nulo» '
                                              WHEN  DocumentosSisdocWEB = 0 THEN ' DocumentosSisdocWEB : «Falso» '
                                              WHEN  DocumentosSisdocWEB = 1 THEN ' DocumentosSisdocWEB : «Verdadeiro» '
                                    END 
                         + '| MsgCertidaoInexistente : «' + RTRIM( ISNULL( CAST (MsgCertidaoInexistente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoAtualBloqueioLogin : «' + RTRIM( ISNULL( CAST (SituacaoAtualBloqueioLogin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MensagemSituacaoAtualBloqueioLogin : «' + RTRIM( ISNULL( CAST (MensagemSituacaoAtualBloqueioLogin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquearDebitosProtestados IS NULL THEN ' BloquearDebitosProtestados : «Nulo» '
                                              WHEN  BloquearDebitosProtestados = 0 THEN ' BloquearDebitosProtestados : «Falso» '
                                              WHEN  BloquearDebitosProtestados = 1 THEN ' BloquearDebitosProtestados : «Verdadeiro» '
                                    END 
                         + '| TipoParcelamentoRenegociacao : «' + RTRIM( ISNULL( CAST (TipoParcelamentoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigWeb : «' + RTRIM( ISNULL( CAST (IdConfigWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselhoProprietario : «' + RTRIM( ISNULL( CAST (IdConselhoProprietario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PathLogo : «' + RTRIM( ISNULL( CAST (PathLogo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FundoCor : «' + RTRIM( ISNULL( CAST (FundoCor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FundoImg : «' + RTRIM( ISNULL( CAST (FundoImg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinkVoltar : «' + RTRIM( ISNULL( CAST (LinkVoltar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamLetra : «' + RTRIM( ISNULL( CAST (TamLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLetra : «' + RTRIM( ISNULL( CAST (TipoLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorLetra : «' + RTRIM( ISNULL( CAST (CorLetra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstiloCSS : «' + RTRIM( ISNULL( CAST (EstiloCSS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConselho : «' + RTRIM( ISNULL( CAST (NomeConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndMostraProf IS NULL THEN ' IndMostraProf : «Nulo» '
                                              WHEN  IndMostraProf = 0 THEN ' IndMostraProf : «Falso» '
                                              WHEN  IndMostraProf = 1 THEN ' IndMostraProf : «Verdadeiro» '
                                    END 
                         + '| CompletaZero : «' + RTRIM( ISNULL( CAST (CompletaZero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaTrocaSenha : «' + RTRIM( ISNULL( CAST (FormaTrocaSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigAtiva IS NULL THEN ' ConfigAtiva : «Nulo» '
                                              WHEN  ConfigAtiva = 0 THEN ' ConfigAtiva : «Falso» '
                                              WHEN  ConfigAtiva = 1 THEN ' ConfigAtiva : «Verdadeiro» '
                                    END 
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNum : «' + RTRIM( ISNULL( CAST (InicioNossoNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNum : «' + RTRIM( ISNULL( CAST (FimNossoNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaSincronizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaSincronizacao, 113 ),'Nulo'))+'» '
                         + '| TelaInicialPesquisa : «' + RTRIM( ISNULL( CAST (TelaInicialPesquisa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ColunasCriterioPesquisaPF : «' + RTRIM( ISNULL( CAST (ColunasCriterioPesquisaPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ColunasCriterioPesquisaPJ : «' + RTRIM( ISNULL( CAST (ColunasCriterioPesquisaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComparaDados_CamposDisponiveis : «' + RTRIM( ISNULL( CAST (ComparaDados_CamposDisponiveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComparaDados_CamposSelecionados : «' + RTRIM( ISNULL( CAST (ComparaDados_CamposSelecionados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtTelaPesquisaCompleta : «' + RTRIM( ISNULL( CAST (txtTelaPesquisaCompleta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirEspecialidades IS NULL THEN ' ExibirEspecialidades : «Nulo» '
                                              WHEN  ExibirEspecialidades = 0 THEN ' ExibirEspecialidades : «Falso» '
                                              WHEN  ExibirEspecialidades = 1 THEN ' ExibirEspecialidades : «Verdadeiro» '
                                    END 
                         + '| MaxEspecialidedes : «' + RTRIM( ISNULL( CAST (MaxEspecialidedes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirAreaAtuacao IS NULL THEN ' ExibirAreaAtuacao : «Nulo» '
                                              WHEN  ExibirAreaAtuacao = 0 THEN ' ExibirAreaAtuacao : «Falso» '
                                              WHEN  ExibirAreaAtuacao = 1 THEN ' ExibirAreaAtuacao : «Verdadeiro» '
                                    END 
                         + '| MaxAreaAtuacao : «' + RTRIM( ISNULL( CAST (MaxAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirCurso_Nivel IS NULL THEN ' ExibirCurso_Nivel : «Nulo» '
                                              WHEN  ExibirCurso_Nivel = 0 THEN ' ExibirCurso_Nivel : «Falso» '
                                              WHEN  ExibirCurso_Nivel = 1 THEN ' ExibirCurso_Nivel : «Verdadeiro» '
                                    END 
                         + '| MaxCurso_Nivel : «' + RTRIM( ISNULL( CAST (MaxCurso_Nivel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna1_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna1_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna2_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna2_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna3_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna3_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna4_PF : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna4_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna1_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna1_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna2_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna2_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna3_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna3_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoPesquisa_Coluna4_PJ : «' + RTRIM( ISNULL( CAST (ResultadoPesquisa_Coluna4_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoProfWeb : «' + RTRIM( ISNULL( CAST (TpControleAcessoProfWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CamposComparacaoLoginPF : «' + RTRIM( ISNULL( CAST (CamposComparacaoLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CamposComparacaoLoginPJ : «' + RTRIM( ISNULL( CAST (CamposComparacaoLoginPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginConselho : «' + RTRIM( ISNULL( CAST (MsgTelaLoginConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginPF : «' + RTRIM( ISNULL( CAST (MsgTelaLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginPJ : «' + RTRIM( ISNULL( CAST (MsgTelaLoginPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgTelaLoginDireto : «' + RTRIM( ISNULL( CAST (MsgTelaLoginDireto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoPF : «' + RTRIM( ISNULL( CAST (TpControleAcessoPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpControleAcessoPJ : «' + RTRIM( ISNULL( CAST (TpControleAcessoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtRodapeTelaResultadoPesquisa_PF : «' + RTRIM( ISNULL( CAST (txtRodapeTelaResultadoPesquisa_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| txtRodapeTelaResultadoPesquisa_PJ : «' + RTRIM( ISNULL( CAST (txtRodapeTelaResultadoPesquisa_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarCampoNuloLoginPf IS NULL THEN ' DesprezarCampoNuloLoginPf : «Nulo» '
                                              WHEN  DesprezarCampoNuloLoginPf = 0 THEN ' DesprezarCampoNuloLoginPf : «Falso» '
                                              WHEN  DesprezarCampoNuloLoginPf = 1 THEN ' DesprezarCampoNuloLoginPf : «Verdadeiro» '
                                    END 
                         + '| QuantCampoNuloLoginPf : «' + RTRIM( ISNULL( CAST (QuantCampoNuloLoginPf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarCampoNuloLoginPj IS NULL THEN ' DesprezarCampoNuloLoginPj : «Nulo» '
                                              WHEN  DesprezarCampoNuloLoginPj = 0 THEN ' DesprezarCampoNuloLoginPj : «Falso» '
                                              WHEN  DesprezarCampoNuloLoginPj = 1 THEN ' DesprezarCampoNuloLoginPj : «Verdadeiro» '
                                    END 
                         + '| QuantCampoNuloLoginPj : «' + RTRIM( ISNULL( CAST (QuantCampoNuloLoginPj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglaConselho : «' + RTRIM( ISNULL( CAST (siglaConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoVlrBoleto : «' + RTRIM( ISNULL( CAST (DescontoVlrBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcrescimoVlrBoleto : «' + RTRIM( ISNULL( CAST (AcrescimoVlrBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RenegociarAnoCorrente IS NULL THEN ' RenegociarAnoCorrente : «Nulo» '
                                              WHEN  RenegociarAnoCorrente = 0 THEN ' RenegociarAnoCorrente : «Falso» '
                                              WHEN  RenegociarAnoCorrente = 1 THEN ' RenegociarAnoCorrente : «Verdadeiro» '
                                    END 
                         + '| RenegociarAnoCorrenteMenor : «' + RTRIM( ISNULL( CAST (RenegociarAnoCorrenteMenor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasRenInicio : «' + RTRIM( ISNULL( CAST (QtdDiasRenInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Acrescimo : «' + RTRIM( ISNULL( CAST (Acrescimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DespBancarias : «' + RTRIM( ISNULL( CAST (DespBancarias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DespAdv : «' + RTRIM( ISNULL( CAST (DespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoValidacaoLoginPf : «' + RTRIM( ISNULL( CAST (CampoValidacaoLoginPf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoValidacaoLoginPj : «' + RTRIM( ISNULL( CAST (CampoValidacaoLoginPj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBConvenioComercioEletronico : «' + RTRIM( ISNULL( CAST (BBConvenioComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBConvenioCobranca : «' + RTRIM( ISNULL( CAST (BBConvenioCobranca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBRefTran : «' + RTRIM( ISNULL( CAST (BBRefTran AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF1 : «' + RTRIM( ISNULL( CAST (linkPF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF1 : «' + RTRIM( ISNULL( CAST (TextolinkPF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF2 : «' + RTRIM( ISNULL( CAST (linkPF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF2 : «' + RTRIM( ISNULL( CAST (TextolinkPF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPF3 : «' + RTRIM( ISNULL( CAST (linkPF3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPF3 : «' + RTRIM( ISNULL( CAST (TextolinkPF3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ1 : «' + RTRIM( ISNULL( CAST (linkPJ1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ1 : «' + RTRIM( ISNULL( CAST (TextolinkPJ1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ2 : «' + RTRIM( ISNULL( CAST (linkPJ2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ2 : «' + RTRIM( ISNULL( CAST (TextolinkPJ2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| linkPJ3 : «' + RTRIM( ISNULL( CAST (linkPJ3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextolinkPJ3 : «' + RTRIM( ISNULL( CAST (TextolinkPJ3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquearRenDA_PF IS NULL THEN ' BloquearRenDA_PF : «Nulo» '
                                              WHEN  BloquearRenDA_PF = 0 THEN ' BloquearRenDA_PF : «Falso» '
                                              WHEN  BloquearRenDA_PF = 1 THEN ' BloquearRenDA_PF : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearRenDA_PJ IS NULL THEN ' BloquearRenDA_PJ : «Nulo» '
                                              WHEN  BloquearRenDA_PJ = 0 THEN ' BloquearRenDA_PJ : «Falso» '
                                              WHEN  BloquearRenDA_PJ = 1 THEN ' BloquearRenDA_PJ : «Verdadeiro» '
                                    END 
                         + '| MsgBloqueioRenDA_PF : «' + RTRIM( ISNULL( CAST (MsgBloqueioRenDA_PF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgBloqueioRenDA_PJ : «' + RTRIM( ISNULL( CAST (MsgBloqueioRenDA_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgParaRegistroConselho : «' + RTRIM( ISNULL( CAST (MsgParaRegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgParaRegistroConselhoPJ : «' + RTRIM( ISNULL( CAST (MsgParaRegistroConselhoPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarEnderecoTrabalho IS NULL THEN ' UtilizarEnderecoTrabalho : «Nulo» '
                                              WHEN  UtilizarEnderecoTrabalho = 0 THEN ' UtilizarEnderecoTrabalho : «Falso» '
                                              WHEN  UtilizarEnderecoTrabalho = 1 THEN ' UtilizarEnderecoTrabalho : «Verdadeiro» '
                                    END 
                         + '| Email : «' + RTRIM( ISNULL( CAST (Email AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirDebitosPagos IS NULL THEN ' ExibirDebitosPagos : «Nulo» '
                                              WHEN  ExibirDebitosPagos = 0 THEN ' ExibirDebitosPagos : «Falso» '
                                              WHEN  ExibirDebitosPagos = 1 THEN ' ExibirDebitosPagos : «Verdadeiro» '
                                    END 
                         + '| txtTelaPesquisaPersonalizada : «' + RTRIM( ISNULL( CAST (txtTelaPesquisaPersonalizada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNumeroDocumento : «' + RTRIM( ISNULL( CAST (SequencialNumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BBPagamentoEletronico : «' + RTRIM( ISNULL( CAST (BBPagamentoEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CompararCPF_CNPJ IS NULL THEN ' CompararCPF_CNPJ : «Nulo» '
                                              WHEN  CompararCPF_CNPJ = 0 THEN ' CompararCPF_CNPJ : «Falso» '
                                              WHEN  CompararCPF_CNPJ = 1 THEN ' CompararCPF_CNPJ : «Verdadeiro» '
                                    END 
                         + '| TiposDebitoRenegociacao : «' + RTRIM( ISNULL( CAST (TiposDebitoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgCamposComparacaoLoginPF : «' + RTRIM( ISNULL( CAST (MsgCamposComparacaoLoginPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesprezarZeroEsquerdaRegPf IS NULL THEN ' DesprezarZeroEsquerdaRegPf : «Nulo» '
                                              WHEN  DesprezarZeroEsquerdaRegPf = 0 THEN ' DesprezarZeroEsquerdaRegPf : «Falso» '
                                              WHEN  DesprezarZeroEsquerdaRegPf = 1 THEN ' DesprezarZeroEsquerdaRegPf : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DesprezarZeroEsquerdaRegPj IS NULL THEN ' DesprezarZeroEsquerdaRegPj : «Nulo» '
                                              WHEN  DesprezarZeroEsquerdaRegPj = 0 THEN ' DesprezarZeroEsquerdaRegPj : «Falso» '
                                              WHEN  DesprezarZeroEsquerdaRegPj = 1 THEN ' DesprezarZeroEsquerdaRegPj : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  visualizarDocumentos IS NULL THEN ' visualizarDocumentos : «Nulo» '
                                              WHEN  visualizarDocumentos = 0 THEN ' visualizarDocumentos : «Falso» '
                                              WHEN  visualizarDocumentos = 1 THEN ' visualizarDocumentos : «Verdadeiro» '
                                    END 
                         + '| DescontoRenegociacao : «' + RTRIM( ISNULL( CAST (DescontoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarDescontoSobreValorDivida IS NULL THEN ' AplicarDescontoSobreValorDivida : «Nulo» '
                                              WHEN  AplicarDescontoSobreValorDivida = 0 THEN ' AplicarDescontoSobreValorDivida : «Falso» '
                                              WHEN  AplicarDescontoSobreValorDivida = 1 THEN ' AplicarDescontoSobreValorDivida : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial IS NULL THEN ' NaoCobrarEncargosSobreParcelaInicial : «Nulo» '
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial = 0 THEN ' NaoCobrarEncargosSobreParcelaInicial : «Falso» '
                                              WHEN  NaoCobrarEncargosSobreParcelaInicial = 1 THEN ' NaoCobrarEncargosSobreParcelaInicial : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LimiteDataRenegociacaoMesCorrente IS NULL THEN ' LimiteDataRenegociacaoMesCorrente : «Nulo» '
                                              WHEN  LimiteDataRenegociacaoMesCorrente = 0 THEN ' LimiteDataRenegociacaoMesCorrente : «Falso» '
                                              WHEN  LimiteDataRenegociacaoMesCorrente = 1 THEN ' LimiteDataRenegociacaoMesCorrente : «Verdadeiro» '
                                    END 
                         + '| PathComercioEletronico : «' + RTRIM( ISNULL( CAST (PathComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa IS NULL THEN ' bloquearDebitosDividaAtivaAdministrativa : «Nulo» '
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa = 0 THEN ' bloquearDebitosDividaAtivaAdministrativa : «Falso» '
                                              WHEN  bloquearDebitosDividaAtivaAdministrativa = 1 THEN ' bloquearDebitosDividaAtivaAdministrativa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearDebitosDividaAtivaExecutiva IS NULL THEN ' BloquearDebitosDividaAtivaExecutiva : «Nulo» '
                                              WHEN  BloquearDebitosDividaAtivaExecutiva = 0 THEN ' BloquearDebitosDividaAtivaExecutiva : «Falso» '
                                              WHEN  BloquearDebitosDividaAtivaExecutiva = 1 THEN ' BloquearDebitosDividaAtivaExecutiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenegociarDebitosVencer IS NULL THEN ' RenegociarDebitosVencer : «Nulo» '
                                              WHEN  RenegociarDebitosVencer = 0 THEN ' RenegociarDebitosVencer : «Falso» '
                                              WHEN  RenegociarDebitosVencer = 1 THEN ' RenegociarDebitosVencer : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DocumentoDigitalART IS NULL THEN ' DocumentoDigitalART : «Nulo» '
                                              WHEN  DocumentoDigitalART = 0 THEN ' DocumentoDigitalART : «Falso» '
                                              WHEN  DocumentoDigitalART = 1 THEN ' DocumentoDigitalART : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeDadosPJValidadeCertidoes IS NULL THEN ' ExibeDadosPJValidadeCertidoes : «Nulo» '
                                              WHEN  ExibeDadosPJValidadeCertidoes = 0 THEN ' ExibeDadosPJValidadeCertidoes : «Falso» '
                                              WHEN  ExibeDadosPJValidadeCertidoes = 1 THEN ' ExibeDadosPJValidadeCertidoes : «Verdadeiro» '
                                    END 
                         + '| InstrucoesExperienciaProfissional : «' + RTRIM( ISNULL( CAST (InstrucoesExperienciaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararCampo5 : «' + RTRIM( ISNULL( CAST (CompararCampo5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararCampo6 : «' + RTRIM( ISNULL( CAST (CompararCampo6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararDataNac : «' + RTRIM( ISNULL( CAST (CompararDataNac AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararNomeMae : «' + RTRIM( ISNULL( CAST (CompararNomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CompararRegistro : «' + RTRIM( ISNULL( CAST (CompararRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FuncoesDisponiveisPJ : «' + RTRIM( ISNULL( CAST (FuncoesDisponiveisPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FuncoesDisponiveisrPF : «' + RTRIM( ISNULL( CAST (FuncoesDisponiveisrPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DocumentosSisdocWEB IS NULL THEN ' DocumentosSisdocWEB : «Nulo» '
                                              WHEN  DocumentosSisdocWEB = 0 THEN ' DocumentosSisdocWEB : «Falso» '
                                              WHEN  DocumentosSisdocWEB = 1 THEN ' DocumentosSisdocWEB : «Verdadeiro» '
                                    END 
                         + '| MsgCertidaoInexistente : «' + RTRIM( ISNULL( CAST (MsgCertidaoInexistente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoAtualBloqueioLogin : «' + RTRIM( ISNULL( CAST (SituacaoAtualBloqueioLogin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MensagemSituacaoAtualBloqueioLogin : «' + RTRIM( ISNULL( CAST (MensagemSituacaoAtualBloqueioLogin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BloquearDebitosProtestados IS NULL THEN ' BloquearDebitosProtestados : «Nulo» '
                                              WHEN  BloquearDebitosProtestados = 0 THEN ' BloquearDebitosProtestados : «Falso» '
                                              WHEN  BloquearDebitosProtestados = 1 THEN ' BloquearDebitosProtestados : «Verdadeiro» '
                                    END 
                         + '| TipoParcelamentoRenegociacao : «' + RTRIM( ISNULL( CAST (TipoParcelamentoRenegociacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
