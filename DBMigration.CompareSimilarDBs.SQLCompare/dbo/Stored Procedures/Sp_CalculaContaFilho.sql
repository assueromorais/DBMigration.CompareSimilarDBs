/* OC 17219 - Rodrigo Souza */ 
/* OC 60144 - Andre */
/* OC 70589 - Kleber - 02/12/2010*/

CREATE PROCEDURE [dbo].[Sp_CalculaContaFilho] @Conta VARCHAR(12), @Grupo VARCHAR(1), @Exercicio VARCHAR(4), @TemFilho BIT = 0 OUTPUT  
  
AS  
  
DECLARE @Grupo1 INT  
DECLARE @codconta1 VARCHAR(18),@ExisteExercicio VARCHAR(18)

SET @ExisteExercicio = NULL
SELECT @ExisteExercicio = pc.CodConta FROM PlanoContas pc WHERE isnull(pc.Exercicio,0) = isnull(@Exercicio,0)

IF @ExisteExercicio IS NULL 
	SET @Exercicio = '0'  
  
SET @TemFilho = 0
IF  @Exercicio IS NULL
  SET @Exercicio = '0'  
  
SELECT TOP 1 @codconta1 = CodConta FROM PlanoContas WHERE PlanoContas.CodConta > @Conta AND PlanoContas.Grupo = @Grupo AND ISNULL(Exercicio,0) = @Exercicio ORDER BY Grupo, CodConta  
  
IF @codconta1 <> ''  
BEGIN  
        IF (LEN(@codconta1) % 2 = 0) AND (LEN(@codconta1) >= 6)  
        BEGIN  
                IF SUBSTRING(@codconta1,1,1) = '1'  
                        SET @Grupo1 = 3  
                ELSE IF SUBSTRING(@codconta1,1,1) = '3'  
                        SET @Grupo1 = 4  
                ELSE IF SUBSTRING(@codconta1,1,1) = '9'  
                        SET @Grupo1 = 4  
                ELSE IF SUBSTRING(@codconta1,1,1) = '4'  
                        SET @Grupo1 = 5  
                ELSE IF SUBSTRING(@codconta1,1,1) = '2'  
                        SET @Grupo1 = 6  
        END  
        ELSE  
        BEGIN  
                IF SUBSTRING(@codconta1,1,1) = '2'  
                        SET @Grupo1 = 1  
                ELSE IF SUBSTRING(@codconta1,1,1) = '3'  
                        SET @Grupo1 = 2  
        END  
END  
  
IF @Grupo1 <= 2  
BEGIN  
        IF LEN(@codconta1) > 3  
                SET @codconta1 = REPLACE(@codconta1, LEN(@codconta1)-1,2)  
        ELSE  
                SET @codconta1 = REPLACE(@codconta1, LEN(@codconta1),1)  
END  
ELSE  
BEGIN  
        IF LEN(@codconta1) > 6  
                SET @codconta1 = SUBSTRING(@codconta1, 1, LEN(@Conta))  
/*                SET @codconta1 = REPLACE(@codconta1, LEN(@codconta1)-1,2)*/  
        ELSE IF CAST(SUBSTRING(@codconta1,5,2) AS INTEGER) <> 0  
                SET @codconta1 = SUBSTRING(@codconta1,1,4) + '00'  
        ELSE IF CAST(SUBSTRING(@codconta1,3,2) AS INTEGER) <> 0  
                SET @codconta1 = SUBSTRING(@codconta1,1,2) + '0000'  
        ELSE IF CAST(SUBSTRING(@codconta1,2,1) AS INTEGER) <> 0  
                SET @codconta1 = SUBSTRING(@codconta1,1,1) + '00000'  
        ELSE  
                SET @codconta1 = ''  
END  
  
IF @codconta1 = @Conta  
        SET @TemFilho = 1
