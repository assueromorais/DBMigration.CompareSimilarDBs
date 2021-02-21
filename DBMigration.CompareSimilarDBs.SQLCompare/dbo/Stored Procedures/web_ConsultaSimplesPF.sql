																						
																			
-- ============================================================================
--	web_ConsultaSimplesPF
-- ============================================================================																							
CREATE PROCEDURE [dbo].[web_ConsultaSimplesPF]
	@Sigla VARCHAR(20) ,
	@CampoOrdem VARCHAR(100) = NULL,
	@NumeroRegistro VARCHAR(20) = NULL,
	@NomeProf VARCHAR(50) = NULL,
	@NomeCategoria VARCHAR(50) = NULL,
	@NomeSituacao VARCHAR(50) = NULL,
	@NomeRegiao VARCHAR(20) = NULL,
	@NomeCidade VARCHAR(50) = NULL,
	@idAreaAtuacao VARCHAR(100) = NULL,
	@idSetorAtuacao VARCHAR(100) = NULL,
	@NomeEspecialidade VARCHAR(100) = NULL,
	@Curso_Nivel VARCHAR(100) = NULL,
	@bListarEspecialidades BIT = 0,
	@MaxEspecialidades INT = 1,
	@bListarCurso_Nivel BIT = 0,
	@MaxCurso_Nivel INT = 1,
	@indicativoProf1 CHAR(1) = NULL,
	@indicativoProf2 CHAR(1) = NULL,
	@indicativoProf3 CHAR(1) = NULL,
	@SituacaoEspecifica VARCHAR(5000) = NULL,
	@IdSubRegiao INT = NULL,
	@CPF VARCHAR(11) = NULL,
	@detalheSituacao VARCHAR(50) = NULL,
	@nomeSocial VARCHAR(100) = NULL,
	@DBMainName VARCHAR(100) = 'siscafweb_java'
AS
BEGIN
	DECLARE @IdProfissional                           VARCHAR(10),
	        @RegistroConselhoAtual                    VARCHAR(100),
	        @InibirVisualizacaoRegistroConselhoAtual  VARCHAR(10),
	        @Nome                                     VARCHAR(100),
	        @CategoriaAtual                           VARCHAR(100),
	        @SituacaoAtual                            VARCHAR(100),
	        @RegiaoConselho                           VARCHAR(100),
	        @NomeCidadeAux                            VARCHAR(100),
	        @NomeEspecialidadeAux                     VARCHAR(100),
	        @NomeCursoAux                             VARCHAR(100),
	        @bUpdate                                  BIT,
	        @iContador                                INT,
	        @sqlIndicativos                           VARCHAR(5000),
	        @sqlSituacaoEspecifica                    VARCHAR(5000),
	        @idTipoInscricao                          INT,
	        @SubRegiao                                VARCHAR(120),
	        @TipoInscricao                            VARCHAR(20),
	        @TelefoneTrab                             VARCHAR(100),
	        @Suspenso                                 BIT,
	        @ENDerecoTrabalho                         BIT,
	        @idSituacoes                              VARCHAR(1000),
	        @IdRegional                               INT,
	        @DetalhedASituacao                        VARCHAR(100),
	        @socialNome                               VARCHAR(100),
	        @SQLTmp                                   NVARCHAR(4000),
	        @EscondeEspecialidade                     BIT,
	        @EscondeCursoNivel                        BIT,
	        @DataSituacao                             VARCHAR(10),
	        @AreaAtuacao                              VARCHAR(150)
	
	SELECT @EscondeEspecialidade = CASE 
	                                    WHEN @bListarEspecialidades 
	                                         =
	                                         1 THEN 0
	                                    ELSE 1
	                               END,
	       @EscondeCursoNivel = CASE 
	                                 WHEN @bListarEspecialidades 
	                                      =
	                                      1 THEN 0
	                                 ELSE 1
	                            END    
	
	IF @bListarEspecialidades = 0
	    SET @bListarEspecialidades = 1                                
	
	IF @bListarCurso_Nivel = 0
	    SET @bListarCurso_Nivel = 1    
	
	DECLARE @idCurso          VARCHAR(10),
	        @idEspecialidade  VARCHAR(10)
	
	SELECT @idCurso = @Curso_Nivel,
	       @idEspecialidade = @NomeEspecialidade                                 
	
	IF @NomeEspecialidade IS NOT NULL
	    SELECT @NomeEspecialidade = e.NomeEspecialidade
	    FROM   Especialidades 
	           e
	    WHERE  e.IdEspecialidade = @idEspecialidade    
	
	IF @Curso_Nivel IS NOT NULL
	    SELECT @Curso_Nivel = nc.NivelCurso
	    FROM   NiveisCurso 
	           nc
	    WHERE  nc.IdNivelCurso = @idCurso            
	
	IF @MaxEspecialidades IS NULL
	    SET @MaxEspecialidades = 1    
	
	IF @MaxCurso_Nivel IS NULL
	    SET @MaxCurso_Nivel = 1
	
	SET NOCOUNT ON 
	
	/* Buscar IdRegional */                
	
	SET @SQLTmp = 'SELECT @Valor = ' + @DBMainName + 
	    '.dbo.Regionais.IdRegional ' +
	    '  FROM ' + @DBMainName + '.dbo.Conselhos ' +
	    '       LEFT JOIN ' + @DBMainName + '.dbo.Regionais ON ' + @DBMainName + 
	    '.dbo.Regionais.IdConselho = ' +
	    @DBMainName + '.dbo.Conselhos.IdConselho ' +
	    '				LEFT JOIN ' + @DBMainName + '.dbo.Estados ON ' + @DBMainName 
	    + '.dbo.Estados.IdEstado = ' +
	    @DBMainName + '.dbo.Regionais.IdEstado ' +
	    ' WHERE (SiglaConselho+UF = ''' + @sigla + 
	    ''' OR SiglaConselhoFederal = ''' + @sigla + ''')'
	
	--PRINT @SQLTmp
	
	EXEC sp_executesql @SQLTmp,
	     N'@Valor int output',
	     @IdRegional OUTPUT
	
	--PRINT '@IdRegional = ' + CAST(@IdRegional AS VARCHAR(100))
	
	SET @idSituacoes = ''                
	
	SET @SQLTmp = 
	    'SELECT @Valor = ISNULL(SUBSTRING(REPLACE(LTRIM(RTRIM(r.situacoesPGNaoMostrarDetalhe)),'';'','',''),  1,
					(CASE 
							WHEN  LEN(r.situacoesPGNaoMostrarDetalhe) > 0 THEN         
								LEN(r.situacoesPGNaoMostrarDetalhe)                
							ELSE ''1'' 	    
						END)-1),'''')
				 FROM ' + @DBMainName + '.dbo.Regionais r WHERE r.IdRegional = ' 
	    + CAST(@IdRegional AS VARCHAR(100))
	
	--PRINT @SQLTmp
	
	EXEC sp_executesql @SQLTmp,
	     N'@Valor VARCHAR(1000) output',
	     @idSituacoes OUTPUT 
	
	--PRINT '@idSituacoes = ''' + @idSituacoes + ''''
	
	IF (@idSituacoes < > '')
	    SET @idSituacoes = ' AND sp.IdSituacaoPFPJ IN(' + @IdSituacoes + ') '
	
	SELECT TOP 1 @ENDerecotrabalho = ISNULL(UtilizarENDerecoTrabalho, 0)
	FROM   ParametrosSiscafweb                        
	
	SET @sqlIndicativos = ''                                            
	
	IF @IndicativoProf1 IS NOT NULL
	    SET @sqlIndicativos = ' AND (IndicativoProf1 = ' + @IndicativoProf1 + 
	        ' ) '
	
	IF @IndicativoProf2 IS NOT NULL
	    SET @sqlIndicativos = @sqlIndicativos + ' AND (IndicativoProf2 = ' + @IndicativoProf2 
	        + ' )  '
	
	IF @IndicativoProf3 IS NOT NULL
	    SET @sqlIndicativos = @sqlIndicativos + ' AND (IndicativoProf3 = ' +
	        @IndicativoProf3 + ' )  '
	
	IF @detalheSituacao IS NOT NULL
	    SET @sqlIndicativos = @sqlIndicativos + ' AND (DetalheSituacao = ''' +
	        @detalheSituacao 
	        +
	        ''' )  ' 
	
	IF @SituacaoEspecifica IS NULL
	    SET @sqlSituacaoEspecifica = '' 
	
	--SET @SituacaoEspecifica = REPLACE(@SituacaoEspecifica, '''', '''''')                                  
	
	IF @SituacaoEspecifica IS NOT NULL
	    SET @sqlSituacaoEspecifica = @SituacaoEspecifica
	
	CREATE TABLE #Resultado
	(
		Ident                                    INT IDENTITY(1, 1),
		sigla                                    VARCHAR(15),
		IdProfissional                           INT,
		RegistroConselho                         VARCHAR(100) NULL,
		Nome                                     VARCHAR(100) NULL,
		InibirVisualizacaoRegistroConselhoAtual  VARCHAR(10),
		CategoriaAtual                           VARCHAR(100) NULL,
		SituacaoAtual                            VARCHAR(100),
		RegiaoConselho                           VARCHAR(100) NULL,
		Cidade                                   VARCHAR(100) NULL,
		Especialidade                            VARCHAR(100) NULL,
		Curso_Nivel                              VARCHAR(100) NULL,
		indicativoProf1                          BIT NULL,
		indicativoProf2                          BIT NULL,
		indicativoProf3                          BIT NULL,
		idTipoInscricao                          INT NULL,
		SubRegiao                                VARCHAR(120) NULL,
		TipoInscricao                            VARCHAR(20) NULL,
		TelefoneTrab                             VARCHAR(100) NULL,
		suspenso                                 BIT NULL,
		Cpf                                      VARCHAR(11) NULL,
		DetalheSituacao                          VARCHAR(100),
		NomeSocial                               VARCHAR(100),
		DataSituacao                             VARCHAR(10),
		AreaAtuacao                              VARCHAR(150)
	)                                          
	
	DECLARE crProfissionais                             CURSOR FAST_FORWARD 
	FOR
	    SELECT DISTINCT @Sigla AS sigla,
	           Profissionais                            .IdProfissional,
	           Profissionais                            .RegistroConselhoAtual,
	           Profissionais                            .Nome,
	           InibirVisualizacaoRegistroConselhoAtual  = ISNULL(
	               (
	                   SELECT TOP 
	                          1 
	                          s.InibirRegistrosWeb
	                   FROM   Profissionais_SituacoesPF 
	                          ps
	                          JOIN SituacoesPFPJ 
	                               s
	                               ON  s.IdSituacaoPFPJ = ps.IdSituacaoPFPJ
	                   WHERE  ps.IdProfissional = Profissionais.IdProfissional
	                   ORDER BY
	                          ps.DataInicioSituacao 
	                          DESC
	               ),
	               ''
	           ),
	           Profissionais                            .CategoriaAtual,
	           Profissionais                            .SituacaoAtual,
	           PessoAS                                  .Sigla,
	           (
	               SELECT                               TOP 1 e2.NomeCidade
	               FROM   Enderecos e2
	               WHERE  e2.IdProfissional = Profissionais.IdProfissional
	                      AND (
	                              (e2.E_Residencial = 0 AND @EnderecoTrabalho = 1)
	                              OR (e2.Correspondencia = 1 AND @EnderecoTrabalho = 0)
	                          )
	           ) AS NomeCidade,
	           Profissionais                            .indicativoProf1,
	           Profissionais                            .indicativoProf2,
	           Profissionais                            .indicativoProf3,
	           Profissionais                            .idTipoInscricao,
	           SubRegiao                                .Nome AS SubRegiao,
	           TiposInscricao                           .TipoInscricao,
	           (
	               CASE                                 Profissionais.TelTrabDivulgacao
	                    WHEN 1 THEN Profissionais.TelefoneTrab
	                    ELSE ''
	               END
	           ) AS TelefoneTrab,
	           suspenso,
	           Profissionais                            .CPF,
	           DetalheSituacao                          = ISNULL(
	               (
	                   SELECT TOP 
	                          1 
	                          ds.Detalhe
	                   FROM   Profissionais_SituacoesPF 
	                          ps
	                          JOIN DetalhesSituacao 
	                               ds
	                               ON  ds.IdDetalheSituacao = ps.IdDetalheSituacao
	                   WHERE  ps.IdProfissional = Profissionais.IdProfissional
	                   ORDER BY
	                          ps.DataInicioSituacao 
	                          DESC
	               ),
	               ''
	           ),
	           NomeSocial,
	           DataSituacao                             = ISNULL(
	               (
	                   SELECT CONVERT(VARCHAR(10), MAX(DataInicioSituacao), 103)
	                   FROM   Profissionais_SituacoesPF psp
	                   WHERE  psp.IdProfissional = Profissionais.IdProfissional
	               ),
	               ''
	           ),
			   CASE WHEN EXISTS(SELECT TOP 1 1
                                FROM	ParametrosSiscafWeb
                                WHERE	ResultadoPesquisa_Coluna1_PF LIKE '%AreaAtuacao%') THEN aa.AreaAtuacao 
				    ELSE NULL 
	           END AS AreaAtuacao
	    FROM   Profissionais
	           LEFT JOIN PessoAS
	                ON  PessoAS.IdPessoa = Profissionais.IdUnidadeConselho
	           LEFT JOIN PessoAS SubRegiao
	                ON  Profissionais.IdSubRegiao = SubRegiao.IdPessoa
	           LEFT JOIN TiposInscricao
	                ON  Profissionais.IdTipoInscricao = TiposInscricao.IdTipoInscricao
               LEFT JOIN ExperienciasProfissionais ep
	                ON  Profissionais.IdProfissional = ep.IdProfissional
	           LEFT JOIN AreasAtuacao aa
	                ON  aa.IdAreaAtuacao = ep.IdAreaAtuacao
	                
	    WHERE  (
	               (
	                   Profissionais.Nome 
	                   COLLATE 
	                   Latin1_General_CI_AI 
	                   LIKE 
	                   dbo.RetiraAcento(@NomeProf)
	               )
	               OR (@NomeProf IS NULL)
	           )
	           AND (
	                   (
	                       dbo.RetiraZero(Profissionais.RegistroConselhoAtual) 
	                       LIKE 
	                       dbo.RetiraZero(@NumeroRegistro)
	                   )
	                   OR (@NumeroRegistro IS NULL)
	               )
	           AND (
	                   (Profissionais.CategoriaAtual LIKE @NomeCategoria)
	                   OR (@NomeCategoria IS NULL)
	               )
	           AND ((PessoAS.Sigla LIKE @NomeRegiao) OR (@NomeRegiao IS NULL))
	           AND (
	                   (Profissionais.SituacaoAtual LIKE @NomeSituacao)
	                   OR (@NomeSituacao IS NULL)
	               )
	           AND (
	                   (Profissionais.IdSubRegiao = @IdSubRegiao)
	                   OR (@IdSubRegiao IS NULL)
	               )
	           AND ((Profissionais.CPF LIKE @CPF) OR (@CPF IS NULL))
	           AND (
	                   (Profissionais.NomeSocial LIKE @NomeSocial)
	                   OR (@NomeSocial IS NULL)
	               )
	           AND ((ep.IdAreaAtuacao =  @idAreaAtuacao) OR (@idAreaAtuacao IS NULL))
	           AND ((ep.IdSetorAtuacao =  @IdSetorAtuacao) OR (@IdSetorAtuacao IS NULL))
	           AND (
	                   EXISTS(
	                       SELECT TOP 1 1
	                       FROM   Enderecos e
	                       WHERE  e.IdProfissional = Profissionais.IdProfissional
	                              AND (
	                                      (e.E_Residencial = 0 AND @EnderecoTrabalho = 1)
	                                      OR (@EnderecoTrabalho = 0 AND e.Correspondencia = 1)
	                                  )
	                              AND ISNULL(e.NomeCidade, '-') LIKE @NomeCidade
	                   )
	                   OR (@NomeCidade IS NULL)
	               ) 
	               -- AND (suspenso = @sup1 OR suspenso = @sup2)
	    ORDER BY
	           Profissionais.Nome 
	
	OPEN crProfissionais 
	FETCH NEXT FROM crProfissionais INTO 
	@Sigla, 
	@IdProfissional, 
	@RegistroConselhoAtual, 
	@Nome,
	@InibirVisualizacaoRegistroConselhoAtual, 
	@CategoriaAtual, 
	@SituacaoAtual, 
	@RegiaoConselho, 
	@NomeCidadeAux,
	@indicativoProf1,
	@indicativoProf2,
	@indicativoProf3, 
	@idTipoInscricao, 
	@SubRegiao, 
	@TipoInscricao, 
	@TelefoneTrab,
	@Suspenso, 
	@CPF, 
	@DetalhedASituacao, 
	@socialNome,
	@DataSituacao,
	@AreaAtuacao
	
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    INSERT #Resultado
	    VALUES
	      (
	        @Sigla,
	        @IdProfissional,
	        @RegistroConselhoAtual,
	        @Nome,
	        @InibirVisualizacaoRegistroConselhoAtual,
	        @CategoriaAtual,
	        @SituacaoAtual,
	        @RegiaoConselho,
	        @NomeCidadeAux,
	        NULL,
	        NULL,
	        @indicativoProf1,
	        @indicativoProf2,
	        @indicativoProf3,
	        @idTipoInscricao,
	        @SubRegiao,
	        @TipoInscricao,
	        @TelefoneTrab,
	        @Suspenso,
	        @CPF,
	        @DetalhedASituacao,
	        @socialNome,
	        @DataSituacao,
	        @AreaAtuacao
	      )                              
	    SET @iContador = 1
	    
	    SET @bUpdate = 1 
	    
	    /********** ESPECIALIDADES **********/                          
	    
	    IF @bListarEspecialidades = 1
	    BEGIN
	        DECLARE crEspecialidades CURSOR FAST_FORWARD 
	        FOR
	            SELECT NomeEspecialidade
	            FROM   Especialidades
	                   LEFT JOIN EspecialidadesProfissional
	                        ON  EspecialidadesProfissional.IdEspecialidade = 
	                            Especialidades.IdEspecialidade
	            WHERE  EspecialidadesProfissional.IdProfissional = @IdProfissional
	            ORDER BY
	                   NomeEspecialidade
	        
	        OPEN crEspecialidades 
	        
	        FETCH NEXT FROM crEspecialidades INTO @NomeEspecialidadeAux
	        
	        WHILE (@@FETCH_STATUS = 0)
	              AND (@iContador < = @MaxEspecialidades)
	        BEGIN
	            IF @iContador <= @MaxEspecialidades
	            BEGIN
	                IF @bUpdate = 1
	                BEGIN
	                    UPDATE #Resultado
	                    SET    Especialidade = @NomeEspecialidadeAux
	                    WHERE  Ident = @@IDENTITY
	                    
	                    SET @bUpdate = 0
	                END
	                ELSE
	                    INSERT #Resultado
	                    VALUES
	                      (
	                        @IdProfissional,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        @NomeEspecialidadeAux,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL
	                      )                              
	                
	                SET @iContador = @iContador + 1
	            END 
	            
	            FETCH NEXT FROM crEspecialidades INTO @NomeEspecialidadeAux
	        END 
	        CLOSE crEspecialidades 
	        DEALLOCATE crEspecialidades
	    END 
	    /********** ESPECIALIDADES **********/                          
	    
	    SET @iContador = 1
	    
	    SET @bUpdate = 1
	    
	    /********** CURSO - NIVEL **********/                                             
	    IF @bListarCurso_Nivel = 1
	    BEGIN
	        DECLARE crCurso_Nivel CURSOR FAST_FORWARD 
	        FOR
	            SELECT CursosEventos.NomeCursoEvento 
	                   +
	                   ' - ' 
	                   +
	                   NiveisCurso.NivelCurso AS [Curso_Nivel]
	            FROM   CursosEventosRealizado
	                   LEFT JOIN CursosEventos
	                        ON  CursosEventos.IdCursoEvento = 
	                            CursosEventosRealizado.IdCursoEvento
	                   LEFT JOIN NiveisCurso
	                        ON  NiveisCurso.IdNivelCurso = CursosEventos.IdNivelCurso
	            WHERE  CursosEventosRealizado.IdProfissional = @IdProfissional
	                   AND CursosEventosRealizado.E_Curso = 1
	                   AND NiveisCurso.NivelCurso 
	                       LIKE 
	                       @Curso_Nivel
	            ORDER BY
	                   CursosEventos.NomeCursoEvento
	        
	        OPEN crCurso_Nivel 
	        FETCH NEXT FROM crCurso_Nivel INTO @NomeCursoAux	        
	        
	        WHILE (@@FETCH_STATUS = 0)
	              AND (@iContador < = @MaxCurso_Nivel)
	        BEGIN
	            IF @iContador <= @MaxCurso_Nivel
	            BEGIN
	                IF @bUpdate = 1
	                BEGIN
	                    UPDATE #Resultado
	                    SET    Curso_Nivel = @NomeCursoAux
	                    WHERE  Ident = @@IDENTITY
	                    
	                    SET @bUpdate = 0
	                END
	                ELSE
	                    INSERT #Resultado
	                    VALUES
	                      (
	                        @IdProfissional,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        @NomeCursoAux,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL,
	                        NULL
	                      )                                          
	                
	                SET @iContador = @iContador 
	                    +
	                    1
	            END 
	            
	            FETCH NEXT FROM crCurso_Nivel INTO @NomeCursoAux
	        END 
	        CLOSE crCurso_Nivel 
	        DEALLOCATE crCurso_Nivel
	    END
	    
	    /********** CURSO - NIVEL **********/ 
	    
	    /********** REGRA PARA ENDEREÃƒâ€¡O **********/                             
	    
	    IF @NomeCidadeAux IS NULL
	    BEGIN
	        SELECT TOP 
	               1 
	               @NomeCidadeAux = NomeCidade
	        FROM   ENDerecos
	        WHERE  IdProfissional = @IdProfissional
	               AND Atualizado = 1                                          
	        
	        IF @NomeCidadeAux IS NULL
	            SELECT TOP 
	                   1 
	                   @NomeCidadeAux = NomeCidade
	            FROM   ENDerecos
	            WHERE  IdProfissional = @IdProfissional
	    END 
	    
	    /********** REGRA PARA ENDEREÃƒâ€¡O **********/ 
	    
	    FETCH NEXT FROM crProfissionais INTO 
	    @Sigla, 
	    @IdProfissional, 
	    @RegistroConselhoAtual,
	    @Nome,
	    @InibirVisualizacaoRegistroConselhoAtual, 
	    @CategoriaAtual, 
	    @SituacaoAtual, 
	    @RegiaoConselho, 
	    @NomeCidadeAux,
	    @indicativoProf1,
	    @indicativoProf2,
	    @indicativoProf3,
	    @idTipoInscricao, 
	    @SubRegiao, 
	    @TipoInscricao, 
	    @TelefoneTrab ,
	    @Suspenso, 
	    @CPF, 
	    @DetalhedASituacao, 
	    @socialNome,
	    @DataSituacao,
	    @AreaAtuacao
	END 
	
	CLOSE crProfissionais 
	DEALLOCATE crProfissionais
	
	IF @NomeCidade IS NULL
	    SET @nomeCidade = 'null'
	
	IF @NomeEspecialidade IS NULL
	    SET @NomeEspecialidade = 'null'
	ELSE
	    SET @NomeEspecialidade = '''' + @NomeEspecialidade + ''''
	
	IF @Curso_Nivel IS NULL
	    SET @Curso_Nivel = 'null'
	ELSE
	    SET @Curso_Nivel = '''%' + @Curso_Nivel + '%'''
	
	DECLARE @ExibeEspecialidade  VARCHAR(100),
	        @ExibeCursoNivel     VARCHAR(100)
	
	SELECT @ExibeEspecialidade = CASE @EscondeEspecialidade
	                                  WHEN 1 THEN ''''' AS Especialidade '
	                                  ELSE ' Especialidade '
	                             END,
	       @ExibeCursoNivel = CASE @EscondeCursoNivel
	                               WHEN 1 THEN ''''' AS Curso_Nivel '
	                               ELSE ' Curso_Nivel '
	                          END    
	
	
	EXEC (
	         'SELECT Ident,sigla, IdProfissional, RegistroConselho,
								Nome,InibirVisualizacaoRegistroConselhoAtual , CategoriaAtual, SituacaoAtual ,                                          
								RegiaoConselho , Cidade, ' + @ExibeEspecialidade 
	         + ' , ' +
	         @ExibeCursoNivel + 
	         ' ,                                  
								CASE indicativoProf1 WHEN ''1'' THEN ''SIM'' WHEN ''0'' THEN ''NÃ£o'' ELSE ''-'' END AS indicativoProf1,                                  
								CASE indicativoProf2 WHEN ''1'' THEN ''SIM'' WHEN ''0'' THEN ''NÃ£o'' ELSE ''-'' END AS indicativoProf2,                                  
								CASE indicativoProf3 WHEN ''1'' THEN ''SIM'' WHEN ''0'' THEN ''NÃ£o'' ELSE ''-'' END AS indicativoProf3,                              
								SubRegiao, TipoInscricao, TelefoneTrab,                    
								(SELECT TOP 1 1                
								   FROM SituacoesPFPJ sp                
								  WHERE sp.NomeSituacao COLLATE Latin1_General_CI_AI = SituacaoAtual COLLATE Latin1_General_CI_AI
									' + @idSituacoes + 
	         ') AS ExibirDetalhes, 0 AS UtilizAServidorExterno, 
									'''' AS ENDerecoServidorExterno, Cpf, DetalheSituacao, NomeSocial, DataSituacao, AreaAtuacao                                                                  
					FROM #Resultado WHERE
								/* ( ( Cidade LIKE  ' + @NomeCidade + 
	         '  ) OR (  ' + @NomeCidade + 
	         '  IS NULL ) ) AND */
								( ( Especialidade LIKE   ' + @NomeEspecialidade 
	         + '  ) OR (  ' + @NomeEspecialidade + 
	         '  IS NULL ) )
					 AND
								( ( Curso_Nivel LIKE ' + @Curso_Nivel + 
	         ' ) OR ( ' + @Curso_Nivel + '  IS NULL ) )	' +
	         @sqlIndicativos + @sqlSituacaoEspecifica +
	         ' ORDER BY Nome'
	     ) 
	
	/*                                
	Web_ConsultASimplesPF 'CRPRJ',null,null,'maria%',null,null,null,null,null,null,null,null,null,null,0,null,null,null                                            
	*/ 
	DROP TABLE #Resultado                                           	
	SET NOCOUNT ON
END
