/* OC 53039 - Selvino */
CREATE FUNCTION [dbo].[CampoGridProcesso]
(
	@IdProcesso  INT,
	@Campo       VARCHAR(100)
)
RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @IdProfissional    INT
	DECLARE @IdPessoaJuridica  INT
	DECLARE @IdPessoa          INT
	DECLARE @NOMES             VARCHAR(1000)
	DECLARE @NOME              VARCHAR(200)
	SET @NOMES = ''
	IF @Campo = 'CampoGrid'
	    DECLARE campo_grid_cursor CURSOR FAST_FORWARD READ_ONLY 
	    FOR
	        SELECT ppp.IdProfissional,
	               ppp .IdPessoaJuridica,
	               ppp .IdPessoa
	        FROM   Processos_Prof_PJ ppp
	        WHERE  ppp.IdProcesso = @IdProcesso
	
	IF @Campo = 'CampoGridDinamico'
	    DECLARE campo_grid_cursor CURSOR FAST_FORWARD READ_ONLY 
	    FOR
	        SELECT pppp.IdProfissional,
	               pppp .IdPessoaJuridica,
	               pppp .IdPessoa
	        FROM   Processos_Prof_PJ_Pessoas1 pppp
	        WHERE  pppp.IdProcesso = @IdProcesso
	
	OPEN campo_grid_cursor
	FETCH FROM campo_grid_cursor INTO @IdProfissional, @IdPessoaJuridica, @IdPessoa                                       

                
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    SELECT @NOME = CASE 
	                        WHEN @IdProfissional IS NOT NULL THEN (
	                                 SELECT Nome
	                                 FROM   Profissionais
	                                 WHERE  IdProfissional = @IdProfissional
	                             )
	                        WHEN @IdPessoaJuridica IS NOT NULL THEN (
	                                 SELECT Nome
	                                 FROM   PessoasJuridicas
	                                 WHERE  IdPessoaJuridica = @IdPessoaJuridica
	                             )
	                        WHEN @IdPessoa IS NOT NULL THEN (
	                                 SELECT Nome
	                                 FROM   Pessoas
	                                 WHERE  IdPessoa = @IdPessoa
	                             )
	                   END
	    
	    IF @NOMES > ''
	        SET @NOMES = @NOMES + CHAR(13)
	    
	    SET @NOMES = @NOMES + @NOME
	    FETCH FROM campo_grid_cursor INTO @IdProfissional, @IdPessoaJuridica, @IdPessoa
	END
	CLOSE campo_grid_cursor
	DEALLOCATE campo_grid_cursor
	RETURN @NOMES
END
