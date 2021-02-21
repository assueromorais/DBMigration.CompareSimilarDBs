CREATE TABLE [dbo].[DominioConsultaPrestacaoContas] (
    [IdDominioPrestacaoConta] INT             IDENTITY (1, 1) NOT NULL,
    [NumeroSolicitacao]       VARCHAR (50)    NULL,
    [DataSolicitacao]         DATETIME        NULL,
    [Solicitante]             VARCHAR (50)    NULL,
    [Nome]                    VARBINARY (150) NULL,
    [Cargo]                   VARCHAR (50)    NULL,
    [Setor]                   VARCHAR (50)    NULL,
    [Evento]                  VARCHAR (50)    NULL,
    [Descricao]               VARCHAR (50)    NULL,
    [Inicio]                  DATETIME        NULL,
    [Fim]                     DATETIME        NULL,
    [UF]                      VARCHAR (2)     NULL,
    [Cidade]                  VARCHAR (50)    NULL,
    CONSTRAINT [PK_DominioConsultaPrestacaoContas] PRIMARY KEY CLUSTERED ([IdDominioPrestacaoConta] ASC)
);


GO
CREATE TRIGGER [TrgLog_DominioConsultaPrestacaoContas] ON [Implanta_CRPAM].[dbo].[DominioConsultaPrestacaoContas] 
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
SET @TableName = 'DominioConsultaPrestacaoContas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDominioPrestacaoConta : «' + RTRIM( ISNULL( CAST (IdDominioPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSolicitacao : «' + RTRIM( ISNULL( CAST (NumeroSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| Solicitante : «' + RTRIM( ISNULL( CAST (Solicitante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Setor : «' + RTRIM( ISNULL( CAST (Setor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Inicio : «' + RTRIM( ISNULL( CONVERT (CHAR, Inicio, 113 ),'Nulo'))+'» '
                         + '| Fim : «' + RTRIM( ISNULL( CONVERT (CHAR, Fim, 113 ),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDominioPrestacaoConta : «' + RTRIM( ISNULL( CAST (IdDominioPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSolicitacao : «' + RTRIM( ISNULL( CAST (NumeroSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| Solicitante : «' + RTRIM( ISNULL( CAST (Solicitante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Setor : «' + RTRIM( ISNULL( CAST (Setor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Inicio : «' + RTRIM( ISNULL( CONVERT (CHAR, Inicio, 113 ),'Nulo'))+'» '
                         + '| Fim : «' + RTRIM( ISNULL( CONVERT (CHAR, Fim, 113 ),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDominioPrestacaoConta : «' + RTRIM( ISNULL( CAST (IdDominioPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSolicitacao : «' + RTRIM( ISNULL( CAST (NumeroSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| Solicitante : «' + RTRIM( ISNULL( CAST (Solicitante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Setor : «' + RTRIM( ISNULL( CAST (Setor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Inicio : «' + RTRIM( ISNULL( CONVERT (CHAR, Inicio, 113 ),'Nulo'))+'» '
                         + '| Fim : «' + RTRIM( ISNULL( CONVERT (CHAR, Fim, 113 ),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDominioPrestacaoConta : «' + RTRIM( ISNULL( CAST (IdDominioPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSolicitacao : «' + RTRIM( ISNULL( CAST (NumeroSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| Solicitante : «' + RTRIM( ISNULL( CAST (Solicitante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Setor : «' + RTRIM( ISNULL( CAST (Setor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Inicio : «' + RTRIM( ISNULL( CONVERT (CHAR, Inicio, 113 ),'Nulo'))+'» '
                         + '| Fim : «' + RTRIM( ISNULL( CONVERT (CHAR, Fim, 113 ),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
