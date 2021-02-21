/* OC 17219 - Rodrigo Souza */ 
/*André - 12/04/2010 - Oc. 61190*/

CREATE Procedure [dbo].[Sp_GastosMensaisDespesa]  
   @DataIni datetime, @DataFim datetime,  
   @SomenteCMovimento bit = 0,  
   @CentroCusto varchar(10) = '',  
   @ContaInicio varchar(20) = '',  
   @ContaFim varchar(20) = ''  
AS  
SET NOCOUNT ON  
  
DECLARE   
 @strSQLSintetico varchar(8000), @i Int,  
   @DataAux datetime, @strNomeCampo varchar(2000),  
   @strMes varchar(4), @strCriaTabela varchar(5000),  
   @strSQLAnalitico varchar(8000), @strSQLColunasWRA varchar(2000),  
   @strSQLColunasWRS varchar(2000), @strSQLColunasSoma varchar(2000);  
  
SET @i = 0;  
SET @DataAux = @DataIni;  
SET @strNomeCampo = '';  
SET @strSQLColunasWRA = '';  
SET @strSQLColunasWRS = '';  
SET @strSQLColunasSoma = '';  
SET @strCriaTabela = 'CREATE TABLE #tempRelGastosMensaisDESPESA (Grupo int, Conta varchar(18) COLLATE database_default, Nome varchar(50) COLLATE database_default ';  
  
  
/*Gera as colunas de cada mês - limitado a 12 meses (12 colunas)*/  
WHILE (@i <= (SELECT DATEDIFF(m, @DataIni, @DataFim))) AND (@i < 12)  
BEGIN  
 SELECT @strMes =  
 CASE month(@DataAux)  
    WHEN 1 THEN 'Jan_'  
    WHEN 2 THEN 'Fev_'  
    WHEN 3 THEN 'Mar_'  
    WHEN 4 THEN 'Abr_'  
    WHEN 5 THEN 'Mai_'  
    WHEN 6 THEN 'Jun_'  
    WHEN 7 THEN 'Jul_'  
    WHEN 8 THEN 'Ago_'  
    WHEN 9 THEN 'Set_'  
    WHEN 10 THEN 'Out_'  
    WHEN 11 THEN 'Nov_'  
    WHEN 12 THEN 'Dez_'  
   END  
 SET @strSQLColunasWRA = @strSQLColunasWRA + ', SUM(CASE WHEN Month(WRA.DataDespesa) = ' + CAST(Month(@DataAux) AS varchar(2)) + ' and Year(WRA.DataDespesa) = ' + CAST(Year(@DataAux) AS varchar(4)) + ' THEN isnull(WRA.ValorEfetivo,0) ELSE 0 END) AS ' +  @strMes 
+ CAST(Year(@DataAux) AS varchar(4)) + ' ';  
 SET @strSQLColunasWRS = @strSQLColunasWRS + ', SUM(CASE WHEN Month(WRS.DataDespesa) = ' + CAST(Month(@DataAux) AS varchar(2)) + ' and Year(WRS.DataDespesa) = ' + CAST(Year(@DataAux) AS varchar(4)) + ' THEN isnull(WRS.ValorEfetivo,0) ELSE 0 END) AS ' +  @strMes 
+ CAST(Year(@DataAux) AS varchar(4)) + ' ';  
 SET @strNomeCampo = @strNomeCampo + ', ' +  @strMes + CAST(Year(@DataAux) AS varchar(4));  
 SET @strCriaTabela = @strCriaTabela + ', ' +  @strMes + CAST(Year(@DataAux) AS varchar(4)) + ' Money';  
 SET @strSQLColunasSoma = @strSQLColunasSoma + ', SUM(' +  @strMes + CAST(Year(@DataAux) AS varchar(4)) + ') AS ' +  @strMes + CAST(Year(@DataAux) AS varchar(4)) + ' ';  
 SET @i = @i + 1;  
 SET @DataAux = DATEADD(m, 1, @DataAux);  
END  
  
SET @strCriaTabela = @strCriaTabela + ', Total Money) '  
  
SET @strSQLSintetico = 'INSERT INTO #tempRelGastosMensaisDESPESA select Grupo, CodConta, NomeConta ' + @strSQLColunasSoma +  
', Sum(Valor) Valor   
from   
(select PCA.Grupo, PCS.CodConta, PCS.NomeConta' + @strNomeCampo +  
', PCA.Valor from   
PlanoContas PCS,   
   (select PCRS.Grupo, PCRS.CodConta, PCRS.NomeConta' + @strSQLColunasWRS +  
   ', SUM(IsNull(WRS.ValorEfetivo,0)) AS Valor   
   from (PlanoContas PCRS LEFT JOIN Web_Despesas WRS  
   ON WRS.IdConta = PCRS.IdConta AND WRS.Status IN (''Pendente'',''Aceito'')   
   AND WRS.DataDespesa BETWEEN ''' + CONVERT(varchar(8),@DataIni, 112) + ''' AND ''' + CONVERT(varchar(8),@DataFim, 112) + ''' '  
IF @CentroCusto <> ''  
BEGIN  
   SET @strSQLSintetico = @strSQLSintetico + 'AND WRS.IdCentroCusto = ' + @CentroCusto + ' '  
END  
SET @strSQLSintetico = @strSQLSintetico + ')where PCRS.Analitico = 1 and PCRS.Grupo IN (4,5)   
   Group By PCRS.Grupo, PCRS.CodConta, PCRS.NomeConta) PCA   
where PCS.Analitico = 0 AND ISNULL(PCS.Exercicio,0) = CASE WHEN (SELECT TOP 1 1 FROM PlanoContas PC WHERE PC.Exercicio = ''' + CONVERT(varchar(4),@DataIni, 112) + ''') = 1 THEN ''' + CONVERT(varchar(4),@DataIni, 112) + ''' ELSE 0 END and   
SubString(PCA.CodConta,1,  
CASE WHEN (substring(PCS.CodConta,len(PCS.CodConta)-1,1) <> 0) AND (substring(pcs.CodConta,len(PCS.CodConta),1) = 0) THEN  
Len(Replace(RTrim(replace(PCS.CodConta,''0'','' '')),'' '',''0'')) + 1  
 ELSE  
 CASE WHEN Len(Replace(RTrim(replace(PCS.CodConta,''0'','' '')),'' '',''0'')) IN (3,5,7,9) THEN  
  Len(Replace(RTrim(replace(PCS.CodConta,''0'','' '')),'' '',''0'')) + 1  
 ELSE  
  Len(Replace(RTrim(replace(PCS.CodConta,''0'','' '')),'' '',''0'')) END END  
 ) =  
CASE WHEN (substring(PCS.CodConta,len(PCS.CodConta)-1,1) <> 0) AND (substring(pcs.CodConta,len(PCS.CodConta),1) = 0) THEN  
 Replace(RTrim(replace(PCS.CodConta,''0'','' '')),'' '',''0'') + ''0''  
 ELSE  
 CASE WHEN Len(replace(PCS.CodConta,''0'','' '')) IN (3,5,7,9) THEN  
  Replace(RTrim(replace(PCS.CodConta,''0'','' '')),'' '',''0'') + ''0''  
 ELSE  
  Replace(RTrim(replace(PCS.CodConta,''0'','' '')),'' '',''0'') END END '
SET @strSQLAnalitico = ' Union all   
select PCR1.Grupo, PCR1.CodConta, PCR1.NomeConta' + @strSQLColunasWRA + ', SUM(IsNull(WRA.ValorEfetivo,0)) AS Valor   
from (PlanoContas PCR1 LEFT JOIN Web_Despesas WRA  
  ON WRA.IdConta = PCR1.IdConta AND WRA.Status IN (''Pendente'',''Aceito'')   
  AND WRA.DataDespesa BETWEEN ''' + CONVERT(varchar(8),@DataIni, 112) + ''' AND ''' + CONVERT(varchar(8),@DataFim, 112) + ''' '  
IF @CentroCusto <> ''  
BEGIN  
  SET @strSQLAnalitico = @strSQLAnalitico + 'AND WRA.IdCentroCusto = ' + @CentroCusto + ' '  
END  
SET @strSQLAnalitico = @strSQLAnalitico + ') where PCR1.Analitico = 1 and PCR1.Grupo IN (4,5) 
AND ISNULL(PCR1.Exercicio,0) = CASE WHEN (SELECT TOP 1 1 FROM PlanoContas PC WHERE PC.Exercicio = ''' + CONVERT(varchar(4),@DataIni, 112) + ''') = 1 THEN ''' + CONVERT(varchar(4),@DataIni, 112) + ''' ELSE 0 END     
Group By PCR1.Grupo, PCR1.CodConta, PCR1.NomeConta) PlanoContas   
where Grupo > 2 and len(CodConta)>=6   
Group By Grupo, CodConta, NomeConta '  
IF @SomenteCMovimento = 1   
begin  
  SET @strSQLAnalitico = @strSQLAnalitico + 'HAVING Sum(Valor) > 0 '  
END  
  
SET @strSQLAnalitico = @strSQLAnalitico + 'Order By Grupo, CodConta '  
  
SET @strSQLAnalitico = @strSQLAnalitico + 'INSERT INTO #tempRelGastosMensaisDESPESA SELECT NULL, NULL, ''Total Despesas''' + @strSQLColunasWRA +   
', SUM(IsNull(WRA.ValorEfetivo,0)) AS Valor FROM Web_Despesas WRA INNER JOIN PlanoContas PC ON PC.IdConta = WRA.IdConta AND PC.Grupo IN (4,5) WHERE WRA.DataDespesa BETWEEN ''' +   
CONVERT(varchar(8),@DataIni, 112) + ''' AND ''' + CONVERT(varchar(8),@DataFim, 112) + ''' AND WRA.Status IN (''Pendente'',''Aceito'') '  
IF @CentroCusto <> ''  
BEGIN  
  SET @strSQLAnalitico = @strSQLAnalitico + 'AND WRA.IdCentroCusto = ' + @CentroCusto + ' '  
END  
  
SET @strSQLAnalitico = @strSQLAnalitico + ' SELECT * FROM #tempRelGastosMensaisDESPESA '  
SET @strSQLAnalitico = @strSQLAnalitico + ' DROP TABLE #tempRelGastosMensaisDESPESA '  
  
EXEC(@strCriaTabela + @strSQLSintetico + @strSQLAnalitico)  
  
  
