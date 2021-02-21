

/* Miler - OC 29234 */
CREATE PROCEDURE [dbo].[sp_WebEfetuaEstornoRecolhimento] @idUser VARCHAR(10) = '0', @tributos VARCHAR(1000)
 AS  
SET NOCOUNT ON  
  
EXEC ('UPDATE web_detalhesDespesa   
SET datarecolhimento = null ,IdContaFinanceira = null,  
IdUsuarioEstornoRecolhimento = '+@idUser +'  
WHERE idDetalheDespesa in ('+@tributos+')')  





