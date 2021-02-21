CREATE TABLE [dbo].[ArquivosRetornoBanco] (
    [IdArquivoRetorno]        INT          IDENTITY (1, 1) NOT NULL,
    [CodigoBanco]             VARCHAR (3)  NOT NULL,
    [CodigoAgencia]           VARCHAR (4)  NULL,
    [DvCodigoAgencia]         VARCHAR (1)  NULL,
    [ContaCorrente]           VARCHAR (23) NULL,
    [NomeArquivoPagamento]    VARCHAR (50) NULL,
    [NomeArquivoPgtoRenom]    VARCHAR (50) NULL,
    [DataGravacaoBanco]       DATETIME     NULL,
    [SequenciaRetornoBB]      VARCHAR (7)  NULL,
    [Mensagem]                TEXT         NULL,
    [DataProcessamento]       DATETIME     NULL,
    [QuantidadeRegistro]      INT          NULL,
    [QuantidadeAcatado]       INT          NULL,
    [QuantidadeRecusado]      INT          NULL,
    [RegistraLog]             BIT          CONSTRAINT [DF__ArquivosR__Regis__080C0D4A] DEFAULT ((1)) NULL,
    [TipoEmissao]             INT          CONSTRAINT [DF__ArquivosR__TipoE__494735CF] DEFAULT ((1)) NOT NULL,
    [CodConvenio]             VARCHAR (9)  NULL,
    [UsuarioProcessamento]    VARCHAR (35) NULL,
    [QuantidadeOutrosCodBco]  INT          NULL,
    [Arquivo]                 IMAGE        NULL,
    [NumeroSequencialArquivo] VARCHAR (6)  NULL,
    CONSTRAINT [PK_ArquivosRetornoBanco] PRIMARY KEY CLUSTERED ([IdArquivoRetorno] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxDataGravacaoBanco]
    ON [dbo].[ArquivosRetornoBanco]([DataGravacaoBanco] ASC);


GO
CREATE NONCLUSTERED INDEX [idxNomeArquivoPagamento]
    ON [dbo].[ArquivosRetornoBanco]([NomeArquivoPagamento] ASC);


GO
CREATE TRIGGER [TrgLog_ArquivosRetornoBanco] ON [Implanta_CRPAM].[dbo].[ArquivosRetornoBanco] 
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
SET @TableName = 'ArquivosRetornoBanco'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoRetorno : «' + RTRIM( ISNULL( CAST (IdArquivoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DvCodigoAgencia : «' + RTRIM( ISNULL( CAST (DvCodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoPagamento : «' + RTRIM( ISNULL( CAST (NomeArquivoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoPgtoRenom : «' + RTRIM( ISNULL( CAST (NomeArquivoPgtoRenom AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGravacaoBanco : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGravacaoBanco, 113 ),'Nulo'))+'» '
                         + '| SequenciaRetornoBB : «' + RTRIM( ISNULL( CAST (SequenciaRetornoBB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProcessamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProcessamento, 113 ),'Nulo'))+'» '
                         + '| QuantidadeRegistro : «' + RTRIM( ISNULL( CAST (QuantidadeRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeAcatado : «' + RTRIM( ISNULL( CAST (QuantidadeAcatado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeRecusado : «' + RTRIM( ISNULL( CAST (QuantidadeRecusado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenio : «' + RTRIM( ISNULL( CAST (CodConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioProcessamento : «' + RTRIM( ISNULL( CAST (UsuarioProcessamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeOutrosCodBco : «' + RTRIM( ISNULL( CAST (QuantidadeOutrosCodBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSequencialArquivo : «' + RTRIM( ISNULL( CAST (NumeroSequencialArquivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoRetorno : «' + RTRIM( ISNULL( CAST (IdArquivoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DvCodigoAgencia : «' + RTRIM( ISNULL( CAST (DvCodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoPagamento : «' + RTRIM( ISNULL( CAST (NomeArquivoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoPgtoRenom : «' + RTRIM( ISNULL( CAST (NomeArquivoPgtoRenom AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGravacaoBanco : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGravacaoBanco, 113 ),'Nulo'))+'» '
                         + '| SequenciaRetornoBB : «' + RTRIM( ISNULL( CAST (SequenciaRetornoBB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProcessamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProcessamento, 113 ),'Nulo'))+'» '
                         + '| QuantidadeRegistro : «' + RTRIM( ISNULL( CAST (QuantidadeRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeAcatado : «' + RTRIM( ISNULL( CAST (QuantidadeAcatado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeRecusado : «' + RTRIM( ISNULL( CAST (QuantidadeRecusado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenio : «' + RTRIM( ISNULL( CAST (CodConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioProcessamento : «' + RTRIM( ISNULL( CAST (UsuarioProcessamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeOutrosCodBco : «' + RTRIM( ISNULL( CAST (QuantidadeOutrosCodBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSequencialArquivo : «' + RTRIM( ISNULL( CAST (NumeroSequencialArquivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArquivoRetorno : «' + RTRIM( ISNULL( CAST (IdArquivoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DvCodigoAgencia : «' + RTRIM( ISNULL( CAST (DvCodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoPagamento : «' + RTRIM( ISNULL( CAST (NomeArquivoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoPgtoRenom : «' + RTRIM( ISNULL( CAST (NomeArquivoPgtoRenom AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGravacaoBanco : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGravacaoBanco, 113 ),'Nulo'))+'» '
                         + '| SequenciaRetornoBB : «' + RTRIM( ISNULL( CAST (SequenciaRetornoBB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProcessamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProcessamento, 113 ),'Nulo'))+'» '
                         + '| QuantidadeRegistro : «' + RTRIM( ISNULL( CAST (QuantidadeRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeAcatado : «' + RTRIM( ISNULL( CAST (QuantidadeAcatado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeRecusado : «' + RTRIM( ISNULL( CAST (QuantidadeRecusado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenio : «' + RTRIM( ISNULL( CAST (CodConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioProcessamento : «' + RTRIM( ISNULL( CAST (UsuarioProcessamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeOutrosCodBco : «' + RTRIM( ISNULL( CAST (QuantidadeOutrosCodBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSequencialArquivo : «' + RTRIM( ISNULL( CAST (NumeroSequencialArquivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoRetorno : «' + RTRIM( ISNULL( CAST (IdArquivoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DvCodigoAgencia : «' + RTRIM( ISNULL( CAST (DvCodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoPagamento : «' + RTRIM( ISNULL( CAST (NomeArquivoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoPgtoRenom : «' + RTRIM( ISNULL( CAST (NomeArquivoPgtoRenom AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGravacaoBanco : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGravacaoBanco, 113 ),'Nulo'))+'» '
                         + '| SequenciaRetornoBB : «' + RTRIM( ISNULL( CAST (SequenciaRetornoBB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProcessamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProcessamento, 113 ),'Nulo'))+'» '
                         + '| QuantidadeRegistro : «' + RTRIM( ISNULL( CAST (QuantidadeRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeAcatado : «' + RTRIM( ISNULL( CAST (QuantidadeAcatado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeRecusado : «' + RTRIM( ISNULL( CAST (QuantidadeRecusado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenio : «' + RTRIM( ISNULL( CAST (CodConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioProcessamento : «' + RTRIM( ISNULL( CAST (UsuarioProcessamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantidadeOutrosCodBco : «' + RTRIM( ISNULL( CAST (QuantidadeOutrosCodBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSequencialArquivo : «' + RTRIM( ISNULL( CAST (NumeroSequencialArquivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
