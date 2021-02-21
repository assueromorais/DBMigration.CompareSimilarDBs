CREATE TABLE [dbo].[DigitalizacoesSispad] (
    [IdDigitalizacoesSispad]   INT IDENTITY (1, 1) NOT NULL,
    [IdSolicitacaoViagem]      INT NOT NULL,
    [IdControleDigitalizacoes] INT NOT NULL,
    CONSTRAINT [PK_DigitalizacoesSispad] PRIMARY KEY CLUSTERED ([IdDigitalizacoesSispad] ASC),
    CONSTRAINT [FK_DigitalizacoesSispad_ControleDigitalizacoes] FOREIGN KEY ([IdControleDigitalizacoes]) REFERENCES [dbo].[ControleDigitalizacoes] ([IdControleDigitalizacoes]),
    CONSTRAINT [FK_DigitalizacoesSispad_SolicitacoesViagem] FOREIGN KEY ([IdSolicitacaoViagem]) REFERENCES [dbo].[SolicitacoesViagem] ([IdSolicitacaoViagem])
);


GO
CREATE TRIGGER [TrgLog_DigitalizacoesSispad] ON [Implanta_CRPAM].[dbo].[DigitalizacoesSispad] 
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
SET @TableName = 'DigitalizacoesSispad'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDigitalizacoesSispad : «' + RTRIM( ISNULL( CAST (IdDigitalizacoesSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDigitalizacoesSispad : «' + RTRIM( ISNULL( CAST (IdDigitalizacoesSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdDigitalizacoesSispad : «' + RTRIM( ISNULL( CAST (IdDigitalizacoesSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDigitalizacoesSispad : «' + RTRIM( ISNULL( CAST (IdDigitalizacoesSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
