/*
 * Oc 198352 
 * Criado por Seila
 * Adicionado por LeandroS
 */
  
CREATE FUNCTION ufnCheckNossoNumero(@IdEmissao INT,@NossoNumero VARCHAR(20))
RETURNS BIT 
AS 
BEGIN
	DECLARE @Existe BIT   

	IF EXISTS (SELECT TOP 1 IdEmissao
				FROM DetalhesEmissao 
				WHERE NossoNumero <> '00000000000000000'
				    AND NossoNumero = @NossoNumero 
					AND IdEmissao <> @IdEmissao )
		SET @Existe = 1
	ELSE 
		SET	@Existe = 0   
		
   RETURN @Existe
END
