

/*Oc. 99421 - Gustavo*/

CREATE FUNCTION dbo.Calcular_Qtde
(
	@NomeTabela  VARCHAR(250),
	@IdTabela    INT,
	@IdDetalhe   INT,
	@TipoPessoa  INT -- 0 TODOS, 1 PF, 2 PJ, 3 OP
)
RETURNS Integer
AS
BEGIN
	DECLARE @Resultado              INT     	
	DECLARE @TotalProfissionais     INT     	
	DECLARE @TotalPessoasJuridicas  INT     	
	DECLARE @TotalPessoas           INT     	
	SET @Resultado = 0     	
	IF (@NomeTabela = 'AreasAtuacao')
	BEGIN
	    SET @TotalProfissionais = (
	            SELECT COUNT(DISTINCT Profissionais.IdProfissional)
	            FROM   Profissionais
	                   INNER JOIN ExperienciasProfissionais
	                        ON  ExperienciasProfissionais.IdProfissional = Profissionais.IdProfissional
	            WHERE  ExperienciasProfissionais.IdAreaAtuacao = @IdTabela
	        )
	    
	    SET @TotalPessoasJuridicas = (
	            SELECT COUNT(DISTINCT PessoasJuridicas.IdPessoaJuridica)
	            FROM   PessoasJuridicas
	                   INNER JOIN AreasAtuacao_PessoasJuridicas
	                        ON  AreasAtuacao_PessoasJuridicas.IdPessoaJuridica = PessoasJuridicas.IdPessoaJuridica
	            WHERE  AreasAtuacao_PessoasJuridicas.IdAreaAtuacao = @IdTabela
	        )
	    
	    SET @TotalPessoas = (
	            SELECT COUNT(DISTINCT Pessoas.IdPessoa)
	            FROM   Pessoas
	                   INNER JOIN AreasAtuacao_Pessoas
	                        ON  AreasAtuacao_Pessoas.IdPessoa = Pessoas.IdPessoa
	            WHERE  AreasAtuacao_Pessoas.IdAreaAtuacao = @IdTabela
	        )
	END
	ELSE      	
	IF (@NomeTabela = 'CursosEventosRealizado')
	BEGIN
	    SET @TotalProfissionais = (
	            SELECT COUNT(DISTINCT Profissionais.IdProfissional)
	            FROM   Profissionais
	                   INNER JOIN CursosEventosRealizado
	                        ON  CursosEventosRealizado.IdProfissional = Profissionais.IdProfissional
	                   INNER JOIN ValoresDominio
	                        ON  CursosEventosRealizado.TipoDocumento = ValoresDominio.CodigoDominio
	            WHERE  ValoresDominio.IdDominio = @IdTabela
	        )
	    
	    SET @TotalPessoasJuridicas = 0     	    
	    SET @TotalPessoas = (
	            SELECT COUNT(DISTINCT Pessoas.IdPessoa)
	            FROM   Pessoas
	                   INNER JOIN CursosEventosRealizado
	                        ON  CursosEventosRealizado.IdPessoa = Pessoas.IdPessoa
	                   INNER JOIN ValoresDominio
	                        ON  CursosEventosRealizado.TipoDocumento = ValoresDominio.CodigoDominio
	            WHERE  ValoresDominio.IdDominio = @IdTabela
	        )
	END
	ELSE      	
	IF (@NomeTabela = 'Enderecos')
	BEGIN
	    SET @TotalProfissionais = (
	            SELECT COUNT(DISTINCT Profissionais.IdProfissional)
	            FROM   Profissionais
	                   INNER JOIN Enderecos
	                        ON  Enderecos.IdProfissional = Profissionais.IdProfissional
	                   INNER JOIN ValoresDominio
	                        ON  Enderecos.E_Residencial = ValoresDominio.CodigoDominio
	            WHERE  ValoresDominio.IdDominio = @IdTabela
	        )
	    
	    SET @TotalPessoasJuridicas = (
	            SELECT COUNT(DISTINCT PessoasJuridicas.IdPessoaJuridica)
	            FROM   PessoasJuridicas
	                   INNER JOIN Enderecos
	                        ON  Enderecos.IdPJTrabalho = PessoasJuridicas.IdPessoaJuridica
	                   INNER JOIN ValoresDominio
	                        ON  Enderecos.E_Residencial = ValoresDominio.CodigoDominio
	            WHERE  ValoresDominio.IdDominio = @IdTabela
	        )
	    
	    SET @TotalPessoas = (
	            SELECT COUNT(DISTINCT Pessoas.IdPessoa)
	            FROM   Pessoas
	                   INNER JOIN Enderecos
	                        ON  Enderecos.IdPessoa = Pessoas.IdPessoa
	                   INNER JOIN ValoresDominio
	                        ON  Enderecos.E_Residencial = ValoresDominio.CodigoDominio
	            WHERE  ValoresDominio.IdDominio = @IdTabela
	        )
	END/*ELSE IF (@NomeTabela = 'ExperienciasProfissionais') - Carga horária semanal */
	ELSE      	
	IF (@NomeTabela = 'MotivoInscricao')
	BEGIN
	    SET @TotalProfissionais = (
	            SELECT COUNT(DISTINCT Profissionais.IdProfissional)
	            FROM   Profissionais
	                   INNER JOIN Profissionais_CategoriasProf
	                        ON  Profissionais_CategoriasProf.IdProfissional = Profissionais.IdProfissional
	            WHERE  Profissionais_CategoriasProf.IdMotivoInscricao = @IdTabela
	        )
	    
	    SET @TotalPessoasJuridicas = (
	            SELECT COUNT(DISTINCT PessoasJuridicas.IdPessoaJuridica)
	            FROM   PessoasJuridicas
	                   INNER JOIN PessoasJuridicas_CategoriaPJ
	                        ON  PessoasJuridicas_CategoriaPJ.IdPessoaJuridica = PessoasJuridicas.IdPessoaJuridica
	            WHERE  PessoasJuridicas_CategoriaPJ.IdMotivoInscricao = @IdTabela
	        )
	    
	    SET @TotalPessoas = 0     	    
	END
	ELSE      	
	IF (@NomeTabela = 'NaturezasPJ')
	BEGIN
	    SET @TotalProfissionais = (
	            SELECT COUNT(DISTINCT Profissionais.IdProfissional)
	            FROM   Profissionais
	                   INNER JOIN ExperienciasProfissionais
	                        ON  ExperienciasProfissionais.IdProfissional = Profissionais.IdProfissional
	            WHERE  ExperienciasProfissionais.IdNatureza = @IdTabela
	        )
	    
	    SET @TotalPessoasJuridicas = (
	            SELECT COUNT(DISTINCT PessoasJuridicas.IdPessoaJuridica)
	            FROM   PessoasJuridicas
	            WHERE  PessoasJuridicas.IdNatureza = @IdTabela
	        )
	    
	    SET @TotalPessoas = (
	            SELECT COUNT(DISTINCT Pessoas.IdPessoa)
	            FROM   Pessoas
	            WHERE  Pessoas.IdNatureza = @IdTabela
	        )
	END
	ELSE      	
	IF (@NomeTabela = 'NiveisCurso')
	BEGIN
	    SET @TotalProfissionais = (
	            SELECT COUNT(DISTINCT Profissionais.IdProfissional)
	            FROM   Profissionais
	                   INNER JOIN CursosEventosRealizado
	                        ON  CursosEventosRealizado.IdProfissional = Profissionais.IdProfissional
	                   INNER JOIN CursosEventos
	                        ON  CursosEventos.IdCursoEvento = CursosEventosRealizado.IdCursoEvento
	            WHERE  CursosEventos.IdNivelCurso = @IdTabela
	        )
	    
	    SET @TotalPessoasJuridicas = 0     	    
	    SET @TotalPessoas = (
	            SELECT COUNT(DISTINCT Pessoas.IdPessoa)
	            FROM   Pessoas
	                   INNER JOIN CursosEventosRealizado
	                        ON  CursosEventosRealizado.IdPessoa = Pessoas.IdPessoa
	                   INNER JOIN CursosEventos
	                        ON  CursosEventos.IdCursoEvento = CursosEventosRealizado.IdCursoEvento
	            WHERE  CursosEventos.IdNivelCurso = @IdTabela
	        )
	END
	ELSE      	
	IF (@NomeTabela = 'SituacoesPFPJ')
	BEGIN
	    SET @TotalProfissionais = (
	            SELECT COUNT(DISTINCT pf.IdProfissional)
	            FROM   Profissionais pf
	                   INNER JOIN Profissionais_SituacoesPF psp
	                        ON  psp.IdProfissional = pf.IdProfissional
	            WHERE  psp.IdSituacaoPFPJ = @IdTabela AND ((psp.IdDetalheSituacao = @IdDetalhe) OR (@IdDetalhe = 0 AND psp.IdDetalheSituacao IS NULL)) 
	        )
	    
	    SET @TotalPessoasJuridicas = (
	            SELECT COUNT(DISTINCT pj.IdPessoaJuridica)
	            FROM   PessoasJuridicas pj
	                   INNER JOIN PessoasJuridicas_SituacoesPFPJ pjsp
	                        ON  pjsp.IdPessoaJuridica = pj.IdPessoaJuridica
	            WHERE  pjsp.IdSituacaoPFPJ = @IdTabela AND ((pjsp.IdDetalheSituacao = @IdDetalhe) OR (@IdDetalhe = 0 AND pjsp.IdDetalheSituacao IS NULL))
	        )
	    
	    SET @TotalPessoas = 0     	    
	END
	ELSE    
	IF (@NomeTabela = 'CategoriasPJ') OR (@NomeTabela = 'CategoriasProf')
	BEGIN
	    SET @TotalProfissionais = (
	            SELECT COUNT(DISTINCT Profissionais.IdProfissional)
	            FROM   Profissionais
	                   INNER JOIN Profissionais_CategoriasProf 
							ON Profissionais_CategoriasProf.IdProfissional = Profissionais.IdProfissional
	            WHERE  Profissionais_CategoriasProf.IdCategoriaProf = @IdTabela
	        )
	    
	    SET @TotalPessoasJuridicas = (
	            SELECT COUNT(DISTINCT PessoasJuridicas.IdPessoaJuridica)
	            FROM   PessoasJuridicas
	                   INNER JOIN PessoasJuridicas_CategoriaPJ
	                        ON PessoasJuridicas_CategoriaPJ.IdPessoaJuridica = PessoasJuridicas.IdPessoaJuridica
	            WHERE  PessoasJuridicas_CategoriaPJ.IdCategoriaPJ = @IdTabela
	        )
	    
	    SET @TotalPessoas = 0     	    
	END
	ELSE 		  	
	IF (@NomeTabela = 'TiposInscricao')
	BEGIN
	    SET @TotalProfissionais = (
	            SELECT COUNT(DISTINCT Profissionais.IdProfissional)
	            FROM   Profissionais
	            WHERE  Profissionais.IdTipoInscricao = @IdTabela
	        )
	    
	    SET @TotalPessoasJuridicas = (
	            SELECT COUNT(DISTINCT PessoasJuridicas.IdPessoaJuridica)
	            FROM   PessoasJuridicas
	            WHERE  PessoasJuridicas.IdTipoInscricao = @IdTabela
	        )
	    
	    SET @TotalPessoas = 0     	    
	END
	ELSE      	
	IF (@NomeTabela = 'VinculosEmpregaticio')
	BEGIN
	    SET @TotalProfissionais = (
	            SELECT COUNT(DISTINCT Profissionais.IdProfissional)
	            FROM   Profissionais
	                   INNER JOIN ExperienciasProfissionais
	                        ON  ExperienciasProfissionais.IdProfissional = Profissionais.IdProfissional
	            WHERE  ExperienciasProfissionais.IdVinculo = @IdTabela
	        )
	    
	    SET @TotalPessoasJuridicas = 0     	    
	    SET @TotalPessoas = 0     	    
	END
	
	SELECT @Resultado = CASE 
	                         WHEN @TipoPessoa = 0 THEN @TotalProfissionais + @TotalPessoasJuridicas + @TotalPessoas
	                         WHEN @TipoPessoa = 1 THEN @TotalProfissionais
	                         WHEN @TipoPessoa = 2 THEN @TotalPessoasJuridicas
	                         WHEN @TipoPessoa = 3 THEN @TotalPessoas
	                         ELSE 0
	                    END
		
	RETURN (@Resultado)
END
