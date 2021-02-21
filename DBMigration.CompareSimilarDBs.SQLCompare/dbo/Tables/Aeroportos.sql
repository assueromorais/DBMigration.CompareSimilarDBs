CREATE TABLE [dbo].[Aeroportos] (
    [IdPessoaAeroporto] INT          IDENTITY (1, 1) NOT NULL,
    [IdPessoa]          INT          NOT NULL,
    [SiglaAeroporto]    VARCHAR (10) NULL,
    [ICAO]              VARCHAR (10) NULL,
    CONSTRAINT [PK_Aeroportos] PRIMARY KEY CLUSTERED ([IdPessoaAeroporto] ASC),
    CONSTRAINT [FK_Aeroportos_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
CREATE TRIGGER [TrgLog_Aeroportos] ON [Implanta_CRPAM].[dbo].[Aeroportos] 
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
SET @TableName = 'Aeroportos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdPessoaAeroporto : «' + RTRIM( ISNULL( CAST (IdPessoaAeroporto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaAeroporto : «' + RTRIM( ISNULL( CAST (SiglaAeroporto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ICAO : «' + RTRIM( ISNULL( CAST (ICAO AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdPessoaAeroporto : «' + RTRIM( ISNULL( CAST (IdPessoaAeroporto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaAeroporto : «' + RTRIM( ISNULL( CAST (SiglaAeroporto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ICAO : «' + RTRIM( ISNULL( CAST (ICAO AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdPessoaAeroporto : «' + RTRIM( ISNULL( CAST (IdPessoaAeroporto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaAeroporto : «' + RTRIM( ISNULL( CAST (SiglaAeroporto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ICAO : «' + RTRIM( ISNULL( CAST (ICAO AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdPessoaAeroporto : «' + RTRIM( ISNULL( CAST (IdPessoaAeroporto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaAeroporto : «' + RTRIM( ISNULL( CAST (SiglaAeroporto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ICAO : «' + RTRIM( ISNULL( CAST (ICAO AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
