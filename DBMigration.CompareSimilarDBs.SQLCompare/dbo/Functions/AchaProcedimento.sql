CREATE FUNCTION [dbo].[AchaProcedimento] (@DataVcto datetime, @DataCalculo datetime, @PessoaFisica int, @IdTipoDebito int, @NumeroParcela int)
	RETURNS int
	AS
	BEGIN
	  DECLARE @IdProcedimento int, @IdRenegociacao int, @IdRecobranca int, @TpPessoa varCHAR(10)

	  DECLARE  @Aplicar int
	  SELECT @Aplicar = CASE @NumeroParcela WHEN 0 THEN 1 ELSE 2 END 

	  SELECT @IdRenegociacao = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Renegociação'
	  SELECT @IdRecobranca = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Recobrança'

	  IF @PessoaFisica = '1'
		SET @TpPessoa = '0,3,4,5'
	  IF @PessoaFisica = '0'
		SET @TpPessoa = '1,3,4,6'
	  IF @PessoaFisica = '2'
		SET @TpPessoa = '2,3,5,6'

	  SELECT @IdProcedimento = IdProcedimentoAtraso 
	  FROM ProcedimentosAtraso
	  WHERE Em_Uso = 1 AND CHARINDEX(CAST(TipoPessoa AS VARCHAR), @TpPessoa ) > 0 AND
			(PeriodoCalculoDe IS NULL OR @DataCalculo > PeriodoCalculoDe) AND
			(PeriodoCalculoAte IS NULL OR @DataCalculo < PeriodoCalculoAte) AND
			(ParaDebVencidoDe IS NULL OR @DataVcto > ParaDebVencidoDe) AND
			(ParaDebVencidoAte IS NULL OR @DataVcto < ParaDebVencidoAte) AND
			((TodosDebExcetoRen = 1 AND @IdTipoDebito <> @IdRenegociacao  AND @IdTipoDebito <> @IdRecobranca )
		OR      (IdProcedimentoAtraso IN (SELECT ProcAtraso_TiposDebito.IdProcedimentoAtraso
				  FROM ProcAtraso_TiposDebito
			  WHERE ProcAtraso_TiposDebito.IdTipoDebito = @IdTipoDebito)))
			  AND ((AplicaProcedimentoParcela = 0) OR AplicaProcedimentoParcela = @Aplicar)
	  RETURN(@IdProcedimento)
	END