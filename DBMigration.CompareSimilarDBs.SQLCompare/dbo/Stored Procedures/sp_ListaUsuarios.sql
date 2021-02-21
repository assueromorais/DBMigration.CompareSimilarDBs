																
-- ============================================================================
--	sp_ListaUsuarios
-- ============================================================================	
CREATE PROCEDURE sp_ListaUsuarios
	@sqlAdd VARCHAR(1000)
AS
	EXEC (
	         'SELECT * FROM usuariossiscafweb ' + @sqlAdd +
	         'ORDER BY (SELECT Nome FROM PessoAS WHERE IdPessoa = IdSubSecao), Usuario'
	     )
