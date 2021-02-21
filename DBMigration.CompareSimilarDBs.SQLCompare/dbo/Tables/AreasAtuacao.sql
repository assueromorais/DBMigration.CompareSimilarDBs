CREATE TABLE [dbo].[AreasAtuacao] (
    [IdAreaAtuacao] INT          IDENTITY (1, 1) NOT NULL,
    [AreaAtuacao]   VARCHAR (50) NULL,
    [Desativado]    BIT          CONSTRAINT [DF_AreasAtuacaoDesativado] DEFAULT ((0)) NULL,
    [TipoPessoa]    CHAR (1)     DEFAULT ('A') NOT NULL,
    CONSTRAINT [PK_AreaAtuacao] PRIMARY KEY CLUSTERED ([IdAreaAtuacao] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IndArea]
    ON [dbo].[AreasAtuacao]([AreaAtuacao] ASC);


GO
CREATE TRIGGER [TrgLog_AreasAtuacao] ON [Implanta_CRPAM].[dbo].[AreasAtuacao] 
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
SET @TableName = 'AreasAtuacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAreaAtuacao : «' + RTRIM( ISNULL( CAST (IdAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AreaAtuacao : «' + RTRIM( ISNULL( CAST (AreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAreaAtuacao : «' + RTRIM( ISNULL( CAST (IdAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AreaAtuacao : «' + RTRIM( ISNULL( CAST (AreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
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
		SELECT @Conteudo = 'IdAreaAtuacao : «' + RTRIM( ISNULL( CAST (IdAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AreaAtuacao : «' + RTRIM( ISNULL( CAST (AreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAreaAtuacao : «' + RTRIM( ISNULL( CAST (IdAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AreaAtuacao : «' + RTRIM( ISNULL( CAST (AreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
