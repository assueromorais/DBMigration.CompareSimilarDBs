CREATE TABLE [dbo].[HistArqEleicaoProfMotivo] (
    [IdHistArqEleicaoProfMotivo] INT            IDENTITY (1, 1) NOT NULL,
    [IdHistArqEleicaoProf]       INT            NULL,
    [Motivo]                     INT            NULL,
    [Descricao]                  VARCHAR (1000) NULL,
    CONSTRAINT [PK_HistArqEleicaoProfMotivo_IdHistArqEleicaoProfMotivo] PRIMARY KEY CLUSTERED ([IdHistArqEleicaoProfMotivo] ASC),
    CONSTRAINT [FK_HistArqEleicaoProfMotivo_HistArqEleicaoProf] FOREIGN KEY ([IdHistArqEleicaoProf]) REFERENCES [dbo].[HistArqEleicaoProf] ([IdHistArqEleicaoProf])
);


GO
CREATE TRIGGER [TrgLog_HistArqEleicaoProfMotivo] ON [Implanta_CRPAM].[dbo].[HistArqEleicaoProfMotivo] 
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
SET @TableName = 'HistArqEleicaoProfMotivo'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistArqEleicaoProfMotivo : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProfMotivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdHistArqEleicaoProf : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistArqEleicaoProfMotivo : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProfMotivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdHistArqEleicaoProf : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistArqEleicaoProfMotivo : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProfMotivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdHistArqEleicaoProf : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistArqEleicaoProfMotivo : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProfMotivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdHistArqEleicaoProf : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
