CREATE TABLE [dbo].[ConfigRegistroConselho] (
    [EhProfissional]  BIT NOT NULL,
    [IdCategoria]     INT NULL,
    [IdTipoInscricao] INT NULL,
    [PosicaoSigla]    INT NULL,
    CONSTRAINT [FK_ConfigRegistroConselho_TiposInscricao] FOREIGN KEY ([IdTipoInscricao]) REFERENCES [dbo].[TiposInscricao] ([IdTipoInscricao])
);


GO
CREATE TRIGGER [TrgLog_ConfigRegistroConselho] ON [Implanta_CRPAM].[dbo].[ConfigRegistroConselho] 
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
SET @TableName = 'ConfigRegistroConselho'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo =  CASE 
         			            WHEN EhProfissional IS NULL THEN ' EhProfissional : «Nulo» '
                                         WHEN EhProfissional = 0 THEN ' EhProfissional : «Falso» '
                                         WHEN EhProfissional = 1 THEN ' EhProfissional : «Verdadeiro» '
 				  END
                         + '| IdCategoria : «' + RTRIM( ISNULL( CAST (IdCategoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosicaoSigla : «' + RTRIM( ISNULL( CAST (PosicaoSigla AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 =  CASE 
         			            WHEN EhProfissional IS NULL THEN ' EhProfissional : «Nulo» '
                                         WHEN EhProfissional = 0 THEN ' EhProfissional : «Falso» '
                                         WHEN EhProfissional = 1 THEN ' EhProfissional : «Verdadeiro» '
 				  END
                         + '| IdCategoria : «' + RTRIM( ISNULL( CAST (IdCategoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosicaoSigla : «' + RTRIM( ISNULL( CAST (PosicaoSigla AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo =  CASE 
         			            WHEN EhProfissional IS NULL THEN ' EhProfissional : «Nulo» '
                                         WHEN EhProfissional = 0 THEN ' EhProfissional : «Falso» '
                                         WHEN EhProfissional = 1 THEN ' EhProfissional : «Verdadeiro» '
 				  END
                         + '| IdCategoria : «' + RTRIM( ISNULL( CAST (IdCategoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosicaoSigla : «' + RTRIM( ISNULL( CAST (PosicaoSigla AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo =  CASE 
         			            WHEN EhProfissional IS NULL THEN ' EhProfissional : «Nulo» '
                                         WHEN EhProfissional = 0 THEN ' EhProfissional : «Falso» '
                                         WHEN EhProfissional = 1 THEN ' EhProfissional : «Verdadeiro» '
 				  END
                         + '| IdCategoria : «' + RTRIM( ISNULL( CAST (IdCategoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosicaoSigla : «' + RTRIM( ISNULL( CAST (PosicaoSigla AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
