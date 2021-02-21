CREATE TABLE [dbo].[EmissoesIdentidadePFPJ] (
    [IdEmissaoIdentidadePFPJ] INT      IDENTITY (1, 1) NOT NULL,
    [IdTipoIdentidadePFPJ]    INT      NOT NULL,
    [IdProfissional]          INT      NULL,
    [IdPessoaJuridica]        INT      NULL,
    [NumeroVia]               INT      NOT NULL,
    [DataEmissao]             DATETIME NULL,
    [Conteudo]                TEXT     NULL,
    CONSTRAINT [PK_EmissoesIdentidadePFPJ] PRIMARY KEY CLUSTERED ([IdEmissaoIdentidadePFPJ] ASC),
    CONSTRAINT [FK_EmissoesIdentidadePFPJ_IdPessoaJuridica] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_EmissoesIdentidadePFPJ_IdProfissional] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_EmissoesIdentidadePFPJ_IdTipoIdentidadePFPJ] FOREIGN KEY ([IdTipoIdentidadePFPJ]) REFERENCES [dbo].[TiposIdentidadePFPJ] ([IdTipoIdentidadePFPJ])
);


GO
CREATE TRIGGER [TrgLog_EmissoesIdentidadePFPJ] ON [Implanta_CRPAM].[dbo].[EmissoesIdentidadePFPJ] 
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
SET @TableName = 'EmissoesIdentidadePFPJ'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEmissaoIdentidadePFPJ : «' + RTRIM( ISNULL( CAST (IdEmissaoIdentidadePFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoIdentidadePFPJ : «' + RTRIM( ISNULL( CAST (IdTipoIdentidadePFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroVia : «' + RTRIM( ISNULL( CAST (NumeroVia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEmissaoIdentidadePFPJ : «' + RTRIM( ISNULL( CAST (IdEmissaoIdentidadePFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoIdentidadePFPJ : «' + RTRIM( ISNULL( CAST (IdTipoIdentidadePFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroVia : «' + RTRIM( ISNULL( CAST (NumeroVia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEmissaoIdentidadePFPJ : «' + RTRIM( ISNULL( CAST (IdEmissaoIdentidadePFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoIdentidadePFPJ : «' + RTRIM( ISNULL( CAST (IdTipoIdentidadePFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroVia : «' + RTRIM( ISNULL( CAST (NumeroVia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEmissaoIdentidadePFPJ : «' + RTRIM( ISNULL( CAST (IdEmissaoIdentidadePFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoIdentidadePFPJ : «' + RTRIM( ISNULL( CAST (IdTipoIdentidadePFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroVia : «' + RTRIM( ISNULL( CAST (NumeroVia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
