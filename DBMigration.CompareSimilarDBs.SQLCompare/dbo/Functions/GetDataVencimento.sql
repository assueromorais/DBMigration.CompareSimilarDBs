/*Oc. 105482 - Nao teve alteracoes, somente para nao dar erro CRPSP*/

CREATE FUNCTION  [dbo].[GetDataVencimento] (@IdTipoDebito INT, @DataVencimento DATETIME, @DataCalculo DATETIME, @IdProcedimentoAtraso INT, @ParaCalculoDeEncargos BIT)
RETURNS DATETIME
AS
BEGIN
	DECLARE @AnoVencimento		VARCHAR(4),
	        @DataRetorno		DATETIME,
	        @DataVencAnu		VARCHAR(4),
	        @DiaVencAnu			VARCHAR(2),
	        @MesVencAnu			VARCHAR(2),
	        @ProximoDiaUtil     DATETIME
	        	        
	SET @AnoVencimento = CAST(YEAR(@DataVencimento) AS VARCHAR)	

	IF (@ParaCalculoDeEncargos = 1) 
	BEGIN		
		SELECT	@DataVencAnu = ISNULL(pa.DataVencimentoAnuidade,'')
		FROM	ProcedimentosAtraso pa
		WHERE	pa.IdProcedimentoAtraso = @IdProcedimentoAtraso
	END
	ELSE
	BEGIN
		SELECT	@DataVencAnu = ISNULL(ps.DtVencAnuConsiderarInadimpl,'')
		FROM	ParametrosSiscafw ps
	END

	IF (@DataVencAnu <> '') AND @IdTipoDebito = 1 
	BEGIN
		/* Separa dia e mês. */
		SET @DiaVencAnu = SUBSTRING(@DataVencAnu, 1, 2)	
		SET	@MesVencAnu = SUBSTRING(@DataVencAnu, 3, 2)
		 		  
		/* Verifica se a data escolhida foi dia 29 de fevereiro*/
		IF @MesVencAnu = '02' AND @DiaVencAnu = '29'
		BEGIN
			/* Verifica se existe dia 29 no ano de vencimento do débito */
			IF ISDATE(@AnoVencimento + '-' + @MesVencAnu + '-' + @DiaVencAnu ) = 0
				/* Se não existe dia 29 então a data definida é dia 28 de fevereiro. */
				SELECT  @DataRetorno = CAST(@AnoVencimento + '-' + @MesVencAnu + '-28' AS DATETIME)  
			ELSE
				/* Se existe então a data fica sendo o dia 29 de fevereiro. */
				SELECT  @DataRetorno = CAST(@AnoVencimento + '-' + @MesVencAnu + '-' + @DiaVencAnu AS DATETIME)	  
		END
		ELSE
		BEGIN
			/* Se for outra data qualquer então pega o dia e o mês informado e junta com o Ano do vencimento do débito. */
			SELECT  @DataRetorno = CAST(@AnoVencimento + '-' + @MesVencAnu + '-' + @DiaVencAnu AS DATETIME)
		END
		
		/* Se a data calculada para o retorno ficou menor que a data do próprio vencimento, então retorna ela mesma. */
		IF @DataRetorno < @DataVencimento 
			SET @DataRetorno = @DataVencimento
	END
	ELSE
		/* Se não estiver definido a data de vencimento da anuidade então 
		* a data de vencimento é a do próprio débito. */
		SET @DataRetorno = @DataVencimento
	
	/* OC 77841 */
	SET @ProximoDiaUtil =  dbo.Calc_DataUtil(@DataRetorno)/*DM69079*/ 		
	
	/* OC 77841 */
	IF @DataCalculo <= @ProximoDiaUtil 
		SET @DataRetorno = @ProximoDiaUtil	
	
	RETURN @DataRetorno
END


