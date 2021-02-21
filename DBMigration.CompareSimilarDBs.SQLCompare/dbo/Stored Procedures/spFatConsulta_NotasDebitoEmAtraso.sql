/*Lucimara - 02/12/2010 - OC 65153*/

CREATE PROCEDURE [dbo].[spFatConsulta_NotasDebitoEmAtraso] (
@DataInicialVencto datetime, @DataFinalVencto datetime, 
@strUF VARCHAR(2), @Ordem varchar(60)
)
AS

DECLARE @SQL VARCHAR( 2000 ), @FATPrazoInadimplencia VARCHAR(3)
SET NOCOUNT ON

SELECT @FATPrazoInadimplencia = FATPrazoInadimplencia FROM ConfiguracoesSG

SET @SQL = 'SELECT IdNotaDebito, NumeroNotaDebito, FND.IdUnidade, ' +
'IdSituacaoNotaDebito, DataEmissao, DataVencimento, ValorTotalNota, ' +
'Unidades.NomeUnidade, DiasEmAtraso = DATEDIFF(day, DataVencimento, GETDATE()) ' +
'From FatNotasDebito FND ' +
'LEFT JOIN Unidades ON Unidades.IdUnidade = FND.IdUnidade AND Unidades.E_ConselhoRegional = 1 ' + 
'WHERE IdSituacaoNotaDebito = 2 AND ' + --(Apenas notas emitidas e não pagas) 
'	DATEDIFF(day, DataVencimento, GETDATE()) >= ' + @FATPrazoInadimplencia
	
IF (@DataInicialVencto is not null) AND (@DataFinalVencto is not null) 
    Set @SQL = @SQL + ' AND DataVencimento BETWEEN '''+ Convert( Varchar( 14 ), @DataInicialVencto, 112 ) + ' 00:00:00'' AND ''' + Convert( Varchar( 14 ), @DataFinalVencto, 112 ) + ' 23:59:59''' 

IF (@strUF  is not null) 
	Set @SQL = @SQL + ' AND (Unidades.SiglaUF = ''' + @strUF + ''') ' 

IF (@Ordem is not null) 
	Set @SQL = @SQL + ' Order by ' + @Ordem

EXEC( @SQL )
