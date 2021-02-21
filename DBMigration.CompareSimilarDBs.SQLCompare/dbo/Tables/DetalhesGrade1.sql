CREATE TABLE [dbo].[DetalhesGrade1] (
    [IdDetalhesGrade1]           INT IDENTITY (1, 1) NOT NULL,
    [IdProcesso_Prof_PJ_Pessoa1] INT NOT NULL,
    [IdPessoa]                   INT NULL,
    [IdProfissional]             INT NULL,
    [IdPessoaJuridica]           INT NULL,
    CONSTRAINT [PK_DetalhesGrade1] PRIMARY KEY CLUSTERED ([IdDetalhesGrade1] ASC),
    CONSTRAINT [FK_DetalhesGrade1_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_DetalhesGrade1_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_DetalhesGrade1_Processos_Prof_PJ_Pessoas1] FOREIGN KEY ([IdProcesso_Prof_PJ_Pessoa1]) REFERENCES [dbo].[Processos_Prof_PJ_Pessoas1] ([IdProcessos_Prof_PJ_Pessoa1]),
    CONSTRAINT [FK_DetalhesGrade1_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_DetalhesGrade1] ON [Implanta_CRPAM].[dbo].[DetalhesGrade1] 
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
SET @TableName = 'DetalhesGrade1'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDetalhesGrade1 : «' + RTRIM( ISNULL( CAST (IdDetalhesGrade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso_Prof_PJ_Pessoa1 : «' + RTRIM( ISNULL( CAST (IdProcesso_Prof_PJ_Pessoa1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDetalhesGrade1 : «' + RTRIM( ISNULL( CAST (IdDetalhesGrade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso_Prof_PJ_Pessoa1 : «' + RTRIM( ISNULL( CAST (IdProcesso_Prof_PJ_Pessoa1 AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdDetalhesGrade1 : «' + RTRIM( ISNULL( CAST (IdDetalhesGrade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso_Prof_PJ_Pessoa1 : «' + RTRIM( ISNULL( CAST (IdProcesso_Prof_PJ_Pessoa1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDetalhesGrade1 : «' + RTRIM( ISNULL( CAST (IdDetalhesGrade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso_Prof_PJ_Pessoa1 : «' + RTRIM( ISNULL( CAST (IdProcesso_Prof_PJ_Pessoa1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
