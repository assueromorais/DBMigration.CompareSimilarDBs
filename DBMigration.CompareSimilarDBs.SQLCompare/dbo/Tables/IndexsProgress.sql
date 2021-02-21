CREATE TABLE [dbo].[IndexsProgress] (
    [Name]            VARCHAR (80) NULL,
    [Progress]        INT          NULL,
    [MaxProgress]     INT          NULL,
    [WorkStationName] VARCHAR (50) NULL,
    [UserName]        VARCHAR (30) NULL,
    [Task]            INT          NULL,
    [MaxTask]         INT          NULL
);


GO
CREATE TRIGGER [TrgLog_IndexsProgress] ON [Implanta_CRPAM].[dbo].[IndexsProgress] 
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
SET @TableName = 'IndexsProgress'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'Name : «' + RTRIM( ISNULL( CAST (Name AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Progress : «' + RTRIM( ISNULL( CAST (Progress AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxProgress : «' + RTRIM( ISNULL( CAST (MaxProgress AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| WorkStationName : «' + RTRIM( ISNULL( CAST (WorkStationName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UserName : «' + RTRIM( ISNULL( CAST (UserName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Task : «' + RTRIM( ISNULL( CAST (Task AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxTask : «' + RTRIM( ISNULL( CAST (MaxTask AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'Name : «' + RTRIM( ISNULL( CAST (Name AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Progress : «' + RTRIM( ISNULL( CAST (Progress AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxProgress : «' + RTRIM( ISNULL( CAST (MaxProgress AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| WorkStationName : «' + RTRIM( ISNULL( CAST (WorkStationName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UserName : «' + RTRIM( ISNULL( CAST (UserName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Task : «' + RTRIM( ISNULL( CAST (Task AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxTask : «' + RTRIM( ISNULL( CAST (MaxTask AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'Name : «' + RTRIM( ISNULL( CAST (Name AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Progress : «' + RTRIM( ISNULL( CAST (Progress AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxProgress : «' + RTRIM( ISNULL( CAST (MaxProgress AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| WorkStationName : «' + RTRIM( ISNULL( CAST (WorkStationName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UserName : «' + RTRIM( ISNULL( CAST (UserName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Task : «' + RTRIM( ISNULL( CAST (Task AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxTask : «' + RTRIM( ISNULL( CAST (MaxTask AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'Name : «' + RTRIM( ISNULL( CAST (Name AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Progress : «' + RTRIM( ISNULL( CAST (Progress AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxProgress : «' + RTRIM( ISNULL( CAST (MaxProgress AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| WorkStationName : «' + RTRIM( ISNULL( CAST (WorkStationName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UserName : «' + RTRIM( ISNULL( CAST (UserName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Task : «' + RTRIM( ISNULL( CAST (Task AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxTask : «' + RTRIM( ISNULL( CAST (MaxTask AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
