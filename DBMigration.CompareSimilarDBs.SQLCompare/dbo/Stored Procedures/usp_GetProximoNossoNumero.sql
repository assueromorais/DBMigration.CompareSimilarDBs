
CREATE PROCEDURE [dbo].[usp_GetProximoNossoNumero]	
	(
		@IdBanco             INT,
		@IdContaCorrente     INT,
		@IdConvenio          INT,
		@DebitoEmConta       BIT,
		@EmissaoWeb          BIT,
		@NossoNumero         VARCHAR(20) OUTPUT
	)
AS
BEGIN
	DECLARE @CodBanco CHAR(3),
			@Agencia VARCHAR(4),
            @UA VARCHAR(2),
            @ContaCorrente VARCHAR(5),
            @Anoyy VARCHAR(2),
            @ByteGeracao CHAR(1),
            @Sequencial VARCHAR(5),
            @DV CHAR(1)          
       
	SET @CodBanco = '000'
	        	
	SELECT @CodBanco = CodigoBanco
	FROM   BancosSiscafw
	WHERE  IdBancoSiscafw = @IdBanco		
		

	IF @DebitoEmConta = 1 
	BEGIN
		/* Criar validação para o limite máximo de nosso número .... */		
		UPDATE ParametrosSiscafw
		SET SequencialNossoNumeroDebConta = ISNULL(SequencialNossoNumeroDebConta, 0) + 1 		

		SELECT @NossoNumero = SequencialNossoNumeroDebConta
		FROM ParametrosSiscafw
	END
	ELSE
	BEGIN
		IF @EmissaoWeb = 1 AND @CodBanco <> '748'
		BEGIN		
			IF EXISTS(SELECT TOP 1 1 FROM ParametrosSiscafweb WHERE ISNULL(SequencialNossoNumero, InicioNossoNum) + 1 > FimNossoNum)
				RAISERROR ( 'O sequencial do nosso número excedeu o limite.', 11, 0 )	

			UPDATE ParametrosSiscafweb
			SET SequencialNossoNumero = ISNULL(SequencialNossoNumero, InicioNossoNum) + 1     

			SELECT @NossoNumero = SequencialNossoNumero
			FROM ParametrosSiscafweb		      
		END
		ELSE
		BEGIN		
			/*  BANCO DO BRASIL  */		
			IF @CodBanco = '001'
			BEGIN
				/* Criar validação para o limite máximo de nosso número .... */			    
				UPDATE ParametrosSiscafw
				SET    SequencialNossoNumero = ISNULL(SequencialNossoNumero, 0) + 1 		
				
				SELECT @NossoNumero = SequencialNossoNumero
				FROM ParametrosSiscafw
			END		
			/*  CAIXA ECONÔMICA  */				
			ELSE IF @CodBanco = '104'
			BEGIN
				UPDATE ParametrosSiscafw 
				SET    SequencialNossoNumero = ISNULL(SequencialNossoNumero,90100000) + 1	
				
				SELECT @NossoNumero = SequencialNossoNumero
				FROM   ParametrosSiscafw
			END			
			/*  BANRISUL  */		
			ELSE IF @CodBanco = '041'
			BEGIN				
				UPDATE ContasCorrentes 
				SET    SequencialNossoNumero = ISNULL(SequencialNossoNumero, InicioNossoNumero) + 1	
				WHERE  IdBancoSiscafw = @IdBanco 
				  AND  IdContaCorrente = @IdContaCorrente
				  				
				SELECT @NossoNumero = SequencialNossoNumero 
				FROM   ContasCorrentes 
				WHERE  IdBancoSiscafw = @IdBanco 
				 AND   IdContaCorrente = @IdContaCorrente		
			END			
			/* BANCOOB */			
			ELSE IF @CodBanco = '756'
			BEGIN
				IF EXISTS(SELECT TOP 1 1 
				          FROM   ContasCorrentes 
				          WHERE  IdContaCorrente = @IdContaCorrente 
				            AND  CASE WHEN SequencialNossoNumero IS NULL THEN InicioNossoNumero 
								      ELSE SequencialNossoNumero + 1 
								 END > FimNossoNumero)
					RAISERROR ( 'O sequencial do nosso número excedeu o limite.', 11, 0 )	
		
				UPDATE ContasCorrentes
				SET SequencialNossoNumero = CASE WHEN SequencialNossoNumero IS NULL THEN InicioNossoNumero 
										         ELSE SequencialNossoNumero + 1 
									        END
				WHERE  IdContaCorrente = @IdContaCorrente	
								
				SELECT @NossoNumero = SequencialNossoNumero
				FROM   ContasCorrentes 
				WHERE  IdContaCorrente = @IdContaCorrente					
			END				
			/* SICREDI */
			ELSE IF @CodBanco = '748'
			BEGIN		
				IF EXISTS(SELECT TOP 1 1 
				          FROM   ContasCorrentes
					      WHERE  IdBancoSiscafw = @IdBanco 
				            AND  IdContaCorrente = @IdContaCorrente
				            AND  RIGHT(ISNULL(SequencialNossoNumero, 0),5)  = '99999' 
				            AND  ByteGeracao = 9 )	
					RAISERROR ( 'O sequencial do nosso número excedeu o limite.', 11, 0 )
				
				UPDATE ContasCorrentes 
			       SET SequencialNossoNumero = CASE WHEN RIGHT(ISNULL(SequencialNossoNumero, 0),5) = '99999' AND ByteGeracao < 9 THEN '00001' 
			                                        ELSE RIGHT(ISNULL(SequencialNossoNumero, 0) + 1,5) 
			                                   END, 
					   ByteGeracao = CASE WHEN RIGHT(ISNULL(SequencialNossoNumero, 0),5) = '99999' AND ByteGeracao < 9 THEN ISNULL(ByteGeracao,2) + 1
			                              ELSE ByteGeracao
			                         END
				 WHERE IdBancoSiscafw = @IdBanco 
				   AND IdContaCorrente = @IdContaCorrente				
				
				SELECT  @Agencia=RIGHT(REPLICATE('0', 4) + CAST(CodigoAgencia AS VARCHAR),4),
                        @UA = RIGHT(REPLICATE('0', 2) + CAST(DVAgencia AS VARCHAR),2),
                        @ContaCorrente = RIGHT(REPLICATE('0', 5) + CAST(ContaCorrente AS VARCHAR),5),
                        @Anoyy= LEFT((CONVERT(varchar(6), GETDATE(), 12)),2), 
                        @ByteGeracao = ByteGeracao,
                        @Sequencial = RIGHT(Replicate('0',5) + CAST(ISNULL(SequencialNossoNumero, 0) AS VARCHAR(6)), 5)
				FROM ContasCorrentes 
				WHERE IdBancoSiscafw = @IdBanco 
				  AND IdContaCorrente = @IdContaCorrente
				
				SELECT @DV = dbo.ufn_CalcularModulo11(@Agencia + @UA + @ContaCorrente + @Anoyy + @ByteGeracao + @Sequencial)		     			    		    		    
			END		
			/* BRADESCO */
			ELSE IF @CodBanco = '237'
			BEGIN				
				UPDATE ContasCorrentes 
				SET    SequencialNossoNumero = ISNULL(SequencialNossoNumero, 0) + 1	
				WHERE  IdContaCorrente = @IdContaCorrente

				SELECT @NossoNumero = SequencialNossoNumero 
				FROM   ContasCorrentes 
				WHERE  IdContaCorrente = @IdContaCorrente		
			END	
		END	
	END
	
	/* Formata o Nosso Número */	
	IF @DebitoEmConta = 1
	BEGIN
		SELECT @NossoNumero = 'DC' + RIGHT( REPLICATE('0',10) + @NossoNumero, 10)		
	END
	ELSE
	BEGIN
		/*  BANCO DO BRASIL  */			
		IF @CodBanco = '001'
		BEGIN		
			/* Convênio de 4 posições */
			IF (SELECT LEN(CodConvenio) FROM Convenios WHERE IdConvenio = @IdConvenio) = 4 
			BEGIN
				SELECT @NossoNumero = CodConvenio + RIGHT( REPLICATE('0',7) + @NossoNumero, 7) 
				FROM   Convenios 
				WHERE  IdConvenio = @IdConvenio	
			END
			/* Convênio de 6 posições */
			ELSE IF (SELECT LEN(CodConvenio) FROM Convenios WHERE IdConvenio = @IdConvenio) = 6 
			BEGIN
				SELECT @NossoNumero = CodConvenio + RIGHT( REPLICATE('0',5) + @NossoNumero, 5) 
				FROM   Convenios 
				WHERE  IdConvenio = @IdConvenio	
			END
			/* Convênio de 7 posições */
			ELSE IF (SELECT LEN(CodConvenio) FROM Convenios WHERE IdConvenio = @IdConvenio) = 7
			BEGIN
				SELECT @NossoNumero = CodConvenio + RIGHT( REPLICATE('0',10) + @NossoNumero, 10)
				FROM   Convenios 
				WHERE  IdConvenio = @IdConvenio			
			END				
		END	
		/*  CAIXA ECONÔMICA  */			
		ELSE IF @CodBanco = '104'
		BEGIN 
			SELECT @NossoNumero = ISNULL((SELECT CodigoCarteiraCobranca FROM Convenios WHERE IdConvenio = @IdConvenio),'') + RIGHT( REPLICATE('0',15) + @NossoNumero, 15)
		END		
		/* BANRISUL */
		ELSE IF @CodBanco = '041'
		BEGIN
			SELECT @NossoNumero =  RIGHT( REPLICATE('0',8) + @NossoNumero, 8)
		END 	
		/* BANCOOB */	
		ELSE IF @CodBanco = '756'
		BEGIN
			SELECT @NossoNumero = RIGHT( REPLICATE('0',7) + @NossoNumero, 7 )	
		END			
		/* SICREDI  */
		ELSE IF @CodBanco = '748'
		BEGIN
			SELECT @NossoNumero =  (@Anoyy + @ByteGeracao + RIGHT( REPLICATE('0',5) + @Sequencial, 5 )	 + @DV)
		END 		
		/* BRADESCO */
		ELSE IF @CodBanco = '237'
		BEGIN
			SELECT @NossoNumero =  RIGHT( REPLICATE('0',11) + @NossoNumero, 11)
		END  
	END
END	
