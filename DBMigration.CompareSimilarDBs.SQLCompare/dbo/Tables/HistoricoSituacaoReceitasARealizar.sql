CREATE TABLE [dbo].[HistoricoSituacaoReceitasARealizar] (
    [IdHistoricoSituacao]  INT           IDENTITY (1, 1) NOT NULL,
    [IdReceitaARealizar]   INT           NULL,
    [Situacao]             VARCHAR (250) NULL,
    [Data]                 DATETIME      NULL,
    [IdUsuario]            INT           NULL,
    [IdControleArquivoCob] INT           NULL,
    CONSTRAINT [PK_HistoricoSituacaoReceitasARealizar] PRIMARY KEY CLUSTERED ([IdHistoricoSituacao] ASC),
    CONSTRAINT [FK_HistoricoSituacaoReceitasARealizar_ControleArquivosCobranca] FOREIGN KEY ([IdControleArquivoCob]) REFERENCES [dbo].[ControleArquivosCobranca] ([IdControleArquivoCob]),
    CONSTRAINT [FK_HistoricoSituacaoReceitasARealizar_ReceitasARealizar] FOREIGN KEY ([IdReceitaARealizar]) REFERENCES [dbo].[ReceitasARealizar] ([IdReceitaARealizar]),
    CONSTRAINT [FK_HistoricoSituacaoReceitasARealizar_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
CREATE TRIGGER [TrgLog_HistoricoSituacaoReceitasARealizar] ON [Implanta_CRPAM].[dbo].[HistoricoSituacaoReceitasARealizar] 
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
SET @TableName = 'HistoricoSituacaoReceitasARealizar'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistoricoSituacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceitaARealizar : «' + RTRIM( ISNULL( CAST (IdReceitaARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistoricoSituacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceitaARealizar : «' + RTRIM( ISNULL( CAST (IdReceitaARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistoricoSituacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceitaARealizar : «' + RTRIM( ISNULL( CAST (IdReceitaARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistoricoSituacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceitaARealizar : «' + RTRIM( ISNULL( CAST (IdReceitaARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
