																														
-- ============================================================================
--	sp_CarregaCursosEventosEspecializacaoPFWEB
-- ============================================================================																														
CREATE PROCEDURE 
[dbo].[Sp_CarregaCursosEventosEspecializacaoPFWEB]
	@IdProfissional INT = 0,
	@Acao INT = 0
AS
BEGIN
	SET NOCOUNT  ON
	
	DECLARE @IdEspecialidade INT,
	        @IdEspecialidadeUnidos VARCHAR(800)
	
	IF @IdProfissional > 0
	    IF @Acao = 1
	        SELECT IdCursoEventoRealizado,
	               IdCursoEvento,
	               (
	                   SELECT NomeCursoEvento
	                   FROM   CursosEventos 
	                          ce
	                   WHERE  ce.IdCursoEvento = CursosEventosRealizado.IdCursoEvento
	               ) AS NomeCursoEvento,
	               PessoAS.IdPessoa,
	               PessoAS.Nome,
	               IdSituacaoCurso,
	               (
	                   SELECT SituacaoCurso
	                   FROM   SituacoesCurso 
	                          sc
	                   WHERE  sc.IdSituacaoCurso = CursosEventosRealizado.IdSituacaoCurso
	               ) AS nomeSituacaoCurso,
	               Duracao,
	               UnidadeDuracao,
	               PeriodoRealizacao,
	               IdEspecialidade,
	               (
	                   SELECT NomeEspecialidade
	                   FROM   Especialidades 
	                          e
	                   WHERE  e.IdEspecialidade = CursosEventosRealizado.IdEspecialidade
	               ) AS NomeEspecialidade,
	               CONVERT(VARCHAR(10), DataConclusao, 103) AS DataConclusao,
	               CONVERT(VARCHAR(10), DataExpedicaoDocumento, 103) AS 
	               DataExpedicaoDocumento,
	               CONVERT(VARCHAR(10), DataColacaoGrau, 103) AS DataColacaoGrau,
	               ISNULL(E_CursoRegistro, 0) AS E_CursoRegistro,
	               TipoDocumento,
	               EnsinoDistancia
	        FROM   CursosEventosRealizado
	               LEFT JOIN PessoAS
	                    ON  PessoAS.IdPessoa = CursosEventosRealizado.IdPessoa
	        WHERE  CursosEventosRealizado.IdProfissional = @IdProfissional
	               AND E_Curso = 1
	
	IF @Acao = 2
	    SELECT IdCursoEventoRealizado,
	           PessoAS.IdPessoa,
	           PessoAS.Nome,
	           IdCursoEvento,
	           CONVERT(VARCHAR(10), DataConclusao, 103) AS DataConclusao,
	           Observacao
	    FROM   CursosEventosRealizado
	           LEFT JOIN PessoAS
	                ON  PessoAS.IdPessoa = CursosEventosRealizado.IdPessoa
	    WHERE  CursosEventosRealizado.IdProfissional = @IdProfissional
	           AND E_Curso != 1
	           AND E_CursoRegistro 
	               IS 
	               NULL
	
	IF @Acao = 3
	BEGIN
	    SET @IdEspecialidadeUnidos = ''
	    
	    DECLARE Especialidade_cursor CURSOR FAST_FORWARD 
	    FOR
	        SELECT IdEspecialidade
	        FROM   EspecialidadesProfissional
	        WHERE  IdProfissional = @IdProfissional
	    
	    OPEN 
	    Especialidade_cursor 
	    FETCH NEXT FROM Especialidade_cursor INTO @IdEspecialidade     
	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        SET @IdEspecialidadeUnidos = @IdEspecialidadeUnidos 
	            +
	            CAST(@IdEspecialidade AS VARCHAR) 
	            +
	            ','
	        
	        FETCH NEXT FROM Especialidade_cursor INTO @IdEspecialidade
	    END 
	    CLOSE Especialidade_cursor 
	    DEALLOCATE Especialidade_cursor     
	    SET @IdEspecialidadeUnidos = RTRIM(@IdEspecialidadeUnidos)
	    
	    SELECT 'IdEspecialidadeUnidos' = @IdEspecialidadeUnidos
	END
	
	SET NOCOUNT 
	    OFF 
	
END
