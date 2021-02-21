CREATE TABLE [dbo].[ParametrosCarteirinhas] (
    [idParametroCarteirinha]     INT          IDENTITY (1, 1) NOT NULL,
    [DataCriacao]                DATETIME     NOT NULL,
    [MargemSuperior]             FLOAT (53)   NULL,
    [MargemEsquerda]             FLOAT (53)   NULL,
    [MargemInferior]             FLOAT (53)   NULL,
    [MargemDireita]              FLOAT (53)   NULL,
    [idUsuarioCriacao]           INT          NOT NULL,
    [InserirTextoNumero]         CHAR (1)     CONSTRAINT [DF_ParametrosCarteirinhas_InserirTextoNumero] DEFAULT ('N') NOT NULL,
    [TextoNumero]                VARCHAR (10) NULL,
    [Fonte]                      VARCHAR (20) NULL,
    [Tamanho]                    INT          CONSTRAINT [DF_ParametrosCarteirinhas_Tamanho] DEFAULT ((10)) NOT NULL,
    [Processo]                   BIT          CONSTRAINT [DF__Parametro__Proce__0CD0C267] DEFAULT ((0)) NOT NULL,
    [PrefixoInscricao]           VARCHAR (10) NULL,
    [JurisdicaoPadrao]           VARCHAR (30) NULL,
    [LocalExpedicaoPadrao]       VARCHAR (30) NULL,
    [CorFonte]                   VARCHAR (20) NULL,
    [EstiloFonte]                VARCHAR (42) NULL,
    [ImprimirSiglaEspecialidade] BIT          CONSTRAINT [DF__Parametro__Impri__44A0E595] DEFAULT ((0)) NULL,
    [PresidentePadrao]           VARCHAR (50) NULL,
    [CargoPadrao]                VARCHAR (50) NULL,
    [UtilizaRNE]                 BIT          NULL,
    [Observacoes]                BIT          NULL,
    [ControleVia]                BIT          NULL,
    [UtilizaDataValidade]        BIT          NULL,
    [TipoObservacaoCarteira]     TINYINT      NULL,
    [QtdCaracterNome]            INT          NULL,
    [QtdCaracterNomePai]         INT          NULL,
    [QtdCaracterNomeMae]         INT          NULL,
    [QtdCaracterNaturalidade]    INT          NULL,
    [QtdCaracterDiplomado]       INT          NULL,
    [TipoCarteira]               INT          NULL,
    [JurisdicaoSecundaria]       VARCHAR (30) NULL,
    [OrdenarListaImpressao]      BIT          DEFAULT ((1)) NOT NULL,
    [ImprimirEspecialidade]      BIT          DEFAULT ((0)) NOT NULL,
    [NumeracaoAutomatica]        BIT          DEFAULT ((0)) NOT NULL,
    [SequencialCarteira]         INT          NULL,
    [LimitarCadastro]            BIT          DEFAULT ((0)) NOT NULL,
    [ImprimirFoto]               BIT          CONSTRAINT [DEF_ImprimirFoto] DEFAULT ((0)) NOT NULL,
    [ImprimirDigital]            BIT          CONSTRAINT [DEF_ImprimirDigital] DEFAULT ((0)) NOT NULL,
    [ImprimirAssProfissional]    BIT          CONSTRAINT [DEF_ImprimirAssProfissional] DEFAULT ((0)) NOT NULL,
    [ImprimirAssPresidente]      BIT          CONSTRAINT [DEF_ImprimirAssPresidente] DEFAULT ((0)) NOT NULL,
    [OmiteNomePresidente]        BIT          CONSTRAINT [DF_ParametrosCarteirinhas_OmiteNomePresidente] DEFAULT ((0)) NOT NULL,
    [ImpCargoAbaixo]             BIT          CONSTRAINT [DF_ParametrosCarteirinhas_ImpCargoAbaixo] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_ParametrosCarteirinhas] PRIMARY KEY CLUSTERED ([idParametroCarteirinha] ASC),
    CONSTRAINT [FK_ParametrosCarteirinhas_Usuarios] FOREIGN KEY ([idUsuarioCriacao]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[ParametrosCarteirinhas] NOCHECK CONSTRAINT [FK_ParametrosCarteirinhas_Usuarios];


GO
CREATE TRIGGER [TrgLog_ParametrosCarteirinhas] ON [Implanta_CRPAM].[dbo].[ParametrosCarteirinhas] 
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
SET @TableName = 'ParametrosCarteirinhas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'idParametroCarteirinha : «' + RTRIM( ISNULL( CAST (idParametroCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idUsuarioCriacao : «' + RTRIM( ISNULL( CAST (idUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InserirTextoNumero : «' + RTRIM( ISNULL( CAST (InserirTextoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextoNumero : «' + RTRIM( ISNULL( CAST (TextoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Fonte : «' + RTRIM( ISNULL( CAST (Fonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Processo IS NULL THEN ' Processo : «Nulo» '
                                              WHEN  Processo = 0 THEN ' Processo : «Falso» '
                                              WHEN  Processo = 1 THEN ' Processo : «Verdadeiro» '
                                    END 
                         + '| PrefixoInscricao : «' + RTRIM( ISNULL( CAST (PrefixoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurisdicaoPadrao : «' + RTRIM( ISNULL( CAST (JurisdicaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalExpedicaoPadrao : «' + RTRIM( ISNULL( CAST (LocalExpedicaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorFonte : «' + RTRIM( ISNULL( CAST (CorFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstiloFonte : «' + RTRIM( ISNULL( CAST (EstiloFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimirSiglaEspecialidade IS NULL THEN ' ImprimirSiglaEspecialidade : «Nulo» '
                                              WHEN  ImprimirSiglaEspecialidade = 0 THEN ' ImprimirSiglaEspecialidade : «Falso» '
                                              WHEN  ImprimirSiglaEspecialidade = 1 THEN ' ImprimirSiglaEspecialidade : «Verdadeiro» '
                                    END 
                         + '| PresidentePadrao : «' + RTRIM( ISNULL( CAST (PresidentePadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoPadrao : «' + RTRIM( ISNULL( CAST (CargoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRNE IS NULL THEN ' UtilizaRNE : «Nulo» '
                                              WHEN  UtilizaRNE = 0 THEN ' UtilizaRNE : «Falso» '
                                              WHEN  UtilizaRNE = 1 THEN ' UtilizaRNE : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Observacoes IS NULL THEN ' Observacoes : «Nulo» '
                                              WHEN  Observacoes = 0 THEN ' Observacoes : «Falso» '
                                              WHEN  Observacoes = 1 THEN ' Observacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControleVia IS NULL THEN ' ControleVia : «Nulo» '
                                              WHEN  ControleVia = 0 THEN ' ControleVia : «Falso» '
                                              WHEN  ControleVia = 1 THEN ' ControleVia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaDataValidade IS NULL THEN ' UtilizaDataValidade : «Nulo» '
                                              WHEN  UtilizaDataValidade = 0 THEN ' UtilizaDataValidade : «Falso» '
                                              WHEN  UtilizaDataValidade = 1 THEN ' UtilizaDataValidade : «Verdadeiro» '
                                    END 
                         + '| TipoObservacaoCarteira : «' + RTRIM( ISNULL( CAST (TipoObservacaoCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNome : «' + RTRIM( ISNULL( CAST (QtdCaracterNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNomePai : «' + RTRIM( ISNULL( CAST (QtdCaracterNomePai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNomeMae : «' + RTRIM( ISNULL( CAST (QtdCaracterNomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNaturalidade : «' + RTRIM( ISNULL( CAST (QtdCaracterNaturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterDiplomado : «' + RTRIM( ISNULL( CAST (QtdCaracterDiplomado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCarteira : «' + RTRIM( ISNULL( CAST (TipoCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurisdicaoSecundaria : «' + RTRIM( ISNULL( CAST (JurisdicaoSecundaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OrdenarListaImpressao IS NULL THEN ' OrdenarListaImpressao : «Nulo» '
                                              WHEN  OrdenarListaImpressao = 0 THEN ' OrdenarListaImpressao : «Falso» '
                                              WHEN  OrdenarListaImpressao = 1 THEN ' OrdenarListaImpressao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirEspecialidade IS NULL THEN ' ImprimirEspecialidade : «Nulo» '
                                              WHEN  ImprimirEspecialidade = 0 THEN ' ImprimirEspecialidade : «Falso» '
                                              WHEN  ImprimirEspecialidade = 1 THEN ' ImprimirEspecialidade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NumeracaoAutomatica IS NULL THEN ' NumeracaoAutomatica : «Nulo» '
                                              WHEN  NumeracaoAutomatica = 0 THEN ' NumeracaoAutomatica : «Falso» '
                                              WHEN  NumeracaoAutomatica = 1 THEN ' NumeracaoAutomatica : «Verdadeiro» '
                                    END 
                         + '| SequencialCarteira : «' + RTRIM( ISNULL( CAST (SequencialCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LimitarCadastro IS NULL THEN ' LimitarCadastro : «Nulo» '
                                              WHEN  LimitarCadastro = 0 THEN ' LimitarCadastro : «Falso» '
                                              WHEN  LimitarCadastro = 1 THEN ' LimitarCadastro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirFoto IS NULL THEN ' ImprimirFoto : «Nulo» '
                                              WHEN  ImprimirFoto = 0 THEN ' ImprimirFoto : «Falso» '
                                              WHEN  ImprimirFoto = 1 THEN ' ImprimirFoto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirDigital IS NULL THEN ' ImprimirDigital : «Nulo» '
                                              WHEN  ImprimirDigital = 0 THEN ' ImprimirDigital : «Falso» '
                                              WHEN  ImprimirDigital = 1 THEN ' ImprimirDigital : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirAssProfissional IS NULL THEN ' ImprimirAssProfissional : «Nulo» '
                                              WHEN  ImprimirAssProfissional = 0 THEN ' ImprimirAssProfissional : «Falso» '
                                              WHEN  ImprimirAssProfissional = 1 THEN ' ImprimirAssProfissional : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirAssPresidente IS NULL THEN ' ImprimirAssPresidente : «Nulo» '
                                              WHEN  ImprimirAssPresidente = 0 THEN ' ImprimirAssPresidente : «Falso» '
                                              WHEN  ImprimirAssPresidente = 1 THEN ' ImprimirAssPresidente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OmiteNomePresidente IS NULL THEN ' OmiteNomePresidente : «Nulo» '
                                              WHEN  OmiteNomePresidente = 0 THEN ' OmiteNomePresidente : «Falso» '
                                              WHEN  OmiteNomePresidente = 1 THEN ' OmiteNomePresidente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpCargoAbaixo IS NULL THEN ' ImpCargoAbaixo : «Nulo» '
                                              WHEN  ImpCargoAbaixo = 0 THEN ' ImpCargoAbaixo : «Falso» '
                                              WHEN  ImpCargoAbaixo = 1 THEN ' ImpCargoAbaixo : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'idParametroCarteirinha : «' + RTRIM( ISNULL( CAST (idParametroCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idUsuarioCriacao : «' + RTRIM( ISNULL( CAST (idUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InserirTextoNumero : «' + RTRIM( ISNULL( CAST (InserirTextoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextoNumero : «' + RTRIM( ISNULL( CAST (TextoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Fonte : «' + RTRIM( ISNULL( CAST (Fonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Processo IS NULL THEN ' Processo : «Nulo» '
                                              WHEN  Processo = 0 THEN ' Processo : «Falso» '
                                              WHEN  Processo = 1 THEN ' Processo : «Verdadeiro» '
                                    END 
                         + '| PrefixoInscricao : «' + RTRIM( ISNULL( CAST (PrefixoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurisdicaoPadrao : «' + RTRIM( ISNULL( CAST (JurisdicaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalExpedicaoPadrao : «' + RTRIM( ISNULL( CAST (LocalExpedicaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorFonte : «' + RTRIM( ISNULL( CAST (CorFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstiloFonte : «' + RTRIM( ISNULL( CAST (EstiloFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimirSiglaEspecialidade IS NULL THEN ' ImprimirSiglaEspecialidade : «Nulo» '
                                              WHEN  ImprimirSiglaEspecialidade = 0 THEN ' ImprimirSiglaEspecialidade : «Falso» '
                                              WHEN  ImprimirSiglaEspecialidade = 1 THEN ' ImprimirSiglaEspecialidade : «Verdadeiro» '
                                    END 
                         + '| PresidentePadrao : «' + RTRIM( ISNULL( CAST (PresidentePadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoPadrao : «' + RTRIM( ISNULL( CAST (CargoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRNE IS NULL THEN ' UtilizaRNE : «Nulo» '
                                              WHEN  UtilizaRNE = 0 THEN ' UtilizaRNE : «Falso» '
                                              WHEN  UtilizaRNE = 1 THEN ' UtilizaRNE : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Observacoes IS NULL THEN ' Observacoes : «Nulo» '
                                              WHEN  Observacoes = 0 THEN ' Observacoes : «Falso» '
                                              WHEN  Observacoes = 1 THEN ' Observacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControleVia IS NULL THEN ' ControleVia : «Nulo» '
                                              WHEN  ControleVia = 0 THEN ' ControleVia : «Falso» '
                                              WHEN  ControleVia = 1 THEN ' ControleVia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaDataValidade IS NULL THEN ' UtilizaDataValidade : «Nulo» '
                                              WHEN  UtilizaDataValidade = 0 THEN ' UtilizaDataValidade : «Falso» '
                                              WHEN  UtilizaDataValidade = 1 THEN ' UtilizaDataValidade : «Verdadeiro» '
                                    END 
                         + '| TipoObservacaoCarteira : «' + RTRIM( ISNULL( CAST (TipoObservacaoCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNome : «' + RTRIM( ISNULL( CAST (QtdCaracterNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNomePai : «' + RTRIM( ISNULL( CAST (QtdCaracterNomePai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNomeMae : «' + RTRIM( ISNULL( CAST (QtdCaracterNomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNaturalidade : «' + RTRIM( ISNULL( CAST (QtdCaracterNaturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterDiplomado : «' + RTRIM( ISNULL( CAST (QtdCaracterDiplomado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCarteira : «' + RTRIM( ISNULL( CAST (TipoCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurisdicaoSecundaria : «' + RTRIM( ISNULL( CAST (JurisdicaoSecundaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OrdenarListaImpressao IS NULL THEN ' OrdenarListaImpressao : «Nulo» '
                                              WHEN  OrdenarListaImpressao = 0 THEN ' OrdenarListaImpressao : «Falso» '
                                              WHEN  OrdenarListaImpressao = 1 THEN ' OrdenarListaImpressao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirEspecialidade IS NULL THEN ' ImprimirEspecialidade : «Nulo» '
                                              WHEN  ImprimirEspecialidade = 0 THEN ' ImprimirEspecialidade : «Falso» '
                                              WHEN  ImprimirEspecialidade = 1 THEN ' ImprimirEspecialidade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NumeracaoAutomatica IS NULL THEN ' NumeracaoAutomatica : «Nulo» '
                                              WHEN  NumeracaoAutomatica = 0 THEN ' NumeracaoAutomatica : «Falso» '
                                              WHEN  NumeracaoAutomatica = 1 THEN ' NumeracaoAutomatica : «Verdadeiro» '
                                    END 
                         + '| SequencialCarteira : «' + RTRIM( ISNULL( CAST (SequencialCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LimitarCadastro IS NULL THEN ' LimitarCadastro : «Nulo» '
                                              WHEN  LimitarCadastro = 0 THEN ' LimitarCadastro : «Falso» '
                                              WHEN  LimitarCadastro = 1 THEN ' LimitarCadastro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirFoto IS NULL THEN ' ImprimirFoto : «Nulo» '
                                              WHEN  ImprimirFoto = 0 THEN ' ImprimirFoto : «Falso» '
                                              WHEN  ImprimirFoto = 1 THEN ' ImprimirFoto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirDigital IS NULL THEN ' ImprimirDigital : «Nulo» '
                                              WHEN  ImprimirDigital = 0 THEN ' ImprimirDigital : «Falso» '
                                              WHEN  ImprimirDigital = 1 THEN ' ImprimirDigital : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirAssProfissional IS NULL THEN ' ImprimirAssProfissional : «Nulo» '
                                              WHEN  ImprimirAssProfissional = 0 THEN ' ImprimirAssProfissional : «Falso» '
                                              WHEN  ImprimirAssProfissional = 1 THEN ' ImprimirAssProfissional : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirAssPresidente IS NULL THEN ' ImprimirAssPresidente : «Nulo» '
                                              WHEN  ImprimirAssPresidente = 0 THEN ' ImprimirAssPresidente : «Falso» '
                                              WHEN  ImprimirAssPresidente = 1 THEN ' ImprimirAssPresidente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OmiteNomePresidente IS NULL THEN ' OmiteNomePresidente : «Nulo» '
                                              WHEN  OmiteNomePresidente = 0 THEN ' OmiteNomePresidente : «Falso» '
                                              WHEN  OmiteNomePresidente = 1 THEN ' OmiteNomePresidente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpCargoAbaixo IS NULL THEN ' ImpCargoAbaixo : «Nulo» '
                                              WHEN  ImpCargoAbaixo = 0 THEN ' ImpCargoAbaixo : «Falso» '
                                              WHEN  ImpCargoAbaixo = 1 THEN ' ImpCargoAbaixo : «Verdadeiro» '
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
		SELECT @Conteudo = 'idParametroCarteirinha : «' + RTRIM( ISNULL( CAST (idParametroCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idUsuarioCriacao : «' + RTRIM( ISNULL( CAST (idUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InserirTextoNumero : «' + RTRIM( ISNULL( CAST (InserirTextoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextoNumero : «' + RTRIM( ISNULL( CAST (TextoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Fonte : «' + RTRIM( ISNULL( CAST (Fonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Processo IS NULL THEN ' Processo : «Nulo» '
                                              WHEN  Processo = 0 THEN ' Processo : «Falso» '
                                              WHEN  Processo = 1 THEN ' Processo : «Verdadeiro» '
                                    END 
                         + '| PrefixoInscricao : «' + RTRIM( ISNULL( CAST (PrefixoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurisdicaoPadrao : «' + RTRIM( ISNULL( CAST (JurisdicaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalExpedicaoPadrao : «' + RTRIM( ISNULL( CAST (LocalExpedicaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorFonte : «' + RTRIM( ISNULL( CAST (CorFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstiloFonte : «' + RTRIM( ISNULL( CAST (EstiloFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimirSiglaEspecialidade IS NULL THEN ' ImprimirSiglaEspecialidade : «Nulo» '
                                              WHEN  ImprimirSiglaEspecialidade = 0 THEN ' ImprimirSiglaEspecialidade : «Falso» '
                                              WHEN  ImprimirSiglaEspecialidade = 1 THEN ' ImprimirSiglaEspecialidade : «Verdadeiro» '
                                    END 
                         + '| PresidentePadrao : «' + RTRIM( ISNULL( CAST (PresidentePadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoPadrao : «' + RTRIM( ISNULL( CAST (CargoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRNE IS NULL THEN ' UtilizaRNE : «Nulo» '
                                              WHEN  UtilizaRNE = 0 THEN ' UtilizaRNE : «Falso» '
                                              WHEN  UtilizaRNE = 1 THEN ' UtilizaRNE : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Observacoes IS NULL THEN ' Observacoes : «Nulo» '
                                              WHEN  Observacoes = 0 THEN ' Observacoes : «Falso» '
                                              WHEN  Observacoes = 1 THEN ' Observacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControleVia IS NULL THEN ' ControleVia : «Nulo» '
                                              WHEN  ControleVia = 0 THEN ' ControleVia : «Falso» '
                                              WHEN  ControleVia = 1 THEN ' ControleVia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaDataValidade IS NULL THEN ' UtilizaDataValidade : «Nulo» '
                                              WHEN  UtilizaDataValidade = 0 THEN ' UtilizaDataValidade : «Falso» '
                                              WHEN  UtilizaDataValidade = 1 THEN ' UtilizaDataValidade : «Verdadeiro» '
                                    END 
                         + '| TipoObservacaoCarteira : «' + RTRIM( ISNULL( CAST (TipoObservacaoCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNome : «' + RTRIM( ISNULL( CAST (QtdCaracterNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNomePai : «' + RTRIM( ISNULL( CAST (QtdCaracterNomePai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNomeMae : «' + RTRIM( ISNULL( CAST (QtdCaracterNomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNaturalidade : «' + RTRIM( ISNULL( CAST (QtdCaracterNaturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterDiplomado : «' + RTRIM( ISNULL( CAST (QtdCaracterDiplomado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCarteira : «' + RTRIM( ISNULL( CAST (TipoCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurisdicaoSecundaria : «' + RTRIM( ISNULL( CAST (JurisdicaoSecundaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OrdenarListaImpressao IS NULL THEN ' OrdenarListaImpressao : «Nulo» '
                                              WHEN  OrdenarListaImpressao = 0 THEN ' OrdenarListaImpressao : «Falso» '
                                              WHEN  OrdenarListaImpressao = 1 THEN ' OrdenarListaImpressao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirEspecialidade IS NULL THEN ' ImprimirEspecialidade : «Nulo» '
                                              WHEN  ImprimirEspecialidade = 0 THEN ' ImprimirEspecialidade : «Falso» '
                                              WHEN  ImprimirEspecialidade = 1 THEN ' ImprimirEspecialidade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NumeracaoAutomatica IS NULL THEN ' NumeracaoAutomatica : «Nulo» '
                                              WHEN  NumeracaoAutomatica = 0 THEN ' NumeracaoAutomatica : «Falso» '
                                              WHEN  NumeracaoAutomatica = 1 THEN ' NumeracaoAutomatica : «Verdadeiro» '
                                    END 
                         + '| SequencialCarteira : «' + RTRIM( ISNULL( CAST (SequencialCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LimitarCadastro IS NULL THEN ' LimitarCadastro : «Nulo» '
                                              WHEN  LimitarCadastro = 0 THEN ' LimitarCadastro : «Falso» '
                                              WHEN  LimitarCadastro = 1 THEN ' LimitarCadastro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirFoto IS NULL THEN ' ImprimirFoto : «Nulo» '
                                              WHEN  ImprimirFoto = 0 THEN ' ImprimirFoto : «Falso» '
                                              WHEN  ImprimirFoto = 1 THEN ' ImprimirFoto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirDigital IS NULL THEN ' ImprimirDigital : «Nulo» '
                                              WHEN  ImprimirDigital = 0 THEN ' ImprimirDigital : «Falso» '
                                              WHEN  ImprimirDigital = 1 THEN ' ImprimirDigital : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirAssProfissional IS NULL THEN ' ImprimirAssProfissional : «Nulo» '
                                              WHEN  ImprimirAssProfissional = 0 THEN ' ImprimirAssProfissional : «Falso» '
                                              WHEN  ImprimirAssProfissional = 1 THEN ' ImprimirAssProfissional : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirAssPresidente IS NULL THEN ' ImprimirAssPresidente : «Nulo» '
                                              WHEN  ImprimirAssPresidente = 0 THEN ' ImprimirAssPresidente : «Falso» '
                                              WHEN  ImprimirAssPresidente = 1 THEN ' ImprimirAssPresidente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OmiteNomePresidente IS NULL THEN ' OmiteNomePresidente : «Nulo» '
                                              WHEN  OmiteNomePresidente = 0 THEN ' OmiteNomePresidente : «Falso» '
                                              WHEN  OmiteNomePresidente = 1 THEN ' OmiteNomePresidente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpCargoAbaixo IS NULL THEN ' ImpCargoAbaixo : «Nulo» '
                                              WHEN  ImpCargoAbaixo = 0 THEN ' ImpCargoAbaixo : «Falso» '
                                              WHEN  ImpCargoAbaixo = 1 THEN ' ImpCargoAbaixo : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'idParametroCarteirinha : «' + RTRIM( ISNULL( CAST (idParametroCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idUsuarioCriacao : «' + RTRIM( ISNULL( CAST (idUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InserirTextoNumero : «' + RTRIM( ISNULL( CAST (InserirTextoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TextoNumero : «' + RTRIM( ISNULL( CAST (TextoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Fonte : «' + RTRIM( ISNULL( CAST (Fonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Processo IS NULL THEN ' Processo : «Nulo» '
                                              WHEN  Processo = 0 THEN ' Processo : «Falso» '
                                              WHEN  Processo = 1 THEN ' Processo : «Verdadeiro» '
                                    END 
                         + '| PrefixoInscricao : «' + RTRIM( ISNULL( CAST (PrefixoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurisdicaoPadrao : «' + RTRIM( ISNULL( CAST (JurisdicaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalExpedicaoPadrao : «' + RTRIM( ISNULL( CAST (LocalExpedicaoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorFonte : «' + RTRIM( ISNULL( CAST (CorFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstiloFonte : «' + RTRIM( ISNULL( CAST (EstiloFonte AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimirSiglaEspecialidade IS NULL THEN ' ImprimirSiglaEspecialidade : «Nulo» '
                                              WHEN  ImprimirSiglaEspecialidade = 0 THEN ' ImprimirSiglaEspecialidade : «Falso» '
                                              WHEN  ImprimirSiglaEspecialidade = 1 THEN ' ImprimirSiglaEspecialidade : «Verdadeiro» '
                                    END 
                         + '| PresidentePadrao : «' + RTRIM( ISNULL( CAST (PresidentePadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoPadrao : «' + RTRIM( ISNULL( CAST (CargoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaRNE IS NULL THEN ' UtilizaRNE : «Nulo» '
                                              WHEN  UtilizaRNE = 0 THEN ' UtilizaRNE : «Falso» '
                                              WHEN  UtilizaRNE = 1 THEN ' UtilizaRNE : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Observacoes IS NULL THEN ' Observacoes : «Nulo» '
                                              WHEN  Observacoes = 0 THEN ' Observacoes : «Falso» '
                                              WHEN  Observacoes = 1 THEN ' Observacoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControleVia IS NULL THEN ' ControleVia : «Nulo» '
                                              WHEN  ControleVia = 0 THEN ' ControleVia : «Falso» '
                                              WHEN  ControleVia = 1 THEN ' ControleVia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UtilizaDataValidade IS NULL THEN ' UtilizaDataValidade : «Nulo» '
                                              WHEN  UtilizaDataValidade = 0 THEN ' UtilizaDataValidade : «Falso» '
                                              WHEN  UtilizaDataValidade = 1 THEN ' UtilizaDataValidade : «Verdadeiro» '
                                    END 
                         + '| TipoObservacaoCarteira : «' + RTRIM( ISNULL( CAST (TipoObservacaoCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNome : «' + RTRIM( ISNULL( CAST (QtdCaracterNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNomePai : «' + RTRIM( ISNULL( CAST (QtdCaracterNomePai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNomeMae : «' + RTRIM( ISNULL( CAST (QtdCaracterNomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterNaturalidade : «' + RTRIM( ISNULL( CAST (QtdCaracterNaturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdCaracterDiplomado : «' + RTRIM( ISNULL( CAST (QtdCaracterDiplomado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCarteira : «' + RTRIM( ISNULL( CAST (TipoCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurisdicaoSecundaria : «' + RTRIM( ISNULL( CAST (JurisdicaoSecundaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  OrdenarListaImpressao IS NULL THEN ' OrdenarListaImpressao : «Nulo» '
                                              WHEN  OrdenarListaImpressao = 0 THEN ' OrdenarListaImpressao : «Falso» '
                                              WHEN  OrdenarListaImpressao = 1 THEN ' OrdenarListaImpressao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirEspecialidade IS NULL THEN ' ImprimirEspecialidade : «Nulo» '
                                              WHEN  ImprimirEspecialidade = 0 THEN ' ImprimirEspecialidade : «Falso» '
                                              WHEN  ImprimirEspecialidade = 1 THEN ' ImprimirEspecialidade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NumeracaoAutomatica IS NULL THEN ' NumeracaoAutomatica : «Nulo» '
                                              WHEN  NumeracaoAutomatica = 0 THEN ' NumeracaoAutomatica : «Falso» '
                                              WHEN  NumeracaoAutomatica = 1 THEN ' NumeracaoAutomatica : «Verdadeiro» '
                                    END 
                         + '| SequencialCarteira : «' + RTRIM( ISNULL( CAST (SequencialCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LimitarCadastro IS NULL THEN ' LimitarCadastro : «Nulo» '
                                              WHEN  LimitarCadastro = 0 THEN ' LimitarCadastro : «Falso» '
                                              WHEN  LimitarCadastro = 1 THEN ' LimitarCadastro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirFoto IS NULL THEN ' ImprimirFoto : «Nulo» '
                                              WHEN  ImprimirFoto = 0 THEN ' ImprimirFoto : «Falso» '
                                              WHEN  ImprimirFoto = 1 THEN ' ImprimirFoto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirDigital IS NULL THEN ' ImprimirDigital : «Nulo» '
                                              WHEN  ImprimirDigital = 0 THEN ' ImprimirDigital : «Falso» '
                                              WHEN  ImprimirDigital = 1 THEN ' ImprimirDigital : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirAssProfissional IS NULL THEN ' ImprimirAssProfissional : «Nulo» '
                                              WHEN  ImprimirAssProfissional = 0 THEN ' ImprimirAssProfissional : «Falso» '
                                              WHEN  ImprimirAssProfissional = 1 THEN ' ImprimirAssProfissional : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimirAssPresidente IS NULL THEN ' ImprimirAssPresidente : «Nulo» '
                                              WHEN  ImprimirAssPresidente = 0 THEN ' ImprimirAssPresidente : «Falso» '
                                              WHEN  ImprimirAssPresidente = 1 THEN ' ImprimirAssPresidente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OmiteNomePresidente IS NULL THEN ' OmiteNomePresidente : «Nulo» '
                                              WHEN  OmiteNomePresidente = 0 THEN ' OmiteNomePresidente : «Falso» '
                                              WHEN  OmiteNomePresidente = 1 THEN ' OmiteNomePresidente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpCargoAbaixo IS NULL THEN ' ImpCargoAbaixo : «Nulo» '
                                              WHEN  ImpCargoAbaixo = 0 THEN ' ImpCargoAbaixo : «Falso» '
                                              WHEN  ImpCargoAbaixo = 1 THEN ' ImpCargoAbaixo : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
