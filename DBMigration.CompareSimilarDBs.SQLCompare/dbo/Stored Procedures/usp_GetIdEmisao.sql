
CREATE PROCEDURE dbo.usp_GetIdEmisao (@TipoPessoa TINYINT, @IdPessoa INT, @EmissaoWeb BIT)
AS
BEGIN
	DECLARE @NomeCampoPessoa     VARCHAR(20),
	        @SQL                 VARCHAR(2000),
	        @IdEmissao           INT 
	
	SET @IdEmissao = 0
	
	DECLARE @tmpEmissoes TABLE (
		        IdEmissao        INT          NULL,
	            IdPessoa         INT          NULL,
	            Nome             VARCHAR(120) NULL,
	            RegistroConselho VARCHAR( 20) NULL,
	            CPF_CNPJ         VARCHAR( 14) NULL,
	            Endereco         VARCHAR(300) NULL,
	            NomeBairro       VARCHAR( 50) NULL,
	            NomeCidade       VARCHAR( 50) NULL,
	            SiglaUF          VARCHAR(  2) NULL,
	            CaixaPostal      VARCHAR( 15) NULL,
	            CEP              VARCHAR(  8) NULL
	)
	
	SELECT @NomeCampoPessoa = CASE @TipoPessoa
	                               WHEN 1 THEN 'IdProfissional'
	                               WHEN 0 THEN 'IdPessoaJuridica'
	                               WHEN 2 THEN 'IdPessoa'
	                               ELSE ''
	                          END
	
	IF @NomeCampoPessoa <> ''
	BEGIN
	    SET @SQL = 'SELECT TOP 1 
	                       IdEmissao,
	                       CASE WHEN IdProfissional   IS NOT NULL THEN IdProfissional
	                            WHEN IdPessoaJuridica IS NOT NULL THEN IdPessoaJuridica
	                            WHEN IdPessoa         IS NOT NULL THEN IdPessoa
	                       END,
	                       RegistroConselho,
	                       Nome,
	                       CPF_CNPJ,
	                       Endereco,
	                       NomeBairro,
	                       NomeCidade,
	                       SiglaUF,
	                       CaixaPostal,
	                       CEP
                    FROM   Emissoes 
                    WHERE ' + @NomeCampoPessoa + ' = ' + CAST(@IdPessoa AS VARCHAR(10)) + '
                    ORDER BY IdEmissao DESC '
        
        INSERT INTO @tmpEmissoes ( IdEmissao, 
                                   IdPessoa,
                                   RegistroConselho, 
                                   Nome, 
                                   CPF_CNPJ,
                                   Endereco, 
                                   NomeBairro, 
                                   NomeCidade, 
                                   SiglaUF,
                                   CaixaPostal, 
                                   CEP )
		EXEC(@SQL)                    
	         
	    SELECT @SQL = CASE @TipoPessoa
	                       WHEN 1 THEN 'SELECT TOP 1 
                                               p.RegistroConselhoAtual,
                                               p.Nome,
                                               p.CPF AS CPF_CNPJ,
                                               e.Endereco,
                                               e.NomeBairro,
                                               e.NomeCidade,
                                               e.SiglaUF,
                                               e.CaixaPostal,
                                               e.CEP,
                                               p.IdProfissional
                                        FROM   Profissionais p
                                               JOIN Enderecos e
                                                    ON  e.IdProfissional = p.IdProfissional
                                        WHERE  p.IdProfissional = ' + CAST(@IdPessoa AS VARCHAR(10)) + '
	                                    ORDER BY e.Correspondencia DESC'
                           WHEN 0 THEN 'SELECT TOP 1 
                                               pj.RegistroConselhoAtual,
                                               pj.Nome,
                                               pj.CNPJ AS CPF_CNPJ,
                                               e.Endereco,
                                               e.NomeBairro,
                                               e.NomeCidade,
                                               e.SiglaUF,
                                               e.CaixaPostal,
                                               e.CEP,
                                               pj.IdPessoaJuridica
                                        FROM   PessoasJuridicas pj
                                               JOIN Enderecos e
                                                    ON  e.IdPessoaJuridica = pj.IdPessoaJuridica
                                        WHERE  pj.IdPessoaJuridica = ' + CAST(@IdPessoa AS VARCHAR(10)) + '
                                        ORDER BY e.Correspondencia DESC'
                           WHEN 2 THEN 'SELECT TOP 1                                    
                                               '''',           
                                               pe.Nome,                                 
                                               pe.CNPJCPF,                  
                                               pe.Endereco,                              
                                               pe.NomeBairro,                            
                                               pe.NomeCidade,                            
                                               pe.SiglaUF,                               
                                               pe.CaixaPostal,                           
                                               pe.CEP,
                                               pe.IdPessoa                                  
                                        FROM   Pessoas pe                               
                                        WHERE  pe.IdPessoa = ' + CAST(@IdPessoa AS VARCHAR(10))                  
                           ELSE ''
	                  END	          
                                   
        INSERT INTO @tmpEmissoes ( RegistroConselho, 
                                   Nome, 
                                   CPF_CNPJ,
                                   Endereco, 
                                   NomeBairro, 
                                   NomeCidade, 
                                   SiglaUF,
                                   CaixaPostal, 
                                   CEP,
                                   IdPessoa )                                                          
		EXEC(@SQL)  
		
		DECLARE @Insert BIT
		
		/* Se não existe ainda na tabela de Emissões então insere um novo registro */
		SELECT @Insert = CASE WHEN EXISTS (SELECT TOP 1 1 FROM @TmpEmissoes WHERE IdEmissao IS NOT NULL) THEN 0 ELSE 1 END  
	                  
	    IF @Insert = 0
	    	SELECT @Insert = CASE WHEN EXISTS (SELECT TOP 1 1 
	    	                                   FROM   @TmpEmissoes e
	    	                                          JOIN @TmpEmissoes e2
	    	                                               ON  e.IdPessoa = e2.IdPessoa
                                               WHERE ISNULL(e.RegistroConselho, '') = ISNULL(e2.RegistroConselho, '')
                                                 AND ISNULL(e.Nome	          , '') = ISNULL(e2.Nome            , '')            
                                                 AND ISNULL(e.CPF_CNPJ        , '') = ISNULL(e2.CPF_CNPJ        , '')   
                                                 AND ISNULL(e.Endereco        , '') = ISNULL(e2.Endereco        , '')   
                                                 AND ISNULL(e.NomeBairro      , '') = ISNULL(e2.NomeBairro      , '')   
                                                 AND ISNULL(e.NomeCidade      , '') = ISNULL(e2.NomeCidade      , '')   
                                                 AND ISNULL(e.SiglaUF	      , '') = ISNULL(e2.SiglaUF         , '')   
                                                 AND ISNULL(e.CaixaPostal     , '') = ISNULL(e2.CaixaPostal     , '')   
                                                 AND ISNULL(e.CEP             , '') = ISNULL(e2.CEP		        , '')
                                                 AND e.IdEmissao IS NULL              AND e2.IdEmissao IS NOT NULL  ) THEN 0
	                              ELSE 1
	                         END	    
	                                             
		IF @Insert = 1 OR @EmissaoWeb = 1
		BEGIN			
			INSERT INTO Emissoes
			  (
			    IdProfissional,
			    IdPessoaJuridica,
			    IdPessoa,
			    RegistroConselho,
			    Nome,
			    CPF_CNPJ,
			    Endereco,
			    NomeBairro,
			    NomeCidade,
			    SiglaUF,
			    CaixaPostal,
			    CEP,
			    AtualizacaoWeb
			  )
			SELECT CASE WHEN @TipoPessoa = 1 THEN IdPessoa ELSE NULL END,
			       CASE WHEN @TipoPessoa = 0 THEN IdPessoa ELSE NULL END,
			       CASE WHEN @TipoPessoa = 2 THEN IdPessoa ELSE NULL END,			
			       RegistroConselho,
			       Nome,
			       CPF_CNPJ,
			       Endereco,
			       NomeBairro,
			       NomeCidade,
			       SiglaUF,
			       CaixaPostal,
			       CEP,
			       CASE WHEN ISNULL(@EmissaoWeb, 0) = 1 THEN 'I:' ELSE NULL END
			FROM   @TmpEmissoes     
			WHERE  IdEmissao IS NULL
			
			SELECT @IdEmissao = SCOPE_IDENTITY()  
		END
		ELSE
			SELECT @IdEmissao = IdEmissao
			FROM   @TmpEmissoes 
			WHERE  IdEmissao IS NOT NULL                                        
	                  
	END
	
	RETURN @IdEmissao

END
