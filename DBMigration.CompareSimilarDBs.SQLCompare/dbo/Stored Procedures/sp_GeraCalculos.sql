


























CREATE  PROCEDURE dbo.sp_GeraCalculos

@Valor Float,
@IdConfigProcedimento int,
@IdMoeda  int,
@DataVencimento datetime,
@DataCalculo datetime,
@Atualiza bit = 1,
@JurosMulta bit = 0,
@Total float OUTPUT


AS

SET NOCOUNT ON

DECLARE @IdProcedimento int, @ValorMulta float, @PercentMulta bit, @ValorJuros float, @PercentJuros bit, @ValorDia float, @PercentDia bit,
	    @TotalMulta float, @Multa float, @TotalJuros float, @Juros float, @TotalDia float, @Dia float, @TotalIndice float

SELECT @IdProcedimento = IdProcedimentoAtraso, @ValorMulta = ValorMultaAtraso, @PercentMulta = ValorMultaAtrasoPercent, @ValorJuros = ValorJurosMesAtraso,
	 @PercentJuros = ValorJurosMesAtrasoPercent, @ValorDia = ValorDiaAtraso, @PercentDia = ValorDiaAtrasoPercent
FROM ConfigProcedimentosAtraso 
WHERE IdConfigProcedimentoAtraso = @IdConfigProcedimento

/*IF @IdProcedimento = 2
BEGIN*/

	EXEC sp_CalculaEncargos @Valor, @ValorMulta, 'MULTA', @DataVencimento, @DataCalculo, @Atualiza, @IdMoeda, @PercentMulta, @Atualizacao = @Multa OUTPUT	
	SET  @TotalMulta = @Valor +  @Multa 

	IF @JurosMulta = 1
		SET @Total = @TotalMulta
	ELSE
   		SET @Total = @Valor		
	EXEC sp_CalculaEncargos @Total, @IdProcedimento, 'JUROS', @DataVencimento, @DataCalculo, @Atualiza, @IdMoeda, @PercentJuros, @Atualizacao = @Juros OUTPUT
	SET @TotalJuros = @Valor +  @Juros 

	IF @Atualiza = 1
		SET @Total = @Valor + @Multa + @Juros
	ELSE 
		SET @Total = @Valor - @Multa - @Juros
	/*SELECT @Total, @Multa, @Juros*/






















































