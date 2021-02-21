CREATE TABLE [dbo].[MotivosBaixaSerasa] (
    [IdMotivoBaixa]   INT            NOT NULL,
    [ExclusivoSerasa] BIT            CONSTRAINT [DEF_MotivosBaixaSerasa_ExclusivoSerasa] DEFAULT ((0)) NOT NULL,
    [Motivo]          VARCHAR (100)  NULL,
    [Descricao]       VARCHAR (8000) NULL,
    CONSTRAINT [PK_MotivosBaixaSerasa_IdMotivoBaixa] PRIMARY KEY CLUSTERED ([IdMotivoBaixa] ASC)
);


GO
CREATE TRIGGER [TrgLog_MotivosBaixaSerasa] ON [Implanta_CRPAM].[dbo].[MotivosBaixaSerasa] 
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
SET @TableName = 'MotivosBaixaSerasa'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMotivoBaixa : «' + RTRIM( ISNULL( CAST (IdMotivoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExclusivoSerasa IS NULL THEN ' ExclusivoSerasa : «Nulo» '
                                              WHEN  ExclusivoSerasa = 0 THEN ' ExclusivoSerasa : «Falso» '
                                              WHEN  ExclusivoSerasa = 1 THEN ' ExclusivoSerasa : «Verdadeiro» '
                                    END 
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMotivoBaixa : «' + RTRIM( ISNULL( CAST (IdMotivoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExclusivoSerasa IS NULL THEN ' ExclusivoSerasa : «Nulo» '
                                              WHEN  ExclusivoSerasa = 0 THEN ' ExclusivoSerasa : «Falso» '
                                              WHEN  ExclusivoSerasa = 1 THEN ' ExclusivoSerasa : «Verdadeiro» '
                                    END 
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMotivoBaixa : «' + RTRIM( ISNULL( CAST (IdMotivoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExclusivoSerasa IS NULL THEN ' ExclusivoSerasa : «Nulo» '
                                              WHEN  ExclusivoSerasa = 0 THEN ' ExclusivoSerasa : «Falso» '
                                              WHEN  ExclusivoSerasa = 1 THEN ' ExclusivoSerasa : «Verdadeiro» '
                                    END 
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMotivoBaixa : «' + RTRIM( ISNULL( CAST (IdMotivoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExclusivoSerasa IS NULL THEN ' ExclusivoSerasa : «Nulo» '
                                              WHEN  ExclusivoSerasa = 0 THEN ' ExclusivoSerasa : «Falso» '
                                              WHEN  ExclusivoSerasa = 1 THEN ' ExclusivoSerasa : «Verdadeiro» '
                                    END 
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
