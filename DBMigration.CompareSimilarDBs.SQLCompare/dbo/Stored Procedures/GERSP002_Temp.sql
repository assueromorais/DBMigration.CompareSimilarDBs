

CREATE PROC dbo.GERSP002_Temp 
@OPCAO INT,
@DE_VAR_01 VARCHAR(50)= NULL
  
AS   
BEGIN
    DECLARE @Texto  VARCHAR(8000)
    SET @Texto = 'SELECT * FROM ( 
		SELECT 
		CentroCustos.*,
		CASE WHEN (
			SELECT COUNT(A.CodigoCentroCusto) 
			FROM CentroCustos A 
			INNER JOIN CentroCustos B ON B.CodigoCentroCusto like A.CodigoCentroCusto+''%'' 
			AND B.Evento = A.Evento 
			WHERE A.IdCentroCusto = CentroCustos.IdCentroCusto
			GROUP BY A.IdCentroCusto ) = 1 THEN ''1'' ELSE ''0'' END Analitico
		FROM CentroCustos 
		WHERE CentroCustos.Evento = 0) C
	WHERE CodigoCentroCusto LIKE ''' + @DE_VAR_01 + '%''
	AND Analitico = ''1''
	ORDER BY CodigoCentrocusto'

    IF @OPCAO = 1 
    BEGIN
        EXECUTE(@Texto)
    END
END




