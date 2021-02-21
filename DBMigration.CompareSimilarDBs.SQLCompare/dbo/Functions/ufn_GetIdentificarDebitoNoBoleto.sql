

CREATE FUNCTION dbo.ufn_GetIdentificarDebitoNoBoleto
(
	@IdDetalheEmissao INT
)
RETURNS VARCHAR(1000)
AS
BEGIN
	DECLARE @Debitos      VARCHAR(1000),
	        @ModoResumido BIT  
	
	DECLARE @Temp TABLE (
	            Parcela VARCHAR(100),
	            Sigla VARCHAR(2000),
	            RenRec BIT,
	            NumConj VARCHAR(100),
	            Linha VARCHAR(100)
	        )
		
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
		
		SELECT @Debitos = REPLACE(  
					REPLACE(  
						(  
							SELECT CASE   
										WHEN ce.NumeroParcela = 0 THEN 'C.Única '  
										ELSE CAST(ce.NumeroParcela AS VARCHAR(2)) + 'ª Parc.'  
									END  
									+ ce.Sigladebito + '/' + CAST(YEAR(d.DataReferencia) AS VARCHAR(4))   
									+ ISNULL(  
											CASE   
												WHEN d.IdTipoDebito IN (2, 10) THEN   
													' (Ref.: ' +  
                                           				DBO.ufn_GetRetornarDebitoNoBoleto(d.IdProfissional, d.IdPessoaJuridica, d.IdPessoa, d.NumConjReneg , d.IdDebito) 
													+ ')'  
												ELSE ''  
											END,  
											''  
										)  
							FROM   DetalhesEmissao de  
									JOIN ComposicoesEmissao ce  
										ON  ce.IdDetalheEmissao = de.IdDetalheEmissao  
									JOIN Debitos AS d  
										ON  d.IdDebito = ce.IdDebito  
									LEFT JOIN TiposDebito AS td  
										ON  td.IdTipoDebito = d.IdTipoDebito  
							WHERE ce.IdDetalheEmissao = @IdDetalheEmissao  
							ORDER BY ce.Sigladebito, YEAR(d.DataReferencia), d.NumeroParcela  
											FOR XML PATH  
						),  
						'<row>',  
						''  
					),  
					'</row>',  
					CHAR(13)+CHAR(10)  
				)      		
				
	END
	ELSE
	BEGIN
	
		INSERT INTO @Temp
		  (
			Parcela,
			Sigla,
			RenRec,
			NumConj,
			Linha
		  )
		SELECT CASE 
					WHEN ce.NumeroParcela = 0 THEN ''
					ELSE CAST(ce.NumeroParcela AS VARCHAR(2)) + 'ª'
			   END Parcela,
			   ce.Sigladebito + '/' + CAST(YEAR(d.DataReferencia) AS VARCHAR(4)) 
			   + ISNULL(
				   CASE 
						WHEN d.IdTipoDebito IN (2, 10) THEN ' (ref.: ' +
							 DBO.ufn_GetRetornarDebitoNoBoleto(
								 d.IdProfissional,
								 d.IdPessoaJuridica,
								 d.IdPessoa,
								 d.NumConjReneg,
								 d.IdDebito
							 ) 
							 + ')'
						ELSE ''
				   END,
				   ''
			   ) + '; ' Sigla,
			   CASE WHEN d.IdTipoDebito IN (2,10) THEN 1 ELSE 0 END,
			   CAST(YEAR(d.DataReferencia) AS VARCHAR) + CAST(td.IdTipoDebito AS VARCHAR) 
			   + CAST(ISNULL(d.numconjtpdebito, '') AS VARCHAR) + CAST(ISNULL(d.numconjreneg, '') AS VARCHAR) NumConj,
			   ROW_NUMBER() OVER(
				   ORDER BY YEAR(d.DataReferencia),
				   td.IdTipoDebito,
				   COALESCE(d.numconjtpdebito, d.numconjreneg, ''),
				   d.NumeroParcela
			   ) Linha
		FROM   DetalhesEmissao de
			   JOIN ComposicoesEmissao ce
					ON  ce.IdDetalheEmissao = de.IdDetalheEmissao
			   JOIN Debitos           AS d
					ON  d.IdDebito = ce.IdDebito
			   LEFT JOIN TiposDebito  AS td
					ON  td.IdTipoDebito = d.IdTipoDebito
		WHERE  ce.IdDetalheEmissao = @IdDetalheEmissao
		ORDER BY
			   ce.Sigladebito,
			   YEAR(d.DataReferencia),
			   d.NumeroParcela 
	
		SELECT @Debitos = REPLACE(
				   REPLACE(
					   (
						   SELECT CASE 
									   WHEN t1.Parcela = '' THEN '' + t1.Sigla
									   WHEN t1.RenRec = 1 THEN t1.Parcela + ' parc. ' + t1.Sigla
									   ELSE CASE 
												 WHEN t1.NumConj = t2.NumConj THEN 
	                                         		  CASE WHEN t1.NumConj = t3.NumConj THEN t1.Parcela + ', '
	                                         			   ELSE t1.Parcela + ' e '
	                                         		  END
												 ELSE t1.Parcela + ' parc. ' + t1.Sigla
											END
								  END
						   FROM   @Temp t1
								  LEFT JOIN @Temp t2
									   ON  t1.linha = t2.linha - 1
								  LEFT JOIN @Temp t3
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
