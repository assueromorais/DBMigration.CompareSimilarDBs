CREATE TABLE [dbo].[ArquivoTREProfissionais] (
    [IdArquivoTREProfissionais] INT          IDENTITY (1, 1) NOT NULL,
    [NomeProfissional]          VARCHAR (50) NULL,
    [IdProfissional]            INT          NULL,
    [RegistroProfissional]      VARCHAR (20) NULL,
    [RegistroConvertido]        INT          NULL,
    [CPF]                       VARCHAR (11) NULL,
    [SituacaoAtual]             VARCHAR (50) NULL,
    [Zona]                      INT          NULL,
    [Secao]                     INT          NULL,
    [IdSubRegiao]               INT          NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_ArquivoTREProfissionaisIdSubRegiao]
    ON [dbo].[ArquivoTREProfissionais]([IdSubRegiao] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ArquivoTREProfissionaisSecao]
    ON [dbo].[ArquivoTREProfissionais]([Secao] ASC);


GO
CREATE TRIGGER [TrgLog_ArquivoTREProfissionais] ON [Implanta_CRPAM].[dbo].[ArquivoTREProfissionais] 
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
SET @TableName = 'ArquivoTREProfissionais'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoTREProfissionais : «' + RTRIM( ISNULL( CAST (IdArquivoTREProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeProfissional : «' + RTRIM( ISNULL( CAST (NomeProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroProfissional : «' + RTRIM( ISNULL( CAST (RegistroProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConvertido : «' + RTRIM( ISNULL( CAST (RegistroConvertido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoAtual : «' + RTRIM( ISNULL( CAST (SituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Zona : «' + RTRIM( ISNULL( CAST (Zona AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Secao : «' + RTRIM( ISNULL( CAST (Secao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubRegiao : «' + RTRIM( ISNULL( CAST (IdSubRegiao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoTREProfissionais : «' + RTRIM( ISNULL( CAST (IdArquivoTREProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeProfissional : «' + RTRIM( ISNULL( CAST (NomeProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroProfissional : «' + RTRIM( ISNULL( CAST (RegistroProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConvertido : «' + RTRIM( ISNULL( CAST (RegistroConvertido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoAtual : «' + RTRIM( ISNULL( CAST (SituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Zona : «' + RTRIM( ISNULL( CAST (Zona AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Secao : «' + RTRIM( ISNULL( CAST (Secao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubRegiao : «' + RTRIM( ISNULL( CAST (IdSubRegiao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArquivoTREProfissionais : «' + RTRIM( ISNULL( CAST (IdArquivoTREProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeProfissional : «' + RTRIM( ISNULL( CAST (NomeProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroProfissional : «' + RTRIM( ISNULL( CAST (RegistroProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConvertido : «' + RTRIM( ISNULL( CAST (RegistroConvertido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoAtual : «' + RTRIM( ISNULL( CAST (SituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Zona : «' + RTRIM( ISNULL( CAST (Zona AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Secao : «' + RTRIM( ISNULL( CAST (Secao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubRegiao : «' + RTRIM( ISNULL( CAST (IdSubRegiao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoTREProfissionais : «' + RTRIM( ISNULL( CAST (IdArquivoTREProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeProfissional : «' + RTRIM( ISNULL( CAST (NomeProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroProfissional : «' + RTRIM( ISNULL( CAST (RegistroProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConvertido : «' + RTRIM( ISNULL( CAST (RegistroConvertido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoAtual : «' + RTRIM( ISNULL( CAST (SituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Zona : «' + RTRIM( ISNULL( CAST (Zona AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Secao : «' + RTRIM( ISNULL( CAST (Secao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubRegiao : «' + RTRIM( ISNULL( CAST (IdSubRegiao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
