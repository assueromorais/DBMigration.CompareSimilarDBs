CREATE TABLE [dbo].[ContasCorrentes] (
    [IdContaCorrente]                 INT              IDENTITY (1, 1) NOT NULL,
    [IdBancoSiscafw]                  INT              NOT NULL,
    [IdMsgInstrCobrancaPadrao]        INT              NULL,
    [IdMsgObsPadrao_BB]               INT              NULL,
    [CodigoAgencia]                   INT              NULL,
    [DVAgencia]                       VARCHAR (5)      NULL,
    [NomeAgencia]                     VARCHAR (30)     NULL,
    [ContaCorrente]                   VARCHAR (13)     NULL,
    [DVContaCorrente]                 VARCHAR (5)      NULL,
    [SequencialRemessa]               INT              NULL,
    [FormaImpressao]                  INT              NULL,
    [Carteira]                        CHAR (2)         NULL,
    [IndConferenciaSeq_BB]            BIT              NULL,
    [Operacao_CX]                     CHAR (3)         NULL,
    [CodigoEntidade_CX_SAD]           INT              NULL,
    [InicioNossoNumero_CX]            CHAR (2)         NULL,
    [SequencialConvenio_BB]           INT              NULL,
    [NomeResumidoConselho_Real_BA]    VARCHAR (30)     NULL,
    [CodigoCedente]                   VARCHAR (16)     NULL,
    [E_CNAB]                          BIT              NULL,
    [NumConvenio_CX_CNAB]             VARCHAR (20)     NULL,
    [TipoDocumento]                   INT              NULL,
    [Cadastramento]                   INT              NULL,
    [IdMsgInstrCobrancaPadraoArquivo] INT              NULL,
    [IdMsgObsPadrao_BBArquivo]        INT              NULL,
    [IdConvenioPadrao]                INT              NULL,
    [PercentualRepasse]               FLOAT (53)       NULL,
    [E_Profissional]                  BIT              NULL,
    [E_PessoaJuridica]                BIT              NULL,
    [E_OutrasPessoas]                 BIT              NULL,
    [CodigoEmpresa]                   VARCHAR (20)     NULL,
    [E_Sinco]                         BIT              NULL,
    [InicioNossoNumero]               INT              NULL,
    [FimNossoNumero]                  INT              NULL,
    [SequencialNossoNumero]           INT              NULL,
    [DVCodigoCedente]                 INT              NULL,
    [ValorTarifa]                     MONEY            NULL,
    [CodigoInstrucao]                 VARCHAR (2)      NULL,
    [QtdeDias]                        INT              NULL,
    [ValorMulta]                      MONEY            NULL,
    [CodigoMora]                      VARCHAR (1)      NULL,
    [SequencialRemessaDebitoConta]    INT              CONSTRAINT [DF__ContasCor__Seque__48531196] DEFAULT ((0)) NOT NULL,
    [ConvenioDebitoEmConta]           VARCHAR (5)      NULL,
    [LeiauteCnab]                     INT              DEFAULT ((0)) NULL,
    [Convenio_CX]                     VARCHAR (20)     NULL,
    [IdMsgVersoBoleto]                INT              NULL,
    [Leiaute]                         VARCHAR (15)     NULL,
    [SituacaoContaCorrente]           BIT              CONSTRAINT [DF_ContasCorrentes_SituacaoContaCorrente] DEFAULT ((0)) NULL,
    [CobrancaRegistrada]              BIT              NULL,
    [RemessaEmProducao]               BIT              CONSTRAINT [DF_ContasCorrentesRemessaEmProducao] DEFAULT ((0)) NULL,
    [IdConfigBancoParaEmissao]        UNIQUEIDENTIFIER CONSTRAINT [DF_ContasCorrentesConfigBancoParaEmissao] DEFAULT (newid()) NULL,
    [QtdDiasMinEntreEmissaoVenc]      INT              NULL,
    [ByteGeracao]                     TINYINT          NULL,
    [QtdMaxArqRemessaDia]             INT              NULL,
    CONSTRAINT [PK_ContasCorrentes] PRIMARY KEY CLUSTERED ([IdContaCorrente] ASC),
    CONSTRAINT [FK_ContasCorrentes_BancosSiscafw] FOREIGN KEY ([IdBancoSiscafw]) REFERENCES [dbo].[BancosSiscafw] ([IdBancoSiscafw]),
    CONSTRAINT [FK_ContasCorrentes_Convenios] FOREIGN KEY ([IdConvenioPadrao]) REFERENCES [dbo].[Convenios] ([IdConvenio]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ContasCorrentes_MsgBoletosBancarios] FOREIGN KEY ([IdMsgInstrCobrancaPadrao]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]),
    CONSTRAINT [FK_ContasCorrentes_MsgBoletosBancarios1] FOREIGN KEY ([IdMsgObsPadrao_BB]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]),
    CONSTRAINT [FK_ContasCorrentes_MsgBoletosBancarios2] FOREIGN KEY ([IdMsgInstrCobrancaPadraoArquivo]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ContasCorrentes_MsgBoletosBancarios3] FOREIGN KEY ([IdMsgObsPadrao_BBArquivo]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ContasCorrentes] ON [Implanta_CRPAM].[dbo].[ContasCorrentes] 
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
SET @TableName = 'ContasCorrentes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BB : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgencia : «' + RTRIM( ISNULL( CAST (DVAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAgencia : «' + RTRIM( ISNULL( CAST (NomeAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVContaCorrente : «' + RTRIM( ISNULL( CAST (DVContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressao : «' + RTRIM( ISNULL( CAST (FormaImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Carteira : «' + RTRIM( ISNULL( CAST (Carteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndConferenciaSeq_BB IS NULL THEN ' IndConferenciaSeq_BB : «Nulo» '
                                              WHEN  IndConferenciaSeq_BB = 0 THEN ' IndConferenciaSeq_BB : «Falso» '
                                              WHEN  IndConferenciaSeq_BB = 1 THEN ' IndConferenciaSeq_BB : «Verdadeiro» '
                                    END 
                         + '| Operacao_CX : «' + RTRIM( ISNULL( CAST (Operacao_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoEntidade_CX_SAD : «' + RTRIM( ISNULL( CAST (CodigoEntidade_CX_SAD AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNumero_CX : «' + RTRIM( ISNULL( CAST (InicioNossoNumero_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialConvenio_BB : «' + RTRIM( ISNULL( CAST (SequencialConvenio_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeResumidoConselho_Real_BA : «' + RTRIM( ISNULL( CAST (NomeResumidoConselho_Real_BA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCedente : «' + RTRIM( ISNULL( CAST (CodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_CNAB IS NULL THEN ' E_CNAB : «Nulo» '
                                              WHEN  E_CNAB = 0 THEN ' E_CNAB : «Falso» '
                                              WHEN  E_CNAB = 1 THEN ' E_CNAB : «Verdadeiro» '
                                    END 
                         + '| NumConvenio_CX_CNAB : «' + RTRIM( ISNULL( CAST (NumConvenio_CX_CNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDocumento : «' + RTRIM( ISNULL( CAST (TipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cadastramento : «' + RTRIM( ISNULL( CAST (Cadastramento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadraoArquivo : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadraoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BBArquivo : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BBArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenioPadrao : «' + RTRIM( ISNULL( CAST (IdConvenioPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Profissional IS NULL THEN ' E_Profissional : «Nulo» '
                                              WHEN  E_Profissional = 0 THEN ' E_Profissional : «Falso» '
                                              WHEN  E_Profissional = 1 THEN ' E_Profissional : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_PessoaJuridica IS NULL THEN ' E_PessoaJuridica : «Nulo» '
                                              WHEN  E_PessoaJuridica = 0 THEN ' E_PessoaJuridica : «Falso» '
                                              WHEN  E_PessoaJuridica = 1 THEN ' E_PessoaJuridica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_OutrasPessoas IS NULL THEN ' E_OutrasPessoas : «Nulo» '
                                              WHEN  E_OutrasPessoas = 0 THEN ' E_OutrasPessoas : «Falso» '
                                              WHEN  E_OutrasPessoas = 1 THEN ' E_OutrasPessoas : «Verdadeiro» '
                                    END 
                         + '| CodigoEmpresa : «' + RTRIM( ISNULL( CAST (CodigoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Sinco IS NULL THEN ' E_Sinco : «Nulo» '
                                              WHEN  E_Sinco = 0 THEN ' E_Sinco : «Falso» '
                                              WHEN  E_Sinco = 1 THEN ' E_Sinco : «Verdadeiro» '
                                    END 
                         + '| InicioNossoNumero : «' + RTRIM( ISNULL( CAST (InicioNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNumero : «' + RTRIM( ISNULL( CAST (FimNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoInstrucao : «' + RTRIM( ISNULL( CAST (CodigoInstrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDias : «' + RTRIM( ISNULL( CAST (QtdeDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoMora : «' + RTRIM( ISNULL( CAST (CodigoMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessaDebitoConta : «' + RTRIM( ISNULL( CAST (SequencialRemessaDebitoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioDebitoEmConta : «' + RTRIM( ISNULL( CAST (ConvenioDebitoEmConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LeiauteCnab : «' + RTRIM( ISNULL( CAST (LeiauteCnab AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Convenio_CX : «' + RTRIM( ISNULL( CAST (Convenio_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgVersoBoleto : «' + RTRIM( ISNULL( CAST (IdMsgVersoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Leiaute : «' + RTRIM( ISNULL( CAST (Leiaute AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SituacaoContaCorrente IS NULL THEN ' SituacaoContaCorrente : «Nulo» '
                                              WHEN  SituacaoContaCorrente = 0 THEN ' SituacaoContaCorrente : «Falso» '
                                              WHEN  SituacaoContaCorrente = 1 THEN ' SituacaoContaCorrente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CobrancaRegistrada IS NULL THEN ' CobrancaRegistrada : «Nulo» '
                                              WHEN  CobrancaRegistrada = 0 THEN ' CobrancaRegistrada : «Falso» '
                                              WHEN  CobrancaRegistrada = 1 THEN ' CobrancaRegistrada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RemessaEmProducao IS NULL THEN ' RemessaEmProducao : «Nulo» '
                                              WHEN  RemessaEmProducao = 0 THEN ' RemessaEmProducao : «Falso» '
                                              WHEN  RemessaEmProducao = 1 THEN ' RemessaEmProducao : «Verdadeiro» '
                                    END 
                         + '| QtdDiasMinEntreEmissaoVenc : «' + RTRIM( ISNULL( CAST (QtdDiasMinEntreEmissaoVenc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ByteGeracao : «' + RTRIM( ISNULL( CAST (ByteGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMaxArqRemessaDia : «' + RTRIM( ISNULL( CAST (QtdMaxArqRemessaDia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BB : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgencia : «' + RTRIM( ISNULL( CAST (DVAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAgencia : «' + RTRIM( ISNULL( CAST (NomeAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVContaCorrente : «' + RTRIM( ISNULL( CAST (DVContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressao : «' + RTRIM( ISNULL( CAST (FormaImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Carteira : «' + RTRIM( ISNULL( CAST (Carteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndConferenciaSeq_BB IS NULL THEN ' IndConferenciaSeq_BB : «Nulo» '
                                              WHEN  IndConferenciaSeq_BB = 0 THEN ' IndConferenciaSeq_BB : «Falso» '
                                              WHEN  IndConferenciaSeq_BB = 1 THEN ' IndConferenciaSeq_BB : «Verdadeiro» '
                                    END 
                         + '| Operacao_CX : «' + RTRIM( ISNULL( CAST (Operacao_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoEntidade_CX_SAD : «' + RTRIM( ISNULL( CAST (CodigoEntidade_CX_SAD AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNumero_CX : «' + RTRIM( ISNULL( CAST (InicioNossoNumero_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialConvenio_BB : «' + RTRIM( ISNULL( CAST (SequencialConvenio_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeResumidoConselho_Real_BA : «' + RTRIM( ISNULL( CAST (NomeResumidoConselho_Real_BA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCedente : «' + RTRIM( ISNULL( CAST (CodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_CNAB IS NULL THEN ' E_CNAB : «Nulo» '
                                              WHEN  E_CNAB = 0 THEN ' E_CNAB : «Falso» '
                                              WHEN  E_CNAB = 1 THEN ' E_CNAB : «Verdadeiro» '
                                    END 
                         + '| NumConvenio_CX_CNAB : «' + RTRIM( ISNULL( CAST (NumConvenio_CX_CNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDocumento : «' + RTRIM( ISNULL( CAST (TipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cadastramento : «' + RTRIM( ISNULL( CAST (Cadastramento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadraoArquivo : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadraoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BBArquivo : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BBArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenioPadrao : «' + RTRIM( ISNULL( CAST (IdConvenioPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Profissional IS NULL THEN ' E_Profissional : «Nulo» '
                                              WHEN  E_Profissional = 0 THEN ' E_Profissional : «Falso» '
                                              WHEN  E_Profissional = 1 THEN ' E_Profissional : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_PessoaJuridica IS NULL THEN ' E_PessoaJuridica : «Nulo» '
                                              WHEN  E_PessoaJuridica = 0 THEN ' E_PessoaJuridica : «Falso» '
                                              WHEN  E_PessoaJuridica = 1 THEN ' E_PessoaJuridica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_OutrasPessoas IS NULL THEN ' E_OutrasPessoas : «Nulo» '
                                              WHEN  E_OutrasPessoas = 0 THEN ' E_OutrasPessoas : «Falso» '
                                              WHEN  E_OutrasPessoas = 1 THEN ' E_OutrasPessoas : «Verdadeiro» '
                                    END 
                         + '| CodigoEmpresa : «' + RTRIM( ISNULL( CAST (CodigoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Sinco IS NULL THEN ' E_Sinco : «Nulo» '
                                              WHEN  E_Sinco = 0 THEN ' E_Sinco : «Falso» '
                                              WHEN  E_Sinco = 1 THEN ' E_Sinco : «Verdadeiro» '
                                    END 
                         + '| InicioNossoNumero : «' + RTRIM( ISNULL( CAST (InicioNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNumero : «' + RTRIM( ISNULL( CAST (FimNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoInstrucao : «' + RTRIM( ISNULL( CAST (CodigoInstrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDias : «' + RTRIM( ISNULL( CAST (QtdeDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoMora : «' + RTRIM( ISNULL( CAST (CodigoMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessaDebitoConta : «' + RTRIM( ISNULL( CAST (SequencialRemessaDebitoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioDebitoEmConta : «' + RTRIM( ISNULL( CAST (ConvenioDebitoEmConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LeiauteCnab : «' + RTRIM( ISNULL( CAST (LeiauteCnab AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Convenio_CX : «' + RTRIM( ISNULL( CAST (Convenio_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgVersoBoleto : «' + RTRIM( ISNULL( CAST (IdMsgVersoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Leiaute : «' + RTRIM( ISNULL( CAST (Leiaute AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SituacaoContaCorrente IS NULL THEN ' SituacaoContaCorrente : «Nulo» '
                                              WHEN  SituacaoContaCorrente = 0 THEN ' SituacaoContaCorrente : «Falso» '
                                              WHEN  SituacaoContaCorrente = 1 THEN ' SituacaoContaCorrente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CobrancaRegistrada IS NULL THEN ' CobrancaRegistrada : «Nulo» '
                                              WHEN  CobrancaRegistrada = 0 THEN ' CobrancaRegistrada : «Falso» '
                                              WHEN  CobrancaRegistrada = 1 THEN ' CobrancaRegistrada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RemessaEmProducao IS NULL THEN ' RemessaEmProducao : «Nulo» '
                                              WHEN  RemessaEmProducao = 0 THEN ' RemessaEmProducao : «Falso» '
                                              WHEN  RemessaEmProducao = 1 THEN ' RemessaEmProducao : «Verdadeiro» '
                                    END 
                         + '| QtdDiasMinEntreEmissaoVenc : «' + RTRIM( ISNULL( CAST (QtdDiasMinEntreEmissaoVenc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ByteGeracao : «' + RTRIM( ISNULL( CAST (ByteGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMaxArqRemessaDia : «' + RTRIM( ISNULL( CAST (QtdMaxArqRemessaDia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BB : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgencia : «' + RTRIM( ISNULL( CAST (DVAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAgencia : «' + RTRIM( ISNULL( CAST (NomeAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVContaCorrente : «' + RTRIM( ISNULL( CAST (DVContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressao : «' + RTRIM( ISNULL( CAST (FormaImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Carteira : «' + RTRIM( ISNULL( CAST (Carteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndConferenciaSeq_BB IS NULL THEN ' IndConferenciaSeq_BB : «Nulo» '
                                              WHEN  IndConferenciaSeq_BB = 0 THEN ' IndConferenciaSeq_BB : «Falso» '
                                              WHEN  IndConferenciaSeq_BB = 1 THEN ' IndConferenciaSeq_BB : «Verdadeiro» '
                                    END 
                         + '| Operacao_CX : «' + RTRIM( ISNULL( CAST (Operacao_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoEntidade_CX_SAD : «' + RTRIM( ISNULL( CAST (CodigoEntidade_CX_SAD AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNumero_CX : «' + RTRIM( ISNULL( CAST (InicioNossoNumero_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialConvenio_BB : «' + RTRIM( ISNULL( CAST (SequencialConvenio_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeResumidoConselho_Real_BA : «' + RTRIM( ISNULL( CAST (NomeResumidoConselho_Real_BA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCedente : «' + RTRIM( ISNULL( CAST (CodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_CNAB IS NULL THEN ' E_CNAB : «Nulo» '
                                              WHEN  E_CNAB = 0 THEN ' E_CNAB : «Falso» '
                                              WHEN  E_CNAB = 1 THEN ' E_CNAB : «Verdadeiro» '
                                    END 
                         + '| NumConvenio_CX_CNAB : «' + RTRIM( ISNULL( CAST (NumConvenio_CX_CNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDocumento : «' + RTRIM( ISNULL( CAST (TipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cadastramento : «' + RTRIM( ISNULL( CAST (Cadastramento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadraoArquivo : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadraoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BBArquivo : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BBArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenioPadrao : «' + RTRIM( ISNULL( CAST (IdConvenioPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Profissional IS NULL THEN ' E_Profissional : «Nulo» '
                                              WHEN  E_Profissional = 0 THEN ' E_Profissional : «Falso» '
                                              WHEN  E_Profissional = 1 THEN ' E_Profissional : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_PessoaJuridica IS NULL THEN ' E_PessoaJuridica : «Nulo» '
                                              WHEN  E_PessoaJuridica = 0 THEN ' E_PessoaJuridica : «Falso» '
                                              WHEN  E_PessoaJuridica = 1 THEN ' E_PessoaJuridica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_OutrasPessoas IS NULL THEN ' E_OutrasPessoas : «Nulo» '
                                              WHEN  E_OutrasPessoas = 0 THEN ' E_OutrasPessoas : «Falso» '
                                              WHEN  E_OutrasPessoas = 1 THEN ' E_OutrasPessoas : «Verdadeiro» '
                                    END 
                         + '| CodigoEmpresa : «' + RTRIM( ISNULL( CAST (CodigoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Sinco IS NULL THEN ' E_Sinco : «Nulo» '
                                              WHEN  E_Sinco = 0 THEN ' E_Sinco : «Falso» '
                                              WHEN  E_Sinco = 1 THEN ' E_Sinco : «Verdadeiro» '
                                    END 
                         + '| InicioNossoNumero : «' + RTRIM( ISNULL( CAST (InicioNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNumero : «' + RTRIM( ISNULL( CAST (FimNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoInstrucao : «' + RTRIM( ISNULL( CAST (CodigoInstrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDias : «' + RTRIM( ISNULL( CAST (QtdeDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoMora : «' + RTRIM( ISNULL( CAST (CodigoMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessaDebitoConta : «' + RTRIM( ISNULL( CAST (SequencialRemessaDebitoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioDebitoEmConta : «' + RTRIM( ISNULL( CAST (ConvenioDebitoEmConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LeiauteCnab : «' + RTRIM( ISNULL( CAST (LeiauteCnab AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Convenio_CX : «' + RTRIM( ISNULL( CAST (Convenio_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgVersoBoleto : «' + RTRIM( ISNULL( CAST (IdMsgVersoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Leiaute : «' + RTRIM( ISNULL( CAST (Leiaute AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SituacaoContaCorrente IS NULL THEN ' SituacaoContaCorrente : «Nulo» '
                                              WHEN  SituacaoContaCorrente = 0 THEN ' SituacaoContaCorrente : «Falso» '
                                              WHEN  SituacaoContaCorrente = 1 THEN ' SituacaoContaCorrente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CobrancaRegistrada IS NULL THEN ' CobrancaRegistrada : «Nulo» '
                                              WHEN  CobrancaRegistrada = 0 THEN ' CobrancaRegistrada : «Falso» '
                                              WHEN  CobrancaRegistrada = 1 THEN ' CobrancaRegistrada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RemessaEmProducao IS NULL THEN ' RemessaEmProducao : «Nulo» '
                                              WHEN  RemessaEmProducao = 0 THEN ' RemessaEmProducao : «Falso» '
                                              WHEN  RemessaEmProducao = 1 THEN ' RemessaEmProducao : «Verdadeiro» '
                                    END 
                         + '| QtdDiasMinEntreEmissaoVenc : «' + RTRIM( ISNULL( CAST (QtdDiasMinEntreEmissaoVenc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ByteGeracao : «' + RTRIM( ISNULL( CAST (ByteGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMaxArqRemessaDia : «' + RTRIM( ISNULL( CAST (QtdMaxArqRemessaDia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BB : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgencia : «' + RTRIM( ISNULL( CAST (DVAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAgencia : «' + RTRIM( ISNULL( CAST (NomeAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVContaCorrente : «' + RTRIM( ISNULL( CAST (DVContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaImpressao : «' + RTRIM( ISNULL( CAST (FormaImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Carteira : «' + RTRIM( ISNULL( CAST (Carteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndConferenciaSeq_BB IS NULL THEN ' IndConferenciaSeq_BB : «Nulo» '
                                              WHEN  IndConferenciaSeq_BB = 0 THEN ' IndConferenciaSeq_BB : «Falso» '
                                              WHEN  IndConferenciaSeq_BB = 1 THEN ' IndConferenciaSeq_BB : «Verdadeiro» '
                                    END 
                         + '| Operacao_CX : «' + RTRIM( ISNULL( CAST (Operacao_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoEntidade_CX_SAD : «' + RTRIM( ISNULL( CAST (CodigoEntidade_CX_SAD AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNumero_CX : «' + RTRIM( ISNULL( CAST (InicioNossoNumero_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialConvenio_BB : «' + RTRIM( ISNULL( CAST (SequencialConvenio_BB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeResumidoConselho_Real_BA : «' + RTRIM( ISNULL( CAST (NomeResumidoConselho_Real_BA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCedente : «' + RTRIM( ISNULL( CAST (CodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_CNAB IS NULL THEN ' E_CNAB : «Nulo» '
                                              WHEN  E_CNAB = 0 THEN ' E_CNAB : «Falso» '
                                              WHEN  E_CNAB = 1 THEN ' E_CNAB : «Verdadeiro» '
                                    END 
                         + '| NumConvenio_CX_CNAB : «' + RTRIM( ISNULL( CAST (NumConvenio_CX_CNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDocumento : «' + RTRIM( ISNULL( CAST (TipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cadastramento : «' + RTRIM( ISNULL( CAST (Cadastramento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrancaPadraoArquivo : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrancaPadraoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao_BBArquivo : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao_BBArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenioPadrao : «' + RTRIM( ISNULL( CAST (IdConvenioPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Profissional IS NULL THEN ' E_Profissional : «Nulo» '
                                              WHEN  E_Profissional = 0 THEN ' E_Profissional : «Falso» '
                                              WHEN  E_Profissional = 1 THEN ' E_Profissional : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_PessoaJuridica IS NULL THEN ' E_PessoaJuridica : «Nulo» '
                                              WHEN  E_PessoaJuridica = 0 THEN ' E_PessoaJuridica : «Falso» '
                                              WHEN  E_PessoaJuridica = 1 THEN ' E_PessoaJuridica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_OutrasPessoas IS NULL THEN ' E_OutrasPessoas : «Nulo» '
                                              WHEN  E_OutrasPessoas = 0 THEN ' E_OutrasPessoas : «Falso» '
                                              WHEN  E_OutrasPessoas = 1 THEN ' E_OutrasPessoas : «Verdadeiro» '
                                    END 
                         + '| CodigoEmpresa : «' + RTRIM( ISNULL( CAST (CodigoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Sinco IS NULL THEN ' E_Sinco : «Nulo» '
                                              WHEN  E_Sinco = 0 THEN ' E_Sinco : «Falso» '
                                              WHEN  E_Sinco = 1 THEN ' E_Sinco : «Verdadeiro» '
                                    END 
                         + '| InicioNossoNumero : «' + RTRIM( ISNULL( CAST (InicioNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNumero : «' + RTRIM( ISNULL( CAST (FimNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoInstrucao : «' + RTRIM( ISNULL( CAST (CodigoInstrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDias : «' + RTRIM( ISNULL( CAST (QtdeDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoMora : «' + RTRIM( ISNULL( CAST (CodigoMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessaDebitoConta : «' + RTRIM( ISNULL( CAST (SequencialRemessaDebitoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioDebitoEmConta : «' + RTRIM( ISNULL( CAST (ConvenioDebitoEmConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LeiauteCnab : «' + RTRIM( ISNULL( CAST (LeiauteCnab AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Convenio_CX : «' + RTRIM( ISNULL( CAST (Convenio_CX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgVersoBoleto : «' + RTRIM( ISNULL( CAST (IdMsgVersoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Leiaute : «' + RTRIM( ISNULL( CAST (Leiaute AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SituacaoContaCorrente IS NULL THEN ' SituacaoContaCorrente : «Nulo» '
                                              WHEN  SituacaoContaCorrente = 0 THEN ' SituacaoContaCorrente : «Falso» '
                                              WHEN  SituacaoContaCorrente = 1 THEN ' SituacaoContaCorrente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CobrancaRegistrada IS NULL THEN ' CobrancaRegistrada : «Nulo» '
                                              WHEN  CobrancaRegistrada = 0 THEN ' CobrancaRegistrada : «Falso» '
                                              WHEN  CobrancaRegistrada = 1 THEN ' CobrancaRegistrada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RemessaEmProducao IS NULL THEN ' RemessaEmProducao : «Nulo» '
                                              WHEN  RemessaEmProducao = 0 THEN ' RemessaEmProducao : «Falso» '
                                              WHEN  RemessaEmProducao = 1 THEN ' RemessaEmProducao : «Verdadeiro» '
                                    END 
                         + '| QtdDiasMinEntreEmissaoVenc : «' + RTRIM( ISNULL( CAST (QtdDiasMinEntreEmissaoVenc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ByteGeracao : «' + RTRIM( ISNULL( CAST (ByteGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMaxArqRemessaDia : «' + RTRIM( ISNULL( CAST (QtdMaxArqRemessaDia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
