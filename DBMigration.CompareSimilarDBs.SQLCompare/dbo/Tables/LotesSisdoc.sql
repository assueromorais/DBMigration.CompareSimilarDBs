CREATE TABLE [dbo].[LotesSisdoc] (
    [IdLote]           INT      IDENTITY (1, 1) NOT NULL,
    [DtCriacao]        DATETIME NOT NULL,
    [IdUsuarioCriacao] INT      NOT NULL,
    [IdDeptCriacao]    INT      NOT NULL,
    [LoteAtivo]        BIT      DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([IdLote] ASC),
    CONSTRAINT [FK_LoteSisdoc_Departamento] FOREIGN KEY ([IdDeptCriacao]) REFERENCES [dbo].[Departamentos] ([IdDepto]),
    CONSTRAINT [FK_LoteSisdoc_Usuario] FOREIGN KEY ([IdUsuarioCriacao]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
CREATE TRIGGER [TrgLog_LotesSisdoc] ON [Implanta_CRPAM].[dbo].[LotesSisdoc] 
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
SET @TableName = 'LotesSisdoc'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLote : «' + RTRIM( ISNULL( CAST (IdLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCriacao, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptCriacao : «' + RTRIM( ISNULL( CAST (IdDeptCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LoteAtivo IS NULL THEN ' LoteAtivo : «Nulo» '
                                              WHEN  LoteAtivo = 0 THEN ' LoteAtivo : «Falso» '
                                              WHEN  LoteAtivo = 1 THEN ' LoteAtivo : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdLote : «' + RTRIM( ISNULL( CAST (IdLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCriacao, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptCriacao : «' + RTRIM( ISNULL( CAST (IdDeptCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LoteAtivo IS NULL THEN ' LoteAtivo : «Nulo» '
                                              WHEN  LoteAtivo = 0 THEN ' LoteAtivo : «Falso» '
                                              WHEN  LoteAtivo = 1 THEN ' LoteAtivo : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdLote : «' + RTRIM( ISNULL( CAST (IdLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCriacao, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptCriacao : «' + RTRIM( ISNULL( CAST (IdDeptCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LoteAtivo IS NULL THEN ' LoteAtivo : «Nulo» '
                                              WHEN  LoteAtivo = 0 THEN ' LoteAtivo : «Falso» '
                                              WHEN  LoteAtivo = 1 THEN ' LoteAtivo : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLote : «' + RTRIM( ISNULL( CAST (IdLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCriacao, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptCriacao : «' + RTRIM( ISNULL( CAST (IdDeptCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  LoteAtivo IS NULL THEN ' LoteAtivo : «Nulo» '
                                              WHEN  LoteAtivo = 0 THEN ' LoteAtivo : «Falso» '
                                              WHEN  LoteAtivo = 1 THEN ' LoteAtivo : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
