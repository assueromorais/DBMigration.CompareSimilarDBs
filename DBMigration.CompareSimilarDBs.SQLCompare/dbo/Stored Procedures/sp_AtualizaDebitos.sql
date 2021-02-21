


























CREATE PROCEDURE dbo.sp_AtualizaDebitos

@DataVcto DateTime,
@DataCalculo DateTime,
@ValorDevido float,
@PessoaFisica bit,
@IdTipoDebito int,
@IdMoeda int,
@IdProcedimento int = 0,
@lChamadaInterna int = 0,
@Total float OUTPUT

AS

SET NOCOUNT ON
DECLARE @NumSequencia int, @DataDe DateTime, @DataAte DateTime, @lValorFixo bit, @ValorFixo Decimal(5,2), 
	    @RotinaCalculo int, @PercentMultaJuros Decimal(5,2), @AplicarSeq varchar(20), @Valor Decimal(5,2), @dtBase DateTime, @dtReajuste DateTime,
	    @SubTotal Decimal(5,2), @Multa Decimal(5,2), @Juros Decimal(5,2), @Atualizacao Decimal(5,2), @SeqCalcDe int, @SeqCalcAte int, @Intervalo bit,
	    @Texto varchar(1000), @SubTexto varchar(1000), @TipoPessoa bit, @TipoDebito bit, @PodeParar bit, @ValorTotal Decimal(5,2),
	    @PercAtualiz Decimal(5,2), @PercMulta Decimal(5,2), @PercJuros Decimal(5,2), @DataFixa bit, @Cont int, @IdProcedimentoT int, @Em_Uso bit

IF @DataCalculo IS NULL 
	SET @DataCalculo = GETDATE()
CREATE TABLE #tmpSubTotais(NumSequencia int, Valor Decimal(5,2), Percentual Decimal(5,2), RotinaCalculo int)
CREATE TABLE #tmpErrosCalculo(Rotina int, DataInicio DateTime, DataCalculo DateTime, TipoErro int, DataErro DateTime)
IF @DataVcto  > @DataCalculo 
	SET @IdProcedimento = -1
IF @IdProcedimento = 0 
BEGIN		
	DECLARE Procedimentos_Cursor
	CURSOR FAST_FORWARD FOR
	SELECT IdProcedimentoAtraso, PeriodoCalculoDe, PeriodoCalculoAte, TipoPessoa, ParaDebVencidoDe, ParaDebVencidoAte, TodosDebExcetoRen, Em_Uso
	FROM ProcedimentosAtraso
	ORDER BY PeriodoCalculoDe, PeriodoCalculoAte
		OPEN Procedimentos_Cursor	
		FETCH NEXT FROM Procedimentos_Cursor
		INTO @IdProcedimento, @DataDe,  @DataAte, @TipoPessoa, @dtBase, @dtReajuste, @TipoDebito, @Em_Uso
		SET @Intervalo = 0
		WHILE @@FETCH_STATUS = 0  AND @Intervalo = 0
		BEGIN
			
			SET @Intervalo = 1
			
			IF @Em_Uso <>1
				SET @Intervalo = 0
			IF (@DataDe IS NOT NULL) AND (@DataCalculo < @DataDe) 
				SET @Intervalo = 0
			IF (@DataAte IS NOT NULL) AND (@DataCalculo > @DataAte)
				SET @Intervalo = 0
			IF (@DtBase IS NOT NULL) AND (@DataVcto < @DtBase)
				SET @Intervalo = 0
			IF (@DtReajuste IS NOT NULL) AND (@DataVcto > @DtReajuste)	
				SET @Intervalo = 0
			IF @PessoaFisica <> @TipoPessoa
				SET @Intervalo = 0
			IF @TipoDebito = 1 
			BEGIN
				IF @IdTipoDebito = 6 
					SET @Intervalo = 0
			END
			ELSE
				IF @IdTipoDebito NOT IN (SELECT TiposDebito.IdTipoDebito FROM TiposDebito JOIN ProcAtraso_TiposDebito ON ProcAtraso_TiposDebito.IdTipoDebito = TiposDebito.IdTipoDebito WHERE IdProcedimentoAtraso = @IdProcedimento)	
					SET @Intervalo = 0	
			IF @Intervalo = 1
				SET @IdProcedimentoT = @IdProcedimento

			FETCH NEXT FROM Procedimentos_Cursor
			INTO @IdProcedimento, @DataDe,  @DataAte, @TipoPessoa, @dtBase, @dtReajuste, @TipoDebito, @Em_Uso
		END
		CLOSE Procedimentos_Cursor
		DEALLOCATE Procedimentos_Cursor
		SET @IdProcedimento = @IdProcedimentoT
	END
DECLARE SequenciaCalculos_Cursor
CURSOR FAST_FORWARD FOR
SELECT NumSequenciaCalculo, AplicarSeqCalculoDe, AplicarSeqCalculoAte, AcrescentarValorFixo, ValorFixo, 
	 RotinaCalculo, PercentualMultaJuros, AplicarSobreSequencia, AplicarSeqCalcDe, AplicarSeqCalcAte
FROM SequenciasCalculos
WHERE IdProcedimentoAtraso = @IdProcedimento
ORDER BY NumSequenciaCalculo
	OPEN SequenciaCalculos_Cursor	
	FETCH NEXT FROM SequenciaCalculos_Cursor
	INTO @NumSequencia, @DataDe, @DataAte, @lValorFixo, @ValorFixo, @RotinaCalculo, @PercentMultaJuros, 
	          @AplicarSeq, @SeqCalcDe, @SeqCalcAte

	WHILE @@FETCH_STATUS = 0 
	BEGIN				
		IF @AplicarSeq = ''
  			SET @Valor = @ValorDevido
		ELSE
		BEGIN
			SET @Valor = 0
			SET @Cont = 1
			WHILE @Cont <= LEN(@AplicarSeq)
			BEGIN	
				SET @Valor = @Valor + (SELECT Valor FROM #tmpSubTotais WHERE NumSequencia IN (SUBSTRING(@AplicarSeq, @Cont, 1 )))	
				SET @Cont = @Cont + 1
			END
			SET @Valor = @Valor + @ValorDevido
		END		
		

		IF (@DataDe IS NULL) OR (@DataDe < @DataVcto) 
  			SET @dtBase = @DataVcto
		ELSE
			SET @dtBase = @DataDe
		
		IF (@DataAte IS NULL) OR (@DataAte >@DataCalculo) 
			SET @dtReajuste = @DataCalculo
		ELSE
			SET @dtReajuste = @DataAte
		
		SET @Intervalo =  1
		IF (@SeqCalcDe > 0) or (@SeqCalcAte > 0)
			IF (DATEDIFF(DAY, @DataVcto, @DataCalculo) >= @SeqCalcDe) AND (DATEDIFF(DAY, @DataVcto, @DataCalculo) <= @SeqCalcAte)
				SET @Intervalo = 0
		IF @DataAte IS NOT NULL		
			SET @DataFixa = 1
		ELSE
			SET @DataFixa = 0
		IF ((@DataAte IS NOT NULL) AND (@DataAte < @DataVcto)) OR ((@DataDe IS NOT NULL) AND (@DataDe > @DataCalculo)) OR (@Intervalo = 0)
		BEGIN
			SET @SubTotal   = 0
		END
		ELSE
		BEGIN
			IF @lChamadaInterna = 0 
			BEGIN
				DELETE FROM #tmpErrosCalculo
				INSERT INTO #tmpErrosCalculo
				EXEC sp_CalculaEncargos @Valor, @PercentMultaJuros, @ValorFixo, @RotinaCalculo, @dtBase, @dtReajuste, @IdMoeda, @DataFixa, @Total = @SubTotal OUTPUT
			END
			ELSE
				EXEC sp_CalculaEncargos @Valor, @PercentMultaJuros, @ValorFixo, @RotinaCalculo, @dtBase, @dtReajuste, @IdMoeda, @DataFixa, @lChamadaInterna, @Total = @SubTotal OUTPUT
			IF @SubTotal < 0 
				BREAK	
			IF @IdMoeda = 2 
			BEGIN
				SET @ValorDevido = @SubTotal
				SET @IdMoeda = 1
				SET @SubTotal = 0
			END
		END
		SET @PercentMultaJuros = @SubTotal / @Valor * 100
		IF @SubTotal IS NULL 
			SET @SubTotal = 0
		IF @PercentMultaJuros IS NULL 
			SET @PercentMultaJuros = 0 
		INSERT #tmpSubTotais VALUES (@NumSequencia, @SubTotal, @PercentMultaJuros,  @RotinaCalculo)		
		
		FETCH NEXT FROM SequenciaCalculos_Cursor
		INTO @NumSequencia, @DataDe, @DataAte, @lValorFixo, @ValorFixo, @RotinaCalculo, @PercentMultaJuros, 
		          @AplicarSeq, @SeqCalcDe, @SeqCalcAte
	END
	CLOSE SequenciaCalculos_Cursor
	DEALLOCATE SequenciaCalculos_Cursor
IF (@SubTotal < 0) AND (@lChamadaInterna = 0)
BEGIN
	SELECT * FROM #tmpErrosCalculo
END
ELSE
BEGIN
	SET @Multa = (SELECT ISNULL(SUM(Valor),0) FROM #tmpSubTotais WHERE RotinaCalculo = 1)
	SET @PercMulta = (SELECT ISNULL(SUM(Percentual),0) FROM #tmpSubTotais WHERE RotinaCalculo = 1)
	SET @Juros = (SELECT ISNULL(SUM(Valor),0) FROM #tmpSubTotais WHERE RotinaCalculo = 2)
	SET @PercJuros = (SELECT ISNULL(SUM(Percentual),0) FROM #tmpSubTotais WHERE RotinaCalculo = 2)
	SET @Atualizacao = (SELECT ISNULL(SUM(Valor),0) FROM #tmpSubTotais WHERE RotinaCalculo <> 1 AND RotinaCalculo <> 2) 
	SET @PercAtualiz = (SELECT ISNULL(SUM(Percentual),0) FROM #tmpSubTotais WHERE RotinaCalculo <> 1 AND RotinaCalculo <> 2) 

	SET @ValorTotal = (SELECT ISNULL(SUM (Valor),0) FROM #tmpSubTotais) + @ValorDevido
	SET @Total = @ValorTotal

	SELECT @Multa as Multa,
             		 @Juros as Juros,
             		 @Atualizacao as Atualizacao, 
               	 @ValorTotal as ValorTotal,
               	 @PercAtualiz As PercAtualiz, 
              	 @PercMulta as PercMulta, 
              	 @PercJuros as PercJuros, 
              	 @IdProcedimento   As IdProcedimento
END






















































