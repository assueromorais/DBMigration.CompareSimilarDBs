/* Task 2017 - Sergio*/ 
/* Task 150 - Carol*/
/* Task 2020 - Serginho*/
CREATE PROCEDURE [dbo].[spBalancetes] @DataInicial datetime, @DataFinal datetime, @Alfabetico BIT = 0, @RegistroPreco Bit = 0, @ItensComMovimento Bit = 0, @ItensComMovimentoNoPeriodo Bit = 0, @OcultarItensInativos Bit = 0 
AS
DECLARE @SQL VARCHAR( 2000 )
SET NOCOUNT ON
SET @SQL = 'SELECT Itens.IdItem, CodigoItem, NomeItem, '+
'ISNULL(QtdIni,0) SaldoInicial, '+
'ISNULL(ValorQtdIni,0) ValorSaldoInicial, '+
'ISNULL(ValorQtdIniOrig,0) ValorSaldoInicialOrig, '+
'ISNULL(QtdEnt,0) Entradas, '+
'ISNULL(ValorQtdEnt,0) ValorEntradas, '+
'ISNULL(QtdSai,0) Saidas, '+
'ISNULL(ValorQtdSai,0) ValorSaidas, '+
'ISNULL(QtdIni,0) + ISNULL(QtdEnt,0) + ISNULL(QtdSai,0) SaldoFinal, '+
'CASE WHEN ISNULL(QtdIni, 0) = 0 AND ISNULL(QtdEnt, 0) = 0 AND ISNULL(QtdSai, 0) = 0 THEN 0 ELSE ISNULL(ValorQtdIni,0) + ISNULL(ValorQtdEnt,0) + ISNULL(ValorQtdSai,0) END ValorSaldoFinal, '+
'ISNULL(ValorQtdIniOrig,0) + ISNULL(ValorQtdEnt,0) + ISNULL(ValorQtdSai,0) ValorSaldoFinalOrig '+
'FROM Itens '+
'LEFT JOIN '+
'( '+
'	SELECT IdItem, SUM(Qtd) QtdIni, SUM(ValorMovimento) ValorQtdIniOrig, CASE WHEN SUM(Qtd) = 0 THEN 0 ELSE SUM(ValorMovimento) END ValorQtdIni '+
'	FROM MovimentacoesItens '+
'	INNER JOIN SubItens ON SubItens.IdSubItem = MovimentacoesItens.IdSubItem '+
'	WHERE DataMovimentacao < ''' + Convert( Varchar( 14 ), @DataInicial, 112 ) + ''' '+
'	GROUP BY IdItem '+
') Ini ON Itens.IdItem = Ini.IdItem '+
'LEFT JOIN '+
'( '+
'	SELECT IdItem, SUM(Qtd) QtdEnt, CASE WHEN SUM(Qtd) = 0 THEN 0 ELSE SUM(ValorMovimento) END ValorQtdEnt '+
'	FROM MovimentacoesItens '+
'	INNER JOIN SubItens ON SubItens.IdSubItem = MovimentacoesItens.IdSubItem '+
'	WHERE DataMovimentacao BETWEEN ''' + Convert( Varchar( 14 ), @DataInicial, 112 ) + ''' AND ''' + Convert( Varchar( 14 ), @DataFinal, 112 ) + ''' '+
'	AND Qtd > 0 '+
'	GROUP BY IdItem '+
') Ent ON Itens.IdItem = Ent.IdItem '+
'LEFT JOIN '+
'( '+
'	SELECT IdItem, SUM(Qtd) QtdSai, CASE WHEN SUM(Qtd) = 0 THEN 0 ELSE SUM(ValorMovimento) END ValorQtdSai '+
'	FROM MovimentacoesItens '+
'	INNER JOIN SubItens ON SubItens.IdSubItem = MovimentacoesItens.IdSubItem '+
'	WHERE DataMovimentacao BETWEEN '''+ Convert( Varchar( 14 ), @DataInicial, 112 ) + ''' AND ''' + Convert( Varchar( 14 ), @DataFinal, 112 ) + ''' '+
'	AND Qtd < 0 '+
'	GROUP BY IdItem '+
') Sai ON Itens.IdItem = Sai.IdItem '+
' WHERE 1 > 0 ' 
IF @RegistroPreco = 0
	SET @SQL = @SQL + ' AND Itens.ItemEmModalidadeRegPreco = 0 '

IF @ItensComMovimento = 1
	SET @SQL = @SQL + ' AND ((QtdEnt > 0) OR (QtdSai < 0) OR (QtdIni <> 0)) '
	
IF @ItensComMovimentoNoPeriodo = 1
	SET @SQL = @SQL + 'AND ((ISNULL(QtdEnt,0) <> 0) or (ISNULL(QtdSai,0) <> 0)) '	

IF @OcultarItensInativos = 1 	
	SET @SQL = @SQL + ' AND Itens.Ativo = 1  '

IF @Alfabetico = 0
SET @SQL = @SQL + 'ORDER BY CodigoItem'
ELSE
SET @SQL = @SQL + 'ORDER BY NomeItem'
EXEC( @sql )
