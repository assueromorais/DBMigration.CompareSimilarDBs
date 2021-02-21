CREATE TABLE [dbo].[ChancelaRepresentado] (
    [IdChancelaRepresentado] INT IDENTITY (1, 1) NOT NULL,
    [IdPessoa]               INT NOT NULL,
    [Ativo]                  BIT NULL,
    CONSTRAINT [PK_ChancelaRepresentado] PRIMARY KEY CLUSTERED ([IdChancelaRepresentado] ASC),
    CONSTRAINT [FK_ChancelaRepresentado_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
CREATE TRIGGER [TrgLog_ChancelaRepresentado] ON [Implanta_CRPAM].[dbo].[ChancelaRepresentado] 
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
SET @TableName = 'ChancelaRepresentado'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdChancelaRepresentado : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdChancelaRepresentado : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdChancelaRepresentado : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdChancelaRepresentado : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
