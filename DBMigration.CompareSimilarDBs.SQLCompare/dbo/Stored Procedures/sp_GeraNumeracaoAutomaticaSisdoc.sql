																											
-- ============================================================================
--	sp_GeraNumeracaoAutomaticaSisdoc
-- ============================================================================
CREATE PROCEDURE [dbo].[sp_GeraNumeracaoAutomaticaSisdoc]
	@IdModeloDocumento INT
AS
BEGIN
	DECLARE @TipoNumeracaoAutomatica  INT,
	        @NumeroDocumento          VARCHAR(50),
	        @ReiniciarAnual           INT,
	        @TamanhoNumeroAuto        INT,
	        @Prefixo                  VARCHAR(20),
	        @Sufixo                   VARCHAR(20),
	        @IdTipoDocumento          INT,
	        @sWhere                   VARCHAR(200),
	        @sSQL                     VARCHAR(500)
	
	CREATE TABLE #TmpNumero
	(
		Numero VARCHAR(20)
	) 
	SELECT @TipoNumeracaoAutomatica = COALESCE(td.TipoNumeracaoAutomatica, m.TipoNumeracaoAutomatica),
	       @NumeroDocumento = NULL,
	       @ReiniciarAnual = COALESCE(td.ReiniciaNumeracaoAnual, m.ReiniciaNumeracaoAnual),
	       @TamanhoNumeroAuto = COALESCE(td.TamanhoNumeroAuto, m.TamanhoNumeroAuto),
	       @Prefixo = ISNULL(
	           CASE 
	                WHEN COALESCE(td.TipoNumeracaoAutomatica, m.TipoNumeracaoAutomatica) 
	                     = 2 THEN (
	                         SELECT td.Prefixo
	                         FROM   TiposDocumentos td
	                         WHERE  td.IdTipoDocumento = COALESCE(IdTipoDocumentoNumeracao, m.IdTipoDocumento)
	                     )
	                ELSE PrefixoModelo
	           END,
	           ''
	       ),
	       @Sufixo = ISNULL(
	           CASE 
	                WHEN COALESCE(td.TipoNumeracaoAutomatica, m.TipoNumeracaoAutomatica)
	                     = 2 THEN (
	                         SELECT td.Sufixo
	                         FROM   TiposDocumentos td
	                         WHERE  td.IdTipoDocumento = COALESCE(IdTipoDocumentoNumeracao, m.IdTipoDocumento)
	                     )
	                ELSE SufixoModelo
	           END,
	           ''
	       ),
	       @IdTipoDocumento = COALESCE(td.IdTipoDocumento, m.IdTipoDocumento)
	FROM   ModelosDocumento m
	       LEFT JOIN TiposDocumentos td
	            ON  td.IdTipoDocumento = ISNULL(m.IdTipoDocumentoNumeracao, m.IdTipoDocumento)
	WHERE  IdModelodocumento = @IdModeloDocumento	
	
	
	IF @TipoNumeracaoAutomatica IN (2, 3)
	BEGIN
	    PRINT 'entrou'
	    IF @TamanhoNumeroAuto > 0
	    BEGIN
	        IF @TipoNumeracaoAutomatica = 2
	        BEGIN
	            SELECT @sWhere = 'IdTipoDocumento = ' + CAST(@IdTipoDocumento AS VARCHAR),
	                   @sSQL = 'EXEC spProximoNumero @Pre = ''' + @Prefixo +
	                   ''', @Suf = ''' + @Sufixo + ''', @Tam = ' + CAST(@TamanhoNumeroAuto AS VARCHAR)
	                   +
	                   ', @Ano = '''', @Tabela = ''DocumentosSisdoc'',   @Campo = ''NumeroDocumento'', @Where = ''' 
	                   + @sWhere +
	                   ''', @ResetAnual = ' + CAST(@ReiniciarAnual AS VARCHAR) +
	                   ''
	        END
	        ELSE
	        BEGIN
	            SELECT @sWhere = 'IdModeloDocumento = ' + CAST(@IdModeloDocumento AS VARCHAR),
	                   @sSQL = 'EXEC spProximoNumero @Pre = ''' + @Prefixo +
	                   ''', @Suf = ''' + @Sufixo + ''', @Tam = ' + CAST(@TamanhoNumeroAuto AS VARCHAR)
	                   +
	                   ', @Ano = '''', @Tabela = ''DocumentosSisdoc'', @Campo = ''NumeroDocumento'',  @Where = ''' 
	                   + @sWhere +
	                   ''', @ResetAnual  = ' + CAST(@ReiniciarAnual AS VARCHAR) 
	                   + ''
	        END PRINT @sSQL  
	        INSERT INTO #TmpNumero
	        EXEC (@sSQL)
	        
	        SELECT NumeroDocumento = CASE 
	                                      WHEN (LTRIM(RTRIM(@Prefixo + @Sufixo)) = '') THEN 
	                                           SUBSTRING(t.numero, 2, LEN(t.numero))
	                                      ELSE t.numero
	                                 END
	        FROM   #TmpNumero t
	    END
	    ELSE
	        SELECT NULL AS NumeroDocumento
	END
	ELSE
	    SELECT NULL AS NumeroDocumento
	
	DROP TABLE #TmpNumero
END
