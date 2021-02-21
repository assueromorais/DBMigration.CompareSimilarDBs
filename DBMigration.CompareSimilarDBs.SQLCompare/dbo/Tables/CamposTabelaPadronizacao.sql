CREATE TABLE [dbo].[CamposTabelaPadronizacao] (
    [IdCampoTabela]        INT           IDENTITY (1, 1) NOT NULL,
    [IdTabelaPadronizacao] INT           NOT NULL,
    [NomeCampo]            VARCHAR (100) NOT NULL,
    [NomeExibicao]         VARCHAR (100) NOT NULL,
    CONSTRAINT [Pk_CamposTabelaPadronizacao] PRIMARY KEY CLUSTERED ([IdCampoTabela] ASC),
    CONSTRAINT [FK_001] FOREIGN KEY ([IdTabelaPadronizacao]) REFERENCES [dbo].[TabelasPadronizacao] ([IdTabelaPadronizacao]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO
CREATE TRIGGER [TrgLog_CamposTabelaPadronizacao] ON [Implanta_CRPAM].[dbo].[CamposTabelaPadronizacao] 
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
SET @TableName = 'CamposTabelaPadronizacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCampoTabela : «' + RTRIM( ISNULL( CAST (IdCampoTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabelaPadronizacao : «' + RTRIM( ISNULL( CAST (IdTabelaPadronizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeExibicao : «' + RTRIM( ISNULL( CAST (NomeExibicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCampoTabela : «' + RTRIM( ISNULL( CAST (IdCampoTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabelaPadronizacao : «' + RTRIM( ISNULL( CAST (IdTabelaPadronizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeExibicao : «' + RTRIM( ISNULL( CAST (NomeExibicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCampoTabela : «' + RTRIM( ISNULL( CAST (IdCampoTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabelaPadronizacao : «' + RTRIM( ISNULL( CAST (IdTabelaPadronizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeExibicao : «' + RTRIM( ISNULL( CAST (NomeExibicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCampoTabela : «' + RTRIM( ISNULL( CAST (IdCampoTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabelaPadronizacao : «' + RTRIM( ISNULL( CAST (IdTabelaPadronizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeExibicao : «' + RTRIM( ISNULL( CAST (NomeExibicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
