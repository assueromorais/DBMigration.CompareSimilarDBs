/* OC 143371 - Task 3766 */
CREATE FUNCTION [dbo].[ConcatenaCorrespondencia](@TipoPessoa INT,@IdPessoa INT,@NGrade INT) 
	RETURNS VARCHAR(MAX) AS 
BEGIN	
/*===================================================================================================================================================		
01-Declarações de tabelas e variávies                     
===================================================================================================================================================*/	
	DECLARE @Retorno VARCHAR(MAX)
	SET @Retorno = ''	
	
	/*Pessoas Jurídicas*/
	DECLARE @Filtro TABLE (IdFiltro INT IDENTITY,Campo01 VARCHAR(60),Campo02 VARCHAR(25),Campo03 VARCHAR(30))				
	DECLARE @FiltroI TABLE (Id INT IDENTITY, IdResponsavelTecnico INT)
	DECLARE @FiltroII TABLE (Id INT IDENTITY, IdCursoEventoRealizado INT,NomeCursoEvento VARCHAR(60))	
	DECLARE @IdRT INT,@IdFiltro INT,@IdFiltroI INT,@IdFiltroII INT,@Formacao VARCHAR(60),@Texto VARCHAR(MAX),
			@Campo01 VARCHAR(60),@Campo02 VARCHAR(25),@Campo03 VARCHAR(30)
	
	/*Pessoas Físicas*/			
	DECLARE @FiltroPF TABLE (IdFiltroPF INT IDENTITY,Campo01PF VARCHAR(85),Campo02PF VARCHAR(85),Campo03PF VARCHAR(30),
		                     Campo04PF VARCHAR(60),Campo05PF VARCHAR(6),Campo06PF VARCHAR(15),Campo07PF VARCHAR(30))	
	DECLARE @IdFiltroPF INT,@TextoPF VARCHAR(MAX)	

/*===================================================================================================================================================		
02-Pessoas Jurídicas                              
===================================================================================================================================================*/	 	
	IF @TipoPessoa = 0 
	BEGIN								
/*Grade referente a Dados do Responsável Técnico "Ativo"(DataFim Nula,Menor ou Igual a Data Atual). 
===================================================================================================================================================*/
		IF @NGrade = 0
		BEGIN
			INSERT INTO @FiltroI(IdResponsavelTecnico) 	
				SELECT RT.IdResponsavelTecnico
				FROM ExperienciasProfissionais EX INNER JOIN 
					 ResponsaveisTecnicosPJ RT ON EX.IdExperienciaProfissional = RT.IdExperienciaProfissional 
				WHERE ((RT.DataFim >= GETDATE())OR RT.DataFim IS NULL) AND EX.IdPessoaJuridica = @IdPessoa
				GROUP BY RT.IdResponsavelTecnico
				ORDER BY RT.IdResponsavelTecnico
								
			SELECT @IdFiltroI = MIN(Id)	FROM @FiltroI									
			WHILE @IdFiltroI IS NOT NULL 
			BEGIN						
				SELECT @Campo01 = 'NOME: ' + ISNULL(SUBSTRING(PF.Nome,1,54),''),
					   @Campo02 = 'INSCRIÇÃO: ' + ISNULL(SUBSTRING(PF.RegistroConselhoAtual,1,14),'') ,  
					   @Campo03 = 'PROCESSO: ' + ISNULL(SUBSTRING(PF.PROCESSO,1,20),'')					   
				FROM PessoasJuridicas PJ LEFT JOIN 	
					 ExperienciasProfissionais EX ON EX.IdPessoaJuridica = PJ.IdPessoaJuridica LEFT JOIN 
					 Profissionais PF ON EX.IdProfissional = PF.IdProfissional LEFT JOIN 
					 ResponsaveisTecnicosPJ RT ON RT.IdExperienciaProfissional = EX.IdExperienciaProfissional
				WHERE ((RT.DataFim >= GETDATE())OR RT.DataFim IS NULL) 
				 AND  RT.IdResponsavelTecnico = (SELECT IdResponsavelTecnico FROM @FiltroI WHERE Id = @IdFiltroI)        
				ORDER BY ISNULL(Datafim,GETDATE())DESC,DataInicio DESC		
				
				INSERT INTO @Filtro(Campo01,Campo02,Campo03)
					VALUES (@Campo01,@Campo02,@Campo03)
				
				/*Dados de Formação================================================================================================================*/
				DELETE @FiltroII	
							
				INSERT INTO @FiltroII(IdCursoEventoRealizado,NomeCursoEvento)
					SELECT TOP 1 CV.IdCursoEventoRealizado,CE.NomeCursoEvento  
					FROM PessoasJuridicas PJ LEFT JOIN 	
						 ExperienciasProfissionais EX ON EX.IdPessoaJuridica = PJ.IdPessoaJuridica LEFT JOIN 
						 Profissionais PF ON EX.IdProfissional = PF.IdProfissional LEFT JOIN 
						 ResponsaveisTecnicosPJ RT ON RT.IdExperienciaProfissional = EX.IdExperienciaProfissional LEFT JOIN 
						 CursosEventosRealizado CV ON CV.IdProfissional = PF.IdProfissional LEFT JOIN 
						 CursosEventos CE ON CE.IdCursoEvento = CV.IdCursoEvento
					WHERE ((RT.DataFim >= GETDATE())OR RT.DataFim IS NULL) 
					 AND  RT.IdResponsavelTecnico = (SELECT IdResponsavelTecnico FROM @FiltroI WHERE Id = @IdFiltroI)        
					ORDER BY ISNULL(Datafim,GETDATE())DESC,DataInicio DESC	
									
	            SELECT @Formacao = ''
	            
	            IF (SELECT TOP 1 1 FROM @FiltroII) > 0
	            BEGIN
					              
					SELECT @IdFiltroII = MIN(Id) FROM @FiltroII									
					WHILE @IdFiltroII IS NOT NULL 
					BEGIN				
						SELECT @Formacao = ISNULL(SUBSTRING(NomeCursoEvento,1,60),'.') 							
						FROM @FiltroII
						WHERE Id = @IdFiltroII 				
						
						INSERT INTO @Filtro(Campo01,Campo02,Campo03)
						    SELECT 'FORMAÇÃO: '+@Formacao ,'',''			
							
					SELECT @IdFiltroII = MIN(Id)
					FROM @FiltroII
					WHERE Id > @IdFiltroII	
					END 
				END
				
				/*Dados de horário=================================================================================================================*/			
				IF (SELECT TOP 1 1 
					FROM ResponsaveisTecnicosPJ RT LEFT JOIN 
						 HorariosResponsavelTecnico HR ON HR.IdResponsavelTecnico = RT.IdResponsavelTecnico
					WHERE ((RT.DataFim >= GETDATE())OR RT.DataFim IS NULL) 
					  AND RT.IdResponsavelTecnico = (SELECT IdResponsavelTecnico FROM @FiltroI WHERE Id = @IdFiltroI)
					  AND HR.HoraInicio IS NOT NULL) > 0
			    BEGIN 
					INSERT INTO @Filtro(Campo01,Campo02,Campo03)
						SELECT 'HORÁRIO TRABALHO:','',''
					INSERT INTO @Filtro(Campo01,Campo02,Campo03)
						SELECT 'Dias da Semana','HoraInicio','HoraFim'						
					INSERT INTO @Filtro(Campo01,Campo02,Campo03)		
						SELECT 'PeríodoTrabalho' = CASE DiaSemana WHEN 1 THEN 'Segunda-Feira' WHEN 2 THEN 'Terça-Feira' WHEN 3 THEN 'Quarta-Feira' 
							   WHEN 4 THEN 'Quinta-Feira' WHEN 5 THEN 'Sexta-Feira' WHEN 6 THEN 'Sábado' WHEN 7 THEN 'Domingo' 
							   WHEN 8 THEN 'Todos' WHEN 9 THEN 'Segunda a Sexta' END,
							   HoraInicio=CONVERT(varchar(30), HoraInicio,108), 
							   HoraFim=CONVERT(varchar(30), HoraFim,108)
						FROM ResponsaveisTecnicosPJ RT LEFT JOIN 
							 HorariosResponsavelTecnico HR ON HR.IdResponsavelTecnico = RT.IdResponsavelTecnico
						WHERE ((RT.DataFim >= GETDATE())OR RT.DataFim IS NULL) 
						  AND RT.IdResponsavelTecnico = (SELECT IdResponsavelTecnico FROM @FiltroI WHERE Id = @IdFiltroI)
						  AND HR.HoraInicio IS NOT NULL 
			    END
			    				   
				SELECT @IdFiltroI = MIN(Id)
				FROM @FiltroI
				WHERE Id > @IdFiltroI				
			END		
			
			SELECT @IdFiltro = MIN(IdFiltro)
			FROM @Filtro		
			WHILE @IdFiltro IS NOT NULL 			
			BEGIN
					SET @Texto = ''
					SELECT @Texto = (Campo01) + REPLICATE(CHAR(32),60-LEN(campo01))+ CHAR(32) + CHAR(32)+ 
									(Campo02) + REPLICATE(CHAR(32),25-LEN(campo02))+ CHAR(32) + CHAR(32)+
									(Campo03) + REPLICATE(CHAR(32),30-LEN(campo03))+ CHAR(32) + CHAR(32)							
					FROM @Filtro
					WHERE IdFiltro = @IdFiltro 
					
					IF @Retorno = '' 
						SET @Retorno = @Texto
					ELSE 
						SET @Retorno = @Retorno + CHAR(13) +  @Texto
				
				SELECT @IdFiltro = MIN(IdFiltro)
				FROM @Filtro
				WHERE IdFiltro > @IdFiltro	
			END 
	    END 
/*Grade referente a Principais Atividades 
===================================================================================================================================================*/
		IF @NGrade = 1
		BEGIN 
			INSERT INTO @Filtro(Campo01)
				SELECT AA.AreaAtuacao
				FROM AreasAtuacao_PessoasJuridicas AP INNER JOIN 
					 AreasAtuacao AA ON AA.IdAreaAtuacao = AP.IdAreaAtuacao
				WHERE IdPessoaJuridica = @IdPessoa				  
			  
			SELECT @IdFiltro = MIN(IdFiltro)
			FROM @Filtro		
			WHILE @IdFiltro IS NOT NULL 			
			BEGIN					
					SELECT @Texto = (Campo01) + REPLICATE(CHAR(32),60-LEN(campo01))							
					FROM @Filtro
					WHERE IdFiltro = @IdFiltro
					
					IF @Retorno = '' 
						SET @Retorno = @Texto
					ELSE					
						SET @Retorno = @Retorno + CHAR(13) +  @Texto
				
				SELECT @IdFiltro = MIN(IdFiltro)
				FROM @Filtro
				WHERE IdFiltro > @IdFiltro	
			END 
		END 		
	END
/*===================================================================================================================================================			
03-Pessoas Físicas
===================================================================================================================================================*/	
	IF @TipoPessoa = 1
	BEGIN	    
	    /*Grade referente a Experiência Profissional. 
===================================================================================================================================================*/
		IF @NGrade = 0
		BEGIN 	
			INSERT INTO @FiltroPF(Campo01PF, Campo02PF, Campo03PF,Campo04PF,Campo05PF, Campo06PF, Campo07PF)
				SELECT 'EMPRESA: ' + ISNULL(SUBSTRING(PJ.Nome,1,76),'.'),
					   'LOGRADOURO: ' + ISNULL(SUBSTRING(PJ.Endereco,1,73),'.') ,  
					   'BAIRRO: ' + ISNULL(SUBSTRING(PJ.NomeBairro,1,22),'.'), 
					   'MUNICIPIO: ' + ISNULL(SUBSTRING(PJ.NomeCidade,1,49),'.'),
					   'UF: ' + ISNULL(SUBSTRING(PJ.SiglaUf,1,2),'.'),
					   'CEP: ' + ISNULL(SUBSTRING(PJ.CEP,1,10),'.'), 
					   'TELEFONE: ' + ISNULL(SUBSTRING(PJ.Telefone,1,20),'.')				
				FROM ExperienciasProfissionais EX LEFT JOIN
					 Profissionais PF ON PF.IdProfissional = EX.IdProfissional LEFT JOIN  	
					 PessoasJuridicas PJ ON PJ.IdPessoaJuridica = EX.IdPessoaJuridica 
				WHERE EX.IdProfissional = @IdPessoa AND EX.IdPessoaJuridica IS NOT NULL 
			UNION ALL
				SELECT 'RAZÃO: ' + ISNULL(SUBSTRING(PE.Nome,1,62),'.'),
					   'LOGRADOURO: ' + ISNULL(SUBSTRING(PE.Endereco,1,73),'.') ,  
					   'BAIRRO: ' + ISNULL(SUBSTRING(PE.NomeBairro,1,22),'.'), 
					   'MUNICIPIO: ' + ISNULL(SUBSTRING(PE.NomeCidade,1,49),'.'),
					   'UF: ' + ISNULL(SUBSTRING(PE.SiglaUf,1,2),'.'),
					   'CEP: ' + ISNULL(SUBSTRING(PE.CEP,1,10),'.'), 
					   'TELEFONE: ' + ISNULL(SUBSTRING(PE.Telefone,1,20),'.')	
				FROM ExperienciasProfissionais EX LEFT JOIN 
					 Profissionais PF ON PF.IdProfissional = EX.IdProfissional LEFT JOIN  	
				     Pessoas PE ON PE.IdPessoa = EX.IdPessoa
				WHERE EX.IdProfissional = @IdPessoa AND EX.IdPessoa IS NOT NULL 			
						  
			
			SELECT @IdFiltroPF = MIN(IdFiltroPF)
			FROM @FiltroPF		
			WHILE @IdFiltroPF IS NOT NULL 			
			BEGIN
					SET @TextoPF = ''
					SELECT @TextoPF = (Campo01PF) + REPLICATE(CHAR(32),85-LEN(Campo01PF))+ CHAR(13) +
									  (Campo02PF) + REPLICATE(CHAR(32),85-LEN(Campo02PF))+ CHAR(32) + CHAR(32)+
									  (Campo03PF) + REPLICATE(CHAR(32),30-LEN(Campo03PF))+ CHAR(13) +					
									  (Campo04PF) + REPLICATE(CHAR(32),60-LEN(Campo04PF))+ CHAR(32) + CHAR(32)+
									  (Campo05PF) + REPLICATE(CHAR(32),06-LEN(Campo05PF))+ CHAR(32) + CHAR(32)+
									  (Campo06PF) + REPLICATE(CHAR(32),15-LEN(Campo06PF))+ CHAR(32) + CHAR(32)+
									  (Campo07PF) + REPLICATE(CHAR(32),30-LEN(Campo07PF))+ CHAR(32) + CHAR(32)
					FROM @FiltroPF
					WHERE IdFiltroPF = @IdFiltroPF
					
					IF @Retorno = '' 
						SET @Retorno = @TextoPF
					ELSE				
					SET @Retorno = @Retorno + CHAR(13) +  @TextoPF
				
				SELECT @IdFiltroPF = MIN(IdFiltroPF)
				FROM @FiltroPF
				WHERE IdFiltroPF > @IdFiltroPF	
			END 
	    END 
	    
/*Grade referente a Formação
===================================================================================================================================================*/
		IF @NGrade = 1
		BEGIN 
			INSERT INTO @FiltroPF(Campo01PF)				
			SELECT CV.NomeCursoEvento
			FROM CursosEventosRealizado CE INNER JOIN 
				 CursosEventos CV ON CV.IdCursoEvento = CE.IdCursoEvento
				WHERE IdProfissional= @IdPessoa
			
			SELECT @IdFiltroPF = MIN(IdFiltroPF)
			FROM @FiltroPF		
			WHILE @IdFiltroPF IS NOT NULL 			
			BEGIN					
					SELECT @TextoPF = (Campo01PF) + REPLICATE(CHAR(32),60-LEN(campo01PF))							
					FROM @FiltroPF
					WHERE IdFiltroPF = @IdFiltroPF
					
					IF @Retorno = '' 
						SET @Retorno = @TextoPF
					ELSE						
						SET @Retorno = @Retorno + CHAR(13) + REPLICATE(CHAR(32),11) + @TextoPF /*Aqui o replicate é para dar espaçamento no campo formação*/
				
				SELECT @IdFiltroPF = MIN(IdFiltroPF)
				FROM @FiltroPF
				WHERE IdFiltroPF > @IdFiltroPF	
			END 
		END 		
	END
/*===================================================================================================================================================			
04-Outras Pessoas
===================================================================================================================================================*/	
IF @TipoPessoa = 3
BEGIN
	SET @Retorno = ''
END 	
/*===================================================================================================================================================	
05-Resultado
===================================================================================================================================================*/	
	RETURN(@Retorno)
END 
