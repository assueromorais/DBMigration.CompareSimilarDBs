/* OC 142345 - Seila */

CREATE FUNCTION [dbo].[ufnAreaAtuacao](@IdExperienciaProfissional INT) 
	RETURNS VARCHAR(MAX) AS 
BEGIN	
	DECLARE @Retorno VARCHAR(MAX),@IdFiltro INT,@Texto VARCHAR(MAX)		
	DECLARE @Filtro TABLE (IdFiltro INT IDENTITY,Campo01 VARCHAR(60))
	SET @Retorno = ''
	
	INSERT INTO @Filtro(Campo01)
		SELECT AA.AreaAtuacao 
		FROM AreasAtuacao_PessoasJuridicas JP INNER JOIN 
			 AreasAtuacao AA ON AA.IdAreaAtuacao = JP.IdAreaAtuacao INNER JOIN 
			 ExperienciasProfissionais EP ON EP.IdPessoaJuridica = JP.IdPessoaJuridica
		WHERE EP.IdExperienciaProfissional = @IdExperienciaProfissional  
		UNION ALL 
		SELECT AA.AreaAtuacao 
		FROM AreasAtuacao_Pessoas JE INNER JOIN 
			 AreasAtuacao AA ON AA.IdAreaAtuacao = JE.IdAreaAtuacao INNER JOIN 
			 ExperienciasProfissionais EP ON EP.IdPessoa = JE.IdPessoa
		WHERE EP.IdExperienciaProfissional = @IdExperienciaProfissional	
		
	SELECT @IdFiltro = MIN(IdFiltro)
	FROM @Filtro		
	WHILE @IdFiltro IS NOT NULL 			
	BEGIN					
			SELECT @Texto = (Campo01)							
			FROM @Filtro
			WHERE IdFiltro = @IdFiltro
			
			IF @Retorno = '' 
				SET @Retorno = @Texto
			ELSE					
				SET @Retorno = @Retorno + CHAR(32) + ';' + CHAR(32) +  @Texto
		
		SELECT @IdFiltro = MIN(IdFiltro)
		FROM @Filtro
		WHERE IdFiltro > @IdFiltro	
	END 
	RETURN(@Retorno)
END 
