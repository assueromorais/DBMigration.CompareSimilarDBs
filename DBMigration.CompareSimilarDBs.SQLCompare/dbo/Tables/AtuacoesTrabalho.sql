CREATE TABLE [dbo].[AtuacoesTrabalho] (
    [TipoMovimento]     VARCHAR (1)  NULL,
    [ConjuntoAnalisado] INT          NULL,
    [IdConjunto]        INT          NULL,
    [ChaveNomeConjunto] VARCHAR (60) NULL,
    [ChaveDataConjunto] DATETIME     NULL,
    [Desativado]        BIT          CONSTRAINT [DF_AtuacoesTrabalhoDesativado] DEFAULT ((0)) NULL
);


GO
CREATE TRIGGER [TrgLog_AtuacoesTrabalho] ON [Implanta_CRPAM].[dbo].[AtuacoesTrabalho] 
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
SET @TableName = 'AtuacoesTrabalho'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'TipoMovimento : «' + RTRIM( ISNULL( CAST (TipoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConjuntoAnalisado : «' + RTRIM( ISNULL( CAST (ConjuntoAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveNomeConjunto : «' + RTRIM( ISNULL( CAST (ChaveNomeConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveDataConjunto : «' + RTRIM( ISNULL( CONVERT (CHAR, ChaveDataConjunto, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'TipoMovimento : «' + RTRIM( ISNULL( CAST (TipoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConjuntoAnalisado : «' + RTRIM( ISNULL( CAST (ConjuntoAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveNomeConjunto : «' + RTRIM( ISNULL( CAST (ChaveNomeConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveDataConjunto : «' + RTRIM( ISNULL( CONVERT (CHAR, ChaveDataConjunto, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
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
		SELECT @Conteudo = 'TipoMovimento : «' + RTRIM( ISNULL( CAST (TipoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConjuntoAnalisado : «' + RTRIM( ISNULL( CAST (ConjuntoAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveNomeConjunto : «' + RTRIM( ISNULL( CAST (ChaveNomeConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveDataConjunto : «' + RTRIM( ISNULL( CONVERT (CHAR, ChaveDataConjunto, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'TipoMovimento : «' + RTRIM( ISNULL( CAST (TipoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConjuntoAnalisado : «' + RTRIM( ISNULL( CAST (ConjuntoAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveNomeConjunto : «' + RTRIM( ISNULL( CAST (ChaveNomeConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveDataConjunto : «' + RTRIM( ISNULL( CONVERT (CHAR, ChaveDataConjunto, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
