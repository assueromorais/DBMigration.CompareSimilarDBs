/* OC.229066
* Criado por Robson
* 
*/

CREATE PROCEDURE [dbo].[SP_DadosEleicaoCFP]
	@Regional VARCHAR(10),
	@Usuario VARCHAR(30),
	@Departamento VARCHAR(60),
	@DataGeracao DATETIME
AS
	SET NOCOUNT ON 
	DECLARE @idHistArqEleicao  INT,
	        @SiglaUF_Regional  VARCHAR(2)
	
	SELECT @SiglaUF_Regional = SiglaUf
	FROM   Pessoas,
	       ParametrosSiscafW
	WHERE  E_ConselhoProfissao = 1
	       AND IdPessoa = IdConselhoCorrente 
	
	-- Cria o histórico de arquivo de eleição
	INSERT INTO HistArqEleicao ( DataGeracao,
	       Regional,
	       Usuario,
	       Departamento )
	SELECT @DataGeracao,
	       @Regional,
	       @Usuario,
	       @Departamento
	
	SET @idHistArqEleicao = (
	        SELECT SCOPE_IDENTITY()
	    )
	
	-- Cria cursor com todos os profissionais existentes na base de dados
	-- Nos casos 
	IF (@Regional = 'CRP20')
	    -- CRPAM
	    
	    INSERT INTO histarqeleicaoprof
		(  
		 IdHistArqEleicao,  
		 IdProfissional,  
		 Nome,  
		 Registro,  
		 CPF,  
		 DataNascimento,  
		 AnoInscricao,  
		 NomeMae,  
		 RG,  
		 SiglaUF,  
		 Cidade,  
		 Bairro,  
		 Endereco,  
		 CEP,  
		 Naturalidade,
		 NomePai,
		 EMail,  
		 EMailAlternativo,  
		 EnderecoAtualizado,  
		 Situacao,  
		 TelefoneCelular,  
		 TelefoneTodos  
		)  	    	    
	    SELECT @idHistArqEleicao,
	           IdProfissional,
	           Nome,
               SUBSTRING(@Regional, 4, 2) + '/' + dbo.RetiraZero(RegistroConselhoAtual),	           
	           CPF,
	           DataNascimento,
	           YEAR(DataInscricaoConselho) AS AnoInscricao,
	           NomeMae,
	           RG,
	           SiglaUF,
	           NomeCidade,
	           NomeBairro,
	           Endereco,
	           CEP,
               (SELECT NomeCidade FROM Cidades AS c WHERE c.IdCidade = idcidadeNaturalidade),
			   NomePai,	           	           
	           EnderecoEMail,
	           EnderecoEMail2,
	           Atualizado,
	           NULL,
               dbo.FormataTelefoneCelular_UNICO(ISNULL(SiglaUF, @SiglaUF_Regional), TelefoneCelular),
	           dbo.FormataTelefoneFixo_UNICO(ISNULL(SiglaUF, @SiglaUF_Regional), TelefoneResid)
	    FROM   profissionais
	    WHERE  EXISTS (
	               SELECT 1
	               FROM   enderecos e
	               WHERE  e.IdProfissional = profissionais.IdProfissional
	                      AND  e.Correspondencia = 1
	                      AND e.SiglaUf IN ('AM', 'RR')
	    ) ORDER BY
	        nome	           	          	                
	           
	ELSE            
	IF (@Regional = 'CRP24')
	    
	    INSERT INTO histarqeleicaoprof
		(  
		 IdHistArqEleicao,  
		 IdProfissional,  
		 Nome,  
		 Registro,  
		 CPF,  
		 DataNascimento,  
		 AnoInscricao,  
		 NomeMae,  
		 RG,  
		 SiglaUF,  
		 Cidade,  
		 Bairro,  
		 Endereco,  
		 CEP,  
		 Naturalidade,
		 NomePai,
		 EMail,  
		 EMailAlternativo,  
		 EnderecoAtualizado,  
		 Situacao,  
		 TelefoneCelular,  
		 TelefoneTodos  
		)  	    	    
	    SELECT @idHistArqEleicao,
	           IdProfissional,
	           Nome,
               SUBSTRING(@Regional, 4, 2) + '/' + dbo.RetiraZero(RegistroConselhoAtual),	           
	           CPF,
	           DataNascimento,
	           YEAR(DataInscricaoConselho) AS AnoInscricao,
	           NomeMae,
	           RG,
	           SiglaUF,
	           NomeCidade,
	           NomeBairro,
	           Endereco,
	           CEP,
               (SELECT NomeCidade FROM Cidades AS c WHERE c.IdCidade = idcidadeNaturalidade),
			   NomePai,	           	           
	           EnderecoEMail,
	           EnderecoEMail2,
	           Atualizado,
	           NULL,
               dbo.FormataTelefoneCelular_UNICO(ISNULL(SiglaUF, @SiglaUF_Regional), TelefoneCelular),
	           dbo.FormataTelefoneFixo_UNICO(ISNULL(SiglaUF, @SiglaUF_Regional), TelefoneResid)
	    FROM   profissionais
	    WHERE  EXISTS (
	               SELECT 1
	               FROM   enderecos e
	               WHERE  e.IdProfissional = profissionais.IdProfissional
	                      AND e.Correspondencia = 1
	                      AND e.SiglaUf IN ('RO', 'AC')
	    ) ORDER BY
	        nome	           
	            
	ELSE
	    INSERT INTO histarqeleicaoprof
		(  
		 IdHistArqEleicao,  
		 IdProfissional,  
		 Nome,  
		 Registro,  
		 CPF,  
		 DataNascimento,  
		 AnoInscricao,  
		 NomeMae,  
		 RG,  
		 SiglaUF,  
		 Cidade,  
		 Bairro,  
		 Endereco,  
		 CEP,  
		 Naturalidade,
		 NomePai,
		 EMail,  
		 EMailAlternativo,  
		 EnderecoAtualizado,  
		 Situacao,  
		 TelefoneCelular,  
		 TelefoneTodos  
		)	    
	    SELECT @idHistArqEleicao,
	           IdProfissional,
	           Nome,
               SUBSTRING(@Regional, 4, 2) + '/' + dbo.RetiraZero(RegistroConselhoAtual),	           
	           CPF,
	           DataNascimento,
	           YEAR(DataInscricaoConselho) AS AnoInscricao,
	           NomeMae,
	           RG,
	           SiglaUF,
	           NomeCidade,
	           NomeBairro,
	           Endereco,
	           CEP,
               (SELECT NomeCidade FROM Cidades AS c WHERE c.IdCidade = idcidadeNaturalidade),
			   NomePai,	           
	           EnderecoEMail,
	           EnderecoEMail2,
	           Atualizado,
	           NULL,
               dbo.FormataTelefoneCelular_UNICO(ISNULL(SiglaUF, @SiglaUF_Regional), TelefoneCelular),
	           dbo.FormataTelefoneFixo_UNICO(ISNULL(SiglaUF, @SiglaUF_Regional), TelefoneResid)
	    FROM   profissionais
	    ORDER BY
	           nome 
	
	-- Verifica se existe algum campo que invalida a inclusão no arquivo para votação, marcando a situação com  2 - Descartado
	UPDATE haep
	SET    haep.Situacao = 2
	FROM   HistArqEleicaoProf haep
	       JOIN profissionais p
	            ON  p.IdProfissional = haep.IdProfissional
	       LEFT JOIN TiposInscricao ti
	            ON  ti.IdTipoInscricao = p.IdTipoInscricao
	WHERE  (haep.IdHistArqEleicao = @idHistArqEleicao)
	       AND (haep.nome IS NULL OR haep.nome = '' OR dbo.CPF_VALIDO(haep.CPF) = 0 OR (UPPER(ISNULL(ti.TipoInscricao, '')) <> 'PRINCIPAL' AND UPPER(ISNULL(ti.TipoInscricao, '')) <> 'PROVISÓRIA' AND UPPER(ISNULL(ti.TipoInscricao, '')) <> 'ESTRANGEIRO') OR UPPER(ISNULL(P.SituacaoAtual, '')) <> 'ATIVO')
	
	-- seleciona os profissionais que estão inadimplentes e atualiza a situação para 0
	UPDATE haep
	SET    haep.Situacao = 0
	FROM   HistArqEleicaoProf haep
	       JOIN (
	                SELECT DISTINCT dx.IdProfissional
	                FROM   Debitos DX
	                       JOIN SituacoesDebito sd
	                            ON  sd.IdSituacaoDebito = DX.IdSituacaoAtual
	                       JOIN TiposDebito td
	                            ON  td.IdTipoDebito = DX.IdTipoDebito
	                WHERE  DX.IdTipoDebito = 1 --ANUIDADE
	                       AND dbo.GetDataVencimento(1, DX.DataVencimento, GETDATE(), NULL, 0)
	                           < GETDATE()
	                       AND DX.DataReferencia < CAST(CAST(YEAR(GETDATE()) AS VARCHAR) + '0101' AS DATETIME)
	                       AND (
	                               (DX.IdSituacaoAtual IN (1, 3, 10, 15) AND (DX.NumeroParcela = 0 OR DX.NPossuiCotaUnica = 1))
	                               OR (
	                                      DX.IdSituacaoAtual IN (6, 14)
	                                      AND (
	                                              EXISTS 
	                                              (
	                                                  SELECT TOP 1 1
	                                                  FROM   Debitos D1
	                                                  WHERE  DX.IdProfissional = D1.IdProfissional
	                                                         AND D1.IdTipoDebito IN (2, 10)
	                                                         AND DX.NumConjReneg = D1.NumConjReneg
	                                                         AND D1.IdSituacaoAtual IN (1, 3)
	                                                         AND (D1.IdSituacaoAtual IN (1, 3) AND (D1.DataVencimento + CAST('23:59:59.000' AS DATETIME)) < GETDATE())
	                                              )
	                                              OR EXISTS (
	                                                     SELECT TOP 1 1
	                                                     FROM   Debitos D1
	                                                     WHERE  DX.IdProfissional = D1.IdProfissional
	                                                            AND D1.IdTipoDebito IN (2, 10)
	                                                            AND DX.NumConjReneg = D1.NumConjReneg
	                                                            AND D1.IdSituacaoAtual IN (1, 3)
	                                                            AND D1.NumeroParcela IN (0, 1)
	                                                            AND (D1.IdSituacaoAtual IN (1, 3) AND (D1.DataVencimento + CAST('23:59:59.000' AS DATETIME)) > GETDATE())
	                                                 )
	                                          )
	                                  )
	                           )
	            ) x
	            ON  haep.IdProfissional = x.idProfissional
	WHERE  haep.IdHistArqEleicao = @idHistArqEleicao
	       AND haep.situacao IS NULL
	
	-- Seleciona os profissionais que restaram, com situação nula setando para 1 - Aptos a Votar
	
	UPDATE HistArqEleicaoProf
	SET    Situacao = 1
	WHERE  IdHistArqEleicao = @idHistArqEleicao
	       AND Situacao IS NULL 
	
	-- Verifica os profissionais com a situação 2 e lança os motivos do descarte para arquivo de eleições
	INSERT INTO HistArqEleicaoProfMotivo
	SELECT haep.IdHistArqEleicaoProf,
	       1,
	       'Nome do Profissioal nulo ou em branco'
	FROM   HistArqEleicaoProf haep
	WHERE  haep.IdHistArqEleicao = @idHistArqEleicao
	       AND haep.Situacao = 2
	       AND ((haep.Nome IS NULL) OR (LTRIM(RTRIM(haep.Nome)) = ''))
	
	INSERT INTO HistArqEleicaoProfMotivo
	SELECT haep.IdHistArqEleicaoProf,
	       2,
	       'CPF Inválido ou não preenchido'
	FROM   HistArqEleicaoProf haep
	WHERE  haep.IdHistArqEleicao = @idHistArqEleicao
	       AND haep.Situacao = 2
	       AND dbo.CPF_VALIDO(haep.CPF) = 0
	
	INSERT INTO HistArqEleicaoProfMotivo
	SELECT haep.IdHistArqEleicaoProf,
	       3,
	       'Tipo Inscrição não habilitado para votação: ' + ISNULL(UPPER(CAST(ti.TipoInscricao AS VARCHAR(50))), 'Tipo Inscrição não preenchida')
	FROM   HistArqEleicaoProf haep
	       JOIN profissionais p
	            ON  p.IdProfissional = haep.IdProfissional
	       LEFT JOIN TiposInscricao ti
	            ON  ti.IdTipoInscricao = p.IdTipoInscricao
	WHERE  haep.IdHistArqEleicao = @idHistArqEleicao
	       AND haep.Situacao = 2
	       AND ((UPPER(ti.TipoInscricao) <> 'PRINCIPAL' AND UPPER(ti.TipoInscricao) <> 'PROVISÓRIA' AND UPPER(ti.TipoInscricao) <> 'ESTRANGEIRO') OR ti.TipoInscricao IS NULL)
	
	INSERT INTO HistArqEleicaoProfMotivo
	SELECT haep.IdHistArqEleicaoProf,
	       4,
	       'Situação Atual não habilitada para votação: ' + ISNULL(UPPER(p.SituacaoAtual), 'Situação Atual não preenchida')
	FROM   HistArqEleicaoProf haep
	       JOIN profissionais p
	            ON  p.IdProfissional = haep.IdProfissional
	WHERE  haep.IdHistArqEleicao = @idHistArqEleicao
	       AND haep.Situacao = 2
	       AND (UPPER(p.SituacaoAtual) <> 'ATIVO' OR p.SituacaoAtual IS NULL)
	
	
	-- Inserção dos motivos de recusa para entrar no arquivo ou deixar como inapto a votar
	INSERT INTO HistArqEleicaoProfMotivo
	SELECT haep.IdHistArqEleicaoProf,
	       5,
	       td.SiglaDebito + ' ' + CAST(YEAR(dx.DataReferencia) AS VARCHAR(4))
	       + ' Parcela ' + CAST(dx.NumeroParcela AS VARCHAR(2)) + ' - ' + sd.SituacaoDebito
	FROM   Debitos DX
	       JOIN HistArqEleicaoProf haep
	            ON  haep.IdProfissional = DX.IdProfissional
	       JOIN SituacoesDebito sd
	            ON  sd.IdSituacaoDebito = DX.IdSituacaoAtual
	       JOIN TiposDebito td
	            ON  td.IdTipoDebito = DX.IdTipoDebito
	WHERE  haep.IdHistArqEleicao = @idHistArqEleicao
	       AND haep.Situacao = 0
	       AND DX.IdTipoDebito = 1 --ANUIDADE
	       AND dbo.GetDataVencimento(1, DX.DataVencimento, GETDATE(), NULL, 0)  
	           < GETDATE()
	       AND DX.DataReferencia < CAST(CAST(YEAR(GETDATE()) AS VARCHAR) + '0101' AS DATETIME)
	       AND (
	               (DX.IdSituacaoAtual IN (1, 3, 10, 15) AND (DX.NumeroParcela = 0 OR DX.NPossuiCotaUnica = 1))
	               OR (
	                      DX.IdSituacaoAtual IN (6, 14)
	                      AND (
	                              EXISTS 
	                              (
	                                  SELECT TOP 1 1
	                                  FROM   Debitos D1
	                                  WHERE  DX.IdProfissional = D1.IdProfissional
	                                         AND D1.IdTipoDebito IN (2, 10)
	                                         AND DX.NumConjReneg = D1.NumConjReneg
	                                         AND D1.IdSituacaoAtual IN (1, 3)
	                                         AND (D1.IdSituacaoAtual IN (1, 3) AND (D1.DataVencimento + CAST('23:59:59.000' AS DATETIME)) < GETDATE())
	                              )
	                              OR EXISTS (
	                                     SELECT TOP 1 1
	                                     FROM   Debitos D1
	                                     WHERE  DX.IdProfissional = D1.IdProfissional
	                                            AND D1.IdTipoDebito IN (2, 10)
	                                            AND DX.NumConjReneg = D1.NumConjReneg
	                                            AND D1.IdSituacaoAtual IN (1, 3)
	                                            AND D1.NumeroParcela IN (0, 1)
	                                            AND (D1.IdSituacaoAtual IN (1, 3) AND (D1.DataVencimento + CAST('23:59:59.000' AS DATETIME)) > GETDATE())
	                                 )
	                          )
	                  )
	           )
	ORDER BY
	       haep.IdHistArqEleicaoProf,
	       YEAR(dx.DataReferencia),
	       dx.NumeroParcela 
	
	-- Verifica nos profissionais aptos ou inaptos a votar se existem CPF duplicados e muda situaçao para 2 - Recusado
	INSERT INTO HistArqEleicaoProfMotivo
	SELECT haep.IdHistArqEleicaoProf,
	       6,
	       'CPF Duplicado'
	FROM   HistArqEleicaoProf haep
	WHERE  haep.IdHistArqEleicao = @idHistArqEleicao
	       AND haep.Situacao IN (0,1)
	       AND  CPF IN (SELECT x.cpf FROM 
	          	   (SELECT cpf, COUNT(*) total  FROM HistArqEleicaoProf haep WHERE haep.Situacao IN (0,1) AND idHistArqEleicao = @idHistArqEleicao
	                GROUP BY CPF  HAVING COUNT(*) > 1) x)
	
	UPDATE HistArqEleicaoProf SET situacao =2
	WHERE IdHistArqEleicao = @idHistArqEleicao
	AND situacao IN (0,1) AND  CPF IN (SELECT x.cpf FROM 
	          	   (SELECT cpf, COUNT(*) total  FROM HistArqEleicaoProf haep WHERE haep.Situacao IN (0,1) AND idHistArqEleicao = @idHistArqEleicao
	                GROUP BY CPF  HAVING COUNT(*) > 1) x)
	                
	-- Verifica os profissionais aptos ou inaptos a votar que possuem mais de um endereço de correspondência e muda situação para 2 - Recusado
	INSERT INTO HistArqEleicaoProfMotivo
	SELECT haep.IdHistArqEleicaoProf,
	       7,
	       'Mais de um endereço de correspondência cadastrado'
	FROM   HistArqEleicaoProf haep
	JOIN profissionais p ON p.IdProfissional = haep.IdProfissional
	WHERE haep.IdHistArqEleicao = @idHistArqEleicao
	      AND haep.Situacao IN (0,1) 
	      AND  (SELECT COUNT(*) FROM enderecos e WHERE e.IdProfissional = p.IdProfissional AND  e.Correspondencia = 1) > 1 
	
		
	UPDATE haep SET situacao = 2
	FROM   HistArqEleicaoProf haep
	JOIN profissionais p ON p.IdProfissional = haep.IdProfissional
	WHERE haep.IdHistArqEleicao = @idHistArqEleicao
	      AND haep.Situacao IN (0,1) 
	      AND  (SELECT COUNT(*) FROM enderecos e WHERE e.IdProfissional = p.IdProfissional AND  e.Correspondencia = 1) > 1
	      
    
    --Profissionais sem número de registro preenchido	      
	INSERT INTO HistArqEleicaoProfMotivo
	SELECT haep.IdHistArqEleicaoProf,
	       8,
	       'Número de registro não preenchido'
	FROM   HistArqEleicaoProf haep
	WHERE  haep.IdHistArqEleicao = @idHistArqEleicao
	       AND haep.Situacao IN (0,1) 	
	       AND ((haep.Registro IS NULL) OR (len(haep.Registro) = 0))
	       
	UPDATE haep SET situacao = 2
	FROM   HistArqEleicaoProf haep
	WHERE  haep.IdHistArqEleicao = @idHistArqEleicao
	       AND situacao IN (0,1) 
	       AND ((haep.Registro IS NULL) OR (len(haep.Registro) = 0))  
	       
	       
		
	SELECT @idHistArqEleicao AS ID
	SET NOCOUNT OFF
