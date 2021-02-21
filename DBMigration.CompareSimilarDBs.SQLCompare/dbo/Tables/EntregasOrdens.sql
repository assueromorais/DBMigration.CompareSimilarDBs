CREATE TABLE [dbo].[EntregasOrdens] (
    [IdEntregasOrdem]    INT        IDENTITY (1, 1) NOT NULL,
    [IdOrdem]            INT        NOT NULL,
    [IdMovimentacaoItem] INT        NOT NULL,
    [IdMedidaEntrega]    INT        NOT NULL,
    [QtdMedidaEntrega]   FLOAT (53) NULL,
    [ValorUnitario]      MONEY      NOT NULL,
    [ValorNota]          MONEY      NOT NULL,
    [ValorReferencia]    MONEY      NOT NULL,
    [DataReferencia]     DATETIME   NOT NULL,
    [DataValidade]       DATETIME   NULL,
    [IdSubItem]          INT        NOT NULL,
    CONSTRAINT [PK_EntregasOrdens] PRIMARY KEY NONCLUSTERED ([IdEntregasOrdem] ASC),
    CONSTRAINT [FK_EntregasOrdens_Medidas] FOREIGN KEY ([IdMedidaEntrega]) REFERENCES [dbo].[Medidas] ([IdMedida]) NOT FOR REPLICATION,
    CONSTRAINT [FK_EntregasOrdens_MovimentacoesItens] FOREIGN KEY ([IdMovimentacaoItem]) REFERENCES [dbo].[MovimentacoesItens] ([IdMovimentacaoItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_EntregasOrdens_Ordens] FOREIGN KEY ([IdOrdem]) REFERENCES [dbo].[Ordens] ([IdOrdem]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_EntregasOrdens] ON [Implanta_CRPAM].[dbo].[EntregasOrdens] 
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
SET @TableName = 'EntregasOrdens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEntregasOrdem : «' + RTRIM( ISNULL( CAST (IdEntregasOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoItem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaEntrega : «' + RTRIM( ISNULL( CAST (IdMedidaEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMedidaEntrega : «' + RTRIM( ISNULL( CAST (QtdMedidaEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorNota : «' + RTRIM( ISNULL( CAST (ValorNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorReferencia : «' + RTRIM( ISNULL( CAST (ValorReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEntregasOrdem : «' + RTRIM( ISNULL( CAST (IdEntregasOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoItem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaEntrega : «' + RTRIM( ISNULL( CAST (IdMedidaEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMedidaEntrega : «' + RTRIM( ISNULL( CAST (QtdMedidaEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorNota : «' + RTRIM( ISNULL( CAST (ValorNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorReferencia : «' + RTRIM( ISNULL( CAST (ValorReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEntregasOrdem : «' + RTRIM( ISNULL( CAST (IdEntregasOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoItem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaEntrega : «' + RTRIM( ISNULL( CAST (IdMedidaEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMedidaEntrega : «' + RTRIM( ISNULL( CAST (QtdMedidaEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorNota : «' + RTRIM( ISNULL( CAST (ValorNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorReferencia : «' + RTRIM( ISNULL( CAST (ValorReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEntregasOrdem : «' + RTRIM( ISNULL( CAST (IdEntregasOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoItem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaEntrega : «' + RTRIM( ISNULL( CAST (IdMedidaEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMedidaEntrega : «' + RTRIM( ISNULL( CAST (QtdMedidaEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorNota : «' + RTRIM( ISNULL( CAST (ValorNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorReferencia : «' + RTRIM( ISNULL( CAST (ValorReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
