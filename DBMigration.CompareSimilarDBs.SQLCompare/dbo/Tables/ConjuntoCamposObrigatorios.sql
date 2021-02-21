CREATE TABLE [dbo].[ConjuntoCamposObrigatorios] (
    [IdConjunto]                 INT          IDENTITY (1, 1) NOT NULL,
    [IdConjuntoPai]              INT          NULL,
    [IndTipoPessoa]              INT          NOT NULL,
    [Descricao]                  VARCHAR (50) NULL,
    [ObrigatorioExistirRegistro] BIT          CONSTRAINT [DF_ConjuntoCamposObrigatorios_ObrigatorioExistirRegistro] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ConjuntoCamposObrigatorios] PRIMARY KEY CLUSTERED ([IdConjunto] ASC),
    CONSTRAINT [FK_ConjuntoCamposObrigatorios_ConjuntoCamposObrigatorios] FOREIGN KEY ([IdConjuntoPai]) REFERENCES [dbo].[ConjuntoCamposObrigatorios] ([IdConjunto])
);


GO
CREATE TRIGGER [TrgLog_ConjuntoCamposObrigatorios] ON [Implanta_CRPAM].[dbo].[ConjuntoCamposObrigatorios] 
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
SET @TableName = 'ConjuntoCamposObrigatorios'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoPai : «' + RTRIM( ISNULL( CAST (IdConjuntoPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndTipoPessoa : «' + RTRIM( ISNULL( CAST (IndTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ObrigatorioExistirRegistro IS NULL THEN ' ObrigatorioExistirRegistro : «Nulo» '
                                              WHEN  ObrigatorioExistirRegistro = 0 THEN ' ObrigatorioExistirRegistro : «Falso» '
                                              WHEN  ObrigatorioExistirRegistro = 1 THEN ' ObrigatorioExistirRegistro : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoPai : «' + RTRIM( ISNULL( CAST (IdConjuntoPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndTipoPessoa : «' + RTRIM( ISNULL( CAST (IndTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ObrigatorioExistirRegistro IS NULL THEN ' ObrigatorioExistirRegistro : «Nulo» '
                                              WHEN  ObrigatorioExistirRegistro = 0 THEN ' ObrigatorioExistirRegistro : «Falso» '
                                              WHEN  ObrigatorioExistirRegistro = 1 THEN ' ObrigatorioExistirRegistro : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoPai : «' + RTRIM( ISNULL( CAST (IdConjuntoPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndTipoPessoa : «' + RTRIM( ISNULL( CAST (IndTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ObrigatorioExistirRegistro IS NULL THEN ' ObrigatorioExistirRegistro : «Nulo» '
                                              WHEN  ObrigatorioExistirRegistro = 0 THEN ' ObrigatorioExistirRegistro : «Falso» '
                                              WHEN  ObrigatorioExistirRegistro = 1 THEN ' ObrigatorioExistirRegistro : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConjunto : «' + RTRIM( ISNULL( CAST (IdConjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoPai : «' + RTRIM( ISNULL( CAST (IdConjuntoPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndTipoPessoa : «' + RTRIM( ISNULL( CAST (IndTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ObrigatorioExistirRegistro IS NULL THEN ' ObrigatorioExistirRegistro : «Nulo» '
                                              WHEN  ObrigatorioExistirRegistro = 0 THEN ' ObrigatorioExistirRegistro : «Falso» '
                                              WHEN  ObrigatorioExistirRegistro = 1 THEN ' ObrigatorioExistirRegistro : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
