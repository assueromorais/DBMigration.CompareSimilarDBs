/*Oc. 96534 - Gustavo*/

CREATE PROCEDURE [dbo].[sp_ComposicaoDebito]  
		@IdProfissional int,@NumConjRen int,@DataCalculo datetime,@lFisica int,@lRenegociacao bit,@IdDebito int,  
		@lEmissao bit = 0,@IdSituacaoDefault int = 0,@DescontoMulta Decimal(10,2) = 0,@DescontoJuros Decimal(10,2)=0 ,
		@DescontoAtualizacao Decimal(10,2) = 0, @bAvulso bit = 0, @DescontoPrincipal DECIMAL(10, 2) = 0, @IdProcedimento INT = 0
AS
	

DECLARE @teste bit
DECLARE @MensagemErro VARCHAR(200) = 'Erro ao gerar a composição.'+CHAR(10)+'Favor tentar novamente. Caso o erro persista,'+CHAR(10)+'entre em contato com o Suporte Implanta.'
/*
DECLARE
			@IdProfissional int,@NumConjRen int,@DataCalculo datetime,@lFisica int,@lRenegociacao bit,@IdDebito int,  
		@lEmissao bit ,@IdSituacaoDefault int ,@DescontoMulta Decimal(10,2) ,@DescontoJuros Decimal(10,2) ,
		@DescontoAtualizacao Decimal(10,2), @bAvulso bit 
		
SELECT @IdProfissional = 24429,
       @NumConjRen = 0,
       @DataCalculo = '20080424',
       @lFisica = 1,
       @lRenegociacao =0,
       @IdDebito = 35747,
       @lEmissao = 0,
       @IdSituacaoDefault =1,
       @DescontoMulta =0,
       @DescontoJuros =0,
       @DescontoAtualizacao =0,
       @bAvulso = 0		

*/
SELECT @teste = 0


BEGIN TRY	  
SET NOCOUNT ON 

DECLARE @IdDebitoOrig            INT,
        @IdDebitoDest            INT,
        @ValorParc               DECIMAL(10, 2),
        @IdMoedaOrig             INT,
        @DataVcto                DATETIME,
        @Saldo                   DECIMAL(10, 2),
        @SaldoAtual              DECIMAL(10, 2),
        @Multa                   DECIMAL(10, 2),
        @Juros                   DECIMAL(10, 2),
        @Atualizacao             DECIMAL(10, 2),
        @IdTpDebito              INT,
        @TotalAtual              DECIMAL(10, 2),
        @Principal               DECIMAL(10, 2),
        @IdDebCotaUnica          INT,
        @PercentAcresc           DECIMAL(10, 2),
        @IndAcresc               FLOAT,
        @IdRenegociacao          INT,
        @IdRecobranca            INT,
        @Registros               INT,
        @CodErro                 INT,
        @Diferenca               DECIMAL(10, 2),
        @ParcUnica               BIT,
        @IdSituacao              INT,
        @tmpSQL                  VARCHAR(8000),
        @Acrescimos              DECIMAL(10, 2),
        @TotalDesconto           DECIMAL(10, 2),
        @TotalParc               DECIMAL(10, 2),
        @Total                   DECIMAL(10, 2),
        @ContParc                INT,
        @DescontoCotaUnica       DECIMAL(10, 2),
        @bExistCotaUnica         INT,
        @idDebitoParcela         INT,
        @ValPrincipal            DECIMAL(10, 2),
        @NumeroParcela           INT,
        @ValorDevido             DECIMAL(10, 2),
        @ValResto                DECIMAL(10, 2),
        @Acre                    DECIMAL(10, 2),
        @IdTblOrigem             INT,
        @ValSobra                DECIMAL(10, 2),
        @ValMontante             DECIMAL(10, 2),
        @MultaMontante           DECIMAL(10, 2),
        @JurosMontante           DECIMAL(10, 2),
        @AtualizacaoMontante     DECIMAL(10, 2),
        @NumPercent              FLOAT,
        @Valvula                 INT,
        @TotalEncargos           DECIMAL(10, 2),
        @ContOrigem              INT,
        @executar                BIT,
        @ValorDescontoPrincipal  DECIMAL(10, 2),
        @ValorDescontoPrincipalPorParcela DECIMAL(10, 2),
        @ID                      INT
    	
DECLARE @tmpAtu DECIMAL(10,2), @tmpMul  DECIMAL(10,2), @tmpJur  DECIMAL(10,2)    	        

SET @PercentAcresc = 0  
SET @IndAcresc = 1  
SET @Saldo = 0  
SET @Registros = 0  
SET @Diferenca = 0  
SET @SaldoAtual = 0  
SET @ParcUnica = 0  
SET @IdDebCotaUnica = 0  
SELECT @executar = 0

CREATE TABLE #tblComposicao (Id int IDENTITY(1,1),IdDebito int,IdDebitoOrigemRen int,ValorEsperadoPrincipal Decimal(10,2), 
			 ValorEsperadoMulta Decimal(10,2),ValorEsperadoJuros Decimal(10,2), ValorEsperadoAtualizacao Decimal(10,2), 
			 IdMoedaValorEsperado int , RegistraLog int, IdProcedimentoAtraso int,valorTotal Decimal(10,2),IdParcela INT,
			 ValorAcrescimo DECIMAL(10,2), ValorDescontoPrincipal DECIMAL(10,2))
CREATE TABLE #tblDebOrigem (Id int IDENTITY(1,1), IdDebito int, Idmoeda int, ValorDevido Decimal(10,2),
			 DataVencimento datetime, IdTipoDebito int,SituacaoAtual int,ValorPago money, TotalOrigem Decimal(10,2), 
			 Multa Decimal(10,2) , Juros Decimal(10,2), Atualizacao Decimal(10,2), TotalAtual Decimal(10,2),CodErro int,
			 IdProcedimento int,Baixa BIT, ValorDescontoPrincipal DECIMAL(10,2), ValorDevidoOriginal DECIMAL(10,2))
CREATE TABLE #tblValorParc (Id int IDENTITY(1,1), IdDebito int, ValorDevido money, NumeroParcela int, Acre money,
			 Desconto money,BaixaAcre bit )

/* Em qual coluna será acrescentado o acréscimo cumulativo por parcela  
@RotinaAcrescimo 1 = Atualizacao  2 = Juros  3 = Multa  4 = Principal  */  

SELECT @IdRenegociacao = IdTipoDebito FROM   TiposDebito WHERE  NomeDebito = 'Renegociação'  
SELECT @IdRecobranca = IdTipoDebito FROM   TiposDebito WHERE  NomeDebito = 'Recobrança'  

/*Pessoa Física*/
IF @lFisica = 1 
   SET @ParcUnica = ISNULL((SELECT 1 WHERE EXISTS 
						   (SELECT TOP 1 1 
                            FROM Debitos 
                            WHERE IdProfissional = @IdProfissional AND NumConjReneg = @NumConjRen AND NumeroParcela > 0 
								  AND(IdTipoDebito = @IdRenegociacao OR  IdTipoDebito = @IdRecobranca))), 0)  
/*Pessoa Jurídica*/
IF @lFisica = 0 
   SET @ParcUnica = ISNULL((SELECT 1 WHERE  EXISTS 
						   (SELECT TOP 1 1
                            FROM Debitos
                            WHERE IdPessoaJuridica = @IdProfissional AND NumConjReneg = @NumConjRen AND NumeroParcela > 0
                                  AND  (IdTipoDebito = @IdRenegociacao OR  IdTipoDebito = @IdRecobranca))), 0)  
/*Pessoa*/
IF @lFisica = 2 
   SET @ParcUnica = ISNULL((SELECT 1 WHERE  EXISTS 
							(SELECT TOP 1 1
                             FROM Debitos
                             WHERE IdPessoa = @IdProfissional AND  NumConjReneg = @NumConjRen  AND  NumeroParcela > 0
                                   AND  (IdTipoDebito = @IdRenegociacao OR  IdTipoDebito = @IdRecobranca))), 0)   

/*Oc. 40545--Trata a Renegociação*********************************************************************************/
--RAISERROR (@MensagemErro,12,1)
IF @lRenegociacao = 1
BEGIN 
    SET @IdDebito = 0  
	
	/*Pessoa Física*/    
    IF @lFisica = 1
    BEGIN
		INSERT INTO #tblDebOrigem (IdDebito,Idmoeda,ValorDevido,DataVencimento,IdTipoDebito,SituacaoAtual,ValorPago , 
								   TotalOrigem ,Multa,Juros,Atualizacao,TotalAtual,CodErro,IdProcedimento,Baixa)
        SELECT IdDebito,IdMoeda,
               ValorDevido = CASE WHEN ValorPago > 0 THEN dbo.Calc_PagoMenor(IdDebito, 1)
                             ELSE CASE WHEN IdMoeda = 1 THEN ValorDevido
                                       WHEN IdMoeda = 2 THEN (dbo.Calc_Ufir(ValorDevido, DataVencimento, @DataCalculo, 2))/*DM42699*/
                                       WHEN IdMoeda = 3 THEN (dbo.Calc_URH(ValorDevido, @DataCalculo, 3))/*DM42699*/
								  END
                             END,
               DataVencimento,IdTipoDebito,
               CASE WHEN ValorPago > 0 THEN 3 ELSE IdSituacaoAtual END ,ValorPago,
               TotalOrigem = (SELECT SUM (dbo.AtualizaDebitos (DataVencimento, @DataCalculo, ValorDevido, @lFisica, 
										  IdTipoDebito, IdMoeda, @IdProcedimento, 0,  IdDebito, 
							 (CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END)) -  
							  CASE WHEN ValorPago > 0 THEN dbo.Calc_PagoMenor(IdDebito, @lFisica)
							  ELSE CASE WHEN IdMoeda = 1 THEN ValorDevido
							        	WHEN IdMoeda = 2 THEN (dbo.Calc_Ufir(ValorDevido,DataVencimento,@DataCalculo,2))
										WHEN IdMoeda = 3 THEN (dbo.Calc_URH(ValorDevido,@DataCalculo, 3))
                                                                                                                                                                END
                                                                                                                                                      END)
							  FROM  Debitos 
                              WHERE IdProfissional = @IdProfissional AND NumConjReneg = @NumConjRen AND 
								    IdSituacaoAtual IN (6, 14)),
                Multa = dbo.AtualizaDebitos(DataVencimento,@DataCalculo,ValorDevido,@lFisica,IdTipoDebito,IdMoeda,
											@IdProcedimento,1,IdDebito,CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
                Juros = dbo.AtualizaDebitos(DataVencimento,@DataCalculo,ValorDevido,@lFisica,IdTipoDebito,IdMoeda, 
											@IdProcedimento,2,IdDebito,CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
                Atualizacao= dbo.AtualizaDebitos(DataVencimento,@DataCalculo,ValorDevido,@lFisica,IdTipoDebito,IdMoeda,
											@IdProcedimento,3,IdDebito,CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
                TotalAtual = dbo.AtualizaDebitos(DataVencimento, @DataCalculo,ValorDevido,@lFisica,IdTipoDebito,IdMoeda, 
											@IdProcedimento,0,IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
                CodErro = dbo.AtualizaDebitos(DataVencimento, @DataCalculo, ValorDevido, @lFisica,IdTipoDebito,IdMoeda, 
											@IdProcedimento,6,IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
				IdProcedimento = CASE WHEN @IdProcedimento = 0 THEN dbo.AchaProcedimento(DataVencimento,@DataCalculo,@lFisica,IdTipoDebito,NumeroParcela)
                                      ELSE @IdProcedimento END,
                0                                   
        FROM Debitos
        WHERE  IdProfissional = @IdProfissional AND  NumConjReneg = @NumConjRen AND  IdSituacaoAtual IN (6, 14)
        ORDER BY NumConjReneg,DataReferencia,NumeroParcela
        
		/*Parcelas da Renegociacao*/  
		INSERT INTO #tblValorParc (IdDebito,ValorDevido,NumeroParcela,Acre,Desconto,BaixaAcre)
        SELECT IdDebito,ValorDevido,NumeroParcela,
			   ISNULL(Acrescimos,0), ISNULL(Desconto,0), 0  /* Oc. 56529 */
        FROM Debitos
        WHERE IdProfissional = @IdProfissional AND NumConjReneg = @NumConjRen AND 
			  IdTipoDebito IN (@IdRenegociacao, @IdRecobranca)
        ORDER BY NumConjReneg,DataReferencia,NumeroParcela        
    END  
	
	/*Pessoa Jurídica*/    
    IF @lFisica = 0
    BEGIN
		INSERT INTO #tblDebOrigem (IdDebito,Idmoeda,ValorDevido,DataVencimento,IdTipoDebito,SituacaoAtual,ValorPago , 
									TotalOrigem ,Multa,Juros,Atualizacao,TotalAtual,CodErro,IdProcedimento,Baixa)        
        SELECT IdDebito,IdMoeda,
               ValorDevido = CASE WHEN ValorPago > 0 THEN dbo.Calc_PagoMenor(IdDebito, 1)
                             ELSE CASE WHEN IdMoeda = 1 THEN ValorDevido
                                       WHEN IdMoeda = 2 THEN (dbo.Calc_Ufir(ValorDevido, DataVencimento, @DataCalculo, 2))/*DM42699*/
                                       WHEN IdMoeda = 3 THEN (dbo.Calc_URH(ValorDevido, @DataCalculo, 3))/*DM42699*/
                                  END
                              END,
               DataVencimento,IdTipoDebito,
               CASE WHEN ValorPago > 0 THEN 3 ELSE IdSituacaoAtual END ,ValorPago,
               TotalOrigem = (SELECT SUM (dbo.AtualizaDebitos (DataVencimento, @DataCalculo, ValorDevido, @lFisica, 
										  IdTipoDebito, IdMoeda, @IdProcedimento, 0,IdDebito, 
							 (CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END)) -
							  CASE WHEN ValorPago > 0 THEN dbo.Calc_PagoMenor(IdDebito,@lFisica)
							  ELSE CASE WHEN IdMoeda = 1 THEN ValorDevido
							  	        WHEN IdMoeda = 2 THEN (dbo.Calc_Ufir(ValorDevido,DataVencimento,@DataCalculo,2))
							  	        WHEN IdMoeda = 3 THEN (dbo.Calc_URH(ValorDevido,@DataCalculo, 3))                                                                                                                                                                               END
                                                                                                                                                                     END)
							  FROM  Debitos
							  WHERE IdPessoaJuridica = @IdProfissional AND NumConjReneg = @NumConjRen AND 
									IdSituacaoAtual IN (6, 14)),
				Multa = dbo.AtualizaDebitos(DataVencimento,@DataCalculo,ValorDevido,@lFisica,IdTipoDebito,IdMoeda,
											@IdProcedimento, 1, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
                Juros = dbo.AtualizaDebitos(DataVencimento, @DataCalculo, ValorDevido, @lFisica, IdTipoDebito,IdMoeda, 
											@IdProcedimento, 2, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
                Atualizacao = dbo.AtualizaDebitos(DataVencimento,@DataCalculo,ValorDevido,@lFisica,IdTipoDebito,IdMoeda, 
											@IdProcedimento, 3, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
                TotalAtual = dbo.AtualizaDebitos(DataVencimento,@DataCalculo,ValorDevido,@lFisica,IdTipoDebito,IdMoeda, 
											@IdProcedimento, 0, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
                CodErro = dbo.AtualizaDebitos(DataVencimento,@DataCalculo,ValorDevido,@lFisica, IdTipoDebito,IdMoeda, 
											@IdProcedimento, 6, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
				IdProcedimento = CASE WHEN @IdProcedimento = 0 THEN dbo.AchaProcedimento(DataVencimento,@DataCalculo,@lFisica,IdTipoDebito,NumeroParcela)
                                      ELSE @IdProcedimento END,
                0                   
        FROM   Debitos
        WHERE  IdPessoaJuridica = @IdProfissional AND  NumConjReneg = @NumConjRen AND  IdSituacaoAtual IN (6, 14)
        ORDER BY NumConjReneg,DataReferencia,NumeroParcela 
        
        /*Parcelas da Renegociacao*/ 
		INSERT INTO #tblValorParc (IdDebito,ValorDevido,NumeroParcela,Acre,Desconto,BaixaAcre)        
        SELECT IdDebito,ValorDevido,NumeroParcela,
               ISNULL(Acrescimos,0), ISNULL(Desconto,0), 0  /* Oc. 56529 */
        FROM  Debitos
        WHERE IdPessoaJuridica = @IdProfissional AND  NumConjReneg = @NumConjRen
               AND IdTipoDebito IN (@IdRenegociacao, @IdRecobranca)
        ORDER BY NumConjReneg,DataReferencia,NumeroParcela                
    END
    
    /*Pessoa*/  
    IF @lFisica = 2
    BEGIN
		INSERT INTO #tblDebOrigem (IdDebito,Idmoeda,ValorDevido,DataVencimento,IdTipoDebito,SituacaoAtual,ValorPago, 
								   TotalOrigem,Multa,Juros ,Atualizacao ,TotalAtual ,CodErro,IdProcedimento,Baixa)        
        SELECT IdDebito,IdMoeda,
               ValorDevido = CASE WHEN ValorPago > 0 THEN dbo.Calc_PagoMenor(IdDebito, @lFisica)
                             ELSE CASE WHEN IdMoeda = 1 THEN ValorDevido
                                       WHEN IdMoeda = 2 THEN (dbo.Calc_Ufir(ValorDevido,DataVencimento,@DataCalculo,2))
                                       WHEN IdMoeda = 3 THEN (dbo.Calc_URH(ValorDevido, @DataCalculo, 3))
                                  END
                             END,
               DataVencimento,IdTipoDebito,
               CASE WHEN ValorPago > 0 THEN 3 ELSE IdSituacaoAtual END ,ValorPago,
               TotalOrigem = (SELECT SUM (dbo.AtualizaDebitos (DataVencimento,@DataCalculo,ValorDevido,@lFisica,
										  IdTipoDebito, IdMoeda, @IdProcedimento, 0, IdDebito, 
							 (CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END)) - 
							  CASE WHEN ValorPago > 0 THEN dbo.Calc_PagoMenor(IdDebito, @lFisica)
							  ELSE CASE WHEN IdMoeda = 1 THEN ValorDevido 
							  			WHEN IdMoeda = 2 THEN (dbo.Calc_Ufir(ValorDevido,DataVencimento,@DataCalculo,2))
							  			WHEN IdMoeda = 3 THEN (dbo.Calc_URH(ValorDevido, @DataCalculo, 3))
									END
                                                                                                                                                                     END)
							  FROM   Debitos
							  WHERE  IdPessoaJuridica = @IdProfissional AND  NumConjReneg = @NumConjRen AND  
									 IdSituacaoAtual IN (6, 14)),
			   Multa = dbo.AtualizaDebitos(DataVencimento, @DataCalculo,ValorDevido,@lFisica,IdTipoDebito,IdMoeda, 
										   @IdProcedimento, 1, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
               Juros = dbo.AtualizaDebitos(DataVencimento, @DataCalculo, ValorDevido, @lFisica, IdTipoDebito,IdMoeda, 
										   @IdProcedimento, 2, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
               Atualizacao = dbo.AtualizaDebitos(DataVencimento, @DataCalculo,ValorDevido,@lFisica,IdTipoDebito,IdMoeda, 
										   @IdProcedimento, 3, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
               TotalAtual = dbo.AtualizaDebitos(DataVencimento, @DataCalculo,ValorDevido, @lFisica,IdTipoDebito,IdMoeda, 
										   @IdProcedimento, 0, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
               CodErro = dbo.AtualizaDebitos(DataVencimento, @DataCalculo, ValorDevido, @lFisica, IdTipoDebito,IdMoeda,
										   @IdProcedimento, 6, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),
		       IdProcedimento = CASE WHEN @IdProcedimento = 0 THEN dbo.AchaProcedimento(DataVencimento,@DataCalculo,@lFisica,IdTipoDebito,NumeroParcela)
                                      ELSE @IdProcedimento END,
               0                   
                   
        FROM   Debitos
        WHERE  IdPessoa = @IdProfissional AND  NumConjReneg = @NumConjRen AND IdSituacaoAtual IN (6, 14)
        ORDER BY NumConjReneg,DataReferencia,NumeroParcela
        
        /*Parcelas da Renegociacao*/ 
		INSERT INTO #tblValorParc (IdDebito,ValorDevido,NumeroParcela,Acre,Desconto,BaixaAcre)        
        SELECT IdDebito,ValorDevido,NumeroParcela,
			   ISNULL(Acrescimos,0), ISNULL(Desconto,0), 0 /* Oc. 56529 */
        FROM   Debitos
        WHERE  IdPessoa = @IdProfissional AND  NumConjReneg = @NumConjRen
               AND IdTipoDebito IN (@IdRenegociacao, @IdRecobranca)
        ORDER BY NumConjReneg,DataReferencia,NumeroParcela
    END 

    IF (SELECT MAX(NumeroParcela) FROM #tblValorParc) > 0
    BEGIN
		/* Calcula o valor do desconto */
		SELECT @ValorDescontoPrincipal = SUM(ValorDevido) * @DescontoPrincipal / 100 FROM #tblDebOrigem        
	    
		/* Aqui a gente identifica o valor do desconto sobre o principal dividido pelo número de parcelas. */        
		SELECT @ValorDescontoPrincipalPorParcela = @ValorDescontoPrincipal / (SELECT MAX(NumeroParcela) FROM #tblValorParc)
		
		/* Assim podemos retirar do campo "Desconto" da tabela #tblValorParc este valor. */
		UPDATE #tblValorParc SET Desconto = Desconto - @ValorDescontoPrincipalPorParcela
		
		/* Seleciona a última origem - O desconto será da última pra tras. */
		SELECT @ID = MAX(ID) FROM #tblDebOrigem
	  
		WHILE @ValorDescontoPrincipal > 0 
		BEGIN
			SELECT @ValorDevido = ValorDevido FROM #tblDebOrigem WHERE Id = @ID
			IF @ValorDescontoPrincipal >= @ValorDevido
			BEGIN
				UPDATE #tblDebOrigem 
				SET    ValorDevido = 0,
					   ValorDescontoPrincipal = ValorDevido
			    WHERE Id = @ID
				SELECT @ValorDescontoPrincipal = @ValorDescontoPrincipal - @ValorDevido			
			END		
			ELSE
			BEGIN
				UPDATE #tblDebOrigem 
				SET    ValorDevido = ValorDevido - @ValorDescontoPrincipal,
			           ValorDescontoPrincipal = @ValorDescontoPrincipal 
				WHERE  Id = @ID
				SELECT @ValorDescontoPrincipal = 0
			END
			
			SELECT @ID = MAX(ID) FROM #tblDebOrigem WHERE ID < @ID		
		END
    END
         
	UPDATE #tblDebOrigem SET ValorDevidoOriginal = ValorDevido          
            
	/*Se existe cota-única*/ 
	IF EXISTS ( SELECT TOP 1 1 FROM #tblValorParc WHERE NumeroParcela = 0) 
	BEGIN
		/*Quantidade de Origens*/
		SELECT @ContOrigem = max(id) FROM   #tblDebOrigem 
   		SET  @DescontoCotaUnica = isnull((SELECT  isnull(Desconto,0) FROM #tblValorParc WHERE NumeroParcela = 0 ),0)   	   	   	   	   	    	    			
   		SET  @idDebitoParcela  = isnull((SELECT IdDebito  FROM #tblValorParc WHERE NumeroParcela = 0 ),0)   	   	   	   	   	    	 
   		
   		IF @DescontoCotaUnica > 0
   		BEGIN 			
		     SET @TotalEncargos =isnull((SELECT Sum(isnull(Multa,0)+isnull(Juros,0)+isnull(Atualizacao,0))
		   	                             FROM #tblDebOrigem  ),0)   	   	   	   	   	    	 		   	
			 SET @DescontoCotaUnica = (@DescontoCotaUnica * 100) / @TotalEncargos    			   			     		   	 				
        END 
        
   		SET @bExistCotaUnica = 1
	END
	ELSE/*Se não existe cota-única*/ 
   	BEGIN
		SET @bExistCotaUnica = 0
		SET @DescontoCotaUnica = 0
	END   		  

    /*Se existe desconto nas parcelas sem ser proporcional */
    SET @TotalDesconto = isnull((SELECT  Sum(isnull(Desconto,0)) FROM #tblValorParc WHERE NumeroParcela > 0 ),0)   	   	   	   	   	    	 
    
    IF (@DescontoMulta = 0 AND @DescontoJuros = 0 AND @DescontoAtualizacao = 0 AND @TotalDesconto > 0 )		  
	BEGIN 
		 SET @TotalEncargos  =isnull((SELECT  Sum(isnull(Multa,0)+isnull(Juros,0)+isnull(Atualizacao,0) ) 
		                              FROM #tblDebOrigem  ),0)   	  
	     IF @TotalDesconto > @TotalEncargos
			SET @TotalDesconto = @TotalEncargos		                               	   	   	   	    	 		   	
		 SET @TotalDesconto =  (@TotalDesconto * 100) / @TotalEncargos 		   			   			     		   	 
	END 
		   	        
	/*Atualizando as Origens*/
	SELECT @ContOrigem = min(id)FROM   #tblDebOrigem		 
	WHILE @ContOrigem IS NOT NULL 
	BEGIN	
		SELECT @Multa =ISNULL(Multa,0),@juros=ISNULL(juros,0),@Atualizacao =ISNULL(Atualizacao,0)    
		FROM #tblDebOrigem 
		WHERE Id = @ContOrigem                  					
		
		/*Se é cota-única*/	
		IF @bExistCotaUnica = 1 
		BEGIN   	
   			/* Se não existe desconto*/
   			IF @DescontoCotaUnica = 0
   			BEGIN
				INSERT INTO #tblComposicao (IdDebito,IdDebitoOrigemRen,ValorEsperadoPrincipal,ValorEsperadoMulta,
											ValorEsperadoJuros,ValorEsperadoAtualizacao,IdMoedaValorEsperado,RegistraLog,
											IdProcedimentoAtraso,valorTotal,IdParcela)    	      	       	     
				SELECT @idDebitoParcela,IdDebito,ValorDevido,Multa,Juros,Atualizacao,Idmoeda,0,IdProcedimento,
					   TotalAtual,0		
				FROM #tblDebOrigem 
				WHERE Id = @ContOrigem   	   	   	   	
   			END
   			/* Se existe desconto*/
   			ELSE 
   			BEGIN
   				/*Se o desconto não foi pela tela da Ren de desconto proporcional*/
   	 			IF (@DescontoMulta = 0 AND @DescontoJuros = 0 AND @DescontoAtualizacao = 0) 
   	 			BEGIN 	
					SELECT @ValPrincipal = ValorDevido, @Multa =ISNULL(Multa,0),@juros=ISNULL(juros,0),
						   @Atualizacao =ISNULL(Atualizacao,0)   
				    FROM #tblDebOrigem 
					WHERE Id = @ContOrigem                  		   	 	

					SELECT @Multa =ISNULL(Multa,0),@juros=ISNULL(juros,0),@Atualizacao =ISNULL(Atualizacao,0)    
					FROM #tblDebOrigem 
					WHERE Id = @ContOrigem                  		
							
					IF @Multa > 0
						SET @Multa = @Multa -  (@Multa * @DescontoCotaUnica / 100 )           
					IF   @Juros > 0
						SET @Juros = @Juros -  (@Juros * @DescontoCotaUnica / 100 )        
					IF   @Atualizacao > 0
						SET @Atualizacao = @Atualizacao -  (@Atualizacao * @DescontoCotaUnica / 100 )                       		   	   	 					      	 					    	 					  					   
   	 				   	 	   
					INSERT INTO #tblComposicao(IdDebito,IdDebitoOrigemRen,ValorEsperadoPrincipal,ValorEsperadoMulta,
											   ValorEsperadoJuros,ValorEsperadoAtualizacao,IdMoedaValorEsperado,
											   RegistraLog,IdProcedimentoAtraso,valorTotal,IdParcela)    	      	       	     
					SELECT @idDebitoParcela,IdDebito,@ValPrincipal,@Multa,@juros,@Atualizacao,Idmoeda,0,IdProcedimento,
						   (@ValPrincipal+@Multa+@juros+@Atualizacao),0		
					FROM #tblDebOrigem 
					WHERE Id = @ContOrigem   	   	   	   	   	 	   
   	 			END
   	 			/*Aplica desconto Propocional nas origens */ 
   	 			ELSE
   	 			BEGIN					   	
					SELECT @ValPrincipal = ValorDevido , @Multa =ISNULL(Multa,0),@juros=ISNULL(juros,0),
						   @Atualizacao =ISNULL(Atualizacao,0)    
					FROM #tblDebOrigem 
					WHERE Id = @ContOrigem                  		
							
					IF  @DescontoMulta > 0 AND @Multa > 0
						SET @Multa = @Multa -  (@Multa * @DescontoMulta / 100 )           
					IF  @DescontoJuros > 0 AND @Juros > 0
						SET @Juros = @Juros -  (@Juros * @DescontoJuros / 100 )        
					IF  @DescontoAtualizacao > 0 AND @Atualizacao > 0
						SET @Atualizacao = @Atualizacao -  (@Atualizacao * @DescontoAtualizacao / 100 )                      	 		   	 		   	 		   	 		   	 																	
								
					INSERT INTO #tblComposicao (IdDebito,IdDebitoOrigemRen,ValorEsperadoPrincipal,ValorEsperadoMulta,
											    ValorEsperadoJuros,ValorEsperadoAtualizacao,IdMoedaValorEsperado,
											    RegistraLog,IdProcedimentoAtraso,valorTotal,IdParcela)    	      	       	     
					SELECT @idDebitoParcela,IdDebito,@ValPrincipal,@Multa,@juros,@Atualizacao,Idmoeda,0,IdProcedimento,
						   (@ValPrincipal+@Multa+@juros+@Atualizacao),0		
					FROM #tblDebOrigem 
					WHERE Id = @ContOrigem 					
   	 			END
   		    END	
		END
			
		
		/*Aplica desconto propocional nas origens */    	
		IF (@DescontoMulta > 0 OR @DescontoJuros > 0 OR @DescontoAtualizacao >0 ) 
		BEGIN 		
			SELECT @Multa =ISNULL(Multa,0),@juros=ISNULL(juros,0),@Atualizacao =ISNULL(Atualizacao,0)    
			FROM #tblDebOrigem 
			WHERE Id = @ContOrigem 
			                 		
			IF  @DescontoMulta > 0 AND @Multa > 0
				 SET @Multa = @Multa -  (@Multa * @DescontoMulta / 100 )           
			IF  @DescontoJuros > 0 AND @Juros > 0
				SET @Juros = @Juros -  (@Juros * @DescontoJuros / 100 )        
			IF  @DescontoAtualizacao > 0 AND @Atualizacao > 0
				SET @Atualizacao = @Atualizacao -  (@Atualizacao * @DescontoAtualizacao / 100 )                       
		END 
		/*verfica se existe desconto avulso nas parcelas */   		
		ELSE IF @TotalDesconto > 0
		BEGIN
			SELECT @Multa =ISNULL(Multa,0),@juros=ISNULL(juros,0),@Atualizacao =ISNULL(Atualizacao,0)    
			FROM #tblDebOrigem 
			WHERE Id = @ContOrigem 
			                 		
			IF   @Multa > 0
				 SET @Multa = @Multa -  (@Multa * @TotalDesconto / 100 )           
			IF   @Juros > 0
				SET @Juros = @Juros -  (@Juros * @TotalDesconto / 100 )        
			IF   @Atualizacao > 0
				SET @Atualizacao = @Atualizacao -  (@Atualizacao * @TotalDesconto / 100 )                       		   	   		   			   			   	
		END	
		
		/* Atualiza origem */
		UPDATE #tblDebOrigem 
		SET Multa = @Multa,Juros = @juros,Atualizacao = @Atualizacao,
			TotalAtual = (ValorDevido + @Multa +@juros +@Atualizacao) 
		WHERE Id = @ContOrigem 
				 
		SELECT @ContOrigem = min(id) FROM   #tblDebOrigem  WHERE  id > @ContOrigem
	END                       
	
	/* Se já foi feita a atualização da origem então deleta*/	
	IF @bExistCotaUnica = 1 
	BEGIN
		 SET @ValorParc = isnull((SELECT  isnull(ValorDevido ,0) FROM #tblValorParc WHERE NumeroParcela = 0 ),0)   	   	   	   	   	    	 
		 SET @TotalParc = isnull((SELECT  Sum(isnull(ValorTotal,0)) FROM #tblComposicao  ),0)   	   	   	   	   	    	 
		 
		 IF @ValorParc > @TotalParc		   	 
		 BEGIN 
		   	 SET @Acre = @ValorParc - @TotalParc
		   	 		   	 
		   	 SELECT TOP 1 @IdTblOrigem =Id, @Multa =ISNULL(ValorEsperadoMulta,0),@juros=ISNULL(ValorEsperadojuros,0),
		   				  @Atualizacao =ISNULL(ValorEsperadoAtualizacao,0) 
		   	 FROM #tblComposicao 
		   	 
		   	 IF @Juros > 0
		   	   SET @Juros = @Juros + @Acre
		   	 ELSE
    	   	 IF @Multa > 0		   	 	
			     SET @Multa = @Multa + @Acre		   	 	 
			 ELSE
			 IF @Atualizacao > 0		   	 		    
			    SET @Atualizacao = @Atualizacao  + @Acre						    
			    
			 UPDATE #tblComposicao  SET ValorEsperadoMulta = @Multa,ValorEsperadoJuros = @juros,ValorEsperadoAtualizacao = @Atualizacao,ValorTotal = (ValorEsperadoPrincipal + @Multa +@juros +@Atualizacao) WHERE Id = @IdTblOrigem  	   
		 END
		 DELETE FROM #tblValorParc WHERE NumeroParcela = 0	
    END 
    /*Quantidade de parcelas */                   
    SELECT @NumeroParcela =  isnull((SELECT CASE WHEN max(NumeroParcela) = 0 THEN 1 ELSE max(NumeroParcela) END 
                                     FROM #tblValorParc ),0)
		 
	/*Quantidade de Origens*/
	SELECT @ContOrigem = max(id) FROM #tblDebOrigem           
		 
	IF @ContOrigem IS NOT NULL 
		SET @ContParc = 1              
	ELSE
		SET @ContParc = @NumeroParcela + 1
		 	
	SET @SaldoAtual = 0
	SET @ValorDevido = 0
	SET @ValResto = 0
	SET @Valvula = 0
		 
	WHILE @ContParc <= @NumeroParcela
	BEGIN      	 		
		 /*Valor da parcela*/
		 SELECT @ValorParc = ValorDevido - isnull((SELECT sum(ISNULL(valorTotal,0))
		                                           FROM #tblComposicao  
		                                           WHERE IdParcela  = @ContParc ),0)
			  ,@idDebitoParcela = IdDebito
		 FROM #tblValorParc 
		 WHERE NumeroParcela  = @ContParc  
		          	  
		 /*Valor Da origem*/ 
		 SELECT TOP 1 @ValorDevido =  isnull(TotalAtual,0) ,@ValPrincipal = isnull(ValorDevido,0),
					  @juros =  isnull(Juros,0) , @Multa =  isnull(Multa,0),@Atualizacao =  isnull(Atualizacao,0),
					  @IdTblOrigem = Id,@IdProcedimento =IdProcedimento 
		 FROM #tblDebOrigem 
		 WHERE Baixa = 0      	  

		 IF (@ValorDevido <= @ValorParc)	
		 BEGIN	
			/*insert na composição pela origem*/
			INSERT INTO #tblComposicao (IdDebito,IdDebitoOrigemRen,ValorEsperadoPrincipal,ValorEsperadoMulta,
										ValorEsperadoJuros,ValorEsperadoAtualizacao,IdMoedaValorEsperado,RegistraLog,
										IdProcedimentoAtraso,valorTotal,IdParcela, ValorDescontoPrincipal)    	      	       	     
			SELECT TOP 1  @idDebitoParcela,IdDebito,ValorDevido+@ValResto,Multa,Juros,Atualizacao,1,0,@IdProcedimento,
						  TotalAtual,@ContParc, ValorDescontoPrincipal  	      
			FROM #tblDebOrigem 
			WHERE Baixa = 0		
				
			/*Da baixa na Origem*/
			UPDATE #tblDebOrigem SET Baixa = 1 WHERE Id = @IdTblOrigem 
				
		 END
		 ELSE
		 BEGIN
    		SET @ValMontante = 0
    		SET @MultaMontante = 0
			SET @JurosMontante = 0    	
			SET @AtualizacaoMontante = 0					
    		SET @ValSobra =  @ValorDevido - @ValorParc		    	
    		SET @NumPercent = (@ValSobra * 100) / @ValorDevido		    	 
    		SET @ValMontante = @ValPrincipal - ( @ValPrincipal - (( @ValPrincipal * @NumPercent) / 100 ) )
			SET @MultaMontante = @Multa - ( @Multa - (( @Multa * @NumPercent) / 100 ) )    	
			SET @JurosMontante = @juros - ( @juros - (( @juros * @NumPercent) / 100 ) )    			
			SET @AtualizacaoMontante = @Atualizacao - ( @Atualizacao - (( @Atualizacao * @NumPercent) / 100 )) 	 

			/*verifica se a composição (da multa juros e atualizacao  estão batendo */				
			IF @ValSobra  >  (@ValMontante + @MultaMontante +@JurosMontante + @AtualizacaoMontante) 			
		   	   SET @ValMontante = @ValMontante + (@ValSobra - (@ValMontante + @MultaMontante +@JurosMontante + 
		   		   @AtualizacaoMontante))				
			ELSE    	
			   SET @ValMontante  = @ValMontante - ((@ValMontante + @MultaMontante +@JurosMontante + 
			       @AtualizacaoMontante)- @ValSobra)			 			
				
			IF @ValSobra  = (@ValMontante + @MultaMontante +@JurosMontante + @AtualizacaoMontante) 
			BEGIN
			   	 INSERT INTO #tblComposicao (IdDebito,IdDebitoOrigemRen,ValorEsperadoPrincipal,ValorEsperadoMulta,
			   								 ValorEsperadoJuros,ValorEsperadoAtualizacao,IdMoedaValorEsperado,
			   								 RegistraLog,IdProcedimentoAtraso,valorTotal,IdParcela)    	      	       	     
  				 SELECT TOP 1  @idDebitoParcela,IdDebito,isnull(ValorDevido,0) -@ValMontante,
  			     			   isnull(Multa,0) -@MultaMontante ,isnull(Juros,0) - @JurosMontante,
  							   isnull(Atualizacao,0)- @AtualizacaoMontante ,1,0,@IdProcedimento,
  							   isnull(TotalAtual,0) -(@ValMontante + @MultaMontante +@JurosMontante + 
  							   @AtualizacaoMontante),@ContParc  	      			 
  				 FROM #tblDebOrigem 
  				 WHERE Baixa = 0		  			 			 		   			   	  			 
		  			 
		   		 UPDATE #tblDebOrigem 
		   		 SET ValorDevido = @ValMontante,Multa =@MultaMontante,Juros = @JurosMontante,
		   			 Atualizacao = @AtualizacaoMontante,TotalAtual = (@ValMontante + @MultaMontante +
		   			 @JurosMontante + @AtualizacaoMontante)  
		   		 WHERE Id = @IdTblOrigem 		   			   			   	
				   	
			END	 					
		 END	   	
		  	
		 /*Essa tabela de composição e para fazer um sum e comparar com o valor da parcela*/	       			
		 /*verifica se a parcela bate */	
		 SELECT @ValorParc = ValorDevido FROM #tblValorParc WHERE NumeroParcela  = @ContParc       	  
		 
		 IF @ValorParc = isnull((SELECT SUM(ISNULL(valorTotal,0)) FROM #tblComposicao WHERE IdParcela  =@ContParc),0)	
		 BEGIN 		
		   SET @ContParc = @ContParc + 1
		   SET @Valvula = 0
		 END  
		 ELSE
			SET @Valvula = @Valvula + 1	   
	     
	     IF @Valvula >= 500
	     BEGIN
			 IF @ValorParc > isnull((SELECT SUM(ISNULL(valorTotal,0)) FROM #tblComposicao WHERE IdParcela  =@ContParc),0)	
			 BEGIN 		 
				SET @ValorParc  = @ValorParc - isnull((SELECT SUM(ISNULL(valorTotal,0)) 
				                                       FROM #tblComposicao 
				                                       WHERE IdParcela  =@ContParc),0)
		   		SELECT TOP 1 @IdTblOrigem =Id, @Multa =ISNULL(ValorEsperadoMulta,0),@juros=ISNULL(ValorEsperadojuros,0),
		   					 @Atualizacao =ISNULL(ValorEsperadoAtualizacao,0) 
		   		FROM #tblComposicao 
		   		WHERE IdParcela  =@ContParc
		   		
		   		IF @Juros > 0
		   			SET @Juros = @Juros + @ValorParc
		   		ELSE IF @Multa > 0		   	 	
					SET @Multa = @Multa + @ValorParc		   	 	 
				ELSE IF @Atualizacao > 0		   	 		    
					SET @Atualizacao = @Atualizacao  + @ValorParc						    
					   
				UPDATE #tblComposicao  
				SET ValorEsperadoMulta = @Multa,ValorEsperadoJuros = @juros,ValorEsperadoAtualizacao = @Atualizacao,
					ValorTotal = (ValorEsperadoPrincipal + @Multa +@juros +@Atualizacao) 
				WHERE Id = @IdTblOrigem  	       		      		      		      
		     END 	  
			 BREAK 	
	      END	       
	END
	
	UPDATE c
	SET    c.ValorDescontoPrincipal = CASE WHEN o.ValorDevido = 0 THEN o.ValorDescontoPrincipal 
	                                       ELSE o.ValorDescontoPrincipal / o.ValorDevidoOriginal * c.ValorEsperadoPrincipal
	                                  END
	FROM   #tblComposicao c
	       JOIN #tblDebOrigem o
	            ON  o.IdDebito = c.IdDebitoOrigemRen
	
	/* Aqui entra o ajuste para quando se deu desconto sobre o valor principal de tal maneira que algum débito 
	* ficou sem entrar na composição*/
	IF (SELECT TOP 1 1 FROM #tblDebOrigem o LEFT JOIN #tblComposicao c ON c.IdDebitoOrigemRen = o.IdDebito WHERE c.Id IS NULL) IS NOT NULL
	BEGIN
		INSERT INTO #tblComposicao (IdDebito,IdDebitoOrigemRen,ValorEsperadoPrincipal,ValorEsperadoMulta,
								 ValorEsperadoJuros,ValorEsperadoAtualizacao,IdMoedaValorEsperado,
								 RegistraLog,IdProcedimentoAtraso,valorTotal,IdParcela, ValorDescontoPrincipal)    	      	       	     
		SELECT @idDebitoParcela,o.IdDebito, 0, 0, 0, 0, 1, 0, @IdProcedimento, 0, @ContParc, o.ValorDescontoPrincipal  	      			 
		FROM #tblDebOrigem o LEFT JOIN #tblComposicao c ON c.IdDebitoOrigemRen = o.IdDebito WHERE c.Id IS NULL
	END		
/*Oc. 40545 Final*********************************************************************************************/    
END
ELSE 
BEGIN
    IF @lEmissao = 1
    BEGIN
		DECLARE @Ren  INT,
		        @Rec  INT
		
		SELECT @Ren = td.IdTipoDebito
		FROM   TiposDebito td
		WHERE  td.NomeDebito = 'Renegociação'
		
		SELECT @Rec = td.IdTipoDebito
		FROM   TiposDebito td
		WHERE  td.NomeDebito = 'Recobrança'
		
		SELECT TOP 1 @IdTpDebito = (
		           ISNULL(
		               (
		                   SELECT TOP 1 d1.IdTipoDebito
		                   FROM   Debitos d1
		                   WHERE  d1.IdDebito = ce.IdDebito
		                          AND d1.IdTipoDebito IN (@Ren, @Rec)
		               ),
		               ISNULL(
		                   (
		                       SELECT TOP 1 d1.IdTipoDebito
		                       FROM   Debitos d1
		                       WHERE  d1.IdDebito = d.IdDebito
		                              AND d1.IdTipoDebito IN (@Ren, @Rec)
		                   ),
		                   1
		               )
		           )
		       )
		FROM   Debitos d
		LEFT JOIN   ComposicoesEmissao ce ON ce.IdDebito = d.IdDebito
		LEFT JOIN   DetalhesEmissao de ON de.IdDetalheEmissao = ce.IdDetalheEmissao
		WHERE  d.IdDebito = @IdDebito
		ORDER BY
		       de.IdDetalheEmissao DESC
       
           	
		SELECT TOP 1 /*@IdTpDebito =  1,*/
					/*DM41705-Retirando as despesas pois não devem incindir para multa e juros*/
					 @ValorParc = ComposicoesEmissao.ValorDevido - CASE WHEN @bAvulso = 1 THEN (ISNULL(ComposicoesEmissao.ValorDespBco,0) + 
												 ISNULL(ComposicoesEmissao.ValorDespPostais,0) + 
												 ISNULL(ComposicoesEmissao.ValorDespAdv,0)+
												 ISNULL(ComposicoesEmissao.ValorAtualizacao,0) +
												 ISNULL(ComposicoesEmissao.ValorMulta,0) +
												 ISNULL(ComposicoesEmissao.ValorJuros,0) 
					 ) ELSE 0 END ,
					/**************************************************************************/		
					 @DataVcto = CASE WHEN @bAvulso = 1 THEN Debitos.DataVencimento ELSE DetalhesEmissao.DataVencimento END ,
					 @IdMoedaOrig = DetalhesEmissao.IdMoedaDevida,@IdSituacao = 0,
					 @Principal = ComposicoesEmissao.ValorPrincipal
        FROM   ComposicoesEmissao,DetalhesEmissao, Debitos
        WHERE  ComposicoesEmissao.IdDetalheEmissao = DetalhesEmissao.IdDetalheEmissao AND  ComposicoesEmissao.IdDebito = @IdDebito
        AND debitos.IdDebito = @IdDebito
        
        ORDER BY IdComposicaoEmissao DESC
    END
    ELSE 
    BEGIN
        SELECT @ValorParc = ValorDevido,@DataVcto = DataVencimento,@IdMoedaOrig = IdMoeda,@IdTpDebito = IdTipoDebito,
               @IdSituacao = IdSituacaoAtual, @Principal = ValorDevido
        FROM   Debitos
        WHERE  IdDebito = @IdDebito
    END 
                  
	IF @IdTpDebito IN (@IdRenegociacao, @IdRecobranca)
		SELECT @Principal = @ValorParc  
    
    IF @IdMoedaOrig = 2
       SELECT @Principal = (SELECT dbo.Calc_Ufir(@Principal, @DataVcto, @DataCalculo, 2))  
    IF @IdMoedaOrig = 3
       SELECT @Principal = (SELECT dbo.Calc_URH(@Principal, @DataCalculo, 3))
    
    /* atualiza o débito e gera a composição */               

    IF @IdSituacaoDefault <> 0
       SELECT @IdSituacao = 1  
    
    SELECT @Multa = ISNULL(Multa,0),@Juros = ISNULL(Juros,0),@Atualizacao = ISNULL(Atualizacao,0),
		   @TotalAtual = ISNULL(ValorTotal,0),@CodErro = CodErro, @IdProcedimento = IdProcedimento
    FROM   dbo.AtualizaDebitosAll (@DataVcto, @DataCalculo, @ValorParc, @lFisica, @IdTpDebito, @IdMoedaOrig, 0, 
		   @IdDebito, @IdSituacao)  
        
	IF @lEmissao = 1 AND @bAvulso = 0
	BEGIN
		SELECT TOP 1 @tmpAtu = ISNULL(ComposicoesEmissao.ValorAtualizacao, 0),
			   @tmpMul = ISNULL(ComposicoesEmissao.ValorMulta, 0),
			   @tmpJur = ISNULL(ComposicoesEmissao.ValorJuros, 0)
		FROM   ComposicoesEmissao,
			   DetalhesEmissao
		WHERE  ComposicoesEmissao.IdDetalheEmissao = DetalhesEmissao.IdDetalheEmissao
			   AND ComposicoesEmissao.IdDebito = @IdDebito
		ORDER BY
			   IdComposicaoEmissao DESC
		
		SELECT @Multa = @Multa + @tmpMul, @Juros = @Juros + @tmpJur, @Atualizacao = @Atualizacao + @tmpAtu	   
	END                          
    
    
    
    SET @IdDebitoDest = 0  
    SELECT @IdDebitoDest = 1
    WHERE  EXISTS (SELECT NULL FROM  ComposicoesDebito WHERE  IdDebito = @IdDebito)  
           
    IF @Principal = @TotalAtual
       SELECT @CodErro = -1                         
           
    IF @CodErro = 0
    IF ((@IdTpDebito IN (@IdRenegociacao, @IdRecobranca) /*= *2*/ ) AND (isnull(@NumConjRen,0) <> 0)) OR  (@IdDebitoDest = 0 )
    BEGIN
       IF @IdTpDebito IN (@IdRenegociacao, @IdRecobranca)
          SELECT @Principal = 0  
       
       SELECT TOP 1 @IdDebitoOrig = IdDebitoOrigemRen FROM  ComposicoesDebito WHERE  IdDebito = @IdDebito  
       
       IF @Principal = 0
		SELECT @IdDebitoOrig = @IdDebito 
			   
	   INSERT INTO #tblComposicao(IdDebito,ValorEsperadoPrincipal,IdMoedaValorEsperado,ValorEsperadoAtualizacao,
								  ValorEsperadoMulta,ValorEsperadoJuros,IdDebitoOrigemRen,RegistraLog,
								  IdProcedimentoAtraso)
                   
       SELECT @IdDebito,@Principal,@IdMoedaOrig,@Atualizacao,@Multa,@Juros,
			  CASE @IdDebitoOrig WHEN 0 THEN NULL ELSE @IdDebitoOrig END,0,
              CASE @IdProcedimento WHEN 0 THEN NULL ELSE @IdProcedimento END 
		
                          
       SET @tmpSQL = 'INSERT INTO ComposicoesDebito(IdDebito,ValorEsperadoPrincipal,IdMoedaValorEsperado,
													ValorEsperadoAtualizacao,ValorEsperadoMulta,ValorEsperadoJuros,
													IdDebitoOrigemRen,RegistraLog'  
                          
       IF @IdProcedimento <> 0
          SET @tmpSQL = @tmpSQL + ',IdProcedimentoAtraso)'
       ELSE 
          SET @tmpSQL = @tmpSQL + ')'  
                          
      SET @tmpSQL = @tmpSQL + ' VALUES( ' + CAST(@IdDebito AS VARCHAR(15)) + ','+ CAST(@Principal AS VARCHAR(15)) + ','+  
											CAST(@IdMoedaOrig AS VARCHAR(15)) + ','+ CAST(@Atualizacao AS VARCHAR(15)) + ','+  
											CAST(@Multa AS VARCHAR(15)) + ','+ CAST(@Juros AS VARCHAR(15)) + ','+  
											ISNULL(CAST(@IdDebitoOrig AS VARCHAR(15)) , 'NULL') + ', 0'  
                          
       IF @IdProcedimento <> 0
          SET @tmpSQL = @tmpSQL + ',' + CAST(@IdProcedimento AS VARCHAR(15)) +')'
       ELSE 
          SET @tmpSQL = @tmpSQL + ')'  
       
       SET @tmpSQL = ' UPDATE ComposicoesDebito SET RegistraLog = 1 WHERE RegistraLog = 0 '  

    END
    ELSE 
    BEGIN
       SELECT @Principal = 0
       WHERE  EXISTS (SELECT 1 FROM  ComposicoesDebito WHERE  IdDebito = @IdDebito)  
                          
       INSERT INTO #tblComposicao (IdDebito,ValorEsperadoPrincipal,IdMoedaValorEsperado,ValorEsperadoAtualizacao,
								   ValorEsperadoMulta,ValorEsperadoJuros,IdDebitoOrigemRen,RegistraLog,
								   IdProcedimentoAtraso)
                          
       SELECT @IdDebito,@Principal,@IdMoedaOrig,@Atualizacao,@Multa,@Juros,
			  CASE @IdDebitoOrig WHEN 0 THEN NULL ELSE @IdDebitoOrig END,0,
              CASE @IdProcedimento WHEN 0 THEN NULL ELSE @IdProcedimento END 
                                 
                                 
       SET @tmpSQL = 'INSERT INTO ComposicoesDebito(IdDebito,ValorEsperadoPrincipal,IdMoedaValorEsperado,
													ValorEsperadoAtualizacao,ValorEsperadoMulta,ValorEsperadoJuros, 
													IdDebitoOrigemRen,RegistraLog'  
       IF @IdProcedimento <> 0
          SET @tmpSQL = @tmpSQL + ',IdProcedimentoAtraso)'
       ELSE 
          SET @tmpSQL = @tmpSQL + ')'  
         
       SET @tmpSQL = @tmpSQL + ' VALUES( ' + CAST(@IdDebito AS VARCHAR(15)) + ','+ CAST(@Principal AS VARCHAR(15)) + ','+  
											 CAST(@IdMoedaOrig AS VARCHAR(15)) + ','+
											 CAST(@Atualizacao AS VARCHAR(15)) + ','+ CAST(@Multa AS VARCHAR(15)) + ','+  
											 CAST(@Juros AS VARCHAR(15)) + ','+  
                                 ISNULL(CAST(@IdDebitoOrig AS VARCHAR(15)) , 'NULL') + ', 0'  
      
      IF @IdProcedimento <> 0
         SET @tmpSQL = @tmpSQL + ',' + CAST(@IdProcedimento AS VARCHAR(15)) +')'
      ELSE 
         SET @tmpSQL = @tmpSQL + ')'   

      SET @tmpSQL = ' UPDATE ComposicoesDebito SET RegistraLog = 1 WHERE RegistraLog = 0 '  
    END
END  

/* Oc. 49027 - Adiciona o valor do acréscimo no valor devido do débito e na composição do débito. */
IF @lRenegociacao = 1
BEGIN
	SELECT @ContParc = MIN(t.Id) FROM #tblValorParc t
		
	WHILE @ContParc IS NOT NULL	
	BEGIN
		SELECT	@idDebitoParcela = t.IdDebito,
				@Acre = t.Acre
		FROM	#tblValorParc t 
		WHERE	t.Id = @ContParc
		
		UPDATE	Debitos 
		SET		ValorDevido = ValorDevido + ISNULL(Acrescimos, 0) 
		WHERE	IdDebito = @idDebitoParcela
		
		/* Oc. 56529
		* 
		* Ajuste realizado porque o valor do acréscimo nao estava sendo distribuído entre as origens da Parcela. 
		* Explicando, cada parcela de renegociação pode ter uma ou mais origens. Para cada origem é criada uma composição 
		* e é na composição da parcela de renegociação que o valor do acréscimo é lançado. 
		* O valor é lançado como um encargo, podendo ser Atualização, Multa ou Juros. 
		* Acontece que antes o valor do acréscimo definido para a parcela era inserido de forma integral em cada composição, 
		* sendo duplicado a cada nova composição. 
		* Então foi feito um cálculo proporcional para cada composição a ser distribuída o acréscimo.
		* 
		* O valor do acréscimo contido na variável @Acre deve ser dividido de forma proporcional entre as origens.
		* Exemplo -> Temos uma parcela de renegociação de R$ 75,00 onde deve-se ser acrescido o valor de R$ 8,80.
		* Supomos que esta parcela tenha duas origens, sendo
		*   - Anu 2007 - Valor Total = R$ 25,00
		*   - Anu 2008 - Valor Total = R$ 50,00
		*  Neste caso não podemos inserir o acréscimo de R$ 7,50 nas duas composições (origens) porque desta 
		*  forma estaríamos duplicando o valor do acréscimo. Então, ao invés de apenas dividir o valor entre as
		*  origens, fazemos um proporcional ficando
		*   - Para a origen de R$ 25,00 o acréscimo de R$ 2,93
		*   - Para a origen de R$ 50,00 o acréscimo de R$ 5,87
		*  ** ValorTotal = Valor princial mais encargos.
		* */		
		
		/* Soma o valor total das origens desta parcela. Esta variável @Total
		*  será utilizada para fazer um proporcional.*/
		SELECT  @Total = SUM(ValorTotal)
		FROM	#tblComposicao
		WHERE	IdDebito = @idDebitoParcela 
		
		/* Insere no campo ValorAcrescimo o valor proprocional de cada origen fazendo uma regra de 3 basica.
		*  Como no exemplo acima, neste momento estamos inserindo o valor de R$ 2,93 para a origem Anu 2007 de R$ 25,00
		*  e o valor de R$ 5,87 para a origem Anu 2008 de R$ 50,00. */
		UPDATE	#tblComposicao
		SET		ValorAcrescimo = (@Acre * ValorTotal) / @Total
		WHERE	IdDebito = @idDebitoParcela		
		
		/* Agora somamos o valor total distribuído. Ou seja, no exemplo acima, estamos somando os valores R$ 2,93 + R$ 5,87. */
		SELECT	@Acrescimos = SUM(ISNULL(ValorAcrescimo, 0)) 
		FROM	#tblComposicao
		WHERE	IdDebito = @idDebitoParcela
		 
		/* Agora comparamos o valor do acréscimo contido na variável @Acre que distribuímos entre as origens e o total distribuido
		*  entre as origens. Fazemos isto porque durate a distribuição pode haver uma difereça de centavos por causa do
		*  arredondamento. Se existe uma diferença, lançamos ela na primeira origem. Porque a primeira? Poderia ser qualquer uma
		*  escolhemos então a primeira.*/
		IF @Acrescimos <> @Acre 
			UPDATE	#tblComposicao
			SET		ValorAcrescimo = ValorAcrescimo + (@Acrescimos - @Acre)
			WHERE	IdDebito = @idDebitoParcela AND IdDebitoOrigemRen = (SELECT	MIN(IdDebitoOrigemRen) 
			     	                                                     FROM	#tblComposicao
			     	                                                     WHERE	IdDebito = @idDebitoParcela)
		/* Agora que temos o valor do acréscimo já dividido entre as origens de forma proporcional e armazenado no 
		* campo ValorAcrescimo jogamos este valor como Juros. Antes esta regra era diferente, utilizava-se o procedimento
		* de atraso para descobrir se iria jogar em Atualização, multa ou juros, e caso o procedimento de atraso não 
		* tivesse nenhum destes valores ele jogava o acréscimo em principal (Aqui que começaram alguns problemas, pois jogar
		* no principal causa efeitos colaterais). Na oc. 96967 alteramos então a forma de distribuição para tratar este
		* erro e ficou acordado que para facilitar a regra sempre jogaremos no campo juros. (Oc. 96967) */	     	                                                     
		UPDATE	#tblComposicao
		SET		ValorEsperadoJuros = ISNULL(ValorEsperadoJuros, 0) + ISNULL(ValorAcrescimo, 0)
		WHERE	IdDebito = @idDebitoParcela  
			
		SELECT @ContParc = MIN(t.Id) FROM #tblValorParc t WHERE id > @ContParc
	END
END

INSERT INTO ComposicoesDebito(IdDebito,IdDebitoOrigemRen,ValorEsperadoPrincipal,ValorEsperadoMulta,ValorEsperadoJuros,
							  ValorEsperadoAtualizacao,IdMoedaValorEsperado,RegistraLog,IdProcedimentoAtraso,ValorDescontoPrincipal)
 
SELECT tc.IdDebito,tc.IdDebitoOrigemRen,tc.ValorEsperadoPrincipal,tc.ValorEsperadoMulta,tc.ValorEsperadoJuros,
       tc.ValorEsperadoAtualizacao,tc.IdMoedaValorEsperado,tc.RegistraLog,tc.IdProcedimentoAtraso,ISNULL(tc.ValorDescontoPrincipal, 0)
FROM   #tblComposicao tc
ORDER BY tc.Id

UPDATE ComposicoesDebito SET RegistraLog = 1 WHERE RegistraLog = 0 

END TRY
/*
IF @teste = 1
BEGIN
	SELECT cd.* FROM ComposicoesDebito cd
	join #tblComposicao t ON t.IdDebito = cd.IdDebito
		
	DROP TABLE #tblComposicao
	DROP TABLE #tblDebOrigem                 
	DROP TABLE #tblValorParc

	ROLLBACK TRAN
END */
BEGIN CATCH
  RAISERROR (@MensagemErro,12,1)
END CATCH
	
