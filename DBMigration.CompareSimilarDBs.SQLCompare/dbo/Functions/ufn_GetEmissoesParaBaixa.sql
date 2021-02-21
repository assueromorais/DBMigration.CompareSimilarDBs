  
CREATE FUNCTION dbo.ufn_GetEmissoesParaBaixa( @EmissoesAguardandoBaixa     BIT,  
                                              @EmissoesVencidas            BIT,  
                                              @EmissoesVencidasData        DATETIME,  
                                              @EmissoesDebitosPagos        BIT,  
                                              @EmissoesDebitosRenegociados BIT,  
                                              @EmissoesDebitosCancelados   BIT,  
                                              @EmissoesDebitosExcluidos    BIT )  
RETURNS @Emissoes TABLE ( IdDetalheEmissao INT, 
                          EmissoesAguardandoBaixa     BIT, 
                          EmissoesVencidas            BIT,  
                          EmissoesDebitosPagos        BIT,  
                          EmissoesDebitosRenegociados BIT,  
                          EmissoesDebitosCancelados   BIT,  
                          EmissoesDebitosExcluidos    BIT )  
AS  
BEGIN    
  DECLARE @EmissoesTMP TABLE ( IdDetalheEmissao INT, 
                                EmissoesAguardandoBaixa     TINYINT,
                                EmissoesVencidas            TINYINT,  
                                EmissoesDebitosPagos        TINYINT,  
                                EmissoesDebitosRenegociados TINYINT,  
                                EmissoesDebitosCancelados   TINYINT,  
                                EmissoesDebitosExcluidos    TINYINT )

 /*  
 *  EMISSÕES VENCIDAS
 */   
  
 IF @EmissoesVencidas = 1  
  INSERT INTO @EmissoesTMP (IdDetalheEmissao, EmissoesVencidas)  
  SELECT IdDetalheEmissao, 1
  FROM   DetalhesEmissao  
  WHERE  IdEmissaoConfig IS NOT NULL  
    AND SituacaoRegistro IN (2, 3, 7)  
    AND DataVencimento <= @EmissoesVencidasData  
  
 /*  
 *  DÉBITOS PAGOS
 */   
  
 IF @EmissoesDebitosPagos = 1  
  INSERT INTO @EmissoesTMP (IdDetalheEmissao, EmissoesDebitosPagos)  
  SELECT DISTINCT   
    de.IdDetalheEmissao, 1
  FROM   DetalhesEmissao de  
    JOIN ComposicoesEmissao ce ON ce.IdDetalheEmissao = de.IdDetalheEmissao  
    JOIN Debitos d ON d.IdDebito = ce.IdDebito  
  WHERE  de.IdEmissaoConfig IS NOT NULL  
    AND d.IdSituacaoAtual IN (2, 4, 5, 11)  
    AND de.SituacaoRegistro IN (2,3,7)  
    AND NOT EXISTS (  
      SELECT TOP 1 1  
      FROM   ComposicoesEmissao ce2  
        JOIN Debitos d2 ON d2.IdDebito = ce2.IdDebito  
      WHERE  ce2.IdDetalheEmissao = de.IdDetalheEmissao    
        AND d2.IdSituacaoAtual IN (1,3,10,15)  
     )   
  
 /*  
 *  DÉBITOS RENEGOCIADOS
 */


 IF @EmissoesDebitosRenegociados = 1
  INSERT INTO @EmissoesTMP (IdDetalheEmissao, EmissoesDebitosRenegociados )
  SELECT DISTINCT
    de.IdDetalheEmissao, 1
  FROM   DetalhesEmissao de
    JOIN ComposicoesEmissao ce ON ce.IdDetalheEmissao = de.IdDetalheEmissao
    JOIN Debitos d ON d.IdDebito = ce.IdDebito
  WHERE  de.IdEmissaoConfig IS NOT NULL
    AND d.IdSituacaoAtual IN (6,14)
    AND de.SituacaoRegistro IN (2,3,7)
    AND NOT EXISTS (
      SELECT TOP 1 1
      FROM   ComposicoesEmissao ce2
        JOIN Debitos d2 ON d2.IdDebito = ce2.IdDebito
      WHERE  ce2.IdDetalheEmissao = de.IdDetalheEmissao
        AND d2.IdSituacaoAtual IN (1,3,10,15)
     )

 /*
 *  DÉBITOS CANCELADOS
 */

 IF @EmissoesDebitosCancelados = 1
  INSERT INTO @EmissoesTMP (IdDetalheEmissao, EmissoesDebitosCancelados)
  SELECT DISTINCT
    de.IdDetalheEmissao, 1
  FROM   DetalhesEmissao de
    JOIN ComposicoesEmissao ce ON ce.IdDetalheEmissao = de.IdDetalheEmissao
    JOIN Debitos d ON d.IdDebito = ce.IdDebito
  WHERE  de.IdEmissaoConfig IS NOT NULL
    AND d.IdSituacaoAtual IN (9,12)
    AND de.SituacaoRegistro IN (2,3,7)
    AND NOT EXISTS (
      SELECT TOP 1 1
      FROM   ComposicoesEmissao ce2
        JOIN Debitos d2 ON d2.IdDebito = ce2.IdDebito
      WHERE  ce2.IdDetalheEmissao = de.IdDetalheEmissao
        AND d2.IdSituacaoAtual IN (1,3,10,15)
     )

 /*
 *  DÉBITOS EXCLUÍDOS
 */

 IF @EmissoesDebitosExcluidos = 1
  INSERT INTO @EmissoesTMP (IdDetalheEmissao, EmissoesDebitosExcluidos)
  SELECT DISTINCT
    de.IdDetalheEmissao, 1
  FROM   DetalhesEmissao de
    JOIN ComposicoesEmissao ce ON ce.IdDetalheEmissao = de.IdDetalheEmissao
    LEFT JOIN Debitos d ON d.IdDebito = ce.IdDebito
  WHERE  de.IdEmissaoConfig IS NOT NULL
    AND de.SituacaoRegistro IN (2,3,7)
	AND d.IdDebito IS NULL
    AND NOT EXISTS (
      SELECT TOP 1 1
      FROM   ComposicoesEmissao ce2
        JOIN Debitos d2 ON d2.IdDebito = ce2.IdDebito
      WHERE  ce2.IdDetalheEmissao = de.IdDetalheEmissao
        AND  d2.IdSituacaoAtual IN (1,3,10,15)
     )

 INSERT INTO @Emissoes ( IdDetalheEmissao,
                         EmissoesAguardandoBaixa,
                         EmissoesVencidas,
                         EmissoesDebitosPagos,
                         EmissoesDebitosRenegociados,
                         EmissoesDebitosCancelados,
                         EmissoesDebitosExcluidos )
 SELECT IdDetalheEmissao,
        CASE WHEN SUM(EmissoesAguardandoBaixa    ) > 0 THEN 1 ELSE 0 END,
        CASE WHEN SUM(EmissoesVencidas           ) > 0 THEN 1 ELSE 0 END,
        CASE WHEN SUM(EmissoesDebitosPagos       ) > 0 THEN 1 ELSE 0 END,
        CASE WHEN SUM(EmissoesDebitosRenegociados) > 0 THEN 1 ELSE 0 END,
        CASE WHEN SUM(EmissoesDebitosCancelados  ) > 0 THEN 1 ELSE 0 END,
        CASE WHEN SUM(EmissoesDebitosExcluidos   ) > 0 THEN 1 ELSE 0 END
  FROM @EmissoesTMP
 GROUP BY IdDetalheEmissao

 RETURN
END

