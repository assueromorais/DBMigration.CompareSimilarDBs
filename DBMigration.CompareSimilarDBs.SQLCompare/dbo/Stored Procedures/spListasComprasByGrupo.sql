/* Felipe Campos   Oc. 77456   09/05/2011  */

CREATE PROCEDURE [dbo].[spListasComprasByGrupo](@IdGrupo INT, @DataInicial DATETIME, @DataFinal DATETIME)
AS
BEGIN
	CREATE TABLE #ListaCompra
	(
		IdItem         INT,
		NomeItem       VARCHAR(60) COLLATE database_default,
		NomeGrupoItem  VARCHAR(60) COLLATE database_default,
		QtdAComprar    INT,
		ValorEstimado  MONEY,
		EstoqueMaximo  INT,
		EstoqueMinimo  INT,
		EstoqueAtual   INT,
		QtdPedidos     INT,
		QtdOrdens      INT
	)  
	
	DECLARE @IdItem             INT,
	        @NomeItem           VARCHAR(60),
	        @NomeGrupoItem      VARCHAR(60),
	        @EstoqueMaximo      INT,
	        @EstoqueMinimo      INT,
	        @EstoqueAtual       INT,
	        @QtdPedidos         INT,
	        @QtdOrdens          INT,
	        @ValorReferencia    MONEY
	
	DECLARE ListaCompra_Cursor  CURSOR FAST_FORWARD 
	FOR
	    SELECT IdItem,
	           NomeItem,
	           NomeGrupoItem,
	           EstoqueMaximo,
	           EstoqueMinimo,
	           ValorReferencia  
	    FROM   Itens
	           INNER JOIN GruposItens
	                ON  GruposItens.IdGrupoItem = Itens.IdGrupoItem
	    WHERE  Itens.Ativo = 1
	           AND Itens.IdGrupoItem = ISNULL(@IdGrupo, Itens.IdGrupoItem)
	           AND NOT EXISTS(
	                   SELECT 1
	                   FROM   ListaComprasGeradas
	                          INNER JOIN ItensListaComprasGeradas
	                               ON  ItensListaComprasGeradas.IdListaCompraGerada = 
	                                   ListaComprasGeradas.IdListaCompraGerada
	                   WHERE  ItensListaComprasGeradas.IdItem = Itens.IdItem
	                          AND ListaComprasGeradas.DataHoraGeracao BETWEEN @DataInicial 
	                              AND @DataFinal
	               )
	    ORDER BY
	           NomeItem
	
	OPEN ListaCompra_Cursor
	
	FETCH NEXT FROM ListaCompra_Cursor
	INTO @IdItem, @NomeItem, @NomeGrupoItem, @EstoqueMaximo, @EstoqueMinimo, @ValorReferencia                                                                                                                                
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    SET @EstoqueAtual = (
	            SELECT ISNULL(SUM(Qtd), 0)
	            FROM   SubItens,
	                   MovimentacoesItens
	            WHERE  SubItens.IdSubItem = MovimentacoesItens.IdSubItem
	                   AND IdItem = @IdItem
	        )
	    
	    SET @QtdPedidos = (
	            SELECT ISNULL(SUM(Qtd), 0)
	            FROM   ItensPedidos
	            WHERE  IdItem = @IdItem
	        ) + (
	            SELECT ISNULL(SUM(Qtd), 0)
	            FROM   MovimentacoesItens,
	                   SubItens
	            WHERE  MovimentacoesItens.IdSubItem = SubItens.IdSubItem
	                   AND MovimentacoesItens.IdUnidade IS NOT NULL
	                   AND IdItem = @IdItem
	        )
	    
	    SET @QtdOrdens = (
	            SELECT ISNULL(SUM(Qtd), 0)
	            FROM   ItensOrdens
	                   INNER JOIN Ordens
	                        ON  Ordens.IdOrdem = ItensOrdens.IdOrdem
	                   INNER JOIN SubItens
	                        ON  SubItens.IdSubItem = ItensOrdens.IdSubItem
	                   INNER JOIN Itens
	                        ON  Itens.IdItem = SubItens.IdItem
	            WHERE  Ordens.Situacao = 0
	                   AND Itens.IdItem = @IdItem
	        ) -(
	            SELECT ISNULL(SUM(Qtd), 0)
	            FROM   MovimentacoesItens
	                   INNER JOIN EntregasOrdens
	                        ON  EntregasOrdens.IdMovimentacaoItem = 
	                            MovimentacoesItens.IdMovimentacaoItem
	                   INNER JOIN SubItens
	                        ON  SubItens.IdSubItem = MovimentacoesItens.IdSubItem
	                   INNER JOIN Itens
	                        ON  Itens.IdItem = SubItens.IdItem
	            WHERE  Itens.IdItem = @IdItem
	        )
	    
	    IF @EstoqueAtual - @QtdPedidos + @QtdOrdens < @EstoqueMinimo
	        INSERT #ListaCompra
	        VALUES
	          (
	            @IdItem,
	            @NomeItem,
	            @NomeGrupoItem,
	            @EstoqueMaximo - @EstoqueAtual + @QtdPedidos - @QtdOrdens,
	            @ValorReferencia,
	            @EstoqueMaximo,
	            @EstoqueMinimo,
	            @EstoqueAtual,
	            @QtdPedidos,
	            @QtdOrdens
	          )
	    
	    FETCH NEXT FROM ListaCompra_Cursor
	    INTO @IdItem, @NomeItem, @NomeGrupoItem, @EstoqueMaximo, @EstoqueMinimo, 
	    @ValorReferencia
	END
	
	CLOSE ListaCompra_Cursor
	DEALLOCATE ListaCompra_Cursor
	
	SELECT *
	FROM   #ListaCompra
	
	DROP TABLE #ListaCompra
END 
