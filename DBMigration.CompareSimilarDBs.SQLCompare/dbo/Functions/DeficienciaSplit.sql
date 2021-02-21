	       
CREATE FUNCTION [dbo].[DeficienciaSplit]
(
	@idProfissional INT
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @idsDeficiencia VARCHAR(100)
	SET @idsDeficiencia = ''
	SELECT @idsDeficiencia = @idsDeficiencia + CAST(pd.IdDeficiencia AS VARCHAR) 
	       + ','
	FROM   Profissionais_Deficiencia pd
	WHERE  pd.IdProfissional = @idProfissional
	
	RETURN @idsDeficiencia
END
