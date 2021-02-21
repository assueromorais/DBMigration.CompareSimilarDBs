CREATE TABLE [dbo].[ConfigTiposDebito] (
    [IdConfigTiposDebito] INT IDENTITY (1, 1) NOT NULL,
    [IdUsuario]           INT NOT NULL,
    [IdTipoDebito]        INT NOT NULL,
    [EmiteBoleto]         BIT DEFAULT ((0)) NOT NULL,
    [Renegocia]           BIT DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_IdConfigTiposDebito] PRIMARY KEY CLUSTERED ([IdConfigTiposDebito] ASC),
    CONSTRAINT [FK_ConfigTiposDebito_TiposDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ConfigTiposDebito_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ConfigTiposDebito] ON [Implanta_CRPAM].[dbo].[ConfigTiposDebito] 
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
SET @TableName = 'ConfigTiposDebito'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigTiposDebito : «' + RTRIM( ISNULL( CAST (IdConfigTiposDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmiteBoleto IS NULL THEN ' EmiteBoleto : «Nulo» '
                                              WHEN  EmiteBoleto = 0 THEN ' EmiteBoleto : «Falso» '
                                              WHEN  EmiteBoleto = 1 THEN ' EmiteBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Renegocia IS NULL THEN ' Renegocia : «Nulo» '
                                              WHEN  Renegocia = 0 THEN ' Renegocia : «Falso» '
                                              WHEN  Renegocia = 1 THEN ' Renegocia : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigTiposDebito : «' + RTRIM( ISNULL( CAST (IdConfigTiposDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmiteBoleto IS NULL THEN ' EmiteBoleto : «Nulo» '
                                              WHEN  EmiteBoleto = 0 THEN ' EmiteBoleto : «Falso» '
                                              WHEN  EmiteBoleto = 1 THEN ' EmiteBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Renegocia IS NULL THEN ' Renegocia : «Nulo» '
                                              WHEN  Renegocia = 0 THEN ' Renegocia : «Falso» '
                                              WHEN  Renegocia = 1 THEN ' Renegocia : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdConfigTiposDebito : «' + RTRIM( ISNULL( CAST (IdConfigTiposDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmiteBoleto IS NULL THEN ' EmiteBoleto : «Nulo» '
                                              WHEN  EmiteBoleto = 0 THEN ' EmiteBoleto : «Falso» '
                                              WHEN  EmiteBoleto = 1 THEN ' EmiteBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Renegocia IS NULL THEN ' Renegocia : «Nulo» '
                                              WHEN  Renegocia = 0 THEN ' Renegocia : «Falso» '
                                              WHEN  Renegocia = 1 THEN ' Renegocia : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigTiposDebito : «' + RTRIM( ISNULL( CAST (IdConfigTiposDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmiteBoleto IS NULL THEN ' EmiteBoleto : «Nulo» '
                                              WHEN  EmiteBoleto = 0 THEN ' EmiteBoleto : «Falso» '
                                              WHEN  EmiteBoleto = 1 THEN ' EmiteBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Renegocia IS NULL THEN ' Renegocia : «Nulo» '
                                              WHEN  Renegocia = 0 THEN ' Renegocia : «Falso» '
                                              WHEN  Renegocia = 1 THEN ' Renegocia : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
