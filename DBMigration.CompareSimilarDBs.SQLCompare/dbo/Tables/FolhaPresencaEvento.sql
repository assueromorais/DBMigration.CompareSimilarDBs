CREATE TABLE [dbo].[FolhaPresencaEvento] (
    [IdFolhaPresenca]           INT          IDENTITY (1, 1) NOT NULL,
    [IdEvento]                  INT          NOT NULL,
    [IdPessoaSolicitacaoViagem] INT          NOT NULL,
    [DataPresenca]              DATETIME     NOT NULL,
    [TipoPresenca]              VARCHAR (20) NOT NULL,
    [ObservacaoPresenca]        TEXT         NULL,
    CONSTRAINT [PK_FolhaPresencaEvento] PRIMARY KEY CLUSTERED ([IdFolhaPresenca] ASC),
    CONSTRAINT [FK_FolhaPresencaEvento_EventosSispad] FOREIGN KEY ([IdEvento]) REFERENCES [dbo].[EventosSispad] ([IdEvento]),
    CONSTRAINT [FK_FolhaPresencaEvento_PessoasSolicitacoesViagem] FOREIGN KEY ([IdPessoaSolicitacaoViagem]) REFERENCES [dbo].[PessoasSolicitacoesViagem] ([IdPessoaSolicitacaoViagem])
);


GO
CREATE TRIGGER [TrgLog_FolhaPresencaEvento] ON [Implanta_CRPAM].[dbo].[FolhaPresencaEvento] 
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
SET @TableName = 'FolhaPresencaEvento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFolhaPresenca : «' + RTRIM( ISNULL( CAST (IdFolhaPresenca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPresenca : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPresenca, 113 ),'Nulo'))+'» '
                         + '| TipoPresenca : «' + RTRIM( ISNULL( CAST (TipoPresenca AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFolhaPresenca : «' + RTRIM( ISNULL( CAST (IdFolhaPresenca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPresenca : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPresenca, 113 ),'Nulo'))+'» '
                         + '| TipoPresenca : «' + RTRIM( ISNULL( CAST (TipoPresenca AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdFolhaPresenca : «' + RTRIM( ISNULL( CAST (IdFolhaPresenca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPresenca : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPresenca, 113 ),'Nulo'))+'» '
                         + '| TipoPresenca : «' + RTRIM( ISNULL( CAST (TipoPresenca AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFolhaPresenca : «' + RTRIM( ISNULL( CAST (IdFolhaPresenca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPresenca : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPresenca, 113 ),'Nulo'))+'» '
                         + '| TipoPresenca : «' + RTRIM( ISNULL( CAST (TipoPresenca AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
