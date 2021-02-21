CREATE TABLE [dbo].[DetalhesGrade] (
    [IdDetalhesGrade]    INT IDENTITY (1, 1) NOT NULL,
    [IdProcesso_Prof_PJ] INT NOT NULL,
    [IdPessoa]           INT NULL,
    [IdProfissional]     INT NULL,
    [IdPessoaJuridica]   INT NULL,
    CONSTRAINT [PK_DetalhesGrade] PRIMARY KEY CLUSTERED ([IdDetalhesGrade] ASC),
    CONSTRAINT [FK_DetalhesGrade_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_DetalhesGrade_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_DetalhesGrade_Processos_Prof_PJ] FOREIGN KEY ([IdProcesso_Prof_PJ]) REFERENCES [dbo].[Processos_Prof_PJ] ([IdProcessos_Prof_PJ]),
    CONSTRAINT [FK_DetalhesGrade_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_DetalhesGrade] ON [Implanta_CRPAM].[dbo].[DetalhesGrade] 
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
SET @TableName = 'DetalhesGrade'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDetalhesGrade : «' + RTRIM( ISNULL( CAST (IdDetalhesGrade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso_Prof_PJ : «' + RTRIM( ISNULL( CAST (IdProcesso_Prof_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDetalhesGrade : «' + RTRIM( ISNULL( CAST (IdDetalhesGrade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso_Prof_PJ : «' + RTRIM( ISNULL( CAST (IdProcesso_Prof_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDetalhesGrade : «' + RTRIM( ISNULL( CAST (IdDetalhesGrade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso_Prof_PJ : «' + RTRIM( ISNULL( CAST (IdProcesso_Prof_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDetalhesGrade : «' + RTRIM( ISNULL( CAST (IdDetalhesGrade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso_Prof_PJ : «' + RTRIM( ISNULL( CAST (IdProcesso_Prof_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
