/* 113297 */ 

CREATE PROCEDURE [dbo].[spFatConsulta_ItensAFaturar] (
@DataInicial datetime, @DataFinal datetime, @strUF VARCHAR(2),
@Ordem varchar(25), @intIdTipoInclusao varchar(3),@strCodigoStatusPedido VARCHAR(20)
)
AS

DECLARE @SQL VARCHAR( 2000 )
SET NOCOUNT ON

IF (@strUF is not null)
Begin
	SET @SQL = 'SELECT FIF.IdItemAFaturar, FIF.IdItemProduto,  FIF.IdTipoInclusao, ' +
	'Codigo = Case ' + 
	'       when FIF.IdTipoInclusao in (1,2) then (Select CodigoItem from Itens where Itens.IdItem = FIF.IdItemProduto) ' +
	'		else '''' end, ' +
	'Nome = Case ' + 
	'       when FIF.IdTipoInclusao in (1,2) then (Select NomeItem from Itens where Itens.IdItem = FIF.IdItemProduto) ' +
	'		else (Select NomeProduto from FatProdutosEspeciais FPE where FPE.IdProduto = FIF.IdItemProduto) end, ' +
	'ValorVenda = Case ' + 
	'       when FIF.IdTipoInclusao in (1,2) then (Select ValorVenda from Itens where Itens.IdItem = FIF.IdItemProduto) ' +
	'       else (Select ValorVenda from FatProdutosEspeciais FPE where FPE.IdProduto = FIF.IdItemProduto) end, ' +
	'FatTiposInclusao.DescricaoTipoInclusao, IdSituacaoItemAFaturar, Qtde, DataPedido,PCI.CodigoStatusPedidoAtual,PCS.StatusPedido ' +
	'From FatItensAFaturar FIF ' +
	'LEFT JOIN FatTiposInclusao ON FatTiposInclusao.IdTipoInclusao = FIF.IdTipoInclusao ' +
	'INNER JOIN Unidades ON Unidades.IdUnidade = FIF.IdUnidade AND Unidades.E_ConselhoRegional = 1 AND Unidades.SiglaUF = ''' + @strUF + ''' ' +
	' LEFT JOIN ' + 
    ' PedidosCedulaIdentidadeProfissional PCI ON PCI.NumeroPedido = FIF.NumeroPedido AND FIF.IdTipoInclusao = 1  LEFT JOIN ' +
    ' PedidosCedulaStatus PCS ON PCI.CodigoStatusPedidoAtual = PCS.CodigoStatusPedido  AND PCI.CodigoStatusPedidoAtual IN(3,4)' + 
	'WHERE DataFaturamento IS NULL AND DataCancelamento IS NULL ' 
       
	IF (@DataInicial is not null) AND (@DataFinal is not null) 
		Set @SQL = @SQL + 'AND DataPedido BETWEEN '''+ Convert( Varchar( 14 ), @DataInicial, 112 ) + ' 00:00:00'' AND ''' + Convert( Varchar( 14 ), @DataFinal, 112 ) + ' 23:59:59''' 

	IF (@intIdTipoInclusao  is not null) 
		Set @SQL = @SQL + 'AND (FIF.IdTipoInclusao = ' + @intIdTipoInclusao + ') ' 
		
	IF (@strCodigoStatusPedido IS NOT NULL) 
	    Set @SQL = @SQL + ' AND ((PCI.CodigoStatusPedidoAtual IS NULL) OR (PCI.CodigoStatusPedidoAtual = ' + @strCodigoStatusPedido + ')) '

	IF (@Ordem is not null) 
		Set @SQL = @SQL + 'Order by ' + @Ordem

	EXEC( @SQL )
End
