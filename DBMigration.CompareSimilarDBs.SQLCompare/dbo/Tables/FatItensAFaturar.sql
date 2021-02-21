CREATE TABLE [dbo].[FatItensAFaturar] (
    [IdItemAFaturar]         INT            IDENTITY (1, 1) NOT NULL,
    [IdUnidade]              INT            NOT NULL,
    [IdItemProduto]          INT            NOT NULL,
    [IdTipoInclusao]         INT            NOT NULL,
    [IdSituacaoItemAFaturar] INT            NOT NULL,
    [Qtde]                   REAL           NOT NULL,
    [DataPedido]             DATETIME       NULL,
    [HistoricoMovimentacao]  VARCHAR (2000) NULL,
    [DataFaturamento]        DATETIME       NULL,
    [IdNotaDebito]           INT            NULL,
    [IdItemNotaDebito]       INT            NULL,
    [DataCancelamento]       DATETIME       NULL,
    [IdUsuarioCancelamento]  INT            NULL,
    [MotivoCancelamento]     VARCHAR (2000) NULL,
    [NumeroPedido]           INT            NULL,
    CONSTRAINT [PK_FatItensAFaturar] PRIMARY KEY CLUSTERED ([IdItemAFaturar] ASC),
    CONSTRAINT [FK_FatItensAFaturar_FatItensNotasDebito] FOREIGN KEY ([IdNotaDebito], [IdItemNotaDebito]) REFERENCES [dbo].[FatItensNotasDebito] ([IdNotaDebito], [IdItemNotaDebito]),
    CONSTRAINT [FK_FatItensAFaturar_FatProdutosEspeciais] FOREIGN KEY ([IdItemProduto]) REFERENCES [dbo].[FatProdutosEspeciais] ([IdProduto]),
    CONSTRAINT [FK_FatItensAFaturar_FatSituacoesItemAFaturar] FOREIGN KEY ([IdSituacaoItemAFaturar]) REFERENCES [dbo].[FatSituacoesItemAFaturar] ([IdSituacaoItemAFaturar]),
    CONSTRAINT [FK_FatItensAFaturar_FatTiposInclusao] FOREIGN KEY ([IdTipoInclusao]) REFERENCES [dbo].[FatTiposInclusao] ([IdTipoInclusao]),
    CONSTRAINT [FK_FatItensAFaturar_Itens] FOREIGN KEY ([IdItemProduto]) REFERENCES [dbo].[Itens] ([IdItem]),
    CONSTRAINT [FK_FatItensAFaturar_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade]),
    CONSTRAINT [FK_FatItensAFaturar_Usuarios] FOREIGN KEY ([IdUsuarioCancelamento]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
ALTER TABLE [dbo].[FatItensAFaturar] NOCHECK CONSTRAINT [FK_FatItensAFaturar_FatProdutosEspeciais];


GO
ALTER TABLE [dbo].[FatItensAFaturar] NOCHECK CONSTRAINT [FK_FatItensAFaturar_Itens];


GO
CREATE TRIGGER [TrgLog_FatItensAFaturar] ON [Implanta_CRPAM].[dbo].[FatItensAFaturar] 
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
SET @TableName = 'FatItensAFaturar'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItemAFaturar : «' + RTRIM( ISNULL( CAST (IdItemAFaturar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemProduto : «' + RTRIM( ISNULL( CAST (IdItemProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInclusao : «' + RTRIM( ISNULL( CAST (IdTipoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoItemAFaturar : «' + RTRIM( ISNULL( CAST (IdSituacaoItemAFaturar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtde : «' + RTRIM( ISNULL( CAST (Qtde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPedido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPedido, 113 ),'Nulo'))+'» '
                         + '| HistoricoMovimentacao : «' + RTRIM( ISNULL( CAST (HistoricoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFaturamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFaturamento, 113 ),'Nulo'))+'» '
                         + '| IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemNotaDebito : «' + RTRIM( ISNULL( CAST (IdItemNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCancelamento : «' + RTRIM( ISNULL( CAST (IdUsuarioCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoCancelamento : «' + RTRIM( ISNULL( CAST (MotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPedido : «' + RTRIM( ISNULL( CAST (NumeroPedido AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItemAFaturar : «' + RTRIM( ISNULL( CAST (IdItemAFaturar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemProduto : «' + RTRIM( ISNULL( CAST (IdItemProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInclusao : «' + RTRIM( ISNULL( CAST (IdTipoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoItemAFaturar : «' + RTRIM( ISNULL( CAST (IdSituacaoItemAFaturar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtde : «' + RTRIM( ISNULL( CAST (Qtde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPedido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPedido, 113 ),'Nulo'))+'» '
                         + '| HistoricoMovimentacao : «' + RTRIM( ISNULL( CAST (HistoricoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFaturamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFaturamento, 113 ),'Nulo'))+'» '
                         + '| IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemNotaDebito : «' + RTRIM( ISNULL( CAST (IdItemNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCancelamento : «' + RTRIM( ISNULL( CAST (IdUsuarioCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoCancelamento : «' + RTRIM( ISNULL( CAST (MotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPedido : «' + RTRIM( ISNULL( CAST (NumeroPedido AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItemAFaturar : «' + RTRIM( ISNULL( CAST (IdItemAFaturar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemProduto : «' + RTRIM( ISNULL( CAST (IdItemProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInclusao : «' + RTRIM( ISNULL( CAST (IdTipoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoItemAFaturar : «' + RTRIM( ISNULL( CAST (IdSituacaoItemAFaturar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtde : «' + RTRIM( ISNULL( CAST (Qtde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPedido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPedido, 113 ),'Nulo'))+'» '
                         + '| HistoricoMovimentacao : «' + RTRIM( ISNULL( CAST (HistoricoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFaturamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFaturamento, 113 ),'Nulo'))+'» '
                         + '| IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemNotaDebito : «' + RTRIM( ISNULL( CAST (IdItemNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCancelamento : «' + RTRIM( ISNULL( CAST (IdUsuarioCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoCancelamento : «' + RTRIM( ISNULL( CAST (MotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPedido : «' + RTRIM( ISNULL( CAST (NumeroPedido AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItemAFaturar : «' + RTRIM( ISNULL( CAST (IdItemAFaturar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemProduto : «' + RTRIM( ISNULL( CAST (IdItemProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInclusao : «' + RTRIM( ISNULL( CAST (IdTipoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoItemAFaturar : «' + RTRIM( ISNULL( CAST (IdSituacaoItemAFaturar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtde : «' + RTRIM( ISNULL( CAST (Qtde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPedido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPedido, 113 ),'Nulo'))+'» '
                         + '| HistoricoMovimentacao : «' + RTRIM( ISNULL( CAST (HistoricoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFaturamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFaturamento, 113 ),'Nulo'))+'» '
                         + '| IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemNotaDebito : «' + RTRIM( ISNULL( CAST (IdItemNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCancelamento : «' + RTRIM( ISNULL( CAST (IdUsuarioCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoCancelamento : «' + RTRIM( ISNULL( CAST (MotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPedido : «' + RTRIM( ISNULL( CAST (NumeroPedido AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
