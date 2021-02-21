CREATE TABLE [dbo].[Convenios] (
    [IdConvenio]                      INT              IDENTITY (1, 1) NOT NULL,
    [CodConvenio]                     VARCHAR (7)      NULL,
    [DataConvenio]                    DATETIME         NULL,
    [SituacaoConvenio]                VARCHAR (1)      CONSTRAINT [DF_Convenios_SituacaoConvenio] DEFAULT ((0)) NULL,
    [CodigoCarteiraCobranca]          VARCHAR (6)      NULL,
    [TipoConvenio]                    VARCHAR (2)      NULL,
    [Variacao]                        VARCHAR (3)      NULL,
    [Sequencia]                       INT              NULL,
    [Sequencial]                      INT              NULL,
    [IdContaCorrente]                 INT              NOT NULL,
    [PercentualRepasse]               FLOAT (53)       NULL,
    [IdMsgInstrCobrancaPadrao]        INT              NULL,
    [IdMsgInstrCobrancaPadraoArquivo] INT              NULL,
    [IdMsgObsPadrao_BB]               INT              NULL,
    [IdMsgObsPadrao_BBArquivo]        INT              NULL,
    [ValorTarifa]                     MONEY            NULL,
    [RemessaEmProducao]               BIT              CONSTRAINT [DF_ConveniosRemessaEmProducao] DEFAULT ((0)) NULL,
    [NomeConvenio]                    VARCHAR (30)     NULL,
    [codBaixaDev]                     INT              NULL,
    [numDiasBaixaDev]                 INT              NULL,
    [IdMsgVersoBoleto]                INT              NULL,
    [VersaoAplicativoCaixa]           BIT              CONSTRAINT [DF_Convenios_VersaoAplicativoCaixa] DEFAULT ((1)) NOT NULL,
    [TipoServico]                     VARCHAR (40)     CONSTRAINT [DF_Convenios_TipoServico] DEFAULT ('02-Cobrança Sem Registro / Serviços') NOT NULL,
    [IndConferenciaSeq_BB]            BIT              CONSTRAINT [DF_Convenios_IndConferenciaSeq_BB] DEFAULT ((0)) NOT NULL,
    [SequencialRemessa]               INT              NULL,
    [CobrancaRegistrada]              BIT              CONSTRAINT [DF_Convenios_CobrancaRegistrada] DEFAULT ((1)) NOT NULL,
    [IdConfigBancoParaEmissao]        UNIQUEIDENTIFIER CONSTRAINT [DF_ConveniosConfigBancoParaEmissao] DEFAULT (newid()) NULL,
    [NumeroComercioEletronico]        INT              NULL,
    CONSTRAINT [PK_Convenios] PRIMARY KEY CLUSTERED ([IdConvenio] ASC),
    CONSTRAINT [FK_Convenios_ContasCorrentes] FOREIGN KEY ([IdContaCorrente]) REFERENCES [dbo].[ContasCorrentes] ([IdContaCorrente]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Convenios_MsgBoletosBancarios] FOREIGN KEY ([IdMsgInstrCobrancaPadrao]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Convenios_MsgBoletosBancarios1] FOREIGN KEY ([IdMsgInstrCobrancaPadraoArquivo]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Convenios_MsgBoletosBancarios2] FOREIGN KEY ([IdMsgObsPadrao_BB]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Convenios_MsgBoletosBancarios3] FOREIGN KEY ([IdMsgObsPadrao_BBArquivo]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_Convenios] ON [Implanta_CRPAM].[dbo].[Convenios] 
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
SET @TableName = 'Convenios'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenio : «' + RTRIM( ISNULL( CAST (CodConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConvenio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConvenio, 113 ),'Nulo'))+'» '
                         + '| SituacaoConvenio : «' + RTRIM( ISNULL( CAST (SituacaoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCarteiraCobranca : «' + RTRIM( ISNULL( CAST (CodigoCarteiraCobranca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoConvenio : «' + RTRIM( ISNULL( CAST (TipoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Variacao : «' + RTRIM( ISNULL( CAST (Variacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencial : «' + RTRIM( ISNULL( CAST (Sequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadraoArquivo : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadraoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BB : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BBArquivo : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BBArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RemessaEmProducao IS NULL THEN ' RemessaEmProducao : «Nulo» '
                                              WHEN  RemessaEmProducao = 0 THEN ' RemessaEmProducao : «Falso» '
                                              WHEN  RemessaEmProducao = 1 THEN ' RemessaEmProducao : «Verdadeiro» '
                                    END 
                         + '| NomeConvenio : «' + RTRIM( ISNULL( CAST (NomeConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| codBaixaDev : «' + RTRIM( ISNULL( CAST (codBaixaDev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| numDiasBaixaDev : «' + RTRIM( ISNULL( CAST (numDiasBaixaDev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgVersoBoleto : «' + RTRIM( ISNULL( CAST (IdMsgVersoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VersaoAplicativoCaixa IS NULL THEN ' VersaoAplicativoCaixa : «Nulo» '
                                              WHEN  VersaoAplicativoCaixa = 0 THEN ' VersaoAplicativoCaixa : «Falso» '
                                              WHEN  VersaoAplicativoCaixa = 1 THEN ' VersaoAplicativoCaixa : «Verdadeiro» '
                                    END 
                         + '| TipoServico : «' + RTRIM( ISNULL( CAST (TipoServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndConferenciaSeq_BB IS NULL THEN ' IndConferenciaSeq_BB : «Nulo» '
                                              WHEN  IndConferenciaSeq_BB = 0 THEN ' IndConferenciaSeq_BB : «Falso» '
                                              WHEN  IndConferenciaSeq_BB = 1 THEN ' IndConferenciaSeq_BB : «Verdadeiro» '
                                    END 
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CobrancaRegistrada IS NULL THEN ' CobrancaRegistrada : «Nulo» '
                                              WHEN  CobrancaRegistrada = 0 THEN ' CobrancaRegistrada : «Falso» '
                                              WHEN  CobrancaRegistrada = 1 THEN ' CobrancaRegistrada : «Verdadeiro» '
                                    END 
                         + '| NumeroComercioEletronico : «' + RTRIM( ISNULL( CAST (NumeroComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenio : «' + RTRIM( ISNULL( CAST (CodConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConvenio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConvenio, 113 ),'Nulo'))+'» '
                         + '| SituacaoConvenio : «' + RTRIM( ISNULL( CAST (SituacaoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCarteiraCobranca : «' + RTRIM( ISNULL( CAST (CodigoCarteiraCobranca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoConvenio : «' + RTRIM( ISNULL( CAST (TipoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Variacao : «' + RTRIM( ISNULL( CAST (Variacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencial : «' + RTRIM( ISNULL( CAST (Sequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadraoArquivo : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadraoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BB : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BBArquivo : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BBArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RemessaEmProducao IS NULL THEN ' RemessaEmProducao : «Nulo» '
                                              WHEN  RemessaEmProducao = 0 THEN ' RemessaEmProducao : «Falso» '
                                              WHEN  RemessaEmProducao = 1 THEN ' RemessaEmProducao : «Verdadeiro» '
                                    END 
                         + '| NomeConvenio : «' + RTRIM( ISNULL( CAST (NomeConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| codBaixaDev : «' + RTRIM( ISNULL( CAST (codBaixaDev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| numDiasBaixaDev : «' + RTRIM( ISNULL( CAST (numDiasBaixaDev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgVersoBoleto : «' + RTRIM( ISNULL( CAST (IdMsgVersoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VersaoAplicativoCaixa IS NULL THEN ' VersaoAplicativoCaixa : «Nulo» '
                                              WHEN  VersaoAplicativoCaixa = 0 THEN ' VersaoAplicativoCaixa : «Falso» '
                                              WHEN  VersaoAplicativoCaixa = 1 THEN ' VersaoAplicativoCaixa : «Verdadeiro» '
                                    END 
                         + '| TipoServico : «' + RTRIM( ISNULL( CAST (TipoServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndConferenciaSeq_BB IS NULL THEN ' IndConferenciaSeq_BB : «Nulo» '
                                              WHEN  IndConferenciaSeq_BB = 0 THEN ' IndConferenciaSeq_BB : «Falso» '
                                              WHEN  IndConferenciaSeq_BB = 1 THEN ' IndConferenciaSeq_BB : «Verdadeiro» '
                                    END 
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CobrancaRegistrada IS NULL THEN ' CobrancaRegistrada : «Nulo» '
                                              WHEN  CobrancaRegistrada = 0 THEN ' CobrancaRegistrada : «Falso» '
                                              WHEN  CobrancaRegistrada = 1 THEN ' CobrancaRegistrada : «Verdadeiro» '
                                    END 
                         + '| NumeroComercioEletronico : «' + RTRIM( ISNULL( CAST (NumeroComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenio : «' + RTRIM( ISNULL( CAST (CodConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConvenio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConvenio, 113 ),'Nulo'))+'» '
                         + '| SituacaoConvenio : «' + RTRIM( ISNULL( CAST (SituacaoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCarteiraCobranca : «' + RTRIM( ISNULL( CAST (CodigoCarteiraCobranca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoConvenio : «' + RTRIM( ISNULL( CAST (TipoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Variacao : «' + RTRIM( ISNULL( CAST (Variacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencial : «' + RTRIM( ISNULL( CAST (Sequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadraoArquivo : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadraoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BB : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BBArquivo : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BBArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RemessaEmProducao IS NULL THEN ' RemessaEmProducao : «Nulo» '
                                              WHEN  RemessaEmProducao = 0 THEN ' RemessaEmProducao : «Falso» '
                                              WHEN  RemessaEmProducao = 1 THEN ' RemessaEmProducao : «Verdadeiro» '
                                    END 
                         + '| NomeConvenio : «' + RTRIM( ISNULL( CAST (NomeConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| codBaixaDev : «' + RTRIM( ISNULL( CAST (codBaixaDev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| numDiasBaixaDev : «' + RTRIM( ISNULL( CAST (numDiasBaixaDev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgVersoBoleto : «' + RTRIM( ISNULL( CAST (IdMsgVersoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VersaoAplicativoCaixa IS NULL THEN ' VersaoAplicativoCaixa : «Nulo» '
                                              WHEN  VersaoAplicativoCaixa = 0 THEN ' VersaoAplicativoCaixa : «Falso» '
                                              WHEN  VersaoAplicativoCaixa = 1 THEN ' VersaoAplicativoCaixa : «Verdadeiro» '
                                    END 
                         + '| TipoServico : «' + RTRIM( ISNULL( CAST (TipoServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndConferenciaSeq_BB IS NULL THEN ' IndConferenciaSeq_BB : «Nulo» '
                                              WHEN  IndConferenciaSeq_BB = 0 THEN ' IndConferenciaSeq_BB : «Falso» '
                                              WHEN  IndConferenciaSeq_BB = 1 THEN ' IndConferenciaSeq_BB : «Verdadeiro» '
                                    END 
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CobrancaRegistrada IS NULL THEN ' CobrancaRegistrada : «Nulo» '
                                              WHEN  CobrancaRegistrada = 0 THEN ' CobrancaRegistrada : «Falso» '
                                              WHEN  CobrancaRegistrada = 1 THEN ' CobrancaRegistrada : «Verdadeiro» '
                                    END 
                         + '| NumeroComercioEletronico : «' + RTRIM( ISNULL( CAST (NumeroComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenio : «' + RTRIM( ISNULL( CAST (CodConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConvenio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConvenio, 113 ),'Nulo'))+'» '
                         + '| SituacaoConvenio : «' + RTRIM( ISNULL( CAST (SituacaoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCarteiraCobranca : «' + RTRIM( ISNULL( CAST (CodigoCarteiraCobranca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoConvenio : «' + RTRIM( ISNULL( CAST (TipoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Variacao : «' + RTRIM( ISNULL( CAST (Variacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencial : «' + RTRIM( ISNULL( CAST (Sequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadraoArquivo : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadraoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BB : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BBArquivo : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BBArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RemessaEmProducao IS NULL THEN ' RemessaEmProducao : «Nulo» '
                                              WHEN  RemessaEmProducao = 0 THEN ' RemessaEmProducao : «Falso» '
                                              WHEN  RemessaEmProducao = 1 THEN ' RemessaEmProducao : «Verdadeiro» '
                                    END 
                         + '| NomeConvenio : «' + RTRIM( ISNULL( CAST (NomeConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| codBaixaDev : «' + RTRIM( ISNULL( CAST (codBaixaDev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| numDiasBaixaDev : «' + RTRIM( ISNULL( CAST (numDiasBaixaDev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgVersoBoleto : «' + RTRIM( ISNULL( CAST (IdMsgVersoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VersaoAplicativoCaixa IS NULL THEN ' VersaoAplicativoCaixa : «Nulo» '
                                              WHEN  VersaoAplicativoCaixa = 0 THEN ' VersaoAplicativoCaixa : «Falso» '
                                              WHEN  VersaoAplicativoCaixa = 1 THEN ' VersaoAplicativoCaixa : «Verdadeiro» '
                                    END 
                         + '| TipoServico : «' + RTRIM( ISNULL( CAST (TipoServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndConferenciaSeq_BB IS NULL THEN ' IndConferenciaSeq_BB : «Nulo» '
                                              WHEN  IndConferenciaSeq_BB = 0 THEN ' IndConferenciaSeq_BB : «Falso» '
                                              WHEN  IndConferenciaSeq_BB = 1 THEN ' IndConferenciaSeq_BB : «Verdadeiro» '
                                    END 
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CobrancaRegistrada IS NULL THEN ' CobrancaRegistrada : «Nulo» '
                                              WHEN  CobrancaRegistrada = 0 THEN ' CobrancaRegistrada : «Falso» '
                                              WHEN  CobrancaRegistrada = 1 THEN ' CobrancaRegistrada : «Verdadeiro» '
                                    END 
                         + '| NumeroComercioEletronico : «' + RTRIM( ISNULL( CAST (NumeroComercioEletronico AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
