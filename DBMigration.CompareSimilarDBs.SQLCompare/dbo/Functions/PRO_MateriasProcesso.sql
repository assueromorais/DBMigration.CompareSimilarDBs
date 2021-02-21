

CREATE FUNCTION dbo.PRO_MateriasProcesso(@pIdProcesso as int)RETURNS NVARCHAR(1000)    
BEGIN 
    DECLARE @Resultado AS NVARCHAR(1000)
	SET @Resultado = ''
	
	SELECT @Resultado = @Resultado + Descricao + ' ;  '	 
    FROM (
		SELECT ProcessosLista1.Descricao 	  
		FROM Processos_ProcessosLista1 
			LEFT JOIN ProcessosLista1 ON ProcessosLista1.IdProcessoLista1 = Processos_ProcessosLista1.idProcessoLista1
		WHERE Processos_ProcessosLista1.idProcesso = @pIdProcesso              
		GROUP BY ProcessosLista1.Descricao
		) TB

    RETURN @Resultado
END



