CREATE TABLE [dbo].[ListaProcessos] (
    [IdListaProcesso] INT        IDENTITY (1, 1) NOT NULL,
    [IdProcesso]      INT        NOT NULL,
    [IdItem]          INT        NULL,
    [IdServico]       INT        NULL,
    [Qtd]             FLOAT (53) NULL,
    [IdPessoa]        INT        NULL,
    [ExportadoWeb]    BIT        NOT NULL,
    [IdItemCompra]    INT        NULL,
    [ValorUnitario]   MONEY      NULL,
    [Desconto]        MONEY      NULL,
    [FreteValor]      MONEY      NULL,
    [ValorEstimado]   MONEY      NULL,
    CONSTRAINT [PK_ListaProcessos] PRIMARY KEY CLUSTERED ([IdListaProcesso] ASC),
    CONSTRAINT [FK_ListaProcessos_Itens] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[Itens] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ListaProcessos_ItensCompras] FOREIGN KEY ([IdItemCompra]) REFERENCES [dbo].[ItensCompras] ([IdItemCompra]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ListaProcessos_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ListaProcessos_ProcessosCompServ] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[ProcessosCompServ] ([IdProcesso]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ListaProcessos_Servicos] FOREIGN KEY ([IdServico]) REFERENCES [dbo].[Servicos] ([IdServico]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[ListaProcessos] NOCHECK CONSTRAINT [FK_ListaProcessos_Itens];


GO
ALTER TABLE [dbo].[ListaProcessos] NOCHECK CONSTRAINT [FK_ListaProcessos_ItensCompras];


GO
ALTER TABLE [dbo].[ListaProcessos] NOCHECK CONSTRAINT [FK_ListaProcessos_Pessoas];


GO
ALTER TABLE [dbo].[ListaProcessos] NOCHECK CONSTRAINT [FK_ListaProcessos_Servicos];


GO
CREATE TRIGGER [TrgLog_ListaProcessos] ON [Implanta_CRPAM].[dbo].[ListaProcessos] 
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
SET @TableName = 'ListaProcessos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdListaProcesso : «' + RTRIM( ISNULL( CAST (IdListaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExportadoWeb IS NULL THEN ' ExportadoWeb : «Nulo» '
                                              WHEN  ExportadoWeb = 0 THEN ' ExportadoWeb : «Falso» '
                                              WHEN  ExportadoWeb = 1 THEN ' ExportadoWeb : «Verdadeiro» '
                                    END 
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdListaProcesso : «' + RTRIM( ISNULL( CAST (IdListaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExportadoWeb IS NULL THEN ' ExportadoWeb : «Nulo» '
                                              WHEN  ExportadoWeb = 0 THEN ' ExportadoWeb : «Falso» '
                                              WHEN  ExportadoWeb = 1 THEN ' ExportadoWeb : «Verdadeiro» '
                                    END 
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdListaProcesso : «' + RTRIM( ISNULL( CAST (IdListaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExportadoWeb IS NULL THEN ' ExportadoWeb : «Nulo» '
                                              WHEN  ExportadoWeb = 0 THEN ' ExportadoWeb : «Falso» '
                                              WHEN  ExportadoWeb = 1 THEN ' ExportadoWeb : «Verdadeiro» '
                                    END 
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdListaProcesso : «' + RTRIM( ISNULL( CAST (IdListaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExportadoWeb IS NULL THEN ' ExportadoWeb : «Nulo» '
                                              WHEN  ExportadoWeb = 0 THEN ' ExportadoWeb : «Falso» '
                                              WHEN  ExportadoWeb = 1 THEN ' ExportadoWeb : «Verdadeiro» '
                                    END 
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
