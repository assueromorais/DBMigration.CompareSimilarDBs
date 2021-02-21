/*
 * Oc 187691
 * Criado por Wesley Silva
 * Adicionado por Leandro
 */
 
CREATE FUNCTION [dbo].[ufnFiscalizadoCompleto]
(
	@IdFiscalizacao INT
)
RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @Nome VARCHAR(250) 
	SELECT @Nome = (
	           SELECT TOP 1
	                  CASE 
	                       WHEN fpp.IdProfissional IS NOT NULL THEN (
	                                SELECT Nome
	                                  FROM Profissionais p
	                                 WHERE p.IdProfissional = fpp.IdProfissional
	                            )
	                       WHEN fpp.IdPessoaJuridica IS NOT NULL THEN (
	                                SELECT Nome
	                                  FROM PessoasJuridicas pj
	                                 WHERE pj.IdPessoaJuridica = fpp.IdPessoaJuridica
	                            )
	                       WHEN fpp.IdPessoa IS NOT NULL THEN (
	                                SELECT Nome
	                                  FROM Pessoas pe
	                                 WHERE pe.IdPessoa = fpp.IdPessoa
	                            )
	                  END
	             FROM Fiscalizacoes_Prof_PJ fpp
	            WHERE fpp.IdFiscalizacao = @IdFiscalizacao
	       ) + (
	           SELECT CASE COUNT(fpp.IdFiscalizacao_Prof_PJ)
	                       WHEN 1 THEN ''
	                       ELSE dbo.ufnFiscalizadoOutros(@IdFiscalizacao)
	                  END
	             FROM Fiscalizacoes_Prof_PJ fpp
	            WHERE fpp.IdFiscalizacao = @IdFiscalizacao
	       )
	
	RETURN @Nome
END
