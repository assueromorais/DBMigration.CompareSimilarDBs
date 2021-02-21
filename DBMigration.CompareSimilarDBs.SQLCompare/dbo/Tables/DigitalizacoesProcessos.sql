CREATE TABLE [dbo].[DigitalizacoesProcessos] (
    [IdDigitalizacaoProcesso]  INT IDENTITY (1, 1) NOT NULL,
    [IdProcesso]               INT NOT NULL,
    [IdControleDigitalizacoes] INT NOT NULL,
    CONSTRAINT [PK_DigitalizacoesProcesso] PRIMARY KEY CLUSTERED ([IdDigitalizacaoProcesso] ASC),
    CONSTRAINT [FK_DigitalizacoesProcessos_IdControleDigitalizacoes] FOREIGN KEY ([IdControleDigitalizacoes]) REFERENCES [dbo].[ControleDigitalizacoes] ([IdControleDigitalizacoes]),
    CONSTRAINT [FK_DigitalizacoesProcessos_IdProcesso] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso])
);


GO
CREATE TRIGGER [TrgLog_DigitalizacoesProcessos] ON [Implanta_CRPAM].[dbo].[DigitalizacoesProcessos] 
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
SET @TableName = 'DigitalizacoesProcessos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDigitalizacaoProcesso : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDigitalizacaoProcesso : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdDigitalizacaoProcesso : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDigitalizacaoProcesso : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
