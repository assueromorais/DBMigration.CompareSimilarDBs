/* Felipe Campos  oc 76361   05/04/2011  */

CREATE PROCEDURE dbo.sp_getContasPersonalizadas(@Parametro VARCHAR(4))
AS
BEGIN
	DECLARE @Exercicio VARCHAR(4) 
	IF EXISTS(
	       SELECT 1
	       FROM   PlanoContas
	       WHERE  Exercicio = @Parametro
	   )
	BEGIN
	    SET @Exercicio = @Parametro
	END
	ELSE
	BEGIN
	    SET @Exercicio = '0'
	END
	
	SELECT DISTINCT NomePersonalizado
	FROM   GruposContasPersonalizados g
	       INNER JOIN PlanoContas pc
	            ON  pc.IdConta = g.IdConta
	WHERE  ISNULL(pc.Exercicio, '0') = @Exercicio
END
