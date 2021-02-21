
CREATE FUNCTION ufn_GetIndicarDebitosEmAberto (@IdDetalheEmissao INT)
	RETURNS VARCHAR(1000)
AS
BEGIN
	/*
	* Parte 1 - Identifica o Tipo de Pessoa e o ID da pessoa
	* */
	DECLARE @TipoPessoa TINYINT,
			@IdPessoa   INT

	SELECT @TipoPessoa = CASE 
	                          WHEN e.IdPessoaJuridica IS NOT NULL THEN 0
	                          WHEN e.IdProfissional   IS NOT NULL THEN 1
	                          WHEN e.IdPessoa         IS NOT NULL THEN 2
	                          ELSE -1
	                     END,
			@IdPessoa = CASE 
							WHEN e.IdPessoaJuridica IS NOT NULL THEN e.IdPessoaJuridica
							WHEN e.IdProfissional   IS NOT NULL THEN e.IdProfissional
							WHEN e.IdPessoa         IS NOT NULL THEN e.IdPessoa
							ELSE -1
						END
	FROM   DetalhesEmissao de
			JOIN Emissoes e ON e.IdEmissao = de.IdEmissao
	WHERE  de.IdDetalheEmissao = @IdDetalheEmissao  
	
	
	/*
	* Parte 2 - Identificando os débitos
	* */
	
	DECLARE @Temp TABLE ( IdDebito         INT,
                          Conjunto         VARCHAR(20),
                          TemParcela       BIT,
                          NPossuiCotaUnica BIT,
                          Emissao          BIT )	
	
	-- Pessoa Jurídica
	IF @TipoPessoa = 0
		INSERT INTO @Temp ( IdDebito, Conjunto, TemParcela, NPossuiCotaUnica )
		SELECT IdDebito,
			   RIGHT(
					REPLICATE('0', 14) + CASE 
												WHEN IdTipoDebito = 1 THEN '0'
												WHEN IdTipoDebito IN (2, 10) THEN CAST(NumConjReneg AS VARCHAR)
												ELSE CAST(NumConjTpDebito AS VARCHAR)
										END, 14) +
			   CAST(YEAR(DataReferencia) AS VARCHAR(4)) +
			   RIGHT('00' + CAST(IdTipoDebito AS VARCHAR), 2),
			   CASE WHEN NumeroParcela > 0 THEN 1 ELSE 0 END,
			   NPossuiCotaUnica
		FROM   Debitos
		WHERE  IdPessoaJuridica = @IdPessoa
	      AND  IdSituacaoAtual IN (1, 3, 10, 15)
           
    -- Profissional
	ELSE IF @TipoPessoa = 1           
		INSERT INTO @Temp ( IdDebito, Conjunto, TemParcela, NPossuiCotaUnica )
		SELECT IdDebito,
			   RIGHT(
					REPLICATE('0', 14) + CASE 
												WHEN IdTipoDebito = 1 THEN '0'
												WHEN IdTipoDebito IN (2, 10) THEN CAST(NumConjReneg AS VARCHAR)
												ELSE CAST(NumConjTpDebito AS VARCHAR)
										END, 14) +
			   CAST(YEAR(DataReferencia) AS VARCHAR(4)) +
			   RIGHT('00' + CAST(IdTipoDebito AS VARCHAR), 2),
			   CASE WHEN NumeroParcela > 0 THEN 1 ELSE 0 END,
			   NPossuiCotaUnica
		FROM   Debitos
		WHERE  IdProfissional = @IdPessoa
		  AND  IdSituacaoAtual IN (1, 3, 10, 15)
           
    -- Outras Pessoas
	ELSE IF @TipoPessoa = 2           
		INSERT INTO @Temp ( IdDebito, Conjunto, TemParcela, NPossuiCotaUnica )
		SELECT IdDebito,
				RIGHT(
					REPLICATE('0', 14) + CASE 
												WHEN IdTipoDebito = 1 THEN '0'
												WHEN IdTipoDebito IN (2, 10) THEN CAST(NumConjReneg AS VARCHAR)
												ELSE CAST(NumConjTpDebito AS VARCHAR)
										END, 14) +
				CAST(YEAR(DataReferencia) AS VARCHAR(4)) +
				RIGHT('00' + CAST(IdTipoDebito AS VARCHAR), 2),
				CASE WHEN NumeroParcela > 0 THEN 1 ELSE 0 END,
			   NPossuiCotaUnica
		FROM   Debitos
		WHERE  IdPessoa = @IdPessoa
		  AND  IdSituacaoAtual IN (1, 3, 10, 15)				
								           
	UPDATE @Temp
	SET    Emissao = 1
	WHERE  IdDebito IN (SELECT IdDebito
						FROM   ComposicoesEmissao
						WHERE  IdDetalheEmissao = @IdDetalheEmissao)   
				
	DELETE T1
	FROM   @Temp T1
	WHERE  T1.NPossuiCotaUnica = 0
      AND  T1.TemParcela = 1
      AND  NOT EXISTS(SELECT TOP 1 1 
                      FROM   @Temp T2 
                      WHERE  T1.Conjunto = T2.Conjunto 
                        AND  T2.Emissao = 1)
  	
	DELETE T1
	FROM   @Temp T1
		   JOIN @Temp T2 ON T1.Conjunto = T2.Conjunto
	WHERE  T2.Emissao = 1
      AND  T2.TemParcela <> T1.TemParcela            
	  				
	DELETE 
	FROM   @Temp
	WHERE  Emissao = 1  	
	
	
	/*
	* Parte 3 - Listar os débito que com a descrição e na ordem correta
	* */

	DECLARE @ListaDebitos TABLE ( Ordem          TINYINT IDENTITY(1,1),
								  Descricao      VARCHAR(1000), 
								  DebitoVencido  BIT )
								  
	DECLARE @Msg                   VARCHAR(1000), 
	        @ListaDebitosDescricao VARCHAR(1000)			
			
	INSERT INTO @ListaDebitos( Descricao, DebitoVencido )
	SELECT CASE WHEN d.NumeroParcela = 0 THEN 'C.Única '
			    ELSE CAST(d.NumeroParcela AS VARCHAR(2)) + 'ª Parc.'
		   END + td.Sigladebito + '/' + CAST(YEAR(d.DataReferencia) AS VARCHAR(4)) + '                    ',
		   CASE WHEN d.DataVencimento < CAST(CONVERT(VARCHAR(8), GETDATE(), 112) AS DATETIME) THEN 1 
		        ELSE 0 
		   END              
	FROM   Debitos d
	       JOIN TiposDebito td ON td.IdTipoDebito = d.IdTipoDebito
	       JOIN @Temp t ON t.IdDebito = d.IdDebito
	ORDER BY YEAR(d.DataReferencia) DESC,
	         d.IdTipoDebito,
		     COALESCE(d.NumConjTpDebito, d.NumConjReneg, 0),
		     d.NumeroParcela			
		
	/*
	* Parte 4 - Gerar as mensagens
	* */
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM @ListaDebitos)
	   SET @Msg = ' * * * Não constam débitos em aberto * * * ' 		
	ELSE
	BEGIN
		SELECT @ListaDebitosDescricao = REPLACE( 
			                                REPLACE( 
			                                	      (SELECT descricao 
			                                	       FROM   @ListaDebitos 
			                                	       ORDER BY Ordem
			                                	       FOR XML PATH), 
			                                	    '<row><descricao>','' ), 
			                                	'</descricao></row>', 
			                            CHAR(13)+CHAR(10))				
		
		IF EXISTS (SELECT TOP 1 1 FROM @ListaDebitos WHERE DebitoVencido = 1)
		BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM @ListaDebitos WHERE DebitoVencido = 0)
				SET @Msg = ' * * * Constam débitos em aberto vencidos e a vencer * * * ' + CHAR(13)+CHAR(10) + @ListaDebitosDescricao
			ELSE	
				SET @Msg = ' * * * Constam débitos em aberto vencidos * * * ' + CHAR(13)+CHAR(10) + @ListaDebitosDescricao
		END 	
		ELSE
			SET @Msg = ' * * * Constam débitos em aberto a vencer * * * ' + CHAR(13)+CHAR(10) + @ListaDebitosDescricao						 	
	END

	RETURN @Msg 
END
