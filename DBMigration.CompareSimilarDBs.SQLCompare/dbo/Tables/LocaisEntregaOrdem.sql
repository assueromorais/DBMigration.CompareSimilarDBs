﻿CREATE TABLE [dbo].[LocaisEntregaOrdem] (
    [IdLocalEntregaOrdem] INT          IDENTITY (1, 1) NOT NULL,
    [Nome]                VARCHAR (60) NOT NULL,
    [Descricao]           TEXT         NULL,
    CONSTRAINT [PK_LocaisEntregaOrdem] PRIMARY KEY CLUSTERED ([IdLocalEntregaOrdem] ASC)
);


GO
CREATE TRIGGER [TrgLog_LocaisEntregaOrdem] ON [Implanta_CRPAM].[dbo].[LocaisEntregaOrdem] 
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
SET @TableName = 'LocaisEntregaOrdem'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLocalEntregaOrdem : «' + RTRIM( ISNULL( CAST (IdLocalEntregaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLocalEntregaOrdem : «' + RTRIM( ISNULL( CAST (IdLocalEntregaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLocalEntregaOrdem : «' + RTRIM( ISNULL( CAST (IdLocalEntregaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLocalEntregaOrdem : «' + RTRIM( ISNULL( CAST (IdLocalEntregaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
