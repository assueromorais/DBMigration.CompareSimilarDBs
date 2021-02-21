CREATE TABLE [dbo].[Afastamento] (
    [IdAfastamento]     INT      IDENTITY (1, 1) NOT NULL,
    [IdPessoaSispad]    INT      NULL,
    [IdTipoAfastamento] INT      NULL,
    [DataInicio]        DATETIME NULL,
    [DataTermino]       DATETIME NULL,
    [E_Definitivo]      BIT      NULL,
    [RenunciaAceito]    BIT      NULL,
    [Observacao]        NTEXT    NULL,
    [ValidoGT]          BIT      DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Afastamento] PRIMARY KEY CLUSTERED ([IdAfastamento] ASC),
    CONSTRAINT [FK_Afastamento_PessoasSispad] FOREIGN KEY ([IdPessoaSispad]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad]),
    CONSTRAINT [FK_Afastamento_TipoAfastamento] FOREIGN KEY ([IdTipoAfastamento]) REFERENCES [dbo].[TipoAfastamento] ([IdTipoAfastamento])
);


GO
CREATE TRIGGER [TrgLog_Afastamento] ON [Implanta_CRPAM].[dbo].[Afastamento] 
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
SET @TableName = 'Afastamento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAfastamento : «' + RTRIM( ISNULL( CAST (IdAfastamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoAfastamento : «' + RTRIM( ISNULL( CAST (IdTipoAfastamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Definitivo IS NULL THEN ' E_Definitivo : «Nulo» '
                                              WHEN  E_Definitivo = 0 THEN ' E_Definitivo : «Falso» '
                                              WHEN  E_Definitivo = 1 THEN ' E_Definitivo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenunciaAceito IS NULL THEN ' RenunciaAceito : «Nulo» '
                                              WHEN  RenunciaAceito = 0 THEN ' RenunciaAceito : «Falso» '
                                              WHEN  RenunciaAceito = 1 THEN ' RenunciaAceito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValidoGT IS NULL THEN ' ValidoGT : «Nulo» '
                                              WHEN  ValidoGT = 0 THEN ' ValidoGT : «Falso» '
                                              WHEN  ValidoGT = 1 THEN ' ValidoGT : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdAfastamento : «' + RTRIM( ISNULL( CAST (IdAfastamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoAfastamento : «' + RTRIM( ISNULL( CAST (IdTipoAfastamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Definitivo IS NULL THEN ' E_Definitivo : «Nulo» '
                                              WHEN  E_Definitivo = 0 THEN ' E_Definitivo : «Falso» '
                                              WHEN  E_Definitivo = 1 THEN ' E_Definitivo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenunciaAceito IS NULL THEN ' RenunciaAceito : «Nulo» '
                                              WHEN  RenunciaAceito = 0 THEN ' RenunciaAceito : «Falso» '
                                              WHEN  RenunciaAceito = 1 THEN ' RenunciaAceito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValidoGT IS NULL THEN ' ValidoGT : «Nulo» '
                                              WHEN  ValidoGT = 0 THEN ' ValidoGT : «Falso» '
                                              WHEN  ValidoGT = 1 THEN ' ValidoGT : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdAfastamento : «' + RTRIM( ISNULL( CAST (IdAfastamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoAfastamento : «' + RTRIM( ISNULL( CAST (IdTipoAfastamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Definitivo IS NULL THEN ' E_Definitivo : «Nulo» '
                                              WHEN  E_Definitivo = 0 THEN ' E_Definitivo : «Falso» '
                                              WHEN  E_Definitivo = 1 THEN ' E_Definitivo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenunciaAceito IS NULL THEN ' RenunciaAceito : «Nulo» '
                                              WHEN  RenunciaAceito = 0 THEN ' RenunciaAceito : «Falso» '
                                              WHEN  RenunciaAceito = 1 THEN ' RenunciaAceito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValidoGT IS NULL THEN ' ValidoGT : «Nulo» '
                                              WHEN  ValidoGT = 0 THEN ' ValidoGT : «Falso» '
                                              WHEN  ValidoGT = 1 THEN ' ValidoGT : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAfastamento : «' + RTRIM( ISNULL( CAST (IdAfastamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoAfastamento : «' + RTRIM( ISNULL( CAST (IdTipoAfastamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Definitivo IS NULL THEN ' E_Definitivo : «Nulo» '
                                              WHEN  E_Definitivo = 0 THEN ' E_Definitivo : «Falso» '
                                              WHEN  E_Definitivo = 1 THEN ' E_Definitivo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RenunciaAceito IS NULL THEN ' RenunciaAceito : «Nulo» '
                                              WHEN  RenunciaAceito = 0 THEN ' RenunciaAceito : «Falso» '
                                              WHEN  RenunciaAceito = 1 THEN ' RenunciaAceito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValidoGT IS NULL THEN ' ValidoGT : «Nulo» '
                                              WHEN  ValidoGT = 0 THEN ' ValidoGT : «Falso» '
                                              WHEN  ValidoGT = 1 THEN ' ValidoGT : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
