

CREATE PROCEDURE dbo.sp_RelatorioGerencial
@DataInicial datetime,
@DataFinal datetime,
@IdRelatorioGerencial int,
@IdsCCusto varchar(8000) = '',
@PE bit = 0,
@TCC bit = 0,
@TC bit = 0,
@IdsConta varchar(8000) = ''

AS 

SET NOCOUNT ON

CREATE TABLE #IdsC (IdConta int PRIMARY KEY)
CREATE TABLE #RelatorioGerencial (CodCentroCusto int, CentroCusto varchar(250) COLLATE database_default, CodItem int, GrupoConta varchar(250) COLLATE database_default, ValorOrcado money, ValorPago money, ValorEmpenhado money, Saldo money, lTotal bit)

DECLARE	@CodCCusto int, @IdCentroCusto int, @NomeCentroCusto varchar(250), @CodItem int, @IdGrupoContaPersonalizado int, 
		@GCNomePersonalizado varchar(250), @ValorOrcado money, @ValorRealizado money, @ValorEmpenhado money,
		@PreEmpenho bit, @TotalizarContas bit, @PrimeirodeJaneiro varchar(8), @TituloRelatorio varchar(250)

SET @PrimeirodeJaneiro = Cast(Year(@DataInicial) As varchar(4)) + '0101'

SELECT @TituloRelatorio = TituloRelatorioGerencial 
FROM RelatoriosGerenciais
WHERE IdRelatorioGerencial = @IdRelatorioGerencial

IF @IdRelatorioGerencial > 0
	SELECT @PreEmpenho = PreEmpenho, @TotalizarContas = TotalizarContas
	FROM RelatoriosGerenciais
	WHERE IdRelatorioGerencial = @IdRelatorioGerencial
ELSE
BEGIN
	SET @PreEmpenho = @PE
	SET @TotalizarContas = @TC
END

IF @IdsCCusto <> ''
	EXEC('
	DECLARE CentroCusto_Cursor CURSOR FAST_FORWARD FOR
	SELECT IdCentroCusto, NomeCentroCusto
	FROM CentroCustos
	WHERE Evento = 0
	AND IdCentroCusto IN (' + @IdsCCusto + ')
	ORDER BY CodigoCentroCusto')
ELSE
	EXEC('
	DECLARE CentroCusto_Cursor CURSOR FAST_FORWARD FOR
	SELECT IdCentroCusto, NomeCentroCusto
	FROM CentroCustos
	WHERE Evento = 0
	ORDER BY CodigoCentroCusto')

SET @CodCCusto = 1
OPEN CentroCusto_Cursor
FETCH NEXT FROM CentroCusto_Cursor
INTO @IdCentroCusto, @NomeCentroCusto
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @IdRelatorioGerencial > 0
		DECLARE GrupoContaPersonalizado_cursor CURSOR FAST_FORWARD FOR
		SELECT GrupoContaRelatorioGerencial.IdGrupoContaPersonalizado, NomePersonalizado
		FROM GrupoContaRelatorioGerencial
		LEFT JOIN GruposContasPersonalizados 
		ON GruposContasPersonalizados.IdGrupoContaPersonalizado = GrupoContaRelatorioGerencial.IdGrupoContaPersonalizado
		WHERE GrupoContaRelatorioGerencial.IdRelatorioGerencial = @IdRelatorioGerencial
		ORDER BY Ordem
	ELSE
		EXEC('
		DECLARE GrupoContaPersonalizado_cursor CURSOR FAST_FORWARD FOR
		SELECT IdGrupoContaPersonalizado, NomePersonalizado
		FROM GruposContasPersonalizados
		WHERE IdGrupoContaPersonalizado IN (' + @IdsConta + ') 
		ORDER BY Ordem')

	SET @CodItem = 1
	OPEN GrupoContaPersonalizado_cursor
	FETCH NEXT FROM GrupoContaPersonalizado_cursor
	INTO @IdGrupoContaPersonalizado, @GCNomePersonalizado
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DELETE FROM #IdsC
		INSERT INTO #IdsC
		SELECT IdConta From GruposContasPersonalizados
		WHERE NomePersonalizado = @GCNomePersonalizado

		SELECT @ValorOrcado = ISNULL(SUM(ValorDotacao), 0) 
		FROM DotacoesCentroCustoConta DCCC, #IdsC
		WHERE @IdCentroCusto = DCCC.IdCentroCusto
		AND #IdsC.IdConta = DCCC.IdConta
		AND DataDotacao >= @PrimeirodeJaneiro
		AND DataDotacao <= @DataFinal

		SELECT @ValorEmpenhado =  ISNULL(SUM(Valor), 0)
		FROM CentroCustosEmpenho CCE, Empenhos E, #IdsC
		WHERE E.IdEmpenho = CCE.IdEmpenho
		AND CCE.IdCentroCusto = @IdCentroCusto
		AND E.IdConta = #IdsC.IdConta
		AND DataEmpenho >= @DataInicial
		AND DataEmpenho <= @DataFinal
		
		IF @PreEmpenho = 1
			SELECT @ValorEmpenhado = @ValorEmpenhado + ISNULL(SUM(CCP.Valor), 0)
			FROM CentroCustosPreEmpenho CCP, PreEmpenhos PE, #IdsC
			WHERE PE.IdPreEmpenho = CCP.IdPreEmpenho
			AND CCP.IdCentroCusto = @IdCentroCusto
			AND PE.IdConta = #IdsC.IdConta
			AND DataPreEmpenho >= @PrimeirodeJaneiro
			AND DataPreEmpenho <= @DataFinal
			AND ValorPreEmpenho > 0
			AND IdEmpenho IS Null

		SELECT @ValorEmpenhado = @ValorEmpenhado - ISNULL(SUM(Valor), 0 )
		FROM CentroCustosAnulacao CCA, Anulacoes A, Empenhos E, #IdsC
		WHERE A.IdAnulacao = CCA.IdAnulacao
		AND E.IdEmpenho = A.IdEmpenho
		AND CCA.IdCentroCusto = @IdCentroCusto
		AND E.IdConta = #IdsC.IdConta
		AND DataAnulacao >= @DataInicial
		AND DataAnulacao <= @DataFinal

		SELECT @ValorRealizado = ISNULL(SUM(ValorEvento), 0)
		FROM CentroCustosPagamento CCP, Pagamentos P, Empenhos E, #IdsC
		WHERE P.IdPagamento = CCP.IdPagamento
		AND @IdCentroCusto = CCP.IdCentroCusto
		AND E.IdEmpenho = P.IdEmpenho
		AND #IdsC.IdConta = E.IdConta
		AND DataEvento >= @DataInicial
		AND DataEvento <= @DataFinal

		INSERT INTO #RelatorioGerencial VALUES(@CodCCusto, @NomeCentroCusto, @CodItem, @GCNomePersonalizado, @ValorOrcado, @ValorRealizado, @ValorEmpenhado - @ValorRealizado, @ValorOrcado - @ValorEmpenhado, 0)
		SET @CodItem = @CodItem + 1

		FETCH NEXT FROM GrupoContaPersonalizado_cursor
		INTO @IdGrupoContaPersonalizado, @GCNomePersonalizado
	END
	CLOSE GrupoContaPersonalizado_cursor
	DEALLOCATE GrupoContaPersonalizado_cursor
	IF @TotalizarContas = 1
		INSERT INTO #RelatorioGerencial 
		SELECT @CodCCusto, @NomeCentroCusto, @CodItem, 'Total', SUM(ValorOrcado), SUM(ValorPago), SUM(ValorEmpenhado), SUM(Saldo), 1
		FROM #RelatorioGerencial
		WHERE CentroCusto = @NomeCentroCusto

	SET @CodCCusto = @CodCCusto + 1

	FETCH NEXT FROM CentroCusto_Cursor
	INTO @IdCentroCusto, @NomeCentroCusto
END
CLOSE CentroCusto_Cursor
DEALLOCATE CentroCusto_Cursor

IF CHARINDEX(',', @IdsCCusto) > 0 
BEGIN
	
	IF (SELECT COUNT(*) FROM #RelatorioGerencial) > 0
	BEGIN
		INSERT INTO #RelatorioGerencial 
		SELECT @CodCCusto, 'Total dos Centros de Custo', CodItem, GrupoConta, SUM(ValorOrcado), SUM(ValorPago), SUM(ValorEmpenhado), SUM(Saldo), 1
		FROM #RelatorioGerencial
		GROUP BY CodItem, GrupoConta
	END
END

SELECT @TituloRelatorio TituloRelatorio, * FROM #RelatorioGerencial
ORDER BY CodCentroCusto, CodItem

DROP TABLE #IdsC
DROP TABLE #RelatorioGerencial




