CREATE TABLE [dbo].[ConfiguracoesSG] (
    [AvisaA4]                                   BIT              NOT NULL,
    [MostraConsumoMensal]                       BIT              NOT NULL,
    [MostraUltimaCompra]                        BIT              NOT NULL,
    [MostraUltimaSaida]                         BIT              NOT NULL,
    [ResponsavelUnidade]                        BIT              NOT NULL,
    [IdAlmoxarifadoPadraoOrdem]                 INT              NULL,
    [IdAlmoxarifadoPadraoPedido]                INT              NULL,
    [IdResponsavelPadraoAlmoxarifado]           INT              NULL,
    [IdResponsavelPadraoPatrimonio]             INT              NULL,
    [IdResponsavelPadraoTermo]                  INT              NULL,
    [CargoResponsavelTermo]                     VARCHAR (30)     NULL,
    [IdUnidadePadraoPatrimonio]                 INT              NULL,
    [IdTipoMovimentacaoPadraoOrdem]             INT              NULL,
    [IdTipoMovimentacaoPadraoDevolucaoOrdem]    INT              NULL,
    [IdTipoMovimentacaoPadraoPedido]            INT              NULL,
    [IdTipoMovimentacaoPadraoDevolucaoPedido]   INT              NULL,
    [Margem]                                    REAL             NULL,
    [VisualizaSiglaUnidade]                     BIT              NOT NULL,
    [IdTipoBemPadrao]                           INT              NULL,
    [DescricaoTermo]                            TEXT             NULL,
    [IdFaseLimiteProcesso]                      INT              NULL,
    [OrdemTelaAL]                               INT              NULL,
    [LocalEntregaAL]                            TEXT             NULL,
    [AssinaturaOS1]                             TEXT             NULL,
    [AssinaturaOS2]                             TEXT             NULL,
    [AssinaturaFA1]                             TEXT             NULL,
    [AssinaturaFA2]                             TEXT             NULL,
    [AssinaturaFA3]                             TEXT             NULL,
    [AssinaturaFA4]                             TEXT             NULL,
    [OrdemTelaBM]                               INT              NULL,
    [OrdemTelaBI]                               INT              NULL,
    [AssinaturaOC1]                             TEXT             NULL,
    [AssinaturaOC2]                             TEXT             NULL,
    [TextoSolicitacaoCotacao]                   TEXT             NULL,
    [MascaraMescladaLI]                         BIT              NULL,
    [AssinaturaSolicitacaoCotacao1]             TEXT             NULL,
    [AssinaturaSolicitacaoCotacao2]             TEXT             NULL,
    [DataLimiteAL]                              VARCHAR (20)     NULL,
    [DataAcessoAL]                              VARCHAR (20)     NULL,
    [AcessoAL]                                  VARCHAR (20)     NULL,
    [DataLimiteCO]                              VARCHAR (20)     NULL,
    [DataAcessoCO]                              VARCHAR (20)     NULL,
    [AcessoCO]                                  VARCHAR (20)     NULL,
    [DataLimitePA]                              VARCHAR (20)     NULL,
    [DataAcessoPA]                              VARCHAR (20)     NULL,
    [AcessoPA]                                  VARCHAR (20)     NULL,
    [TituloRelOC]                               VARCHAR (30)     NULL,
    [TituloRelOS]                               VARCHAR (30)     NULL,
    [TipoValorItem]                             INT              NULL,
    [EmpenhoObrigatorioContrato]                BIT              NULL,
    [PedidoExclusivoUnidade]                    BIT              NULL,
    [TituloRelCS]                               VARCHAR (50)     NULL,
    [DescricaoTransfTermo]                      TEXT             NULL,
    [LicencasAL]                                VARCHAR (20)     NULL,
    [LicencasCO]                                VARCHAR (20)     NULL,
    [LicencasPA]                                VARCHAR (20)     NULL,
    [AvisoVencimentoContrato]                   VARCHAR (3)      NULL,
    [AvisoVencimentoSeguro]                     VARCHAR (3)      NULL,
    [TextoEmailCotWebCabecalho]                 TEXT             NULL,
    [TextoEmailCotWebRodape]                    TEXT             NULL,
    [TextoEmailCotWebAssinatura1]               TEXT             NULL,
    [TextoEmailCotWebAssinatura2]               TEXT             NULL,
    [AvisoItensAdquiridosOrdem]                 VARCHAR (3)      NULL,
    [ModalidadeRegistroPreco]                   BIT              NULL,
    [TextoCabecalhoRegPreco]                    TEXT             NULL,
    [TextoRodapeRegPreco]                       TEXT             NULL,
    [TextoAssinatura1RegPreco]                  TEXT             NULL,
    [TextoAssinatura2RegPreco]                  TEXT             NULL,
    [TituloAtesto]                              NVARCHAR (100)   NULL,
    [CabecalhoAtesto]                           TEXT             NULL,
    [RodapeAtesto]                              TEXT             NULL,
    [AssinaturaContrato]                        TEXT             NULL,
    [BloquearAtendimentoPedido]                 BIT              NULL,
    [BrasaoRepublica]                           IMAGE            NULL,
    [IncrementoCertificacao]                    VARCHAR (4)      NULL,
    [NumCertificadoSequencial]                  BIT              NULL,
    [Assinatura01]                              VARCHAR (200)    NULL,
    [Cargo01]                                   VARCHAR (200)    NULL,
    [Registro01]                                VARCHAR (200)    NULL,
    [Cpf01]                                     VARCHAR (200)    NULL,
    [MultiplosLocaisEntrega]                    BIT              NULL,
    [IdContaPatrimonioAL]                       INT              NULL,
    [IdContaEntrada]                            INT              NULL,
    [IdContaSaida]                              INT              NULL,
    [DataContabilizacaoAL]                      DATETIME         NULL,
    [IdContaAquisicaoBM]                        INT              NULL,
    [IdContaAquisicaoBI]                        INT              NULL,
    [IdContaAlienacaoBM]                        INT              NULL,
    [IdContaAlienacaoBI]                        INT              NULL,
    [DataContabilizacaoPAT]                     DATETIME         NULL,
    [IdContaBensMoveis]                         INT              NULL,
    [IdContaBensImoveis]                        INT              NULL,
    [IdContaReavaliacaoBM]                      INT              NULL,
    [IdContaReavaliacaoBI]                      INT              NULL,
    [DescItensMoveisObrigatorio]                BIT              NULL,
    [DescItensImoveisObrigatorio]               BIT              NULL,
    [NaturezaOrdemObrigatoria]                  BIT              NULL,
    [ImprimeLocalExecucaoOS]                    BIT              NULL,
    [AvisoEmpenhoRecusado]                      VARCHAR (3)      NULL,
    [NumerarTermoResponsabilidade]              BIT              NULL,
    [LinkSispatWeb]                             VARCHAR (50)     NULL,
    [UtilizaItemSemValorRef]                    BIT              NULL,
    [ExibeBrasaoRelExternos]                    BIT              NULL,
    [AvisoVencimentoParcelasContratos]          VARCHAR (3)      NULL,
    [InventarioMesmoPeriodo]                    BIT              NULL,
    [PedidoExibeOutrosServicos]                 BIT              NULL,
    [PedidoExibeJustificativa]                  BIT              NULL,
    [PedidoExibeEstoque]                        BIT              NULL,
    [PedidoExibeValorEstimado]                  BIT              NULL,
    [PedidoExibeJustificativaOutrosItens]       BIT              NULL,
    [LiberarDepreciacao]                        BIT              NULL,
    [IntervaloAvisoDepreciacao]                 INT              NULL,
    [PeridiocidadeDepreciacao]                  INT              NULL,
    [IdEstadoConservDepreciacao]                INT              NULL,
    [ProximaExibicaoAvisoDepreciacao]           DATETIME         NULL,
    [IniciaDepreciacaoPorEstadoConserv]         BIT              NULL,
    [IdEstadoConservDeprecTransf]               INT              NULL,
    [IdEstadoConservDeprecOrigem]               INT              NULL,
    [AvisoImportacaoCotacoes]                   VARCHAR (3)      NULL,
    [ExibeAtendimentoServico]                   BIT              DEFAULT ((0)) NULL,
    [ImportacaoXML]                             INT              NULL,
    [DataPeriodoMovimentacaoIni]                DATETIME         NULL,
    [DataPeriodoMovimentacaoFim]                DATETIME         NULL,
    [UtilizaFinalidadePedido]                   BIT              CONSTRAINT [DF_ConfiguracoesSG_UtilizaFinalidadePedido] DEFAULT ((0)) NOT NULL,
    [PedidoImprimePedidoSolicitacao]            BIT              NULL,
    [PedidoSequenciaAutorizacao]                BIT              CONSTRAINT [DEF_PedidoSequenciaAutorizacao] DEFAULT ((0)) NOT NULL,
    [PedidoURLArquivoSolicitacao]               VARCHAR (200)    NULL,
    [PedidoAnexaArquivoSolicitacao]             BIT              CONSTRAINT [DEF_PedidoAnexaArquivoSolicitacao] DEFAULT ((0)) NOT NULL,
    [ImportacaoXMLAtualizaMovBem]               BIT              CONSTRAINT [DF_ConfiguracoesSG_ImportacaoXMLAtualizaMovBem] DEFAULT ((1)) NOT NULL,
    [AssinaturaTermoRepactuacao]                VARCHAR (200)    NULL,
    [FATUtilizaFaturamento]                     BIT              CONSTRAINT [DF_ConfiguracoesSG_FATUtilizaFaturamento] DEFAULT ((0)) NOT NULL,
    [FATPrazoParaFaturamento]                   VARCHAR (3)      NULL,
    [FATPrazoVencNotasDebito]                   VARCHAR (3)      NULL,
    [FATPrazoInadimplencia]                     VARCHAR (3)      NULL,
    [FATIntervaloAlerta]                        VARCHAR (3)      NULL,
    [FATAgendamentoAlerta]                      DATETIME         NULL,
    [FATIncrementoNotaDebito]                   INT              NULL,
    [FatTextoCabecalhoEmailND]                  VARCHAR (8000)   NULL,
    [FatTextoRodapeEmailND]                     VARCHAR (8000)   NULL,
    [FatTextoAssinatura1EmailND]                VARCHAR (2000)   NULL,
    [FatTextoAssinatura2EmailND]                VARCHAR (2000)   NULL,
    [FATAnexarNotaDebitoEmail]                  BIT              CONSTRAINT [DF_ConfiguracoesSG_FATAnexarNotaDebitoEmail] DEFAULT ((0)) NOT NULL,
    [FatTextoCabecalhoAutPed]                   VARCHAR (8000)   NULL,
    [FatTextoRodapeAutPed]                      VARCHAR (8000)   NULL,
    [FatTextoAssinatura1AutPed]                 VARCHAR (2000)   NULL,
    [FatTextoAssinatura2AutPed]                 VARCHAR (2000)   NULL,
    [FatAssinatura1NotaDebito]                  VARCHAR (2000)   NULL,
    [SepararItemOrdemCompra]                    BIT              DEFAULT ((0)) NOT NULL,
    [CaptionNumProtocolo]                       VARCHAR (450)    NULL,
    [MultiplosLocaisEntregaPAT]                 BIT              NULL,
    [UtilizaContabilizacaoMCASP]                BIT              CONSTRAINT [DF_ConfiguracoesSG_UtilizaContabilizacaoMCASP] DEFAULT ((0)) NOT NULL,
    [DataContabilizacaoAL_MCASP]                DATETIME         NULL,
    [DataContabilizacaoPAT_MCASP]               DATETIME         NULL,
    [IdPlanoContaMCASPReavaliacaoAumentativaBM] UNIQUEIDENTIFIER NULL,
    [IdPlanoContaMCASPReavaliacaoDiminutivaBM]  UNIQUEIDENTIFIER NULL,
    [IdPlanoContaMCASPAlmoxarifado]             UNIQUEIDENTIFIER NULL,
    [AlertaCadastroOrdem]                       INT              NULL,
    [AlertaCadastroOrdemQtdDias]                INT              NULL,
    [AlertaRecebimentoProcessoCompra]           INT              NULL,
    [EnderecoTemp]                              VARCHAR (50)     NULL,
    [FechaAlm]                                  VARCHAR (1)      NULL,
    [FechaAlmDataInicial]                       DATETIME         NULL,
    [FechaAlmDataFinal]                         DATETIME         NULL,
    [CasasDecimais]                             INT              NULL,
    [TamanhoFonte]                              INT              NULL,
    [ContabilizaMCASPInventarioMenos]           BIT              DEFAULT ((1)) NULL,
    [IntervaloAvisoDepreciacaoBI]               INT              NULL,
    [PeridiocidadeDepreciacaoBI]                INT              NULL,
    [ProximaExibicaoAvisoDepreciacaoBI]         DATETIME         NULL,
    [ClassificacaoItensOrdemCompra]             INT              NULL,
    [PermitirAlterarDtPrevLicit]                BIT              CONSTRAINT [DF_ConfiguracoesSG_PermitirAlterarDtPrevLicit] DEFAULT ((0)) NOT NULL,
    [TiposMovimentacaoVerificados]              VARCHAR (1)      NULL,
    [DtInicioNovaContabilizacaoAL]              DATETIME         NULL,
    [DtInicioHistoricoBaixaBem]                 DATETIME         NULL,
    [ExibeSaldoRealBalancete]                   BIT              NULL,
    [BloqueiaSispatConversao]                   BIT              NULL,
    [BloqueiaSialmConversao]                    BIT              NULL,
    [AssinaturaBA1]                             TEXT             NULL,
    [AssinaturaBA2]                             TEXT             NULL,
    [AssinaturaBA3]                             TEXT             NULL,
    [AssinaturaBASIALM1]                        TEXT             NULL,
    [AssinaturaBASIALM2]                        TEXT             NULL,
    [AssinaturaBASIALM3]                        TEXT             NULL,
    [BloqueiaSICCLConversao]                    BIT              NULL,
    [DataConversaoSICCL]                        DATETIME         NULL,
    [UtilizaDataConversao]                      BIT              NULL,
    [IdUnidadeConversao]                        INT              NULL,
    [IdResponsavelConversao]                    INT              NULL,
    CONSTRAINT [FK_ConfiguracoesSG_Responsaveis] FOREIGN KEY ([IdResponsavelConversao]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ConfiguracoesSG_Unidades] FOREIGN KEY ([IdUnidadeConversao]) REFERENCES [dbo].[Unidades] ([IdUnidade]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ConfiguracoesSG] ON [Implanta_CRPAM].[dbo].[ConfiguracoesSG] 
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
SET @TableName = 'ConfiguracoesSG'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo =  CASE 
         			            WHEN AvisaA4 IS NULL THEN ' AvisaA4 : «Nulo» '
                                         WHEN AvisaA4 = 0 THEN ' AvisaA4 : «Falso» '
                                         WHEN AvisaA4 = 1 THEN ' AvisaA4 : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  MostraConsumoMensal IS NULL THEN ' MostraConsumoMensal : «Nulo» '
                                              WHEN  MostraConsumoMensal = 0 THEN ' MostraConsumoMensal : «Falso» '
                                              WHEN  MostraConsumoMensal = 1 THEN ' MostraConsumoMensal : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraUltimaCompra IS NULL THEN ' MostraUltimaCompra : «Nulo» '
                                              WHEN  MostraUltimaCompra = 0 THEN ' MostraUltimaCompra : «Falso» '
                                              WHEN  MostraUltimaCompra = 1 THEN ' MostraUltimaCompra : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraUltimaSaida IS NULL THEN ' MostraUltimaSaida : «Nulo» '
                                              WHEN  MostraUltimaSaida = 0 THEN ' MostraUltimaSaida : «Falso» '
                                              WHEN  MostraUltimaSaida = 1 THEN ' MostraUltimaSaida : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ResponsavelUnidade IS NULL THEN ' ResponsavelUnidade : «Nulo» '
                                              WHEN  ResponsavelUnidade = 0 THEN ' ResponsavelUnidade : «Falso» '
                                              WHEN  ResponsavelUnidade = 1 THEN ' ResponsavelUnidade : «Verdadeiro» '
                                    END 
                         + '| IdAlmoxarifadoPadraoOrdem : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoPadraoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifadoPadraoPedido : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoPadraoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoPatrimonio : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoPatrimonio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoTermo : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoResponsavelTermo : «' + RTRIM( ISNULL( CAST (CargoResponsavelTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadePadraoPatrimonio : «' + RTRIM( ISNULL( CAST (IdUnidadePadraoPatrimonio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoOrdem : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoDevolucaoOrdem : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoDevolucaoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoPedido : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoDevolucaoPedido : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoDevolucaoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Margem : «' + RTRIM( ISNULL( CAST (Margem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizaSiglaUnidade IS NULL THEN ' VisualizaSiglaUnidade : «Nulo» '
                                              WHEN  VisualizaSiglaUnidade = 0 THEN ' VisualizaSiglaUnidade : «Falso» '
                                              WHEN  VisualizaSiglaUnidade = 1 THEN ' VisualizaSiglaUnidade : «Verdadeiro» '
                                    END 
                         + '| IdTipoBemPadrao : «' + RTRIM( ISNULL( CAST (IdTipoBemPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaseLimiteProcesso : «' + RTRIM( ISNULL( CAST (IdFaseLimiteProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaAL : «' + RTRIM( ISNULL( CAST (OrdemTelaAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaBM : «' + RTRIM( ISNULL( CAST (OrdemTelaBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaBI : «' + RTRIM( ISNULL( CAST (OrdemTelaBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MascaraMescladaLI IS NULL THEN ' MascaraMescladaLI : «Nulo» '
                                              WHEN  MascaraMescladaLI = 0 THEN ' MascaraMescladaLI : «Falso» '
                                              WHEN  MascaraMescladaLI = 1 THEN ' MascaraMescladaLI : «Verdadeiro» '
                                    END 
                         + '| DataLimiteAL : «' + RTRIM( ISNULL( CAST (DataLimiteAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoAL : «' + RTRIM( ISNULL( CAST (DataAcessoAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoAL : «' + RTRIM( ISNULL( CAST (AcessoAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteCO : «' + RTRIM( ISNULL( CAST (DataLimiteCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoCO : «' + RTRIM( ISNULL( CAST (DataAcessoCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoCO : «' + RTRIM( ISNULL( CAST (AcessoCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimitePA : «' + RTRIM( ISNULL( CAST (DataLimitePA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoPA : «' + RTRIM( ISNULL( CAST (DataAcessoPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoPA : «' + RTRIM( ISNULL( CAST (AcessoPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelOC : «' + RTRIM( ISNULL( CAST (TituloRelOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelOS : «' + RTRIM( ISNULL( CAST (TituloRelOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoValorItem : «' + RTRIM( ISNULL( CAST (TipoValorItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmpenhoObrigatorioContrato IS NULL THEN ' EmpenhoObrigatorioContrato : «Nulo» '
                                              WHEN  EmpenhoObrigatorioContrato = 0 THEN ' EmpenhoObrigatorioContrato : «Falso» '
                                              WHEN  EmpenhoObrigatorioContrato = 1 THEN ' EmpenhoObrigatorioContrato : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExclusivoUnidade IS NULL THEN ' PedidoExclusivoUnidade : «Nulo» '
                                              WHEN  PedidoExclusivoUnidade = 0 THEN ' PedidoExclusivoUnidade : «Falso» '
                                              WHEN  PedidoExclusivoUnidade = 1 THEN ' PedidoExclusivoUnidade : «Verdadeiro» '
                                    END 
                         + '| TituloRelCS : «' + RTRIM( ISNULL( CAST (TituloRelCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasAL : «' + RTRIM( ISNULL( CAST (LicencasAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasCO : «' + RTRIM( ISNULL( CAST (LicencasCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasPA : «' + RTRIM( ISNULL( CAST (LicencasPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoVencimentoContrato : «' + RTRIM( ISNULL( CAST (AvisoVencimentoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoVencimentoSeguro : «' + RTRIM( ISNULL( CAST (AvisoVencimentoSeguro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoItensAdquiridosOrdem : «' + RTRIM( ISNULL( CAST (AvisoItensAdquiridosOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ModalidadeRegistroPreco IS NULL THEN ' ModalidadeRegistroPreco : «Nulo» '
                                              WHEN  ModalidadeRegistroPreco = 0 THEN ' ModalidadeRegistroPreco : «Falso» '
                                              WHEN  ModalidadeRegistroPreco = 1 THEN ' ModalidadeRegistroPreco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAtendimentoPedido IS NULL THEN ' BloquearAtendimentoPedido : «Nulo» '
                                              WHEN  BloquearAtendimentoPedido = 0 THEN ' BloquearAtendimentoPedido : «Falso» '
                                              WHEN  BloquearAtendimentoPedido = 1 THEN ' BloquearAtendimentoPedido : «Verdadeiro» '
                                    END 
                         + '| IncrementoCertificacao : «' + RTRIM( ISNULL( CAST (IncrementoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumCertificadoSequencial IS NULL THEN ' NumCertificadoSequencial : «Nulo» '
                                              WHEN  NumCertificadoSequencial = 0 THEN ' NumCertificadoSequencial : «Falso» '
                                              WHEN  NumCertificadoSequencial = 1 THEN ' NumCertificadoSequencial : «Verdadeiro» '
                                    END 
                         + '| Assinatura01 : «' + RTRIM( ISNULL( CAST (Assinatura01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo01 : «' + RTRIM( ISNULL( CAST (Cargo01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro01 : «' + RTRIM( ISNULL( CAST (Registro01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf01 : «' + RTRIM( ISNULL( CAST (Cpf01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MultiplosLocaisEntrega IS NULL THEN ' MultiplosLocaisEntrega : «Nulo» '
                                              WHEN  MultiplosLocaisEntrega = 0 THEN ' MultiplosLocaisEntrega : «Falso» '
                                              WHEN  MultiplosLocaisEntrega = 1 THEN ' MultiplosLocaisEntrega : «Verdadeiro» '
                                    END 
                         + '| IdContaPatrimonioAL : «' + RTRIM( ISNULL( CAST (IdContaPatrimonioAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaEntrada : «' + RTRIM( ISNULL( CAST (IdContaEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaSaida : «' + RTRIM( ISNULL( CAST (IdContaSaida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| IdContaAquisicaoBM : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBI : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBM : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBI : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT, 113 ),'Nulo'))+'» '
                         + '| IdContaBensMoveis : «' + RTRIM( ISNULL( CAST (IdContaBensMoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensImoveis : «' + RTRIM( ISNULL( CAST (IdContaBensImoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBM : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBI : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DescItensMoveisObrigatorio IS NULL THEN ' DescItensMoveisObrigatorio : «Nulo» '
                                              WHEN  DescItensMoveisObrigatorio = 0 THEN ' DescItensMoveisObrigatorio : «Falso» '
                                              WHEN  DescItensMoveisObrigatorio = 1 THEN ' DescItensMoveisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DescItensImoveisObrigatorio IS NULL THEN ' DescItensImoveisObrigatorio : «Nulo» '
                                              WHEN  DescItensImoveisObrigatorio = 0 THEN ' DescItensImoveisObrigatorio : «Falso» '
                                              WHEN  DescItensImoveisObrigatorio = 1 THEN ' DescItensImoveisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaturezaOrdemObrigatoria IS NULL THEN ' NaturezaOrdemObrigatoria : «Nulo» '
                                              WHEN  NaturezaOrdemObrigatoria = 0 THEN ' NaturezaOrdemObrigatoria : «Falso» '
                                              WHEN  NaturezaOrdemObrigatoria = 1 THEN ' NaturezaOrdemObrigatoria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeLocalExecucaoOS IS NULL THEN ' ImprimeLocalExecucaoOS : «Nulo» '
                                              WHEN  ImprimeLocalExecucaoOS = 0 THEN ' ImprimeLocalExecucaoOS : «Falso» '
                                              WHEN  ImprimeLocalExecucaoOS = 1 THEN ' ImprimeLocalExecucaoOS : «Verdadeiro» '
                                    END 
                         + '| AvisoEmpenhoRecusado : «' + RTRIM( ISNULL( CAST (AvisoEmpenhoRecusado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumerarTermoResponsabilidade IS NULL THEN ' NumerarTermoResponsabilidade : «Nulo» '
                                              WHEN  NumerarTermoResponsabilidade = 0 THEN ' NumerarTermoResponsabilidade : «Falso» '
                                              WHEN  NumerarTermoResponsabilidade = 1 THEN ' NumerarTermoResponsabilidade : «Verdadeiro» '
                                    END 
                         + '| LinkSispatWeb : «' + RTRIM( ISNULL( CAST (LinkSispatWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaItemSemValorRef IS NULL THEN ' UtilizaItemSemValorRef : «Nulo» '
                                              WHEN  UtilizaItemSemValorRef = 0 THEN ' UtilizaItemSemValorRef : «Falso» '
                                              WHEN  UtilizaItemSemValorRef = 1 THEN ' UtilizaItemSemValorRef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeBrasaoRelExternos IS NULL THEN ' ExibeBrasaoRelExternos : «Nulo» '
                                              WHEN  ExibeBrasaoRelExternos = 0 THEN ' ExibeBrasaoRelExternos : «Falso» '
                                              WHEN  ExibeBrasaoRelExternos = 1 THEN ' ExibeBrasaoRelExternos : «Verdadeiro» '
                                    END 
                         + '| AvisoVencimentoParcelasContratos : «' + RTRIM( ISNULL( CAST (AvisoVencimentoParcelasContratos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InventarioMesmoPeriodo IS NULL THEN ' InventarioMesmoPeriodo : «Nulo» '
                                              WHEN  InventarioMesmoPeriodo = 0 THEN ' InventarioMesmoPeriodo : «Falso» '
                                              WHEN  InventarioMesmoPeriodo = 1 THEN ' InventarioMesmoPeriodo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeOutrosServicos IS NULL THEN ' PedidoExibeOutrosServicos : «Nulo» '
                                              WHEN  PedidoExibeOutrosServicos = 0 THEN ' PedidoExibeOutrosServicos : «Falso» '
                                              WHEN  PedidoExibeOutrosServicos = 1 THEN ' PedidoExibeOutrosServicos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeJustificativa IS NULL THEN ' PedidoExibeJustificativa : «Nulo» '
                                              WHEN  PedidoExibeJustificativa = 0 THEN ' PedidoExibeJustificativa : «Falso» '
                                              WHEN  PedidoExibeJustificativa = 1 THEN ' PedidoExibeJustificativa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeEstoque IS NULL THEN ' PedidoExibeEstoque : «Nulo» '
                                              WHEN  PedidoExibeEstoque = 0 THEN ' PedidoExibeEstoque : «Falso» '
                                              WHEN  PedidoExibeEstoque = 1 THEN ' PedidoExibeEstoque : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeValorEstimado IS NULL THEN ' PedidoExibeValorEstimado : «Nulo» '
                                              WHEN  PedidoExibeValorEstimado = 0 THEN ' PedidoExibeValorEstimado : «Falso» '
                                              WHEN  PedidoExibeValorEstimado = 1 THEN ' PedidoExibeValorEstimado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeJustificativaOutrosItens IS NULL THEN ' PedidoExibeJustificativaOutrosItens : «Nulo» '
                                              WHEN  PedidoExibeJustificativaOutrosItens = 0 THEN ' PedidoExibeJustificativaOutrosItens : «Falso» '
                                              WHEN  PedidoExibeJustificativaOutrosItens = 1 THEN ' PedidoExibeJustificativaOutrosItens : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LiberarDepreciacao IS NULL THEN ' LiberarDepreciacao : «Nulo» '
                                              WHEN  LiberarDepreciacao = 0 THEN ' LiberarDepreciacao : «Falso» '
                                              WHEN  LiberarDepreciacao = 1 THEN ' LiberarDepreciacao : «Verdadeiro» '
                                    END 
                         + '| IntervaloAvisoDepreciacao : «' + RTRIM( ISNULL( CAST (IntervaloAvisoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeridiocidadeDepreciacao : «' + RTRIM( ISNULL( CAST (PeridiocidadeDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstadoConservDepreciacao : «' + RTRIM( ISNULL( CAST (IdEstadoConservDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximaExibicaoAvisoDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, ProximaExibicaoAvisoDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IniciaDepreciacaoPorEstadoConserv IS NULL THEN ' IniciaDepreciacaoPorEstadoConserv : «Nulo» '
                                              WHEN  IniciaDepreciacaoPorEstadoConserv = 0 THEN ' IniciaDepreciacaoPorEstadoConserv : «Falso» '
                                              WHEN  IniciaDepreciacaoPorEstadoConserv = 1 THEN ' IniciaDepreciacaoPorEstadoConserv : «Verdadeiro» '
                                    END 
                         + '| IdEstadoConservDeprecTransf : «' + RTRIM( ISNULL( CAST (IdEstadoConservDeprecTransf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstadoConservDeprecOrigem : «' + RTRIM( ISNULL( CAST (IdEstadoConservDeprecOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoImportacaoCotacoes : «' + RTRIM( ISNULL( CAST (AvisoImportacaoCotacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeAtendimentoServico IS NULL THEN ' ExibeAtendimentoServico : «Nulo» '
                                              WHEN  ExibeAtendimentoServico = 0 THEN ' ExibeAtendimentoServico : «Falso» '
                                              WHEN  ExibeAtendimentoServico = 1 THEN ' ExibeAtendimentoServico : «Verdadeiro» '
                                    END 
                         + '| ImportacaoXML : «' + RTRIM( ISNULL( CAST (ImportacaoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPeriodoMovimentacaoIni : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPeriodoMovimentacaoIni, 113 ),'Nulo'))+'» '
                         + '| DataPeriodoMovimentacaoFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPeriodoMovimentacaoFim, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaFinalidadePedido IS NULL THEN ' UtilizaFinalidadePedido : «Nulo» '
                                              WHEN  UtilizaFinalidadePedido = 0 THEN ' UtilizaFinalidadePedido : «Falso» '
                                              WHEN  UtilizaFinalidadePedido = 1 THEN ' UtilizaFinalidadePedido : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoImprimePedidoSolicitacao IS NULL THEN ' PedidoImprimePedidoSolicitacao : «Nulo» '
                                              WHEN  PedidoImprimePedidoSolicitacao = 0 THEN ' PedidoImprimePedidoSolicitacao : «Falso» '
                                              WHEN  PedidoImprimePedidoSolicitacao = 1 THEN ' PedidoImprimePedidoSolicitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoSequenciaAutorizacao IS NULL THEN ' PedidoSequenciaAutorizacao : «Nulo» '
                                              WHEN  PedidoSequenciaAutorizacao = 0 THEN ' PedidoSequenciaAutorizacao : «Falso» '
                                              WHEN  PedidoSequenciaAutorizacao = 1 THEN ' PedidoSequenciaAutorizacao : «Verdadeiro» '
                                    END 
                         + '| PedidoURLArquivoSolicitacao : «' + RTRIM( ISNULL( CAST (PedidoURLArquivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PedidoAnexaArquivoSolicitacao IS NULL THEN ' PedidoAnexaArquivoSolicitacao : «Nulo» '
                                              WHEN  PedidoAnexaArquivoSolicitacao = 0 THEN ' PedidoAnexaArquivoSolicitacao : «Falso» '
                                              WHEN  PedidoAnexaArquivoSolicitacao = 1 THEN ' PedidoAnexaArquivoSolicitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImportacaoXMLAtualizaMovBem IS NULL THEN ' ImportacaoXMLAtualizaMovBem : «Nulo» '
                                              WHEN  ImportacaoXMLAtualizaMovBem = 0 THEN ' ImportacaoXMLAtualizaMovBem : «Falso» '
                                              WHEN  ImportacaoXMLAtualizaMovBem = 1 THEN ' ImportacaoXMLAtualizaMovBem : «Verdadeiro» '
                                    END 
                         + '| AssinaturaTermoRepactuacao : «' + RTRIM( ISNULL( CAST (AssinaturaTermoRepactuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FATUtilizaFaturamento IS NULL THEN ' FATUtilizaFaturamento : «Nulo» '
                                              WHEN  FATUtilizaFaturamento = 0 THEN ' FATUtilizaFaturamento : «Falso» '
                                              WHEN  FATUtilizaFaturamento = 1 THEN ' FATUtilizaFaturamento : «Verdadeiro» '
                                    END 
                         + '| FATPrazoParaFaturamento : «' + RTRIM( ISNULL( CAST (FATPrazoParaFaturamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATPrazoVencNotasDebito : «' + RTRIM( ISNULL( CAST (FATPrazoVencNotasDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATPrazoInadimplencia : «' + RTRIM( ISNULL( CAST (FATPrazoInadimplencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATIntervaloAlerta : «' + RTRIM( ISNULL( CAST (FATIntervaloAlerta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATAgendamentoAlerta : «' + RTRIM( ISNULL( CONVERT (CHAR, FATAgendamentoAlerta, 113 ),'Nulo'))+'» '
                         + '| FATIncrementoNotaDebito : «' + RTRIM( ISNULL( CAST (FATIncrementoNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoCabecalhoEmailND : «' + RTRIM( ISNULL( CAST (FatTextoCabecalhoEmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoRodapeEmailND : «' + RTRIM( ISNULL( CAST (FatTextoRodapeEmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura1EmailND : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura1EmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura2EmailND : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura2EmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FATAnexarNotaDebitoEmail IS NULL THEN ' FATAnexarNotaDebitoEmail : «Nulo» '
                                              WHEN  FATAnexarNotaDebitoEmail = 0 THEN ' FATAnexarNotaDebitoEmail : «Falso» '
                                              WHEN  FATAnexarNotaDebitoEmail = 1 THEN ' FATAnexarNotaDebitoEmail : «Verdadeiro» '
                                    END 
                         + '| FatTextoCabecalhoAutPed : «' + RTRIM( ISNULL( CAST (FatTextoCabecalhoAutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoRodapeAutPed : «' + RTRIM( ISNULL( CAST (FatTextoRodapeAutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura1AutPed : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura1AutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura2AutPed : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura2AutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatAssinatura1NotaDebito : «' + RTRIM( ISNULL( CAST (FatAssinatura1NotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SepararItemOrdemCompra IS NULL THEN ' SepararItemOrdemCompra : «Nulo» '
                                              WHEN  SepararItemOrdemCompra = 0 THEN ' SepararItemOrdemCompra : «Falso» '
                                              WHEN  SepararItemOrdemCompra = 1 THEN ' SepararItemOrdemCompra : «Verdadeiro» '
                                    END 
                         + '| CaptionNumProtocolo : «' + RTRIM( ISNULL( CAST (CaptionNumProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MultiplosLocaisEntregaPAT IS NULL THEN ' MultiplosLocaisEntregaPAT : «Nulo» '
                                              WHEN  MultiplosLocaisEntregaPAT = 0 THEN ' MultiplosLocaisEntregaPAT : «Falso» '
                                              WHEN  MultiplosLocaisEntregaPAT = 1 THEN ' MultiplosLocaisEntregaPAT : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaContabilizacaoMCASP IS NULL THEN ' UtilizaContabilizacaoMCASP : «Nulo» '
                                              WHEN  UtilizaContabilizacaoMCASP = 0 THEN ' UtilizaContabilizacaoMCASP : «Falso» '
                                              WHEN  UtilizaContabilizacaoMCASP = 1 THEN ' UtilizaContabilizacaoMCASP : «Verdadeiro» '
                                    END 
                         + '| DataContabilizacaoAL_MCASP : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL_MCASP, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT_MCASP : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT_MCASP, 113 ),'Nulo'))+'» '
                         + '| AlertaCadastroOrdem : «' + RTRIM( ISNULL( CAST (AlertaCadastroOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlertaCadastroOrdemQtdDias : «' + RTRIM( ISNULL( CAST (AlertaCadastroOrdemQtdDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlertaRecebimentoProcessoCompra : «' + RTRIM( ISNULL( CAST (AlertaRecebimentoProcessoCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoTemp : «' + RTRIM( ISNULL( CAST (EnderecoTemp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FechaAlm : «' + RTRIM( ISNULL( CAST (FechaAlm AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FechaAlmDataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, FechaAlmDataInicial, 113 ),'Nulo'))+'» '
                         + '| FechaAlmDataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, FechaAlmDataFinal, 113 ),'Nulo'))+'» '
                         + '| CasasDecimais : «' + RTRIM( ISNULL( CAST (CasasDecimais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoFonte : «' + RTRIM( ISNULL( CAST (TamanhoFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ContabilizaMCASPInventarioMenos IS NULL THEN ' ContabilizaMCASPInventarioMenos : «Nulo» '
                                              WHEN  ContabilizaMCASPInventarioMenos = 0 THEN ' ContabilizaMCASPInventarioMenos : «Falso» '
                                              WHEN  ContabilizaMCASPInventarioMenos = 1 THEN ' ContabilizaMCASPInventarioMenos : «Verdadeiro» '
                                    END 
                         + '| IntervaloAvisoDepreciacaoBI : «' + RTRIM( ISNULL( CAST (IntervaloAvisoDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeridiocidadeDepreciacaoBI : «' + RTRIM( ISNULL( CAST (PeridiocidadeDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximaExibicaoAvisoDepreciacaoBI : «' + RTRIM( ISNULL( CONVERT (CHAR, ProximaExibicaoAvisoDepreciacaoBI, 113 ),'Nulo'))+'» '
                         + '| ClassificacaoItensOrdemCompra : «' + RTRIM( ISNULL( CAST (ClassificacaoItensOrdemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitirAlterarDtPrevLicit IS NULL THEN ' PermitirAlterarDtPrevLicit : «Nulo» '
                                              WHEN  PermitirAlterarDtPrevLicit = 0 THEN ' PermitirAlterarDtPrevLicit : «Falso» '
                                              WHEN  PermitirAlterarDtPrevLicit = 1 THEN ' PermitirAlterarDtPrevLicit : «Verdadeiro» '
                                    END 
                         + '| TiposMovimentacaoVerificados : «' + RTRIM( ISNULL( CAST (TiposMovimentacaoVerificados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtInicioNovaContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioNovaContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| DtInicioHistoricoBaixaBem : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioHistoricoBaixaBem, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeSaldoRealBalancete IS NULL THEN ' ExibeSaldoRealBalancete : «Nulo» '
                                              WHEN  ExibeSaldoRealBalancete = 0 THEN ' ExibeSaldoRealBalancete : «Falso» '
                                              WHEN  ExibeSaldoRealBalancete = 1 THEN ' ExibeSaldoRealBalancete : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSispatConversao IS NULL THEN ' BloqueiaSispatConversao : «Nulo» '
                                              WHEN  BloqueiaSispatConversao = 0 THEN ' BloqueiaSispatConversao : «Falso» '
                                              WHEN  BloqueiaSispatConversao = 1 THEN ' BloqueiaSispatConversao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSialmConversao IS NULL THEN ' BloqueiaSialmConversao : «Nulo» '
                                              WHEN  BloqueiaSialmConversao = 0 THEN ' BloqueiaSialmConversao : «Falso» '
                                              WHEN  BloqueiaSialmConversao = 1 THEN ' BloqueiaSialmConversao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSICCLConversao IS NULL THEN ' BloqueiaSICCLConversao : «Nulo» '
                                              WHEN  BloqueiaSICCLConversao = 0 THEN ' BloqueiaSICCLConversao : «Falso» '
                                              WHEN  BloqueiaSICCLConversao = 1 THEN ' BloqueiaSICCLConversao : «Verdadeiro» '
                                    END 
                         + '| DataConversaoSICCL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConversaoSICCL, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaDataConversao IS NULL THEN ' UtilizaDataConversao : «Nulo» '
                                              WHEN  UtilizaDataConversao = 0 THEN ' UtilizaDataConversao : «Falso» '
                                              WHEN  UtilizaDataConversao = 1 THEN ' UtilizaDataConversao : «Verdadeiro» '
                                    END 
                         + '| IdUnidadeConversao : «' + RTRIM( ISNULL( CAST (IdUnidadeConversao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelConversao : «' + RTRIM( ISNULL( CAST (IdResponsavelConversao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 =  CASE 
         			            WHEN AvisaA4 IS NULL THEN ' AvisaA4 : «Nulo» '
                                         WHEN AvisaA4 = 0 THEN ' AvisaA4 : «Falso» '
                                         WHEN AvisaA4 = 1 THEN ' AvisaA4 : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  MostraConsumoMensal IS NULL THEN ' MostraConsumoMensal : «Nulo» '
                                              WHEN  MostraConsumoMensal = 0 THEN ' MostraConsumoMensal : «Falso» '
                                              WHEN  MostraConsumoMensal = 1 THEN ' MostraConsumoMensal : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraUltimaCompra IS NULL THEN ' MostraUltimaCompra : «Nulo» '
                                              WHEN  MostraUltimaCompra = 0 THEN ' MostraUltimaCompra : «Falso» '
                                              WHEN  MostraUltimaCompra = 1 THEN ' MostraUltimaCompra : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraUltimaSaida IS NULL THEN ' MostraUltimaSaida : «Nulo» '
                                              WHEN  MostraUltimaSaida = 0 THEN ' MostraUltimaSaida : «Falso» '
                                              WHEN  MostraUltimaSaida = 1 THEN ' MostraUltimaSaida : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ResponsavelUnidade IS NULL THEN ' ResponsavelUnidade : «Nulo» '
                                              WHEN  ResponsavelUnidade = 0 THEN ' ResponsavelUnidade : «Falso» '
                                              WHEN  ResponsavelUnidade = 1 THEN ' ResponsavelUnidade : «Verdadeiro» '
                                    END 
                         + '| IdAlmoxarifadoPadraoOrdem : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoPadraoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifadoPadraoPedido : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoPadraoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoPatrimonio : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoPatrimonio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoTermo : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoResponsavelTermo : «' + RTRIM( ISNULL( CAST (CargoResponsavelTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadePadraoPatrimonio : «' + RTRIM( ISNULL( CAST (IdUnidadePadraoPatrimonio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoOrdem : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoDevolucaoOrdem : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoDevolucaoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoPedido : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoDevolucaoPedido : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoDevolucaoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Margem : «' + RTRIM( ISNULL( CAST (Margem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizaSiglaUnidade IS NULL THEN ' VisualizaSiglaUnidade : «Nulo» '
                                              WHEN  VisualizaSiglaUnidade = 0 THEN ' VisualizaSiglaUnidade : «Falso» '
                                              WHEN  VisualizaSiglaUnidade = 1 THEN ' VisualizaSiglaUnidade : «Verdadeiro» '
                                    END 
                         + '| IdTipoBemPadrao : «' + RTRIM( ISNULL( CAST (IdTipoBemPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaseLimiteProcesso : «' + RTRIM( ISNULL( CAST (IdFaseLimiteProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaAL : «' + RTRIM( ISNULL( CAST (OrdemTelaAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaBM : «' + RTRIM( ISNULL( CAST (OrdemTelaBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaBI : «' + RTRIM( ISNULL( CAST (OrdemTelaBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MascaraMescladaLI IS NULL THEN ' MascaraMescladaLI : «Nulo» '
                                              WHEN  MascaraMescladaLI = 0 THEN ' MascaraMescladaLI : «Falso» '
                                              WHEN  MascaraMescladaLI = 1 THEN ' MascaraMescladaLI : «Verdadeiro» '
                                    END 
                         + '| DataLimiteAL : «' + RTRIM( ISNULL( CAST (DataLimiteAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoAL : «' + RTRIM( ISNULL( CAST (DataAcessoAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoAL : «' + RTRIM( ISNULL( CAST (AcessoAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteCO : «' + RTRIM( ISNULL( CAST (DataLimiteCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoCO : «' + RTRIM( ISNULL( CAST (DataAcessoCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoCO : «' + RTRIM( ISNULL( CAST (AcessoCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimitePA : «' + RTRIM( ISNULL( CAST (DataLimitePA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoPA : «' + RTRIM( ISNULL( CAST (DataAcessoPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoPA : «' + RTRIM( ISNULL( CAST (AcessoPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelOC : «' + RTRIM( ISNULL( CAST (TituloRelOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelOS : «' + RTRIM( ISNULL( CAST (TituloRelOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoValorItem : «' + RTRIM( ISNULL( CAST (TipoValorItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmpenhoObrigatorioContrato IS NULL THEN ' EmpenhoObrigatorioContrato : «Nulo» '
                                              WHEN  EmpenhoObrigatorioContrato = 0 THEN ' EmpenhoObrigatorioContrato : «Falso» '
                                              WHEN  EmpenhoObrigatorioContrato = 1 THEN ' EmpenhoObrigatorioContrato : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExclusivoUnidade IS NULL THEN ' PedidoExclusivoUnidade : «Nulo» '
                                              WHEN  PedidoExclusivoUnidade = 0 THEN ' PedidoExclusivoUnidade : «Falso» '
                                              WHEN  PedidoExclusivoUnidade = 1 THEN ' PedidoExclusivoUnidade : «Verdadeiro» '
                                    END 
                         + '| TituloRelCS : «' + RTRIM( ISNULL( CAST (TituloRelCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasAL : «' + RTRIM( ISNULL( CAST (LicencasAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasCO : «' + RTRIM( ISNULL( CAST (LicencasCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasPA : «' + RTRIM( ISNULL( CAST (LicencasPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoVencimentoContrato : «' + RTRIM( ISNULL( CAST (AvisoVencimentoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoVencimentoSeguro : «' + RTRIM( ISNULL( CAST (AvisoVencimentoSeguro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoItensAdquiridosOrdem : «' + RTRIM( ISNULL( CAST (AvisoItensAdquiridosOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ModalidadeRegistroPreco IS NULL THEN ' ModalidadeRegistroPreco : «Nulo» '
                                              WHEN  ModalidadeRegistroPreco = 0 THEN ' ModalidadeRegistroPreco : «Falso» '
                                              WHEN  ModalidadeRegistroPreco = 1 THEN ' ModalidadeRegistroPreco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAtendimentoPedido IS NULL THEN ' BloquearAtendimentoPedido : «Nulo» '
                                              WHEN  BloquearAtendimentoPedido = 0 THEN ' BloquearAtendimentoPedido : «Falso» '
                                              WHEN  BloquearAtendimentoPedido = 1 THEN ' BloquearAtendimentoPedido : «Verdadeiro» '
                                    END 
                         + '| IncrementoCertificacao : «' + RTRIM( ISNULL( CAST (IncrementoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumCertificadoSequencial IS NULL THEN ' NumCertificadoSequencial : «Nulo» '
                                              WHEN  NumCertificadoSequencial = 0 THEN ' NumCertificadoSequencial : «Falso» '
                                              WHEN  NumCertificadoSequencial = 1 THEN ' NumCertificadoSequencial : «Verdadeiro» '
                                    END 
                         + '| Assinatura01 : «' + RTRIM( ISNULL( CAST (Assinatura01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo01 : «' + RTRIM( ISNULL( CAST (Cargo01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro01 : «' + RTRIM( ISNULL( CAST (Registro01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf01 : «' + RTRIM( ISNULL( CAST (Cpf01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MultiplosLocaisEntrega IS NULL THEN ' MultiplosLocaisEntrega : «Nulo» '
                                              WHEN  MultiplosLocaisEntrega = 0 THEN ' MultiplosLocaisEntrega : «Falso» '
                                              WHEN  MultiplosLocaisEntrega = 1 THEN ' MultiplosLocaisEntrega : «Verdadeiro» '
                                    END 
                         + '| IdContaPatrimonioAL : «' + RTRIM( ISNULL( CAST (IdContaPatrimonioAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaEntrada : «' + RTRIM( ISNULL( CAST (IdContaEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaSaida : «' + RTRIM( ISNULL( CAST (IdContaSaida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| IdContaAquisicaoBM : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBI : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBM : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBI : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT, 113 ),'Nulo'))+'» '
                         + '| IdContaBensMoveis : «' + RTRIM( ISNULL( CAST (IdContaBensMoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensImoveis : «' + RTRIM( ISNULL( CAST (IdContaBensImoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBM : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBI : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DescItensMoveisObrigatorio IS NULL THEN ' DescItensMoveisObrigatorio : «Nulo» '
                                              WHEN  DescItensMoveisObrigatorio = 0 THEN ' DescItensMoveisObrigatorio : «Falso» '
                                              WHEN  DescItensMoveisObrigatorio = 1 THEN ' DescItensMoveisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DescItensImoveisObrigatorio IS NULL THEN ' DescItensImoveisObrigatorio : «Nulo» '
                                              WHEN  DescItensImoveisObrigatorio = 0 THEN ' DescItensImoveisObrigatorio : «Falso» '
                                              WHEN  DescItensImoveisObrigatorio = 1 THEN ' DescItensImoveisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaturezaOrdemObrigatoria IS NULL THEN ' NaturezaOrdemObrigatoria : «Nulo» '
                                              WHEN  NaturezaOrdemObrigatoria = 0 THEN ' NaturezaOrdemObrigatoria : «Falso» '
                                              WHEN  NaturezaOrdemObrigatoria = 1 THEN ' NaturezaOrdemObrigatoria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeLocalExecucaoOS IS NULL THEN ' ImprimeLocalExecucaoOS : «Nulo» '
                                              WHEN  ImprimeLocalExecucaoOS = 0 THEN ' ImprimeLocalExecucaoOS : «Falso» '
                                              WHEN  ImprimeLocalExecucaoOS = 1 THEN ' ImprimeLocalExecucaoOS : «Verdadeiro» '
                                    END 
                         + '| AvisoEmpenhoRecusado : «' + RTRIM( ISNULL( CAST (AvisoEmpenhoRecusado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumerarTermoResponsabilidade IS NULL THEN ' NumerarTermoResponsabilidade : «Nulo» '
                                              WHEN  NumerarTermoResponsabilidade = 0 THEN ' NumerarTermoResponsabilidade : «Falso» '
                                              WHEN  NumerarTermoResponsabilidade = 1 THEN ' NumerarTermoResponsabilidade : «Verdadeiro» '
                                    END 
                         + '| LinkSispatWeb : «' + RTRIM( ISNULL( CAST (LinkSispatWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaItemSemValorRef IS NULL THEN ' UtilizaItemSemValorRef : «Nulo» '
                                              WHEN  UtilizaItemSemValorRef = 0 THEN ' UtilizaItemSemValorRef : «Falso» '
                                              WHEN  UtilizaItemSemValorRef = 1 THEN ' UtilizaItemSemValorRef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeBrasaoRelExternos IS NULL THEN ' ExibeBrasaoRelExternos : «Nulo» '
                                              WHEN  ExibeBrasaoRelExternos = 0 THEN ' ExibeBrasaoRelExternos : «Falso» '
                                              WHEN  ExibeBrasaoRelExternos = 1 THEN ' ExibeBrasaoRelExternos : «Verdadeiro» '
                                    END 
                         + '| AvisoVencimentoParcelasContratos : «' + RTRIM( ISNULL( CAST (AvisoVencimentoParcelasContratos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InventarioMesmoPeriodo IS NULL THEN ' InventarioMesmoPeriodo : «Nulo» '
                                              WHEN  InventarioMesmoPeriodo = 0 THEN ' InventarioMesmoPeriodo : «Falso» '
                                              WHEN  InventarioMesmoPeriodo = 1 THEN ' InventarioMesmoPeriodo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeOutrosServicos IS NULL THEN ' PedidoExibeOutrosServicos : «Nulo» '
                                              WHEN  PedidoExibeOutrosServicos = 0 THEN ' PedidoExibeOutrosServicos : «Falso» '
                                              WHEN  PedidoExibeOutrosServicos = 1 THEN ' PedidoExibeOutrosServicos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeJustificativa IS NULL THEN ' PedidoExibeJustificativa : «Nulo» '
                                              WHEN  PedidoExibeJustificativa = 0 THEN ' PedidoExibeJustificativa : «Falso» '
                                              WHEN  PedidoExibeJustificativa = 1 THEN ' PedidoExibeJustificativa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeEstoque IS NULL THEN ' PedidoExibeEstoque : «Nulo» '
                                              WHEN  PedidoExibeEstoque = 0 THEN ' PedidoExibeEstoque : «Falso» '
                                              WHEN  PedidoExibeEstoque = 1 THEN ' PedidoExibeEstoque : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeValorEstimado IS NULL THEN ' PedidoExibeValorEstimado : «Nulo» '
                                              WHEN  PedidoExibeValorEstimado = 0 THEN ' PedidoExibeValorEstimado : «Falso» '
                                              WHEN  PedidoExibeValorEstimado = 1 THEN ' PedidoExibeValorEstimado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeJustificativaOutrosItens IS NULL THEN ' PedidoExibeJustificativaOutrosItens : «Nulo» '
                                              WHEN  PedidoExibeJustificativaOutrosItens = 0 THEN ' PedidoExibeJustificativaOutrosItens : «Falso» '
                                              WHEN  PedidoExibeJustificativaOutrosItens = 1 THEN ' PedidoExibeJustificativaOutrosItens : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LiberarDepreciacao IS NULL THEN ' LiberarDepreciacao : «Nulo» '
                                              WHEN  LiberarDepreciacao = 0 THEN ' LiberarDepreciacao : «Falso» '
                                              WHEN  LiberarDepreciacao = 1 THEN ' LiberarDepreciacao : «Verdadeiro» '
                                    END 
                         + '| IntervaloAvisoDepreciacao : «' + RTRIM( ISNULL( CAST (IntervaloAvisoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeridiocidadeDepreciacao : «' + RTRIM( ISNULL( CAST (PeridiocidadeDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstadoConservDepreciacao : «' + RTRIM( ISNULL( CAST (IdEstadoConservDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximaExibicaoAvisoDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, ProximaExibicaoAvisoDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IniciaDepreciacaoPorEstadoConserv IS NULL THEN ' IniciaDepreciacaoPorEstadoConserv : «Nulo» '
                                              WHEN  IniciaDepreciacaoPorEstadoConserv = 0 THEN ' IniciaDepreciacaoPorEstadoConserv : «Falso» '
                                              WHEN  IniciaDepreciacaoPorEstadoConserv = 1 THEN ' IniciaDepreciacaoPorEstadoConserv : «Verdadeiro» '
                                    END 
                         + '| IdEstadoConservDeprecTransf : «' + RTRIM( ISNULL( CAST (IdEstadoConservDeprecTransf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstadoConservDeprecOrigem : «' + RTRIM( ISNULL( CAST (IdEstadoConservDeprecOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoImportacaoCotacoes : «' + RTRIM( ISNULL( CAST (AvisoImportacaoCotacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeAtendimentoServico IS NULL THEN ' ExibeAtendimentoServico : «Nulo» '
                                              WHEN  ExibeAtendimentoServico = 0 THEN ' ExibeAtendimentoServico : «Falso» '
                                              WHEN  ExibeAtendimentoServico = 1 THEN ' ExibeAtendimentoServico : «Verdadeiro» '
                                    END 
                         + '| ImportacaoXML : «' + RTRIM( ISNULL( CAST (ImportacaoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPeriodoMovimentacaoIni : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPeriodoMovimentacaoIni, 113 ),'Nulo'))+'» '
                         + '| DataPeriodoMovimentacaoFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPeriodoMovimentacaoFim, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaFinalidadePedido IS NULL THEN ' UtilizaFinalidadePedido : «Nulo» '
                                              WHEN  UtilizaFinalidadePedido = 0 THEN ' UtilizaFinalidadePedido : «Falso» '
                                              WHEN  UtilizaFinalidadePedido = 1 THEN ' UtilizaFinalidadePedido : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoImprimePedidoSolicitacao IS NULL THEN ' PedidoImprimePedidoSolicitacao : «Nulo» '
                                              WHEN  PedidoImprimePedidoSolicitacao = 0 THEN ' PedidoImprimePedidoSolicitacao : «Falso» '
                                              WHEN  PedidoImprimePedidoSolicitacao = 1 THEN ' PedidoImprimePedidoSolicitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoSequenciaAutorizacao IS NULL THEN ' PedidoSequenciaAutorizacao : «Nulo» '
                                              WHEN  PedidoSequenciaAutorizacao = 0 THEN ' PedidoSequenciaAutorizacao : «Falso» '
                                              WHEN  PedidoSequenciaAutorizacao = 1 THEN ' PedidoSequenciaAutorizacao : «Verdadeiro» '
                                    END 
                         + '| PedidoURLArquivoSolicitacao : «' + RTRIM( ISNULL( CAST (PedidoURLArquivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PedidoAnexaArquivoSolicitacao IS NULL THEN ' PedidoAnexaArquivoSolicitacao : «Nulo» '
                                              WHEN  PedidoAnexaArquivoSolicitacao = 0 THEN ' PedidoAnexaArquivoSolicitacao : «Falso» '
                                              WHEN  PedidoAnexaArquivoSolicitacao = 1 THEN ' PedidoAnexaArquivoSolicitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImportacaoXMLAtualizaMovBem IS NULL THEN ' ImportacaoXMLAtualizaMovBem : «Nulo» '
                                              WHEN  ImportacaoXMLAtualizaMovBem = 0 THEN ' ImportacaoXMLAtualizaMovBem : «Falso» '
                                              WHEN  ImportacaoXMLAtualizaMovBem = 1 THEN ' ImportacaoXMLAtualizaMovBem : «Verdadeiro» '
                                    END 
                         + '| AssinaturaTermoRepactuacao : «' + RTRIM( ISNULL( CAST (AssinaturaTermoRepactuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FATUtilizaFaturamento IS NULL THEN ' FATUtilizaFaturamento : «Nulo» '
                                              WHEN  FATUtilizaFaturamento = 0 THEN ' FATUtilizaFaturamento : «Falso» '
                                              WHEN  FATUtilizaFaturamento = 1 THEN ' FATUtilizaFaturamento : «Verdadeiro» '
                                    END 
                         + '| FATPrazoParaFaturamento : «' + RTRIM( ISNULL( CAST (FATPrazoParaFaturamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATPrazoVencNotasDebito : «' + RTRIM( ISNULL( CAST (FATPrazoVencNotasDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATPrazoInadimplencia : «' + RTRIM( ISNULL( CAST (FATPrazoInadimplencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATIntervaloAlerta : «' + RTRIM( ISNULL( CAST (FATIntervaloAlerta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATAgendamentoAlerta : «' + RTRIM( ISNULL( CONVERT (CHAR, FATAgendamentoAlerta, 113 ),'Nulo'))+'» '
                         + '| FATIncrementoNotaDebito : «' + RTRIM( ISNULL( CAST (FATIncrementoNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoCabecalhoEmailND : «' + RTRIM( ISNULL( CAST (FatTextoCabecalhoEmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoRodapeEmailND : «' + RTRIM( ISNULL( CAST (FatTextoRodapeEmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura1EmailND : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura1EmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura2EmailND : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura2EmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FATAnexarNotaDebitoEmail IS NULL THEN ' FATAnexarNotaDebitoEmail : «Nulo» '
                                              WHEN  FATAnexarNotaDebitoEmail = 0 THEN ' FATAnexarNotaDebitoEmail : «Falso» '
                                              WHEN  FATAnexarNotaDebitoEmail = 1 THEN ' FATAnexarNotaDebitoEmail : «Verdadeiro» '
                                    END 
                         + '| FatTextoCabecalhoAutPed : «' + RTRIM( ISNULL( CAST (FatTextoCabecalhoAutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoRodapeAutPed : «' + RTRIM( ISNULL( CAST (FatTextoRodapeAutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura1AutPed : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura1AutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura2AutPed : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura2AutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatAssinatura1NotaDebito : «' + RTRIM( ISNULL( CAST (FatAssinatura1NotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SepararItemOrdemCompra IS NULL THEN ' SepararItemOrdemCompra : «Nulo» '
                                              WHEN  SepararItemOrdemCompra = 0 THEN ' SepararItemOrdemCompra : «Falso» '
                                              WHEN  SepararItemOrdemCompra = 1 THEN ' SepararItemOrdemCompra : «Verdadeiro» '
                                    END 
                         + '| CaptionNumProtocolo : «' + RTRIM( ISNULL( CAST (CaptionNumProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MultiplosLocaisEntregaPAT IS NULL THEN ' MultiplosLocaisEntregaPAT : «Nulo» '
                                              WHEN  MultiplosLocaisEntregaPAT = 0 THEN ' MultiplosLocaisEntregaPAT : «Falso» '
                                              WHEN  MultiplosLocaisEntregaPAT = 1 THEN ' MultiplosLocaisEntregaPAT : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaContabilizacaoMCASP IS NULL THEN ' UtilizaContabilizacaoMCASP : «Nulo» '
                                              WHEN  UtilizaContabilizacaoMCASP = 0 THEN ' UtilizaContabilizacaoMCASP : «Falso» '
                                              WHEN  UtilizaContabilizacaoMCASP = 1 THEN ' UtilizaContabilizacaoMCASP : «Verdadeiro» '
                                    END 
                         + '| DataContabilizacaoAL_MCASP : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL_MCASP, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT_MCASP : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT_MCASP, 113 ),'Nulo'))+'» '
                         + '| AlertaCadastroOrdem : «' + RTRIM( ISNULL( CAST (AlertaCadastroOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlertaCadastroOrdemQtdDias : «' + RTRIM( ISNULL( CAST (AlertaCadastroOrdemQtdDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlertaRecebimentoProcessoCompra : «' + RTRIM( ISNULL( CAST (AlertaRecebimentoProcessoCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoTemp : «' + RTRIM( ISNULL( CAST (EnderecoTemp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FechaAlm : «' + RTRIM( ISNULL( CAST (FechaAlm AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FechaAlmDataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, FechaAlmDataInicial, 113 ),'Nulo'))+'» '
                         + '| FechaAlmDataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, FechaAlmDataFinal, 113 ),'Nulo'))+'» '
                         + '| CasasDecimais : «' + RTRIM( ISNULL( CAST (CasasDecimais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoFonte : «' + RTRIM( ISNULL( CAST (TamanhoFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ContabilizaMCASPInventarioMenos IS NULL THEN ' ContabilizaMCASPInventarioMenos : «Nulo» '
                                              WHEN  ContabilizaMCASPInventarioMenos = 0 THEN ' ContabilizaMCASPInventarioMenos : «Falso» '
                                              WHEN  ContabilizaMCASPInventarioMenos = 1 THEN ' ContabilizaMCASPInventarioMenos : «Verdadeiro» '
                                    END 
                         + '| IntervaloAvisoDepreciacaoBI : «' + RTRIM( ISNULL( CAST (IntervaloAvisoDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeridiocidadeDepreciacaoBI : «' + RTRIM( ISNULL( CAST (PeridiocidadeDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximaExibicaoAvisoDepreciacaoBI : «' + RTRIM( ISNULL( CONVERT (CHAR, ProximaExibicaoAvisoDepreciacaoBI, 113 ),'Nulo'))+'» '
                         + '| ClassificacaoItensOrdemCompra : «' + RTRIM( ISNULL( CAST (ClassificacaoItensOrdemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitirAlterarDtPrevLicit IS NULL THEN ' PermitirAlterarDtPrevLicit : «Nulo» '
                                              WHEN  PermitirAlterarDtPrevLicit = 0 THEN ' PermitirAlterarDtPrevLicit : «Falso» '
                                              WHEN  PermitirAlterarDtPrevLicit = 1 THEN ' PermitirAlterarDtPrevLicit : «Verdadeiro» '
                                    END 
                         + '| TiposMovimentacaoVerificados : «' + RTRIM( ISNULL( CAST (TiposMovimentacaoVerificados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtInicioNovaContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioNovaContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| DtInicioHistoricoBaixaBem : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioHistoricoBaixaBem, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeSaldoRealBalancete IS NULL THEN ' ExibeSaldoRealBalancete : «Nulo» '
                                              WHEN  ExibeSaldoRealBalancete = 0 THEN ' ExibeSaldoRealBalancete : «Falso» '
                                              WHEN  ExibeSaldoRealBalancete = 1 THEN ' ExibeSaldoRealBalancete : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSispatConversao IS NULL THEN ' BloqueiaSispatConversao : «Nulo» '
                                              WHEN  BloqueiaSispatConversao = 0 THEN ' BloqueiaSispatConversao : «Falso» '
                                              WHEN  BloqueiaSispatConversao = 1 THEN ' BloqueiaSispatConversao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSialmConversao IS NULL THEN ' BloqueiaSialmConversao : «Nulo» '
                                              WHEN  BloqueiaSialmConversao = 0 THEN ' BloqueiaSialmConversao : «Falso» '
                                              WHEN  BloqueiaSialmConversao = 1 THEN ' BloqueiaSialmConversao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSICCLConversao IS NULL THEN ' BloqueiaSICCLConversao : «Nulo» '
                                              WHEN  BloqueiaSICCLConversao = 0 THEN ' BloqueiaSICCLConversao : «Falso» '
                                              WHEN  BloqueiaSICCLConversao = 1 THEN ' BloqueiaSICCLConversao : «Verdadeiro» '
                                    END 
                         + '| DataConversaoSICCL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConversaoSICCL, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaDataConversao IS NULL THEN ' UtilizaDataConversao : «Nulo» '
                                              WHEN  UtilizaDataConversao = 0 THEN ' UtilizaDataConversao : «Falso» '
                                              WHEN  UtilizaDataConversao = 1 THEN ' UtilizaDataConversao : «Verdadeiro» '
                                    END 
                         + '| IdUnidadeConversao : «' + RTRIM( ISNULL( CAST (IdUnidadeConversao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelConversao : «' + RTRIM( ISNULL( CAST (IdResponsavelConversao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo =  CASE 
         			            WHEN AvisaA4 IS NULL THEN ' AvisaA4 : «Nulo» '
                                         WHEN AvisaA4 = 0 THEN ' AvisaA4 : «Falso» '
                                         WHEN AvisaA4 = 1 THEN ' AvisaA4 : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  MostraConsumoMensal IS NULL THEN ' MostraConsumoMensal : «Nulo» '
                                              WHEN  MostraConsumoMensal = 0 THEN ' MostraConsumoMensal : «Falso» '
                                              WHEN  MostraConsumoMensal = 1 THEN ' MostraConsumoMensal : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraUltimaCompra IS NULL THEN ' MostraUltimaCompra : «Nulo» '
                                              WHEN  MostraUltimaCompra = 0 THEN ' MostraUltimaCompra : «Falso» '
                                              WHEN  MostraUltimaCompra = 1 THEN ' MostraUltimaCompra : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraUltimaSaida IS NULL THEN ' MostraUltimaSaida : «Nulo» '
                                              WHEN  MostraUltimaSaida = 0 THEN ' MostraUltimaSaida : «Falso» '
                                              WHEN  MostraUltimaSaida = 1 THEN ' MostraUltimaSaida : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ResponsavelUnidade IS NULL THEN ' ResponsavelUnidade : «Nulo» '
                                              WHEN  ResponsavelUnidade = 0 THEN ' ResponsavelUnidade : «Falso» '
                                              WHEN  ResponsavelUnidade = 1 THEN ' ResponsavelUnidade : «Verdadeiro» '
                                    END 
                         + '| IdAlmoxarifadoPadraoOrdem : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoPadraoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifadoPadraoPedido : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoPadraoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoPatrimonio : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoPatrimonio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoTermo : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoResponsavelTermo : «' + RTRIM( ISNULL( CAST (CargoResponsavelTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadePadraoPatrimonio : «' + RTRIM( ISNULL( CAST (IdUnidadePadraoPatrimonio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoOrdem : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoDevolucaoOrdem : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoDevolucaoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoPedido : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoDevolucaoPedido : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoDevolucaoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Margem : «' + RTRIM( ISNULL( CAST (Margem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizaSiglaUnidade IS NULL THEN ' VisualizaSiglaUnidade : «Nulo» '
                                              WHEN  VisualizaSiglaUnidade = 0 THEN ' VisualizaSiglaUnidade : «Falso» '
                                              WHEN  VisualizaSiglaUnidade = 1 THEN ' VisualizaSiglaUnidade : «Verdadeiro» '
                                    END 
                         + '| IdTipoBemPadrao : «' + RTRIM( ISNULL( CAST (IdTipoBemPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaseLimiteProcesso : «' + RTRIM( ISNULL( CAST (IdFaseLimiteProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaAL : «' + RTRIM( ISNULL( CAST (OrdemTelaAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaBM : «' + RTRIM( ISNULL( CAST (OrdemTelaBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaBI : «' + RTRIM( ISNULL( CAST (OrdemTelaBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MascaraMescladaLI IS NULL THEN ' MascaraMescladaLI : «Nulo» '
                                              WHEN  MascaraMescladaLI = 0 THEN ' MascaraMescladaLI : «Falso» '
                                              WHEN  MascaraMescladaLI = 1 THEN ' MascaraMescladaLI : «Verdadeiro» '
                                    END 
                         + '| DataLimiteAL : «' + RTRIM( ISNULL( CAST (DataLimiteAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoAL : «' + RTRIM( ISNULL( CAST (DataAcessoAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoAL : «' + RTRIM( ISNULL( CAST (AcessoAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteCO : «' + RTRIM( ISNULL( CAST (DataLimiteCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoCO : «' + RTRIM( ISNULL( CAST (DataAcessoCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoCO : «' + RTRIM( ISNULL( CAST (AcessoCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimitePA : «' + RTRIM( ISNULL( CAST (DataLimitePA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoPA : «' + RTRIM( ISNULL( CAST (DataAcessoPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoPA : «' + RTRIM( ISNULL( CAST (AcessoPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelOC : «' + RTRIM( ISNULL( CAST (TituloRelOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelOS : «' + RTRIM( ISNULL( CAST (TituloRelOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoValorItem : «' + RTRIM( ISNULL( CAST (TipoValorItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmpenhoObrigatorioContrato IS NULL THEN ' EmpenhoObrigatorioContrato : «Nulo» '
                                              WHEN  EmpenhoObrigatorioContrato = 0 THEN ' EmpenhoObrigatorioContrato : «Falso» '
                                              WHEN  EmpenhoObrigatorioContrato = 1 THEN ' EmpenhoObrigatorioContrato : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExclusivoUnidade IS NULL THEN ' PedidoExclusivoUnidade : «Nulo» '
                                              WHEN  PedidoExclusivoUnidade = 0 THEN ' PedidoExclusivoUnidade : «Falso» '
                                              WHEN  PedidoExclusivoUnidade = 1 THEN ' PedidoExclusivoUnidade : «Verdadeiro» '
                                    END 
                         + '| TituloRelCS : «' + RTRIM( ISNULL( CAST (TituloRelCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasAL : «' + RTRIM( ISNULL( CAST (LicencasAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasCO : «' + RTRIM( ISNULL( CAST (LicencasCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasPA : «' + RTRIM( ISNULL( CAST (LicencasPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoVencimentoContrato : «' + RTRIM( ISNULL( CAST (AvisoVencimentoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoVencimentoSeguro : «' + RTRIM( ISNULL( CAST (AvisoVencimentoSeguro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoItensAdquiridosOrdem : «' + RTRIM( ISNULL( CAST (AvisoItensAdquiridosOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ModalidadeRegistroPreco IS NULL THEN ' ModalidadeRegistroPreco : «Nulo» '
                                              WHEN  ModalidadeRegistroPreco = 0 THEN ' ModalidadeRegistroPreco : «Falso» '
                                              WHEN  ModalidadeRegistroPreco = 1 THEN ' ModalidadeRegistroPreco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAtendimentoPedido IS NULL THEN ' BloquearAtendimentoPedido : «Nulo» '
                                              WHEN  BloquearAtendimentoPedido = 0 THEN ' BloquearAtendimentoPedido : «Falso» '
                                              WHEN  BloquearAtendimentoPedido = 1 THEN ' BloquearAtendimentoPedido : «Verdadeiro» '
                                    END 
                         + '| IncrementoCertificacao : «' + RTRIM( ISNULL( CAST (IncrementoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumCertificadoSequencial IS NULL THEN ' NumCertificadoSequencial : «Nulo» '
                                              WHEN  NumCertificadoSequencial = 0 THEN ' NumCertificadoSequencial : «Falso» '
                                              WHEN  NumCertificadoSequencial = 1 THEN ' NumCertificadoSequencial : «Verdadeiro» '
                                    END 
                         + '| Assinatura01 : «' + RTRIM( ISNULL( CAST (Assinatura01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo01 : «' + RTRIM( ISNULL( CAST (Cargo01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro01 : «' + RTRIM( ISNULL( CAST (Registro01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf01 : «' + RTRIM( ISNULL( CAST (Cpf01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MultiplosLocaisEntrega IS NULL THEN ' MultiplosLocaisEntrega : «Nulo» '
                                              WHEN  MultiplosLocaisEntrega = 0 THEN ' MultiplosLocaisEntrega : «Falso» '
                                              WHEN  MultiplosLocaisEntrega = 1 THEN ' MultiplosLocaisEntrega : «Verdadeiro» '
                                    END 
                         + '| IdContaPatrimonioAL : «' + RTRIM( ISNULL( CAST (IdContaPatrimonioAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaEntrada : «' + RTRIM( ISNULL( CAST (IdContaEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaSaida : «' + RTRIM( ISNULL( CAST (IdContaSaida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| IdContaAquisicaoBM : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBI : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBM : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBI : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT, 113 ),'Nulo'))+'» '
                         + '| IdContaBensMoveis : «' + RTRIM( ISNULL( CAST (IdContaBensMoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensImoveis : «' + RTRIM( ISNULL( CAST (IdContaBensImoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBM : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBI : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DescItensMoveisObrigatorio IS NULL THEN ' DescItensMoveisObrigatorio : «Nulo» '
                                              WHEN  DescItensMoveisObrigatorio = 0 THEN ' DescItensMoveisObrigatorio : «Falso» '
                                              WHEN  DescItensMoveisObrigatorio = 1 THEN ' DescItensMoveisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DescItensImoveisObrigatorio IS NULL THEN ' DescItensImoveisObrigatorio : «Nulo» '
                                              WHEN  DescItensImoveisObrigatorio = 0 THEN ' DescItensImoveisObrigatorio : «Falso» '
                                              WHEN  DescItensImoveisObrigatorio = 1 THEN ' DescItensImoveisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaturezaOrdemObrigatoria IS NULL THEN ' NaturezaOrdemObrigatoria : «Nulo» '
                                              WHEN  NaturezaOrdemObrigatoria = 0 THEN ' NaturezaOrdemObrigatoria : «Falso» '
                                              WHEN  NaturezaOrdemObrigatoria = 1 THEN ' NaturezaOrdemObrigatoria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeLocalExecucaoOS IS NULL THEN ' ImprimeLocalExecucaoOS : «Nulo» '
                                              WHEN  ImprimeLocalExecucaoOS = 0 THEN ' ImprimeLocalExecucaoOS : «Falso» '
                                              WHEN  ImprimeLocalExecucaoOS = 1 THEN ' ImprimeLocalExecucaoOS : «Verdadeiro» '
                                    END 
                         + '| AvisoEmpenhoRecusado : «' + RTRIM( ISNULL( CAST (AvisoEmpenhoRecusado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumerarTermoResponsabilidade IS NULL THEN ' NumerarTermoResponsabilidade : «Nulo» '
                                              WHEN  NumerarTermoResponsabilidade = 0 THEN ' NumerarTermoResponsabilidade : «Falso» '
                                              WHEN  NumerarTermoResponsabilidade = 1 THEN ' NumerarTermoResponsabilidade : «Verdadeiro» '
                                    END 
                         + '| LinkSispatWeb : «' + RTRIM( ISNULL( CAST (LinkSispatWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaItemSemValorRef IS NULL THEN ' UtilizaItemSemValorRef : «Nulo» '
                                              WHEN  UtilizaItemSemValorRef = 0 THEN ' UtilizaItemSemValorRef : «Falso» '
                                              WHEN  UtilizaItemSemValorRef = 1 THEN ' UtilizaItemSemValorRef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeBrasaoRelExternos IS NULL THEN ' ExibeBrasaoRelExternos : «Nulo» '
                                              WHEN  ExibeBrasaoRelExternos = 0 THEN ' ExibeBrasaoRelExternos : «Falso» '
                                              WHEN  ExibeBrasaoRelExternos = 1 THEN ' ExibeBrasaoRelExternos : «Verdadeiro» '
                                    END 
                         + '| AvisoVencimentoParcelasContratos : «' + RTRIM( ISNULL( CAST (AvisoVencimentoParcelasContratos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InventarioMesmoPeriodo IS NULL THEN ' InventarioMesmoPeriodo : «Nulo» '
                                              WHEN  InventarioMesmoPeriodo = 0 THEN ' InventarioMesmoPeriodo : «Falso» '
                                              WHEN  InventarioMesmoPeriodo = 1 THEN ' InventarioMesmoPeriodo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeOutrosServicos IS NULL THEN ' PedidoExibeOutrosServicos : «Nulo» '
                                              WHEN  PedidoExibeOutrosServicos = 0 THEN ' PedidoExibeOutrosServicos : «Falso» '
                                              WHEN  PedidoExibeOutrosServicos = 1 THEN ' PedidoExibeOutrosServicos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeJustificativa IS NULL THEN ' PedidoExibeJustificativa : «Nulo» '
                                              WHEN  PedidoExibeJustificativa = 0 THEN ' PedidoExibeJustificativa : «Falso» '
                                              WHEN  PedidoExibeJustificativa = 1 THEN ' PedidoExibeJustificativa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeEstoque IS NULL THEN ' PedidoExibeEstoque : «Nulo» '
                                              WHEN  PedidoExibeEstoque = 0 THEN ' PedidoExibeEstoque : «Falso» '
                                              WHEN  PedidoExibeEstoque = 1 THEN ' PedidoExibeEstoque : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeValorEstimado IS NULL THEN ' PedidoExibeValorEstimado : «Nulo» '
                                              WHEN  PedidoExibeValorEstimado = 0 THEN ' PedidoExibeValorEstimado : «Falso» '
                                              WHEN  PedidoExibeValorEstimado = 1 THEN ' PedidoExibeValorEstimado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeJustificativaOutrosItens IS NULL THEN ' PedidoExibeJustificativaOutrosItens : «Nulo» '
                                              WHEN  PedidoExibeJustificativaOutrosItens = 0 THEN ' PedidoExibeJustificativaOutrosItens : «Falso» '
                                              WHEN  PedidoExibeJustificativaOutrosItens = 1 THEN ' PedidoExibeJustificativaOutrosItens : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LiberarDepreciacao IS NULL THEN ' LiberarDepreciacao : «Nulo» '
                                              WHEN  LiberarDepreciacao = 0 THEN ' LiberarDepreciacao : «Falso» '
                                              WHEN  LiberarDepreciacao = 1 THEN ' LiberarDepreciacao : «Verdadeiro» '
                                    END 
                         + '| IntervaloAvisoDepreciacao : «' + RTRIM( ISNULL( CAST (IntervaloAvisoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeridiocidadeDepreciacao : «' + RTRIM( ISNULL( CAST (PeridiocidadeDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstadoConservDepreciacao : «' + RTRIM( ISNULL( CAST (IdEstadoConservDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximaExibicaoAvisoDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, ProximaExibicaoAvisoDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IniciaDepreciacaoPorEstadoConserv IS NULL THEN ' IniciaDepreciacaoPorEstadoConserv : «Nulo» '
                                              WHEN  IniciaDepreciacaoPorEstadoConserv = 0 THEN ' IniciaDepreciacaoPorEstadoConserv : «Falso» '
                                              WHEN  IniciaDepreciacaoPorEstadoConserv = 1 THEN ' IniciaDepreciacaoPorEstadoConserv : «Verdadeiro» '
                                    END 
                         + '| IdEstadoConservDeprecTransf : «' + RTRIM( ISNULL( CAST (IdEstadoConservDeprecTransf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstadoConservDeprecOrigem : «' + RTRIM( ISNULL( CAST (IdEstadoConservDeprecOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoImportacaoCotacoes : «' + RTRIM( ISNULL( CAST (AvisoImportacaoCotacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeAtendimentoServico IS NULL THEN ' ExibeAtendimentoServico : «Nulo» '
                                              WHEN  ExibeAtendimentoServico = 0 THEN ' ExibeAtendimentoServico : «Falso» '
                                              WHEN  ExibeAtendimentoServico = 1 THEN ' ExibeAtendimentoServico : «Verdadeiro» '
                                    END 
                         + '| ImportacaoXML : «' + RTRIM( ISNULL( CAST (ImportacaoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPeriodoMovimentacaoIni : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPeriodoMovimentacaoIni, 113 ),'Nulo'))+'» '
                         + '| DataPeriodoMovimentacaoFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPeriodoMovimentacaoFim, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaFinalidadePedido IS NULL THEN ' UtilizaFinalidadePedido : «Nulo» '
                                              WHEN  UtilizaFinalidadePedido = 0 THEN ' UtilizaFinalidadePedido : «Falso» '
                                              WHEN  UtilizaFinalidadePedido = 1 THEN ' UtilizaFinalidadePedido : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoImprimePedidoSolicitacao IS NULL THEN ' PedidoImprimePedidoSolicitacao : «Nulo» '
                                              WHEN  PedidoImprimePedidoSolicitacao = 0 THEN ' PedidoImprimePedidoSolicitacao : «Falso» '
                                              WHEN  PedidoImprimePedidoSolicitacao = 1 THEN ' PedidoImprimePedidoSolicitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoSequenciaAutorizacao IS NULL THEN ' PedidoSequenciaAutorizacao : «Nulo» '
                                              WHEN  PedidoSequenciaAutorizacao = 0 THEN ' PedidoSequenciaAutorizacao : «Falso» '
                                              WHEN  PedidoSequenciaAutorizacao = 1 THEN ' PedidoSequenciaAutorizacao : «Verdadeiro» '
                                    END 
                         + '| PedidoURLArquivoSolicitacao : «' + RTRIM( ISNULL( CAST (PedidoURLArquivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PedidoAnexaArquivoSolicitacao IS NULL THEN ' PedidoAnexaArquivoSolicitacao : «Nulo» '
                                              WHEN  PedidoAnexaArquivoSolicitacao = 0 THEN ' PedidoAnexaArquivoSolicitacao : «Falso» '
                                              WHEN  PedidoAnexaArquivoSolicitacao = 1 THEN ' PedidoAnexaArquivoSolicitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImportacaoXMLAtualizaMovBem IS NULL THEN ' ImportacaoXMLAtualizaMovBem : «Nulo» '
                                              WHEN  ImportacaoXMLAtualizaMovBem = 0 THEN ' ImportacaoXMLAtualizaMovBem : «Falso» '
                                              WHEN  ImportacaoXMLAtualizaMovBem = 1 THEN ' ImportacaoXMLAtualizaMovBem : «Verdadeiro» '
                                    END 
                         + '| AssinaturaTermoRepactuacao : «' + RTRIM( ISNULL( CAST (AssinaturaTermoRepactuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FATUtilizaFaturamento IS NULL THEN ' FATUtilizaFaturamento : «Nulo» '
                                              WHEN  FATUtilizaFaturamento = 0 THEN ' FATUtilizaFaturamento : «Falso» '
                                              WHEN  FATUtilizaFaturamento = 1 THEN ' FATUtilizaFaturamento : «Verdadeiro» '
                                    END 
                         + '| FATPrazoParaFaturamento : «' + RTRIM( ISNULL( CAST (FATPrazoParaFaturamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATPrazoVencNotasDebito : «' + RTRIM( ISNULL( CAST (FATPrazoVencNotasDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATPrazoInadimplencia : «' + RTRIM( ISNULL( CAST (FATPrazoInadimplencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATIntervaloAlerta : «' + RTRIM( ISNULL( CAST (FATIntervaloAlerta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATAgendamentoAlerta : «' + RTRIM( ISNULL( CONVERT (CHAR, FATAgendamentoAlerta, 113 ),'Nulo'))+'» '
                         + '| FATIncrementoNotaDebito : «' + RTRIM( ISNULL( CAST (FATIncrementoNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoCabecalhoEmailND : «' + RTRIM( ISNULL( CAST (FatTextoCabecalhoEmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoRodapeEmailND : «' + RTRIM( ISNULL( CAST (FatTextoRodapeEmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura1EmailND : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura1EmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura2EmailND : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura2EmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FATAnexarNotaDebitoEmail IS NULL THEN ' FATAnexarNotaDebitoEmail : «Nulo» '
                                              WHEN  FATAnexarNotaDebitoEmail = 0 THEN ' FATAnexarNotaDebitoEmail : «Falso» '
                                              WHEN  FATAnexarNotaDebitoEmail = 1 THEN ' FATAnexarNotaDebitoEmail : «Verdadeiro» '
                                    END 
                         + '| FatTextoCabecalhoAutPed : «' + RTRIM( ISNULL( CAST (FatTextoCabecalhoAutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoRodapeAutPed : «' + RTRIM( ISNULL( CAST (FatTextoRodapeAutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura1AutPed : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura1AutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura2AutPed : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura2AutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatAssinatura1NotaDebito : «' + RTRIM( ISNULL( CAST (FatAssinatura1NotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SepararItemOrdemCompra IS NULL THEN ' SepararItemOrdemCompra : «Nulo» '
                                              WHEN  SepararItemOrdemCompra = 0 THEN ' SepararItemOrdemCompra : «Falso» '
                                              WHEN  SepararItemOrdemCompra = 1 THEN ' SepararItemOrdemCompra : «Verdadeiro» '
                                    END 
                         + '| CaptionNumProtocolo : «' + RTRIM( ISNULL( CAST (CaptionNumProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MultiplosLocaisEntregaPAT IS NULL THEN ' MultiplosLocaisEntregaPAT : «Nulo» '
                                              WHEN  MultiplosLocaisEntregaPAT = 0 THEN ' MultiplosLocaisEntregaPAT : «Falso» '
                                              WHEN  MultiplosLocaisEntregaPAT = 1 THEN ' MultiplosLocaisEntregaPAT : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaContabilizacaoMCASP IS NULL THEN ' UtilizaContabilizacaoMCASP : «Nulo» '
                                              WHEN  UtilizaContabilizacaoMCASP = 0 THEN ' UtilizaContabilizacaoMCASP : «Falso» '
                                              WHEN  UtilizaContabilizacaoMCASP = 1 THEN ' UtilizaContabilizacaoMCASP : «Verdadeiro» '
                                    END 
                         + '| DataContabilizacaoAL_MCASP : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL_MCASP, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT_MCASP : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT_MCASP, 113 ),'Nulo'))+'» '
                         + '| AlertaCadastroOrdem : «' + RTRIM( ISNULL( CAST (AlertaCadastroOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlertaCadastroOrdemQtdDias : «' + RTRIM( ISNULL( CAST (AlertaCadastroOrdemQtdDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlertaRecebimentoProcessoCompra : «' + RTRIM( ISNULL( CAST (AlertaRecebimentoProcessoCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoTemp : «' + RTRIM( ISNULL( CAST (EnderecoTemp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FechaAlm : «' + RTRIM( ISNULL( CAST (FechaAlm AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FechaAlmDataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, FechaAlmDataInicial, 113 ),'Nulo'))+'» '
                         + '| FechaAlmDataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, FechaAlmDataFinal, 113 ),'Nulo'))+'» '
                         + '| CasasDecimais : «' + RTRIM( ISNULL( CAST (CasasDecimais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoFonte : «' + RTRIM( ISNULL( CAST (TamanhoFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ContabilizaMCASPInventarioMenos IS NULL THEN ' ContabilizaMCASPInventarioMenos : «Nulo» '
                                              WHEN  ContabilizaMCASPInventarioMenos = 0 THEN ' ContabilizaMCASPInventarioMenos : «Falso» '
                                              WHEN  ContabilizaMCASPInventarioMenos = 1 THEN ' ContabilizaMCASPInventarioMenos : «Verdadeiro» '
                                    END 
                         + '| IntervaloAvisoDepreciacaoBI : «' + RTRIM( ISNULL( CAST (IntervaloAvisoDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeridiocidadeDepreciacaoBI : «' + RTRIM( ISNULL( CAST (PeridiocidadeDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximaExibicaoAvisoDepreciacaoBI : «' + RTRIM( ISNULL( CONVERT (CHAR, ProximaExibicaoAvisoDepreciacaoBI, 113 ),'Nulo'))+'» '
                         + '| ClassificacaoItensOrdemCompra : «' + RTRIM( ISNULL( CAST (ClassificacaoItensOrdemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitirAlterarDtPrevLicit IS NULL THEN ' PermitirAlterarDtPrevLicit : «Nulo» '
                                              WHEN  PermitirAlterarDtPrevLicit = 0 THEN ' PermitirAlterarDtPrevLicit : «Falso» '
                                              WHEN  PermitirAlterarDtPrevLicit = 1 THEN ' PermitirAlterarDtPrevLicit : «Verdadeiro» '
                                    END 
                         + '| TiposMovimentacaoVerificados : «' + RTRIM( ISNULL( CAST (TiposMovimentacaoVerificados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtInicioNovaContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioNovaContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| DtInicioHistoricoBaixaBem : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioHistoricoBaixaBem, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeSaldoRealBalancete IS NULL THEN ' ExibeSaldoRealBalancete : «Nulo» '
                                              WHEN  ExibeSaldoRealBalancete = 0 THEN ' ExibeSaldoRealBalancete : «Falso» '
                                              WHEN  ExibeSaldoRealBalancete = 1 THEN ' ExibeSaldoRealBalancete : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSispatConversao IS NULL THEN ' BloqueiaSispatConversao : «Nulo» '
                                              WHEN  BloqueiaSispatConversao = 0 THEN ' BloqueiaSispatConversao : «Falso» '
                                              WHEN  BloqueiaSispatConversao = 1 THEN ' BloqueiaSispatConversao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSialmConversao IS NULL THEN ' BloqueiaSialmConversao : «Nulo» '
                                              WHEN  BloqueiaSialmConversao = 0 THEN ' BloqueiaSialmConversao : «Falso» '
                                              WHEN  BloqueiaSialmConversao = 1 THEN ' BloqueiaSialmConversao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSICCLConversao IS NULL THEN ' BloqueiaSICCLConversao : «Nulo» '
                                              WHEN  BloqueiaSICCLConversao = 0 THEN ' BloqueiaSICCLConversao : «Falso» '
                                              WHEN  BloqueiaSICCLConversao = 1 THEN ' BloqueiaSICCLConversao : «Verdadeiro» '
                                    END 
                         + '| DataConversaoSICCL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConversaoSICCL, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaDataConversao IS NULL THEN ' UtilizaDataConversao : «Nulo» '
                                              WHEN  UtilizaDataConversao = 0 THEN ' UtilizaDataConversao : «Falso» '
                                              WHEN  UtilizaDataConversao = 1 THEN ' UtilizaDataConversao : «Verdadeiro» '
                                    END 
                         + '| IdUnidadeConversao : «' + RTRIM( ISNULL( CAST (IdUnidadeConversao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelConversao : «' + RTRIM( ISNULL( CAST (IdResponsavelConversao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo =  CASE 
         			            WHEN AvisaA4 IS NULL THEN ' AvisaA4 : «Nulo» '
                                         WHEN AvisaA4 = 0 THEN ' AvisaA4 : «Falso» '
                                         WHEN AvisaA4 = 1 THEN ' AvisaA4 : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  MostraConsumoMensal IS NULL THEN ' MostraConsumoMensal : «Nulo» '
                                              WHEN  MostraConsumoMensal = 0 THEN ' MostraConsumoMensal : «Falso» '
                                              WHEN  MostraConsumoMensal = 1 THEN ' MostraConsumoMensal : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraUltimaCompra IS NULL THEN ' MostraUltimaCompra : «Nulo» '
                                              WHEN  MostraUltimaCompra = 0 THEN ' MostraUltimaCompra : «Falso» '
                                              WHEN  MostraUltimaCompra = 1 THEN ' MostraUltimaCompra : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraUltimaSaida IS NULL THEN ' MostraUltimaSaida : «Nulo» '
                                              WHEN  MostraUltimaSaida = 0 THEN ' MostraUltimaSaida : «Falso» '
                                              WHEN  MostraUltimaSaida = 1 THEN ' MostraUltimaSaida : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ResponsavelUnidade IS NULL THEN ' ResponsavelUnidade : «Nulo» '
                                              WHEN  ResponsavelUnidade = 0 THEN ' ResponsavelUnidade : «Falso» '
                                              WHEN  ResponsavelUnidade = 1 THEN ' ResponsavelUnidade : «Verdadeiro» '
                                    END 
                         + '| IdAlmoxarifadoPadraoOrdem : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoPadraoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifadoPadraoPedido : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoPadraoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoPatrimonio : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoPatrimonio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelPadraoTermo : «' + RTRIM( ISNULL( CAST (IdResponsavelPadraoTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoResponsavelTermo : «' + RTRIM( ISNULL( CAST (CargoResponsavelTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadePadraoPatrimonio : «' + RTRIM( ISNULL( CAST (IdUnidadePadraoPatrimonio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoOrdem : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoDevolucaoOrdem : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoDevolucaoOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoPedido : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacaoPadraoDevolucaoPedido : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacaoPadraoDevolucaoPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Margem : «' + RTRIM( ISNULL( CAST (Margem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizaSiglaUnidade IS NULL THEN ' VisualizaSiglaUnidade : «Nulo» '
                                              WHEN  VisualizaSiglaUnidade = 0 THEN ' VisualizaSiglaUnidade : «Falso» '
                                              WHEN  VisualizaSiglaUnidade = 1 THEN ' VisualizaSiglaUnidade : «Verdadeiro» '
                                    END 
                         + '| IdTipoBemPadrao : «' + RTRIM( ISNULL( CAST (IdTipoBemPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaseLimiteProcesso : «' + RTRIM( ISNULL( CAST (IdFaseLimiteProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaAL : «' + RTRIM( ISNULL( CAST (OrdemTelaAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaBM : «' + RTRIM( ISNULL( CAST (OrdemTelaBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTelaBI : «' + RTRIM( ISNULL( CAST (OrdemTelaBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MascaraMescladaLI IS NULL THEN ' MascaraMescladaLI : «Nulo» '
                                              WHEN  MascaraMescladaLI = 0 THEN ' MascaraMescladaLI : «Falso» '
                                              WHEN  MascaraMescladaLI = 1 THEN ' MascaraMescladaLI : «Verdadeiro» '
                                    END 
                         + '| DataLimiteAL : «' + RTRIM( ISNULL( CAST (DataLimiteAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoAL : «' + RTRIM( ISNULL( CAST (DataAcessoAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoAL : «' + RTRIM( ISNULL( CAST (AcessoAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteCO : «' + RTRIM( ISNULL( CAST (DataLimiteCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoCO : «' + RTRIM( ISNULL( CAST (DataAcessoCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoCO : «' + RTRIM( ISNULL( CAST (AcessoCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimitePA : «' + RTRIM( ISNULL( CAST (DataLimitePA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcessoPA : «' + RTRIM( ISNULL( CAST (DataAcessoPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AcessoPA : «' + RTRIM( ISNULL( CAST (AcessoPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelOC : «' + RTRIM( ISNULL( CAST (TituloRelOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelOS : «' + RTRIM( ISNULL( CAST (TituloRelOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoValorItem : «' + RTRIM( ISNULL( CAST (TipoValorItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmpenhoObrigatorioContrato IS NULL THEN ' EmpenhoObrigatorioContrato : «Nulo» '
                                              WHEN  EmpenhoObrigatorioContrato = 0 THEN ' EmpenhoObrigatorioContrato : «Falso» '
                                              WHEN  EmpenhoObrigatorioContrato = 1 THEN ' EmpenhoObrigatorioContrato : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExclusivoUnidade IS NULL THEN ' PedidoExclusivoUnidade : «Nulo» '
                                              WHEN  PedidoExclusivoUnidade = 0 THEN ' PedidoExclusivoUnidade : «Falso» '
                                              WHEN  PedidoExclusivoUnidade = 1 THEN ' PedidoExclusivoUnidade : «Verdadeiro» '
                                    END 
                         + '| TituloRelCS : «' + RTRIM( ISNULL( CAST (TituloRelCS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasAL : «' + RTRIM( ISNULL( CAST (LicencasAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasCO : «' + RTRIM( ISNULL( CAST (LicencasCO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LicencasPA : «' + RTRIM( ISNULL( CAST (LicencasPA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoVencimentoContrato : «' + RTRIM( ISNULL( CAST (AvisoVencimentoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoVencimentoSeguro : «' + RTRIM( ISNULL( CAST (AvisoVencimentoSeguro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoItensAdquiridosOrdem : «' + RTRIM( ISNULL( CAST (AvisoItensAdquiridosOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ModalidadeRegistroPreco IS NULL THEN ' ModalidadeRegistroPreco : «Nulo» '
                                              WHEN  ModalidadeRegistroPreco = 0 THEN ' ModalidadeRegistroPreco : «Falso» '
                                              WHEN  ModalidadeRegistroPreco = 1 THEN ' ModalidadeRegistroPreco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearAtendimentoPedido IS NULL THEN ' BloquearAtendimentoPedido : «Nulo» '
                                              WHEN  BloquearAtendimentoPedido = 0 THEN ' BloquearAtendimentoPedido : «Falso» '
                                              WHEN  BloquearAtendimentoPedido = 1 THEN ' BloquearAtendimentoPedido : «Verdadeiro» '
                                    END 
                         + '| IncrementoCertificacao : «' + RTRIM( ISNULL( CAST (IncrementoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumCertificadoSequencial IS NULL THEN ' NumCertificadoSequencial : «Nulo» '
                                              WHEN  NumCertificadoSequencial = 0 THEN ' NumCertificadoSequencial : «Falso» '
                                              WHEN  NumCertificadoSequencial = 1 THEN ' NumCertificadoSequencial : «Verdadeiro» '
                                    END 
                         + '| Assinatura01 : «' + RTRIM( ISNULL( CAST (Assinatura01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo01 : «' + RTRIM( ISNULL( CAST (Cargo01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro01 : «' + RTRIM( ISNULL( CAST (Registro01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf01 : «' + RTRIM( ISNULL( CAST (Cpf01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MultiplosLocaisEntrega IS NULL THEN ' MultiplosLocaisEntrega : «Nulo» '
                                              WHEN  MultiplosLocaisEntrega = 0 THEN ' MultiplosLocaisEntrega : «Falso» '
                                              WHEN  MultiplosLocaisEntrega = 1 THEN ' MultiplosLocaisEntrega : «Verdadeiro» '
                                    END 
                         + '| IdContaPatrimonioAL : «' + RTRIM( ISNULL( CAST (IdContaPatrimonioAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaEntrada : «' + RTRIM( ISNULL( CAST (IdContaEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaSaida : «' + RTRIM( ISNULL( CAST (IdContaSaida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| IdContaAquisicaoBM : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBI : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBM : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBI : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT, 113 ),'Nulo'))+'» '
                         + '| IdContaBensMoveis : «' + RTRIM( ISNULL( CAST (IdContaBensMoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensImoveis : «' + RTRIM( ISNULL( CAST (IdContaBensImoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBM : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBI : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DescItensMoveisObrigatorio IS NULL THEN ' DescItensMoveisObrigatorio : «Nulo» '
                                              WHEN  DescItensMoveisObrigatorio = 0 THEN ' DescItensMoveisObrigatorio : «Falso» '
                                              WHEN  DescItensMoveisObrigatorio = 1 THEN ' DescItensMoveisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DescItensImoveisObrigatorio IS NULL THEN ' DescItensImoveisObrigatorio : «Nulo» '
                                              WHEN  DescItensImoveisObrigatorio = 0 THEN ' DescItensImoveisObrigatorio : «Falso» '
                                              WHEN  DescItensImoveisObrigatorio = 1 THEN ' DescItensImoveisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NaturezaOrdemObrigatoria IS NULL THEN ' NaturezaOrdemObrigatoria : «Nulo» '
                                              WHEN  NaturezaOrdemObrigatoria = 0 THEN ' NaturezaOrdemObrigatoria : «Falso» '
                                              WHEN  NaturezaOrdemObrigatoria = 1 THEN ' NaturezaOrdemObrigatoria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeLocalExecucaoOS IS NULL THEN ' ImprimeLocalExecucaoOS : «Nulo» '
                                              WHEN  ImprimeLocalExecucaoOS = 0 THEN ' ImprimeLocalExecucaoOS : «Falso» '
                                              WHEN  ImprimeLocalExecucaoOS = 1 THEN ' ImprimeLocalExecucaoOS : «Verdadeiro» '
                                    END 
                         + '| AvisoEmpenhoRecusado : «' + RTRIM( ISNULL( CAST (AvisoEmpenhoRecusado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumerarTermoResponsabilidade IS NULL THEN ' NumerarTermoResponsabilidade : «Nulo» '
                                              WHEN  NumerarTermoResponsabilidade = 0 THEN ' NumerarTermoResponsabilidade : «Falso» '
                                              WHEN  NumerarTermoResponsabilidade = 1 THEN ' NumerarTermoResponsabilidade : «Verdadeiro» '
                                    END 
                         + '| LinkSispatWeb : «' + RTRIM( ISNULL( CAST (LinkSispatWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaItemSemValorRef IS NULL THEN ' UtilizaItemSemValorRef : «Nulo» '
                                              WHEN  UtilizaItemSemValorRef = 0 THEN ' UtilizaItemSemValorRef : «Falso» '
                                              WHEN  UtilizaItemSemValorRef = 1 THEN ' UtilizaItemSemValorRef : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeBrasaoRelExternos IS NULL THEN ' ExibeBrasaoRelExternos : «Nulo» '
                                              WHEN  ExibeBrasaoRelExternos = 0 THEN ' ExibeBrasaoRelExternos : «Falso» '
                                              WHEN  ExibeBrasaoRelExternos = 1 THEN ' ExibeBrasaoRelExternos : «Verdadeiro» '
                                    END 
                         + '| AvisoVencimentoParcelasContratos : «' + RTRIM( ISNULL( CAST (AvisoVencimentoParcelasContratos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InventarioMesmoPeriodo IS NULL THEN ' InventarioMesmoPeriodo : «Nulo» '
                                              WHEN  InventarioMesmoPeriodo = 0 THEN ' InventarioMesmoPeriodo : «Falso» '
                                              WHEN  InventarioMesmoPeriodo = 1 THEN ' InventarioMesmoPeriodo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeOutrosServicos IS NULL THEN ' PedidoExibeOutrosServicos : «Nulo» '
                                              WHEN  PedidoExibeOutrosServicos = 0 THEN ' PedidoExibeOutrosServicos : «Falso» '
                                              WHEN  PedidoExibeOutrosServicos = 1 THEN ' PedidoExibeOutrosServicos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeJustificativa IS NULL THEN ' PedidoExibeJustificativa : «Nulo» '
                                              WHEN  PedidoExibeJustificativa = 0 THEN ' PedidoExibeJustificativa : «Falso» '
                                              WHEN  PedidoExibeJustificativa = 1 THEN ' PedidoExibeJustificativa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeEstoque IS NULL THEN ' PedidoExibeEstoque : «Nulo» '
                                              WHEN  PedidoExibeEstoque = 0 THEN ' PedidoExibeEstoque : «Falso» '
                                              WHEN  PedidoExibeEstoque = 1 THEN ' PedidoExibeEstoque : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeValorEstimado IS NULL THEN ' PedidoExibeValorEstimado : «Nulo» '
                                              WHEN  PedidoExibeValorEstimado = 0 THEN ' PedidoExibeValorEstimado : «Falso» '
                                              WHEN  PedidoExibeValorEstimado = 1 THEN ' PedidoExibeValorEstimado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoExibeJustificativaOutrosItens IS NULL THEN ' PedidoExibeJustificativaOutrosItens : «Nulo» '
                                              WHEN  PedidoExibeJustificativaOutrosItens = 0 THEN ' PedidoExibeJustificativaOutrosItens : «Falso» '
                                              WHEN  PedidoExibeJustificativaOutrosItens = 1 THEN ' PedidoExibeJustificativaOutrosItens : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LiberarDepreciacao IS NULL THEN ' LiberarDepreciacao : «Nulo» '
                                              WHEN  LiberarDepreciacao = 0 THEN ' LiberarDepreciacao : «Falso» '
                                              WHEN  LiberarDepreciacao = 1 THEN ' LiberarDepreciacao : «Verdadeiro» '
                                    END 
                         + '| IntervaloAvisoDepreciacao : «' + RTRIM( ISNULL( CAST (IntervaloAvisoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeridiocidadeDepreciacao : «' + RTRIM( ISNULL( CAST (PeridiocidadeDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstadoConservDepreciacao : «' + RTRIM( ISNULL( CAST (IdEstadoConservDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximaExibicaoAvisoDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, ProximaExibicaoAvisoDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IniciaDepreciacaoPorEstadoConserv IS NULL THEN ' IniciaDepreciacaoPorEstadoConserv : «Nulo» '
                                              WHEN  IniciaDepreciacaoPorEstadoConserv = 0 THEN ' IniciaDepreciacaoPorEstadoConserv : «Falso» '
                                              WHEN  IniciaDepreciacaoPorEstadoConserv = 1 THEN ' IniciaDepreciacaoPorEstadoConserv : «Verdadeiro» '
                                    END 
                         + '| IdEstadoConservDeprecTransf : «' + RTRIM( ISNULL( CAST (IdEstadoConservDeprecTransf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstadoConservDeprecOrigem : «' + RTRIM( ISNULL( CAST (IdEstadoConservDeprecOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AvisoImportacaoCotacoes : «' + RTRIM( ISNULL( CAST (AvisoImportacaoCotacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeAtendimentoServico IS NULL THEN ' ExibeAtendimentoServico : «Nulo» '
                                              WHEN  ExibeAtendimentoServico = 0 THEN ' ExibeAtendimentoServico : «Falso» '
                                              WHEN  ExibeAtendimentoServico = 1 THEN ' ExibeAtendimentoServico : «Verdadeiro» '
                                    END 
                         + '| ImportacaoXML : «' + RTRIM( ISNULL( CAST (ImportacaoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPeriodoMovimentacaoIni : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPeriodoMovimentacaoIni, 113 ),'Nulo'))+'» '
                         + '| DataPeriodoMovimentacaoFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPeriodoMovimentacaoFim, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaFinalidadePedido IS NULL THEN ' UtilizaFinalidadePedido : «Nulo» '
                                              WHEN  UtilizaFinalidadePedido = 0 THEN ' UtilizaFinalidadePedido : «Falso» '
                                              WHEN  UtilizaFinalidadePedido = 1 THEN ' UtilizaFinalidadePedido : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoImprimePedidoSolicitacao IS NULL THEN ' PedidoImprimePedidoSolicitacao : «Nulo» '
                                              WHEN  PedidoImprimePedidoSolicitacao = 0 THEN ' PedidoImprimePedidoSolicitacao : «Falso» '
                                              WHEN  PedidoImprimePedidoSolicitacao = 1 THEN ' PedidoImprimePedidoSolicitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedidoSequenciaAutorizacao IS NULL THEN ' PedidoSequenciaAutorizacao : «Nulo» '
                                              WHEN  PedidoSequenciaAutorizacao = 0 THEN ' PedidoSequenciaAutorizacao : «Falso» '
                                              WHEN  PedidoSequenciaAutorizacao = 1 THEN ' PedidoSequenciaAutorizacao : «Verdadeiro» '
                                    END 
                         + '| PedidoURLArquivoSolicitacao : «' + RTRIM( ISNULL( CAST (PedidoURLArquivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PedidoAnexaArquivoSolicitacao IS NULL THEN ' PedidoAnexaArquivoSolicitacao : «Nulo» '
                                              WHEN  PedidoAnexaArquivoSolicitacao = 0 THEN ' PedidoAnexaArquivoSolicitacao : «Falso» '
                                              WHEN  PedidoAnexaArquivoSolicitacao = 1 THEN ' PedidoAnexaArquivoSolicitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImportacaoXMLAtualizaMovBem IS NULL THEN ' ImportacaoXMLAtualizaMovBem : «Nulo» '
                                              WHEN  ImportacaoXMLAtualizaMovBem = 0 THEN ' ImportacaoXMLAtualizaMovBem : «Falso» '
                                              WHEN  ImportacaoXMLAtualizaMovBem = 1 THEN ' ImportacaoXMLAtualizaMovBem : «Verdadeiro» '
                                    END 
                         + '| AssinaturaTermoRepactuacao : «' + RTRIM( ISNULL( CAST (AssinaturaTermoRepactuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FATUtilizaFaturamento IS NULL THEN ' FATUtilizaFaturamento : «Nulo» '
                                              WHEN  FATUtilizaFaturamento = 0 THEN ' FATUtilizaFaturamento : «Falso» '
                                              WHEN  FATUtilizaFaturamento = 1 THEN ' FATUtilizaFaturamento : «Verdadeiro» '
                                    END 
                         + '| FATPrazoParaFaturamento : «' + RTRIM( ISNULL( CAST (FATPrazoParaFaturamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATPrazoVencNotasDebito : «' + RTRIM( ISNULL( CAST (FATPrazoVencNotasDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATPrazoInadimplencia : «' + RTRIM( ISNULL( CAST (FATPrazoInadimplencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATIntervaloAlerta : «' + RTRIM( ISNULL( CAST (FATIntervaloAlerta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FATAgendamentoAlerta : «' + RTRIM( ISNULL( CONVERT (CHAR, FATAgendamentoAlerta, 113 ),'Nulo'))+'» '
                         + '| FATIncrementoNotaDebito : «' + RTRIM( ISNULL( CAST (FATIncrementoNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoCabecalhoEmailND : «' + RTRIM( ISNULL( CAST (FatTextoCabecalhoEmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoRodapeEmailND : «' + RTRIM( ISNULL( CAST (FatTextoRodapeEmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura1EmailND : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura1EmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura2EmailND : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura2EmailND AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FATAnexarNotaDebitoEmail IS NULL THEN ' FATAnexarNotaDebitoEmail : «Nulo» '
                                              WHEN  FATAnexarNotaDebitoEmail = 0 THEN ' FATAnexarNotaDebitoEmail : «Falso» '
                                              WHEN  FATAnexarNotaDebitoEmail = 1 THEN ' FATAnexarNotaDebitoEmail : «Verdadeiro» '
                                    END 
                         + '| FatTextoCabecalhoAutPed : «' + RTRIM( ISNULL( CAST (FatTextoCabecalhoAutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoRodapeAutPed : «' + RTRIM( ISNULL( CAST (FatTextoRodapeAutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura1AutPed : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura1AutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatTextoAssinatura2AutPed : «' + RTRIM( ISNULL( CAST (FatTextoAssinatura2AutPed AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatAssinatura1NotaDebito : «' + RTRIM( ISNULL( CAST (FatAssinatura1NotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SepararItemOrdemCompra IS NULL THEN ' SepararItemOrdemCompra : «Nulo» '
                                              WHEN  SepararItemOrdemCompra = 0 THEN ' SepararItemOrdemCompra : «Falso» '
                                              WHEN  SepararItemOrdemCompra = 1 THEN ' SepararItemOrdemCompra : «Verdadeiro» '
                                    END 
                         + '| CaptionNumProtocolo : «' + RTRIM( ISNULL( CAST (CaptionNumProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MultiplosLocaisEntregaPAT IS NULL THEN ' MultiplosLocaisEntregaPAT : «Nulo» '
                                              WHEN  MultiplosLocaisEntregaPAT = 0 THEN ' MultiplosLocaisEntregaPAT : «Falso» '
                                              WHEN  MultiplosLocaisEntregaPAT = 1 THEN ' MultiplosLocaisEntregaPAT : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaContabilizacaoMCASP IS NULL THEN ' UtilizaContabilizacaoMCASP : «Nulo» '
                                              WHEN  UtilizaContabilizacaoMCASP = 0 THEN ' UtilizaContabilizacaoMCASP : «Falso» '
                                              WHEN  UtilizaContabilizacaoMCASP = 1 THEN ' UtilizaContabilizacaoMCASP : «Verdadeiro» '
                                    END 
                         + '| DataContabilizacaoAL_MCASP : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL_MCASP, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT_MCASP : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT_MCASP, 113 ),'Nulo'))+'» '
                         + '| AlertaCadastroOrdem : «' + RTRIM( ISNULL( CAST (AlertaCadastroOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlertaCadastroOrdemQtdDias : «' + RTRIM( ISNULL( CAST (AlertaCadastroOrdemQtdDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlertaRecebimentoProcessoCompra : «' + RTRIM( ISNULL( CAST (AlertaRecebimentoProcessoCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoTemp : «' + RTRIM( ISNULL( CAST (EnderecoTemp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FechaAlm : «' + RTRIM( ISNULL( CAST (FechaAlm AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FechaAlmDataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, FechaAlmDataInicial, 113 ),'Nulo'))+'» '
                         + '| FechaAlmDataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, FechaAlmDataFinal, 113 ),'Nulo'))+'» '
                         + '| CasasDecimais : «' + RTRIM( ISNULL( CAST (CasasDecimais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoFonte : «' + RTRIM( ISNULL( CAST (TamanhoFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ContabilizaMCASPInventarioMenos IS NULL THEN ' ContabilizaMCASPInventarioMenos : «Nulo» '
                                              WHEN  ContabilizaMCASPInventarioMenos = 0 THEN ' ContabilizaMCASPInventarioMenos : «Falso» '
                                              WHEN  ContabilizaMCASPInventarioMenos = 1 THEN ' ContabilizaMCASPInventarioMenos : «Verdadeiro» '
                                    END 
                         + '| IntervaloAvisoDepreciacaoBI : «' + RTRIM( ISNULL( CAST (IntervaloAvisoDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeridiocidadeDepreciacaoBI : «' + RTRIM( ISNULL( CAST (PeridiocidadeDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximaExibicaoAvisoDepreciacaoBI : «' + RTRIM( ISNULL( CONVERT (CHAR, ProximaExibicaoAvisoDepreciacaoBI, 113 ),'Nulo'))+'» '
                         + '| ClassificacaoItensOrdemCompra : «' + RTRIM( ISNULL( CAST (ClassificacaoItensOrdemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermitirAlterarDtPrevLicit IS NULL THEN ' PermitirAlterarDtPrevLicit : «Nulo» '
                                              WHEN  PermitirAlterarDtPrevLicit = 0 THEN ' PermitirAlterarDtPrevLicit : «Falso» '
                                              WHEN  PermitirAlterarDtPrevLicit = 1 THEN ' PermitirAlterarDtPrevLicit : «Verdadeiro» '
                                    END 
                         + '| TiposMovimentacaoVerificados : «' + RTRIM( ISNULL( CAST (TiposMovimentacaoVerificados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtInicioNovaContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioNovaContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| DtInicioHistoricoBaixaBem : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioHistoricoBaixaBem, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeSaldoRealBalancete IS NULL THEN ' ExibeSaldoRealBalancete : «Nulo» '
                                              WHEN  ExibeSaldoRealBalancete = 0 THEN ' ExibeSaldoRealBalancete : «Falso» '
                                              WHEN  ExibeSaldoRealBalancete = 1 THEN ' ExibeSaldoRealBalancete : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSispatConversao IS NULL THEN ' BloqueiaSispatConversao : «Nulo» '
                                              WHEN  BloqueiaSispatConversao = 0 THEN ' BloqueiaSispatConversao : «Falso» '
                                              WHEN  BloqueiaSispatConversao = 1 THEN ' BloqueiaSispatConversao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSialmConversao IS NULL THEN ' BloqueiaSialmConversao : «Nulo» '
                                              WHEN  BloqueiaSialmConversao = 0 THEN ' BloqueiaSialmConversao : «Falso» '
                                              WHEN  BloqueiaSialmConversao = 1 THEN ' BloqueiaSialmConversao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloqueiaSICCLConversao IS NULL THEN ' BloqueiaSICCLConversao : «Nulo» '
                                              WHEN  BloqueiaSICCLConversao = 0 THEN ' BloqueiaSICCLConversao : «Falso» '
                                              WHEN  BloqueiaSICCLConversao = 1 THEN ' BloqueiaSICCLConversao : «Verdadeiro» '
                                    END 
                         + '| DataConversaoSICCL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConversaoSICCL, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaDataConversao IS NULL THEN ' UtilizaDataConversao : «Nulo» '
                                              WHEN  UtilizaDataConversao = 0 THEN ' UtilizaDataConversao : «Falso» '
                                              WHEN  UtilizaDataConversao = 1 THEN ' UtilizaDataConversao : «Verdadeiro» '
                                    END 
                         + '| IdUnidadeConversao : «' + RTRIM( ISNULL( CAST (IdUnidadeConversao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelConversao : «' + RTRIM( ISNULL( CAST (IdResponsavelConversao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
