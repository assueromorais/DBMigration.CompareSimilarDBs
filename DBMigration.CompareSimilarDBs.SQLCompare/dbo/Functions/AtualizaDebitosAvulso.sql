CREATE FUNCTION dbo.AtualizaDebitosAvulso (@DataVcto DateTime, @DataCalculo DateTime, @Valor float, @IdTipoDebito int, @DataFixa bit, @DataFixaVenc bit)
	RETURNS decimal(10,2)
	AS
	BEGIN

	  /* Esse não é igual ao índice existente na tabela, ele foi tirado de um Vetor na unit uContrantes.pas */
	  DECLARE @Indice int
	  SET @Indice = (SELECT TOP 1 IdIndice FROM AtualizacaoIndices WHERE IdTipoDebito = @IdTipoDebito)

	  DECLARE @ValorCalc Decimal(10,2)
	  SET @ValorCalc = @Valor;

	  DECLARE @Dataini DateTime
	  SET @DataIni = @DataVcto

	  DECLARE @DataFim DateTime
	  SET @DataFim = @DataCalculo

	  DECLARE @Atualizacao Decimal(10,2)
	  SET @Atualizacao = 
		CASE @Indice
		  WHEN 0 THEN dbo.Calc_SelicCapitalizada(@ValorCalc,@DataIni,@DataFim,@DataFixa,@DataFixaVenc)
		  WHEN 1 THEN dbo.Calc_INPC_Acumulado(@ValorCalc,@DataIni,@DataFim,@DataFixa, @DataFixaVenc, 0)
		  WHEN 2 THEN dbo.Calc_IPCA_IBGE(@ValorCalc,@DataIni,@DataFim,@DataFixa)
		  WHEN 3 THEN dbo.Calc_Poupanca(@ValorCalc,@DataIni,@DataFim,0)
		  ELSE        0
		END

	  RETURN(@Atualizacao)
	END