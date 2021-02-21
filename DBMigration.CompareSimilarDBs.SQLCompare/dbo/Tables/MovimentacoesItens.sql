CREATE TABLE [dbo].[MovimentacoesItens] (
    [IdMovimentacaoItem]          INT              IDENTITY (1, 1) NOT NULL,
    [DataMovimentacao]            DATETIME         NOT NULL,
    [IdAlmoxarifado]              INT              NOT NULL,
    [IdTipoMovimentacao]          INT              NOT NULL,
    [IdSubItem]                   INT              NOT NULL,
    [Qtd]                         FLOAT (53)       NULL,
    [IdUnidade]                   INT              NULL,
    [IdAlmoxarifadoDestino]       INT              NULL,
    [IdMovimentacaoDestino]       INT              NULL,
    [IdInventario]                INT              NULL,
    [ReciboImpresso]              INT              NULL,
    [ValorMovimento]              MONEY            NOT NULL,
    [SaldoMovimento]              MONEY            NULL,
    [IdSaldoMovimento]            TEXT             NULL,
    [MotivoDevolucao]             TEXT             NULL,
    [MovimentacaoDeRegistroPreco] BIT              CONSTRAINT [DF_MovimentacoesItens_MovimentacaoDeRegistroPreco] DEFAULT ((0)) NULL,
    [IdLocalEntrega]              INT              NULL,
    [HistoricoMovimentacao]       VARCHAR (2000)   NULL,
    [IdLancamentoMCASP]           UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_MovimentacoesItens] PRIMARY KEY NONCLUSTERED ([IdMovimentacaoItem] ASC),
    CONSTRAINT [FK_MovimentacoesItens_Almoxarifados] FOREIGN KEY ([IdAlmoxarifado]) REFERENCES [dbo].[Almoxarifados] ([IdAlmoxarifado]),
    CONSTRAINT [FK_MovimentacoesItens_Almoxarifados1] FOREIGN KEY ([IdAlmoxarifadoDestino]) REFERENCES [dbo].[Almoxarifados] ([IdAlmoxarifado]),
    CONSTRAINT [FK_MovimentacoesItens_Inventarios] FOREIGN KEY ([IdInventario]) REFERENCES [dbo].[Inventarios] ([IdInventario]),
    CONSTRAINT [FK_MovimentacoesItens_LocaisEntrega] FOREIGN KEY ([IdLocalEntrega]) REFERENCES [dbo].[LocaisEntrega] ([IdLocalEntrega]),
    CONSTRAINT [FK_MovimentacoesItens_SubItens] FOREIGN KEY ([IdSubItem]) REFERENCES [dbo].[SubItens] ([IdSubItem]),
    CONSTRAINT [FK_MovimentacoesItens_TiposMovimentacoesItens] FOREIGN KEY ([IdTipoMovimentacao]) REFERENCES [dbo].[TiposMovimentacoesItens] ([IdTipoMovimentacao]),
    CONSTRAINT [FK_MovimentacoesItens_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[MovimentacoesItens] NOCHECK CONSTRAINT [FK_MovimentacoesItens_Unidades];


GO
CREATE NONCLUSTERED INDEX [IX_MovimentacoesItensDataMovimentacaoIdSubItemQtdIdUnidade]
    ON [dbo].[MovimentacoesItens]([DataMovimentacao] ASC, [IdSubItem] ASC, [Qtd] ASC, [IdUnidade] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MovimentacoesItensIdSubItemQtd]
    ON [dbo].[MovimentacoesItens]([IdSubItem] ASC, [Qtd] ASC);


GO
/*Lucimara - 09/02/2011 - OC 65153*/

CREATE TRIGGER [dbo].[Trg_Itens_a_faturar] ON [dbo].[MovimentacoesItens]
FOR INSERT
AS
BEGIN
	DECLARE @IdTipoMovimentacaoPadraoPedido INT, 
	@IdTipoMovimentacaoPadraoDevolucaoPedido INT,
	@IdUnidade INT,@IdItemProduto INT,@IdTipoInclusao SMALLINT,
	@IdUnidade_ant INT,@IdItemProduto_ant INT,@IdTipoInclusao_ant SMALLINT,
	@IdSituacaoItemAFaturar SMALLINT,@Qtde_Devolucao INT,@Qtde_a_faturar INT,
	@IdItemAFaturar INT, @TOTAL_DEVOLUCAO INT, @SALDO_DEVOLUCAO INT
	
	SELECT @IdTipoMovimentacaoPadraoPedido=IdTipoMovimentacaoPadraoPedido,
	@IdTipoMovimentacaoPadraoDevolucaoPedido=IdTipoMovimentacaoPadraoDevolucaoPedido
	FROM ConfiguracoesSG cs
	
	IF EXISTS ( SELECT 1
				FROM INSERTED T1,
					dbo.Unidades T2,
					SUBITENS T3,
					ITENS T4
				WHERE T1.IdUnidade=T2.IdUnidade AND
					T2.E_ConselhoRegional=1 AND
					IdTipoMovimentacao IN (@IdTipoMovimentacaoPadraoPedido,@IdTipoMovimentacaoPadraoDevolucaoPedido) AND
					T1.IdSubItem=T3.IdSubItem AND	  
					T3.IdItem = T4.IdItem AND
					T4.ItemFaturavel = 1)
	BEGIN

		SELECT T1.IdUnidade,IdItemProduto=T3.IdItem,IdTipoInclusao=2,
		IdSituacaoItemAFaturar=1,Qtde=T1.Qtd,DataPedido=GETDATE(),
		T1.HistoricoMovimentacao,atualizacao=0
		INTO #TABTEMP_MOVIMENTACAO_A_ATUALIZAR
		FROM INSERTED T1,
			dbo.Unidades T2,
			SUBITENS T3,
			ITENS T4
		WHERE T1.IdUnidade=T2.IdUnidade AND
			T2.E_ConselhoRegional=1 AND
			IdTipoMovimentacao IN (@IdTipoMovimentacaoPadraoPedido,@IdTipoMovimentacaoPadraoDevolucaoPedido) AND
			T1.IdSubItem=T3.IdSubItem AND	  
			T3.IdItem = T4.IdItem AND
			T4.ItemFaturavel = 1
	
		/*Ver como fica quando se devolver mais que a qtde do item a faturar mais recente*/        	
		IF EXISTS (SELECT 1 FROM #TABTEMP_MOVIMENTACAO_A_ATUALIZAR 
				   WHERE Qtde > 0)
		BEGIN
			DECLARE Devolucao_Cursor
			CURSOR FAST_FORWARD FOR
			SELECT IdItemAFaturar,t1.IdUnidade,t1.IdItemProduto,t1.IdTipoInclusao,
			Qtde_Devolucao=t1.Qtde, Qtde_a_faturar=t2.Qtde
			FROM #TABTEMP_MOVIMENTACAO_A_ATUALIZAR t1,
				FatItensAFaturar t2
			WHERE t1.IdUnidade=t2.IdUnidade AND
						  t1.IdItemProduto=t2.IdItemProduto AND
						  t1.IdTipoInclusao=t2.IdTipoInclusao AND
						  t2.IdSituacaoItemAFaturar =1 AND
						  t1.Qtde > 0
			ORDER BY t1.IdUnidade,t1.IdItemProduto,t1.IdTipoInclusao
			
			OPEN Devolucao_Cursor
			FETCH NEXT FROM Devolucao_Cursor
			INTO @IdItemAFaturar,@IdUnidade,@IdItemProduto,@IdTipoInclusao,
			@Qtde_Devolucao,@Qtde_a_faturar

			SET @IdUnidade_ANT= 0
			SET @IdItemProduto_ANT= 0
			SET @IdTipoInclusao_ANT= 0
		
			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF @IdUnidade <> @IdUnidade_ant OR 
				   @IdItemProduto <> @IdItemProduto_ANT OR 
			       @IdTipoInclusao <> @IdTipoInclusao_ANT
				BEGIN
					SET @IdUnidade_ANT= @IdUnidade
					SET @IdItemProduto_ANT= @IdItemProduto
					SET @IdTipoInclusao_ANT= @IdTipoInclusao
					SET @SALDO_DEVOLUCAO = @Qtde_Devolucao			
				END
			
				IF @SALDO_DEVOLUCAO > 0
				BEGIN 
					UPDATE FatItensAFaturar SET
					Qtde= Qtde - @SALDO_DEVOLUCAO
					WHERE IdItemAFaturar=@IdItemAFaturar
				
					SET @SALDO_DEVOLUCAO = @SALDO_DEVOLUCAO - @Qtde_a_faturar
				END
			
				FETCH NEXT FROM Devolucao_Cursor
				INTO @IdItemAFaturar,@IdUnidade,@IdItemProduto,@IdTipoInclusao,
					 @Qtde_Devolucao,@Qtde_a_faturar
		
			END
			CLOSE Devolucao_Cursor
			DEALLOCATE Devolucao_Cursor
		END		   
		
		INSERT INTO dbo.FatItensAFaturar (IdUnidade,IdItemProduto,IdTipoInclusao,IdSituacaoItemAFaturar,
		Qtde,DataPedido, HistoricoMovimentacao)  
		SELECT T1.IdUnidade,t1.IdItemProduto,T1.IdTipoInclusao,T1.IdSituacaoItemAFaturar,
		Qtde=(T1.Qtde * -1),T1.DataPedido, t1.HistoricoMovimentacao 
		FROM #TABTEMP_MOVIMENTACAO_A_ATUALIZAR t1 
		WHERE T1.Qtde < 0
	
		DELETE FROM dbo.FatItensAFaturar
		WHERE Qtde <= 0
	END  
END

GO
CREATE TRIGGER [TrgLog_MovimentacoesItens] ON [Implanta_CRPAM].[dbo].[MovimentacoesItens] 
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
SET @TableName = 'MovimentacoesItens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMovimentacaoItem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacao : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifadoDestino : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoDestino : «' + RTRIM( ISNULL( CAST (IdMovimentacaoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ReciboImpresso : «' + RTRIM( ISNULL( CAST (ReciboImpresso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMovimento : «' + RTRIM( ISNULL( CAST (ValorMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoMovimento : «' + RTRIM( ISNULL( CAST (SaldoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MovimentacaoDeRegistroPreco IS NULL THEN ' MovimentacaoDeRegistroPreco : «Nulo» '
                                              WHEN  MovimentacaoDeRegistroPreco = 0 THEN ' MovimentacaoDeRegistroPreco : «Falso» '
                                              WHEN  MovimentacaoDeRegistroPreco = 1 THEN ' MovimentacaoDeRegistroPreco : «Verdadeiro» '
                                    END 
                         + '| IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HistoricoMovimentacao : «' + RTRIM( ISNULL( CAST (HistoricoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMovimentacaoItem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacao : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifadoDestino : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoDestino : «' + RTRIM( ISNULL( CAST (IdMovimentacaoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ReciboImpresso : «' + RTRIM( ISNULL( CAST (ReciboImpresso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMovimento : «' + RTRIM( ISNULL( CAST (ValorMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoMovimento : «' + RTRIM( ISNULL( CAST (SaldoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MovimentacaoDeRegistroPreco IS NULL THEN ' MovimentacaoDeRegistroPreco : «Nulo» '
                                              WHEN  MovimentacaoDeRegistroPreco = 0 THEN ' MovimentacaoDeRegistroPreco : «Falso» '
                                              WHEN  MovimentacaoDeRegistroPreco = 1 THEN ' MovimentacaoDeRegistroPreco : «Verdadeiro» '
                                    END 
                         + '| IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HistoricoMovimentacao : «' + RTRIM( ISNULL( CAST (HistoricoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMovimentacaoItem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacao : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifadoDestino : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoDestino : «' + RTRIM( ISNULL( CAST (IdMovimentacaoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ReciboImpresso : «' + RTRIM( ISNULL( CAST (ReciboImpresso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMovimento : «' + RTRIM( ISNULL( CAST (ValorMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoMovimento : «' + RTRIM( ISNULL( CAST (SaldoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MovimentacaoDeRegistroPreco IS NULL THEN ' MovimentacaoDeRegistroPreco : «Nulo» '
                                              WHEN  MovimentacaoDeRegistroPreco = 0 THEN ' MovimentacaoDeRegistroPreco : «Falso» '
                                              WHEN  MovimentacaoDeRegistroPreco = 1 THEN ' MovimentacaoDeRegistroPreco : «Verdadeiro» '
                                    END 
                         + '| IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HistoricoMovimentacao : «' + RTRIM( ISNULL( CAST (HistoricoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMovimentacaoItem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentacao : «' + RTRIM( ISNULL( CAST (IdTipoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifadoDestino : «' + RTRIM( ISNULL( CAST (IdAlmoxarifadoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoDestino : «' + RTRIM( ISNULL( CAST (IdMovimentacaoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ReciboImpresso : «' + RTRIM( ISNULL( CAST (ReciboImpresso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMovimento : «' + RTRIM( ISNULL( CAST (ValorMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoMovimento : «' + RTRIM( ISNULL( CAST (SaldoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MovimentacaoDeRegistroPreco IS NULL THEN ' MovimentacaoDeRegistroPreco : «Nulo» '
                                              WHEN  MovimentacaoDeRegistroPreco = 0 THEN ' MovimentacaoDeRegistroPreco : «Falso» '
                                              WHEN  MovimentacaoDeRegistroPreco = 1 THEN ' MovimentacaoDeRegistroPreco : «Verdadeiro» '
                                    END 
                         + '| IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HistoricoMovimentacao : «' + RTRIM( ISNULL( CAST (HistoricoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
