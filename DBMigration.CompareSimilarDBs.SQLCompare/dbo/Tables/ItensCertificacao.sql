CREATE TABLE [dbo].[ItensCertificacao] (
    [IdItemCertificacao]   INT          IDENTITY (1, 1) NOT NULL,
    [NomeItemCertificacao] VARCHAR (60) NOT NULL,
    [ItemPadrao]           BIT          NOT NULL,
    CONSTRAINT [PK_ItensCertificacao] PRIMARY KEY NONCLUSTERED ([IdItemCertificacao] ASC)
);


GO
CREATE TRIGGER [TrgLog_ItensCertificacao] ON [Implanta_CRPAM].[dbo].[ItensCertificacao] 
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
SET @TableName = 'ItensCertificacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItemCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItemCertificacao : «' + RTRIM( ISNULL( CAST (NomeItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ItemPadrao IS NULL THEN ' ItemPadrao : «Nulo» '
                                              WHEN  ItemPadrao = 0 THEN ' ItemPadrao : «Falso» '
                                              WHEN  ItemPadrao = 1 THEN ' ItemPadrao : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdItemCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItemCertificacao : «' + RTRIM( ISNULL( CAST (NomeItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ItemPadrao IS NULL THEN ' ItemPadrao : «Nulo» '
                                              WHEN  ItemPadrao = 0 THEN ' ItemPadrao : «Falso» '
                                              WHEN  ItemPadrao = 1 THEN ' ItemPadrao : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdItemCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItemCertificacao : «' + RTRIM( ISNULL( CAST (NomeItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ItemPadrao IS NULL THEN ' ItemPadrao : «Nulo» '
                                              WHEN  ItemPadrao = 0 THEN ' ItemPadrao : «Falso» '
                                              WHEN  ItemPadrao = 1 THEN ' ItemPadrao : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItemCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItemCertificacao : «' + RTRIM( ISNULL( CAST (NomeItemCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ItemPadrao IS NULL THEN ' ItemPadrao : «Nulo» '
                                              WHEN  ItemPadrao = 0 THEN ' ItemPadrao : «Falso» '
                                              WHEN  ItemPadrao = 1 THEN ' ItemPadrao : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
