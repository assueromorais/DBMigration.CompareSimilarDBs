/* OC 17219 - Rodrigo Souza */ 
/* OC 60144 - Andre */
/*André - 25/05/2010 - Oc 62835*/
CREATE PROCEDURE [dbo].[Sp_CalculaPlano]   
@DataInicial datetime,   
@DataFinal datetime,   
@IncluiEncerramento bit = 1,   
@IncluiAnaliticas bit = 1,   
@IncluiGrupo1 bit = 1,   
@IncluiGrupo2 bit = 1,   
@IncluiGrupo3 bit = 1,   
@IncluiGrupo4 bit = 1,   
@IncluiGrupo5 bit = 1,   
@IncluiGrupo6 bit = 1,   
@Comparativo bit = 0,   
--FluxoCaixa-demanda 7239******************************************************************************   
@MostraDadosSiscontw bit = 1,   
--*****************************************************************************************************   
@Exercicio varchar(4) = '',  -- Plurianual
@Exercicio2 varchar(4) = @Exercicio
   
AS

DECLARE @ExercicioAtual VARCHAR(4), @ExercicioAtual2 VARCHAR(4)
SELECT @ExercicioAtual = CASE WHEN (SELECT TOP 1 1 FROM PlanoContas WHERE Exercicio = @Exercicio) = 1 THEN @Exercicio ELSE 0 END      
IF @Exercicio2 <> @Exercicio
	SELECT @ExercicioAtual2 = CASE WHEN (SELECT TOP 1 1 FROM PlanoContas WHERE Exercicio = @Exercicio2) = 1 THEN @Exercicio2 ELSE 0 END      
ELSE
	SET @ExercicioAtual2 = @ExercicioAtual

SET NOCOUNT ON   
   
DECLARE @TemFilho BIT   
SET @TemFilho = 0   
   
--FluxoCaixa-demanda 7239******************************************************************************   
-- A tabela movimentos foi substituida pela #MOVTEMP   
CREATE TABLE #MOVTEMP   
 (   
  IdMovimento int,   
  IdLancamento int,   
  IdConta int,   
                DataLancamento datetime,   
    ValorDebito  money,   
    ValorCredito money   
 )   
   
INSERT #MOVTEMP   
  SELECT   
  IdMovimento,   
  IdLancamento,   
  IdConta,   
  DataLancamento,   
  ValorDebito,   
  ValorCredito   
  FROM Movimentos   
   
IF @MostraDadosSiscontw = 0    
BEGIN   
DELETE #MOVTEMP   
WHERE IdMovimento in(SELECT Mv.IdMovimento FROM Movimentos Mv,Lancamentos Lc                  
                      WHERE Mv.IdLancamento = Lc.IdLancamento AND Lc.Origem IS NULL)   
END   
--*****************************************************************************************************   
    
CREATE TABLE #TABMOV   
 (   
  Grupo  int,   
    CodConta varchar(18) COLLATE database_default,   
    Debitos  money,   
    Creditos money   
 )   
CREATE INDEX TEMPIND ON #TABMOV (Grupo, CodConta, Debitos, Creditos)   
IF @IncluiEncerramento= 1   
 INSERT #TABMOV   
  SELECT DISTINCT
  Grupo,   
  CodConta,   
  Sum(ValorDebito),   
  Sum(ValorCredito)   
  FROM   
  PlanoContas, #MOVTEMP   
  WHERE   
  PlanoContas.IdConta= #MOVTEMP.IdConta and   
  ISNULL(PlanoContas.Exercicio, 0) IN (@ExercicioAtual, @ExercicioAtual2) AND -- OC 17219 - Rodrigo - Plurianual   	
  #MOVTEMP.DataLancamento >= @DataInicial and   
  #MOVTEMP.DataLancamento <= @DataFinal and   
  (   
  (PlanoContas.Grupo= 1 and @IncluiGrupo1= 1) or   
  (PlanoContas.Grupo= 2 and @IncluiGrupo2= 1) or   
  (PlanoContas.Grupo= 3 and @IncluiGrupo3= 1) or   
  (PlanoContas.Grupo= 4 and @IncluiGrupo4= 1) or   
  (PlanoContas.Grupo= 5 and @IncluiGrupo5= 1) or   
  (PlanoContas.Grupo= 6 and @IncluiGrupo6= 1)   
  )   
  GROUP BY   
  Grupo, CodConta   
ELSE   
 INSERT #TABMOV   
  SELECT DISTINCT  
  Grupo,   
  CodConta,   
  Sum(ValorDebito),   
  Sum(ValorCredito)   
  FROM   
  PlanoContas, #MOVTEMP, Lancamentos   
  WHERE   
  ISNULL(PlanoContas.Exercicio, 0) IN (@ExercicioAtual, @ExercicioAtual2) AND -- OC 17219 - Rodrigo - Plurianual   	
  PlanoContas.IdConta= #MOVTEMP.IdConta and   
  #MOVTEMP.IdLancamento= Lancamentos.IdLancamento and   
  Lancamentos.Encerramento= 0 and   
  #MOVTEMP.DataLancamento >= @DataInicial and   
  #MOVTEMP.DataLancamento <= @DataFinal and   
  (   
  (PlanoContas.Grupo= 1 and @IncluiGrupo1= 1) or   
  (PlanoContas.Grupo= 2 and @IncluiGrupo2= 1) or   
  (PlanoContas.Grupo= 3 and @IncluiGrupo3= 1) or   
  (PlanoContas.Grupo= 4 and @IncluiGrupo4= 1) or   
  (PlanoContas.Grupo= 5 and @IncluiGrupo5= 1) or   
  (PlanoContas.Grupo= 6 and @IncluiGrupo6= 1)   
  )   
  GROUP BY   
  Grupo, CodConta   
CREATE TABLE #TABINI   
 (   
  Grupo  int,   
  CodConta varchar(18) COLLATE database_default,   
  SaldoInicial money   
 )   
CREATE INDEX TEMPIND ON #TABINI (Grupo, CodConta, SaldoInicial)   
DECLARE @idconta int, @datasaldo datetime   
   
IF @Comparativo = 0   
BEGIN   
 IF SUBSTRING(CONVERT(VARCHAR, @DataInicial, 112),5,4) = '1231'   
 BEGIN    
  DECLARE saldos_cursor CURSOR FAST_FORWARD FOR   
   SELECT IdConta, Max(DataSaldo) as DataSaldo   
   FROM SaldosIniciais   
   WHERE DataSaldo <= @DataInicial   
   AND YEAR(DataSaldo) <= YEAR(@DataInicial)-1   
   GROUP BY IdConta   
     OPEN saldos_cursor   
     FETCH NEXT FROM saldos_cursor   
     INTO @idconta, @datasaldo   
 END   
 ELSE   
 BEGIN    
  DECLARE saldos_cursor CURSOR FAST_FORWARD FOR   
         SELECT IdConta, Max(DataSaldo) as DataSaldo   
         FROM SaldosIniciais   
   WHERE DataSaldo <= @DataInicial   
   GROUP BY IdConta   
     OPEN saldos_cursor   
     FETCH NEXT FROM saldos_cursor   
     INTO @idconta, @datasaldo   
    
 END   
END   
ELSE   
BEGIN   
 /* Se não existe movimento no ano selecionado */   
 IF (SELECT COUNT(IdMovimento) Total FROM #MOVTEMP WHERE YEAR(DataLancamento) = YEAR(@DataInicial)) = 0     
 BEGIN   
  /* Seleciona o saldo inicial do proximo ano */   
  DECLARE saldos_cursor CURSOR FAST_FORWARD FOR   
   SELECT IdConta, Max(DataSaldo) as DataSaldo   
   FROM SaldosIniciais   
   WHERE DataSaldo <= @DataInicial   
   AND YEAR(DataSaldo) = YEAR(@DataInicial)   
   GROUP BY IdConta   
     OPEN saldos_cursor   
     FETCH NEXT FROM saldos_cursor   
     INTO @idconta, @datasaldo   
 END   
 ELSE   
 BEGIN   
  /* Seleciona o saldo inicial do ano anterior */   
  DECLARE saldos_cursor CURSOR FAST_FORWARD FOR   
   SELECT IdConta, Max(DataSaldo) as DataSaldo   
   FROM SaldosIniciais   
   WHERE DataSaldo <= @DataInicial   
   AND YEAR(DataSaldo) <= YEAR(@DataInicial)-1   
   GROUP BY IdConta   
     OPEN saldos_cursor   
     FETCH NEXT FROM saldos_cursor   
     INTO @idconta, @datasaldo   
 END   
END   
   
WHILE @@FETCH_STATUS = 0   
BEGIN   
 INSERT #TABINI   
    SELECT DISTINCT  
  Grupo,   
  CodConta,   
  Saldo   
  FROM   
  PlanoContas, SaldosIniciais   
  WHERE   
  ISNULL(PlanoContas.Exercicio, 0) IN (@ExercicioAtual, @ExercicioAtual2) AND -- OC 17219 - Rodrigo - Plurianual   	
  PlanoContas.IdConta= SaldosIniciais.IdConta and   
  SaldosIniciais.IdConta = @idconta and   
  SaldosIniciais.DataSaldo = @datasaldo    
     
 INSERT #TABINI   
  SELECT DISTINCT  
  Grupo,   
  CodConta,   
  Sum(IsNull(ValorDebito,0))-Sum(IsNull(ValorCredito,0))   
  FROM   
  PlanoContas, #MOVTEMP   
  WHERE   
  ISNULL(PlanoContas.Exercicio, 0) IN (@ExercicioAtual, @ExercicioAtual2) AND -- OC 17219 - Rodrigo - Plurianual   	
  PlanoContas.IdConta= @idconta and   
  PlanoContas.IdConta= #MOVTEMP.IdConta and      
  #MOVTEMP.DataLancamento > @datasaldo and   
  #MOVTEMP.DataLancamento < @DataInicial   
  GROUP BY   
  Grupo, CodConta   
 FETCH NEXT FROM saldos_cursor   
 INTO @idconta, @datasaldo   
END   
CLOSE saldos_cursor   
DEALLOCATE saldos_cursor   
  
INSERT #TABINI   
 SELECT DISTINCT  
 Grupo,   
 CodConta,   
 Sum(IsNull(ValorDebito,0))-Sum(IsNull(ValorCredito,0))   
 FROM   
 PlanoContas, #MOVTEMP   
 WHERE   
 ISNULL(PlanoContas.Exercicio, 0) IN (@ExercicioAtual, @ExercicioAtual2) AND -- OC 17219 - Rodrigo - Plurianual   	
 PlanoContas.Grupo < 3 and   
 PlanoContas.IdConta= #MOVTEMP.IdConta and    
 PlanoContas.CodConta Not Like '241%' and   
 PlanoContas.CodConta Not Like '332%' and   
 PlanoContas.CodConta Not Like '341%' and   
 #MOVTEMP.DataLancamento < @DataInicial and   
 PlanoContas.CodConta Not in (Select Distinct CodConta From #TABINI)   --- MODIFICAR 
 GROUP BY   
 Grupo, CodConta  

IF NOT EXISTS (SELECT TOP 1 1 FROM #TABINI)
INSERT #TABINI   
SELECT
Grupo,   
CodConta, 
Saldo + Sum(IsNull(ValorDebito,0))-Sum(IsNull(ValorCredito,0))   
FROM ( 
		SELECT DISTINCT  
		Grupo,   
		CodConta,
		( 
			SELECT IdConta 
			FROM PlanoContas PC1 
			WHERE  PC1.CodConta = (SELECT CodConta FROM PlanoContas PC2 WHERE PC2.IdConta = PlanoContas.IdConta) 
			AND ISNULL(Exercicio,0) = CASE WHEN (SELECT TOP 1 1 FROM PlanoContas PC3 WHERE PC3.Exercicio = @Exercicio-1) = 1 THEN @Exercicio-1 ELSE 0 END 
		) IdContaAnterior
		FROM   
		PlanoContas   
		WHERE ISNULL(PlanoContas.Exercicio, 0) IN (@ExercicioAtual, @ExercicioAtual2) AND PlanoContas.Grupo < 3   
		AND PlanoContas.CodConta Not Like '241%'    
		AND PlanoContas.CodConta Not Like '332%' 
		AND PlanoContas.CodConta Not Like '341%'    
	) tblTempPluriAnual, #MOVTEMP, SaldosIniciais
WHERE tblTempPluriAnual.IdContaAnterior = #MOVTEMP.IdConta
AND tblTempPluriAnual.IdContaAnterior = SaldosIniciais.IdConta AND SaldosIniciais.DataSaldo = @datasaldo     
AND #MOVTEMP.DataLancamento > @datasaldo  
AND #MOVTEMP.DataLancamento < @DataInicial  
GROUP BY Grupo, CodConta, Saldo  
  
INSERT #TABINI   
 SELECT DISTINCT  
 Grupo,   
 CodConta,   
 Sum(IsNull(ValorDebito,0))-Sum(IsNull(ValorCredito,0))   
 FROM   
 PlanoContas, #MOVTEMP   
 WHERE     
 ISNULL(PlanoContas.Exercicio, 0) IN (@ExercicioAtual, @ExercicioAtual2) AND -- OC 17219 - Rodrigo - Plurianual   	
 PlanoContas.IdConta= #MOVTEMP.IdConta and    
 #MOVTEMP.DataLancamento < @DataInicial and   
 Year(#MOVTEMP.DataLancamento)= Year(@DataInicial) and   
 (((PlanoContas.CodConta Like '241%' or   
 PlanoContas.CodConta Like '332%' or   
 PlanoContas.CodConta Like '341%') and   
 (PlanoContas.Grupo < 3))  or   
 (PlanoContas.Grupo > 2)) and   
 PlanoContas.CodConta Not in (Select Distinct CodConta From #TABINI)    
 GROUP BY   
 Grupo, CodConta   
   
CREATE TABLE #TABTEMP1   
 (   
  Grupo  int,   
  CodConta varchar(27) COLLATE database_default,   
  NomeConta varchar(50) COLLATE database_default,   
  Analitico bit,   
  SaldoInicial money,   
  Debitos  money,   
  Creditos money   
 )   
DECLARE @grupo int, @codconta varchar(18), @nomeconta varchar(50), @analitico bit, @codaux varchar(18), @i int, @contaformatada varchar(27), @saldoinicial money   
DECLARE plano_cursor CURSOR FAST_FORWARD FOR    
 SELECT DISTINCT Grupo, CodConta, NomeConta, Analitico   
 FROM PlanoContas   
 WHERE  
 ISNULL(PlanoContas.Exercicio, 0) IN (@ExercicioAtual, @ExercicioAtual2) AND -- OC 17219 - Rodrigo - Plurianual   	
 (Analitico= 0 or   
 Analitico= @IncluiAnaliticas) and   
 (   
 (PlanoContas.Grupo= 1 and @IncluiGrupo1= 1) or   
 (PlanoContas.Grupo= 2 and @IncluiGrupo2= 1) or   
 (PlanoContas.Grupo= 3 and @IncluiGrupo3= 1) or   
 (PlanoContas.Grupo= 4 and @IncluiGrupo4= 1) or   
 (PlanoContas.Grupo= 5 and @IncluiGrupo5= 1) or   
 (PlanoContas.Grupo= 6 and @IncluiGrupo6= 1)   
 )   
 ORDER BY Grupo, Codconta   
OPEN plano_cursor   
FETCH NEXT FROM plano_cursor   
INTO @grupo, @codconta, @nomeconta, @analitico   
   
WHILE @@FETCH_STATUS = 0   
BEGIN   
 SET @contaformatada= Left(@codconta, 1)   
 SET @codaux= @codconta   
 IF @grupo> 2    
  BEGIN   
    IF @analitico= 0   
      SET @codaux= replace(rtrim(replace(@codconta, '0', ' ')),' ','0')   
   
  IF (LEN(@codaux) > 1) AND (LEN(@codaux) % 2) <> 0   
  BEGIN
	IF @codconta = '313240'
	BEGIN
	  PRINT @Exercicio
	  PRINT @ExercicioAtual
	END
	EXECUTE Sp_CalculaContaFilho @codconta, @grupo, @ExercicioAtual, @TemFilho OUTPUT   
    IF @TemFilho = 1    
		SET @codaux = @codaux + '0'   
  END   
   
  SET @i= 2   
  WHILE @i <= len(@codconta)   
     BEGIN       
       IF @i < 4   
                SET @contaformatada= @contaformatada + '.'   
       ELSE   
        IF @i % 2 = 1   
          SET @contaformatada= @contaformatada + '.'   
       SET @contaformatada= @contaformatada + substring(@codconta,@i,1)   
       SET @i= (@i + 1)   
     END   
  END   
  ELSE   
  BEGIN           
    SET @i= 2   
    WHILE @i <= len(@codconta)   
  BEGIN      
       IF @i < 5   
                SET @contaformatada= @contaformatada + '.'   
       ELSE   
        IF @i % 2 = 0    
          SET @contaformatada= @contaformatada + '.'   
       SET @contaformatada= @contaformatada + substring(@codconta,@i,1)   
       SET @i= @i + 1   
     END   
  END   
  SET @saldoinicial=(   
  SELECT IsNull(Sum(SaldoInicial),0)   
  FROM   
  #TABINI   
  WHERE   
  #TABINI.Grupo = @grupo and   
  #TABINI.CodConta >= @codaux  and   
  #TABINI.CodConta < (@codaux+'a'))   
   
 INSERT #TABTEMP1   
  SELECT   
  @grupo,   
  @contaformatada,   
  @nomeconta,   
  @analitico,   
  @saldoinicial,   
  IsNull(Sum(Debitos), 0),   
  IsNull(Sum(Creditos), 0)   
  FROM   
  #TABMOV   
  WHERE   
  #TABMOV.Grupo = @grupo and   
  #TABMOV.CodConta >= @codaux  and   
  #TABMOV.CodConta < (@codaux+'a')   
 FETCH NEXT FROM plano_cursor   
  INTO @grupo, @codconta, @nomeconta, @analitico   
END   
CLOSE plano_cursor   
DEALLOCATE plano_cursor   
   
SELECT *, SaldoInicial + Debitos - Creditos AS Saldo FROM #TABTEMP1     
   
DROP TABLE #TABINI   
DROP TABLE #TABTEMP1    
DROP TABLE #TABMOV   
--FluxoCaixa-demanda 7239******************************************************************************   
DROP TABLE #MOVTEMP   
--*****************************************************************************************************
