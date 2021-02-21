CREATE TABLE [dbo].[ParametrosContabeis] (
    [IdParametroContabil] INT          IDENTITY (1, 1) NOT NULL,
    [Evento]              VARCHAR (1)  NOT NULL,
    [TipoPessoa]          INT          NOT NULL,
    [Classificacao]       INT          NOT NULL,
    [IdTipoDebito]        INT          NOT NULL,
    [IdBancoSiscafw]      INT          NULL,
    [CodAgencia]          VARCHAR (4)  NULL,
    [CodOperacao]         VARCHAR (3)  NULL,
    [CodCC_Conv_Ced]      VARCHAR (16) NULL,
    CONSTRAINT [PK_ParametrosContabeis] PRIMARY KEY CLUSTERED ([IdParametroContabil] ASC),
    CONSTRAINT [FK_ParametrosContabeis_BancosSiscafw] FOREIGN KEY ([IdBancoSiscafw]) REFERENCES [dbo].[BancosSiscafw] ([IdBancoSiscafw]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ParametrosContabeis_TiposDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[ParametrosContabeis] NOCHECK CONSTRAINT [FK_ParametrosContabeis_BancosSiscafw];


GO
CREATE TRIGGER [TrgLog_ParametrosContabeis] ON [Implanta_CRPAM].[dbo].[ParametrosContabeis] 
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
SET @TableName = 'ParametrosContabeis'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdParametroContabil : «' + RTRIM( ISNULL( CAST (IdParametroContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Classificacao : «' + RTRIM( ISNULL( CAST (Classificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdParametroContabil : «' + RTRIM( ISNULL( CAST (IdParametroContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Classificacao : «' + RTRIM( ISNULL( CAST (Classificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdParametroContabil : «' + RTRIM( ISNULL( CAST (IdParametroContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Classificacao : «' + RTRIM( ISNULL( CAST (Classificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdParametroContabil : «' + RTRIM( ISNULL( CAST (IdParametroContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Classificacao : «' + RTRIM( ISNULL( CAST (Classificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
