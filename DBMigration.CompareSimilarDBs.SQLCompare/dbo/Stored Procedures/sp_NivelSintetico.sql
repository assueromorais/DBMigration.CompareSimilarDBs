/* OC 17219 - Rodrigo Souza */ 
CREATE PROCEDURE dbo.sp_NivelSintetico    
@Exercicio VARCHAR(4) = ''  -- Plurianual    
AS    
 SELECT @Exercicio = CASE WHEN (SELECT TOP 1 1 FROM CentroCustos WHERE Exercicio = @Exercicio) = 1 THEN @Exercicio ELSE 0 END  -- Plurianual   
 SET NOCOUNT ON      
 CREATE TABLE #SINTETICOREF    
 (    
  IdCentroCusto               INT,    
  IdCentroCustoSintetico      INT,    
  CodigoCentroCustoSintetico  VARCHAR(8) COLLATE database_default    
 )      
     
 DECLARE @IdCentroCusto       INT,    
         @CodigoCentroCusto   VARCHAR(8),    
         @CodigoSintetico     VARCHAR(8),    
         @i                   integer,    
         @IdSintetico         INT,    
         @Evento                                      BIT    
     
 DECLARE SinteticoRef_cursor                          CURSOR FAST_FORWARD     
 FOR    
     SELECT IdCentroCusto, CodigoCentroCusto, Evento      
     FROM CentroCustos    
  WHERE ISNULL(Exercicio,0) = @Exercicio  -- Plurianual   
     ORDER BY    
     CodigoCentroCusto    
     
 OPEN SinteticoRef_cursor     
 FETCH NEXT FROM SinteticoRef_cursor     
 INTO @IdCentroCusto, @CodigoCentroCusto, @Evento                                                               
 WHILE @@FETCH_STATUS = 0    
 BEGIN    
     SET @i = 1      
     SET @IdSintetico = NULL      
     SET @CodigoSintetico = ''     
     PRINT @CodigoCentroCusto      
     WHILE @i < LEN(@CodigoCentroCusto) + 1    
     BEGIN    
         SET @IdSintetico = (    
                 SELECT A.IdCentroCusto    
                 FROM CentroCustos A    
                 INNER JOIN CentroCustos B ON B.CodigoCentroCusto LIKE     
                      SUBSTRING(@CodigoCentroCusto, 1, LEN(@CodigoCentroCusto) -@i)    
                      + '%'    
                 WHERE A.CodigoCentroCusto = SUBSTRING(@CodigoCentroCusto, 1, LEN(@CodigoCentroCusto) -@i)    
                 AND A.Evento = @Evento    
     AND ISNULL(A.Exercicio,0) = @Exercicio  -- Plurianual   
                 GROUP BY    
                 A.IdCentroCusto    
                 HAVING     
                 COUNT(A.IdCentroCusto) > 1    
             )    
             
         SET @CodigoSintetico = (    
                 SELECT A.CodigoCentroCusto    
                 FROM CentroCustos A    
                 INNER JOIN CentroCustos B ON B.CodigoCentroCusto LIKE     
                      SUBSTRING(@CodigoCentroCusto, 1, LEN(@CodigoCentroCusto) -@i)    
                      + '%'    
                 WHERE A.CodigoCentroCusto = SUBSTRING(@CodigoCentroCusto, 1, LEN(@CodigoCentroCusto) -@i)    
                 AND A.Evento = @Evento    
     AND ISNULL(A.Exercicio,0) = @Exercicio  -- Plurianual   
                 GROUP BY    
                 A.CodigoCentroCusto    
                 HAVING     
                 COUNT(A.CodigoCentroCusto) > 1    
             )    
             
         IF @CodigoSintetico <> ''    
             SET @i = LEN(@CodigoCentroCusto)    
             
         SET @i = @i + 1    
     END       
     IF @CodigoSintetico <> ''    
         INSERT INTO #SINTETICOREF    
         VALUES    
           (    
             @IdCentroCusto,    
             @IdSintetico,    
             @CodigoSintetico    
           )     
         
     FETCH NEXT FROM SinteticoRef_cursor     
     INTO @IdCentroCusto, @CodigoCentroCusto, @Evento    
 END     
 CLOSE SinteticoRef_cursor     
 DEALLOCATE SinteticoRef_cursor      
     
 SELECT *    
 FROM #SINTETICOREF      
