CREATE TABLE [dbo].[LivrosPJ] (
    [IdLivroPJ]        INT          IDENTITY (1, 1) NOT NULL,
    [Numero]           VARCHAR (20) NOT NULL,
    [Ano]              INT          NOT NULL,
    [IdTipoLivroPJ]    INT          NOT NULL,
    [IdPessoaJuridica] INT          NOT NULL,
    CONSTRAINT [PK_LivrosPJ] PRIMARY KEY CLUSTERED ([IdLivroPJ] ASC),
    CONSTRAINT [FK_LivrosPJ_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_LivrosPJ_TiposLivroPJ] FOREIGN KEY ([IdTipoLivroPJ]) REFERENCES [dbo].[TiposLivroPJ] ([IdTipoLivroPJ])
);


GO
CREATE TRIGGER [TrgLog_LivrosPJ] ON [Implanta_CRPAM].[dbo].[LivrosPJ] 
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
SET @TableName = 'LivrosPJ'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLivroPJ : «' + RTRIM( ISNULL( CAST (IdLivroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ano : «' + RTRIM( ISNULL( CAST (Ano AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoLivroPJ : «' + RTRIM( ISNULL( CAST (IdTipoLivroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLivroPJ : «' + RTRIM( ISNULL( CAST (IdLivroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ano : «' + RTRIM( ISNULL( CAST (Ano AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoLivroPJ : «' + RTRIM( ISNULL( CAST (IdTipoLivroPJ AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdLivroPJ : «' + RTRIM( ISNULL( CAST (IdLivroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ano : «' + RTRIM( ISNULL( CAST (Ano AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoLivroPJ : «' + RTRIM( ISNULL( CAST (IdTipoLivroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLivroPJ : «' + RTRIM( ISNULL( CAST (IdLivroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ano : «' + RTRIM( ISNULL( CAST (Ano AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoLivroPJ : «' + RTRIM( ISNULL( CAST (IdTipoLivroPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
