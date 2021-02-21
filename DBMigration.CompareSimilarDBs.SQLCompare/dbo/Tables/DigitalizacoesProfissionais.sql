CREATE TABLE [dbo].[DigitalizacoesProfissionais] (
    [IdDigitalizacaoProfissional] INT IDENTITY (1, 1) NOT NULL,
    [IdProfissional]              INT NOT NULL,
    [IdControleDigitalizacoes]    INT NOT NULL,
    CONSTRAINT [PK_DigitalizacoesProfissionais] PRIMARY KEY CLUSTERED ([IdDigitalizacaoProfissional] ASC),
    CONSTRAINT [FK_DigitalizacoesProfissionais_ControleDigitalizacoes] FOREIGN KEY ([IdControleDigitalizacoes]) REFERENCES [dbo].[ControleDigitalizacoes] ([IdControleDigitalizacoes]),
    CONSTRAINT [FK_DigitalizacoesProfissionais_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_DigitalizacoesProfissionais] ON [Implanta_CRPAM].[dbo].[DigitalizacoesProfissionais] 
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
SET @TableName = 'DigitalizacoesProfissionais'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDigitalizacaoProfissional : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDigitalizacaoProfissional : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDigitalizacaoProfissional : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDigitalizacaoProfissional : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
