CREATE TABLE [dbo].[ItensProvidenciar] (
    [IdItemProvidenciar]          INT IDENTITY (1, 1) NOT NULL,
    [IdProcessoSolicitacaoViagem] INT NOT NULL,
    [IdTipoDespesa]               INT NOT NULL,
    CONSTRAINT [PK_ItensProvidenciar] PRIMARY KEY CLUSTERED ([IdItemProvidenciar] ASC),
    CONSTRAINT [FK_ItensProvidenciar_ProcessosSolicitacaoViagem] FOREIGN KEY ([IdProcessoSolicitacaoViagem]) REFERENCES [dbo].[ProcessosSolicitacaoViagem] ([IdProcessoSolicitacaoViagem]),
    CONSTRAINT [FK_ItensProvidenciar_TiposDespesas] FOREIGN KEY ([IdTipoDespesa]) REFERENCES [dbo].[TiposDespesas] ([IdTipoDespesa])
);


GO
CREATE TRIGGER [TrgLog_ItensProvidenciar] ON [Implanta_CRPAM].[dbo].[ItensProvidenciar] 
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
SET @TableName = 'ItensProvidenciar'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItemProvidenciar : «' + RTRIM( ISNULL( CAST (IdItemProvidenciar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItemProvidenciar : «' + RTRIM( ISNULL( CAST (IdItemProvidenciar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItemProvidenciar : «' + RTRIM( ISNULL( CAST (IdItemProvidenciar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItemProvidenciar : «' + RTRIM( ISNULL( CAST (IdItemProvidenciar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
