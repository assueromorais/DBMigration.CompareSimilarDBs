CREATE TABLE [dbo].[Fiscalizacoes_OLD] (
    [IdFiscalizacao]     INT NULL,
    [IdProcesso]         INT NULL,
    [IdFiscal]           INT NULL,
    [IdFiscalPessoa]     INT NULL,
    [NumeroFiscalizacao] INT NULL,
    [IdCidade]           INT NULL,
    [IdCidade1]          INT NULL,
    [IdCidade2]          INT NULL
);


GO
CREATE TRIGGER [TrgLog_Fiscalizacoes_OLD] ON [Implanta_CRPAM].[dbo].[Fiscalizacoes_OLD] 
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
SET @TableName = 'Fiscalizacoes_OLD'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscal : «' + RTRIM( ISNULL( CAST (IdFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalPessoa : «' + RTRIM( ISNULL( CAST (IdFiscalPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFiscalizacao : «' + RTRIM( ISNULL( CAST (NumeroFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade1 : «' + RTRIM( ISNULL( CAST (IdCidade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade2 : «' + RTRIM( ISNULL( CAST (IdCidade2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscal : «' + RTRIM( ISNULL( CAST (IdFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalPessoa : «' + RTRIM( ISNULL( CAST (IdFiscalPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFiscalizacao : «' + RTRIM( ISNULL( CAST (NumeroFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade1 : «' + RTRIM( ISNULL( CAST (IdCidade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade2 : «' + RTRIM( ISNULL( CAST (IdCidade2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscal : «' + RTRIM( ISNULL( CAST (IdFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalPessoa : «' + RTRIM( ISNULL( CAST (IdFiscalPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFiscalizacao : «' + RTRIM( ISNULL( CAST (NumeroFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade1 : «' + RTRIM( ISNULL( CAST (IdCidade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade2 : «' + RTRIM( ISNULL( CAST (IdCidade2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscal : «' + RTRIM( ISNULL( CAST (IdFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalPessoa : «' + RTRIM( ISNULL( CAST (IdFiscalPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFiscalizacao : «' + RTRIM( ISNULL( CAST (NumeroFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade1 : «' + RTRIM( ISNULL( CAST (IdCidade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade2 : «' + RTRIM( ISNULL( CAST (IdCidade2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
