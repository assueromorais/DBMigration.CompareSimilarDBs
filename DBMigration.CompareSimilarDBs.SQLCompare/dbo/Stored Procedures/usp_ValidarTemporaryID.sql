
CREATE PROCEDURE dbo.usp_ValidarTemporaryID (@IdEmissaoConfig INT, @DataMinimaASerConsiderada DATETIME)
AS
BEGIN
	DECLARE @Chave                UNIQUEIDENTIFIER,
	        @DataVencimentoBoleto DATETIME

	DECLARE @DebitosList TABLE ( IdDebito INT )
	
	DECLARE @PessoasID TABLE (
	            Chave      UNIQUEIDENTIFIER,
	            IdDebito   INT,
	            IdPessoa   INT,
	            TipoPessoa TINYINT,
	            CPF_CNPJ   VARCHAR(14)
	        ) 		
	
	SELECT @Chave = Chave,
	       @DataVencimentoBoleto = ec.DataVencimentoBoleto
	FROM   EmissoesConfig ec
	WHERE  ec.IdEmissaoConfig = @IdEmissaoConfig  	
	
	INSERT INTO @DebitosList ( IdDebito )
	SELECT ti.ID
	FROM   TemporaryID ti
	       JOIN EmissoesConfig ec
	            ON  ec.Chave = ti.Chave
	WHERE  ec.IdEmissaoConfig = @IdEmissaoConfig	
	
	INSERT INTO @PessoasID
	  (
	    Chave,
	    IdDebito,
	    IdPessoa,
	    TipoPessoa,
	    CPF_CNPJ
	  )
	SELECT @Chave,
	       d.IdDebito,
	       CASE 
	            WHEN p.IdProfissional IS NOT NULL THEN p.IdProfissional
	            WHEN pj.IdPessoaJuridica IS NOT NULL THEN pj.IdPessoaJuridica
	            WHEN pe.IdPessoa IS NOT NULL THEN pe.IdPessoa
	            ELSE     ''
	       END,
	       CASE 
	            WHEN pj.IdPessoaJuridica IS NOT NULL THEN 0
	            WHEN p.IdProfissional IS NOT NULL THEN 1
	            WHEN pe.IdPessoa IS NOT NULL THEN 2
	            ELSE -1
	       END,
	       CASE 
	            WHEN p.IdProfissional IS NOT NULL THEN p.CPF
	            WHEN pj.IdPessoaJuridica IS NOT NULL THEN pj.CNPJ
	            WHEN pe.IdPessoa IS NOT NULL THEN pe.CNPJCPF
	            ELSE     ''
	       END
	FROM   Debitos d
	       JOIN @DebitosList dl
	            ON  dl.IdDebito = d.IdDebito
	       LEFT JOIN Profissionais p
	            ON  p.IdProfissional = d.IdProfissional
	       LEFT JOIN PessoasJuridicas pj
	            ON  pj.IdPessoaJuridica = d.IdPessoaJuridica
	       LEFT JOIN Pessoas pe
	            ON  pe.IdPessoa = d.IdPessoa	
	
	/* Validação do CPF / CNPJ */
	UPDATE ti
	SET    ti.[Status] = 1,	-- Inválido
	       ti.Validacao = STUFF(ti.Validacao, 1, 1, '1') -- Posição 1 - Código para CPF / CNPJ Inválido
	FROM   TemporaryID ti
	       JOIN @PessoasID pid
	            ON  pid.Chave = ti.Chave
	            AND pid.IdDebito = ti.ID
	            AND pid.IdPessoa = ti.IDPessoa
	WHERE  dbo.ufn_ValidarCpfCnpj(pid.CPF_CNPJ) = 0 
		
	/* Validação do endereço */
	UPDATE ti
	SET    ti.[Status] = 1,	-- Inválido
	       ti.Validacao = STUFF(ti.Validacao, 2, 1, '1') -- Posição  2 - Código para Endereço inválido
	FROM   TemporaryID ti
	       JOIN @PessoasID pid
	            ON  pid.Chave = ti.Chave
	            AND pid.IdDebito = ti.ID
	            AND pid.IdPessoa = ti.IDPessoa
	WHERE  dbo.ufn_ValidarEndereco (pid.IdPessoa, pid.TipoPessoa) = 0
		       
	/* Validação da data de vencimento */
	UPDATE ti
	SET    ti.[Status] = 1,	-- Inválido
	       ti.Validacao = STUFF(ti.Validacao, 3, 1, '1') -- Posição 3 - Data de vencimento inválida
	FROM   TemporaryID ti
	       JOIN @PessoasID pid
	            ON  pid.Chave = ti.Chave
	            AND pid.IdDebito = ti.ID
	            AND pid.IdPessoa = ti.IDPessoa
	       JOIN Debitos d
	            ON  ti.ID = d.IdDebito
	       OUTER APPLY dbo.ufn_GetDescontos( d.IdDebito, @DataMinimaASerConsiderada ) gd    
	WHERE  CASE WHEN @DataVencimentoBoleto IS NOT NULL THEN @DataVencimentoBoleto ELSE ISNULL(gd.DataDesconto, d.DataVencimento) END < @DataMinimaASerConsiderada             
END
