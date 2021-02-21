CREATE TABLE [dbo].[ControleAcessoSiscafweb] (
    [Id]                         INT           IDENTITY (1, 1) NOT NULL,
    [IdUsuario]                  INT           NULL,
    [NomeTela]                   VARCHAR (50)  NULL,
    [PermissaoCampos]            VARCHAR (50)  NULL,
    [Visivel]                    BIT           NULL,
    [MsgTelaBloqueada]           VARCHAR (200) NULL,
    [ObrigatorioExistirRegistro] BIT           CONSTRAINT [DF_ControleAcessoSiscafweb_ObrigatorioExistirRegistro] DEFAULT ((0)) NOT NULL,
    [NomeCampo]                  VARCHAR (100) NULL
);


GO
CREATE TRIGGER [TrgLog_ControleAcessoSiscafweb] ON [Implanta_CRPAM].[dbo].[ControleAcessoSiscafweb] 
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
SET @TableName = 'ControleAcessoSiscafweb'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTela : «' + RTRIM( ISNULL( CAST (NomeTela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PermissaoCampos : «' + RTRIM( ISNULL( CAST (PermissaoCampos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Visivel IS NULL THEN ' Visivel : «Nulo» '
                                              WHEN  Visivel = 0 THEN ' Visivel : «Falso» '
                                              WHEN  Visivel = 1 THEN ' Visivel : «Verdadeiro» '
                                    END 
                         + '| MsgTelaBloqueada : «' + RTRIM( ISNULL( CAST (MsgTelaBloqueada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ObrigatorioExistirRegistro IS NULL THEN ' ObrigatorioExistirRegistro : «Nulo» '
                                              WHEN  ObrigatorioExistirRegistro = 0 THEN ' ObrigatorioExistirRegistro : «Falso» '
                                              WHEN  ObrigatorioExistirRegistro = 1 THEN ' ObrigatorioExistirRegistro : «Verdadeiro» '
                                    END 
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTela : «' + RTRIM( ISNULL( CAST (NomeTela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PermissaoCampos : «' + RTRIM( ISNULL( CAST (PermissaoCampos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Visivel IS NULL THEN ' Visivel : «Nulo» '
                                              WHEN  Visivel = 0 THEN ' Visivel : «Falso» '
                                              WHEN  Visivel = 1 THEN ' Visivel : «Verdadeiro» '
                                    END 
                         + '| MsgTelaBloqueada : «' + RTRIM( ISNULL( CAST (MsgTelaBloqueada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ObrigatorioExistirRegistro IS NULL THEN ' ObrigatorioExistirRegistro : «Nulo» '
                                              WHEN  ObrigatorioExistirRegistro = 0 THEN ' ObrigatorioExistirRegistro : «Falso» '
                                              WHEN  ObrigatorioExistirRegistro = 1 THEN ' ObrigatorioExistirRegistro : «Verdadeiro» '
                                    END 
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTela : «' + RTRIM( ISNULL( CAST (NomeTela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PermissaoCampos : «' + RTRIM( ISNULL( CAST (PermissaoCampos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Visivel IS NULL THEN ' Visivel : «Nulo» '
                                              WHEN  Visivel = 0 THEN ' Visivel : «Falso» '
                                              WHEN  Visivel = 1 THEN ' Visivel : «Verdadeiro» '
                                    END 
                         + '| MsgTelaBloqueada : «' + RTRIM( ISNULL( CAST (MsgTelaBloqueada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ObrigatorioExistirRegistro IS NULL THEN ' ObrigatorioExistirRegistro : «Nulo» '
                                              WHEN  ObrigatorioExistirRegistro = 0 THEN ' ObrigatorioExistirRegistro : «Falso» '
                                              WHEN  ObrigatorioExistirRegistro = 1 THEN ' ObrigatorioExistirRegistro : «Verdadeiro» '
                                    END 
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTela : «' + RTRIM( ISNULL( CAST (NomeTela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PermissaoCampos : «' + RTRIM( ISNULL( CAST (PermissaoCampos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Visivel IS NULL THEN ' Visivel : «Nulo» '
                                              WHEN  Visivel = 0 THEN ' Visivel : «Falso» '
                                              WHEN  Visivel = 1 THEN ' Visivel : «Verdadeiro» '
                                    END 
                         + '| MsgTelaBloqueada : «' + RTRIM( ISNULL( CAST (MsgTelaBloqueada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ObrigatorioExistirRegistro IS NULL THEN ' ObrigatorioExistirRegistro : «Nulo» '
                                              WHEN  ObrigatorioExistirRegistro = 0 THEN ' ObrigatorioExistirRegistro : «Falso» '
                                              WHEN  ObrigatorioExistirRegistro = 1 THEN ' ObrigatorioExistirRegistro : «Verdadeiro» '
                                    END 
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
