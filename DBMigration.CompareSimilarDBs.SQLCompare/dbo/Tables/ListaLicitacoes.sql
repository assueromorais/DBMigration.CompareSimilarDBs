CREATE TABLE [dbo].[ListaLicitacoes] (
    [IdListaLicitacao] INT        IDENTITY (1, 1) NOT NULL,
    [IdLicitacao]      INT        NOT NULL,
    [IdProposta]       INT        NULL,
    [IdItem]           INT        NULL,
    [IdServico]        INT        NULL,
    [Qtd]              FLOAT (53) NULL,
    [IdItemCompra]     INT        NULL,
    [ValorEstimado]    MONEY      NULL,
    [IdOrdem]          INT        NULL,
    CONSTRAINT [PK_ListaLicitacoes] PRIMARY KEY CLUSTERED ([IdListaLicitacao] ASC),
    CONSTRAINT [FK_ListaLicitacoes_Itens] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[Itens] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ListaLicitacoes_ItensCompras] FOREIGN KEY ([IdItemCompra]) REFERENCES [dbo].[ItensCompras] ([IdItemCompra]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ListaLicitacoes_Licitacoes] FOREIGN KEY ([IdLicitacao]) REFERENCES [dbo].[Licitacoes] ([IdLicitacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ListaLicitacoes_Propostas] FOREIGN KEY ([IdProposta]) REFERENCES [dbo].[Propostas] ([IdProposta]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ListaLicitacoes_Servicos] FOREIGN KEY ([IdServico]) REFERENCES [dbo].[Servicos] ([IdServico]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[ListaLicitacoes] NOCHECK CONSTRAINT [FK_ListaLicitacoes_Itens];


GO
ALTER TABLE [dbo].[ListaLicitacoes] NOCHECK CONSTRAINT [FK_ListaLicitacoes_ItensCompras];


GO
ALTER TABLE [dbo].[ListaLicitacoes] NOCHECK CONSTRAINT [FK_ListaLicitacoes_Servicos];


GO
CREATE TRIGGER [TrgLog_ListaLicitacoes] ON [Implanta_CRPAM].[dbo].[ListaLicitacoes] 
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
SET @TableName = 'ListaLicitacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdListaLicitacao : «' + RTRIM( ISNULL( CAST (IdListaLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProposta : «' + RTRIM( ISNULL( CAST (IdProposta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdListaLicitacao : «' + RTRIM( ISNULL( CAST (IdListaLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProposta : «' + RTRIM( ISNULL( CAST (IdProposta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdListaLicitacao : «' + RTRIM( ISNULL( CAST (IdListaLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProposta : «' + RTRIM( ISNULL( CAST (IdProposta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdListaLicitacao : «' + RTRIM( ISNULL( CAST (IdListaLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProposta : «' + RTRIM( ISNULL( CAST (IdProposta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
