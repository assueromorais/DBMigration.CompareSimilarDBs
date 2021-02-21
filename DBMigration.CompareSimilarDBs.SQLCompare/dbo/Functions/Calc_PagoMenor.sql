
/*DM42699*/
/*DM45596*/
/*DM71661*/
/*Alterada pelo Gustavo em 22/07/2011 - Ocorr. 79678*/

CREATE FUNCTION [dbo].[Calc_PagoMenor] (@IdDebito int, @bFisica bit)
	RETURNS decimal (15,2)
	AS
BEGIN

  DECLARE @ValorDevido Decimal(15,2), @IdMoeda int, @ValorPago Decimal(15,2), @DataVencimento Datetime, 
		  @DataPagamento DateTime, @ValorAtual Decimal(15,2), @IdTipoDebito int,@IdRenegociacao int,@IdRecobranca int, 
		  @ValorReal Decimal(15,2), @IdSituacaoAtual int
	
  SELECT @IdRenegociacao = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Renegociação'
  SELECT @IdRecobranca = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Recobrança'
 
  SELECT @ValorDevido = ValorDevido, @ValorPago = ValorPago, @IdMoeda = IdMoeda, @DataVencimento = DataVencimento, 
		 @IdTipoDebito = IdTipoDebito, @DataPagamento = DataPgto, @IdSituacaoAtual = IdSituacaoAtual
  FROM Debitos 
  WHERE IdDebito = @IdDebito

  IF @IdSituacaoAtual  IN (3,6,14,10,15)
  BEGIN
	SELECT @ValorReal = ISNULL(SUM(ISNULL(ValorEsperadoPrincipal, 0)),0) +
						/*DM42699*****************************************/
						ISNULL(SUM(ISNULL(ValorEsperadoDespBco, 0)),0) +
						ISNULL(SUM(ISNULL(ValorEsperadoDespAdv, 0)),0) +
						ISNULL(SUM(ISNULL(ValorEsperadoDespPostais, 0)),0)
						/*************************************************/
	FROM ComposicoesDebito 
	WHERE IdDebito = @IdDebito
    /*DM41732**********************************************************/
    IF @IdMoeda = 2
		SELECT  @ValorReal = dbo.Calc_Ufir(@ValorReal, @DataVencimento, @DataPagamento, 1)
	ELSE IF @IdMoeda = 3
		SELECT  @ValorReal = dbo.Calc_URH (@ValorReal, @DataPagamento, 1)

    /*****************************************************************/
	IF @ValorReal = 0
	BEGIN
	  IF @IdMoeda = 2
	     SELECT  @ValorReal = dbo.Calc_Ufir(@ValorDevido, @DataVencimento, @DataPagamento, @IdMoeda)
	  ELSE IF @IdMoeda = 3  /*Oc. 35316*/
	     SELECT  @ValorReal = dbo.Calc_URH (@ValorDevido, @DataPagamento, @IdMoeda)    /*Oc. 35316*/
	  ELSE
	    SET @ValorReal = @ValorDevido
	END
	
	SELECT @ValorAtual = ISNULL(SUM(ISNULL(ValorPagoPrincipal, 0)), 0)+
						/*DM42699*****************************************/
						ISNULL(SUM(ISNULL(ValorPagoDespBco, 0)), 0) +
						ISNULL(SUM(ISNULL(ValorPagoDespAdv, 0)), 0) +
						ISNULL(SUM(ISNULL(ValorPagoDespPostais, 0)), 0)
						/*************************************************/
	FROM ComposicoesDebito 
	WHERE IdDebito = @IdDebito

	IF ((@IdTipoDebito IN (2)) or (@IdTipoDebito = @IdRecobranca))/*30428*/
	BEGIN

	  /* italo oc.42066, Sergio 37595 */
 	  SELECT @ValorDevido = SUM(ISNULL(ValorEsperadoPrincipal, 0) + ISNULL(ValorEsperadoMulta, 0) + 
 								ISNULL(ValorEsperadoJuros, 0) + ISNULL(ValorEsperadoDespBco, 0) +
 								ISNULL(ValorEsperadoAtualizacao, 0) + 
 								ISNULL(ValorEsperadoDespAdv, 0) + ISNULL(ValorEsperadoDespPostais, 0))
 	  FROM ComposicoesDebito cd 
 	  WHERE cd.IdDebito = @IdDebito	

	  SET @ValorReal = @ValorDevido - @ValorPago /*DM41732*/
	END   
	ELSE
	BEGIN
	  IF @ValorAtual <> 0 AND 
	     @ValorPago <= CAST((SELECT SUM(ISNULL(ValorPagoPrincipal,0)+ISNULL(ValorPagoAtualizacao,0) + 
									ISNULL(ValorPagoMulta,0) + ISNULL(ValorPagoJuros,0) + 
									ISNULL(ValorPagoDespPostais,0) + ISNULL(ValorPagoDespAdv,0) + 
									ISNULL(ValorPagoDespBco,0))     
							  FROM ComposicoesDebito 
                             /*DM45596*****************************************/   
	                         WHERE IdDebito = @IdDebito) AS Decimal(15,2))
                             /*************************************************/
	    SET @ValorReal = @ValorReal - @ValorAtual    
	  ELSE    
	  BEGIN    
	    SELECT @ValorAtual = dbo.AtualizaDebitos(@DataVencimento, @DataPagamento, @ValorDevido, @bFisica,
												 @IdTipoDebito, @IdMoeda, 0, 0, 0, 0)    
	    IF (@ValorAtual = @ValorDevido) AND (@IdMoeda <> 1)    
	     SET @ValorAtual = @ValorReal    
	    
	    SET @ValorReal = @ValorReal - (@ValorReal * @ValorPago) / @ValorAtual     
	  END    
	END
  END    
  ELSE    
	SET @ValorReal = 0 
	RETURN  @ValorReal    
  END