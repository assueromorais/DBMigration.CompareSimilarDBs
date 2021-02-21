
CREATE FUNCTION dbo.ufn_GetDebitosAtualizados
(
	@Debitos VARCHAR(MAX),
	@DataAtualizacao DATETIME,
	@IdProcedimentoAtraso INT
)
RETURNS @Result TABLE ( IdDebito INT,
                        IdProcedimentoAtraso INT,
                        ValorDevido NUMERIC(10,2),
                        ValorAtualizacao NUMERIC(10,2),
                        ValorMulta NUMERIC(10,2),
                        ValorJuros NUMERIC(10,2),
						ValorTotal NUMERIC(10,2),
                        CodErro INT )
BEGIN
	INSERT INTO @Result ( IdDebito ) 
	SELECT ID
	FROM   dbo.ufn_SplitID( @Debitos )
	
	DECLARE @IdDebito            INT,
	        @DataVencimento      DATETIME,
	        @DataAtualizacaoCalc DATETIME,
	        @ValorDevido         NUMERIC(10,2),
	        @PessoaFisica        INT,
	        @IdTipoDebito        INT,
	        @IdMoeda             INT,
	        @IdSituacao          INT
	        	
	SELECT @IdDebito = MIN(IdDebito) 
	FROM   @Result
	
	WHILE @IdDebito IS NOT NULL
	BEGIN		
		SELECT @DataVencimento      = DataVencimento,
		       @DataAtualizacaoCalc = CASE WHEN @DataAtualizacao IS NOT NULL THEN @DataAtualizacao
		                                   ELSE DataVencimento
		                              END, 
	           @ValorDevido         = ValorDevido,
	           @PessoaFisica        = CASE WHEN IdPessoaJuridica IS NOT NULL THEN 0
	                                       WHEN IdProfissional   IS NOT NULL THEN 1
	                                       ELSE 2
	                                  END,
	           @IdTipoDebito        = IdTipoDebito,
	           @IdMoeda             = IdMoeda,
	           @IdSituacao          = IdSituacaoAtual
		FROM   Debitos 
		WHERE  IdDebito = @IdDebito
		
		UPDATE r 
		SET    r.ValorDevido          = ISNULL(ada.ValorTotal, 0) -  
		                                ISNULL(ada.Atualizacao, 0) - 
		                                ISNULL(ada.Multa, 0) - 
		                                ISNULL(ada.Juros, 0),
			   r.ValorAtualizacao     = ISNULL(ada.Atualizacao, 0),
               r.ValorMulta           = ISNULL(ada.Multa, 0),
               r.ValorJuros           = ISNULL(ada.Juros, 0),
               r.ValorTotal           = ISNULL(ada.ValorTotal, 0),
			   r.IdProcedimentoAtraso = ada.IdProcedimento,
			   r.CodErro              = ada.CodErro		
		FROM   @Result r,
		       dbo.AtualizaDebitosAll(
		           @DataVencimento,
		           @DataAtualizacaoCalc,
		           @ValorDevido,
		           @PessoaFisica,
		           @IdTipoDebito,
		           @IdMoeda,
		           @IdProcedimentoAtraso,
		           @IdDebito,
		           @IdSituacao
		       ) AS ada
		WHERE r.IdDebito = @IdDebito
		
		SELECT @IdDebito = MIN(IdDebito) 
		FROM   @Result
		WHERE  IdDebito > @IdDebito 
	END	
	
	RETURN
END
