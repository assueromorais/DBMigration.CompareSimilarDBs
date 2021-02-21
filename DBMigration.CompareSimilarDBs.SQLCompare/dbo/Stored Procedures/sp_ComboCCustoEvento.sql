/* OC 17219 - Rodrigo Souza */  
/* OC 71293 - Rodrigo Souza */   
CREATE PROCEDURE [dbo].[sp_ComboCCustoEvento]    
    
@Id integer,    
@Tipo varchar(7) = 'STRING',    
@Dado varchar(60) = '',    
@Exercicio varchar(4) = ''  -- Plurianual    
AS    
PRINT @Exercicio   
SELECT @Exercicio = CASE WHEN (SELECT TOP 1 1 FROM CentroCustos WHERE Exercicio = @Exercicio) = 1 THEN @Exercicio ELSE 0 END    
PRINT @Exercicio  
SET NOCOUNT ON    
    
CREATE TABLE #CodigosCCustoEvento    
(    
 IdCentroCusto int,    
 CodigoCentroCusto varchar(15) COLLATE database_default,    
 Analitico int    
)    
INSERT INTO #CodigosCCustoEvento EXEC dbo.sp_CodigosCCustoEvento '', @Exercicio  -- Plurianual    
    
IF @Id <> NULL    
BEGIN    
 SELECT DISTINCT A.IdCentroCusto,C.CodigoCentroCusto,A.NomeCentroCusto,C.Analitico,A.Evento    
 FROM CentroCustos A    
 LEFT JOIN CentroCustos B ON B.CodigoCentroCusto like A.CodigoCentroCusto+'%' /*AND B.Evento = A.Evento*/    
 LEFT JOIN #CodigosCCustoEvento C ON C.IdCentroCusto = A.IdCentroCusto    
 WHERE A.IdCentroCusto = @Id    
 AND (ISNULL(@Exercicio,0) = 0 AND A.Exercicio IS NULL) OR (ISNULL(A.Exercicio,0) = ISNULL(@Exercicio,0))  -- Plurianual  
 ORDER BY A.Evento,C.CodigoCentroCusto    
END    
ELSE    
 If @Tipo = 'STRING'    
 BEGIN    

  SELECT DISTINCT A.IdCentroCusto,C.CodigoCentroCusto,A.NomeCentroCusto,C.Analitico,A.Evento    
  FROM CentroCustos A    
  LEFT JOIN CentroCustos B ON B.CodigoCentroCusto like A.CodigoCentroCusto+'%' /*AND B.Evento = A.Evento*/    
  LEFT JOIN #CodigosCCustoEvento C ON C.IdCentroCusto = A.IdCentroCusto    
  WHERE A.NomeCentroCusto LIKE @Dado + '%'    
  AND (ISNULL(@Exercicio,0) = 0 AND A.Exercicio IS NULL) OR (ISNULL(A.Exercicio,0) = ISNULL(@Exercicio,0))  -- Plurianual  
  ORDER BY A.Evento, A.NomeCentroCusto  --C.CodigoCentroCusto -- OC 71293
 END    
 ELSE    
 BEGIN    
  SELECT DISTINCT A.IdCentroCusto,CASE WHEN CHARINDEX('.', @Dado) > 0 THEN C.CodigoCentroCusto ELSE REPLACE(C.CodigoCentroCusto, '.', '') END CodigoCentroCusto,A.NomeCentroCusto,C.Analitico,A.Evento    
  FROM CentroCustos A    
  LEFT JOIN CentroCustos B ON B.CodigoCentroCusto like A.CodigoCentroCusto+'%' /*AND B.Evento = A.Evento*/    
  LEFT JOIN #CodigosCCustoEvento C ON C.IdCentroCusto = A.IdCentroCusto    
  WHERE A.CodigoCentroCusto LIKE REPLACE(@Dado,'.','') + '%'    
  AND (ISNULL(@Exercicio,0) = 0 AND A.Exercicio IS NULL) OR (ISNULL(A.Exercicio,0) = ISNULL(@Exercicio,0))  -- Plurianual  
  ORDER BY A.Evento,CodigoCentroCusto    
 END    

  
  
  
  
  
