/*Lucimara - 25/10/2010 - OC 65153*/
/*Caroline - 26/11/2013 - Oc 119075*/
/*Oc nº 119075*/ 
CREATE PROCEDURE [dbo].[spFatConsulta_ItensNotasDebito] @IdsNotaDebito VARCHAR(200)
AS

DECLARE @SQL VARCHAR( 2000 )
SET NOCOUNT ON

IF (@IdsNotaDebito is not null)
Begin
	SET @SQL = 'SELECT FIND.IdNotaDebito, IdItemNotaDebito, IdItemProduto, FIND.IdTipoInclusao, ValorUnitario, Qtde, ' +
    '(ValorUnitario * Qtde) as ValorTotalItem, ' +	
	'Codigo = Case ' + 
	'       when FIND.IdTipoInclusao in (1,2) then (Select CodigoItem from Itens where Itens.IdItem = FIND.IdItemProduto) ' +
	'		else '''' end, ' +
	'Nome = Case ' +  
	'       when FIND.IdTipoInclusao in (1,2) then (Select NomeItem from Itens where Itens.IdItem = FIND.IdItemProduto)  ' +
	'		else (Select NomeProduto from FatProdutosEspeciais FPE where FPE.IdProduto = FIND.IdItemProduto) end, ' + 
	'Medidas.NomeMedida, FND.NumeroNotaDebito, FND.IdUnidade, Unidades.NomeUnidade, Unidades.SiglaUnidade,  ' +
	'FND.IdSituacaoNotaDebito, FND.DataEmissao, FND.DataVencimento, FND.ValorTotalNota, FND.HistoricoSolicitacao, ' +
	'FND.IdUsuarioEmissao, fti.DescricaoTipoInclusao as DescricaoTipoInclusao  ' +
	'From FatItensNotasDebito FIND ' +
	'INNER JOIN FatNotasDebito FND ON FND.IdNotaDebito = FIND.IdNotaDebito ' +
    	'LEFT JOIN Unidades ON FND.IdUnidade = Unidades.IdUnidade  ' +
	'LEFT JOIN Itens ON Itens.IdItem = FIND.IdItemProduto AND FIND.IdTipoInclusao in (1,2)  ' + --GDB ou Almoxarifado
	'LEFT JOIN Medidas ON Medidas.IdMedida = Itens.IdMedidaPadrao  ' +
	'INNER JOIN  FatTiposInclusao fti ON fti.IdTipoInclusao = FIND.IdTipoInclusao '+
	'WHERE FIND.IdNotaDebito in (' + @IdsNotaDebito + ') ' +
	'Order by FIND.IdNotaDebito, IdItemNotaDebito'
	
	EXEC( @SQL )
END
