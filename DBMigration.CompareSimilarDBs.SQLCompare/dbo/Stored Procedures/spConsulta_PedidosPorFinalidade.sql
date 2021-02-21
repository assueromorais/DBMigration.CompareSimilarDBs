/* Lucimara - 21/12/2010 - SG - Oc. 69428 */
/* Felipe - 20/40/2011 - SG - Oc. 76304 */

CREATE PROCEDURE [dbo].[spConsulta_PedidosPorFinalidade] (
    @DataInicial            DATETIME,
    @DataFinal              DATETIME,
    @strIdUnidade           VARCHAR(4),
    @strIdLocalEntrega      VARCHAR(4),
    @strIdItem              VARCHAR(5),
    @strIdFinalidadePedido  VARCHAR(4),
    @Ordem                  VARCHAR(60)
)
AS
BEGIN
	DECLARE @SQL VARCHAR(2000)
	SET NOCOUNT ON
	
	SET @SQL = 
	    'SELECT IP.IdItem,  Itens.CodigoItem, Itens.NomeItem, Itens.ValorReferencia, ' 
	    +
	    'IP.Qtd, cast((Itens.ValorReferencia * IP.Qtd) as money) as ValorTotal, Pedidos.DataPedido, ' 
	    +
	    'Pedidos.IdUnidade, Unidades.NomeUnidade, Pedidos.IdLocalEntrega, ' +
	    'LocaisEntrega.TituloLocal, Pedidos.IdFinalidadePedido, ' +
	    'FinalidadePedido.FinalidadePedido, Pedidos.IdPedido ' +
	    'From ItensPedidos IP ' +
	    'INNER JOIN Itens ON Itens.IdItem = IP.IdItem ' +
	    'INNER JOIN Pedidos ON Pedidos.IdPedido = IP.IdPedido ' +
	    'LEFT JOIN Unidades ON Unidades.IdUnidade = Pedidos.IdUnidade ' +
	    'LEFT JOIN LocaisEntrega ON LocaisEntrega.IdLocalEntrega = Pedidos.IdLocalEntrega ' 
	    +
	    'LEFT JOIN FinalidadePedido ON FinalidadePedido.IdFinalidadePedido = Pedidos.IdFinalidadePedido ' 
	
	IF (@DataInicial IS NOT NULL AND @DataFinal IS NOT NULL)
	   OR (@strIdUnidade IS NOT NULL)
	   OR (@strIdLocalEntrega IS NOT NULL)
	   OR (@strIdFinalidadePedido IS NOT NULL)
	   OR (@strIdItem IS NOT NULL)
	BEGIN
	    SET @SQL = @SQL + ' WHERE 1 > 0 '
	END
	
	IF (@DataInicial IS NOT NULL)
	   AND (@DataFinal IS NOT NULL)
	    SET @SQL = @SQL + 'AND DataPedido BETWEEN ''' + CONVERT(VARCHAR(14), @DataInicial, 112) 
	        + ' 00:00:00'' AND ''' + CONVERT(VARCHAR(14), @DataFinal, 112) + 
	        ' 23:59:59'''
	
	IF (@strIdUnidade IS NOT NULL)
	    SET @SQL = @SQL + 'AND (Pedidos.IdUnidade = ' + @strIdUnidade + ') '
	
	IF (@strIdLocalEntrega IS NOT NULL)
	    SET @SQL = @SQL + 'AND (Pedidos.IdLocalEntrega = ' + @strIdLocalEntrega 
	        + ') '
	
	IF (@strIdFinalidadePedido IS NOT NULL)
	    SET @SQL = @SQL + 'AND (Pedidos.IdFinalidadePedido = ' + @strIdFinalidadePedido 
	        + ') '
	
	IF (@strIdItem IS NOT NULL)
	    SET @SQL = @SQL + 'AND (IP.IdItem = ' + @strIdItem + ') '
	
	IF (@Ordem IS NOT NULL)
	    SET @SQL = @SQL + 'Order by ' + @Ordem
	
	EXEC (@SQL)
END 
