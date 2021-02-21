CREATE TABLE [dbo].[CategoriasPJ] (
    [IdCategoriaPJ]    INT          IDENTITY (1, 1) NOT NULL,
    [NomeCategoriaPJ]  VARCHAR (40) NOT NULL,
    [SiglaCategoriaPJ] VARCHAR (5)  NULL,
    [Desativado]       BIT          CONSTRAINT [DF_CategoriasPJDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_CategoriaPJ] PRIMARY KEY NONCLUSTERED ([IdCategoriaPJ] ASC)
);


GO
CREATE TRIGGER [TrgLog_CategoriasPJ] ON [Implanta_CRPAM].[dbo].[CategoriasPJ] 
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
SET @TableName = 'CategoriasPJ'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCategoriaPJ : «' + RTRIM( ISNULL( CAST (IdCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaPJ : «' + RTRIM( ISNULL( CAST (NomeCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCategoriaPJ : «' + RTRIM( ISNULL( CAST (SiglaCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdCategoriaPJ : «' + RTRIM( ISNULL( CAST (IdCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaPJ : «' + RTRIM( ISNULL( CAST (NomeCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCategoriaPJ : «' + RTRIM( ISNULL( CAST (SiglaCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdCategoriaPJ : «' + RTRIM( ISNULL( CAST (IdCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaPJ : «' + RTRIM( ISNULL( CAST (NomeCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCategoriaPJ : «' + RTRIM( ISNULL( CAST (SiglaCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCategoriaPJ : «' + RTRIM( ISNULL( CAST (IdCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaPJ : «' + RTRIM( ISNULL( CAST (NomeCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCategoriaPJ : «' + RTRIM( ISNULL( CAST (SiglaCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
