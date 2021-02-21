

/*
PCS
André - 29/09/2009
*/

CREATE PROCEDURE [dbo].[Sp_StatusOrcamento]                      
 @idCentroCusto int,          
 @Exercicio int,       
 @Status char(1),          
 @IdUsuario int      
AS          
SET NOCOUNT ON                    
          
DECLARE @Identificador bit       
      
SELECT @Identificador = Identificador FROM  StatusOrcamento      
WHERE IdCentroCusto = @idCentroCusto AND Ano = @Exercicio    
      
PRINT @Identificador      
IF @Identificador >0       
BEGIN      
 UPDATE StatusOrcamento      
 SET      
        
  IdCentroCusto = @idCentroCusto,      
  Ano = @Exercicio,      
  Status = @Status,      
  IdUsuarioFinalizacao = @IdUsuario,      
  DataFinalizacao = getDate()      
 WHERE IdCentroCusto = @idCentroCusto AND Ano = @Exercicio
END      
ELSE      
BEGIN      
 INSERT INTO StatusOrcamento      
 (        
  IdCentroCusto,      
  Ano,      
  Status,      
  IdUsuarioFinalizacao,      
  DataFinalizacao      
 )      
 VALUES      
 (       
   @IdCentroCusto ,      
   @Exercicio ,      
   @Status ,      
   @IdUsuario ,      
   getDate()      
 )        
END




