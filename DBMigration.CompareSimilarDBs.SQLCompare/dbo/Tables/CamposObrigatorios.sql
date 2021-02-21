CREATE TABLE [dbo].[CamposObrigatorios] (
    [IdCampoObrigatorio] INT           IDENTITY (1, 1) NOT NULL,
    [IdConjunto]         INT           NOT NULL,
    [Tabela]             VARCHAR (100) NOT NULL,
    [Campo]              VARCHAR (100) NOT NULL,
    [Descricao]          VARCHAR (100) NOT NULL,
    [Obrigatorio]        BIT           CONSTRAINT [DF_CamposObrigatorios_Obrigatorio] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_CamposObrigatorios] PRIMARY KEY CLUSTERED ([IdCampoObrigatorio] ASC),
    CONSTRAINT [FK_CamposObrigatorios_ConjuntoCamposObrigatorios] FOREIGN KEY ([IdConjunto]) REFERENCES [dbo].[ConjuntoCamposObrigatorios] ([IdConjunto])
);


GO
CREATE TRIGGER [TrgLog_CamposObrigatorios] ON [Implanta_CRPAM].[dbo].[CamposObrigatorios] 
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
SET @TableName = 'CamposObrigatorios'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCampoObrigatorio : «' + RTRIM( ISNULL( CAST (IdCampoObrigatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tabela : «' + RTRIM( ISNULL( CAST (Tabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Campo : «' + RTRIM( ISNULL( CAST (Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatorio IS NULL THEN ' Obrigatorio : «Nulo» '
                                              WHEN  Obrigatorio = 0 THEN ' Obrigatorio : «Falso» '
                                              WHEN  Obrigatorio = 1 THEN ' Obrigatorio : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdCampoObrigatorio : «' + RTRIM( ISNULL( CAST (IdCampoObrigatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tabela : «' + RTRIM( ISNULL( CAST (Tabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Campo : «' + RTRIM( ISNULL( CAST (Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatorio IS NULL THEN ' Obrigatorio : «Nulo» '
                                              WHEN  Obrigatorio = 0 THEN ' Obrigatorio : «Falso» '
                                              WHEN  Obrigatorio = 1 THEN ' Obrigatorio : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdCampoObrigatorio : «' + RTRIM( ISNULL( CAST (IdCampoObrigatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tabela : «' + RTRIM( ISNULL( CAST (Tabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Campo : «' + RTRIM( ISNULL( CAST (Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatorio IS NULL THEN ' Obrigatorio : «Nulo» '
                                              WHEN  Obrigatorio = 0 THEN ' Obrigatorio : «Falso» '
                                              WHEN  Obrigatorio = 1 THEN ' Obrigatorio : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCampoObrigatorio : «' + RTRIM( ISNULL( CAST (IdCampoObrigatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tabela : «' + RTRIM( ISNULL( CAST (Tabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Campo : «' + RTRIM( ISNULL( CAST (Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatorio IS NULL THEN ' Obrigatorio : «Nulo» '
                                              WHEN  Obrigatorio = 0 THEN ' Obrigatorio : «Falso» '
                                              WHEN  Obrigatorio = 1 THEN ' Obrigatorio : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
