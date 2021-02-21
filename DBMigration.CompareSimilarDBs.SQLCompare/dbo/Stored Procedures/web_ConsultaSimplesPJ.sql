																							
-- ============================================================================
--	web_ConsultaSimplesPJ
-- ============================================================================	
CREATE PROCEDURE [dbo].[web_ConsultaSimplesPJ]
	@sigla VARCHAR(15),
	@CampoOrdem VARCHAR(100) = NULL,
	@NumeroRegistro VARCHAR(20) = NULL,
	@NomeFantASia VARCHAR(50) = NULL,
	@Nome VARCHAR(100) = NULL,
	@NomeCategoria VARCHAR(50) = NULL,
	@NomeSituacao VARCHAR(50) = NULL,
	@NomeAreaAtuacao VARCHAR(100) = NULL,
	@NomeSetorAtuacao VARCHAR(100) = NULL,
	@bListarAreaAtuacao BIT = 0,
	@MaxAreaAtuacao INT = 2,
	@SituacaoEspeficia VARCHAR(5000) = NULL,
	@idSubRegiao VARCHAR(10) = NULL,
	@filtroTpInscricaoPj VARCHAR(5000) = NULL,
	@Cnpj VARCHAR(14) = NULL,
	@detalheSituacao VARCHAR(50) = NULL,
	@NomeCidade VARCHAR(50) = NULL
AS

BEGIN
	DECLARE @IdPessoaJuridica       VARCHAR(15),
	        @RegistroConselhoAtual  VARCHAR(100),
	        @NomeFantASiaAux        VARCHAR(100),
	        @CategoriaAtual         VARCHAR(100),
	        @SituacaoAtual          VARCHAR(100),
	        @NomeAreaAtuacaoAux     VARCHAR(100),
	        @bUpdate                BIT,
	        @iContador              INT,
	        @teste                  BIT,
	        @sqlAreASCampo          VARCHAR(50),
	        @sqlAreASFROM           VARCHAR(2000),
	        @sqlAreASJoin           VARCHAR(2000),
	        @IdAreaAtuacao          INT,
	        @IdSetorAtuacao         INT,
	        @DetalhedASituacao      VARCHAR(100),
	        @NomeCidadeAux          VARCHAR(100),
	        @ENDerecoTrabalho       BIT  
	
	SET NOCOUNT ON
	
	SET @SituacaoEspeficia = ISNULL(@SituacaoEspeficia, '')
	SET @filtroTpInscricaoPj = ISNULL(@filtroTpInscricaoPj, '')
	SET @DetalhedASituacao = ISNULL(@DetalhedASituacao, '')  
	
	SELECT @IdAreaAtuacao = aa.IdAreaAtuacao
	FROM   AreASAtuacao 
	       aa
	WHERE  aa.AreaAtuacao = @NomeAreaAtuacao  
	
	
    SELECT @IdSetorAtuacao = sas.IdSetorAtuacao
	FROM   SetoresAtuacao 
	       sas
	WHERE  sas.SetorAtuacao = @NomeSetorAtuacao  
		
	SELECT @MaxAreaAtuacao = ISNULL(@MaxAreaAtuacao, 2)            
	
	SELECT TOP 1 @ENDerecotrabalho = ISNULL(UtilizarENDerecoTrabalho, 0)
	FROM   ParametrosSiscafweb    
	
	CREATE TABLE #Resultado
	(
		Ident             INT IDENTITY(1, 1),
		sigla             VARCHAR(15),
		IdPessoaJuridica  INT NULL,
		RegistroConselho  VARCHAR(100) NULL,
		NomeFantASia      VARCHAR(100) NULL,
		CategoriaAtual    VARCHAR(100) NULL,
		SituacaoAtual     VARCHAR(100) NULL,
		Nome              VARCHAR(200) NULL,
		IdTipoInscricao   INT NULL,
		SubRegiao         VARCHAR(100),
		RegiaoConselho    VARCHAR(1),
		Cnpj              VARCHAR(14) NULL,
		DetalheSituacao   VARCHAR(100),
		NomeCidade        VARCHAR(50) 
	)            
	
	CREATE TABLE #Resultado2
	(
		Ident             INT IDENTITY(1, 1),
		sigla             VARCHAR(15),
		IdPessoaJuridica  INT NULL,
		RegistroConselho  VARCHAR(100) NULL,
		NomeFantasia      VARCHAR(100) NULL,
		CategoriaAtual    VARCHAR(100) NULL,
		SituacaoAtual     VARCHAR(100) NULL,
		Nome              VARCHAR(200) NULL,
		AreaAtuacao       VARCHAR(100) NULL,
		SubRegiao         VARCHAR(100),
		RegiaoConselho    VARCHAR(1),
		Cnpj              VARCHAR(14) NULL,
		DetalheSituacao   VARCHAR(100), 
		NomeCidade        VARCHAR(50)
	) 
	
	INSERT INTO 
	       #Resultado
	SELECT @sigla AS Sigla,
	       PessoASJuridicAS.IdPessoaJuridica,
	       PessoASJuridicAS.RegistroConselhoAtual,
	       PessoASJuridicAS.NomeFantASia,
	       PessoASJuridicAS.CategoriaAtual,
	       PessoASJuridicAS.SituacaoAtual,
	       PessoASJuridicAS.Nome,
	       PessoASJuridicAS.idTipoInscricao,
	       SubRegiao.Nome AS subRegiao,
	       NULL,
	       PessoASJuridicAS.CNPJ,
	       DetalheSituacao = ISNULL(
	           (
	               SELECT TOP 
	                      1 
	                      ds.Detalhe
	               FROM   PessoASJuridicAS_SituacoesPFPJ 
	                      ps
	                      JOIN DetalhesSituacao 
	                           ds
	                           ON  ds.IdDetalheSituacao = ps.IdDetalheSituacao
	               WHERE  ps.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	               ORDER BY
	                      ps.DataInicioSituacao 
	                      DESC
	           ),
	           ''
	       ), 
	       PessoASJuridicAS.NomeCidade	       
	FROM   PessoASJuridicAS
	       LEFT JOIN PessoAS 
	            SubRegiao
	            ON  PessoASJuridicAS.IdSubRegiao = SubRegiao.IdPessoa
	              LEFT JOIN SetoresAtuacao_PessoasJuridicas setoresPJ
	                ON  setoresPJ.idPessoaJuridica =   PessoASJuridicAS.IdPessoaJuridica     
	WHERE  (
	           (PessoASJuridicAS.NomeFantASia LIKE @NomeFantASia)
	           OR (@NomeFantASia IS NULL)
	       )
	       AND (
	               (
	                   PessoASJuridicAS.Nome 
	                   COLLATE 
	                   Latin1_General_CI_AI 
	                   LIKE 
	                   dbo.RetiraAcento(@Nome)
	               )
	               OR (@Nome IS NULL)
	           )
	       AND (
	               (
	                   dbo.RetiraZero(PessoASJuridicAS.RegistroConselhoAtual) 
	                   LIKE 
	                   dbo.RetiraZero(@NumeroRegistro)
	               )
	               OR (@NumeroRegistro IS NULL)
	           )
	       AND (
	               (PessoASJuridicAS.CategoriaAtual LIKE @NomeCategoria)
	               OR (@NomeCategoria IS NULL)
	           )
	       AND (
	               (PessoASJuridicAS.IdSubRegiao LIKE @idSubRegiao)
	               OR (@idSubRegiao IS NULL)
	           )
	       AND (
	               (PessoASJuridicAS.SituacaoAtual LIKE @NomeSituacao)
	               OR (@NomeSituacao IS NULL)
	           )
	       AND ((PessoASJuridicAS.CNPJ LIKE @Cnpj) OR (@Cnpj IS NULL))
	      AND ((setoresPJ.IdSetorAtuacao =  @IdSetorAtuacao) OR (@IdSetorAtuacao IS NULL))
	      AND (
			   EXISTS(
				   SELECT TOP 1 1
				   FROM   Enderecos e
				   WHERE  e.idPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
						  AND (
						   (e.E_Residencial = 0 AND @EnderecoTrabalho = 1)
						 	  OR (@EnderecoTrabalho = 0 AND e.Correspondencia = 1)
						   )
					AND   ISNULL(e.NomeCidade, '-') LIKE @NomeCidade
			   )
			   OR (@NomeCidade IS NULL)
			) 
	      
	ORDER BY
	       PessoASJuridicAS.NomeFantasia             
	
	
	IF ISNULL(@bListarAreaAtuacao, 0) = 1
	    SET @sqlAreASCampo = ', aa.AreaAtuacao AreaAtuacao '
	ELSE
	    SET @sqlAreASCampo = ', '' '' AreaAtuacao '            
	
	IF (@NomeAreaAtuacao IS NOT NULL)
	BEGIN
	    SET @sqlAreASJoin = 
	        ' LEFT JOIN AreASAtuacao_PessoASJuridicAS aapj ON aapj.IdPessoaJuridica = r.IdPessoaJuridica 
			AND aapj.IdAreaAtuacao = ' + CAST(@IdAreaAtuacao AS VARCHAR) +
	        ' AND aapj.IdAreaAtuacao in (SELECT top ' + CAST(@MaxAreaAtuacao AS VARCHAR) 
	        +
	        ' aapj2.IdAreaAtuacao FROM AreASAtuacao_PessoASJuridicAS aapj2 WHERE aapj2.IdPessoaJuridica = aapj.IdPessoaJuridica ' 
	        + ') ' +
	        'JOIN   AreASAtuacao aa ON aa.IdAreaAtuacao = aapj.IdAreaAtuacao'
	END
	ELSE
	BEGIN
	    SET @sqlAreASJoin = 
	        ' LEFT JOIN AreASAtuacao_PessoASJuridicAS aapj ON aapj.IdPessoaJuridica = r.IdPessoaJuridica ' 
	        +
	        ' AND aapj.IdAreaAtuacao in (SELECT top ' + CAST(@MaxAreaAtuacao AS VARCHAR) 
	        +
	        ' aapj2.IdAreaAtuacao FROM AreASAtuacao_PessoASJuridicAS aapj2 WHERE aapj2.IdPessoaJuridica = aapj.IdPessoaJuridica ' 
	        +
	        ') LEFT JOIN   AreASAtuacao aa ON aa.IdAreaAtuacao = aapj.IdAreaAtuacao'
	END 
	
	IF @detalheSituacao IS NOT NULL
	    SET @detalheSituacao = ' AND DetalheSituacao = ''' + @detalheSituacao + 
	        ''''
	
	INSERT INTO 
	       #Resultado2
	  (
	    sigla,
	    IdPessoaJuridica,
	    RegistroConselho,
	    NomeFantASia,
	    CategoriaAtual,
	    SituacaoAtual,
	    Nome,
	    AreaAtuacao,
	    subRegiao,
	    RegiaoConselho,
	    Cnpj,
	    DetalheSituacao,
	    NomeCidade
	  )
	EXEC (
	         'SELECT distinct r.sigla,            
					r.IdPessoaJuridica,            
					r.RegistroConselho,            
					r.NomeFantASia,            
					r.CategoriaAtual,            
					r.SituacaoAtual,            
					r.Nome ' + @sqlAreASCampo +
	         ', r.SubRegiao AS SubRegiao, r.RegiaoConselho, r.cnpj, r.DetalheSituacao, r.nomeCidade ' 
	         +
	         '  FROM #Resultado r ' + @sqlAreasJoin + ' WHERE 1=1 ' +
	         @SituacaoEspeficia + @filtroTpInscricaoPj + @detalheSituacao +
	         ' ORDER BY r.Nome'
	     )   
	
	SELECT *,
	       0 AS UtilizAServidorExterno,
	       '''' AS ENDerecoServidorExterno
	FROM   #Resultado2
	ORDER BY
	       Nome 
	
	DROP TABLE #Resultado 
	DROP TABLE #Resultado2                          
	
	SET NOCOUNT ON
END

