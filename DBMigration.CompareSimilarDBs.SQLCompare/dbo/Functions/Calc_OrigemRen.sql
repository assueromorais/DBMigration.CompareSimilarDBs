CREATE FUNCTION [dbo].[Calc_OrigemRen] (@IdDebito int, @TipoPessoa int)
	RETURNS decimal (15,2)
	AS
	BEGIN
		DECLARE @result decimal(15,2), @ValorDevido decimal(15,2), @Data DateTime
		DECLARE @Total table (Valor decimal(15,2))
		INSERT INTO @Total
		SELECT ISNULL(CASE WHEN ValorPago > 0 THEN dbo.Calc_PagoMenor(IdDebito, @TipoPessoa)  
					 WHEN IdMoeda = 2 THEN dbo.Calc_UFIR(ValorDevido, DataVencimento, '20070101', 2)
				ELSE ValorDevido END, 0) -
				(ISNULL((SELECT SUM(ISNULL(ValorPagoPrincipal,0)) FROM ComposicoesDebito 
					WHERE IdDebitoOrigemRen = Debitos.IdDebito
					AND NOT EXISTS(SELECT TOP 1 1 FROM Debitos D WHERE D.IdDebito = ComposicoesDebito.IdDebito
							AND D.IdSituacaoAtual = 9)),0))
				FROM Debitos WHERE IdDebito = @IdDebito   
		SELECT @result = Valor FROM @Total
		IF @result < 0 
			SET @Result = 0
		RETURN(@result)
	END