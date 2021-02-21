CREATE TABLE [dbo].[AcomodacoesHoteis] (
    [IdAcomodacaoHotel] INT   IDENTITY (1, 1) NOT NULL,
    [IdPessoa]          INT   NOT NULL,
    [ValorAcomodacao]   MONEY NULL,
    [IdAcomodacao]      INT   NULL,
    CONSTRAINT [PK_AcomodacoesHoteis] PRIMARY KEY CLUSTERED ([IdAcomodacaoHotel] ASC),
    CONSTRAINT [FK_AcomodacoesHoteis_Acomodacoes] FOREIGN KEY ([IdAcomodacao]) REFERENCES [dbo].[Acomodacoes] ([IdAcomodacao]),
    CONSTRAINT [FK_AcomodacoesHoteis_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
CREATE TRIGGER [TrgLog_AcomodacoesHoteis] ON [Implanta_CRPAM].[dbo].[AcomodacoesHoteis] 
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
SET @TableName = 'AcomodacoesHoteis'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAcomodacaoHotel : «' + RTRIM( ISNULL( CAST (IdAcomodacaoHotel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcomodacao : «' + RTRIM( ISNULL( CAST (ValorAcomodacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcomodacao : «' + RTRIM( ISNULL( CAST (IdAcomodacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAcomodacaoHotel : «' + RTRIM( ISNULL( CAST (IdAcomodacaoHotel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcomodacao : «' + RTRIM( ISNULL( CAST (ValorAcomodacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcomodacao : «' + RTRIM( ISNULL( CAST (IdAcomodacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAcomodacaoHotel : «' + RTRIM( ISNULL( CAST (IdAcomodacaoHotel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcomodacao : «' + RTRIM( ISNULL( CAST (ValorAcomodacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcomodacao : «' + RTRIM( ISNULL( CAST (IdAcomodacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAcomodacaoHotel : «' + RTRIM( ISNULL( CAST (IdAcomodacaoHotel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcomodacao : «' + RTRIM( ISNULL( CAST (ValorAcomodacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcomodacao : «' + RTRIM( ISNULL( CAST (IdAcomodacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
