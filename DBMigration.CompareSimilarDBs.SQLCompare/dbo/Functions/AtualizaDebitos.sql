/*Oc nº 191655 - adicionado por LeandroS*/

CREATE FUNCTION [dbo].[AtualizaDebitos]
(
	@DataVcto      DATETIME,
	@DataCalculo   DATETIME,
	@ValorDevido   FLOAT,
	@PessoaFisica  INT,
	@IdTipoDebito  INT,
	@IdMoeda       INT,
	@Procedimento  INT = 0,
	@Retorno       INT = 0,
	@IdDebito      INT = 0,
	@IdSituacao    INT = 0
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
	/* Declaração das variáveis */
	DECLARE @SubTotais TABLE (
	            NumSequencia INT,
	            RotinaCalculo INT,
	            Valor DECIMAL(10, 2),
	            CodIndice INT,
	            IdSubTotal INT IDENTITY
	        )
	
	DECLARE @NumSeq INT,
	        @DataIni DATETIME,
	        @DataFim DATETIME,
	        @IncValorFixo BIT,
	        @ValorFixo FLOAT,
	        @RotinaCalculo INT,
	        @PercMultaJuros FLOAT,
	        @AplicarSeq VARCHAR(5),
	        @DiaIni INT,
	        @DiaFim INT,
	        @ValorCalc FLOAT,
	        @DataFixa BIT,
	        @Inc INT,
	        @TotalSeq INT,
	        @CodErro INT,
	        @IdSubTotal INT,
	        @IdProcedimento INT,
	        @DataFixaVenc BIT,
	        @AplicarSobreCalcSeq INT/*DM13871*/,
	        @AplicaPercentual BIT,
	        @NumeroParcela INT,
            @NumSeqC INT,
	        @DataIniC DATETIME,
	        @DataFimC DATETIME,
	        @IncValorFixoC BIT,
	        @ValorFixoC FLOAT,
	        @RotinaCalculoC INT,
	        @PercMultaJurosC FLOAT,
	        @AplicarSeqC VARCHAR(5),
	        @DiaIniC INT,
	        @DiaFimC INT,
	        @ValorCalcC FLOAT,
	        @DataFixaC BIT,
	        @TotalSeqC INT,
	        @IdSubTotalC INT,
	        @IdProcedimentoC INT,
	        @DataFixaVencC BIT,
	        @AplicarSobreCalcSeqC INT, 
            @DataVctoIni DATETIME,
	        @DataVctoFim DATETIME, 
            @ProxDiaUtil    DATETIME,
	        @DiaCotaUnica   VARCHAR(2),
	        @MesCotaUnica   VARCHAR(2),
	        @DataCotaUnica  DATETIME
	
	/* Validação*/
	
	/* Testa se a data de vencimento cai num feriado ou fim de semana */
	IF DATEDIFF(DAY, @DataVcto, @DataCalculo) > 0
	BEGIN
	    SET @ProxDiaUtil = dbo.AdicionaDias(CONVERT(VARCHAR, @DataVcto, 112))
	    
	    IF DATEDIFF(DAY, @DataVcto, CONVERT(DATETIME, @ProxDiaUtil, 111)) > 0
	    BEGIN
	        IF DATEDIFF(DAY, @DataCalculo, CONVERT(DATETIME, @ProxDiaUtil, 111)) 
	           >= 0
	            SET @DataCalculo = @DataVcto
	    END
	END
	
	SELECT @NumeroParcela = d.NumeroParcela
	FROM   Debitos d
	WHERE  d.IdDebito = @IdDebito
	
	/* Usar GetDate (ou similar) para @DataCalculo ANTES de chamar a função */
	SET @CodErro = 0
	
	IF @ValorDevido IS NULL
	   OR @ValorDevido <= 0
	    SET @CodErro = -100
	
	/*Acha o procedimento caso não informado*/
	SET @IdProcedimento = @Procedimento
	
	IF @IdProcedimento = 0
	    SET @IdProcedimento = dbo.AchaProcedimento(
	            @DataVcto,
	            @DataCalculo,
	            @PessoaFisica,
	            @IdTipoDebito,
	            @NumeroParcela
	        )
	ELSE
	    SET @IdProcedimento = (
	            SELECT TOP 1 IdProcedimentoAtraso
	            FROM   SequenciasCalculos
	            WHERE  IdProcedimentoAtraso = @IdProcedimento
	        )
	
	/*Guardara os subtotais*/
	IF @IdProcedimento IS NULL
	    SET @CodErro = -101
	
	/* Oc. 49027*/
	IF @IdDebito > 0
	    SET @DataVcto = dbo.GetDataVencimento(@IdTipoDebito, @DataVcto, @DataCalculo, @IdProcedimento, 1)					
	
	IF @DataVcto >= @DataCalculo
	    SET @CodErro = -99
	
	SET @Inc = 1
	SET @NumSeq = 0
	SET @TotalSeq = (
	        SELECT COUNT(*)
	        FROM   SequenciasCalculos
	        WHERE  IdProcedimentoAtraso = @IdProcedimento
	    )
	
	IF @IdSituacao IN ( 3 , 15 )
	BEGIN
	    SELECT @ValorDevido = dbo.Calc_PagoMenor(@IdDebito, @PessoaFisica)		
	    SET @IdMoeda = 1
	END
	ELSE
	IF @IdMoeda <> 1
	BEGIN
	    IF @IdMoeda = 2
	        SET @ValorDevido = (
	                SELECT dbo.Calc_Ufir(@ValorDevido, @DataVcto, @DataCalculo, 2)
	            )
	    
	    IF @IdMoeda = 3
	        SET @ValorDevido = (
	                SELECT dbo.Calc_URH(@ValorDevido, @DataCalculo, 3)
	            )
	    
	    SET @IdMoeda = 1
	END
	
	IF @CodErro = 0
	    WHILE @Inc <= @TotalSeq
	    BEGIN
	        SELECT TOP 1 @NumSeq = NumSequenciaCalculo,
	               @DataIni = AplicarSeqCalculoDe,
	               @DataFim = AplicarSeqCalculoAte,
	               @IncValorFixo = AcrescentarValorFixo,
	               @ValorFixo = ValorFixo,
	               @RotinaCalculo = RotinaCalculo,
	               @PercMultaJuros = PercentualMultaJuros,
	               @AplicarSeq = AplicarSobreSequencia,
	               @DiaIni = AplicarSeqCalcDe,
	               @DiaFim = AplicarSeqCalcAte,
	               @DataVctoIni = AplicarSeqCalcVctoDe,
	               @DataVctoFim = AplicarSeqCalcVctoAte,
	               @AplicarSobreCalcSeq = AplicarSobreCalculoSequencia /*DM13871*/,
	               @AplicaPercentual = AplicaPercentual
	        FROM   SequenciasCalculos
	        WHERE  IdProcedimentoAtraso = @IdProcedimento
	               AND NumSequenciaCalculo > @NumSeq
	        ORDER BY
	               NumSequenciaCalculo
	        
	        IF @AplicarSeq IS NULL
	            SET @ValorCalc = @ValorDevido
	        ELSE
	        BEGIN
	            SET @ValorCalc = 0
	            
	            WHILE LEN(@AplicarSeq) > 0
	            BEGIN
	                SET @ValorCalc = @ValorCalc + ISNULL(
	                        (
	                            SELECT Valor
	                            FROM   @SubTotais
	                            WHERE  NumSequencia = LEFT(@AplicarSeq, 1)
	                        ),
	                        0
	                    )
	                
	                SET @AplicarSeq = RIGHT(@AplicarSeq, LEN(@AplicarSeq) -1)
	            END
	            SET @ValorCalc = @ValorCalc + @ValorDevido
	        END
	        
	        IF @DataFim IS NOT NULL
	            SET @DataFixa = 1
	        ELSE
	            SET @DataFixa = 0
	        
	        IF @DataIni IS NOT NULL
	            IF @DataVcto > @DataIni
	                SET @DataFixaVenc = 0
	            ELSE
	                SET @DataFixaVenc = 1
	        ELSE
	            SET @DataFixaVenc = 0
	        
	        IF (@DataIni IS NULL)
	           OR (@DataIni < @DataVcto)
	            SET @DataIni = @DataVcto
	        
	        IF (@DataFim IS NULL)
	           OR (@DataFim > @DataCalculo)
	            SET @DataFim = @DataCalculo
	        
	        IF (
	               @DiaIni IS NULL
	               OR DATEDIFF(DAY, @DataVcto, @DataCalculo) >= @DiaIni
	           )
	           AND /*DM13871 o sinal estava menor*//*DM38763*/
	               (
	                   @DiaFim IS NULL
	                   OR DATEDIFF(DAY, @DataVcto, @DataCalculo) <= @DiaFim
	               )
	           AND /*DM13871 o sinal estava maior*//*DM38763*/
	               (@DataFim >= @DataVcto)
	           AND (@DataIni <= @DataCalculo)
	           AND (@DataVctoIni IS NULL OR @DataVcto >= @DataVctoIni)
	           AND (@DataVctoFim IS NULL OR @DataVcto <= @DataVctoFim)
	        BEGIN
	            /*DM13871******************************************************************************************************/  
	            IF @AplicarSobreCalcSeq > 0
	            BEGIN
	                SELECT TOP 1 @NumSeqC = NumSequenciaCalculo,
	                       @DataIniC = AplicarSeqCalculoDe,
	                       @DataFimC = AplicarSeqCalculoAte,
	                       @IncValorFixoC = AcrescentarValorFixo,
	                       @ValorFixoC = ValorFixo,
	                       @RotinaCalculoC = RotinaCalculo,
	                       @PercMultaJurosC = PercentualMultaJuros,
	                       @AplicarSeqC = AplicarSobreSequencia,
	                       @DiaIniC = AplicarSeqCalcDe,
	                       @DiaFimC = AplicarSeqCalcAte,
	                       @AplicarSobreCalcSeqC = AplicarSobreCalculoSequencia
	                FROM   SequenciasCalculos
	                WHERE  IdProcedimentoAtraso = @IdProcedimento
	                       AND NumSequenciaCalculo = @AplicarSobreCalcSeq
	                ORDER BY
	                       NumSequenciaCalculo  
	                
	                SET @ValorCalcC = @ValorDevido  
	                IF ((@DiaFimC IS NOT NULL) AND (@DiaFimC > 0))
	                BEGIN
	                    INSERT INTO @SubTotais
	                    SELECT @NumSeqC,
	                           @RotinaCalculoC,
	                           CASE @RotinaCalculoC
	                                WHEN 1 THEN dbo.Calc_Multa(@ValorCalcC, @PercMultaJurosC)
	                                ELSE 0
	                           END,
	                           @RotinaCalculoC   
	                    
	                    SET @DataIni = @DataIni + @DiaFimC
	                END
	            END 
/*Oc.130059_INI_********************************************************************************************************************/ 	            
	            IF (
	                   SELECT @RotinaCalculo
	               ) = 7 /*Calc_INPC - Se não existir o mês/ano informado na data atualização, é passado como parâmetro o mês anterior */
	            BEGIN
	                DECLARE @SequenciaAno TABLE (Ano INT, Mes INT)
	                
	                DECLARE @AnoIni  INT,
	                        @MesIni  INT,
	                        @AnoFim  INT,
	                        @MesFim  INT,
	                        @QtdMes  INT 
	                
	                SELECT @AnoIni = YEAR(MIN(DATA)),
	                       @MesIni = MONTH(MIN(DATA))
	                FROM   Indices
	                WHERE  IdIndice = 4	
	                
	                SELECT @AnoFim = YEAR(GETDATE()),
	                       @MesFim = MONTH(GETDATE()) -1   
	                
	                SET @QtdMes = 12  
	                
	                WHILE @AnoIni <= @AnoFim
	                BEGIN
	                    IF @AnoIni = @AnoFim
	                        SET @QtdMes = @MesFim 
	                    
	                    WHILE @MesIni <= @QtdMes
	                    BEGIN
	                        INSERT INTO @SequenciaAno
	                          (
	                            Ano,
	                            Mes
	                          )
	                        SELECT @AnoIni,
	                               @MesIni
	                        
	                        SET @MesIni = @MesIni + 1
	                    END
	                    SET @MesIni = 1	
	                    SET @AnoIni = @AnoIni + 1
	                END
	                
	                IF (
	                       SELECT COUNT(*)
	                       FROM   @SequenciaAno T
	                              LEFT JOIN (
	                                       SELECT ID.[Data],
	                                              Ano = YEAR(ID.[Data]),
	                                              Mes = MONTH(ID.[Data])
	                                       FROM   Indices ID
	                                       WHERE  ID.IdIndice = 4
	                                   ) X
	                                   ON  X.Ano = T.Ano
	                                   AND X.Mes = T.Mes
	                       WHERE  X.Mes IS NULL
	                              AND X.Ano IS NULL
	                   ) = 1
	                BEGIN
	                    IF NOT EXISTS (
	                           SELECT DATA
	                           FROM   Indices
	                                  INNER JOIN (
	                                           SELECT Mes = MONTH(@DataFim),
	                                                  Ano = YEAR(@DataFim)
	                                       ) X
	                                       ON  X.Ano = YEAR(Indices.[Data])
	                                       AND X.Mes = MONTH(Indices.[Data])
	                           WHERE  IdIndice = 4
	                       )
	                        SELECT @DataFim = DATEADD(MONTH, -1, @DataFim)
	                END
	            END
/*Oc.130059_FIM_********************************************************************************************************************/ 	            
	            INSERT INTO @SubTotais
	            SELECT @NumSeq,
	                   @RotinaCalculo,
	                   CASE @RotinaCalculo
	                        WHEN 1 THEN dbo.Calc_Multa(@ValorCalc, @PercMultaJuros)
	                        WHEN 2 THEN dbo.Calc_Juros(@ValorCalc, @PercMultaJuros, @DataIni, @DataFim)
	                        WHEN 3 THEN dbo.Calc_Ufir(@ValorCalc, @DataIni, @DataFim, @IdMoeda)
	                        WHEN 4 THEN dbo.Calc_SelicAcumulada(@ValorCalc, @DataIni, @DataFim, @DataFixa, @DataFixaVenc)
	                        WHEN 5 THEN dbo.Calc_SelicCapitalizada(@ValorCalc, @DataIni, @DataFim, @DataFixa, @DataFixaVenc)
	                        WHEN 6 THEN dbo.Calc_ICV(@ValorCalc, @DataIni, @DataFim, @DataFixa)
	                        WHEN 7 THEN dbo.Calc_INPC(@ValorCalc, @DataIni, @DataFim, @DataFixa)
	                        WHEN 8 THEN dbo.Calc_IPCA_IBGE(@ValorCalc, @DataIni, @DataFim, @DataFixa)
	                        WHEN 9 THEN dbo.Calc_Poupanca(@ValorCalc, @DataIni, @DataFim, @DataFixa)
	                        WHEN 10 THEN dbo.Calc_JurosDiarios(@ValorCalc, @PercMultaJuros, @DataIni, @DataFim)
	                        WHEN 11 THEN dbo.Calc_INPC_Acumulado(
	                                 @ValorCalc,
	                                 @DataIni,
	                                 @DataFim,
	                                 @DataFixa,
	                                 @DataFixaVenc,
	                                 @AplicaPercentual
	                             )
	                        WHEN 13 THEN dbo.Calc_IGPM(@ValorCalc, @DataIni, @DataFim, @DataFixa)
	                        WHEN 14 THEN dbo.Calc_JurosCompostos(@ValorCalc, @PercMultaJuros, @DataIni, @DataFim)
	                        WHEN 15 THEN dbo.Calc_MultaDiaria(@ValorCalc, @PercMultaJuros, @DataIni, @DataFim)/*DM13871-Criada a função MultaDiaria*/
	                        WHEN 16 THEN dbo.Calc_URH(@ValorCalc, @DataFim, @IdMoeda)
	                        ELSE 0
	                   END,
	                   CASE @RotinaCalculo
	                        WHEN 3 THEN 2
	                        WHEN 4 THEN 1
	                        WHEN 5 THEN 1
	                        WHEN 6 THEN 3
	                        WHEN 7 THEN 4
	                        WHEN 8 THEN 6
	                        WHEN 9 THEN 5
	                        WHEN 11 THEN 4
	                        WHEN 13 THEN 13
	                        WHEN 15 THEN 1 /*DM13871-Criada a funçao MultaDiária*/
	                        WHEN 16 THEN 7
	                        ELSE 0
	                   END
	            
	            SELECT @IdSubTotal = MAX(IdSubtotal)
	            FROM   @SubTotais
	            
	            UPDATE @SubTotais
	            SET    Valor = 0
	            WHERE  Valor < 0
	                   AND Valor <> -100000
	                   AND IdSubTotal = @IdSubTotal /*Oc 65632*/
	            
	            SELECT @CodErro = CodIndice * (-1)
	            FROM   @SubTotais
	            WHERE  Valor = -100000
	                   AND IdSubTotal = @IdSubtotal
	            
	            IF @CodErro < 0
	                BREAK
	            ELSE
	                UPDATE @SubTotais
	                SET    Valor = Valor + ISNULL(CASE @IncValorFixo WHEN 1 THEN @ValorFixo ELSE 0 END, 0)
	                WHERE  IdSubTotal = @IdSubtotal
	            
	            IF @IdMoeda <> 1
	            BEGIN
	                SELECT TOP 1 @ValorDevido = Valor
	                FROM   @Subtotais
	                
	                SET @IdMoeda = 1
	                DELETE 
	                FROM   @Subtotais
	            END
	        END
	        
	        SET @Inc = @Inc + 1
	    END
	
	DECLARE @Multa        FLOAT,
	        @Juros        FLOAT,
	        @Atualizacao  FLOAT,
	        @ValorTotal   FLOAT,
	        @Result       DECIMAL(10, 2)
	
	SET @ValorTotal = @ValorDevido
	
	IF @CodErro = 0
	BEGIN
	    SELECT @Multa = ISNULL(SUM(Valor), 0)
	    FROM   @Subtotais
	    WHERE  RotinaCalculo IN (1, 15) /*DM13871- inserido o 15-MultaDiária*/
	    SELECT @Juros = ISNULL(SUM(Valor), 0)
	    FROM   @Subtotais
	    WHERE  RotinaCalculo IN (2, 10, 14)/*DM38763*/
	    SELECT @Atualizacao = ISNULL(SUM(Valor), 0)
	    FROM   @Subtotais
	    WHERE  RotinaCalculo NOT IN (1, 2, 10, 14, 15)/*DM13871- inserido o 15-MultaDiária*//*DM38763*/
	    SELECT @ValorTotal = @ValorDevido + ISNULL(SUM(Valor), 0)
	    FROM   @SubTotais
	END
	ELSE 
	IF @CodErro = -99
	BEGIN
	    SET @Multa = 0
	    SET @Juros = 0
	    SET @Atualizacao = 0
	END
	
	/*
	Se o valor for menor que zero, retornamos 0
	*/
	IF (ISNULL(@ValorTotal, 0) < 0)
	    SET @ValorTotal = 0
	
	IF (ISNULL(@Multa, 0) < 0)
	    SET @Multa = 0
	
	IF (ISNULL(@Juros, 0) < 0)
	    SET @Juros = 0
	
	IF (ISNULL(@Atualizacao, 0) < 0)
	    SET @Atualizacao = 0

	SELECT @Result = CASE @Retorno
	                      WHEN 0 THEN @ValorTotal
	                      WHEN 1 THEN @Multa
	                      WHEN 2 THEN @Juros
	                      WHEN 3 THEN @Atualizacao
	                      ELSE @CodErro
	                 END
	
	IF (ISNULL(@Result, 0) < 0)
	   AND (@Retorno < 4)
	    /*51195*/
	    SET @Result = 0
	
	IF (@Result = -99)
	    SET @Result = 0 
	
	RETURN(@result)
END
