CREATE TABLE [dbo].[GruposPessoasPessoas] (
    [IdGrupoPessoa]  INT NOT NULL,
    [IdPessoaSispad] INT NOT NULL,
    CONSTRAINT [PK_GruposPessoasPessoas] PRIMARY KEY CLUSTERED ([IdGrupoPessoa] ASC, [IdPessoaSispad] ASC),
    CONSTRAINT [FK_GruposPessoasPessoas_GruposPessoas] FOREIGN KEY ([IdGrupoPessoa]) REFERENCES [dbo].[GruposPessoas] ([IdGrupoPessoa]),
    CONSTRAINT [FK_GruposPessoasPessoas_PessoasSispad] FOREIGN KEY ([IdPessoaSispad]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad])
);


GO
CREATE TRIGGER [TrgLog_GruposPessoasPessoas] ON [Implanta_CRPAM].[dbo].[GruposPessoasPessoas] 
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
SET @TableName = 'GruposPessoasPessoas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdGrupoPessoa : «' + RTRIM( ISNULL( CAST (IdGrupoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdGrupoPessoa : «' + RTRIM( ISNULL( CAST (IdGrupoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdGrupoPessoa : «' + RTRIM( ISNULL( CAST (IdGrupoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdGrupoPessoa : «' + RTRIM( ISNULL( CAST (IdGrupoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
