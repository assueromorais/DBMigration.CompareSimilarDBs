CREATE TABLE [dbo].[ItensPrePedidos] (
    [IdItensPrePedidos] INT        IDENTITY (1, 1) NOT NULL,
    [IdPrePedido]       INT        NOT NULL,
    [IdItem]            INT        NOT NULL,
    [Qtd]               FLOAT (53) NULL,
    CONSTRAINT [PK_ItensPrePedidos] PRIMARY KEY NONCLUSTERED ([IdItensPrePedidos] ASC),
    CONSTRAINT [FK_ItensPrePedidos_Itens] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[Itens] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensPrePedidos_PrePedidos] FOREIGN KEY ([IdPrePedido]) REFERENCES [dbo].[PrePedidos] ([IdPrePedido]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ItensPrePedidos] ON [Implanta_CRPAM].[dbo].[ItensPrePedidos] 
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
SET @TableName = 'ItensPrePedidos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItensPrePedidos : «' + RTRIM( ISNULL( CAST (IdItensPrePedidos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPrePedido : «' + RTRIM( ISNULL( CAST (IdPrePedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItensPrePedidos : «' + RTRIM( ISNULL( CAST (IdItensPrePedidos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPrePedido : «' + RTRIM( ISNULL( CAST (IdPrePedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItensPrePedidos : «' + RTRIM( ISNULL( CAST (IdItensPrePedidos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPrePedido : «' + RTRIM( ISNULL( CAST (IdPrePedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItensPrePedidos : «' + RTRIM( ISNULL( CAST (IdItensPrePedidos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPrePedido : «' + RTRIM( ISNULL( CAST (IdPrePedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
