CREATE TABLE [dbo].[CategoriasProf] (
    [IdCategoriaProf]    INT          IDENTITY (1, 1) NOT NULL,
    [NomeCategoriaProf]  VARCHAR (40) NOT NULL,
    [SiglaCategoriaProf] VARCHAR (5)  NULL,
    [Desativado]         BIT          CONSTRAINT [DF_CategoriasProfDesativado] DEFAULT ((0)) NULL,
    [TipoFormacao]       CHAR (1)     NULL,
    CONSTRAINT [PK_CategoriasProfissional] PRIMARY KEY NONCLUSTERED ([IdCategoriaProf] ASC)
);


GO
CREATE TRIGGER [TrgLog_CategoriasProf] ON [Implanta_CRPAM].[dbo].[CategoriasProf] 
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
SET @TableName = 'CategoriasProf'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaProf : «' + RTRIM( ISNULL( CAST (NomeCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCategoriaProf : «' + RTRIM( ISNULL( CAST (SiglaCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| TipoFormacao : «' + RTRIM( ISNULL( CAST (TipoFormacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaProf : «' + RTRIM( ISNULL( CAST (NomeCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCategoriaProf : «' + RTRIM( ISNULL( CAST (SiglaCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| TipoFormacao : «' + RTRIM( ISNULL( CAST (TipoFormacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaProf : «' + RTRIM( ISNULL( CAST (NomeCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCategoriaProf : «' + RTRIM( ISNULL( CAST (SiglaCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| TipoFormacao : «' + RTRIM( ISNULL( CAST (TipoFormacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaProf : «' + RTRIM( ISNULL( CAST (NomeCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCategoriaProf : «' + RTRIM( ISNULL( CAST (SiglaCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| TipoFormacao : «' + RTRIM( ISNULL( CAST (TipoFormacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
