CREATE PROCEDURE [dbo].[spMigracao_ConfereExercicioAtual] (
@ExercicioAnterior INT, @ExercicioAtual INT, @ExercicioEfetivo INT
)
AS

/*
* Observação=
* o exercício anterior é 1 ano a menos que o exercício efetivo.
* o exercício atual é o ano da data do servidor.(Obs= não pode ser menor que o ano efetivo).
* o exercício efetivo é o ano em que está o plano de contas. (obs= ele pode ser igual ou menor ao atual).
* 
* Registros faltantes= é o número de registros que estão no exercício anterior
*                      e que não tem correspondente no exercício atual.
* Registros incorretos= é o número de registros os quais as datas estão no exercício atual,
*                       porém as contas não pertencem ao exercício efetivo.
*                       
* Exemplo=  Para anterior = 2009, atual = 2010 e efetivo = 2010 
*				(desta maneira vai testar o ano de 2010, verificando os registros da data atual = 2010, 
*				 se estes estão com as contas realmente no exercicio efetivo é 2010).
*
*           Para anterior = 2010, atual = 2011 e efetivo = 2011 
*				(desta maneira vai testar o ano de 2011, verificando os registros da data atual = 2011, 
*				 se estes estão com as contas realmente no exercicio efetivo é 2011).
*					 
*  	    Para anterior = 2009, atual = 2011 e efetivo = 2010
*			        (é o caso quando já virou o ano de 2010 e ainda não migrou para 2011,
*			         desta maneira a data atual está em 2011, porém o plano de contas efetivo é 2010.            
*                           
*/

SET NOCOUNT ON

Declare @CodErro tinyint, @ConferirRegistrosFaltantes tinyint, @MsgErro varchar(2000), 
@QtdRegistros_Incorretos INT,  @QtdRegistros_faltantes INT, @IdscomProblema VARCHAR(8000)


SET @CodErro = 0
SET @ConferirRegistrosFaltantes = 1
SET @MsgErro = 'Dados Corretos.'
  
  
IF (@ExercicioAnterior IS NULL)  
BEGIN
    Set @CodErro = 1
	Set @MsgErro = 'Exercício anterior inválido.'
END
ELSE
IF NOT EXISTS (SELECT 1 FROM PlanoContas WHERE Exercicio = @ExercicioAnterior)
BEGIN
  Set @ExercicioAnterior = 0
END
       
   
IF (@ExercicioAtual IS NULL) 
BEGIN
   Set @CodErro = 1
   Set @MsgErro = 'Exercício atual inválido.'
END 

IF (@ExercicioEfetivo IS NULL) 
BEGIN
   Set @CodErro = 1
   Set @MsgErro = 'Exercício efetivo inválido.'
END 


IF NOT EXISTS (SELECT 1 FROM PlanoContas WHERE Exercicio = @ExercicioAtual)
BEGIN
  	SET @ConferirRegistrosFaltantes = 0
END
  
  
CREATE TABLE #tabtemp_Resultado
(
  	Seq               SMALLINT IDENTITY(1, 1),
  	Erro                   BIT,
  	CampoVerificado        VARCHAR(25),
  	TabelaComProblema      VARCHAR(50),
  	CampoId                VARCHAR(50),
  	QtdRegistros	       INT,
  	IdscomProblema	       VARCHAR(8000)
)   
  
---------------------  Inicio Validação  -----------------------
  
IF (@CodErro = 0) AND (@ConferirRegistrosFaltantes = 1)
BEGIN
  /***** Conferindo Plano de Contas *****/
      
  SELECT @QtdRegistros_faltantes = Count(pc.IdConta) 
  FROM PlanoContas pc 
  WHERE pc.codConta NOT IN (SELECT pc2.CodConta FROM Planocontas pc2 WHERE pc2.Exercicio = @ExercicioAtual)
    AND ISNULL(pc.Exercicio,0) = @ExercicioAnterior   

  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + cast(pc.IdConta AS VARCHAR(15)) + ',' 
	 FROM PlanoContas pc 
	 WHERE pc.codConta NOT IN (SELECT pc2.CodConta FROM Planocontas pc2 WHERE pc2.Exercicio = @ExercicioAtual)
     AND ISNULL(pc.Exercicio, 0) = @ExercicioAnterior   
           
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'CodConta', 'PlanoContas', 'IdConta', @QtdRegistros_faltantes, @IdscomProblema)         
  END        


/***** Conferindo GruposPersonalizados *****/
  
  SELECT @QtdRegistros_faltantes = COUNT(GCP.IdGrupoContaPersonalizado)
  FROM   GruposContasPersonalizados AS GCP
         INNER JOIN PlanoContas AS PC
              ON  GCP.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT Top 1 GCP2.IdConta
                  FROM   GruposContasPersonalizados AS GCP2
                  WHERE  GCP2.IdConta IN (SELECT PC2.IdConta
                                          FROM   PlanoContas AS PC2
                                          WHERE  PC2.codConta = PC.codConta
                                                 AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(GCP.IdGrupoContaPersonalizado AS VARCHAR(15)) + ','
     FROM   GruposContasPersonalizados AS GCP
            INNER JOIN PlanoContas AS PC
                 ON  GCP.IdConta = PC.IdConta
                 AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
     WHERE  ISNULL(( SELECT Top 1 GCP2.IdConta
                     FROM   GruposContasPersonalizados AS GCP2
                     WHERE  GCP2.IdConta IN (SELECT PC2.IdConta
                                             FROM   PlanoContas AS PC2
                                             WHERE  PC2.codConta = PC.codConta
                                                    AND PC2.Exercicio = @ExercicioAtual)),0) = 0
            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdConta', 'GruposContasPersonalizados', 'IdGrupoContaPersonalizado', @QtdRegistros_faltantes, @IdscomProblema)         
  END


/***** Conferindo ContasPersonalizada *****/
  
  SELECT @QtdRegistros_faltantes = COUNT(CP.IdContaPersonalizada)
  FROM   ContasPersonalizada AS CP
         INNER JOIN PlanoContas AS PC ON CP.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT Top 1 CP2.IdConta
                  FROM   ContasPersonalizada AS CP2
                  WHERE  CP2.IdConta IN (SELECT PC2.IdConta
                                          FROM   PlanoContas AS PC2
                                          WHERE  PC2.codConta = PC.codConta
                                                 AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(CP.IdContaPersonalizada AS VARCHAR(15)) + ','
     FROM   ContasPersonalizada AS CP
            INNER JOIN PlanoContas AS PC ON CP.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
     WHERE  ISNULL(( SELECT Top 1 CP2.IdConta
                  FROM   ContasPersonalizada AS CP2
                  WHERE  CP2.IdConta IN (SELECT PC2.IdConta
                                          FROM   PlanoContas AS PC2
                                          WHERE  PC2.codConta = PC.codConta
                                                 AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdConta', 'ContasPersonalizada', 'IdContaPersonalizada', @QtdRegistros_faltantes, @IdscomProblema)         
  END


/***** Conferindo Centros de Custo *****/
  
  SELECT @QtdRegistros_faltantes = Count(cc.IdCentroCusto) 
  FROM CentroCustos cc 
  WHERE cc.CodigoCentroCusto NOT IN 
    (SELECT cc2.CodigoCentroCusto FROM CentroCustos cc2 WHERE cc2.Exercicio = @ExercicioAtual)
     AND ISNULL(cc.Exercicio, 0) = @ExercicioAnterior   

  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + cast(cc.IdCentroCusto AS VARCHAR(15)) + ',' 
     FROM CentroCustos cc 
     WHERE cc.CodigoCentroCusto NOT IN 
        (SELECT cc2.CodigoCentroCusto FROM CentroCustos cc2 WHERE cc2.Exercicio = @ExercicioAtual)
         AND ISNULL(cc.Exercicio,0) = @ExercicioAnterior    
           
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'CodigoCentroCusto', 'CentroCustos', 'IdCentroCusto', @QtdRegistros_faltantes, @IdscomProblema)         
  END        

  
  /***** Conferindo SubAreas *****/

  SELECT @QtdRegistros_faltantes = COUNT(S.IdSubArea)
  FROM   SubAreas S
         INNER JOIN CentroCustos AS CC
              ON  S.IdCentroCusto = CC.IdCentroCusto
              AND ISNULL(CC.Exercicio,0) = @ExercicioAnterior
  WHERE  ISNULL((SELECT Top 1 S2.IdCentroCusto
                 FROM   SubAreas AS S2
                 WHERE  S2.IdCentroCusto IN (SELECT CC2.IdCentroCusto
                                             FROM   CentroCustos AS CC2
                                             WHERE  CC2.CodigoCentroCusto = CC.CodigoCentroCusto
                                                    AND CC2.Exercicio = @ExercicioAtual)),0) = 0
     
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + cast(S.IdSubArea AS VARCHAR(15)) + ',' 
     FROM SubAreas S 
	 INNER JOIN CentroCustos AS CC ON S.IdCentroCusto = CC.IdCentroCusto AND ISNULL(CC.Exercicio,0) = @ExercicioAnterior
	 WHERE  ISNULL((SELECT Top 1 S2.IdCentroCusto
               FROM   SubAreas AS S2
               WHERE  S2.IdCentroCusto IN (SELECT CC2.IdCentroCusto
                                           FROM   CentroCustos AS CC2
                                           WHERE  CC2.CodigoCentroCusto = CC.CodigoCentroCusto
                                                  AND CC2.Exercicio = @ExercicioAtual)),0) = 0
                                                                                                    
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdCentroCusto', 'SubAreas', 'IdSubArea', @QtdRegistros_faltantes, @IdscomProblema)         
  END        


/***** Conferindo PlanoContasFinanceiro *****/

  SELECT @QtdRegistros_faltantes = COUNT(PCF.IdContaFinanceira)
  FROM   PlanoContasFinanceiro AS PCF
  WHERE  ISNULL(PCF.Exercicio,0) = @ExercicioAnterior AND
         ISNULL((SELECT Top 1 PCF2.IdContaFinanceira
                 FROM   PlanoContasFinanceiro AS PCF2
                 WHERE PCF2.NomeContaFinanceira = PCF.NomeContaFinanceira AND 
                       PCF2.Exercicio = @ExercicioAtual),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(PCF.IdContaFinanceira AS VARCHAR(15)) + ','
     FROM   PlanoContasFinanceiro AS PCF
     WHERE  ISNULL(PCF.Exercicio, 0) = @ExercicioAnterior AND
         ISNULL((SELECT Top 1 PCF2.IdContaFinanceira
                 FROM   PlanoContasFinanceiro AS PCF2
                 WHERE PCF2.NomeContaFinanceira = PCF.NomeContaFinanceira AND 
                       PCF2.Exercicio = @ExercicioAtual),0) = 0
            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'NomeContaFinanceira', 'PlanoContasFinanceiro', 'IdContaFinanceira', @QtdRegistros_faltantes, @IdscomProblema)         
  END

/***** Conferindo AssociaPlanoContasFinanceiro *****/

  SELECT @QtdRegistros_faltantes = COUNT( DISTINCT APCF.IdContaFinanceiraPai)
  FROM   AssociaPlanoContasFinanceiro AS APCF
  INNER JOIN PlanoContasFinanceiro AS PCF ON PCF.IdContaFinanceira = APCF.IdContaFinanceiraPai AND ISNULL(PCF.Exercicio, 0) = @ExercicioAnterior
  WHERE ISNULL(( SELECT Top 1 APCF2.IdContaFinanceiraPai
                 FROM  AssociaPlanoContasFinanceiro AS APCF2
                 INNER JOIN PlanoContasFinanceiro AS PCF2 ON PCF2.IdContaFinanceira = APCF2.IdContaFinanceiraPai
                 WHERE PCF2.NomeContaFinanceira = PCF.NomeContaFinanceira 
                       AND PCF2.Exercicio = @ExercicioAtual),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(APCF.IdContaFinanceiraPai AS VARCHAR(15)) + ','
     FROM   AssociaPlanoContasFinanceiro AS APCF
     INNER JOIN PlanoContasFinanceiro AS PCF ON PCF.IdContaFinanceira = APCF.IdContaFinanceiraPai AND ISNULL(PCF.Exercicio, 0) = @ExercicioAnterior
     WHERE ISNULL((SELECT  Top 1 APCF2.IdContaFinanceiraPai
                    FROM  AssociaPlanoContasFinanceiro AS APCF2
                    INNER JOIN PlanoContasFinanceiro AS PCF2 ON PCF2.IdContaFinanceira = APCF2.IdContaFinanceiraPai
                    WHERE PCF2.NomeContaFinanceira = PCF.NomeContaFinanceira 
                          AND PCF2.Exercicio = @ExercicioAtual), 0) = 0
     GROUP BY APCF.IdContaFinanceiraPai                    
            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdContaFinanceira', 'AssociaPlanoContasFinanceiro', 'IdContaFinanceiraPai', @QtdRegistros_faltantes, @IdscomProblema)         
  END


  /*************** Conferindo PlanoContasIntegracao ***************/
  
  SELECT @QtdRegistros_faltantes = COUNT(PCI.IdContaIntegracao)
  FROM   PlanoContasIntegracao AS PCI
         INNER JOIN PlanoContas AS PC
              ON  PCI.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT  Top 1 PCI2.IdConta
                  FROM   PlanoContasIntegracao AS PCI2
                  WHERE  PCI2.IdConta IN (SELECT PC2.IdConta
                                          FROM   PlanoContas AS PC2
                                          WHERE  PC2.codConta = PC.codConta
                                                 AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(PCI.IdContaIntegracao AS VARCHAR(15)) + ','
     FROM   PlanoContasIntegracao AS PCI
            INNER JOIN PlanoContas AS PC
              ON  PCI.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
     WHERE  ISNULL(( SELECT  Top 1 PCI2.IdConta
                     FROM   PlanoContasIntegracao AS PCI2
                     WHERE  PCI2.IdConta IN (SELECT PC2.IdConta
                                             FROM   PlanoContas AS PC2
                                             WHERE  PC2.codConta = PC.codConta
                                                    AND PC2.Exercicio = @ExercicioAtual)),0) = 0
            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdConta', 'PlanoContasIntegracao', 'IdContaIntegracao', @QtdRegistros_faltantes, @IdscomProblema)         
  END


/*************** Conferindo Tributos ***************/
  
  SELECT @QtdRegistros_faltantes = COUNT(T.IdTributo)
  FROM   Tributos AS T
         INNER JOIN PlanoContas AS PC
              ON  T.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT Top 1 T2.IdConta
                  FROM   Tributos AS T2
                  WHERE  T2.IdConta IN (SELECT PC2.IdConta
                                          FROM   PlanoContas AS PC2
                                          WHERE  PC2.codConta = PC.codConta
                                                 AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(T.IdTributo AS VARCHAR(15)) + ','
     FROM   Tributos AS T
            INNER JOIN PlanoContas AS PC
                 ON  T.IdConta = PC.IdConta
                 AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
     WHERE  ISNULL(( SELECT Top 1 T2.IdConta
                     FROM   Tributos AS T2
                     WHERE  T2.IdConta IN (SELECT PC2.IdConta
                                           FROM   PlanoContas AS PC2
                                           WHERE  PC2.codConta = PC.codConta
                                                  AND PC2.Exercicio = @ExercicioAtual)), 0) = 0
            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdConta',  'Tributos', 'IdTributo', @QtdRegistros_faltantes, @IdscomProblema)         
  END


/*************** Conferindo ValoresTributos ***************/
  
  SELECT @QtdRegistros_faltantes = COUNT(VT.IdTributo)
  FROM   ValoresTributos AS VT
  INNER JOIN Tributos AS T ON T.IdTributo = VT.IdTributo AND ISNULL(T.Exercicio, 0) = @ExercicioAnterior
  INNER JOIN PlanoContas AS PC ON  T.IdConta = PC.IdConta  AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE ISNULL(( SELECT  Top 1 VT2.IdTributo
                 FROM  ValoresTributos AS VT2
                 INNER JOIN Tributos AS T2 ON T2.IdTributo = VT2.IdTributo
                 WHERE  T2.IdConta IN (SELECT PC2.IdConta
                                       FROM   PlanoContas AS PC2
                                       WHERE  PC2.codConta = PC.codConta
                                       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(VT.IdTributo AS VARCHAR(15)) + ','
	 FROM   ValoresTributos AS VT
	 INNER JOIN Tributos AS T ON T.IdTributo = VT.IdTributo AND ISNULL(T.Exercicio, 0) = @ExercicioAnterior
	 INNER JOIN PlanoContas AS PC ON  T.IdConta = PC.IdConta  AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
	 WHERE ISNULL(( SELECT  Top 1 VT2.IdTributo
		            FROM  ValoresTributos AS VT2
			        INNER JOIN Tributos AS T2 ON T2.IdTributo = VT2.IdTributo
				    WHERE  T2.IdConta IN (SELECT PC2.IdConta
					                      FROM   PlanoContas AS PC2
						                  WHERE  PC2.codConta = PC.codConta
							              AND PC2.Exercicio = @ExercicioAtual)),0) = 0
              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdConta',  'ValoresTributos', 'IdTributo', @QtdRegistros_faltantes, @IdscomProblema)         
  END



/*************** Conferindo TributosPadroes ***************/
  
  SELECT @QtdRegistros_faltantes = COUNT(TP.IdTributo)
  FROM   TributosPadroes AS TP
  INNER JOIN Tributos AS T ON T.IdTributo = TP.IdTributo AND ISNULL(T.Exercicio, 0) = @ExercicioAnterior
  INNER JOIN PlanoContas AS PC ON  T.IdConta = PC.IdConta  AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE ISNULL(( SELECT  Top 1 TP2.IdTributo
                 FROM  TributosPadroes AS TP2
                 INNER JOIN Tributos AS T2 ON T2.IdTributo = TP2.IdTributo
                 WHERE  T2.IdConta IN (SELECT PC2.IdConta
                                       FROM   PlanoContas AS PC2
                                       WHERE  PC2.codConta = PC.codConta
                                       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(TP.IdTributo AS VARCHAR(15)) + ','
	 FROM   TributosPadroes AS TP
	 INNER JOIN Tributos AS T ON T.IdTributo = TP.IdTributo AND ISNULL(T.Exercicio, 0) = @ExercicioAnterior
     INNER JOIN PlanoContas AS PC ON  T.IdConta = PC.IdConta  AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
     WHERE ISNULL(( SELECT  Top 1 TP2.IdTributo
                    FROM  TributosPadroes AS TP2
                    INNER JOIN Tributos AS T2 ON T2.IdTributo = TP2.IdTributo
                    WHERE  T2.IdConta IN (SELECT PC2.IdConta
                                          FROM   PlanoContas AS PC2
                                          WHERE  PC2.codConta = PC.codConta
                                          AND PC2.Exercicio = @ExercicioAtual)),0) = 0
                                                
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdConta',  'TributosPadroes', 'IdTributo', @QtdRegistros_faltantes, @IdscomProblema)         
  END



 /*************** Conferindo RamosAtividadesContas ***************/
  
  SELECT @QtdRegistros_faltantes = COUNT(RAC.IdRamoAtividade)
  FROM   RamosAtividadeContas AS RAC
         INNER JOIN PlanoContas AS PC
              ON  RAC.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT  Top 1 RAC2.IdConta
                  FROM   RamosAtividadeContas AS RAC2
                  WHERE  RAC2.IdConta IN (SELECT PC2.IdConta
                                          FROM   PlanoContas AS PC2
                                          WHERE  PC2.codConta = PC.codConta
                                                 AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(RAC.IdRamoAtividade AS VARCHAR(15)) + ','
     FROM   RamosAtividadeContas AS RAC
            INNER JOIN PlanoContas AS PC
              ON  RAC.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
     WHERE  ISNULL(( SELECT  Top 1 RAC2.IdConta
                     FROM   RamosAtividadeContas AS RAC2
                     WHERE  RAC2.IdConta IN (SELECT PC2.IdConta
                                             FROM   PlanoContas AS PC2
                                             WHERE  PC2.codConta = PC.codConta
                                                    AND PC2.Exercicio = @ExercicioAtual)),0) = 0

            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdConta',  'RamosAtividadeContas', 'IdRamoAtividade', @QtdRegistros_faltantes, @IdscomProblema)         
  END


/*************** Conferindo PessoasTributos ***************/
  
  SELECT @QtdRegistros_faltantes = Count(PT.IdPessoaTributo) 
  FROM PessoasTributos PT 
  WHERE ISNULL(PT.Exercicio, 0) = @ExercicioAnterior    
        AND ISNULL((SELECT  Top 1 PT2.IdPessoaTributo
                    FROM   PessoasTributos AS PT2
                    WHERE  PT2.IdPessoa  = PT.IdPessoa AND 
                           PT2.Exercicio = @ExercicioAtual),0) = 0
 
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + cast(PT.IdPessoaTributo AS VARCHAR(15)) + ',' 
	 FROM PessoasTributos PT 
     WHERE ISNULL(PT.Exercicio, 0) = @ExercicioAnterior    
           AND ISNULL((SELECT  Top 1 PT2.IdPessoaTributo
                       FROM   PessoasTributos AS PT2
                       WHERE  PT2.IdPessoa  = PT.IdPessoa AND 
                              PT2.Exercicio = @ExercicioAtual),0) = 0   
           
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdPessoa', 'PessoasTributos', 'IdPessoaTributo', @QtdRegistros_faltantes, @IdscomProblema)         
  END        



/*************** Conferindo Bancos ***************/
  
  SELECT @QtdRegistros_faltantes = COUNT(B.IdBanco)
  FROM   Bancos AS B
         INNER JOIN PlanoContas AS PC
              ON  B.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT  Top 1 B2.IdConta
                  FROM   Bancos AS B2
                  WHERE  B2.IdConta IN (SELECT PC2.IdConta
                                          FROM   PlanoContas AS PC2
                                          WHERE  PC2.codConta = PC.codConta
                                                 AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(B.IdBanco AS VARCHAR(15)) + ','
     FROM   Bancos AS B
            INNER JOIN PlanoContas AS PC
              ON  B.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
     WHERE  ISNULL(( SELECT  Top 1 B2.IdConta
                     FROM   Bancos AS B2
                     WHERE  B2.IdConta IN (SELECT PC2.IdConta
                                           FROM   PlanoContas AS PC2
                                           WHERE  PC2.codConta = PC.codConta
                                                  AND PC2.Exercicio = @ExercicioAtual)),0) = 0
            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdConta',  'Bancos', 'IdBanco', @QtdRegistros_faltantes, @IdscomProblema)         
  END



  /*************** Conferindo ConfiguracoesCheques ***************/

  SELECT @QtdRegistros_faltantes = COUNT(C.IdConfiguracaoCheque)
  FROM   ConfiguracoesCheques AS C
  INNER JOIN Bancos AS B ON B.IdBanco = C.IdBanco 
  INNER JOIN PlanoContas AS PC ON  B.IdConta = PC.IdConta  AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE ISNULL(( SELECT  Top 1 C2.IdBanco
                 FROM  ConfiguracoesCheques AS C2
                 INNER JOIN Bancos AS B2 ON B2.IdBanco = C2.IdBanco
                 WHERE  B2.IdConta IN (SELECT PC2.IdConta
                                       FROM   PlanoContas AS PC2
                                       WHERE  PC2.codConta = PC.codConta
                                       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(C.IdConfiguracaoCheque AS VARCHAR(15)) + ','
	 FROM   ConfiguracoesCheques AS C
	 INNER JOIN Bancos AS B ON B.IdBanco = C.IdBanco 
	 INNER JOIN PlanoContas AS PC ON  B.IdConta = PC.IdConta  AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
	 WHERE ISNULL(( SELECT  Top 1 C2.IdBanco
		        FROM  ConfiguracoesCheques AS C2
			INNER JOIN Bancos AS B2 ON B2.IdBanco = C2.IdBanco
			WHERE  B2.IdConta IN (SELECT PC2.IdConta
			                      FROM   PlanoContas AS PC2
			                      WHERE  PC2.codConta = PC.codConta
					              AND PC2.Exercicio = @ExercicioAtual)),0) = 0
              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdConta',  'ConfiguracoesCheques', 'IdConfiguracaoCheque', @QtdRegistros_faltantes, @IdscomProblema)         
  END


/*************** Conferindo ContasEvento ***************/
  
  SELECT @QtdRegistros_faltantes = COUNT(CE.IdContasEvento)
  FROM   ContasEvento AS CE
         INNER JOIN PlanoContas AS PC
              ON  CE.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT  Top 1 CE2.IdConta
                  FROM   ContasEvento AS CE2
                  WHERE  CE2.IdConta IN (SELECT PC2.IdConta
                                          FROM   PlanoContas AS PC2
                                          WHERE  PC2.codConta = PC.codConta
                                                 AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(CE.IdContasEvento AS VARCHAR(15)) + ','
     FROM   ContasEvento AS CE
	    INNER JOIN PlanoContas AS PC
              ON  CE.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
     WHERE  ISNULL(( SELECT  Top 1 CE2.IdConta
	             FROM   ContasEvento AS CE2
	             WHERE  CE2.IdConta IN (SELECT PC2.IdConta
		                            FROM   PlanoContas AS PC2
		                            WHERE  PC2.codConta = PC.codConta
                                                   AND PC2.Exercicio = @ExercicioAtual)),0) = 0
                                                                
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdConta',  'ContasEvento', 'IdContasEvento', @QtdRegistros_faltantes, @IdscomProblema)         
  END


  
  /*************** Conferindo Repasses ***************/  


  SELECT @QtdRegistros_faltantes = COUNT(RE.IdRepasse)
  FROM   Repasses AS RE
         INNER JOIN PlanoContas AS PC
              ON  RE.IdContaRepasse = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
		 WHERE  ISNULL(( SELECT  Top 1 RE2.IdContaRepasse
			         FROM   Repasses AS RE2
				 WHERE  RE2.IdContaRepasse IN (SELECT PC2.IdConta
								FROM   PlanoContas AS PC2
								WHERE  PC2.codConta = PC.codConta
						 		       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(RE.IdRepasse AS VARCHAR(15)) + ','
     FROM   Repasses AS RE
	    INNER JOIN PlanoContas AS PC
	     ON  RE.IdContaRepasse = PC.IdConta
	     AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
     WHERE  ISNULL(( SELECT  Top 1 RE2.IdContaRepasse
	             FROM   Repasses AS RE2
	             WHERE  RE2.IdContaRepasse IN (SELECT PC2.IdConta
					    	   FROM   PlanoContas AS PC2
						   WHERE  PC2.codConta = PC.codConta
						          AND PC2.Exercicio = @ExercicioAtual)),0) = 0
                                                                
     INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
     VALUES (0, 'IdContaRepasse',  'Repasses', 'IdRepasse', @QtdRegistros_faltantes, @IdscomProblema)         
  END


  /*************** Conferindo RepassesContas ***************/


  SELECT @QtdRegistros_faltantes = COUNT(RC.IdRepasseConta)
  FROM   RepassesContas AS RC
  INNER JOIN Repasses AS RE ON RE.IdRepasse = RC.IdRepasse
  INNER JOIN PlanoContas AS PC ON  RE.IdContaRepasse = PC.IdConta  AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE ISNULL(( SELECT  Top 1 RC2.IdRepasseConta
                 FROM  RepassesContas AS RC2
                 INNER JOIN Repasses AS RE2 ON RE2.IdRepasse = RC2.IdRepasse
                 WHERE  RE2.IdContaRepasse IN (SELECT PC2.IdConta
                                       FROM   PlanoContas AS PC2
                                       WHERE  PC2.codConta = PC.codConta
                                       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(RC.IdRepasseConta AS VARCHAR(15)) + ','
	 FROM   RepassesContas AS RC
	 INNER JOIN Repasses AS RE ON RE.IdRepasse = RC.IdRepasse
	 INNER JOIN PlanoContas AS PC ON  RE.IdContaRepasse = PC.IdConta  AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
	 WHERE ISNULL(( SELECT  Top 1 RC2.IdRepasseConta
		            FROM  RepassesContas AS RC2
			        INNER JOIN Repasses AS RE2 ON RE2.IdRepasse = RC2.IdRepasse
				    WHERE  RE2.IdContaRepasse IN (SELECT PC2.IdConta
					                       FROM   PlanoContas AS PC2
						                   WHERE  PC2.codConta = PC.codConta
							               AND PC2.Exercicio = @ExercicioAtual)),0) = 0
							               
              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdContaRepasse', 'RepassesContas', 'IdRepasseConta', @QtdRegistros_faltantes, @IdscomProblema)         
  END



  /*************** Conferindo TiposDespesas ***************/


  SELECT @QtdRegistros_faltantes = COUNT(TD.IdTipoDespesa)
  FROM   TiposDespesas AS TD
         INNER JOIN PlanoContas AS PC
              ON  TD.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT  Top 1 TD2.IdTipoDespesa
  		          FROM   TiposDespesas AS TD2
				  WHERE  TD2.IdConta IN (SELECT PC2.IdConta
								FROM   PlanoContas AS PC2
								WHERE  PC2.codConta = PC.codConta
						 		       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(TD.IdTipoDespesa AS VARCHAR(15)) + ','
	 FROM   TiposDespesas AS TD
		     INNER JOIN PlanoContas AS PC
              ON  TD.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
	 WHERE  ISNULL(( SELECT Top 1 TD2.IdTipoDespesa
  			         FROM   TiposDespesas AS TD2
					 WHERE  TD2.IdConta IN (SELECT PC2.IdConta
											FROM   PlanoContas AS PC2
											WHERE  PC2.codConta = PC.codConta
						 						   AND PC2.Exercicio = @ExercicioAtual)),0) = 0
                                                                
     INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
     VALUES (0, 'IdConta',  'TiposDespesas', 'IdTipoDespesa', @QtdRegistros_faltantes, @IdscomProblema)         
  END



/*************** Conferindo TiposItemDevolucaoReceita ***************/  
  
  SELECT @QtdRegistros_faltantes = COUNT(TIDR.IdTipoItemDevolucaoReceita)
  FROM   TiposItemDevolucaoReceita AS TIDR
         INNER JOIN PlanoContas AS PC
              ON  TIDR.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT  Top 1 TIDR2.IdTipoItemDevolucaoReceita
  		          FROM   TiposItemDevolucaoReceita AS TIDR2
				  WHERE  TIDR2.IdConta IN (SELECT PC2.IdConta
								FROM   PlanoContas AS PC2
								WHERE  PC2.codConta = PC.codConta
						 		       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(TIDR.IdTipoItemDevolucaoReceita AS VARCHAR(15)) + ','
	 FROM   TiposItemDevolucaoReceita AS TIDR
		    INNER JOIN PlanoContas AS PC
              ON  TIDR.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
	 WHERE  ISNULL(( SELECT  Top 1 TIDR2.IdTipoItemDevolucaoReceita
  		             FROM   TiposItemDevolucaoReceita AS TIDR2
				     WHERE  TIDR2.IdConta IN (SELECT PC2.IdConta
											  FROM   PlanoContas AS PC2
											  WHERE  PC2.codConta = PC.codConta
						 					  AND PC2.Exercicio = @ExercicioAtual)),0) = 0
                                                                
     INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
     VALUES (0, 'IdConta',  'TiposItemDevolucaoReceita', 'IdTipoItemDevolucaoReceita', @QtdRegistros_faltantes, @IdscomProblema)         
  END
  

/*************** Conferindo TiposItemDevolucaoReceitaConta ***************/  
  
  SELECT @QtdRegistros_faltantes = COUNT(TIDRC.IdTipoItemDevolucaoReceita)
  FROM   TiposItemDevolucaoReceitaConta AS TIDRC
         INNER JOIN PlanoContas AS PC
              ON  TIDRC.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT  Top 1 TIDRC2.IdTipoItemDevolucaoReceita
  		          FROM   TiposItemDevolucaoReceitaConta AS TIDRC2
				  WHERE  TIDRC2.IdConta IN (SELECT PC2.IdConta
								FROM   PlanoContas AS PC2
								WHERE  PC2.codConta = PC.codConta
						 		       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(TIDRC.IdTipoItemDevolucaoReceita AS VARCHAR(15)) + ','
	 FROM   TiposItemDevolucaoReceitaConta AS TIDRC
		    INNER JOIN PlanoContas AS PC
              ON  TIDRC.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
	 WHERE  ISNULL(( SELECT  Top 1 TIDRC2.IdTipoItemDevolucaoReceita
  		          FROM   TiposItemDevolucaoReceitaConta AS TIDRC2
				  WHERE  TIDRC2.IdConta IN (SELECT PC2.IdConta
								FROM   PlanoContas AS PC2
								WHERE  PC2.codConta = PC.codConta
						 		       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
                                                                
     INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
     VALUES (0, 'IdConta',  'TiposItemDevolucaoReceitaConta', 'IdTipoItemDevolucaoReceita', @QtdRegistros_faltantes, @IdscomProblema)         
  END


/*************** Conferindo UnidadesCentroCustosAno ***************/

  SELECT @QtdRegistros_faltantes = COUNT(UCCA.IdUnidadeCentroCustoAno)
  FROM   UnidadesCentroCustosAno UCCA
         INNER JOIN CentroCustos AS CC
              ON  UCCA.IdCentroCusto = CC.IdCentroCusto
              AND ISNULL(CC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL((SELECT  Top 1 UCCA2.IdUnidadeCentroCustoAno
                 FROM   UnidadesCentroCustosAno AS UCCA2
                 WHERE  UCCA.IdUnidade = UCCA2.IdUnidade
                        AND UCCA2.IdCentroCusto IN (SELECT CC2.IdCentroCusto
                                             FROM   CentroCustos AS CC2
                                             WHERE  CC2.CodigoCentroCusto = CC.CodigoCentroCusto
                                                    AND CC2.Exercicio = @ExercicioAtual)),0) = 0
     
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + cast(UCCA.IdUnidadeCentroCustoAno AS VARCHAR(15)) + ',' 
	 FROM   UnidadesCentroCustosAno UCCA
		    INNER JOIN CentroCustos AS CC
              ON  UCCA.IdCentroCusto = CC.IdCentroCusto
              AND ISNULL(CC.Exercicio, 0) = @ExercicioAnterior
	 WHERE  ISNULL((SELECT  Top 1 UCCA2.IdUnidadeCentroCustoAno
		            FROM   UnidadesCentroCustosAno AS UCCA2
					WHERE  UCCA.IdUnidade = UCCA2.IdUnidade
						   AND UCCA2.IdCentroCusto IN (SELECT CC2.IdCentroCusto
                                             FROM   CentroCustos AS CC2
                                             WHERE  CC2.CodigoCentroCusto = CC.CodigoCentroCusto
                                                    AND CC2.Exercicio = @ExercicioAtual)),0) = 0
                                                    
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdCentroCusto', 'UnidadesCentroCustosAno', 'IdUnidadeCentroCustoAno', @QtdRegistros_faltantes, @IdscomProblema)         
  END        




  /*************** Conferindo HistoricosExtrato ***************/

  SELECT @QtdRegistros_faltantes = COUNT(HE.IdHistorico)
  FROM   HistoricosExtrato HE         
  WHERE  ISNULL(HE.Exercicio, 0) = @ExercicioAnterior AND   
         ISNULL((SELECT  Top 1 HE2.IdHistorico
                 FROM   HistoricosExtrato AS HE2
                 WHERE  HE2.Historico = HE.Historico
                        AND HE2.Exercicio = @ExercicioAtual),0) = 0
     
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + cast(HE.IdHistorico AS VARCHAR(15)) + ',' 
	 FROM   HistoricosExtrato HE         
	 WHERE  ISNULL(HE.Exercicio, 0) = @ExercicioAnterior AND   
            ISNULL((SELECT  Top 1 HE2.IdHistorico
			        FROM   HistoricosExtrato AS HE2
				    WHERE  HE2.Historico = HE.Historico
					       AND HE2.Exercicio = @ExercicioAtual),0) = 0
                                                    
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'Historico', 'HistoricosExtrato', 'IdHistorico', @QtdRegistros_faltantes, @IdscomProblema)         
  END        


  /*************** Conferindo HistoricosBancos ***************/


  SELECT @QtdRegistros_faltantes = COUNT(HB.IdHistorico)
  FROM   HistoricosBancos AS HB
  INNER JOIN HistoricosExtrato AS HE ON HE.IdHistorico = HB.IdHistorico AND ISNULL(HE.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL((SELECT  Top 1 HB2.IdHistorico
                 FROM   HistoricosBancos AS HB2
                 INNER JOIN HistoricosExtrato AS HE2 ON HE2.IdHistorico = HB2.IdHistorico
                 WHERE HB2.CodBanco = HB.CodBanco AND 
                       HE2.Exercicio = @ExercicioAtual),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(HB.IdHistorico AS VARCHAR(15)) + ','
	 FROM   HistoricosBancos AS HB
	 INNER JOIN HistoricosExtrato AS HE ON HE.IdHistorico = HB.IdHistorico AND ISNULL(HE.Exercicio, 0) = @ExercicioAnterior
	 WHERE  ISNULL((SELECT  Top 1 HB2.IdHistorico
		            FROM   HistoricosBancos AS HB2
			        INNER JOIN HistoricosExtrato AS HE2 ON HE2.IdHistorico = HB2.IdHistorico
				    WHERE HB2.CodBanco = HB.CodBanco AND 
					      HE2.Exercicio = @ExercicioAtual),0) = 0
            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'CodBanco', 'HistoricosBancos', 'IdHistorico', @QtdRegistros_faltantes, @IdscomProblema)         
  END


  /*************** Conferindo HisToricosExtratoConta ***************/


  SELECT @QtdRegistros_faltantes = COUNT(HEC.IdHistorico)
  FROM   HisToricosExtratoConta AS HEC
  INNER JOIN HistoricosExtrato AS HE ON HE.IdHistorico = HEC.IdHistorico AND ISNULL(HE.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL((SELECT  Top 1 HEC2.IdHistorico
                 FROM   HisToricosExtratoConta AS HEC2
                 INNER JOIN HistoricosExtrato AS HE2 ON HE2.IdHistorico = HEC2.IdHistorico
                 WHERE HE2.Historico = HE.Historico AND 
                       HE2.Exercicio = @ExercicioAtual),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(HEC.IdHistorico AS VARCHAR(15)) + ','
	 FROM   HisToricosExtratoConta AS HEC
			INNER JOIN HistoricosExtrato AS HE ON HE.IdHistorico = HEC.IdHistorico AND ISNULL(HE.Exercicio, 0) = @ExercicioAnterior
	 WHERE  ISNULL((SELECT  Top 1 HEC2.IdHistorico
		            FROM   HisToricosExtratoConta AS HEC2
			        INNER JOIN HistoricosExtrato AS HE2 ON HE2.IdHistorico = HEC2.IdHistorico
				    WHERE HE2.Historico = HE.Historico AND 
					      HE2.Exercicio = @ExercicioAtual),0) = 0
            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'Historico', 'HisToricosExtratoConta', 'IdHistorico', @QtdRegistros_faltantes, @IdscomProblema)         
  END


/*************** Conferindo HistoricoConciliacaoBancaria ***************/  
  
  SELECT @QtdRegistros_faltantes = COUNT(HCB.IdHistorico)
  FROM   HistoricoConciliacaoBancaria AS HCB
         INNER JOIN PlanoContas AS PC ON HCB.IdConta = PC.IdConta
             AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT  Top 1 HCB2.IdHistorico
  		          FROM   HistoricoConciliacaoBancaria AS HCB2
				  WHERE  HCB2.IdConta IN (SELECT PC2.IdConta
								FROM   PlanoContas AS PC2
								WHERE  PC2.codConta = PC.codConta
						 		       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(HCB.IdHistorico AS VARCHAR(15)) + ','
	 FROM   HistoricoConciliacaoBancaria AS HCB
		    INNER JOIN PlanoContas AS PC ON HCB.IdConta = PC.IdConta
             AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
	 WHERE  ISNULL(( SELECT  Top 1 HCB2.IdHistorico
  		          FROM   HistoricoConciliacaoBancaria AS HCB2
				  WHERE  HCB2.IdConta IN (SELECT PC2.IdConta
								FROM   PlanoContas AS PC2
								WHERE  PC2.codConta = PC.codConta
						 		       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
                                                                
     INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
     VALUES (0, 'IdConta',  'HistoricoConciliacaoBancaria', 'IdHistorico', @QtdRegistros_faltantes, @IdscomProblema)         
  END
  

/*************** Conferindo FatConfigContasFaturamento ***************/  
  

  SELECT @QtdRegistros_faltantes = COUNT(FCCF.IdConfigContasFaturamento)
  FROM   FatConfigContasFaturamento AS FCCF
         INNER JOIN PlanoContas AS PC ON FCCF.IdContaPatrimonialUnidade = PC.IdConta
             AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT  Top 1 FCCF2.IdConfigContasFaturamento
  		          FROM   FatConfigContasFaturamento AS FCCF2
				  WHERE  FCCF2.IdContaPatrimonialUnidade IN (SELECT PC2.IdConta
								FROM   PlanoContas AS PC2
								WHERE  PC2.codConta = PC.codConta
						 		       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(FCCF.IdConfigContasFaturamento AS VARCHAR(15)) + ','
	 FROM   FatConfigContasFaturamento AS FCCF
            INNER JOIN PlanoContas AS PC ON FCCF.IdContaPatrimonialUnidade = PC.IdConta
             AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
	 WHERE  ISNULL(( SELECT  Top 1 FCCF2.IdConfigContasFaturamento
  		          FROM   FatConfigContasFaturamento AS FCCF2
				  WHERE  FCCF2.IdContaPatrimonialUnidade IN (SELECT PC2.IdConta
								FROM   PlanoContas AS PC2
								WHERE  PC2.codConta = PC.codConta
						 		       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
                                                                  
     INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
     VALUES (0, 'IdContaPatrimonialUnidade',  'FatConfigContasFaturamento', 'IdConfigContasFaturamento', @QtdRegistros_faltantes, @IdscomProblema)         
  END
  


 /*************** Conferindo PessoaCCustoAutorizacao ***************/


  SELECT @QtdRegistros_faltantes = COUNT(PA.IdPessoaSispad)
  FROM   PessoaCCustoAutorizacao PA
         INNER JOIN CentroCustos AS CC
              ON  PA.IdCentroCusto = CC.IdCentroCusto
              AND ISNULL(CC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL((SELECT  Top 1 PA2.IdPessoaSispad
                 FROM   PessoaCCustoAutorizacao AS PA2
                 WHERE  PA2.IdCentroCusto IN (SELECT CC2.IdCentroCusto
                                             FROM   CentroCustos AS CC2
                                             WHERE  CC2.CodigoCentroCusto = CC.CodigoCentroCusto
                                                    AND CC2.Exercicio = @ExercicioAtual)),0) = 0
     
  IF @QtdRegistros_faltantes > 0
  BEGIN
    SET @IdscomProblema = ''
    SELECT @IdscomProblema = @IdscomProblema + cast(PA.IdPessoaSispad AS VARCHAR(15)) + ',' 
	FROM   PessoaCCustoAutorizacao PA
		   INNER JOIN CentroCustos AS CC
            ON  PA.IdCentroCusto = CC.IdCentroCusto
            AND ISNULL(CC.Exercicio, 0) = @ExercicioAnterior
	WHERE  ISNULL((SELECT  Top 1 PA2.IdPessoaSispad
			       FROM   PessoaCCustoAutorizacao AS PA2
				   WHERE  PA2.IdCentroCusto IN (SELECT CC2.IdCentroCusto
					                            FROM   CentroCustos AS CC2
						                        WHERE  CC2.CodigoCentroCusto = CC.CodigoCentroCusto
							                           AND CC2.Exercicio = @ExercicioAtual)),0) = 0
                                                    
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdCentroCusto', 'PessoaCCustoAutorizacao', 'IdPessoaSispad', @QtdRegistros_faltantes, @IdscomProblema)         
  END        



/*************** Conferindo RateioDespesasCentroCusto ***************/

  SELECT @QtdRegistros_faltantes = COUNT(RDCC.IdRateio)
  FROM   RateioDespesasCentroCusto RDCC
         INNER JOIN CentroCustos AS CC
              ON  RDCC.IdCentroCusto = CC.IdCentroCusto
              AND ISNULL(CC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL((SELECT  Top 1 RDCC2.IdRateio
                 FROM   RateioDespesasCentroCusto AS RDCC2
                 WHERE  RDCC2.IdCentroCusto IN (SELECT CC2.IdCentroCusto
                                             FROM   CentroCustos AS CC2
                                             WHERE  CC2.CodigoCentroCusto = CC.CodigoCentroCusto
                                                    AND CC2.Exercicio = @ExercicioAtual)),0) = 0
     
  IF @QtdRegistros_faltantes > 0
  BEGIN
    SET @IdscomProblema = ''
    SELECT @IdscomProblema = @IdscomProblema + cast(RDCC.IdRateio AS VARCHAR(15)) + ',' 
	FROM   RateioDespesasCentroCusto RDCC
		   INNER JOIN CentroCustos AS CC
              ON  RDCC.IdCentroCusto = CC.IdCentroCusto
              AND ISNULL(CC.Exercicio, 0) = @ExercicioAnterior
	WHERE  ISNULL((SELECT  Top 1 RDCC2.IdRateio
		           FROM   RateioDespesasCentroCusto AS RDCC2
			       WHERE  RDCC2.IdCentroCusto IN (SELECT CC2.IdCentroCusto
						              FROM   CentroCustos AS CC2
							 	WHERE  CC2.CodigoCentroCusto = CC.CodigoCentroCusto
                                                         AND CC2.Exercicio = @ExercicioAtual)),0) = 0
                                                    
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdCentroCusto', 'RateioDespesasCentroCusto', 'IdRateio', @QtdRegistros_faltantes, @IdscomProblema)         
  END        




/*************** Conferindo Usuarios ***************/


  SELECT @QtdRegistros_faltantes = COUNT(U.IdUsuario)
  FROM   Usuarios U
  WHERE  U.IdCentroCusto IS NOT NULL
         AND U.IdCentroCusto <> 0      
         AND U.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                        FROM   CentroCustos CC
                                        WHERE  CC.Exercicio = @ExercicioEfetivo)


 IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(U.IdUsuario AS VARCHAR(15)) + ','
	 FROM   Usuarios U
	 WHERE  U.IdCentroCusto IS NOT NULL
         AND U.IdCentroCusto <> 0      
         AND U.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                        FROM   CentroCustos CC
                                        WHERE  CC.Exercicio = @ExercicioEfetivo)
  
                                 
 	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'IdCentroCusto', 'Usuarios', 'IdUsuario', @QtdRegistros_faltantes, @IdscomProblema)         
  END        



/*************** Conferindo CentroCustosPersonalizado ***************/

  SELECT @QtdRegistros_faltantes = COUNT(CCP.IdCentroCustosPersonalizado)
  FROM   CentroCustosPersonalizado CCP         
  WHERE  ISNULL(CCP.Exercicio, 0) = @ExercicioAnterior AND   
         ISNULL((SELECT  Top 1 CCP2.IdCentroCustosPersonalizado
                 FROM   CentroCustosPersonalizado AS CCP2
                 WHERE  CCP2.NomePersonalizado = CCP.NomePersonalizado
                        AND CCP2.Exercicio = @ExercicioAtual),0) = 0
     
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + cast(CCP.IdCentroCustosPersonalizado AS VARCHAR(15)) + ',' 
	 FROM   CentroCustosPersonalizado CCP         
	 WHERE  ISNULL(CCP.Exercicio, 0) = @ExercicioAnterior AND   
		    ISNULL((SELECT  Top 1 CCP2.IdCentroCustosPersonalizado
			        FROM   CentroCustosPersonalizado AS CCP2
				    WHERE  CCP2.NomePersonalizado = CCP.NomePersonalizado
					       AND CCP2.Exercicio = @ExercicioAtual),0) = 0
                                                    
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, 'NomePersonalizado', 'CentroCustosPersonalizado', 'IdCentroCustosPersonalizado', @QtdRegistros_faltantes, @IdscomProblema)         
  END        


  /*************** Conferindo ConfiguracoesAnuaisSipro ***************/


  SELECT @QtdRegistros_faltantes = COUNT(CAS.Exercicio)
  FROM   ConfiguracoesAnuaisSipro CAS         
  WHERE  CAS.Exercicio = @ExercicioAtual 
     
  IF @QtdRegistros_faltantes = 0 
  BEGIN                                                    
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (0, '', 'ConfiguracoesAnuaisSipro', 'Exercicio', 1, 0)         
  END        


  /*************** Conferindo ConveniosSipro ***************/


  SELECT @QtdRegistros_faltantes = COUNT(CS.IdConvenioSipro)
  FROM   ConveniosSipro AS CS
         INNER JOIN PlanoContas AS PC
              ON  CS.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
  WHERE  ISNULL(( SELECT  Top 1 CS2.IdConvenioSipro
			  	  FROM   ConveniosSipro AS CS2
				  WHERE  CS2.IdConta IN (SELECT PC2.IdConta
								FROM   PlanoContas AS PC2
								WHERE  PC2.codConta = PC.codConta
						 		       AND PC2.Exercicio = @ExercicioAtual)),0) = 0
  
  IF @QtdRegistros_faltantes > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(CS.IdConvenioSipro AS VARCHAR(15)) + ','
     FROM   ConveniosSipro AS CS
            INNER JOIN PlanoContas AS PC
              ON  CS.IdConta = PC.IdConta
              AND ISNULL(PC.Exercicio, 0) = @ExercicioAnterior
	 WHERE  ISNULL(( SELECT  Top 1 CS2.IdConvenioSipro
				  	  FROM   ConveniosSipro AS CS2
					  WHERE  CS2.IdConta IN (SELECT PC2.IdConta
								 FROM   PlanoContas AS PC2
								 WHERE  PC2.codConta = PC.codConta
						 			 AND PC2.Exercicio = @ExercicioAtual)),0) = 0
                                                                
     INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
     VALUES (0, 'IdConta',  'ConveniosSipro', 'IdConvenioSipro', @QtdRegistros_faltantes, @IdscomProblema)         
  END

END

/********************************************************************************************/ 
/*Conferência de atualização de registros que já tinham sido lançados para o novo exercício*/

IF (@CodErro = 0)
BEGIN
  /***** Conferindo PlanoContasFinanceiro *****/

  SELECT @QtdRegistros_Incorretos = COUNT(PCF.IdContaFinanceira)
  FROM   PlanoContasFinanceiro PCF
  WHERE  PCF.IdConta IS NOT NULL
         AND PCF.IdConta <> 0
         AND PCF.Exercicio = @ExercicioAtual 
         AND PCF.IdConta NOT IN (SELECT pc.IdConta FROM PlanoContas pc WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(PCF.IdContaFinanceira AS VARCHAR(15)) + ','
	 FROM   PlanoContasFinanceiro PCF
     WHERE  PCF.IdConta IS NOT NULL
            AND PCF.IdConta <> 0
            AND PCF.Exercicio = @ExercicioAtual 
            AND PCF.IdConta NOT IN (SELECT pc.IdConta FROM PlanoContas pc WHERE  pc.Exercicio = @ExercicioEfetivo)
                     
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'PlanoContasFinanceiro', 'IdContaFinanceira', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

    
  /*************** Conferindo DotacoesCentroCustoConta ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(DCCC.IdDotacaoCCustoConta)
  FROM   DotacoesCentroCustoConta DCCC
  WHERE  DCCC.IdConta IS NOT NULL
         AND DCCC.IdConta <> 0
         AND YEAR(DCCC.DataDotacao) = @ExercicioAtual 
         AND DCCC.IdConta NOT IN (SELECT pc.IdConta
                                  FROM   PlanoContas pc
                                  WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(DCCC.IdDotacaoCCustoConta AS VARCHAR(15)) + ','
	 FROM   DotacoesCentroCustoConta DCCC
	 WHERE  DCCC.IdConta IS NOT NULL
		    AND DCCC.IdConta <> 0
			AND YEAR(DCCC.DataDotacao) = @ExercicioAtual 
			AND DCCC.IdConta NOT IN (SELECT pc.IdConta
			                         FROM   PlanoContas pc
			                         WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'DotacoesCentroCustoConta', 'IdDotacaoCCustoConta', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  
  SELECT @QtdRegistros_Incorretos = COUNT(DCCC.IdDotacaoCCustoConta)
  FROM   DotacoesCentroCustoConta DCCC
  WHERE  DCCC.IdCentroCusto IS NOT NULL
         AND DCCC.IdCentroCusto <> 0
         AND YEAR(DCCC.DataDotacao) = @ExercicioAtual 
         AND DCCC.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                        FROM   CentroCustos CC
                                        WHERE  CC.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(DCCC.IdDotacaoCCustoConta AS VARCHAR(15)) + ','
	 FROM   DotacoesCentroCustoConta DCCC
	 WHERE  DCCC.IdCentroCusto IS NOT NULL
		    AND DCCC.IdCentroCusto <> 0
			AND YEAR(DCCC.DataDotacao) = @ExercicioAtual 
			AND DCCC.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
			                               FROM   CentroCustos CC
			                               WHERE  CC.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdCentroCusto', 'DotacoesCentroCustoConta', 'IdDotacaoCCustoConta', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

    /*************** Conferindo DotacoesConta ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(DC.IdDotacaoConta)
  FROM   DotacoesConta DC
  WHERE  DC.IdConta IS NOT NULL
         AND DC.IdConta <> 0
         AND YEAR(DC.DataDotacao) = @ExercicioAtual 
         AND DC.IdConta NOT IN (SELECT pc.IdConta
                                FROM   PlanoContas pc
                                WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(DC.IdDotacaoConta AS VARCHAR(15)) + ','
	 FROM   DotacoesConta DC
	 WHERE  DC.IdConta IS NOT NULL
		    AND DC.IdConta <> 0
			AND YEAR(DC.DataDotacao) = @ExercicioAtual 
			AND DC.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'DotacoesConta', 'IdDotacaoConta', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  /*************** Conferindo DotacoesCentroCusto ***************/

  SELECT @QtdRegistros_Incorretos = COUNT(DCC.IdDotacaoCCusto)
  FROM   DotacoesCentroCusto DCC
  WHERE  DCC.IdCentroCusto IS NOT NULL
         AND DCC.IdCentroCusto <> 0
         AND YEAR(DCC.DataDotacao) = @ExercicioAtual 
         AND DCC.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                       FROM   CentroCustos CC
                                       WHERE  CC.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(DCC.IdDotacaoCCusto AS VARCHAR(15)) + ','
	 FROM   DotacoesCentroCusto DCC
	 WHERE  DCC.IdCentroCusto IS NOT NULL
		    AND DCC.IdCentroCusto <> 0
			AND YEAR(DCC.DataDotacao) = @ExercicioAtual 
			AND DCC.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
			                              FROM   CentroCustos CC
			                              WHERE  CC.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdCentroCusto', 'DotacoesCentroCusto', 'IdDotacaoCCusto', @QtdRegistros_Incorretos, @IdscomProblema)         
  END


  /*************** Conferindo CentroCustosPagamento ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(CCP.IdCentroCustosPagamento)
  FROM   CentroCustosPagamento CCP
  WHERE  CCP.IdConta IS NOT NULL
         AND CCP.IdConta <> 0
         AND YEAR(CCP.DataEvento) = @ExercicioAtual 
         AND CCP.IdConta NOT IN (SELECT pc.IdConta
                                 FROM   PlanoContas pc
                                 WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(CCP.IdCentroCustosPagamento AS VARCHAR(15)) + ','
	 FROM   CentroCustosPagamento CCP
	 WHERE  CCP.IdConta IS NOT NULL
		    AND CCP.IdConta <> 0
			AND YEAR(CCP.DataEvento) = @ExercicioAtual 
			AND CCP.IdConta NOT IN (SELECT pc.IdConta
			                        FROM   PlanoContas pc
			                        WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'CentroCustosPagamento', 'IdCentroCustosPagamento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  
  SELECT @QtdRegistros_Incorretos = COUNT(CCP.IdCentroCustosPagamento)
  FROM   CentroCustosPagamento CCP
  WHERE  CCP.IdCentroCusto IS NOT NULL
         AND CCP.IdCentroCusto <> 0
         AND YEAR(CCP.DataEvento) = @ExercicioAtual 
         AND CCP.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                       FROM   CentroCustos CC
                                       WHERE  CC.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(CCP.IdCentroCustosPagamento AS VARCHAR(15)) + ','
	 FROM   CentroCustosPagamento CCP
	 WHERE  CCP.IdCentroCusto IS NOT NULL
		    AND CCP.IdCentroCusto <> 0
			AND YEAR(CCP.DataEvento) = @ExercicioAtual 
			AND CCP.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
			                              FROM   CentroCustos CC
			                              WHERE  CC.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdCentroCusto', 'CentroCustosPagamento', 'IdCentroCustosPagamento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END



  /*************** Conferindo CentroCustosEmpenho ***************/

  SELECT @QtdRegistros_Incorretos = COUNT(CCE.IdCentroCustoEmpenho)
  FROM   CentroCustosEmpenho CCE
  WHERE  CCE.IdCentroCusto IS NOT NULL
         AND CCE.IdCentroCusto <> 0
         AND CCE.IdEmpenho IN (SELECT IdEmpenho FROM Empenhos WHERE YEAR(DataEmpenho) = @ExercicioAtual) 
         AND CCE.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                       FROM   CentroCustos CC
                                       WHERE  CC.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(CCE.IdCentroCustoEmpenho AS VARCHAR(15)) + ','
	 FROM   CentroCustosEmpenho CCE
	 WHERE  CCE.IdCentroCusto IS NOT NULL
		    AND CCE.IdCentroCusto <> 0
			AND CCE.IdEmpenho IN (SELECT IdEmpenho FROM Empenhos WHERE YEAR(DataEmpenho) =  @ExercicioAtual) 
			AND CCE.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
			                              FROM   CentroCustos CC
			                              WHERE  CC.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdCentroCusto', 'CentroCustosEmpenho', 'IdCentroCustoEmpenho', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  /*************** Conferindo CentroCustosAnulacao ***************/

  SELECT @QtdRegistros_Incorretos = COUNT(CCA.IdCentroCustoAnulacao)
  FROM   CentroCustosAnulacao CCA
  WHERE  CCA.IdCentroCusto IS NOT NULL
         AND CCA.IdCentroCusto <> 0
         AND CCA.IdAnulacao IN (SELECT IdAnulacao FROM Anulacoes WHERE YEAR(DataAnulacao) = @ExercicioAtual) 
         AND CCA.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                       FROM   CentroCustos CC
                                       WHERE  CC.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(CCA.IdCentroCustoAnulacao AS VARCHAR(15)) + ','
	 FROM   CentroCustosAnulacao CCA
	 WHERE  CCA.IdCentroCusto IS NOT NULL
		    AND CCA.IdCentroCusto <> 0
			AND CCA.IdAnulacao IN (SELECT IdAnulacao FROM Anulacoes WHERE YEAR(DataAnulacao) = @ExercicioAtual) 
			AND CCA.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
			                              FROM   CentroCustos CC
			                              WHERE  CC.Exercicio = @ExercicioEfetivo)
                            
    INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
    VALUES (1, 'IdCentroCusto', 'CentroCustosAnulacao', 'IdCentroCustoAnulacao', @QtdRegistros_Incorretos, @IdscomProblema)        
  END


  /*************** Conferindo CentroCustosPreEmpenho ***************/

  SELECT @QtdRegistros_Incorretos = COUNT(CCPE.IdCentroCustosPreEmpenho)
  FROM   CentroCustosPreEmpenho CCPE
  WHERE  CCPE.IdCentroCusto IS NOT NULL
         AND CCPE.IdCentroCusto <> 0
         AND CCPE.IdPreEmpenho IN (SELECT IdPreEmpenho FROM PreEmpenhos WHERE YEAR(DataPreEmpenho) = @ExercicioAtual) 
         AND CCPE.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                        FROM   CentroCustos CC
                                        WHERE  CC.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(CCPE.IdCentroCustosPreEmpenho AS VARCHAR(15)) + ','
	 FROM   CentroCustosPreEmpenho CCPE
	 WHERE  CCPE.IdCentroCusto IS NOT NULL
		AND CCPE.IdCentroCusto <> 0
		AND CCPE.IdPreEmpenho IN (SELECT IdPreEmpenho FROM PreEmpenhos WHERE YEAR(DataPreEmpenho) = @ExercicioAtual) 
		AND CCPE.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
		                               FROM   CentroCustos CC
		                               WHERE  CC.Exercicio = @ExercicioEfetivo)
                              
     INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
     VALUES (1, 'IdCentroCusto', 'CentroCustosPreEmpenho', 'IdCentroCustosPreEmpenho', @QtdRegistros_Incorretos, @IdscomProblema)        
  END



  /*************** Conferindo Empenhos ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(E.IdEmpenho)
  FROM   Empenhos E
  WHERE  E.IdConta IS NOT NULL
         AND E.IdConta <> 0
         AND YEAR(E.DataEmpenho) = @ExercicioAtual 
         AND E.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(E.IdEmpenho AS VARCHAR(15)) + ','
	 FROM   Empenhos E
	 WHERE  E.IdConta IS NOT NULL
		    AND E.IdConta <> 0
			AND YEAR(E.DataEmpenho) = @ExercicioAtual 
			AND E.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'Empenhos', 'IdEmpenho', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  /*************** Conferindo FormasPagamento ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(FP.IdFormaPagamento)
  FROM   FormasPagamento FP
  WHERE  FP.IdContaBanco IS NOT NULL
         AND FP.IdContaBanco <> 0
         AND YEAR(FP.DataPagto) = @ExercicioAtual 
         AND FP.IdContaBanco NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(FP.IdFormaPagamento AS VARCHAR(15)) + ','
	 FROM   FormasPagamento FP
	 WHERE  FP.IdContaBanco IS NOT NULL
		    AND FP.IdContaBanco <> 0
			AND YEAR(FP.DataPagto) = @ExercicioAtual 
			AND FP.IdContaBanco NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaBanco', 'FormasPagamento', 'IdFormaPagamento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END




  /*************** Conferindo ItensImoveis ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(II.IdItem)
  FROM   ItensImoveis II
  WHERE  II.IdConta IS NOT NULL
         AND II.IdConta <> 0
         AND YEAR(II.DataAquisicao) = @ExercicioAtual 
         AND II.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(II.IdItem AS VARCHAR(15)) + ','
	 FROM   ItensImoveis II
	 WHERE  II.IdConta IS NOT NULL
		    AND II.IdConta <> 0
			AND YEAR(II.DataAquisicao) = @ExercicioAtual 
			AND II.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'ItensImoveis', 'IdItem', @QtdRegistros_Incorretos, @IdscomProblema)         
  END



  /*************** Conferindo ItensMoveis ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(IM.IdItem)
  FROM   ItensMoveis IM
  WHERE  IM.IdConta IS NOT NULL
         AND IM.IdConta <> 0
         AND YEAR(IM.DataAquisicao) = @ExercicioAtual 
         AND IM.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(IM.IdItem AS VARCHAR(15)) + ','
	 FROM   ItensMoveis IM
	 WHERE  IM.IdConta IS NOT NULL
		    AND IM.IdConta <> 0
			AND YEAR(IM.DataAquisicao) = @ExercicioAtual 
			AND IM.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'ItensMoveis', 'IdItem', @QtdRegistros_Incorretos, @IdscomProblema)         
  END


  /*************** Conferindo MovimentoFinanceiro ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(MF.IdMovimentoFinanceiro)
  FROM   MovimentoFinanceiro MF
  WHERE  MF.IdContaOrigem IS NOT NULL
         AND MF.IdContaOrigem <> 0
         AND YEAR(MF.DataMovimentoFinanceiro) = @ExercicioAtual 
         AND MF.IdContaOrigem NOT IN (SELECT pc.IdConta
                                      FROM   PlanoContas pc
                                      WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(MF.IdMovimentoFinanceiro AS VARCHAR(15)) + ','
	 FROM   MovimentoFinanceiro MF
	 WHERE  MF.IdContaOrigem IS NOT NULL
		    AND MF.IdContaOrigem <> 0
			AND YEAR(MF.DataMovimentoFinanceiro) = @ExercicioAtual 
			AND MF.IdContaOrigem NOT IN (SELECT pc.IdConta
			                             FROM   PlanoContas pc
			                             WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaOrigem', 'MovimentoFinanceiro', 'IdMovimentoFinanceiro', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  --------------
  
  SELECT @QtdRegistros_Incorretos = COUNT(MF.IdMovimentoFinanceiro)
  FROM   MovimentoFinanceiro MF
  WHERE  MF.IdContaOrigem IS NOT NULL
         AND MF.IdContaOrigem <> 0
         AND MF.DataMovimentoFinanceiro IS NULL
         AND YEAR(MF.DataPrevista) = @ExercicioAtual 
         AND MF.IdContaOrigem NOT IN (SELECT pc.IdConta
                                      FROM   PlanoContas pc
                                      WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(MF.IdMovimentoFinanceiro AS VARCHAR(15)) + ','
	 FROM   MovimentoFinanceiro MF
	 WHERE  MF.IdContaOrigem IS NOT NULL
		    AND MF.IdContaOrigem <> 0
                        AND MF.DataMovimentoFinanceiro IS NULL
			AND YEAR(MF.DataPrevista) = @ExercicioAtual 
			AND MF.IdContaOrigem NOT IN (SELECT pc.IdConta
			                             FROM   PlanoContas pc
			                             WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaOrigem', 'MovimentoFinanceiro', 'IdMovimentoFinanceiro', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  ------------
    
  SELECT @QtdRegistros_Incorretos = COUNT(MF.IdMovimentoFinanceiro)
  FROM   MovimentoFinanceiro MF
  WHERE  MF.IdContaDestino IS NOT NULL
         AND MF.IdContaDestino <> 0
         AND YEAR(MF.DataMovimentoFinanceiro) = @ExercicioAtual 
         AND MF.IdContaDestino NOT IN (SELECT pc.IdConta
                                      FROM   PlanoContas pc
                                      WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(MF.IdMovimentoFinanceiro AS VARCHAR(15)) + ','
	 FROM   MovimentoFinanceiro MF
	 WHERE  MF.IdContaDestino IS NOT NULL
		    AND MF.IdContaDestino <> 0
			AND YEAR(MF.DataMovimentoFinanceiro) = @ExercicioAtual 
			AND MF.IdContaDestino NOT IN (SELECT pc.IdConta
			                             FROM   PlanoContas pc
			                             WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaDestino', 'MovimentoFinanceiro', 'IdMovimentoFinanceiro', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  --------------
  
  SELECT @QtdRegistros_Incorretos = COUNT(MF.IdMovimentoFinanceiro)
  FROM   MovimentoFinanceiro MF
  WHERE  MF.IdContaDestino IS NOT NULL
         AND MF.IdContaDestino <> 0
         AND MF.DataMovimentoFinanceiro IS NULL
         AND YEAR(MF.DataPrevista) = @ExercicioAtual 
         AND MF.IdContaDestino NOT IN (SELECT pc.IdConta
                                      FROM   PlanoContas pc
                                      WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(MF.IdMovimentoFinanceiro AS VARCHAR(15)) + ','
	 FROM   MovimentoFinanceiro MF
	 WHERE  MF.IdContaDestino IS NOT NULL
		    AND MF.IdContaDestino <> 0
                        AND MF.DataMovimentoFinanceiro IS NULL
			AND YEAR(MF.DataPrevista) = @ExercicioAtual 
			AND MF.IdContaDestino NOT IN (SELECT pc.IdConta
			                             FROM   PlanoContas pc
			                             WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaDestino', 'MovimentoFinanceiro', 'IdMovimentoFinanceiro', @QtdRegistros_Incorretos, @IdscomProblema)         
  END



  /*************** Conferindo Movimentos ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(M.IdMovimento)
  FROM   Movimentos M
  WHERE  M.IdConta IS NOT NULL
         AND M.IdConta <> 0
         AND YEAR(M.DataLancamento) = @ExercicioAtual 
         AND M.IdConta NOT IN (SELECT pc.IdConta
                                      FROM   PlanoContas pc
                                      WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(M.IdMovimento AS VARCHAR(15)) + ','
	 FROM   Movimentos M
	 WHERE  M.IdConta IS NOT NULL
		    AND M.IdConta <> 0
			AND YEAR(M.DataLancamento) = @ExercicioAtual 
			AND M.IdConta NOT IN (SELECT pc.IdConta
			                             FROM   PlanoContas pc
			                             WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'Movimentos', 'IdMovimento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END




  /*************** Conferindo Obras ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(O.IdObra)
  FROM   Obras O
  WHERE  O.IdConta IS NOT NULL
         AND O.IdConta <> 0
         AND O.Exercicio = @ExercicioAtual 
         AND O.IdConta NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(O.IdObra AS VARCHAR(15)) + ','
	 FROM   Obras O
	 WHERE  O.IdConta IS NOT NULL
		    AND O.IdConta <> 0
			AND O.Exercicio = @ExercicioAtual 
			AND O.IdConta NOT IN (SELECT pc.IdConta
			                      FROM   PlanoContas pc
			                      WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'Obras', 'IdObra', @QtdRegistros_Incorretos, @IdscomProblema)         
  END


 
 /*************** Conferindo Pagamentos ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(P.IdPagamento)
  FROM   Pagamentos P
  WHERE  P.IdContaProvisao IS NOT NULL
         AND P.IdContaProvisao <> 0
         AND YEAR(P.DataPgto) = @ExercicioAtual 
         AND P.IdContaProvisao NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(P.IdPagamento AS VARCHAR(15)) + ','
	 FROM   Pagamentos P
	 WHERE  P.IdContaProvisao IS NOT NULL
		    AND P.IdContaProvisao <> 0
			AND YEAR(P.DataPgto) = @ExercicioAtual 
			AND P.IdContaProvisao NOT IN (SELECT pc.IdConta
			                      FROM   PlanoContas pc
			                      WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaProvisao', 'Pagamentos', 'IdPagamento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  --------------

  SELECT @QtdRegistros_Incorretos = COUNT(P.IdPagamento)
  FROM   Pagamentos P
  WHERE  P.IdContaProvisao IS NOT NULL
         AND P.IdContaProvisao <> 0
	 AND P.DataPgto IS NULL
         AND YEAR(P.DataProvisao) = @ExercicioAtual 
         AND P.IdContaProvisao NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(P.IdPagamento AS VARCHAR(15)) + ','
	 FROM   Pagamentos P
	 WHERE  P.IdContaProvisao IS NOT NULL
		    AND P.IdContaProvisao <> 0
            	    AND P.DataPgto IS NULL
			AND YEAR(P.DataProvisao) = @ExercicioAtual 
			AND P.IdContaProvisao NOT IN (SELECT pc.IdConta
			                      FROM   PlanoContas pc
			                      WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaProvisao', 'Pagamentos', 'IdPagamento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  --------------

  SELECT @QtdRegistros_Incorretos = COUNT(P.IdPagamento)
  FROM   Pagamentos P
  WHERE  P.IdContaProvisao IS NOT NULL
         AND P.IdContaProvisao <> 0
         AND P.DataPgto IS NULL
         AND P.DataProvisao IS NULL
         AND YEAR(P.DataVencimento) = @ExercicioAtual 
         AND P.IdContaProvisao NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(P.IdPagamento AS VARCHAR(15)) + ','
	 FROM   Pagamentos P
	 WHERE  P.IdContaProvisao IS NOT NULL
		    AND P.IdContaProvisao <> 0
                    AND P.DataPgto IS NULL
                    AND P.DataProvisao IS NULL
			AND YEAR(P.DataVencimento) = @ExercicioAtual 
			AND P.IdContaProvisao NOT IN (SELECT pc.IdConta
			                      FROM   PlanoContas pc
			                      WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaProvisao', 'Pagamentos', 'IdPagamento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  ----------------

  SELECT @QtdRegistros_Incorretos = COUNT(P.IdPagamento)
  FROM   Pagamentos P
  WHERE  P.IdContaDevolucao IS NOT NULL
         AND P.IdContaDevolucao <> 0
         AND YEAR(P.DataPgto) = @ExercicioAtual 
         AND P.IdContaDevolucao NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(P.IdPagamento AS VARCHAR(15)) + ','
	 FROM   Pagamentos P
	 WHERE  P.IdContaDevolucao IS NOT NULL
		    AND P.IdContaDevolucao <> 0
			AND YEAR(P.DataPgto) = @ExercicioAtual 
			AND P.IdContaDevolucao NOT IN (SELECT pc.IdConta
			                      FROM   PlanoContas pc
			                      WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaDevolucao', 'Pagamentos', 'IdPagamento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  ---------------
  
  SELECT @QtdRegistros_Incorretos = COUNT(P.IdPagamento)
  FROM   Pagamentos P
  WHERE  P.IdContaDevolucao IS NOT NULL
         AND P.IdContaDevolucao <> 0
         AND P.DataPgto IS NULL
         AND YEAR(P.DataProvisao) = @ExercicioAtual 
         AND P.IdContaDevolucao NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(P.IdPagamento AS VARCHAR(15)) + ','
	 FROM   Pagamentos P
	 WHERE  P.IdContaDevolucao IS NOT NULL
		    AND P.IdContaDevolucao <> 0
                    AND P.DataPgto IS NULL
			AND YEAR(P.DataProvisao) = @ExercicioAtual 
			AND P.IdContaDevolucao NOT IN (SELECT pc.IdConta
			                      FROM   PlanoContas pc
			                      WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaDevolucao', 'Pagamentos', 'IdPagamento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

---------------
  
  SELECT @QtdRegistros_Incorretos = COUNT(P.IdPagamento)
  FROM   Pagamentos P
  WHERE  P.IdContaDevolucao IS NOT NULL
         AND P.IdContaDevolucao <> 0
         AND P.DataPgto IS NULL
         AND P.DataProvisao IS NULL
         AND YEAR(P.DataVencimento) = @ExercicioAtual 
         AND P.IdContaDevolucao NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(P.IdPagamento AS VARCHAR(15)) + ','
	 FROM   Pagamentos P
	 WHERE  P.IdContaDevolucao IS NOT NULL
		    AND P.IdContaDevolucao <> 0
                    AND P.DataPgto IS NULL
                    AND P.DataProvisao IS NULL
			AND YEAR(P.DataVencimento) = @ExercicioAtual 
			AND P.IdContaDevolucao NOT IN (SELECT pc.IdConta
			                      FROM   PlanoContas pc
			                      WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaDevolucao', 'Pagamentos', 'IdPagamento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
  

/*************** Conferindo PreEmpenhos ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(PE.IdPreEmpenho)
  FROM   PreEmpenhos PE
  WHERE  PE.IdConta IS NOT NULL
         AND PE.IdConta <> 0
         AND YEAR(PE.DataPreEmpenho) = @ExercicioAtual 
         AND PE.IdConta NOT IN (SELECT pc.IdConta
                                FROM   PlanoContas pc
                                WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(PE.IdPreEmpenho AS VARCHAR(15)) + ','
	 FROM   PreEmpenhos PE
	 WHERE  PE.IdConta IS NOT NULL
		    AND PE.IdConta <> 0
			AND YEAR(PE.DataPreEmpenho) = @ExercicioAtual 
			AND PE.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'PreEmpenhos', 'IdPreEmpenho', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
  


  /*************** Conferindo Receitas ***************/

  
  SELECT @QtdRegistros_Incorretos = COUNT(R.IdReceita)
  FROM   Receitas R
  WHERE  R.IdConta IS NOT NULL
         AND R.IdConta <> 0
         AND YEAR(R.DataReceita) = @ExercicioAtual 
         AND R.IdConta NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(R.IdReceita AS VARCHAR(15)) + ','
	 FROM   Receitas R
	 WHERE  R.IdConta IS NOT NULL
		    AND R.IdConta <> 0
			AND YEAR(R.DataReceita) = @ExercicioAtual 
			AND R.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'Receitas', 'IdReceita', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
  
  -----------
 
  SELECT @QtdRegistros_Incorretos = COUNT(R.IdReceita)
  FROM   Receitas R
  WHERE  R.IdConta IS NOT NULL
         AND R.IdConta <> 0
         AND R.DataReceita IS NULL
         AND YEAR(R.DataPrevisao) = @ExercicioAtual 
         AND R.IdConta NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(R.IdReceita AS VARCHAR(15)) + ','
	 FROM   Receitas R
	 WHERE  R.IdConta IS NOT NULL
		    AND R.IdConta <> 0
                        AND R.DataReceita IS NULL
			AND YEAR(R.DataPrevisao) = @ExercicioAtual 
			AND R.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'Receitas', 'IdReceita', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  ------------
  
  SELECT @QtdRegistros_Incorretos = COUNT(R.IdReceita)
  FROM   Receitas R
  WHERE  R.IdContaBanco IS NOT NULL
         AND R.IdContaBanco <> 0
         AND YEAR(R.DataReceita) = @ExercicioAtual 
         AND R.IdContaBanco NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(R.IdReceita AS VARCHAR(15)) + ','
	 FROM   Receitas R
	 WHERE  R.IdContaBanco IS NOT NULL
		    AND R.IdContaBanco <> 0
			AND YEAR(R.DataReceita) = @ExercicioAtual 
			AND R.IdContaBanco NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaBanco', 'Receitas', 'IdReceita', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
  
  -----------
 
  SELECT @QtdRegistros_Incorretos = COUNT(R.IdReceita)
  FROM   Receitas R
  WHERE  R.IdContaBanco IS NOT NULL
         AND R.IdContaBanco <> 0
         AND R.DataReceita IS NULL
         AND YEAR(R.DataPrevisao) = @ExercicioAtual 
         AND R.IdContaBanco NOT IN (SELECT pc.IdConta
                               FROM   PlanoContas pc
                               WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(R.IdReceita AS VARCHAR(15)) + ','
	 FROM   Receitas R
	 WHERE  R.IdContaBanco IS NOT NULL
		    AND R.IdContaBanco <> 0
                        AND R.DataReceita IS NULL
			AND YEAR(R.DataPrevisao) = @ExercicioAtual 
			AND R.IdContaBanco NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaBanco', 'Receitas', 'IdReceita', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
  

  /*************** Conferindo TransposicoesConta ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(T.IdTransposicao)
  FROM   TransposicoesConta T
  WHERE  T.IdConta IS NOT NULL
         AND T.IdConta <> 0
         AND YEAR(T.DataDotacao) = @ExercicioAtual 
         AND T.IdConta NOT IN (SELECT pc.IdConta
                                FROM   PlanoContas pc
                                WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(T.IdTransposicao AS VARCHAR(15)) + ','
	 FROM   TransposicoesConta T
	 WHERE  T.IdConta IS NOT NULL
		    AND T.IdConta <> 0
			AND YEAR(T.DataDotacao) = @ExercicioAtual 
			AND T.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'TransposicoesConta', 'IdTransposicao', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  /*************** Conferindo TransposicoesCentroCusto ***************/

  SELECT @QtdRegistros_Incorretos = COUNT(TCC.IdTransposicao)
  FROM   TransposicoesCentroCusto TCC
  WHERE  TCC.IdCentroCusto IS NOT NULL
         AND TCC.IdCentroCusto <> 0
         AND YEAR(TCC.DataDotacao) = @ExercicioAtual  
         AND TCC.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                        FROM   CentroCustos CC
                                        WHERE  CC.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(TCC.IdTransposicao AS VARCHAR(15)) + ','
	 FROM   TransposicoesCentroCusto TCC
	 WHERE  TCC.IdCentroCusto IS NOT NULL
		    AND TCC.IdCentroCusto <> 0
			AND YEAR(TCC.DataDotacao) = @ExercicioAtual  
			AND TCC.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
			                               FROM   CentroCustos CC
			                               WHERE  CC.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdCentroCusto', 'TransposicoesCentroCusto', 'IdTransposicao', @QtdRegistros_Incorretos, @IdscomProblema)        
  END


  /*************** Conferindo TransposicoesCentroCustoConta ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(T.IdTransposicao)
  FROM   TransposicoesCentroCustoConta T
  WHERE  T.IdConta IS NOT NULL
         AND T.IdConta <> 0
         AND YEAR(T.DataDotacao) = @ExercicioAtual 
         AND T.IdConta NOT IN (SELECT pc.IdConta
                                FROM   PlanoContas pc
                                WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(T.IdTransposicao AS VARCHAR(15)) + ','
	 FROM   TransposicoesCentroCustoConta T
	 WHERE  T.IdConta IS NOT NULL
		    AND T.IdConta <> 0
			AND YEAR(T.DataDotacao) = @ExercicioAtual 
			AND T.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'TransposicoesCentroCustoConta', 'IdTransposicao', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
 
  ----------------
  
  SELECT @QtdRegistros_Incorretos = COUNT(TCC.IdTransposicao)
  FROM   TransposicoesCentroCustoConta TCC
  WHERE  TCC.IdCentroCusto IS NOT NULL
         AND TCC.IdCentroCusto <> 0
         AND YEAR(TCC.DataDotacao) = @ExercicioAtual  
         AND TCC.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                        FROM   CentroCustos CC
                                        WHERE  CC.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(TCC.IdTransposicao AS VARCHAR(15)) + ','
	 FROM   TransposicoesCentroCustoConta TCC
	 WHERE  TCC.IdCentroCusto IS NOT NULL
		    AND TCC.IdCentroCusto <> 0
			AND YEAR(TCC.DataDotacao) = @ExercicioAtual  
			AND TCC.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
			                               FROM   CentroCustos CC
			                               WHERE  CC.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdCentroCusto', 'TransposicoesCentroCustoConta', 'IdTransposicao', @QtdRegistros_Incorretos, @IdscomProblema)        
  END

  /*************** Conferindo DespesasReceita ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(DR.IdDespesaReceita)
  FROM   DespesasReceita DR
  WHERE  DR.IdContaDespesa IS NOT NULL
         AND DR.IdContaDespesa <> 0
         AND (SELECT YEAR(R.DataReceita) FROM Receitas R  WHERE R.IdReceita = DR.IdReceita) = @ExercicioAtual 
         AND DR.IdContaDespesa NOT IN (SELECT pc.IdConta
                                       FROM   PlanoContas pc
                                       WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(DR.IdDespesaReceita AS VARCHAR(15)) + ','
	 FROM   DespesasReceita DR
	 WHERE  DR.IdContaDespesa IS NOT NULL
		    AND DR.IdContaDespesa <> 0
			AND (SELECT YEAR(R.DataReceita) FROM Receitas R  WHERE R.IdReceita = DR.IdReceita) = @ExercicioAtual 
			AND DR.IdContaDespesa NOT IN (SELECT pc.IdConta
			                              FROM   PlanoContas pc
			                              WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaDespesa', 'DespesasReceita', 'IdDespesaReceita', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
 

  /*************** Conferindo ImportacaoReceitasDespesas ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(IRD.IdImportacaoReceitaDespesa)
  FROM   ImportacaoReceitasDespesas IRD
  WHERE  IRD.IdContaDebito IS NOT NULL
         AND IRD.IdContaDebito <> 0
         AND (CASE WHEN IRD.Data IS NOT NULL THEN YEAR(IRD.Data) ELSE (SELECT YEAR(DataReceita) FROM Receitas AS R WHERE R.IdReceita = IRD.IdReceita) END) = @ExercicioAtual 
         AND IRD.IdContaDebito NOT IN (SELECT pc.IdConta
                                       FROM   PlanoContas pc
                                       WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(IRD.IdImportacaoReceitaDespesa AS VARCHAR(15)) + ','
	 FROM   ImportacaoReceitasDespesas IRD
	 WHERE  IRD.IdContaDebito IS NOT NULL
		    AND IRD.IdContaDebito <> 0
			AND (CASE WHEN IRD.Data IS NOT NULL THEN YEAR(IRD.Data) ELSE (SELECT YEAR(DataReceita) FROM Receitas AS R WHERE R.IdReceita = IRD.IdReceita) END) = @ExercicioAtual 
			AND IRD.IdContaDebito NOT IN (SELECT pc.IdConta
			                               FROM   PlanoContas pc
			                               WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaDebito', 'ImportacaoReceitasDespesas', 'IdImportacaoReceitaDespesa', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
  
  -------------
 
  SELECT @QtdRegistros_Incorretos = COUNT(IRD.IdImportacaoReceitaDespesa)
  FROM   ImportacaoReceitasDespesas IRD
  WHERE  IRD.IdContaCredito IS NOT NULL
         AND IRD.IdContaCredito <> 0
         AND (CASE WHEN IRD.Data IS NOT NULL THEN YEAR(IRD.Data) ELSE (SELECT YEAR(DataReceita) FROM Receitas AS R WHERE R.IdReceita = IRD.IdReceita) END) = @ExercicioAtual 
         AND IRD.IdContaCredito NOT IN (SELECT pc.IdConta
                                       FROM   PlanoContas pc
                                       WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(IRD.IdImportacaoReceitaDespesa AS VARCHAR(15)) + ','
	 FROM   ImportacaoReceitasDespesas IRD
	 WHERE  IRD.IdContaCredito IS NOT NULL
		    AND IRD.IdContaCredito <> 0
			AND (CASE WHEN IRD.Data IS NOT NULL THEN YEAR(IRD.Data) ELSE (SELECT YEAR(DataReceita) FROM Receitas AS R WHERE R.IdReceita = IRD.IdReceita) END) = @ExercicioAtual 
			AND IRD.IdContaCredito NOT IN (SELECT pc.IdConta
			                               FROM   PlanoContas pc
			                               WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaCredito', 'ImportacaoReceitasDespesas', 'IdImportacaoReceitaDespesa', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
 
    

  /*************** Conferindo RepassesReceita ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(RR.IdRepasseReceita)
  FROM   RepassesReceita RR
  WHERE  RR.IdContaRepasse IS NOT NULL
         AND RR.IdContaRepasse <> 0
         AND (SELECT YEAR(R.DataReceita) FROM Receitas R  WHERE R.IdReceita = RR.IdReceita) = @ExercicioAtual 
         AND RR.IdContaRepasse NOT IN (SELECT pc.IdConta
                                       FROM   PlanoContas pc
                                       WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(RR.IdRepasseReceita AS VARCHAR(15)) + ','
	 FROM   RepassesReceita RR
	 WHERE  RR.IdContaRepasse IS NOT NULL
		    AND RR.IdContaRepasse <> 0
			AND (SELECT YEAR(R.DataReceita) FROM Receitas R  WHERE R.IdReceita = RR.IdReceita) = @ExercicioAtual 
			AND RR.IdContaRepasse NOT IN (SELECT pc.IdConta
			                              FROM   PlanoContas pc
			                              WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaRepasse', 'RepassesReceita', 'IdRepasseReceita', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
 

   
  /*************** Conferindo PrevisoesPagamento ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(PP.IdPrevisaoPagamento)
  FROM   PrevisoesPagamento PP
  WHERE  PP.IdContaCredito IS NOT NULL
         AND PP.IdContaCredito <> 0
         AND (SELECT P.AnoExercicio FROM Pagamentos P WHERE P.IdPagamento = PP.IdPagamento) = @ExercicioAtual 
         AND PP.IdContaCredito NOT IN (SELECT pc.IdConta
                                       FROM   PlanoContas pc
                                       WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(PP.IdPrevisaoPagamento AS VARCHAR(15)) + ','
	 FROM   PrevisoesPagamento PP
	 WHERE  PP.IdContaCredito IS NOT NULL
		    AND PP.IdContaCredito <> 0
			AND (SELECT P.AnoExercicio FROM Pagamentos P WHERE P.IdPagamento = PP.IdPagamento) = @ExercicioAtual 
			AND PP.IdContaCredito NOT IN (SELECT pc.IdConta
			                              FROM   PlanoContas pc
			                              WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaCredito', 'PrevisoesPagamento', 'IdPrevisaoPagamento', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

   
  /*************** Conferindo SaldosIniciais ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(SI.IdConta)
  FROM   SaldosIniciais SI
  WHERE  SI.IdConta IS NOT NULL
         AND SI.IdConta <> 0
         AND (YEAR(DataSaldo) + 1) = @ExercicioAtual 
         AND SI.IdConta NOT IN (SELECT pc.IdConta
                                FROM   PlanoContas pc
                                WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(SI.IdConta AS VARCHAR(15)) + ','
	 FROM   SaldosIniciais SI
	 WHERE  SI.IdConta IS NOT NULL
		    AND SI.IdConta <> 0
			AND (YEAR(DataSaldo) + 1) = @ExercicioAtual 
			AND SI.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'SaldosIniciais', 'IdConta', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
   
   
  /*************** Conferindo RestosEmpenho ***************/
  
  
  SELECT @QtdRegistros_Incorretos = COUNT(REM.IdRestosEmpenho)
  FROM   RestosEmpenho REM
  WHERE  REM.IdConta IS NOT NULL
         AND REM.IdConta <> 0
         /*AND YEAR(REM.DataEmpenho) = @ExercicioAtual*/
         AND CASE WHEN NOT EXISTS (SELECT 1 FROM PlanoContas WHERE Exercicio = YEAR(REM.DataEmpenho))
             THEN 0 ELSE YEAR(REM.DataEmpenho) END = @ExercicioAnterior          
         AND REM.IdConta NOT IN (SELECT pc.IdConta
                                FROM   PlanoContas pc
                                WHERE  ISNULL(pc.Exercicio,0) = @ExercicioAnterior)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(REM.IdRestosEmpenho AS VARCHAR(15)) + ','
	 FROM   RestosEmpenho REM
	 WHERE  REM.IdConta IS NOT NULL
	        AND REM.IdConta <> 0
  	  	  /*AND YEAR(REM.DataEmpenho) = @ExercicioAtual*/
            AND CASE WHEN  NOT EXISTS (SELECT 1 FROM PlanoContas WHERE Exercicio = YEAR(REM.DataEmpenho)) 
                THEN 0 ELSE YEAR(REM.DataEmpenho) END = @ExercicioAnterior
            AND REM.IdConta NOT IN (SELECT pc.IdConta
		   	                        FROM   PlanoContas pc
			                        WHERE  ISNULL(pc.Exercicio,0) = @ExercicioAnterior)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'RestosEmpenho', 'IdRestosEmpenho', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
   
  --------------
  
  SELECT @QtdRegistros_Incorretos = COUNT(REM.IdRestosEmpenho)
  FROM   RestosEmpenho REM
  WHERE  REM.IdContaDebito IS NOT NULL
         AND REM.IdContaDebito <> 0
         /*AND YEAR(REM.DataEmpenho) = @ExercicioAtual*/
	     AND CASE WHEN NOT EXISTS (SELECT 1 FROM PlanoContas WHERE Exercicio = YEAR(REM.DataEmpenho)) 
	     THEN 0 ELSE YEAR(REM.DataEmpenho) END = @ExercicioAnterior          
         AND REM.IdContaDebito NOT IN (SELECT pc.IdConta
 				       FROM   PlanoContas pc
					   WHERE  ISNULL(pc.Exercicio,0) = @ExercicioAnterior)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(REM.IdRestosEmpenho AS VARCHAR(15)) + ','
	 FROM   RestosEmpenho REM
	 WHERE  REM.IdContaDebito IS NOT NULL
	        AND REM.IdContaDebito <> 0
		  /*AND YEAR(REM.DataEmpenho) = @ExercicioAtual*/
		    AND CASE WHEN NOT EXISTS (SELECT 1 FROM PlanoContas WHERE Exercicio = YEAR(REM.DataEmpenho)) 
		    THEN 0 ELSE YEAR(REM.DataEmpenho) END = @ExercicioAnterior
		   	AND REM.IdContaDebito NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  ISNULL(pc.Exercicio,0) = @ExercicioAnterior)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaDebito', 'RestosEmpenho', 'IdRestosEmpenho', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
   
  
  --------------

  SELECT @QtdRegistros_Incorretos = COUNT(REM.IdRestosEmpenho)
  FROM   RestosEmpenho REM
  WHERE  REM.IdContaPluri IS NOT NULL
         AND REM.IdContaPluri <> 0
         AND CASE WHEN NOT EXISTS (SELECT 1 FROM PlanoContas WHERE Exercicio = YEAR(REM.DataEmpenho))
         THEN 0 ELSE YEAR(REM.DataEmpenho) END = @ExercicioAnterior 
         AND REM.AnoExercicio + 1 = @ExercicioEfetivo
         AND REM.IdContaPluri NOT IN (SELECT pc.IdConta FROM PlanoContas pc WHERE pc.Exercicio = @ExercicioEfetivo) 
                  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(REM.IdRestosEmpenho AS VARCHAR(15)) + ','
	 FROM   RestosEmpenho REM
	 WHERE  REM.IdContaPluri IS NOT NULL
		    AND REM.IdContaPluri <> 0
		    AND CASE WHEN NOT EXISTS (SELECT 1 FROM PlanoContas WHERE Exercicio = YEAR(REM.DataEmpenho)) 
		    THEN 0 ELSE YEAR(REM.DataEmpenho) END = @ExercicioAnterior 
		    AND REM.AnoExercicio + 1 = @ExercicioEfetivo       
            AND REM.IdContaPluri NOT IN (SELECT pc.IdConta FROM PlanoContas pc WHERE pc.Exercicio = @ExercicioEfetivo)  
                            
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaPluri', 'RestosEmpenho', 'IdRestosEmpenho', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
   
  -------------------
  
  
  SELECT @QtdRegistros_Incorretos = COUNT(REM.IdRestosEmpenho)
  FROM   RestosEmpenho REM
  WHERE  REM.IdContaDebitoPluri IS NOT NULL
         AND REM.IdContaDebitoPluri <> 0
         AND CASE WHEN NOT EXISTS (SELECT 1 FROM PlanoContas WHERE Exercicio = YEAR(REM.DataEmpenho)) 
         THEN 0 ELSE YEAR(REM.DataEmpenho) END = @ExercicioAnterior 
         AND REM.AnoExercicio + 1 = @ExercicioEfetivo
         AND REM.IdContaDebitoPluri NOT IN (SELECT pc.IdConta FROM PlanoContas pc WHERE pc.Exercicio = @ExercicioEfetivo) 
                  	
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(REM.IdRestosEmpenho AS VARCHAR(15)) + ','
	 FROM   RestosEmpenho REM
	 WHERE  REM.IdContaDebitoPluri IS NOT NULL
	        AND REM.IdContaDebitoPluri <> 0
		    AND CASE WHEN NOT EXISTS (SELECT 1 FROM PlanoContas WHERE Exercicio = YEAR(REM.DataEmpenho))
		    THEN 0 ELSE YEAR(REM.DataEmpenho) END = @ExercicioAnterior 
            AND REM.AnoExercicio + 1 = @ExercicioEfetivo
            AND REM.IdContaDebitoPluri NOT IN (SELECT pc.IdConta FROM PlanoContas pc WHERE pc.Exercicio = @ExercicioEfetivo) 
     		  
                                
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaDebitoPluri', 'RestosEmpenho', 'IdRestosEmpenho', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  -------------------

  SELECT @QtdRegistros_Incorretos = COUNT(REM.IdRestosEmpenho)
  FROM   RestosEmpenho REM
  WHERE  REM.IdContaDebito IS NULL
         AND REM.IdContaDebitoPluri IS NOT NULL 
         AND YEAR(REM.DataEmpenho) = @ExercicioAtual
                  
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(REM.IdRestosEmpenho AS VARCHAR(15)) + ','
	 FROM   RestosEmpenho REM
	 WHERE  REM.IdContaDebito IS NULL
			AND REM.IdContaDebitoPluri IS NOT NULL 
			AND YEAR(REM.DataEmpenho) = @ExercicioAtual
                                
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaDebitoPluri', 'RestosEmpenho', 'IdRestosEmpenho', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
  
  /*************** Conferindo RestosAnulacao ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(RA.IdRestosAnulacao)
  FROM   RestosAnulacao RA
  WHERE  RA.IdContaCancelamentoRestos IS NOT NULL
         AND RA.IdContaCancelamentoRestos <> 0
         AND YEAR(RA.DataAnulacao) = @ExercicioAtual 
         AND RA.IdContaCancelamentoRestos NOT IN (SELECT pc.IdConta
                                FROM   PlanoContas pc
                                WHERE  pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(RA.IdRestosAnulacao AS VARCHAR(15)) + ','
	 FROM   RestosAnulacao RA
	 WHERE  RA.IdContaCancelamentoRestos IS NOT NULL
		    AND RA.IdContaCancelamentoRestos <> 0
			AND YEAR(RA.DataAnulacao) = @ExercicioAtual 
			AND RA.IdContaCancelamentoRestos NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaCancelamentoRestos', 'RestosAnulacao', 'IdRestosAnulacao', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
   


 /*************** Conferindo TiposPessoaValor ***************/
  
 /* SELECT @QtdRegistros_Incorretos = COUNT(TPV.IdTipoPessoaValor)
  FROM   TiposPessoaValor TPV
  WHERE  TPV.IdConta IS NOT NULL
         AND TPV.IdConta <> 0
         AND YEAR(TPV.Data) = @ExercicioAtual 
         AND TPV.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(TPV.IdTipoPessoaValor AS VARCHAR(15)) + ','
	 FROM   TiposPessoaValor TPV
	 WHERE  TPV.IdConta IS NOT NULL
		    AND TPV.IdConta <> 0
			AND YEAR(TPV.Data) = @ExercicioAtual 
			AND TPV.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'TiposPessoaValor', 'IdTipoPessoaValor', @QtdRegistros_Incorretos, @IdscomProblema)         
  END */



  /*************** Conferindo Tributos ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(T.IdTributo)
  FROM   Tributos T
  WHERE  T.IdConta IS NOT NULL
         AND T.IdConta <> 0
         AND T.Exercicio = @ExercicioAtual 
         AND T.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(T.IdTributo AS VARCHAR(15)) + ','
	 FROM   Tributos T
	 WHERE  T.IdConta IS NOT NULL
		    AND T.IdConta <> 0
			AND T.Exercicio = @ExercicioAtual 
			AND T.IdConta NOT IN (SELECT pc.IdConta
			                       FROM   PlanoContas pc
			                       WHERE  pc.Exercicio = @ExercicioEfetivo)
                              
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'Tributos', 'IdTributo', @QtdRegistros_Incorretos, @IdscomProblema)         
  END



  /*************** Conferindo TributosPadroes ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(TP.IdTributo)
  FROM   TributosPadroes TP
  WHERE  TP.IdConta IS NOT NULL
         AND TP.IdConta <> 0
         AND TP.IdTributo IN (SELECT T.IdTributo FROM Tributos T WHERE T.Exercicio = @ExercicioAtual)  
         AND TP.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(TP.IdTributo AS VARCHAR(15)) + ','
	 FROM   TributosPadroes TP
	 WHERE  TP.IdConta IS NOT NULL
		    AND TP.IdConta <> 0
			AND TP.IdTributo IN (SELECT T.IdTributo FROM Tributos T WHERE T.Exercicio = @ExercicioAtual)  
			AND TP.IdConta NOT IN (SELECT pc.IdConta
				                    FROM  PlanoContas pc
					                WHERE pc.Exercicio = @ExercicioEfetivo)
                           
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'TributosPadroes', 'IdTributo', @QtdRegistros_Incorretos, @IdscomProblema)         
  END



  /*************** Conferindo RamosAtividadeContas ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(RAC.IdRamoAtividade)
  FROM   RamosAtividadeContas RAC
  WHERE  RAC.IdConta IS NOT NULL
         AND RAC.IdConta <> 0
         AND RAC.Exercicio = @ExercicioAtual  
         AND RAC.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(RAC.IdRamoAtividade AS VARCHAR(15)) + ','
	  FROM   RamosAtividadeContas RAC
	  WHERE  RAC.IdConta IS NOT NULL
         AND RAC.IdConta <> 0
         AND RAC.Exercicio = @ExercicioAtual  
         AND RAC.IdConta NOT IN (SELECT pc.IdConta
			                     FROM  PlanoContas pc
		                         WHERE pc.Exercicio = @ExercicioEfetivo)
                           
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'RamosAtividadeContas', 'IdRamoAtividade', @QtdRegistros_Incorretos, @IdscomProblema)         
  END




  /*************** Conferindo TiposRateioAssociacoes ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(TRA.IdTipoRateioAssociacao)
  FROM   TiposRateioAssociacoes TRA
  WHERE  TRA.IdConta IS NOT NULL
         AND TRA.IdConta <> 0
         AND TRA.Exercicio = @ExercicioAtual  
         AND TRA.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(TRA.IdTipoRateioAssociacao AS VARCHAR(15)) + ','
	 FROM   TiposRateioAssociacoes TRA
	 WHERE  TRA.IdConta IS NOT NULL
		    AND TRA.IdConta <> 0
			AND TRA.Exercicio = @ExercicioAtual  
			AND TRA.IdConta NOT IN (SELECT pc.IdConta
				                    FROM  PlanoContas pc
					                WHERE pc.Exercicio = @ExercicioEfetivo)
                           
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'TiposRateioAssociacoes', 'IdTipoRateioAssociacao', @QtdRegistros_Incorretos, @IdscomProblema)         
  END



  /*************** Conferindo Reavaliacoes ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(R.IdValorAtual)
  FROM   Reavaliacoes R
  WHERE  R.IdConta IS NOT NULL
         AND R.IdConta <> 0
         AND YEAR(R.DataReavaliacao) = @ExercicioAtual  
         AND R.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(R.IdValorAtual AS VARCHAR(15)) + ','
	 FROM   Reavaliacoes R
	 WHERE  R.IdConta IS NOT NULL
         AND R.IdConta <> 0
         AND YEAR(R.DataReavaliacao) = @ExercicioAtual  
         AND R.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
                           
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'Reavaliacoes', 'IdValorAtual', @QtdRegistros_Incorretos, @IdscomProblema)         
  END




  /*************** Conferindo AlertaEmpenhoSG ***************/
  
  SELECT @QtdRegistros_Incorretos = COUNT(AES.IdAlertaEmpenhoSG)
  FROM   AlertaEmpenhoSG AES
  WHERE  AES.IdConta IS NOT NULL
         AND AES.IdConta <> 0
         AND YEAR(AES.DataSolicitacao) = @ExercicioAtual  
         AND AES.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(AES.IdAlertaEmpenhoSG AS VARCHAR(15)) + ','
	 FROM   AlertaEmpenhoSG AES
	 WHERE  AES.IdConta IS NOT NULL
		    AND AES.IdConta <> 0
			AND YEAR(AES.DataSolicitacao) = @ExercicioAtual  
			AND AES.IdConta NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
                           
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdConta', 'AlertaEmpenhoSG', 'IdAlertaEmpenhoSG', @QtdRegistros_Incorretos, @IdscomProblema)         
  END



  /*************** Conferindo FatNotasDebitoLancamentos ***************/


  
  SELECT @QtdRegistros_Incorretos = COUNT(FNDL.IdNotaDebito_Lancamentos)
  FROM   FatNotasDebitoLancamentos FNDL
  WHERE  FNDL.IdContaPatrimonialUnidade IS NOT NULL
         AND FNDL.IdContaPatrimonialUnidade <> 0
         AND FNDL.IdNotaDebito IN (SELECT F.IdNotaDebito FROM FatNotasDebito F WHERE YEAR(F.DataEmissao) = @ExercicioAtual)  
         AND FNDL.IdContaPatrimonialUnidade NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(FNDL.IdNotaDebito_Lancamentos AS VARCHAR(15)) + ','
	 FROM   FatNotasDebitoLancamentos FNDL
	 WHERE  FNDL.IdContaPatrimonialUnidade IS NOT NULL
         AND FNDL.IdContaPatrimonialUnidade <> 0
         AND FNDL.IdNotaDebito IN (SELECT F.IdNotaDebito FROM FatNotasDebito F WHERE YEAR(F.DataEmissao) = @ExercicioAtual)  
         AND FNDL.IdContaPatrimonialUnidade NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
                             
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaPatrimonialUnidade', 'FatNotasDebitoLancamentos', 'IdNotaDebito_Lancamentos', @QtdRegistros_Incorretos, @IdscomProblema)         
  END


  ---------------

  SELECT @QtdRegistros_Incorretos = COUNT(FNDL.IdNotaDebito_Lancamentos)
  FROM   FatNotasDebitoLancamentos FNDL
  WHERE  FNDL.IdContaPatrimonial IS NOT NULL
         AND FNDL.IdContaPatrimonial <> 0
         AND FNDL.IdNotaDebito IN (SELECT F.IdNotaDebito FROM FatNotasDebito F WHERE YEAR(F.DataEmissao) = @ExercicioAtual)  
         AND FNDL.IdContaPatrimonial NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(FNDL.IdNotaDebito_Lancamentos AS VARCHAR(15)) + ','
	 FROM   FatNotasDebitoLancamentos FNDL
	 WHERE  FNDL.IdContaPatrimonial IS NOT NULL
         AND FNDL.IdContaPatrimonial <> 0
         AND FNDL.IdNotaDebito IN (SELECT F.IdNotaDebito FROM FatNotasDebito F WHERE YEAR(F.DataEmissao) = @ExercicioAtual)  
         AND FNDL.IdContaPatrimonial NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
                             
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaPatrimonial', 'FatNotasDebitoLancamentos', 'IdNotaDebito_Lancamentos', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  ---------------

  SELECT @QtdRegistros_Incorretos = COUNT(FNDL.IdNotaDebito_Lancamentos)
  FROM   FatNotasDebitoLancamentos FNDL
  WHERE  FNDL.IdContaReceita IS NOT NULL
         AND FNDL.IdContaReceita <> 0
         AND FNDL.IdNotaDebito IN (SELECT F.IdNotaDebito FROM FatNotasDebito F WHERE YEAR(F.DataEmissao) = @ExercicioAtual)  
         AND FNDL.IdContaReceita NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(FNDL.IdNotaDebito_Lancamentos AS VARCHAR(15)) + ','
	 FROM   FatNotasDebitoLancamentos FNDL
	 WHERE  FNDL.IdContaReceita IS NOT NULL
         AND FNDL.IdContaReceita <> 0
         AND FNDL.IdNotaDebito IN (SELECT F.IdNotaDebito FROM FatNotasDebito F WHERE YEAR(F.DataEmissao) = @ExercicioAtual)  
         AND FNDL.IdContaReceita NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
                             
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaReceita', 'FatNotasDebitoLancamentos', 'IdNotaDebito_Lancamentos', @QtdRegistros_Incorretos, @IdscomProblema)         
  END

  ---------------

  SELECT @QtdRegistros_Incorretos = COUNT(FNDL.IdNotaDebito_Lancamentos)
  FROM   FatNotasDebitoLancamentos FNDL
  WHERE  FNDL.IdContaBanco IS NOT NULL
         AND FNDL.IdContaBanco <> 0
         AND FNDL.IdNotaDebito IN (SELECT F.IdNotaDebito FROM FatNotasDebito F WHERE YEAR(F.DataEmissao) = @ExercicioAtual)  
         AND FNDL.IdContaBanco NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(FNDL.IdNotaDebito_Lancamentos AS VARCHAR(15)) + ','
	 FROM   FatNotasDebitoLancamentos FNDL
	 WHERE  FNDL.IdContaBanco IS NOT NULL
         AND FNDL.IdContaBanco <> 0
         AND FNDL.IdNotaDebito IN (SELECT F.IdNotaDebito FROM FatNotasDebito F WHERE YEAR(F.DataEmissao) = @ExercicioAtual)  
         AND FNDL.IdContaBanco NOT IN (SELECT pc.IdConta
                                FROM  PlanoContas pc
                                WHERE pc.Exercicio = @ExercicioEfetivo)
                             
  	 INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
	 VALUES (1, 'IdContaBanco', 'FatNotasDebitoLancamentos', 'IdNotaDebito_Lancamentos', @QtdRegistros_Incorretos, @IdscomProblema)         
  END
  

  /*************** Conferindo SubAreasPagamento ***************/

  SELECT @QtdRegistros_Incorretos = COUNT(SAP.IdSubAreasPagamento)
  FROM   SubAreasPagamento SAP
  WHERE  SAP.IdCentroCusto IS NOT NULL
         AND SAP.IdCentroCusto <> 0
         AND YEAR(SAP.DataEvento) = @ExercicioAtual          
         AND SAP.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                        FROM   CentroCustos CC
                                        WHERE  CC.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(SAP.IdSubAreasPagamento AS VARCHAR(15)) + ','
	 FROM   SubAreasPagamento SAP
	 WHERE  SAP.IdCentroCusto IS NOT NULL
		    AND SAP.IdCentroCusto <> 0
			AND YEAR(SAP.DataEvento) = @ExercicioAtual          
			AND SAP.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                          FROM   CentroCustos CC
                                          WHERE  CC.Exercicio = @ExercicioEfetivo)
                              
     INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
     VALUES (1, 'IdCentroCusto', 'SubAreasPagamento', 'IdSubAreasPagamento', @QtdRegistros_Incorretos, @IdscomProblema)        
  END


  /*************** Conferindo HistoricosExtrato ***************/

  SELECT @QtdRegistros_Incorretos = COUNT(HE.IdHistorico)
  FROM   HistoricosExtrato HE
  WHERE  HE.IdCentroCusto IS NOT NULL
         AND HE.IdCentroCusto <> 0
         AND HE.Exercicio = @ExercicioAtual          
         AND HE.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
                                        FROM   CentroCustos CC
                                        WHERE  CC.Exercicio = @ExercicioEfetivo)
  
  IF @QtdRegistros_Incorretos > 0
  BEGIN
     SET @IdscomProblema = ''
     SELECT @IdscomProblema = @IdscomProblema + CAST(HE.IdHistorico AS VARCHAR(15)) + ','
	 FROM   HistoricosExtrato HE
	 WHERE  HE.IdCentroCusto IS NOT NULL
		    AND HE.IdCentroCusto <> 0
			AND HE.Exercicio = @ExercicioAtual          
			AND HE.IdCentroCusto NOT IN (SELECT CC.IdCentroCusto
				                         FROM   CentroCustos CC
					                     WHERE  CC.Exercicio = @ExercicioEfetivo)
  
                              
     INSERT INTO #tabtemp_Resultado (Erro, CampoVerificado, TabelaComProblema, CampoId, QtdRegistros, IdscomProblema)
     VALUES (1, 'IdCentroCusto', 'HistoricosExtrato', 'IdHistorico', @QtdRegistros_Incorretos, @IdscomProblema)        
  END

END

 --------------------- Retornando o Resultado ---------------------

IF @CodErro = 1
  SELECT CodErro=@CodErro, MsgErro=@MsgErro
ELSE  
  SELECT * FROM #tabtemp_Resultado
  
DROP TABLE #tabtemp_Resultado
