/* OC 17219 - Rodrigo Souza */ 
CREATE PROCEDURE [dbo].[Sp_PlanoContas] 
@Exercicio varchar(8000) = ''  -- Plurianual
AS   
SET NOCOUNT ON   

-- Plurianual
IF NOT EXISTS(SELECT TOP 1 1 FROM PlanoContas WHERE Exercicio = @Exercicio)
  SELECT @Exercicio = NULL

CREATE TABLE #PlConta  
 (  
  IdConta   int,  
  Grupo   int,  
  CodConta  varchar(18),  
  CodContaResumido  int,  
  ContaFormatada  varchar(27),  
  NomeConta  varchar(50),  
  Analitico  bit,  
  E_Banco bit  
 )  
DECLARE @idconta int, @grupo int, @codconta varchar(18),  
@codcontaresumido int, @nomeconta varchar(50), @analitico bit,  
@E_Banco bit, @i int, @contaformatada varchar(27)  
DECLARE plano_cursor CURSOR FAST_FORWARD FOR   
 SELECT IdConta, Grupo, CodConta, CodContaResumido, NomeConta, Analitico, E_Banco  
 FROM PlanoContas  
 WHERE (ISNULL(@Exercicio,0) = 0 AND PlanoContas.Exercicio IS NULL) OR (PlanoContas.Exercicio = @Exercicio)  -- Plurianual
 ORDER BY Grupo, Codconta  
OPEN plano_cursor  
FETCH NEXT FROM plano_cursor  
INTO @idconta, @grupo, @codconta, @codcontaresumido, @nomeconta, @analitico, @E_Banco  
WHILE @@FETCH_STATUS = 0  
BEGIN  
 set @contaformatada= Left(@codconta, 1)  
 If @grupo> 2   
 begin  
  set @i= 2  
  while @i <= len(@codconta)  
   begin      
    If @i < 4  
            set @contaformatada= @contaformatada + '.'  
    Else  
    If @i % 2 = 1   
     set @contaformatada= @contaformatada + '.'  
    set @contaformatada= @contaformatada + substring(@codconta,@i,1)  
    set @i= (@i + 1)  
   End  
 End  
 Else  
 Begin          
  set @i= 2  
  while @i <= len(@codconta)  
   begin     
    If @i < 5  
            set @contaformatada= @contaformatada + '.'  
    Else  
    If @i % 2 = 0   
     set @contaformatada= @contaformatada + '.'  
    set @contaformatada= @contaformatada + substring(@codconta,@i,1)  
    set @i= @i + 1  
   End  
 End  
 INSERT #PlConta  
  VALUES(  
   @idconta,  
   @grupo,  
   @codconta,  
   @codcontaresumido,  
   @contaformatada,  
   @nomeconta,  
   @analitico,  
   @E_banco  
   )  
 FETCH NEXT FROM plano_cursor  
 INTO @idconta, @grupo, @codconta, @codcontaresumido, @nomeconta, @analitico, @E_Banco  
END  
CLOSE plano_cursor  
DEALLOCATE plano_cursor  
  
Select *  
From #PlConta  
