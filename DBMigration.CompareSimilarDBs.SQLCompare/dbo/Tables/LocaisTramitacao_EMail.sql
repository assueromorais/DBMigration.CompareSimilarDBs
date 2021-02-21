CREATE TABLE [dbo].[LocaisTramitacao_EMail] (
    [IdLocalTramEMail]  INT           IDENTITY (1, 1) NOT NULL,
    [IdLocalTramitacao] INT           NOT NULL,
    [DestinatarioNome]  VARCHAR (80)  CONSTRAINT [DF_LocaisTramitacao_EMail_Nome] DEFAULT ('') NULL,
    [DestinatarioEMail] VARCHAR (250) CONSTRAINT [DF_LocaisTramitacao_EMail_EMail] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_LocaisTramitacao_EMail] PRIMARY KEY CLUSTERED ([IdLocalTramEMail] ASC),
    CONSTRAINT [FK_LocaisTramitacao_EMail_LocaisTramitacao] FOREIGN KEY ([IdLocalTramitacao]) REFERENCES [dbo].[LocaisTramitacao] ([IdLocalTramitacao])
);


GO
CREATE TRIGGER [TrgLog_LocaisTramitacao_EMail] ON [Implanta_CRPAM].[dbo].[LocaisTramitacao_EMail] 
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
SET @TableName = 'LocaisTramitacao_EMail'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLocalTramEMail : «' + RTRIM( ISNULL( CAST (IdLocalTramEMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatarioNome : «' + RTRIM( ISNULL( CAST (DestinatarioNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatarioEMail : «' + RTRIM( ISNULL( CAST (DestinatarioEMail AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLocalTramEMail : «' + RTRIM( ISNULL( CAST (IdLocalTramEMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatarioNome : «' + RTRIM( ISNULL( CAST (DestinatarioNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatarioEMail : «' + RTRIM( ISNULL( CAST (DestinatarioEMail AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLocalTramEMail : «' + RTRIM( ISNULL( CAST (IdLocalTramEMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatarioNome : «' + RTRIM( ISNULL( CAST (DestinatarioNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatarioEMail : «' + RTRIM( ISNULL( CAST (DestinatarioEMail AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLocalTramEMail : «' + RTRIM( ISNULL( CAST (IdLocalTramEMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatarioNome : «' + RTRIM( ISNULL( CAST (DestinatarioNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DestinatarioEMail : «' + RTRIM( ISNULL( CAST (DestinatarioEMail AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
