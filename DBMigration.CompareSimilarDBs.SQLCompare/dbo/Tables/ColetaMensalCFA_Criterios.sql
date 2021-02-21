CREATE TABLE [dbo].[ColetaMensalCFA_Criterios] (
    [IdColetaMensalCFA_Criterio] INT          IDENTITY (1, 1) NOT NULL,
    [IdentificadorCriterio]      VARCHAR (50) NOT NULL,
    [SemCategoria]               BIT          CONSTRAINT [DF_SemCategoria] DEFAULT ((0)) NOT NULL,
    [SemInscricao]               BIT          CONSTRAINT [DF_SemInscricao] DEFAULT ((0)) NOT NULL,
    [SemSituacao]                BIT          CONSTRAINT [DF_SemSituacao] DEFAULT ((0)) NOT NULL,
    [SemNome]                    BIT          CONSTRAINT [DF_SemNome] DEFAULT ((0)) NOT NULL,
    [SemRegistro]                BIT          CONSTRAINT [DF_SemRegistro] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ColetaMensalCFA_Criterios] PRIMARY KEY CLUSTERED ([IdColetaMensalCFA_Criterio] ASC),
    CONSTRAINT [UN_IdentificadorCriterio] UNIQUE NONCLUSTERED ([IdentificadorCriterio] ASC)
);


GO
CREATE TRIGGER [TrgLog_ColetaMensalCFA_Criterios] ON [Implanta_CRPAM].[dbo].[ColetaMensalCFA_Criterios] 
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
SET @TableName = 'ColetaMensalCFA_Criterios'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdColetaMensalCFA_Criterio : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorCriterio : «' + RTRIM( ISNULL( CAST (IdentificadorCriterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SemCategoria IS NULL THEN ' SemCategoria : «Nulo» '
                                              WHEN  SemCategoria = 0 THEN ' SemCategoria : «Falso» '
                                              WHEN  SemCategoria = 1 THEN ' SemCategoria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemInscricao IS NULL THEN ' SemInscricao : «Nulo» '
                                              WHEN  SemInscricao = 0 THEN ' SemInscricao : «Falso» '
                                              WHEN  SemInscricao = 1 THEN ' SemInscricao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemSituacao IS NULL THEN ' SemSituacao : «Nulo» '
                                              WHEN  SemSituacao = 0 THEN ' SemSituacao : «Falso» '
                                              WHEN  SemSituacao = 1 THEN ' SemSituacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemNome IS NULL THEN ' SemNome : «Nulo» '
                                              WHEN  SemNome = 0 THEN ' SemNome : «Falso» '
                                              WHEN  SemNome = 1 THEN ' SemNome : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemRegistro IS NULL THEN ' SemRegistro : «Nulo» '
                                              WHEN  SemRegistro = 0 THEN ' SemRegistro : «Falso» '
                                              WHEN  SemRegistro = 1 THEN ' SemRegistro : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdColetaMensalCFA_Criterio : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorCriterio : «' + RTRIM( ISNULL( CAST (IdentificadorCriterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SemCategoria IS NULL THEN ' SemCategoria : «Nulo» '
                                              WHEN  SemCategoria = 0 THEN ' SemCategoria : «Falso» '
                                              WHEN  SemCategoria = 1 THEN ' SemCategoria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemInscricao IS NULL THEN ' SemInscricao : «Nulo» '
                                              WHEN  SemInscricao = 0 THEN ' SemInscricao : «Falso» '
                                              WHEN  SemInscricao = 1 THEN ' SemInscricao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemSituacao IS NULL THEN ' SemSituacao : «Nulo» '
                                              WHEN  SemSituacao = 0 THEN ' SemSituacao : «Falso» '
                                              WHEN  SemSituacao = 1 THEN ' SemSituacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemNome IS NULL THEN ' SemNome : «Nulo» '
                                              WHEN  SemNome = 0 THEN ' SemNome : «Falso» '
                                              WHEN  SemNome = 1 THEN ' SemNome : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemRegistro IS NULL THEN ' SemRegistro : «Nulo» '
                                              WHEN  SemRegistro = 0 THEN ' SemRegistro : «Falso» '
                                              WHEN  SemRegistro = 1 THEN ' SemRegistro : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdColetaMensalCFA_Criterio : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorCriterio : «' + RTRIM( ISNULL( CAST (IdentificadorCriterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SemCategoria IS NULL THEN ' SemCategoria : «Nulo» '
                                              WHEN  SemCategoria = 0 THEN ' SemCategoria : «Falso» '
                                              WHEN  SemCategoria = 1 THEN ' SemCategoria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemInscricao IS NULL THEN ' SemInscricao : «Nulo» '
                                              WHEN  SemInscricao = 0 THEN ' SemInscricao : «Falso» '
                                              WHEN  SemInscricao = 1 THEN ' SemInscricao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemSituacao IS NULL THEN ' SemSituacao : «Nulo» '
                                              WHEN  SemSituacao = 0 THEN ' SemSituacao : «Falso» '
                                              WHEN  SemSituacao = 1 THEN ' SemSituacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemNome IS NULL THEN ' SemNome : «Nulo» '
                                              WHEN  SemNome = 0 THEN ' SemNome : «Falso» '
                                              WHEN  SemNome = 1 THEN ' SemNome : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemRegistro IS NULL THEN ' SemRegistro : «Nulo» '
                                              WHEN  SemRegistro = 0 THEN ' SemRegistro : «Falso» '
                                              WHEN  SemRegistro = 1 THEN ' SemRegistro : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdColetaMensalCFA_Criterio : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorCriterio : «' + RTRIM( ISNULL( CAST (IdentificadorCriterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SemCategoria IS NULL THEN ' SemCategoria : «Nulo» '
                                              WHEN  SemCategoria = 0 THEN ' SemCategoria : «Falso» '
                                              WHEN  SemCategoria = 1 THEN ' SemCategoria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemInscricao IS NULL THEN ' SemInscricao : «Nulo» '
                                              WHEN  SemInscricao = 0 THEN ' SemInscricao : «Falso» '
                                              WHEN  SemInscricao = 1 THEN ' SemInscricao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemSituacao IS NULL THEN ' SemSituacao : «Nulo» '
                                              WHEN  SemSituacao = 0 THEN ' SemSituacao : «Falso» '
                                              WHEN  SemSituacao = 1 THEN ' SemSituacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemNome IS NULL THEN ' SemNome : «Nulo» '
                                              WHEN  SemNome = 0 THEN ' SemNome : «Falso» '
                                              WHEN  SemNome = 1 THEN ' SemNome : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SemRegistro IS NULL THEN ' SemRegistro : «Nulo» '
                                              WHEN  SemRegistro = 0 THEN ' SemRegistro : «Falso» '
                                              WHEN  SemRegistro = 1 THEN ' SemRegistro : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
