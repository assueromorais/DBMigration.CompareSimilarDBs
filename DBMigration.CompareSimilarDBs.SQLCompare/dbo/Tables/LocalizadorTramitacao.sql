CREATE TABLE [dbo].[LocalizadorTramitacao] (
    [IdLocalizador]  INT          IDENTITY (1, 1) NOT NULL,
    [Localizador]    VARCHAR (10) NOT NULL,
    [Descricao]      VARCHAR (50) NULL,
    [Desativado]     BIT          NULL,
    [IdDepartamento] INT          NULL,
    CONSTRAINT [PK_LocalizadorTramitacao] PRIMARY KEY CLUSTERED ([IdLocalizador] ASC),
    CONSTRAINT [FK_LocalizadorTramitacao_Departamentos] FOREIGN KEY ([IdDepartamento]) REFERENCES [dbo].[Departamentos] ([IdDepto])
);


GO
CREATE TRIGGER [TrgLog_LocalizadorTramitacao] ON [Implanta_CRPAM].[dbo].[LocalizadorTramitacao] 
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
SET @TableName = 'LocalizadorTramitacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLocalizador : «' + RTRIM( ISNULL( CAST (IdLocalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Localizador : «' + RTRIM( ISNULL( CAST (Localizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLocalizador : «' + RTRIM( ISNULL( CAST (IdLocalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Localizador : «' + RTRIM( ISNULL( CAST (Localizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLocalizador : «' + RTRIM( ISNULL( CAST (IdLocalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Localizador : «' + RTRIM( ISNULL( CAST (Localizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLocalizador : «' + RTRIM( ISNULL( CAST (IdLocalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Localizador : «' + RTRIM( ISNULL( CAST (Localizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
