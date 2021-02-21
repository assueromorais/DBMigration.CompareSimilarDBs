/*Lucimara - 07/12/2010 - OC 65153*/

CREATE PROCEDURE [dbo].[spFatConsulta_ExtratoRecebimento] (
@DataInicialVencto datetime, @DataFinalVencto datetime, 
@strUF VARCHAR(2)
)
AS

DECLARE @SQL VARCHAR( 2000 )
SET NOCOUNT ON

SET @SQL = 'SELECT FND.IdUnidade, Unidades.NomeUnidade, SUM(ValorTotalNota) Total, ' +
'ISNULL(SUM(ValorPago),0) Recebido, (SUM(ValorTotalNota) - ISNULL(SUM(ValorPago),0)) AReceber ' +
'FROM FatNotasDebito FND '+
'LEFT JOIN Unidades ON Unidades.IdUnidade = FND.IdUnidade AND Unidades.E_ConselhoRegional = 1 ' + 
'WHERE IdSituacaoNotaDebito in (2, 3) ' --(Apenas notas emitidas - pagas e não pagas) 
	
IF (@DataInicialVencto is not null) AND (@DataFinalVencto is not null) 
    Set @SQL = @SQL + ' AND DataVencimento BETWEEN '''+ Convert( Varchar( 14 ), @DataInicialVencto, 112 ) + ' 00:00:00'' AND ''' + Convert( Varchar( 14 ), @DataFinalVencto, 112 ) + ' 23:59:59''' 

IF (@strUF  is not null) 
	Set @SQL = @SQL + ' AND (Unidades.SiglaUF = ''' + @strUF + ''') ' 

Set @SQL = @SQL + 'GROUP BY FND.IdUnidade, Unidades.NomeUnidade ' +
' Order by Unidades.NomeUnidade '

EXEC( @SQL )
