/*Criado pelo Selvino em 06/04/2011 - Ocorr. 68443*/

CREATE FUNCTION [dbo].[ufnOrigemRECREN]
(
	@IdDebito INT
)
RETURNS VARCHAR(800)
AS
BEGIN 
	DECLARE @Ano VARCHAR(4)
	DECLARE @Exercicios VARCHAR(50)
	SET @Exercicios = NULL;
	
	DECLARE origem_cursor               CURSOR FAST_FORWARD READ_ONLY 
	FOR
	    SELECT DISTINCT CAST(YEAR(debitoOrigem.DataReferencia) AS VARCHAR(4)) AS Ano
	      FROM Debitos d
	           JOIN ComposicoesDebito cd
	             ON cd.IdDebito = d.IdDebito
	           JOIN Debitos debitoOrigem
	             ON debitoOrigem.IdDebito = cd.IdDebitoOrigemRen
	    WHERE D.IdDebito = @IdDebito
	    ORDER BY Ano
	OPEN origem_cursor 
	FETCH FROM origem_cursor INTO @Ano
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @Exercicios IS NULL
		   SET @Exercicios = @Ano
		ELSE 
		   SET @Exercicios = @Exercicios + ', ' + @Ano   
	    FETCH FROM origem_cursor INTO @Ano
	END
	CLOSE origem_cursor
	DEALLOCATE origem_cursor

	RETURN @Exercicios
END
