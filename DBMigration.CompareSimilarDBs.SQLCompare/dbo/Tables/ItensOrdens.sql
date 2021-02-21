CREATE TABLE [dbo].[ItensOrdens] (
    [IdItensOrdem]  INT        IDENTITY (1, 1) NOT NULL,
    [IdOrdem]       INT        NOT NULL,
    [Qtd]           FLOAT (53) NULL,
    [ValorUnitario] MONEY      NULL,
    [IdSubItem]     INT        NOT NULL,
    [Desconto]      MONEY      NULL,
    [Detalhes]      TEXT       NULL,
    CONSTRAINT [PK_ItensOrdens] PRIMARY KEY NONCLUSTERED ([IdItensOrdem] ASC),
    CONSTRAINT [FK_ItensOrdens_Ordens] FOREIGN KEY ([IdOrdem]) REFERENCES [dbo].[Ordens] ([IdOrdem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensOrdens_SubItens] FOREIGN KEY ([IdSubItem]) REFERENCES [dbo].[SubItens] ([IdSubItem]) NOT FOR REPLICATION
);


GO
CREATE NONCLUSTERED INDEX [IX_ItensOrdensIdSubItemQtd]
    ON [dbo].[ItensOrdens]([IdSubItem] ASC, [Qtd] ASC);


GO
CREATE TRIGGER [TrgLog_ItensOrdens] ON [Implanta_CRPAM].[dbo].[ItensOrdens] 
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
SET @TableName = 'ItensOrdens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItensOrdem : «' + RTRIM( ISNULL( CAST (IdItensOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItensOrdem : «' + RTRIM( ISNULL( CAST (IdItensOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItensOrdem : «' + RTRIM( ISNULL( CAST (IdItensOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItensOrdem : «' + RTRIM( ISNULL( CAST (IdItensOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
