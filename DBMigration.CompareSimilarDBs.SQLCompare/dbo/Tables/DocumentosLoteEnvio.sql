CREATE TABLE [dbo].[DocumentosLoteEnvio] (
    [IdDocumentoLote]         INT          IDENTITY (1, 1) NOT NULL,
    [IdLoteEnvio]             INT          NULL,
    [IdComplementoDocEmitido] INT          NULL,
    [CodigoBarras]            VARCHAR (50) NULL,
    [IdDocumento]             INT          NULL
);


GO
CREATE TRIGGER [TrgLog_DocumentosLoteEnvio] ON [Implanta_CRPAM].[dbo].[DocumentosLoteEnvio] 
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
SET @TableName = 'DocumentosLoteEnvio'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDocumentoLote : «' + RTRIM( ISNULL( CAST (IdDocumentoLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLoteEnvio : «' + RTRIM( ISNULL( CAST (IdLoteEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComplementoDocEmitido : «' + RTRIM( ISNULL( CAST (IdComplementoDocEmitido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarras : «' + RTRIM( ISNULL( CAST (CodigoBarras AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDocumentoLote : «' + RTRIM( ISNULL( CAST (IdDocumentoLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLoteEnvio : «' + RTRIM( ISNULL( CAST (IdLoteEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComplementoDocEmitido : «' + RTRIM( ISNULL( CAST (IdComplementoDocEmitido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarras : «' + RTRIM( ISNULL( CAST (CodigoBarras AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDocumentoLote : «' + RTRIM( ISNULL( CAST (IdDocumentoLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLoteEnvio : «' + RTRIM( ISNULL( CAST (IdLoteEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComplementoDocEmitido : «' + RTRIM( ISNULL( CAST (IdComplementoDocEmitido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarras : «' + RTRIM( ISNULL( CAST (CodigoBarras AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDocumentoLote : «' + RTRIM( ISNULL( CAST (IdDocumentoLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLoteEnvio : «' + RTRIM( ISNULL( CAST (IdLoteEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComplementoDocEmitido : «' + RTRIM( ISNULL( CAST (IdComplementoDocEmitido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarras : «' + RTRIM( ISNULL( CAST (CodigoBarras AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
