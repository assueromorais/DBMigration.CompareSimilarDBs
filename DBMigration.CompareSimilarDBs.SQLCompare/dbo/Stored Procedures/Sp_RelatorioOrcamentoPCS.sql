/*
PCS
André - 21/09/2009
André - 30/09/2009
Miler - 08/12/2009
*/
CREATE PROCEDURE [dbo].[Sp_RelatorioOrcamentoPCS]                     
@Exercicio int,              
 @idCentroCusto int,              
 @AnaliticoReceita bit,              
 @Resumo bit              
AS              
SET NOCOUNT ON                        
              
DECLARE @TemFilho BIT                        
SET @TemFilho = 0                        
              
CREATE TABLE #TABPER              
(              
    Grupo  int,              
    CodConta varchar(18),              
    Periodo  money              
)                        
CREATE INDEX TEMPIND ON #TABPER (Grupo, CodConta, Periodo)                        
IF @AnaliticoReceita = 1              
    INSERT #TABPER                        
SELECT Grupo,              
       CodConta,              
       Sum(Valor)              
FROM   PlanoContas,              
       Web_Dotacoes              
WHERE  PlanoContas.IdConta = Web_Dotacoes.IdConta              
  AND  YEAR(Web_Dotacoes.DataDotacao) = @Exercicio              
  AND  PlanoContas.Grupo IN (3, 6)              
  AND  Web_Dotacoes.IdCentroCusto = @idCentroCusto              
GROUP BY              
       Grupo,              
       CodConta                        
       ELSE                      
INSERT #TABPER                        
SELECT Grupo,              
       CodConta,              
       Sum(Valor)              
FROM   PlanoContas,              
       Web_Dotacoes              
WHERE  PlanoContas.IdConta = Web_Dotacoes.IdConta              
  AND  YEAR(Web_Dotacoes.DataDotacao) = @Exercicio              
  AND  PlanoContas.Grupo IN (4, 5)              
  AND  Web_Dotacoes.IdCentroCusto = @idCentroCusto              
GROUP BY              
       Grupo,              
       CodConta                        
              
CREATE TABLE #TABTEMP1              
(              
    IdConta int,              
    Grupo  int,              
    CodConta varchar(27),              
    NomeConta varchar(50),              
    Analitico bit,              
    Periodo  money,              
    PCS int              
)                        
            
CREATE TABLE #TABTEMP1ORDENADA            
(              
 ids int IDENTITY ,            
    Conta varchar(200),              
    valor money,              
    IdCentroCusto int,              
    Analitica bit,              
    ValorFormatado money          
)                    
            
                                
DECLARE @IdConta int,              
        @grupo int,              
        @codconta varchar(18),              
        @nomeconta varchar(50),              
        @analitico bit,              
        @codaux varchar(18),              
        @i int,              
        @contaformatada varchar(27),              
        @periodo money,              
        @PCS int                        
IF @AnaliticoReceita = 1              
    DECLARE plano_cursor CURSOR FAST_FORWARD               
    FOR              
        SELECT IdConta,              
               Grupo,              
               CodConta,              
               NomeConta,              
               Analitico              
        FROM   PlanoContas              
        WHERE  PlanoContas.Grupo IN (3, 6)              
        ORDER BY              
               Grupo,              
               Codconta              
ELSE               
    DECLARE plano_cursor CURSOR FAST_FORWARD               
    FOR              
        SELECT IdConta,              
               Grupo,              
               CodConta,              
               NomeConta,              
               Analitico              
        FROM   PlanoContas              
        WHERE  PlanoContas.Grupo IN (4, 5)              
        ORDER BY              
               Grupo,              
               Codconta                        
              
OPEN plano_cursor                        
FETCH NEXT FROM plano_cursor                        
INTO @IdConta, @grupo, @codconta, @nomeconta, @analitico                   
                        
WHILE @@FETCH_STATUS = 0              
BEGIN              
    SET @contaformatada = LEFT(@codconta, 1)                 
    SET @codaux = @codconta                        
    IF @grupo> 2              
    BEGIN              
        IF @analitico= 0                        
        SET @codaux= replace(rtrim(replace(@codconta, '0', ' ')),' ','0')              
            IF (LEN(@codaux) > 1 )              
               AND (LEN(@codaux) % 2 ) <> 0              
            BEGIN              
                EXECUTE Sp_CalculaContaFilho @codconta, @grupo,@Exercicio, @TemFilho OUTPUT                        
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
        SET @i = 2                        
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
                  
    SET @periodo=(                        
    SELECT IsNull(Sum(Periodo),0)              
    FROM   #TABPER              
    WHERE  #TABPER.Grupo = @grupo              
      AND  #TABPER.CodConta >= @codaux              
      AND  #TABPER.CodConta < (@codaux+'a'))                        
                    
      SET @PCS=(                        
      SELECT ISNULL(COUNT(*), 0)              
      FROM   Web_Dotacoes WD              
      INNER JOIN PlanoContas PC              
        ON   PC.IdConta = WD.IdConta              
      WHERE  PC.Grupo = @grupo              
        AND  PC.CodConta >= @codaux              
        AND  PC.CodConta < (@codaux+'a'))                        
                  
    INSERT #TABTEMP1                        
    SELECT @IdConta,              
           @grupo,              
           @contaformatada,              
           @nomeconta,              
           @analitico,              
           @periodo,              
           @PCS                        
                  
    FETCH NEXT FROM plano_cursor                        
    INTO @IdConta, @grupo, @codconta, @nomeconta, @analitico              
END                         
CLOSE plano_cursor                        
DEALLOCATE plano_cursor                        
                      
                      
IF @Resumo <> 1            
BEGIN              
 INSERT #TABTEMP1ORDENADA            
                
               SELECT codConta + '-' + NomeConta AS Conta,              
                      periodo AS valor,              
                      IdCentroCusto,              
                      isnull(Analitica ,              
                      0) AS Analitica,              
                      Periodo             
               FROM   #TABTEMP1              
               LEFT JOIN web_dotacoes wt              
                 ON   wt.idConta = #TABTEMP1.idConta              
                AND   wt.idCentroCusto = @IdCentroCusto              
                AND   year(wt.dataDotacao) = @Exercicio      
               WHERE  PCS > 0              
                 AND  (              
                          (@Resumo = 1 AND  Analitico = 0 )              
                      OR  (@Resumo = 0 )              
                 )        
             ORDER BY #TABTEMP1.CodConta                  
                        
 INSERT #TABTEMP1ORDENADA            
               SELECT '  TOTAL ',              
                      0,              
                      '',              
                      '',              
                      sum(Periodo      )          
                                  
               FROM   #TABTEMP1              
               LEFT JOIN web_dotacoes wt              
                 ON   wt.idConta = #TABTEMP1.idConta              
                AND   wt.idCentroCusto = @IdCentroCusto              
                AND   year(dataDotacao) = @Exercicio      
 WHERE  PCS > 0              
                 AND  #TABTEMP1.Analitico = 1              
                             
SELECT ids,Conta,              
           valor,              
           IdCentroCusto,              
           isnull(Analitica ,              
           0) AS Analitica,              
           dbo.format_currency(cast(valorFormatado AS varchar)) AS ValorFormatado               
from                 #TABTEMP1ORDENADA            
            
ORDER BY ids, Conta            
                    
END          
ELSE               
BEGIN              
    SELECT codConta + '-' + NomeConta AS Conta,              
           periodo AS valor,              
           IdCentroCusto,              
           isnull(Analitica ,              
           0) AS Analitica,              
           dbo.format_currency(cast(Periodo AS varchar)) AS ValorFormatado              
    FROM   #TABTEMP1              
    LEFT JOIN web_dotacoes wt              
      ON   wt.idConta = #TABTEMP1.idConta              
     AND   wt.idCentroCusto = @IdCentroCusto        
     AND   year(dataDotacao) = @Exercicio            
    WHERE  PCS > 0              
      AND  (              
  (@Resumo = 1 AND  Analitico = 0 )              
           OR  (@Resumo = 0 )              
      )              
      ORDER BY #TABTEMP1.CodConta              
END              
              
DROP TABLE #TABPER                        
DROP TABLE #TABTEMP1
