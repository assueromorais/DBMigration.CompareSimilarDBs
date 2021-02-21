
CREATE FUNCTION dbo.ufn_GetRetornarDebitoNoBoleto
(
	@IdProfissional       INT,
	@IdPessoaJuridica     INT,
	@IdPessoa             INT,
	@NumConjReneg         INT,
	@IdDebito             INT
)
RETURNS VARCHAR(1000)
AS
BEGIN
	DECLARE @Debitos      VARCHAR(1000), 
	        @Todos        INT,
	        @ModoResumido BIT
	
	DECLARE @Temp TABLE (
		        Ano INT,
	            Parcela VARCHAR(100),
	            Sigla VARCHAR(100),
	            NumConj VARCHAR(100),
	            IdDebito INT
	)
	
	DECLARE @Resumo TABLE (
		        Ano INT,
	            Parcela VARCHAR(100),
	            Sigla VARCHAR(100),
	            NumConj VARCHAR(100),
	            Linha VARCHAR(100)
	)	
	
	SELECT @Todos = CASE (
	                         SELECT 1
	                         FROM   AppConfig AS ac
	                         WHERE  ac.Chave = 
	                                'MOSTRAR_TODOS_DEBITOS_REN_REC_MSG_BOLETO'
	                                AND ac.Valor = '1'
	                     )
	                     WHEN 1 THEN 1
	                     ELSE 0
	                END;
	
	IF @Todos = 1
	    SET @IdDebito = 0; -- E utilizado exclusivamente para trazer as composições do débito atual, caso não seja passado traz todos os débitos de origem da ren/rec
	
	SELECT @ModoResumido = ISNULL((SELECT Valor FROM AppConfig WHERE CHave = 'IDENTIFICAR_DEBITOS_MODO_RESUMIDO'), 1)
	
	/*
	* Na oc.: 204177 foi solicitada a alteração na formatação dos débitos quando utilizada a opção "Identificar débito no boleto".
	* 
	* A nova formatação (ativada pelo ModoResumido) exibe os débitos de forma resumida, unindo parcelas, desta forma: 
	*		1ª, 2ª, 3ª, e 4ª parc. ANU/2018; FS/2018
	*		
	* Já no formato "anterior" este mesmo exemplo ficaria assim:  
	*		1ª parc.ANU/2018
	*		2ª parc.ANU/2018
	*		3ª parc.ANU/2018
	*		4ª parc.ANU/2018
	*		C.Única - Fundo de Seção/2018
	*		
	* Conforme conversado com Raimundo, iremos permitir através da uma FLAG na AppConfig que o conselho possa caso queira 
	* deixar a exibição conforme o modo anterior, por isso a criação do FLAG "IDENTIFICAR_DEBITOS_MODO_RESUMIDO".
	* 
	* Caso não exista a FLAG "IDENTIFICAR_DEBITOS_MODO_RESUMIDO" o sistema irá utilizar a formatação Resumida,
	* como se esta FLAG existisse e estivesse ativada, ou seja, o modo resumido foi definido como padrão.
	* */
	
	IF @ModoResumido = 0 
	BEGIN
		
		SELECT @Debitos =  
			REPLACE(  
						REPLACE(  
							(  
									SELECT 
									CASE dOrig.NumeroParcela  
										WHEN 0 THEN 'C.Única '  
										ELSE CAST(dOrig.NumeroParcela AS VARCHAR(2))   
												+  
												'ª parc. '  
									END  
									+ '- ' + td.NomeDebito   
									+ '/' + CAST(YEAR(dOrig.DataReferencia) AS VARCHAR(4)) + ', '   
									FROM Debitos AS dOrig 
									LEFT JOIN TiposDebito AS td ON  td.IdTipoDebito = dOrig.IdTipoDebito  
									WHERE (ISNULL(@IdProfissional,0) = 0 OR dOrig.IdProfissional = @IdProfissional) 
									AND (ISNULL(@IdPessoaJuridica,0) = 0 OR dOrig.IdPessoaJuridica = @IdPessoaJuridica) 
									AND (ISNULL(@IdPessoa,0) = 0 OR dOrig.IdPessoa = @IdPessoa) 
									AND (IdSituacaoAtual = 6 OR IdSituacaoAtual = 14) 
									AND dOrig.NumConjReneg = @NumConjReneg
									AND (ISNULL(@IdDebito,0) = 0 OR dOrig.IdDebito IN ( SELECT IdDebitoOrigemRen FROM ComposicoesDebito WHERE IdDebito = @IdDebito) )  
									ORDER BY td.Sigladebito, YEAR(dOrig.DataReferencia), dOrig.NumeroParcela  
								FOR XML PATH  
							),  
							'<row>',  
							''  
						),  
						'</row>',  
						''
					)  			
					
	END
	ELSE
	BEGIN
		IF @IdProfissional IS NOT NULL
		BEGIN
			INSERT INTO @Temp
			  (
			  	Ano,
				Parcela,
				Sigla,
				NumConj,
				IdDebito
			  )
			SELECT YEAR(dOrig.DataReferencia),
			       CASE dOrig.NumeroParcela
						WHEN 0 THEN ''
						ELSE CAST(dOrig.NumeroParcela AS VARCHAR(2)) + 'ª'
				   END Parcela,
				   td.SiglaDebito + '/' + CAST(YEAR(dOrig.DataReferencia) AS VARCHAR(4)) + '; ' Sigla,
				   CAST(YEAR(dOrig.DataReferencia) AS VARCHAR) + CAST(td.IdTipoDebito AS VARCHAR) + CAST(ISNULL(NumConjTpDebito, '') AS VARCHAR) + CAST(ISNULL(NumConjReneg, '') AS VARCHAR) NumConj,
				   cd.IdDebito
			FROM   Debitos dOrig
				   JOIN ComposicoesDebito cd ON cd.IdDebitoOrigemRen = dOrig.IdDebito
				   LEFT JOIN TiposDebito td  ON td.IdTipoDebito = dOrig.IdTipoDebito
			WHERE  dOrig.IdProfissional = @IdProfissional
				   AND IdSituacaoAtual IN ( 6, 14 )
				   AND dOrig.NumConjReneg = @NumConjReneg
			ORDER BY
					YEAR(dOrig.DataReferencia),
					td.IdTipoDebito,
					ISNULL(numconjtpdebito,''),
					ISNULL(numconjreneg, ''),
					dOrig.NumeroParcela 
		END
		ELSE IF @IdPessoaJuridica IS NOT NULL
		BEGIN
			INSERT INTO @Temp
			  (
			  	Ano,
				Parcela,
				Sigla,
				NumConj,
				IdDebito
			  )
			SELECT YEAR(dOrig.DataReferencia),
			       CASE dOrig.NumeroParcela
						WHEN 0 THEN ''
						ELSE CAST(dOrig.NumeroParcela AS VARCHAR(2)) + 'ª'
				   END Parcela,
				   td.SiglaDebito + '/' + CAST(YEAR(dOrig.DataReferencia) AS VARCHAR(4)) + '; ' Sigla,
				   CAST(YEAR(dOrig.DataReferencia) AS VARCHAR) + CAST(td.IdTipoDebito AS VARCHAR) + CAST(ISNULL(NumConjTpDebito, '') AS VARCHAR) + CAST(ISNULL(NumConjReneg, '') AS VARCHAR) NumConj,
				   cd.IdDebito
			FROM   Debitos dOrig
				   JOIN ComposicoesDebito cd ON cd.IdDebitoOrigemRen = dOrig.IdDebito
				   LEFT JOIN TiposDebito td  ON td.IdTipoDebito = dOrig.IdTipoDebito
			WHERE  dOrig.IdPessoaJuridica = @IdPessoaJuridica
				   AND IdSituacaoAtual IN ( 6, 14 )
				   AND dOrig.NumConjReneg = @NumConjReneg
			ORDER BY
					YEAR(dOrig.DataReferencia),
					td.IdTipoDebito,
					ISNULL(numconjtpdebito,''),
					ISNULL(numconjreneg, ''),
					dOrig.NumeroParcela			
		END 
		ELSE IF @IdPessoa IS NOT NULL
		BEGIN
			INSERT INTO @Temp
			  (
			  	Ano,
				Parcela,
				Sigla,
				NumConj,
				IdDebito
			  )
			SELECT YEAR(dOrig.DataReferencia),
			       CASE dOrig.NumeroParcela
						WHEN 0 THEN ''
						ELSE CAST(dOrig.NumeroParcela AS VARCHAR(2)) + 'ª'
				   END Parcela,
				   td.SiglaDebito + '/' + CAST(YEAR(dOrig.DataReferencia) AS VARCHAR(4)) + '; ' Sigla,
				   CAST(YEAR(dOrig.DataReferencia) AS VARCHAR) + CAST(td.IdTipoDebito AS VARCHAR) + CAST(ISNULL(NumConjTpDebito, '') AS VARCHAR) + CAST(ISNULL(NumConjReneg, '') AS VARCHAR) NumConj,
				   cd.IdDebito
			FROM   Debitos dOrig
				   JOIN ComposicoesDebito cd ON cd.IdDebitoOrigemRen = dOrig.IdDebito
				   LEFT JOIN TiposDebito td  ON td.IdTipoDebito = dOrig.IdTipoDebito
			WHERE  dOrig.IdPessoa = @IdPessoa
				   AND IdSituacaoAtual IN ( 6, 14 )
				   AND dOrig.NumConjReneg = @NumConjReneg
			ORDER BY
					YEAR(dOrig.DataReferencia),
					td.IdTipoDebito,
					ISNULL(numconjtpdebito,''),
					ISNULL(numconjreneg, ''),
					dOrig.NumeroParcela			
		END
				
		IF @Todos = 0
		    DELETE FROM @Temp WHERE IdDebito <> @IdDebito
		    
		INSERT INTO @Resumo ( Ano, Parcela, Sigla, NumConj, Linha ) 
		SELECT tmp.Ano, tmp.Parcela, tmp.Sigla, tmp.NumConj, ROW_NUMBER() OVER(ORDER BY tmp.Ano, tmp.Sigla, tmp.Parcela, tmp.NumConj) 
		FROM (SELECT DISTINCT Ano, Parcela, Sigla, NumConj FROM @Temp) tmp		    
		
		SELECT @Debitos = REPLACE(
				   REPLACE(
					   (
						   SELECT CASE 
									   WHEN t1.Parcela = '' THEN '' + t1.Sigla
									   ELSE CASE 
												 WHEN t1.NumConj = t2.NumConj THEN 
	                                         		  CASE WHEN t1.NumConj = t3.NumConj THEN t1.Parcela + ', '
	                                         			   ELSE t1.Parcela + ' e '
	                                         		  END
												 ELSE t1.Parcela + ' parc. ' +
													  t1.Sigla
											END
								  END
						   FROM   @Resumo t1
								  LEFT JOIN @Resumo t2
									   ON  t1.linha = t2.linha - 1
								  LEFT JOIN @Resumo t3
									   ON  t1.linha = t3.linha - 2
						   FOR XML PATH
					   ),
					   '<row>',
					   ''
				   ),
				   '</row>',
				   ''
		)
		
	END
	
	RETURN SUBSTRING(@Debitos, 1, LEN(@Debitos) - 1)
END  
