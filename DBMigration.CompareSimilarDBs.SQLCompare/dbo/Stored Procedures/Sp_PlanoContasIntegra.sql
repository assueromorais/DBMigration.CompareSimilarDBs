/* OC 17219 - Rodrigo Souza */ 
CREATE PROCEDURE dbo.Sp_PlanoContasIntegra   
@ebanco char(1)= '',  
@Grupo1 bit = 0,  
@Grupo2 bit = 0,  
@Grupo3 bit = 0,  
@Grupo4 bit = 0,  
@Grupo5 bit = 0,  
@Grupo6 bit = 0,
@Exercicio VARCHAR(4) = ''  -- Plurianual  
AS   
SET NOCOUNT ON  
CREATE TABLE #PlConta  
 (  
  IdConta   int,  
  Grupo   int,  
  CodConta  varchar(18) COLLATE database_default,  
  CodContaResumido  smallint,  
  ContaFormatada  varchar(27) COLLATE database_default,  
  NomeConta  varchar(50) COLLATE database_default,  
  Analitico  bit,  
  E_Banco bit  
 )  
DECLARE @idconta int, @grupo int, @codconta varchar(18),  
@codcontaresumido smallint, @nomeconta varchar(50), @analitico bit,  
@E_Banco bit, @i int, @contaformatada varchar(27)  
DECLARE plano_cursor CURSOR FAST_FORWARD FOR   
SELECT IdConta, Grupo, CodConta, CodContaResumido, NomeConta, Analitico, E_Banco  
 FROM PlanoContas  
 WHERE GRUPO <> 2
 AND ISNULL(Exercicio,0) = CASE WHEN (SELECT TOP 1 1 FROM PlanoContas PC WHERE PC.Exercicio = @Exercicio) = 1 THEN @Exercicio ELSE 0 END  -- Plurianual  
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
From #PlConta where (analitico = 1) and (Grupo <> 2) and (E_banco like @ebanco)   
and IdConta not in(select IdConta from PlanoContasIntegracao)  
and ((Grupo = 1 and @Grupo1 = 1) or (Grupo = 2 and @Grupo2 = 1)or(Grupo = 3 and @Grupo3 = 1)  
or (Grupo = 4 and @Grupo4 = 1) or (Grupo = 5 and @Grupo5 = 1) or (Grupo = 6 and @Grupo6 = 1))  
Order By CodConta  
  
  
