CREATE TABLE [dbo].[MigracaoCentroCustos] (
    [IdAntigo] INT NOT NULL,
    [IdNovo]   INT NOT NULL,
    CONSTRAINT [PK_MigracaoCentroCustos] PRIMARY KEY NONCLUSTERED ([IdAntigo] ASC)
);


GO
CREATE TRIGGER [TrgLog_MigracaoCentroCustos] ON [Implanta_CRPAM].[dbo].[MigracaoCentroCustos] 
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
SET @TableName = 'MigracaoCentroCustos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAntigo : «' + RTRIM( ISNULL( CAST (IdAntigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNovo : «' + RTRIM( ISNULL( CAST (IdNovo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAntigo : «' + RTRIM( ISNULL( CAST (IdAntigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNovo : «' + RTRIM( ISNULL( CAST (IdNovo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAntigo : «' + RTRIM( ISNULL( CAST (IdAntigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNovo : «' + RTRIM( ISNULL( CAST (IdNovo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAntigo : «' + RTRIM( ISNULL( CAST (IdAntigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNovo : «' + RTRIM( ISNULL( CAST (IdNovo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
