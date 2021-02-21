CREATE TABLE [dbo].[Fases] (
    [IdFase]                    INT           IDENTITY (1, 1) NOT NULL,
    [Fase]                      VARCHAR (50)  NOT NULL,
    [CodFase]                   CHAR (8)      NULL,
    [REQUERPESSOA]              BIT           NULL,
    [DATAAUT]                   BIT           NULL,
    [PRZRESP]                   INT           NULL,
    [UsarDataReferencia]        BIT           NULL,
    [IdModelo]                  INT           NULL,
    [CampoPDinamico]            VARCHAR (50)  NULL,
    [FaseDistribuicao]          BIT           NULL,
    [FaseTermino]               BIT           NULL,
    [DesvincularRelator]        BIT           NULL,
    [IdEtapaDestino]            INT           NULL,
    [TipoFase]                  INT           NULL,
    [VisualizarWeb]             BIT           NULL,
    [DistribuicaoInstrutor]     BIT           NULL,
    [EnviaNotificacao]          BIT           CONSTRAINT [DF__Fases__EnviaNoti__020EAA92] DEFAULT ((0)) NOT NULL,
    [AssuntoEmail]              VARCHAR (100) NULL,
    [MensagemEmail]             TEXT          NULL,
    [DestinatariosEmail]        VARCHAR (100) NULL,
    [ExibirTelaCadastro]        BIT           CONSTRAINT [DF__Fases__ExibirTel__03F6F304] DEFAULT ((0)) NOT NULL,
    [ConsiderarAnoDistribuicao] BIT           CONSTRAINT [DF_FasesConsiderarAnoDistribuicao] DEFAULT ((0)) NULL,
    [Desativado]                BIT           CONSTRAINT [DF_FasesDesativado] DEFAULT ((0)) NULL,
    [TramitarProcesso]          BIT           NULL,
    [IdLocalTramitacao]         INT           NULL,
    [IdDestinatarioTramitacao]  INT           NULL,
    [TramitarEmLote]            BIT           CONSTRAINT [DF_FasesTramitarEmLote] DEFAULT ((0)) NULL,
    [PrioridadeTramitacao]      INT           NULL,
    [IdSituacaoTramitacao]      INT           NULL,
    [AndamentoTramitacao]       TEXT          NULL,
    [PendenciasTramitacao]      TEXT          NULL,
    [AlteraSituacaoCadastral]   BIT           NULL,
    [IdSituacaoPFPJ]            INT           NULL,
    [RetornaSituacaoCadastral]  BIT           NULL,
    [FiltraPessoas]             BIT           NULL,
    [CampoPDinamicoFiltro]      VARCHAR (50)  NULL,
    [IdSituacaoPFPJRetorno]     INT           NULL,
    [IdDetalheSituacao]         INT           NULL,
    [AlteraSituacaoFisc]        BIT           NULL,
    [idSituacaoProcFis]         INT           NULL,
    [ArquivaFiscalizacao]       BIT           NULL,
    [ModeloCorrespondencia]     IMAGE         NULL,
    [IdTipoDocumento]           INT           NULL,
    [TipoAndamento]             CHAR (1)      DEFAULT ('O') NOT NULL,
    [ExigeCPFCNPJ]              BIT           CONSTRAINT [DEF_FasesExigeCPFCNPJ] DEFAULT ((0)) NOT NULL,
    [IdSituacaoDocumento]       INT           NULL,
    [ModeloProcesso]            IMAGE         NULL,
    [IdTipoProcesso]            INT           NULL,
    [IdSituacaoProcesso]        INT           NULL,
    [BaixaProcesso]             BIT           CONSTRAINT [DEF_Fases_BaixaProcesso] DEFAULT ((0)) NOT NULL,
    [BaixaProcessoQuant]        INT           CONSTRAINT [DEF_Fases_BaixaProcessoQuant] DEFAULT ((0)) NOT NULL,
    [DataRefObrigatoria]        BIT           DEFAULT ((0)) NOT NULL,
    [QtdDiasBloqueio]           INT           NULL,
    [PrazoBloqueioVariavel]     BIT           CONSTRAINT [DF_Fases_PrazoBloqueioVariavel] DEFAULT ((0)) NOT NULL,
    [VoltarTramitacao]          BIT           CONSTRAINT [DF_Fases_VoltarTramitacao] DEFAULT ((0)) NOT NULL,
    [EmitirBoleto]              BIT           CONSTRAINT [DEF_Fases_EmitirBoleto] DEFAULT ((0)) NOT NULL,
    [IdFaseInfracao]            INT           NULL,
    [MotivoAndamento]           INT           NULL,
    [AlteraMotivoAndamentoFis]  BIT           CONSTRAINT [DEF_Fases_AlteraMotivoAndamentoFis] DEFAULT ((0)) NOT NULL,
    [Ocorrencia]                TEXT          NULL,
    [ExibirCadastroPFPJ]        BIT           CONSTRAINT [DF_Fases_ExibirCadastroPFPJ] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Fases] PRIMARY KEY CLUSTERED ([IdFase] ASC),
    CONSTRAINT [FK_Fases_Departamento] FOREIGN KEY ([IdLocalTramitacao]) REFERENCES [dbo].[Departamentos] ([IdDepto]),
    CONSTRAINT [FK_Fases_DetalhesSituacao] FOREIGN KEY ([IdDetalheSituacao]) REFERENCES [dbo].[DetalhesSituacao] ([IdDetalheSituacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Fases_Etapas] FOREIGN KEY ([IdEtapaDestino]) REFERENCES [dbo].[Etapas] ([IdEtapa]),
    CONSTRAINT [FK_Fases_IdSituacaoProcesso] FOREIGN KEY ([IdSituacaoProcesso]) REFERENCES [dbo].[SituacoesProcFis] ([IdSituacaoProcFis]),
    CONSTRAINT [FK_Fases_IdTipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso]),
    CONSTRAINT [FK_Fases_SituacaoDocumento] FOREIGN KEY ([IdSituacaoDocumento]) REFERENCES [dbo].[SituacoesDocumento] ([IdSituacaoDocumento]),
    CONSTRAINT [FK_Fases_SituacaoPFPJ] FOREIGN KEY ([IdSituacaoPFPJ]) REFERENCES [dbo].[SituacoesPFPJ] ([IdSituacaoPFPJ]),
    CONSTRAINT [FK_Fases_SituacoesProcFis] FOREIGN KEY ([idSituacaoProcFis]) REFERENCES [dbo].[SituacoesProcFis] ([IdSituacaoProcFis]),
    CONSTRAINT [FK_Fases_SituacoesTramitacao] FOREIGN KEY ([IdSituacaoTramitacao]) REFERENCES [dbo].[SituacoesTramitacao] ([IdSituacaoTramitacao]),
    CONSTRAINT [FK_Fases_Usuarios] FOREIGN KEY ([IdDestinatarioTramitacao]) REFERENCES [dbo].[Usuarios] ([IdUsuario]),
    CONSTRAINT [FK_TiposDocumentos] FOREIGN KEY ([IdTipoDocumento]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento])
);


GO
CREATE TRIGGER [TrgLog_Fases] ON [Implanta_CRPAM].[dbo].[Fases] 
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
SET @TableName = 'Fases'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Fase : «' + RTRIM( ISNULL( CAST (Fase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodFase : «' + RTRIM( ISNULL( CAST (CodFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  REQUERPESSOA IS NULL THEN ' REQUERPESSOA : «Nulo» '
                                              WHEN  REQUERPESSOA = 0 THEN ' REQUERPESSOA : «Falso» '
                                              WHEN  REQUERPESSOA = 1 THEN ' REQUERPESSOA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DATAAUT IS NULL THEN ' DATAAUT : «Nulo» '
                                              WHEN  DATAAUT = 0 THEN ' DATAAUT : «Falso» '
                                              WHEN  DATAAUT = 1 THEN ' DATAAUT : «Verdadeiro» '
                                    END 
                         + '| PRZRESP : «' + RTRIM( ISNULL( CAST (PRZRESP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsarDataReferencia IS NULL THEN ' UsarDataReferencia : «Nulo» '
                                              WHEN  UsarDataReferencia = 0 THEN ' UsarDataReferencia : «Falso» '
                                              WHEN  UsarDataReferencia = 1 THEN ' UsarDataReferencia : «Verdadeiro» '
                                    END 
                         + '| IdModelo : «' + RTRIM( ISNULL( CAST (IdModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoPDinamico : «' + RTRIM( ISNULL( CAST (CampoPDinamico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FaseDistribuicao IS NULL THEN ' FaseDistribuicao : «Nulo» '
                                              WHEN  FaseDistribuicao = 0 THEN ' FaseDistribuicao : «Falso» '
                                              WHEN  FaseDistribuicao = 1 THEN ' FaseDistribuicao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FaseTermino IS NULL THEN ' FaseTermino : «Nulo» '
                                              WHEN  FaseTermino = 0 THEN ' FaseTermino : «Falso» '
                                              WHEN  FaseTermino = 1 THEN ' FaseTermino : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DesvincularRelator IS NULL THEN ' DesvincularRelator : «Nulo» '
                                              WHEN  DesvincularRelator = 0 THEN ' DesvincularRelator : «Falso» '
                                              WHEN  DesvincularRelator = 1 THEN ' DesvincularRelator : «Verdadeiro» '
                                    END 
                         + '| IdEtapaDestino : «' + RTRIM( ISNULL( CAST (IdEtapaDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoFase : «' + RTRIM( ISNULL( CAST (TipoFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizarWeb IS NULL THEN ' VisualizarWeb : «Nulo» '
                                              WHEN  VisualizarWeb = 0 THEN ' VisualizarWeb : «Falso» '
                                              WHEN  VisualizarWeb = 1 THEN ' VisualizarWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DistribuicaoInstrutor IS NULL THEN ' DistribuicaoInstrutor : «Nulo» '
                                              WHEN  DistribuicaoInstrutor = 0 THEN ' DistribuicaoInstrutor : «Falso» '
                                              WHEN  DistribuicaoInstrutor = 1 THEN ' DistribuicaoInstrutor : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EnviaNotificacao IS NULL THEN ' EnviaNotificacao : «Nulo» '
                                              WHEN  EnviaNotificacao = 0 THEN ' EnviaNotificacao : «Falso» '
                                              WHEN  EnviaNotificacao = 1 THEN ' EnviaNotificacao : «Verdadeiro» '
                                    END 
                         + '| AssuntoEmail : «' + RTRIM( ISNULL( CAST (AssuntoEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatariosEmail : «' + RTRIM( ISNULL( CAST (DestinatariosEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirTelaCadastro IS NULL THEN ' ExibirTelaCadastro : «Nulo» '
                                              WHEN  ExibirTelaCadastro = 0 THEN ' ExibirTelaCadastro : «Falso» '
                                              WHEN  ExibirTelaCadastro = 1 THEN ' ExibirTelaCadastro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ConsiderarAnoDistribuicao IS NULL THEN ' ConsiderarAnoDistribuicao : «Nulo» '
                                              WHEN  ConsiderarAnoDistribuicao = 0 THEN ' ConsiderarAnoDistribuicao : «Falso» '
                                              WHEN  ConsiderarAnoDistribuicao = 1 THEN ' ConsiderarAnoDistribuicao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitarProcesso IS NULL THEN ' TramitarProcesso : «Nulo» '
                                              WHEN  TramitarProcesso = 0 THEN ' TramitarProcesso : «Falso» '
                                              WHEN  TramitarProcesso = 1 THEN ' TramitarProcesso : «Verdadeiro» '
                                    END 
                         + '| IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDestinatarioTramitacao : «' + RTRIM( ISNULL( CAST (IdDestinatarioTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TramitarEmLote IS NULL THEN ' TramitarEmLote : «Nulo» '
                                              WHEN  TramitarEmLote = 0 THEN ' TramitarEmLote : «Falso» '
                                              WHEN  TramitarEmLote = 1 THEN ' TramitarEmLote : «Verdadeiro» '
                                    END 
                         + '| PrioridadeTramitacao : «' + RTRIM( ISNULL( CAST (PrioridadeTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoTramitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraSituacaoCadastral IS NULL THEN ' AlteraSituacaoCadastral : «Nulo» '
                                              WHEN  AlteraSituacaoCadastral = 0 THEN ' AlteraSituacaoCadastral : «Falso» '
                                              WHEN  AlteraSituacaoCadastral = 1 THEN ' AlteraSituacaoCadastral : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RetornaSituacaoCadastral IS NULL THEN ' RetornaSituacaoCadastral : «Nulo» '
                                              WHEN  RetornaSituacaoCadastral = 0 THEN ' RetornaSituacaoCadastral : «Falso» '
                                              WHEN  RetornaSituacaoCadastral = 1 THEN ' RetornaSituacaoCadastral : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FiltraPessoas IS NULL THEN ' FiltraPessoas : «Nulo» '
                                              WHEN  FiltraPessoas = 0 THEN ' FiltraPessoas : «Falso» '
                                              WHEN  FiltraPessoas = 1 THEN ' FiltraPessoas : «Verdadeiro» '
                                    END 
                         + '| CampoPDinamicoFiltro : «' + RTRIM( ISNULL( CAST (CampoPDinamicoFiltro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJRetorno : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacao : «' + RTRIM( ISNULL( CAST (IdDetalheSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraSituacaoFisc IS NULL THEN ' AlteraSituacaoFisc : «Nulo» '
                                              WHEN  AlteraSituacaoFisc = 0 THEN ' AlteraSituacaoFisc : «Falso» '
                                              WHEN  AlteraSituacaoFisc = 1 THEN ' AlteraSituacaoFisc : «Verdadeiro» '
                                    END 
                         + '| idSituacaoProcFis : «' + RTRIM( ISNULL( CAST (idSituacaoProcFis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ArquivaFiscalizacao IS NULL THEN ' ArquivaFiscalizacao : «Nulo» '
                                              WHEN  ArquivaFiscalizacao = 0 THEN ' ArquivaFiscalizacao : «Falso» '
                                              WHEN  ArquivaFiscalizacao = 1 THEN ' ArquivaFiscalizacao : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAndamento : «' + RTRIM( ISNULL( CAST (TipoAndamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExigeCPFCNPJ IS NULL THEN ' ExigeCPFCNPJ : «Nulo» '
                                              WHEN  ExigeCPFCNPJ = 0 THEN ' ExigeCPFCNPJ : «Falso» '
                                              WHEN  ExigeCPFCNPJ = 1 THEN ' ExigeCPFCNPJ : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoProcesso : «' + RTRIM( ISNULL( CAST (IdSituacaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaixaProcesso IS NULL THEN ' BaixaProcesso : «Nulo» '
                                              WHEN  BaixaProcesso = 0 THEN ' BaixaProcesso : «Falso» '
                                              WHEN  BaixaProcesso = 1 THEN ' BaixaProcesso : «Verdadeiro» '
                                    END 
                         + '| BaixaProcessoQuant : «' + RTRIM( ISNULL( CAST (BaixaProcessoQuant AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DataRefObrigatoria IS NULL THEN ' DataRefObrigatoria : «Nulo» '
                                              WHEN  DataRefObrigatoria = 0 THEN ' DataRefObrigatoria : «Falso» '
                                              WHEN  DataRefObrigatoria = 1 THEN ' DataRefObrigatoria : «Verdadeiro» '
                                    END 
                         + '| QtdDiasBloqueio : «' + RTRIM( ISNULL( CAST (QtdDiasBloqueio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PrazoBloqueioVariavel IS NULL THEN ' PrazoBloqueioVariavel : «Nulo» '
                                              WHEN  PrazoBloqueioVariavel = 0 THEN ' PrazoBloqueioVariavel : «Falso» '
                                              WHEN  PrazoBloqueioVariavel = 1 THEN ' PrazoBloqueioVariavel : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VoltarTramitacao IS NULL THEN ' VoltarTramitacao : «Nulo» '
                                              WHEN  VoltarTramitacao = 0 THEN ' VoltarTramitacao : «Falso» '
                                              WHEN  VoltarTramitacao = 1 THEN ' VoltarTramitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmitirBoleto IS NULL THEN ' EmitirBoleto : «Nulo» '
                                              WHEN  EmitirBoleto = 0 THEN ' EmitirBoleto : «Falso» '
                                              WHEN  EmitirBoleto = 1 THEN ' EmitirBoleto : «Verdadeiro» '
                                    END 
                         + '| IdFaseInfracao : «' + RTRIM( ISNULL( CAST (IdFaseInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoAndamento : «' + RTRIM( ISNULL( CAST (MotivoAndamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraMotivoAndamentoFis IS NULL THEN ' AlteraMotivoAndamentoFis : «Nulo» '
                                              WHEN  AlteraMotivoAndamentoFis = 0 THEN ' AlteraMotivoAndamentoFis : «Falso» '
                                              WHEN  AlteraMotivoAndamentoFis = 1 THEN ' AlteraMotivoAndamentoFis : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirCadastroPFPJ IS NULL THEN ' ExibirCadastroPFPJ : «Nulo» '
                                              WHEN  ExibirCadastroPFPJ = 0 THEN ' ExibirCadastroPFPJ : «Falso» '
                                              WHEN  ExibirCadastroPFPJ = 1 THEN ' ExibirCadastroPFPJ : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Fase : «' + RTRIM( ISNULL( CAST (Fase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodFase : «' + RTRIM( ISNULL( CAST (CodFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  REQUERPESSOA IS NULL THEN ' REQUERPESSOA : «Nulo» '
                                              WHEN  REQUERPESSOA = 0 THEN ' REQUERPESSOA : «Falso» '
                                              WHEN  REQUERPESSOA = 1 THEN ' REQUERPESSOA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DATAAUT IS NULL THEN ' DATAAUT : «Nulo» '
                                              WHEN  DATAAUT = 0 THEN ' DATAAUT : «Falso» '
                                              WHEN  DATAAUT = 1 THEN ' DATAAUT : «Verdadeiro» '
                                    END 
                         + '| PRZRESP : «' + RTRIM( ISNULL( CAST (PRZRESP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsarDataReferencia IS NULL THEN ' UsarDataReferencia : «Nulo» '
                                              WHEN  UsarDataReferencia = 0 THEN ' UsarDataReferencia : «Falso» '
                                              WHEN  UsarDataReferencia = 1 THEN ' UsarDataReferencia : «Verdadeiro» '
                                    END 
                         + '| IdModelo : «' + RTRIM( ISNULL( CAST (IdModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoPDinamico : «' + RTRIM( ISNULL( CAST (CampoPDinamico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FaseDistribuicao IS NULL THEN ' FaseDistribuicao : «Nulo» '
                                              WHEN  FaseDistribuicao = 0 THEN ' FaseDistribuicao : «Falso» '
                                              WHEN  FaseDistribuicao = 1 THEN ' FaseDistribuicao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FaseTermino IS NULL THEN ' FaseTermino : «Nulo» '
                                              WHEN  FaseTermino = 0 THEN ' FaseTermino : «Falso» '
                                              WHEN  FaseTermino = 1 THEN ' FaseTermino : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DesvincularRelator IS NULL THEN ' DesvincularRelator : «Nulo» '
                                              WHEN  DesvincularRelator = 0 THEN ' DesvincularRelator : «Falso» '
                                              WHEN  DesvincularRelator = 1 THEN ' DesvincularRelator : «Verdadeiro» '
                                    END 
                         + '| IdEtapaDestino : «' + RTRIM( ISNULL( CAST (IdEtapaDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoFase : «' + RTRIM( ISNULL( CAST (TipoFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizarWeb IS NULL THEN ' VisualizarWeb : «Nulo» '
                                              WHEN  VisualizarWeb = 0 THEN ' VisualizarWeb : «Falso» '
                                              WHEN  VisualizarWeb = 1 THEN ' VisualizarWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DistribuicaoInstrutor IS NULL THEN ' DistribuicaoInstrutor : «Nulo» '
                                              WHEN  DistribuicaoInstrutor = 0 THEN ' DistribuicaoInstrutor : «Falso» '
                                              WHEN  DistribuicaoInstrutor = 1 THEN ' DistribuicaoInstrutor : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EnviaNotificacao IS NULL THEN ' EnviaNotificacao : «Nulo» '
                                              WHEN  EnviaNotificacao = 0 THEN ' EnviaNotificacao : «Falso» '
                                              WHEN  EnviaNotificacao = 1 THEN ' EnviaNotificacao : «Verdadeiro» '
                                    END 
                         + '| AssuntoEmail : «' + RTRIM( ISNULL( CAST (AssuntoEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatariosEmail : «' + RTRIM( ISNULL( CAST (DestinatariosEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirTelaCadastro IS NULL THEN ' ExibirTelaCadastro : «Nulo» '
                                              WHEN  ExibirTelaCadastro = 0 THEN ' ExibirTelaCadastro : «Falso» '
                                              WHEN  ExibirTelaCadastro = 1 THEN ' ExibirTelaCadastro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ConsiderarAnoDistribuicao IS NULL THEN ' ConsiderarAnoDistribuicao : «Nulo» '
                                              WHEN  ConsiderarAnoDistribuicao = 0 THEN ' ConsiderarAnoDistribuicao : «Falso» '
                                              WHEN  ConsiderarAnoDistribuicao = 1 THEN ' ConsiderarAnoDistribuicao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitarProcesso IS NULL THEN ' TramitarProcesso : «Nulo» '
                                              WHEN  TramitarProcesso = 0 THEN ' TramitarProcesso : «Falso» '
                                              WHEN  TramitarProcesso = 1 THEN ' TramitarProcesso : «Verdadeiro» '
                                    END 
                         + '| IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDestinatarioTramitacao : «' + RTRIM( ISNULL( CAST (IdDestinatarioTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TramitarEmLote IS NULL THEN ' TramitarEmLote : «Nulo» '
                                              WHEN  TramitarEmLote = 0 THEN ' TramitarEmLote : «Falso» '
                                              WHEN  TramitarEmLote = 1 THEN ' TramitarEmLote : «Verdadeiro» '
                                    END 
                         + '| PrioridadeTramitacao : «' + RTRIM( ISNULL( CAST (PrioridadeTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoTramitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraSituacaoCadastral IS NULL THEN ' AlteraSituacaoCadastral : «Nulo» '
                                              WHEN  AlteraSituacaoCadastral = 0 THEN ' AlteraSituacaoCadastral : «Falso» '
                                              WHEN  AlteraSituacaoCadastral = 1 THEN ' AlteraSituacaoCadastral : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RetornaSituacaoCadastral IS NULL THEN ' RetornaSituacaoCadastral : «Nulo» '
                                              WHEN  RetornaSituacaoCadastral = 0 THEN ' RetornaSituacaoCadastral : «Falso» '
                                              WHEN  RetornaSituacaoCadastral = 1 THEN ' RetornaSituacaoCadastral : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FiltraPessoas IS NULL THEN ' FiltraPessoas : «Nulo» '
                                              WHEN  FiltraPessoas = 0 THEN ' FiltraPessoas : «Falso» '
                                              WHEN  FiltraPessoas = 1 THEN ' FiltraPessoas : «Verdadeiro» '
                                    END 
                         + '| CampoPDinamicoFiltro : «' + RTRIM( ISNULL( CAST (CampoPDinamicoFiltro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJRetorno : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacao : «' + RTRIM( ISNULL( CAST (IdDetalheSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraSituacaoFisc IS NULL THEN ' AlteraSituacaoFisc : «Nulo» '
                                              WHEN  AlteraSituacaoFisc = 0 THEN ' AlteraSituacaoFisc : «Falso» '
                                              WHEN  AlteraSituacaoFisc = 1 THEN ' AlteraSituacaoFisc : «Verdadeiro» '
                                    END 
                         + '| idSituacaoProcFis : «' + RTRIM( ISNULL( CAST (idSituacaoProcFis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ArquivaFiscalizacao IS NULL THEN ' ArquivaFiscalizacao : «Nulo» '
                                              WHEN  ArquivaFiscalizacao = 0 THEN ' ArquivaFiscalizacao : «Falso» '
                                              WHEN  ArquivaFiscalizacao = 1 THEN ' ArquivaFiscalizacao : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAndamento : «' + RTRIM( ISNULL( CAST (TipoAndamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExigeCPFCNPJ IS NULL THEN ' ExigeCPFCNPJ : «Nulo» '
                                              WHEN  ExigeCPFCNPJ = 0 THEN ' ExigeCPFCNPJ : «Falso» '
                                              WHEN  ExigeCPFCNPJ = 1 THEN ' ExigeCPFCNPJ : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoProcesso : «' + RTRIM( ISNULL( CAST (IdSituacaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaixaProcesso IS NULL THEN ' BaixaProcesso : «Nulo» '
                                              WHEN  BaixaProcesso = 0 THEN ' BaixaProcesso : «Falso» '
                                              WHEN  BaixaProcesso = 1 THEN ' BaixaProcesso : «Verdadeiro» '
                                    END 
                         + '| BaixaProcessoQuant : «' + RTRIM( ISNULL( CAST (BaixaProcessoQuant AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DataRefObrigatoria IS NULL THEN ' DataRefObrigatoria : «Nulo» '
                                              WHEN  DataRefObrigatoria = 0 THEN ' DataRefObrigatoria : «Falso» '
                                              WHEN  DataRefObrigatoria = 1 THEN ' DataRefObrigatoria : «Verdadeiro» '
                                    END 
                         + '| QtdDiasBloqueio : «' + RTRIM( ISNULL( CAST (QtdDiasBloqueio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PrazoBloqueioVariavel IS NULL THEN ' PrazoBloqueioVariavel : «Nulo» '
                                              WHEN  PrazoBloqueioVariavel = 0 THEN ' PrazoBloqueioVariavel : «Falso» '
                                              WHEN  PrazoBloqueioVariavel = 1 THEN ' PrazoBloqueioVariavel : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VoltarTramitacao IS NULL THEN ' VoltarTramitacao : «Nulo» '
                                              WHEN  VoltarTramitacao = 0 THEN ' VoltarTramitacao : «Falso» '
                                              WHEN  VoltarTramitacao = 1 THEN ' VoltarTramitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmitirBoleto IS NULL THEN ' EmitirBoleto : «Nulo» '
                                              WHEN  EmitirBoleto = 0 THEN ' EmitirBoleto : «Falso» '
                                              WHEN  EmitirBoleto = 1 THEN ' EmitirBoleto : «Verdadeiro» '
                                    END 
                         + '| IdFaseInfracao : «' + RTRIM( ISNULL( CAST (IdFaseInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoAndamento : «' + RTRIM( ISNULL( CAST (MotivoAndamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraMotivoAndamentoFis IS NULL THEN ' AlteraMotivoAndamentoFis : «Nulo» '
                                              WHEN  AlteraMotivoAndamentoFis = 0 THEN ' AlteraMotivoAndamentoFis : «Falso» '
                                              WHEN  AlteraMotivoAndamentoFis = 1 THEN ' AlteraMotivoAndamentoFis : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirCadastroPFPJ IS NULL THEN ' ExibirCadastroPFPJ : «Nulo» '
                                              WHEN  ExibirCadastroPFPJ = 0 THEN ' ExibirCadastroPFPJ : «Falso» '
                                              WHEN  ExibirCadastroPFPJ = 1 THEN ' ExibirCadastroPFPJ : «Verdadeiro» '
                                    END  FROM INSERTED 
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
		SELECT @Conteudo = 'IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Fase : «' + RTRIM( ISNULL( CAST (Fase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodFase : «' + RTRIM( ISNULL( CAST (CodFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  REQUERPESSOA IS NULL THEN ' REQUERPESSOA : «Nulo» '
                                              WHEN  REQUERPESSOA = 0 THEN ' REQUERPESSOA : «Falso» '
                                              WHEN  REQUERPESSOA = 1 THEN ' REQUERPESSOA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DATAAUT IS NULL THEN ' DATAAUT : «Nulo» '
                                              WHEN  DATAAUT = 0 THEN ' DATAAUT : «Falso» '
                                              WHEN  DATAAUT = 1 THEN ' DATAAUT : «Verdadeiro» '
                                    END 
                         + '| PRZRESP : «' + RTRIM( ISNULL( CAST (PRZRESP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsarDataReferencia IS NULL THEN ' UsarDataReferencia : «Nulo» '
                                              WHEN  UsarDataReferencia = 0 THEN ' UsarDataReferencia : «Falso» '
                                              WHEN  UsarDataReferencia = 1 THEN ' UsarDataReferencia : «Verdadeiro» '
                                    END 
                         + '| IdModelo : «' + RTRIM( ISNULL( CAST (IdModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoPDinamico : «' + RTRIM( ISNULL( CAST (CampoPDinamico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FaseDistribuicao IS NULL THEN ' FaseDistribuicao : «Nulo» '
                                              WHEN  FaseDistribuicao = 0 THEN ' FaseDistribuicao : «Falso» '
                                              WHEN  FaseDistribuicao = 1 THEN ' FaseDistribuicao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FaseTermino IS NULL THEN ' FaseTermino : «Nulo» '
                                              WHEN  FaseTermino = 0 THEN ' FaseTermino : «Falso» '
                                              WHEN  FaseTermino = 1 THEN ' FaseTermino : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DesvincularRelator IS NULL THEN ' DesvincularRelator : «Nulo» '
                                              WHEN  DesvincularRelator = 0 THEN ' DesvincularRelator : «Falso» '
                                              WHEN  DesvincularRelator = 1 THEN ' DesvincularRelator : «Verdadeiro» '
                                    END 
                         + '| IdEtapaDestino : «' + RTRIM( ISNULL( CAST (IdEtapaDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoFase : «' + RTRIM( ISNULL( CAST (TipoFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizarWeb IS NULL THEN ' VisualizarWeb : «Nulo» '
                                              WHEN  VisualizarWeb = 0 THEN ' VisualizarWeb : «Falso» '
                                              WHEN  VisualizarWeb = 1 THEN ' VisualizarWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DistribuicaoInstrutor IS NULL THEN ' DistribuicaoInstrutor : «Nulo» '
                                              WHEN  DistribuicaoInstrutor = 0 THEN ' DistribuicaoInstrutor : «Falso» '
                                              WHEN  DistribuicaoInstrutor = 1 THEN ' DistribuicaoInstrutor : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EnviaNotificacao IS NULL THEN ' EnviaNotificacao : «Nulo» '
                                              WHEN  EnviaNotificacao = 0 THEN ' EnviaNotificacao : «Falso» '
                                              WHEN  EnviaNotificacao = 1 THEN ' EnviaNotificacao : «Verdadeiro» '
                                    END 
                         + '| AssuntoEmail : «' + RTRIM( ISNULL( CAST (AssuntoEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatariosEmail : «' + RTRIM( ISNULL( CAST (DestinatariosEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirTelaCadastro IS NULL THEN ' ExibirTelaCadastro : «Nulo» '
                                              WHEN  ExibirTelaCadastro = 0 THEN ' ExibirTelaCadastro : «Falso» '
                                              WHEN  ExibirTelaCadastro = 1 THEN ' ExibirTelaCadastro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ConsiderarAnoDistribuicao IS NULL THEN ' ConsiderarAnoDistribuicao : «Nulo» '
                                              WHEN  ConsiderarAnoDistribuicao = 0 THEN ' ConsiderarAnoDistribuicao : «Falso» '
                                              WHEN  ConsiderarAnoDistribuicao = 1 THEN ' ConsiderarAnoDistribuicao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitarProcesso IS NULL THEN ' TramitarProcesso : «Nulo» '
                                              WHEN  TramitarProcesso = 0 THEN ' TramitarProcesso : «Falso» '
                                              WHEN  TramitarProcesso = 1 THEN ' TramitarProcesso : «Verdadeiro» '
                                    END 
                         + '| IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDestinatarioTramitacao : «' + RTRIM( ISNULL( CAST (IdDestinatarioTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TramitarEmLote IS NULL THEN ' TramitarEmLote : «Nulo» '
                                              WHEN  TramitarEmLote = 0 THEN ' TramitarEmLote : «Falso» '
                                              WHEN  TramitarEmLote = 1 THEN ' TramitarEmLote : «Verdadeiro» '
                                    END 
                         + '| PrioridadeTramitacao : «' + RTRIM( ISNULL( CAST (PrioridadeTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoTramitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraSituacaoCadastral IS NULL THEN ' AlteraSituacaoCadastral : «Nulo» '
                                              WHEN  AlteraSituacaoCadastral = 0 THEN ' AlteraSituacaoCadastral : «Falso» '
                                              WHEN  AlteraSituacaoCadastral = 1 THEN ' AlteraSituacaoCadastral : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RetornaSituacaoCadastral IS NULL THEN ' RetornaSituacaoCadastral : «Nulo» '
                                              WHEN  RetornaSituacaoCadastral = 0 THEN ' RetornaSituacaoCadastral : «Falso» '
                                              WHEN  RetornaSituacaoCadastral = 1 THEN ' RetornaSituacaoCadastral : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FiltraPessoas IS NULL THEN ' FiltraPessoas : «Nulo» '
                                              WHEN  FiltraPessoas = 0 THEN ' FiltraPessoas : «Falso» '
                                              WHEN  FiltraPessoas = 1 THEN ' FiltraPessoas : «Verdadeiro» '
                                    END 
                         + '| CampoPDinamicoFiltro : «' + RTRIM( ISNULL( CAST (CampoPDinamicoFiltro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJRetorno : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacao : «' + RTRIM( ISNULL( CAST (IdDetalheSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraSituacaoFisc IS NULL THEN ' AlteraSituacaoFisc : «Nulo» '
                                              WHEN  AlteraSituacaoFisc = 0 THEN ' AlteraSituacaoFisc : «Falso» '
                                              WHEN  AlteraSituacaoFisc = 1 THEN ' AlteraSituacaoFisc : «Verdadeiro» '
                                    END 
                         + '| idSituacaoProcFis : «' + RTRIM( ISNULL( CAST (idSituacaoProcFis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ArquivaFiscalizacao IS NULL THEN ' ArquivaFiscalizacao : «Nulo» '
                                              WHEN  ArquivaFiscalizacao = 0 THEN ' ArquivaFiscalizacao : «Falso» '
                                              WHEN  ArquivaFiscalizacao = 1 THEN ' ArquivaFiscalizacao : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAndamento : «' + RTRIM( ISNULL( CAST (TipoAndamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExigeCPFCNPJ IS NULL THEN ' ExigeCPFCNPJ : «Nulo» '
                                              WHEN  ExigeCPFCNPJ = 0 THEN ' ExigeCPFCNPJ : «Falso» '
                                              WHEN  ExigeCPFCNPJ = 1 THEN ' ExigeCPFCNPJ : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoProcesso : «' + RTRIM( ISNULL( CAST (IdSituacaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaixaProcesso IS NULL THEN ' BaixaProcesso : «Nulo» '
                                              WHEN  BaixaProcesso = 0 THEN ' BaixaProcesso : «Falso» '
                                              WHEN  BaixaProcesso = 1 THEN ' BaixaProcesso : «Verdadeiro» '
                                    END 
                         + '| BaixaProcessoQuant : «' + RTRIM( ISNULL( CAST (BaixaProcessoQuant AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DataRefObrigatoria IS NULL THEN ' DataRefObrigatoria : «Nulo» '
                                              WHEN  DataRefObrigatoria = 0 THEN ' DataRefObrigatoria : «Falso» '
                                              WHEN  DataRefObrigatoria = 1 THEN ' DataRefObrigatoria : «Verdadeiro» '
                                    END 
                         + '| QtdDiasBloqueio : «' + RTRIM( ISNULL( CAST (QtdDiasBloqueio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PrazoBloqueioVariavel IS NULL THEN ' PrazoBloqueioVariavel : «Nulo» '
                                              WHEN  PrazoBloqueioVariavel = 0 THEN ' PrazoBloqueioVariavel : «Falso» '
                                              WHEN  PrazoBloqueioVariavel = 1 THEN ' PrazoBloqueioVariavel : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VoltarTramitacao IS NULL THEN ' VoltarTramitacao : «Nulo» '
                                              WHEN  VoltarTramitacao = 0 THEN ' VoltarTramitacao : «Falso» '
                                              WHEN  VoltarTramitacao = 1 THEN ' VoltarTramitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmitirBoleto IS NULL THEN ' EmitirBoleto : «Nulo» '
                                              WHEN  EmitirBoleto = 0 THEN ' EmitirBoleto : «Falso» '
                                              WHEN  EmitirBoleto = 1 THEN ' EmitirBoleto : «Verdadeiro» '
                                    END 
                         + '| IdFaseInfracao : «' + RTRIM( ISNULL( CAST (IdFaseInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoAndamento : «' + RTRIM( ISNULL( CAST (MotivoAndamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraMotivoAndamentoFis IS NULL THEN ' AlteraMotivoAndamentoFis : «Nulo» '
                                              WHEN  AlteraMotivoAndamentoFis = 0 THEN ' AlteraMotivoAndamentoFis : «Falso» '
                                              WHEN  AlteraMotivoAndamentoFis = 1 THEN ' AlteraMotivoAndamentoFis : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirCadastroPFPJ IS NULL THEN ' ExibirCadastroPFPJ : «Nulo» '
                                              WHEN  ExibirCadastroPFPJ = 0 THEN ' ExibirCadastroPFPJ : «Falso» '
                                              WHEN  ExibirCadastroPFPJ = 1 THEN ' ExibirCadastroPFPJ : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Fase : «' + RTRIM( ISNULL( CAST (Fase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodFase : «' + RTRIM( ISNULL( CAST (CodFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  REQUERPESSOA IS NULL THEN ' REQUERPESSOA : «Nulo» '
                                              WHEN  REQUERPESSOA = 0 THEN ' REQUERPESSOA : «Falso» '
                                              WHEN  REQUERPESSOA = 1 THEN ' REQUERPESSOA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DATAAUT IS NULL THEN ' DATAAUT : «Nulo» '
                                              WHEN  DATAAUT = 0 THEN ' DATAAUT : «Falso» '
                                              WHEN  DATAAUT = 1 THEN ' DATAAUT : «Verdadeiro» '
                                    END 
                         + '| PRZRESP : «' + RTRIM( ISNULL( CAST (PRZRESP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsarDataReferencia IS NULL THEN ' UsarDataReferencia : «Nulo» '
                                              WHEN  UsarDataReferencia = 0 THEN ' UsarDataReferencia : «Falso» '
                                              WHEN  UsarDataReferencia = 1 THEN ' UsarDataReferencia : «Verdadeiro» '
                                    END 
                         + '| IdModelo : «' + RTRIM( ISNULL( CAST (IdModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoPDinamico : «' + RTRIM( ISNULL( CAST (CampoPDinamico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FaseDistribuicao IS NULL THEN ' FaseDistribuicao : «Nulo» '
                                              WHEN  FaseDistribuicao = 0 THEN ' FaseDistribuicao : «Falso» '
                                              WHEN  FaseDistribuicao = 1 THEN ' FaseDistribuicao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FaseTermino IS NULL THEN ' FaseTermino : «Nulo» '
                                              WHEN  FaseTermino = 0 THEN ' FaseTermino : «Falso» '
                                              WHEN  FaseTermino = 1 THEN ' FaseTermino : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DesvincularRelator IS NULL THEN ' DesvincularRelator : «Nulo» '
                                              WHEN  DesvincularRelator = 0 THEN ' DesvincularRelator : «Falso» '
                                              WHEN  DesvincularRelator = 1 THEN ' DesvincularRelator : «Verdadeiro» '
                                    END 
                         + '| IdEtapaDestino : «' + RTRIM( ISNULL( CAST (IdEtapaDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoFase : «' + RTRIM( ISNULL( CAST (TipoFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VisualizarWeb IS NULL THEN ' VisualizarWeb : «Nulo» '
                                              WHEN  VisualizarWeb = 0 THEN ' VisualizarWeb : «Falso» '
                                              WHEN  VisualizarWeb = 1 THEN ' VisualizarWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DistribuicaoInstrutor IS NULL THEN ' DistribuicaoInstrutor : «Nulo» '
                                              WHEN  DistribuicaoInstrutor = 0 THEN ' DistribuicaoInstrutor : «Falso» '
                                              WHEN  DistribuicaoInstrutor = 1 THEN ' DistribuicaoInstrutor : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EnviaNotificacao IS NULL THEN ' EnviaNotificacao : «Nulo» '
                                              WHEN  EnviaNotificacao = 0 THEN ' EnviaNotificacao : «Falso» '
                                              WHEN  EnviaNotificacao = 1 THEN ' EnviaNotificacao : «Verdadeiro» '
                                    END 
                         + '| AssuntoEmail : «' + RTRIM( ISNULL( CAST (AssuntoEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatariosEmail : «' + RTRIM( ISNULL( CAST (DestinatariosEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirTelaCadastro IS NULL THEN ' ExibirTelaCadastro : «Nulo» '
                                              WHEN  ExibirTelaCadastro = 0 THEN ' ExibirTelaCadastro : «Falso» '
                                              WHEN  ExibirTelaCadastro = 1 THEN ' ExibirTelaCadastro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ConsiderarAnoDistribuicao IS NULL THEN ' ConsiderarAnoDistribuicao : «Nulo» '
                                              WHEN  ConsiderarAnoDistribuicao = 0 THEN ' ConsiderarAnoDistribuicao : «Falso» '
                                              WHEN  ConsiderarAnoDistribuicao = 1 THEN ' ConsiderarAnoDistribuicao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TramitarProcesso IS NULL THEN ' TramitarProcesso : «Nulo» '
                                              WHEN  TramitarProcesso = 0 THEN ' TramitarProcesso : «Falso» '
                                              WHEN  TramitarProcesso = 1 THEN ' TramitarProcesso : «Verdadeiro» '
                                    END 
                         + '| IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDestinatarioTramitacao : «' + RTRIM( ISNULL( CAST (IdDestinatarioTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TramitarEmLote IS NULL THEN ' TramitarEmLote : «Nulo» '
                                              WHEN  TramitarEmLote = 0 THEN ' TramitarEmLote : «Falso» '
                                              WHEN  TramitarEmLote = 1 THEN ' TramitarEmLote : «Verdadeiro» '
                                    END 
                         + '| PrioridadeTramitacao : «' + RTRIM( ISNULL( CAST (PrioridadeTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoTramitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraSituacaoCadastral IS NULL THEN ' AlteraSituacaoCadastral : «Nulo» '
                                              WHEN  AlteraSituacaoCadastral = 0 THEN ' AlteraSituacaoCadastral : «Falso» '
                                              WHEN  AlteraSituacaoCadastral = 1 THEN ' AlteraSituacaoCadastral : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RetornaSituacaoCadastral IS NULL THEN ' RetornaSituacaoCadastral : «Nulo» '
                                              WHEN  RetornaSituacaoCadastral = 0 THEN ' RetornaSituacaoCadastral : «Falso» '
                                              WHEN  RetornaSituacaoCadastral = 1 THEN ' RetornaSituacaoCadastral : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  FiltraPessoas IS NULL THEN ' FiltraPessoas : «Nulo» '
                                              WHEN  FiltraPessoas = 0 THEN ' FiltraPessoas : «Falso» '
                                              WHEN  FiltraPessoas = 1 THEN ' FiltraPessoas : «Verdadeiro» '
                                    END 
                         + '| CampoPDinamicoFiltro : «' + RTRIM( ISNULL( CAST (CampoPDinamicoFiltro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJRetorno : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacao : «' + RTRIM( ISNULL( CAST (IdDetalheSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraSituacaoFisc IS NULL THEN ' AlteraSituacaoFisc : «Nulo» '
                                              WHEN  AlteraSituacaoFisc = 0 THEN ' AlteraSituacaoFisc : «Falso» '
                                              WHEN  AlteraSituacaoFisc = 1 THEN ' AlteraSituacaoFisc : «Verdadeiro» '
                                    END 
                         + '| idSituacaoProcFis : «' + RTRIM( ISNULL( CAST (idSituacaoProcFis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ArquivaFiscalizacao IS NULL THEN ' ArquivaFiscalizacao : «Nulo» '
                                              WHEN  ArquivaFiscalizacao = 0 THEN ' ArquivaFiscalizacao : «Falso» '
                                              WHEN  ArquivaFiscalizacao = 1 THEN ' ArquivaFiscalizacao : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAndamento : «' + RTRIM( ISNULL( CAST (TipoAndamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExigeCPFCNPJ IS NULL THEN ' ExigeCPFCNPJ : «Nulo» '
                                              WHEN  ExigeCPFCNPJ = 0 THEN ' ExigeCPFCNPJ : «Falso» '
                                              WHEN  ExigeCPFCNPJ = 1 THEN ' ExigeCPFCNPJ : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoProcesso : «' + RTRIM( ISNULL( CAST (IdSituacaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaixaProcesso IS NULL THEN ' BaixaProcesso : «Nulo» '
                                              WHEN  BaixaProcesso = 0 THEN ' BaixaProcesso : «Falso» '
                                              WHEN  BaixaProcesso = 1 THEN ' BaixaProcesso : «Verdadeiro» '
                                    END 
                         + '| BaixaProcessoQuant : «' + RTRIM( ISNULL( CAST (BaixaProcessoQuant AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DataRefObrigatoria IS NULL THEN ' DataRefObrigatoria : «Nulo» '
                                              WHEN  DataRefObrigatoria = 0 THEN ' DataRefObrigatoria : «Falso» '
                                              WHEN  DataRefObrigatoria = 1 THEN ' DataRefObrigatoria : «Verdadeiro» '
                                    END 
                         + '| QtdDiasBloqueio : «' + RTRIM( ISNULL( CAST (QtdDiasBloqueio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PrazoBloqueioVariavel IS NULL THEN ' PrazoBloqueioVariavel : «Nulo» '
                                              WHEN  PrazoBloqueioVariavel = 0 THEN ' PrazoBloqueioVariavel : «Falso» '
                                              WHEN  PrazoBloqueioVariavel = 1 THEN ' PrazoBloqueioVariavel : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VoltarTramitacao IS NULL THEN ' VoltarTramitacao : «Nulo» '
                                              WHEN  VoltarTramitacao = 0 THEN ' VoltarTramitacao : «Falso» '
                                              WHEN  VoltarTramitacao = 1 THEN ' VoltarTramitacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmitirBoleto IS NULL THEN ' EmitirBoleto : «Nulo» '
                                              WHEN  EmitirBoleto = 0 THEN ' EmitirBoleto : «Falso» '
                                              WHEN  EmitirBoleto = 1 THEN ' EmitirBoleto : «Verdadeiro» '
                                    END 
                         + '| IdFaseInfracao : «' + RTRIM( ISNULL( CAST (IdFaseInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoAndamento : «' + RTRIM( ISNULL( CAST (MotivoAndamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraMotivoAndamentoFis IS NULL THEN ' AlteraMotivoAndamentoFis : «Nulo» '
                                              WHEN  AlteraMotivoAndamentoFis = 0 THEN ' AlteraMotivoAndamentoFis : «Falso» '
                                              WHEN  AlteraMotivoAndamentoFis = 1 THEN ' AlteraMotivoAndamentoFis : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirCadastroPFPJ IS NULL THEN ' ExibirCadastroPFPJ : «Nulo» '
                                              WHEN  ExibirCadastroPFPJ = 0 THEN ' ExibirCadastroPFPJ : «Falso» '
                                              WHEN  ExibirCadastroPFPJ = 1 THEN ' ExibirCadastroPFPJ : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
