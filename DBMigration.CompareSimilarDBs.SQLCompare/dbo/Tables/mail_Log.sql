CREATE TABLE [dbo].[mail_Log] (
    [IdLog]    INT            IDENTITY (1, 1) NOT NULL,
    [IdConta]  INT            NULL,
    [Data]     DATETIME       NULL,
    [Mensagem] VARCHAR (8000) NULL,
    CONSTRAINT [PK_mail_Log] PRIMARY KEY CLUSTERED ([IdLog] ASC),
    CONSTRAINT [FK_mail_Log_IdConta] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[mail_Contas] ([IdConta])
);


GO
CREATE TRIGGER [TrgLog_mail_Log] ON [Implanta_CRPAM].[dbo].[mail_Log] 
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
SET @TableName = 'mail_Log'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLog : «' + RTRIM( ISNULL( CAST (IdLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Mensagem : «' + RTRIM( ISNULL( CAST (Mensagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLog : «' + RTRIM( ISNULL( CAST (IdLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Mensagem : «' + RTRIM( ISNULL( CAST (Mensagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLog : «' + RTRIM( ISNULL( CAST (IdLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Mensagem : «' + RTRIM( ISNULL( CAST (Mensagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLog : «' + RTRIM( ISNULL( CAST (IdLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Mensagem : «' + RTRIM( ISNULL( CAST (Mensagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
