CREATE TABLE [dbo].[ItensCertificacaoCertificacao] (
    [IdItemCertificacaoCertificacao] INT          IDENTITY (1, 1) NOT NULL,
    [IdCertificacao]                 INT          NOT NULL,
    [IdItemCertificacao]             INT          NOT NULL,
    [ItemTipo]                       VARCHAR (20) NULL,
    [DataEntrega]                    DATETIME     NULL,
    [DataAprovacao]                  DATETIME     NULL,
    [DataValidade]                   DATETIME     NULL,
    CONSTRAINT [PK_ItensCertificacaoCertificacao] PRIMARY KEY NONCLUSTERED ([IdItemCertificacaoCertificacao] ASC),
    CONSTRAINT [FK_ItensCertificacaoCertificacao_Certificacoes] FOREIGN KEY ([IdCertificacao]) REFERENCES [dbo].[Certificacoes] ([IdCertificacao]),
    CONSTRAINT [FK_ItensCertificacaoCertificacao_ItensCertificacao] FOREIGN KEY ([IdItemCertificacao]) REFERENCES [dbo].[ItensCertificacao] ([IdItemCertificacao])
);


GO
CREATE TRIGGER [TrgLog_ItensCertificacaoCertificacao] ON [Implanta_CRPAM].[dbo].[ItensCertificacaoCertificacao] 
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
SET @TableName = 'ItensCertificacaoCertificacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItemCertificacaoCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacaoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCertificacao : «' + RTRIM( ISNULL( CAST (IdCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ItemTipo : «' + RTRIM( ISNULL( CAST (ItemTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntrega : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntrega, 113 ),'Nulo'))+'» '
                         + '| DataAprovacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAprovacao, 113 ),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItemCertificacaoCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacaoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCertificacao : «' + RTRIM( ISNULL( CAST (IdCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ItemTipo : «' + RTRIM( ISNULL( CAST (ItemTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntrega : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntrega, 113 ),'Nulo'))+'» '
                         + '| DataAprovacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAprovacao, 113 ),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItemCertificacaoCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacaoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCertificacao : «' + RTRIM( ISNULL( CAST (IdCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ItemTipo : «' + RTRIM( ISNULL( CAST (ItemTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntrega : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntrega, 113 ),'Nulo'))+'» '
                         + '| DataAprovacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAprovacao, 113 ),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItemCertificacaoCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacaoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCertificacao : «' + RTRIM( ISNULL( CAST (IdCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ItemTipo : «' + RTRIM( ISNULL( CAST (ItemTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntrega : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntrega, 113 ),'Nulo'))+'» '
                         + '| DataAprovacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAprovacao, 113 ),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
