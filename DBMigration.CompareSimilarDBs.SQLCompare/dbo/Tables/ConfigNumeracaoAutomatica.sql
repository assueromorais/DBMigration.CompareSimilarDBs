CREATE TABLE [dbo].[ConfigNumeracaoAutomatica] (
    [IdConfigNumeracaoAutomatica] INT      IDENTITY (1, 1) NOT NULL,
    [IdTipoInscricao]             INT      NOT NULL,
    [TipoPessoa]                  CHAR (1) NULL,
    CONSTRAINT [PK_ConfigNumeracaoAutomatica] PRIMARY KEY CLUSTERED ([IdConfigNumeracaoAutomatica] ASC),
    CONSTRAINT [FK_ConfigNumeracaoAutomatica_TiposInscricao] FOREIGN KEY ([IdTipoInscricao]) REFERENCES [dbo].[TiposInscricao] ([IdTipoInscricao])
);


GO
CREATE TRIGGER [TrgLog_ConfigNumeracaoAutomatica] ON [Implanta_CRPAM].[dbo].[ConfigNumeracaoAutomatica] 
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
SET @TableName = 'ConfigNumeracaoAutomatica'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigNumeracaoAutomatica : «' + RTRIM( ISNULL( CAST (IdConfigNumeracaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigNumeracaoAutomatica : «' + RTRIM( ISNULL( CAST (IdConfigNumeracaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigNumeracaoAutomatica : «' + RTRIM( ISNULL( CAST (IdConfigNumeracaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigNumeracaoAutomatica : «' + RTRIM( ISNULL( CAST (IdConfigNumeracaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
