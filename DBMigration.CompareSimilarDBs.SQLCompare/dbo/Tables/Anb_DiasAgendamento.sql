CREATE TABLE [dbo].[Anb_DiasAgendamento] (
    [IdAgendamento]  BIGINT NOT NULL,
    [DiaAgendamento] INT    NOT NULL,
    CONSTRAINT [PK_Anb_DiasAgendamento_1] PRIMARY KEY CLUSTERED ([IdAgendamento] ASC, [DiaAgendamento] ASC),
    CONSTRAINT [FK_Anb_DiasAgendamento_Anb_Agendamento] FOREIGN KEY ([IdAgendamento]) REFERENCES [dbo].[Anb_Agendamento] ([IdAgendamento])
);


GO
CREATE TRIGGER [TrgLog_Anb_DiasAgendamento] ON [Implanta_CRPAM].[dbo].[Anb_DiasAgendamento] 
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
SET @TableName = 'Anb_DiasAgendamento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAgendamento : «' + RTRIM( ISNULL( CAST (IdAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaAgendamento : «' + RTRIM( ISNULL( CAST (DiaAgendamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAgendamento : «' + RTRIM( ISNULL( CAST (IdAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaAgendamento : «' + RTRIM( ISNULL( CAST (DiaAgendamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
                         + '| DiaAgendamento : «' + RTRIM( ISNULL( CAST (DiaAgendamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAgendamento : «' + RTRIM( ISNULL( CAST (IdAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaAgendamento : «' + RTRIM( ISNULL( CAST (DiaAgendamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
