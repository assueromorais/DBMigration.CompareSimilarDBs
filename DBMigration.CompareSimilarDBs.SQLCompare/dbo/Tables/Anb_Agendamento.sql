CREATE TABLE [dbo].[Anb_Agendamento] (
    [IdAgendamento]      BIGINT       IDENTITY (1, 1) NOT NULL,
    [UsuarioAgendamento] VARCHAR (35) NOT NULL,
    [DataAgendamento]    DATETIME     NOT NULL,
    [DataUltimaExecucao] DATETIME     NULL,
    CONSTRAINT [PK_Anb_Agendamento] PRIMARY KEY CLUSTERED ([IdAgendamento] ASC)
);


GO
CREATE TRIGGER [TrgLog_Anb_Agendamento] ON [Implanta_CRPAM].[dbo].[Anb_Agendamento] 
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
SET @TableName = 'Anb_Agendamento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAgendamento : «' + RTRIM( ISNULL( CAST (IdAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioAgendamento : «' + RTRIM( ISNULL( CAST (UsuarioAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAgendamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAgendamento, 113 ),'Nulo'))+'» '
                         + '| DataUltimaExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaExecucao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAgendamento : «' + RTRIM( ISNULL( CAST (IdAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioAgendamento : «' + RTRIM( ISNULL( CAST (UsuarioAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAgendamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAgendamento, 113 ),'Nulo'))+'» '
                         + '| DataUltimaExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaExecucao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAgendamento : «' + RTRIM( ISNULL( CAST (IdAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioAgendamento : «' + RTRIM( ISNULL( CAST (UsuarioAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAgendamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAgendamento, 113 ),'Nulo'))+'» '
                         + '| DataUltimaExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaExecucao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAgendamento : «' + RTRIM( ISNULL( CAST (IdAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioAgendamento : «' + RTRIM( ISNULL( CAST (UsuarioAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAgendamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAgendamento, 113 ),'Nulo'))+'» '
                         + '| DataUltimaExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaExecucao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
