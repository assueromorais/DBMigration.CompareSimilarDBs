CREATE FUNCTION [dbo].[ufnProcessado]
(
	@IdProcesso INT
)
RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @Nome VARCHAR(250) 
	SELECT @Nome = (
	           SELECT TOP 1
	                  CASE 
	                       WHEN ppp.IdProfissional IS NOT NULL THEN (
	                                SELECT Nome
	                                  FROM Profissionais p
	                                 WHERE p.IdProfissional = ppp.IdProfissional
	                            )
	                       WHEN ppp.IdPessoaJuridica IS NOT NULL THEN (
	                                SELECT Nome
	                                  FROM PessoasJuridicas pj
	                                 WHERE pj.IdPessoaJuridica = ppp.IdPessoaJuridica
	                            )
	                       WHEN ppp.IdPessoa IS NOT NULL THEN (
	                                SELECT Nome
	                                  FROM Pessoas pe
	                                 WHERE pe.IdPessoa = ppp.IdPessoa
	                            )
	                  END
	             FROM Processos_Prof_PJ ppp
	            WHERE ppp.IdProcesso = @IdProcesso
	       ) + (
	           SELECT CASE COUNT(ppp.IdProcessos_Prof_PJ)
	                       WHEN 1 THEN ''
	                       ELSE ' e outros '
	                  END
	             FROM Processos_Prof_PJ ppp
	            WHERE ppp.IdProcesso = @IdProcesso
	       )
	
	RETURN @Nome
END