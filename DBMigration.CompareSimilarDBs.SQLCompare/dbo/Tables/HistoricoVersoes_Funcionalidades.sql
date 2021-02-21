CREATE TABLE [dbo].[HistoricoVersoes_Funcionalidades] (
    [IdHistoricoVersao]      INT  NOT NULL,
    [IdFuncionalidade]       INT  NOT NULL,
    [Correcoes]              TEXT NULL,
    [Implementacoes]         TEXT NULL,
    [CorrecoesImplanta]      TEXT NULL,
    [ImplementacoesImplanta] TEXT NULL,
    CONSTRAINT [PK_HistoricoSistemas_Funcionalidades] PRIMARY KEY CLUSTERED ([IdHistoricoVersao] ASC, [IdFuncionalidade] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_HistoricoVersoes_Funcionalidades_Funcionalidades] FOREIGN KEY ([IdFuncionalidade]) REFERENCES [dbo].[Funcionalidades] ([IdFuncionalidade]),
    CONSTRAINT [FK_HistoricoVersoes_Funcionalidades_HistoricoVersoes] FOREIGN KEY ([IdHistoricoVersao]) REFERENCES [dbo].[HistoricoVersoes] ([IdHistoricoVersao])
);


GO
CREATE TRIGGER [TrgLog_HistoricoVersoes_Funcionalidades] ON [Implanta_CRPAM].[dbo].[HistoricoVersoes_Funcionalidades] 
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
SET @TableName = 'HistoricoVersoes_Funcionalidades'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistoricoVersao : «' + RTRIM( ISNULL( CAST (IdHistoricoVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncionalidade : «' + RTRIM( ISNULL( CAST (IdFuncionalidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistoricoVersao : «' + RTRIM( ISNULL( CAST (IdHistoricoVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncionalidade : «' + RTRIM( ISNULL( CAST (IdFuncionalidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistoricoVersao : «' + RTRIM( ISNULL( CAST (IdHistoricoVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncionalidade : «' + RTRIM( ISNULL( CAST (IdFuncionalidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistoricoVersao : «' + RTRIM( ISNULL( CAST (IdHistoricoVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncionalidade : «' + RTRIM( ISNULL( CAST (IdFuncionalidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
