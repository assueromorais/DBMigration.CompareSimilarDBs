CREATE TABLE [dbo].[Fiscalizacoes_FiscalizacoesLista1] (
    [IdFiscalizacoes_FiscalizacoesLista1] INT IDENTITY (1, 1) NOT NULL,
    [IdFiscalizacao]                      INT NOT NULL,
    [IdFiscalizacaoLista1]                INT NOT NULL,
    CONSTRAINT [PK_Fiscalizacoes_FiscalizacoesLista1] PRIMARY KEY CLUSTERED ([IdFiscalizacoes_FiscalizacoesLista1] ASC),
    CONSTRAINT [FK_Fiscalizacoes_FiscalizacoesLista1_Fiscalizacoes] FOREIGN KEY ([IdFiscalizacao]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao]),
    CONSTRAINT [FK_Fiscalizacoes_FiscalizacoesLista1_FiscalizacoesLista1] FOREIGN KEY ([IdFiscalizacaoLista1]) REFERENCES [dbo].[FiscalizacoesLista1] ([IdFiscalizacaoLista1])
);


GO
CREATE TRIGGER [TrgLog_Fiscalizacoes_FiscalizacoesLista1] ON [Implanta_CRPAM].[dbo].[Fiscalizacoes_FiscalizacoesLista1] 
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
SET @TableName = 'Fiscalizacoes_FiscalizacoesLista1'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFiscalizacoes_FiscalizacoesLista1 : «' + RTRIM( ISNULL( CAST (IdFiscalizacoes_FiscalizacoesLista1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacaoLista1 : «' + RTRIM( ISNULL( CAST (IdFiscalizacaoLista1 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFiscalizacoes_FiscalizacoesLista1 : «' + RTRIM( ISNULL( CAST (IdFiscalizacoes_FiscalizacoesLista1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacaoLista1 : «' + RTRIM( ISNULL( CAST (IdFiscalizacaoLista1 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdFiscalizacoes_FiscalizacoesLista1 : «' + RTRIM( ISNULL( CAST (IdFiscalizacoes_FiscalizacoesLista1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacaoLista1 : «' + RTRIM( ISNULL( CAST (IdFiscalizacaoLista1 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFiscalizacoes_FiscalizacoesLista1 : «' + RTRIM( ISNULL( CAST (IdFiscalizacoes_FiscalizacoesLista1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacaoLista1 : «' + RTRIM( ISNULL( CAST (IdFiscalizacaoLista1 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
