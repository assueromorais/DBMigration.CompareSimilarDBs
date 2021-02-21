/*
 * Oc 187691
 * Criado por Wesley Silva
 * Adicionado por Leandro
 */
 
 CREATE FUNCTION [dbo].[ufnFiscalizadoOutros]
(
	@IdFiscalizacao INT
)
RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @SEQ INT = 1,
			@NOME VARCHAR(8000)   = '',
			@SEPARADOR VARCHAR(5) = ', ', 
			@CONT INT = (SELECT COUNT(1) FROM Fiscalizacoes_Prof_PJ WHERE IdFiscalizacao = @IdFiscalizacao)
	
	DECLARE @Fiscaliz_temp TABLE(ID INT,NOME VARCHAR(8000))

	INSERT INTO @Fiscaliz_temp (ID,NOME)
	SELECT ROW_NUMBER() OVER(PARTITION BY IdFiscalizacao ORDER BY IdFiscalizacao ASC ) ID,
			CASE 
			WHEN fpp.IdProfissional   IS NOT NULL THEN ( SELECT Nome FROM Profissionais p     WHERE p.IdProfissional = fpp.IdProfissional )
			WHEN fpp.IdPessoaJuridica IS NOT NULL THEN ( SELECT Nome FROM PessoasJuridicas pj WHERE pj.IdPessoaJuridica = fpp.IdPessoaJuridica )
			WHEN fpp.IdPessoa         IS NOT NULL THEN ( SELECT Nome FROM Pessoas pe          WHERE pe.IdPessoa = fpp.IdPessoa )
			END AS NOME 
	FROM Fiscalizacoes_Prof_PJ fpp 
	WHERE IdFiscalizacao = @IdFiscalizacao

	WHILE @SEQ <= @CONT 
	BEGIN
		IF @SEQ = @CONT BEGIN 
			SET @SEPARADOR = ' e ' 
		END
		ELSE BEGIN 
			SET @SEPARADOR = ', ' 
		END

		IF @NOME = '' BEGIN 
			SET @SEPARADOR = '' 
		END

		SET @NOME = @NOME + @SEPARADOR + (SELECT NOME FROM @Fiscaliz_temp WHERE ID = @SEQ)
		SET @SEQ = @SEQ + 1 
	END

  RETURN @NOME

END
