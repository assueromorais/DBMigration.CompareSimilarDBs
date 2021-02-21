									
-- ============================================================================
--	sp_EnderecoDivulgacao
-- ============================================================================											
CREATE PROCEDURE [dbo].[sp_EnderecoDivulgacao]
	@idProf VARCHAR(10)
AS
BEGIN
	DECLARE @sql             VARCHAR(8000),
	        @sqlExperiencia  VARCHAR(8000)
	
	SET @sqlExperiencia = 'DECLARE @areatuacao VARCHAR(50) ' + CHAR(10)
	    + '    DECLARE @setoratuacao VARCHAR(50) ' + CHAR(10)
	    + '    DECLARE @textoAreaAtuacao VARCHAR(8000) ' + CHAR(10)
	    + '    DECLARE @textoSetorAtuacao VARCHAR(8000) ' + CHAR(10)
	    + '    DECLARE cExperiencias CURSOR FOR  ' + CHAR(10)
	    + 
	    '    SELECT  CASE WHEN ep.SetorAtuacaoDivulgacao = 1 THEN  s.SetorAtuacao ELSE  '''' END  AS SetorAtuacao,  ' 
	    + CHAR(10)
	    + 
	    '            CASE WHEN ep.AreaAtuacaoDivulgacao = 1 then a.AreaAtuacao ELSE '''' END AS AreaAtuacao ' 
	    + CHAR(10)
	    + '                     FROM   ExperienciasProfissionais AS ep ' + CHAR(10)
	    + '                            LEFT JOIN SetoresAtuacao AS s ' + CHAR(10)
	    + 
	    '                            ON  s.IdSetorAtuacao = EP.IdSetorAtuacao ' 
	    + CHAR(10)
	    + 
	    '                            LEFT JOIN AreasAtuacao a ON a.IdAreaAtuacao = ep.IdAreaAtuacao ' 
	    + CHAR(10)
	    + '                     WHERE  --ep.ExerceAtividade = 1 ' + CHAR(10)
	    + '                            EP.IdProfissional = ' + @idProf + CHAR(10)
	    + 
	    '                            AND (ep.SetorAtuacaoDivulgacao = 1 OR ep.AreaAtuacaoDivulgacao = 1) ' 
	    + CHAR(10)
	    + '                     ORDER BY ' + CHAR(10)
	    + 
	    '                            ISNULL(ep.ExerceAtividade, 0) DESC  -- Variable value from the outer cursor ' 
	    + CHAR(10)
	    + ' ' + CHAR(10)
	    + '    OPEN cExperiencias; ' + CHAR(10)
	    + '    FETCH NEXT FROM cExperiencias INTO @setoratuacao,@areatuacao ; ' 
	    + CHAR(10)
	    + ' ' + CHAR(10)
	    + '    SET @textoAreaAtuacao ='''' ' + CHAR(10)
	    + '    SET @textoSetorAtuacao = '''' ' + CHAR(10)
	    + ' ' + CHAR(10)
	    + '    WHILE @@FETCH_STATUS = 0 ' + CHAR(10)
	    + '    BEGIN ' + CHAR(10)
	    + '        IF (@textoAreaAtuacao <> '''')   ' + CHAR(10)
	    + 
	    '          SET @textoAreaAtuacao = @textoAreaAtuacao+'', ''+@areatuacao ' 
	    + CHAR(10)
	    + '        ELSE  SET @textoAreaAtuacao = @areatuacao ' + CHAR(10)
	    + '        IF (@textoSetorAtuacao <> '''') ' + CHAR(10)
	    + 
	    '          SET @textoSetorAtuacao = @textoSetorAtuacao+ '', ''+ @setoratuacao ' 
	    + CHAR(10)
	    + '        ELSE SET @textoSetorAtuacao = @setoratuacao ' + CHAR(10)
	    + 
	    '        FETCH NEXT FROM cExperiencias INTO @setoratuacao,@areatuacao ; ' 
	    + CHAR(10)
	    + '    END; ' + CHAR(10)
	    + ' ' + CHAR(10)
	    + '    CLOSE cExperiencias; ' + CHAR(10)
	    + '    DEALLOCATE cExperiencias;'
	
	SET @Sql = @sqlExperiencia +
	    '
	    SELECT ISNULL(ENDerecos.IdENDereco,''0'') AS IdENDereco, 
	            profissionais.nome, 
	            profissionais.RegistroConselhoAtual,              
							CASE  SiteDivulgacao WHEN 1 THEN Profissionais.Site ELSE '''' END AS Site,              
							CASE  Site2Divulgacao WHEN 1 THEN Profissionais.Site2 ELSE '''' END AS  Site2,              
							CASE  EmailDivulgacao WHEN 1 THEN  Profissionais.ENDerecoEmail ELSE '''' END AS ENDerecoEmail,              
							CASE  Email2Divulgacao WHEN 1 THEN  Profissionais.ENDerecoEmail2 ELSE '''' END AS ENDerecoEmail2,              
							CASE  TelResidDivulgacao WHEN 1 THEN Profissionais.TelefoneResid ELSE '''' END AS TelefoneResid,              
							CASE  TelCelDivulgacao WHEN 1 THEN  Profissionais.TelefoneCelular ELSE '''' END AS TelefoneCelular,              
							CASE  TelTrabDivulgacao WHEN 1 THEN profissionais.TelefoneTrab ELSE '''' END AS TelefoneTrab,              
							CASE  TelRecadoFaxDivulgacao WHEN 1 THEN  Profissionais.TelefoneOutros ELSE '''' END AS TelefoneOutros,
							/* EndereÃ§os */
							CASE  ENDerecos.E_Divulgacao WHEN 1 THEN ISNULL(ENDerecos.Cep,'''') ELSE '''' END AS Cep,               
							CASE  ENDerecos.E_Divulgacao WHEN 1 THEN ISNULL(ENDerecos.ENDereco,'''') ELSE '''' END AS ENDereco,
							CASE  ENDerecos.E_Divulgacao WHEN 1 THEN ISNULL(ENDerecos.NomeBairro,'''') ELSE '''' END AS NomeBairro,
							CASE  ENDerecos.E_Divulgacao WHEN 1 THEN ISNULL(ENDerecos.NomeCidade,'''') ELSE '''' END AS NomeCidade,
							CASE  ENDerecos.E_Divulgacao WHEN 1 THEN ISNULL(ENDerecos.CaixaPostal,'''') ELSE '''' END AS CaixaPostal,
							CASE  ENDerecos.E_Divulgacao WHEN 1 THEN ISNULL(ENDerecos.E_Residencial,'''') ELSE '''' END AS E_Residencial,
							CASE  ENDerecos.E_Divulgacao WHEN 1 THEN ISNULL(ENDerecos.DataUltimaAtualizacao,'''') ELSE '''' END AS DataUltimaAtualizacao,
							CASE  ENDerecos.E_Divulgacao WHEN 1 THEN ISNULL(ENDerecos.SiglaUF,'''') ELSE '''' END AS SiglaUF,
							CASE  ENDerecos.E_Divulgacao WHEN 1 THEN ISNULL(ENDerecos.E_Exterior,'''') ELSE '''' END AS E_Exterior,
							1 AS MostraTelaDivulgacao,
       ISNULL((
           SELECT NomeEspecialidade
           FROM   (
                      SELECT (ROW_NUMBER() OVER(ORDER BY e.NomeEspecialidade)) 
                             Id,
                             e.NomeEspecialidade
                      FROM   EspecialidadesProfissional AS ep
                             JOIN Especialidades AS e
                                  ON  e.IdEspecialidade = ep.IdEspecialidade
                      WHERE ep.EspecialidadeDivulgacao = 1
                        AND EP.IdProfissional = profissionais.IdProfissional
                  ) AS A
           WHERE  A.Id = 1
       ),'''') + ISNULL((
           SELECT '', '' + NomeEspecialidade
           FROM   (
                      SELECT (ROW_NUMBER() OVER(ORDER BY e.NomeEspecialidade)) 
                             Id,
                             e.NomeEspecialidade
                      FROM   EspecialidadesProfissional AS ep
                             JOIN Especialidades AS e
                                  ON  e.IdEspecialidade = ep.IdEspecialidade
				  	  WHERE ep.EspecialidadeDivulgacao = 1   
				  	    AND EP.IdProfissional = profissionais.IdProfissional                               
                  ) AS A
           WHERE  A.Id = 2
       ),'''') + ISNULL((
           SELECT '', '' + NomeEspecialidade
           FROM   (
                      SELECT (ROW_NUMBER() OVER(ORDER BY e.NomeEspecialidade)) 
                             Id,
                             e.NomeEspecialidade
                      FROM   EspecialidadesProfissional AS ep
                             JOIN Especialidades AS e
                                  ON  e.IdEspecialidade = ep.IdEspecialidade
	                  WHERE ep.EspecialidadeDivulgacao = 1     
	                    AND EP.IdProfissional = profissionais.IdProfissional                             
                  ) AS A
           WHERE  A.Id = 3
       ),'''') AS Especialidade,
       @textoAreaAtuacao AS AreaAtuacao,        
       @textoSetorAtuacao AS SetorAtuacao
         FROM Profissionais      
						  LEFT JOIN  ENDerecos on profissionais.IdProfissional = ENDerecos.IdProfissional
								AND ENDerecos.E_Divulgacao = 1 
	      WHERE Profissionais.Idprofissional =' + @idProf
	
	EXEC (@Sql)
END
