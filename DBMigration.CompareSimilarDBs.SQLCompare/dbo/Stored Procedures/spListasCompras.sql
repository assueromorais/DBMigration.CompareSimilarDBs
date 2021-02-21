

/*André - 22/06/2009 - SG*/

CREATE PROCEDURE [dbo].[spListasCompras] AS

CREATE TABLE #ListaCompra
        (
    IdItem		int,
    NomeItem	varchar(60) COLLATE database_default,
    NomeGrupoItem	varchar(60) COLLATE database_default,
    QtdAComprar  	int,
    ValorEstimado   MONEY,
	EstoqueMaximo	int,
	EstoqueMinimo	int,
	EstoqueAtual	int,
	QtdPedidos	int,
	QtdOrdens	int
        )  

DECLARE @IdItem int, @NomeItem varchar(60), @NomeGrupoItem varchar(60), @EstoqueMaximo int, @EstoqueMinimo int, @EstoqueAtual int, @QtdPedidos int, @QtdOrdens INT, @ValorReferencia MONEY

DECLARE ListaCompra_Cursor
CURSOR FAST_FORWARD FOR

SELECT IdItem, NomeItem, NomeGrupoItem, EstoqueMaximo, EstoqueMinimo, ValorReferencia FROM Itens 
INNER JOIN GruposItens ON GruposItens.IdGrupoItem = Itens.IdGrupoItem
WHERE Itens.Ativo = 1
ORDER BY NomeItem

OPEN ListaCompra_Cursor

FETCH NEXT FROM ListaCompra_Cursor
INTO @IdItem, @NomeItem, @NomeGrupoItem, @EstoqueMaximo, @EstoqueMinimo, @ValorReferencia

WHILE @@FETCH_STATUS = 0
BEGIN

	SET @EstoqueAtual = (SELECT ISNULL(SUM(Qtd),0) FROM SubItens, MovimentacoesItens WHERE SubItens.IdSubItem = MovimentacoesItens.IdSubItem AND IdItem = @IdItem)
	SET @QtdPedidos = (SELECT ISNULL(SUM(Qtd),0) FROM ItensPedidos WHERE IdItem = @IdItem) + (SELECT ISNULL(SUM(Qtd),0) FROM MovimentacoesItens, SubItens WHERE MovimentacoesItens.IdSubItem = SubItens.IdSubItem AND MovimentacoesItens.IdUnidade IS NOT NULL AND IdItem = @IdItem)
	SET @QtdOrdens = (SELECT ISNULL(SUM(Qtd),0) FROM ItensOrdens INNER JOIN Ordens ON Ordens.IdOrdem = ItensOrdens.IdOrdem INNER JOIN SubItens ON SubItens.IdSubItem = ItensOrdens.IdSubItem INNER JOIN Itens ON Itens.IdItem = SubItens.IdItem WHERE Ordens.Situacao = 0 AND Itens.IdItem = @IdItem) - (SELECT ISNULL(SUM(Qtd), 0) FROM MovimentacoesItens INNER JOIN EntregasOrdens ON EntregasOrdens.IdMovimentacaoItem = MovimentacoesItens.IdMovimentacaoItem INNER JOIN SubItens ON SubItens.IdSubItem = MovimentacoesItens.IdSubItem INNER JOIN Itens ON Itens.IdItem = SubItens.IdItem WHERE Itens.IdItem = @IdItem)

	IF @EstoqueAtual - @QtdPedidos + @QtdOrdens < @EstoqueMinimo
	
		INSERT #ListaCompra
		VALUES(
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
	INTO @IdItem, @NomeItem, @NomeGrupoItem, @EstoqueMaximo, @EstoqueMinimo, @ValorReferencia
END

CLOSE ListaCompra_Cursor
DEALLOCATE ListaCompra_Cursor

SELECT * FROM #ListaCompra
DROP TABLE #ListaCompra




