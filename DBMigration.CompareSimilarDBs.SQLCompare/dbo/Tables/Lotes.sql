CREATE TABLE [dbo].[Lotes] (
    [IdEleicao]          INT          NOT NULL,
    [NumeroLote]         VARCHAR (10) NOT NULL,
    [ModoVotacao]        CHAR (1)     NULL,
    [QuantVotosPrevista] INT          NULL,
    CONSTRAINT [PK_Lotes] PRIMARY KEY CLUSTERED ([IdEleicao] ASC, [NumeroLote] ASC)
);


GO
CREATE TRIGGER [TrgLog_Lotes] ON [Implanta_CRPAM].[dbo].[Lotes] 
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
SET @TableName = 'Lotes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLote : «' + RTRIM( ISNULL( CAST (NumeroLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ModoVotacao : «' + RTRIM( ISNULL( CAST (ModoVotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantVotosPrevista : «' + RTRIM( ISNULL( CAST (QuantVotosPrevista AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLote : «' + RTRIM( ISNULL( CAST (NumeroLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ModoVotacao : «' + RTRIM( ISNULL( CAST (ModoVotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantVotosPrevista : «' + RTRIM( ISNULL( CAST (QuantVotosPrevista AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLote : «' + RTRIM( ISNULL( CAST (NumeroLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ModoVotacao : «' + RTRIM( ISNULL( CAST (ModoVotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantVotosPrevista : «' + RTRIM( ISNULL( CAST (QuantVotosPrevista AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLote : «' + RTRIM( ISNULL( CAST (NumeroLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ModoVotacao : «' + RTRIM( ISNULL( CAST (ModoVotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantVotosPrevista : «' + RTRIM( ISNULL( CAST (QuantVotosPrevista AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
