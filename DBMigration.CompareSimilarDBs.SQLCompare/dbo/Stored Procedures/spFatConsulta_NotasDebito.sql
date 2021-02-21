/*Lucimara - 25/10/2010 - OC 65153*/

CREATE PROCEDURE [dbo].[spFatConsulta_NotasDebito] (
@DataInicialEmissao datetime, @DataFinalEmissao datetime, @DataInicialVencto datetime,
@DataFinalVencto datetime, @strNumNotaInicial varchar(20), @strNumNotaFinal varchar(20),
@strUF VARCHAR(2), @Ordem varchar(60), @strIdSituacaoNotaDebito varchar(3) 
)
AS

DECLARE @SQL VARCHAR( 2000 )
SET NOCOUNT ON

SET @SQL = 'SELECT FND.IdNotaDebito, FND.NumeroNotaDebito, FND.IdUnidade, FND.IdSituacaoNotaDebito, FND.DataEmissao, ' +
'FND.DataVencimento, FND.ValorTotalNota, Unidades.NomeUnidade, FSN.DescricaoSituacao ' +
'From FatNotasDebito FND ' +
'LEFT JOIN FatSituacoesNotaDebito FSN ON FSN.IdSituacaoNotaDebito = FND.IdSituacaoNotaDebito ' +
'LEFT JOIN Unidades ON Unidades.IdUnidade = FND.IdUnidade AND Unidades.E_ConselhoRegional = 1 ' 

IF (@DataInicialEmissao is not null AND @DataFinalEmissao is not null) Or
   (@DataInicialVencto is not null AND @DataFinalVencto is not null) Or
   (@strNumNotaInicial is not null) Or
   (@strNumNotaFinal is not null) Or
   (@strUF is not null) Or
   (@Ordem is not null) Or
   (@strIdSituacaoNotaDebito  is not null) 
	Begin
		Set @SQL = @SQL + ' WHERE 1 > 0 '
	end

IF (@DataInicialEmissao is not null) AND (@DataFinalEmissao is not null) 	 
    Set @SQL = @SQL + 'AND DataEmissao BETWEEN '''+ Convert( Varchar( 14 ), @DataInicialEmissao, 112 ) + ' 00:00:00'' AND ''' + Convert( Varchar( 14 ), @DataFinalEmissao, 112 ) + ' 23:59:59'''
            
IF (@DataInicialVencto is not null) AND (@DataFinalVencto is not null) 
    Set @SQL = @SQL + 'AND DataVencimento BETWEEN '''+ Convert( Varchar( 14 ), @DataInicialVencto, 112 ) + ' 00:00:00'' AND ''' + Convert( Varchar( 14 ), @DataFinalVencto, 112 ) + ' 23:59:59''' 

IF (@strNumNotaInicial  is not null) 
	Set @SQL = @SQL + 'AND (NumeroNotaDebito >= ' + @strNumNotaInicial + ') ' 

IF (@strNumNotaFinal  is not null) 
	Set @SQL = @SQL + 'AND (NumeroNotaDebito <= ' + @strNumNotaFinal + ') '

IF (@strUF  is not null) 
	Set @SQL = @SQL + 'AND (Unidades.SiglaUF = ''' + @strUF + ''') ' 

IF (@strIdSituacaoNotaDebito  is not null) 
	Set @SQL = @SQL + 'AND (FND.IdSituacaoNotaDebito = ' + @strIdSituacaoNotaDebito + ') '

IF (@Ordem is not null) 
	Set @SQL = @SQL + 'Order by ' + @Ordem

EXEC( @SQL )
