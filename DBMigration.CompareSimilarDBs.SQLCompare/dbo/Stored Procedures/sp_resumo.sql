

/*
PCS
André - 21/09/2009
André - 30/09/2009
*/
CREATE PROCEDURE [dbo].[sp_resumo]          
@Exercicio int,            
 @idCentroCusto int        
        
AS          
SET NOCOUNT ON          
/*          
vlr total analitica          
*/CREATE TABLE #TABTEMPRESUMTOTAL          
(          
 ids int ,        
    identif int IDENTITY(1,1),          
    codContaDespesa varchar(200),          
    periodo  money,          
    IdCentroCusto int,          
    analitica bit,          
    ValorFormatado varchar(25)          
)                   
          
INSERT INTO #TABTEMPRESUMTOTAL           
EXEC Sp_RelatorioOrcamentoPCS @Exercicio,          
         @idCentroCusto,          
         0,          
         0           
          
          
CREATE TABLE #TABTEMPRESUM2TOTAL          
(          
 ids int ,        
    identif int IDENTITY(1,1),          
    codContaReceita varchar(200),          
    periodo  money,          
    IdCentroCusto int,          
    analitica bit,          
    ValorFormatado varchar(25)          
)                   
          
INSERT INTO #TABTEMPRESUM2TOTAL          
EXEC Sp_RelatorioOrcamentoPCS @Exercicio,          
         @idCentroCusto,          
         1,          
         0           
          
          
          
          
CREATE TABLE #TABTEMPRESUM          
(          
    identif int IDENTITY(1,1),          
    codContaDespesa varchar(200),          
    periodo  money,          
    IdCentroCusto int,          
    analitica bit,          
    ValorFormatado varchar(25)          
)                   
          
INSERT INTO #TABTEMPRESUM           
EXEC Sp_RelatorioOrcamentoPCS @Exercicio,          
         @idCentroCusto,          
         0,          
         1           
          
          
CREATE TABLE #TABTEMPRESUM2          
(          
    identif int IDENTITY(1,1),          
    codContaReceita varchar(200),          
    periodo  money,          
    IdCentroCusto int,          
    analitica bit,          
    ValorFormatado varchar(25)          
)                   
          
INSERT INTO #TABTEMPRESUM2          
EXEC Sp_RelatorioOrcamentoPCS @Exercicio,          
         @idCentroCusto,          
         1,          
         1           
          
          
          
DECLARE @m int,          
        @m2 int          
SELECT @m = count(*)          
FROM   #TABTEMPRESUM          
SELECT @m2 = count(*)          
FROM   #TABTEMPRESUM2          
          
/*IF (@m > @m2 )          
BEGIN*/          
    SELECT isnull(#TABTEMPRESUM.analitica,0) AS AnaliticaDesp ,isnull(#TABTEMPRESUM2.analitica,0) AS AnaliticaRec ,isnull(codContaDespesa,'') AS codContaDespesa,isnull(#TABTEMPRESUM.ValorFormatado,'') AS vlrDespesa,isnull(#TABTEMPRESUM2.codContaReceita,''
  
    
      
        
) AS codContaReceita,isnull(#TABTEMPRESUM2.ValorFormatado,'') AS vlrReceita          
    FROM   #TABTEMPRESUM          
    LEFT JOIN #TABTEMPRESUM2          
      ON   #TABTEMPRESUM2.identif = #TABTEMPRESUM.identif          
    UNION ALL           
    SELECT '','','TOTAL DESPESA ',(SELECT dbo.format_currency(cast(SUM (#TABTEMPRESUMTOTAL.periodo )AS varchar))             
    FROM   #TABTEMPRESUMTOTAL              
                             WHERE  analitica = 1),          
      'TOTAL RECEITA',(SELECT dbo.format_currency(cast(SUM (#TABTEMPRESUM2TOTAL.periodo )AS varchar))           
    FROM   #TABTEMPRESUM2TOTAL              
                       WHERE  analitica = 1)          
/*END          
ELSE           
BEGIN          
SELECT codContaDespesa,#TABTEMPRESUM.ValorFormatado AS vlrDespesa,#TABTEMPRESUM2.codContaReceita,#TABTEMPRESUM2.ValorFormatado AS vlrReceita          
    FROM   #TABTEMPRESUM2          
    LEFT JOIN #TABTEMPRESUM          
      ON   #TABTEMPRESUM.identif = #TABTEMPRESUM2.identif          
END*/          
          
          
          
          
          
DROP TABLE #TABTEMPRESUM          
DROP TABLE #TABTEMPRESUM2          
DROP TABLE #TABTEMPRESUMTOTAL          
DROP TABLE #TABTEMPRESUM2TOTAL




