				
-- ============================================================================
--	sp_localizarRegiaoAdmistrativa
-- ============================================================================																																				
CREATE PROCEDURE dbo.sp_localizarRegiaoAdmistrativa
	@nomeCidade VARCHAR(100)
AS
BEGIN
	SELECT ci.IdCidade,
		   ci.NomeCidade,
		   ra.IdRegiaoAdministrativa,
		   ra.RegiaoAdministrativa,
		   p.IdPessoa AS IdPessoASeccional,
		   p.Nome AS NomeSeccional
	FROM   Cidades 
		   ci,
		   RegioesAdministrativAS 
		   ra,
		   PessoAS 
		   p
	WHERE  ci.IdRegiaoAdministrativa = ra.IdRegiaoAdministrativa
		   AND p.IdPessoa = ra.IdPessoaDelegacia
		   AND ci.NomeCidade = @nomeCidade
		   AND ci.Desativado = 0
	
END
