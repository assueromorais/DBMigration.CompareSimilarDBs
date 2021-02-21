
CREATE FUNCTION fnReferenciaDetalheEmissao
(
	@IdDetalheEmissao     INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @Result          VARCHAR(MAX), 
	        @SiglaDebito    VARCHAR(30), 
	        @Exercicio      INT, 
	        @NumeroParcela   INT
		
	SET @Result = ''

	DECLARE cursorDetalhesEmissao CURSOR  
	FOR
	    SELECT ce.Sigladebito, YEAR(ce.DataReferenciaDebito) Exercicio, ce.NumeroParcela FROM 
			dbo.ComposicoesEmissao ce 
			JOIN dbo.DetalhesEmissao de ON de.IdDetalheEmissao = ce.IdDetalheEmissao WHERE ce.IdDetalheEmissao = @IdDetalheEmissao
	
	
	OPEN cursorDetalhesEmissao 
	FETCH NEXT FROM cursorDetalhesEmissao INTO @SiglaDebito, @Exercicio, @NumeroParcela
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @Result <> '' 
		   SET @Result = @Result + ' - '
		   
	    SET @result = @Result + @SiglaDebito + '/' + CAST(@Exercicio AS VARCHAR(4)) +  ' Parc ' + CAST(@NumeroParcela AS VARCHAR(10)) 
 	    
	    FETCH NEXT FROM cursorDetalhesEmissao INTO @SiglaDebito, @Exercicio, @NumeroParcela
	END 
	
	CLOSE cursorDetalhesEmissao 
	DEALLOCATE cursorDetalhesEmissao 
	
	
	RETURN @result
END
