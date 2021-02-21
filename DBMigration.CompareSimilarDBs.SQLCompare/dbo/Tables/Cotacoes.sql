CREATE TABLE [dbo].[Cotacoes] (
    [IdCotacao]        INT          IDENTITY (1, 1) NOT NULL,
    [IdListaProcesso]  INT          NOT NULL,
    [IdPessoa]         INT          NOT NULL,
    [DataCotacao]      DATETIME     NOT NULL,
    [QtdCotacao]       FLOAT (53)   NULL,
    [ValorCotacao]     MONEY        NOT NULL,
    [Condicoes]        TEXT         NULL,
    [Desconto]         MONEY        NULL,
    [PrazoEntrega]     VARCHAR (6)  NULL,
    [FormaPagamento]   VARCHAR (50) NULL,
    [ValidadeProposta] DATETIME     NULL,
    [Frete]            VARCHAR (50) NULL,
    [FreteValor]       MONEY        NULL,
    CONSTRAINT [PK_Cotacoes] PRIMARY KEY CLUSTERED ([IdCotacao] ASC),
    CONSTRAINT [FK_Cotacoes_ListaProcessos] FOREIGN KEY ([IdListaProcesso]) REFERENCES [dbo].[ListaProcessos] ([IdListaProcesso]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Cotacoes_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_Cotacoes] ON [Implanta_CRPAM].[dbo].[Cotacoes] 
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
SET @TableName = 'Cotacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCotacao : «' + RTRIM( ISNULL( CAST (IdCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdListaProcesso : «' + RTRIM( ISNULL( CAST (IdListaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCotacao, 113 ),'Nulo'))+'» '
                         + '| QtdCotacao : «' + RTRIM( ISNULL( CAST (QtdCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCotacao : «' + RTRIM( ISNULL( CAST (ValorCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoEntrega : «' + RTRIM( ISNULL( CAST (PrazoEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaPagamento : «' + RTRIM( ISNULL( CAST (FormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValidadeProposta : «' + RTRIM( ISNULL( CONVERT (CHAR, ValidadeProposta, 113 ),'Nulo'))+'» '
                         + '| Frete : «' + RTRIM( ISNULL( CAST (Frete AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCotacao : «' + RTRIM( ISNULL( CAST (IdCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdListaProcesso : «' + RTRIM( ISNULL( CAST (IdListaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCotacao, 113 ),'Nulo'))+'» '
                         + '| QtdCotacao : «' + RTRIM( ISNULL( CAST (QtdCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCotacao : «' + RTRIM( ISNULL( CAST (ValorCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoEntrega : «' + RTRIM( ISNULL( CAST (PrazoEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaPagamento : «' + RTRIM( ISNULL( CAST (FormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValidadeProposta : «' + RTRIM( ISNULL( CONVERT (CHAR, ValidadeProposta, 113 ),'Nulo'))+'» '
                         + '| Frete : «' + RTRIM( ISNULL( CAST (Frete AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCotacao : «' + RTRIM( ISNULL( CAST (IdCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdListaProcesso : «' + RTRIM( ISNULL( CAST (IdListaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCotacao, 113 ),'Nulo'))+'» '
                         + '| QtdCotacao : «' + RTRIM( ISNULL( CAST (QtdCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCotacao : «' + RTRIM( ISNULL( CAST (ValorCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoEntrega : «' + RTRIM( ISNULL( CAST (PrazoEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaPagamento : «' + RTRIM( ISNULL( CAST (FormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValidadeProposta : «' + RTRIM( ISNULL( CONVERT (CHAR, ValidadeProposta, 113 ),'Nulo'))+'» '
                         + '| Frete : «' + RTRIM( ISNULL( CAST (Frete AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCotacao : «' + RTRIM( ISNULL( CAST (IdCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdListaProcesso : «' + RTRIM( ISNULL( CAST (IdListaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCotacao, 113 ),'Nulo'))+'» '
                         + '| QtdCotacao : «' + RTRIM( ISNULL( CAST (QtdCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCotacao : «' + RTRIM( ISNULL( CAST (ValorCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoEntrega : «' + RTRIM( ISNULL( CAST (PrazoEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaPagamento : «' + RTRIM( ISNULL( CAST (FormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValidadeProposta : «' + RTRIM( ISNULL( CONVERT (CHAR, ValidadeProposta, 113 ),'Nulo'))+'» '
                         + '| Frete : «' + RTRIM( ISNULL( CAST (Frete AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
