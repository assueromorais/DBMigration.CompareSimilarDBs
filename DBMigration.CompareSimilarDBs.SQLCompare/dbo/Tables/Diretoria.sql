CREATE TABLE [dbo].[Diretoria] (
    [IdDiretoria]       INT      IDENTITY (1, 1) NOT NULL,
    [IdCargosDiretoria] INT      NOT NULL,
    [IdPessoaSispad]    INT      NOT NULL,
    [DataInicio]        DATETIME NULL,
    [DataTermino]       DATETIME NULL,
    CONSTRAINT [PK_Diretoria] PRIMARY KEY CLUSTERED ([IdDiretoria] ASC),
    CONSTRAINT [FK_Diretoria_CargosDiretoria] FOREIGN KEY ([IdCargosDiretoria]) REFERENCES [dbo].[CargosDiretoria] ([IdCargosDiretoria]),
    CONSTRAINT [FK_Diretoria_PessoasSispad] FOREIGN KEY ([IdPessoaSispad]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad])
);


GO
CREATE TRIGGER [TrgLog_Diretoria] ON [Implanta_CRPAM].[dbo].[Diretoria] 
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
SET @TableName = 'Diretoria'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDiretoria : «' + RTRIM( ISNULL( CAST (IdDiretoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargosDiretoria : «' + RTRIM( ISNULL( CAST (IdCargosDiretoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDiretoria : «' + RTRIM( ISNULL( CAST (IdDiretoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargosDiretoria : «' + RTRIM( ISNULL( CAST (IdCargosDiretoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDiretoria : «' + RTRIM( ISNULL( CAST (IdDiretoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargosDiretoria : «' + RTRIM( ISNULL( CAST (IdCargosDiretoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDiretoria : «' + RTRIM( ISNULL( CAST (IdDiretoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargosDiretoria : «' + RTRIM( ISNULL( CAST (IdCargosDiretoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
