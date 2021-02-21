/*Marvio Oc.70967 29/11/2010*/ 

CREATE PROCEDURE [dbo].[Sp_CalculaOrcamentoPCS2]
	@Exercicio INT,
	@IdCentroCusto INT ,
	@IdUsuario INT = 0,
	@Tipo CHAR(1) /* R = Receita, D = Despesa, T = Todos */
AS
	SET NOCOUNT ON        
	
	DECLARE
		@TemFilho BIT
		
	DECLARE @Grupos TABLE (IdGrupo INT NOT NULL)
	
	IF @Tipo = 'D' /* Retorna apenas as contas de Depesa */
		BEGIN
			INSERT INTO @Grupos (IdGrupo) VALUES (4)
			INSERT INTO @Grupos (IdGrupo) VALUES (5)
		END
	ELSE IF @Tipo = 'R' /* Retorna apenas as contas Receita */
		BEGIN
			INSERT INTO @Grupos (IdGrupo) VALUES (3)
			INSERT INTO @Grupos (IdGrupo) VALUES (6)
		END
	ELSE /* Retorna todas as contas */
		BEGIN
			INSERT INTO @Grupos (IdGrupo) VALUES (4)
			INSERT INTO @Grupos (IdGrupo) VALUES (5)
		
			INSERT INTO @Grupos (IdGrupo) VALUES (3)
			INSERT INTO @Grupos (IdGrupo) VALUES (6)
		END
		
	        
	SET @TemFilho = 0
	
	CREATE TABLE #TABPER
	(
		Grupo     INT,
		CodConta  VARCHAR(18),
		Periodo   MONEY
	) 
	CREATE INDEX TEMPIND ON #TABPER(Grupo, CodConta, Periodo)        
	INSERT #TABPER
	SELECT
		Grupo,
	    CodConta,
	    SUM(Valor)
	FROM
		PlanoContas,
	    Web_Dotacoes
	WHERE 
		PlanoContas.IdConta = Web_Dotacoes.IdConta
	    AND YEAR(Web_Dotacoes.DataDotacao) = @Exercicio
	    AND PlanoContas.IdConta = Web_Dotacoes.IdConta
	    AND PlanoContas.Grupo IN (SELECT G.IdGrupo FROM @Grupos G)
	    AND Web_Dotacoes.IdCentroCusto = @idCentroCusto
	GROUP BY
		Grupo,
		CodConta        
	
	
	
	
	CREATE TABLE #TABTEMP1
	(
		IdConta    INT,
		Grupo      INT,
		CodConta   VARCHAR(27),
		NomeConta  VARCHAR(50),
		Analitico  BIT,
		Periodo    MONEY,
		PCS        INT
	) 
	
	
	/******ITALO OC.62814 */
	
	CREATE TABLE #tblConta
	(
		CodConta VARCHAR(27)
	)
	
	INSERT INTO #tblConta
	SELECT
		pc.CodConta
	FROM
		PlanoContas pc
		INNER JOIN ContasPersonalizada cp ON pc.IdConta = cp.IdConta
		INNER JOIN Usuarios u ON u.NomeContaPersonalizada = cp.NomePersonalizado
	WHERE 
		pc.Grupo IN (SELECT G.IdGrupo FROM @Grupos G)
	    AND u.IdUsuario = @IdUsuario 
	UNION
	SELECT
		DISTINCT SUBSTRING(pc.CodConta, 1, LEN(pc.CodConta) -2)
	FROM
		PlanoContas pc
		INNER JOIN ContasPersonalizada cp ON pc.IdConta = cp.IdConta
		INNER JOIN Usuarios u ON u.NomeContaPersonalizada = cp.NomePersonalizado
	WHERE 
		pc.Grupo IN (SELECT G.IdGrupo FROM @Grupos G)
	    AND u.IdUsuario = @IdUsuario 
	UNION
	SELECT
		DISTINCT SUBSTRING(pc.CodConta, 1, LEN(pc.CodConta) -2) + '00'
	FROM
		PlanoContas pc
		INNER JOIN ContasPersonalizada cp ON pc.IdConta = cp.IdConta
		INNER JOIN Usuarios u ON u.NomeContaPersonalizada = cp.NomePersonalizado
	WHERE 
		pc.Grupo IN (SELECT G.IdGrupo FROM @Grupos G)
	    AND u.IdUsuario = @IdUsuario 
	--  order BY CAST(codconta AS VARCHAR(50))
	
	DECLARE @strWhere VARCHAR(80) 
	SET @strWhere = 'and 0=0'
	IF @IdUsuario > 0
	    SET @strWhere = 'AND  REPLACE(#TABTEMP1.CodConta,''.'','''') IN (SELECT CodConta  FROM #tblConta  )  ' 
	
	
	/*FIM OC.62814 */        
	
	
	
	DECLARE @IdConta         INT,
	        @grupo           INT,
	        @codconta        VARCHAR(18),
	        @nomeconta       VARCHAR(50),
	        @analitico       BIT,
	        @codaux          VARCHAR(18),
	        @i               INT,
	        @contaformatada  VARCHAR(27),
	        @periodo         MONEY,
	        @PCS             INT  
	
	
	DECLARE plano_cursor CURSOR FAST_FORWARD 
	FOR
	    SELECT
	    	IdConta,
	        Grupo,
	        CodConta,
	        NomeConta,
	        Analitico                    
	    FROM
	    	PlanoContas
	    WHERE 
	    	PlanoContas.Grupo IN (SELECT G.IdGrupo FROM @Grupos G)
	        AND ISNULL(Exercicio, 0) = CASE 
	                                        WHEN (SELECT TOP 1 1 FROM PlanoContas WHERE Exercicio = @Exercicio) = 1 THEN @Exercicio
	                                        ELSE 0
	                                   END
	            --AND IdConta IN (SELECT IdConta FROM Web_Dotacoes WHERE YEAR(DataDotacao) = @Exercicio)
	    ORDER BY
	    	Grupo,
	    	Codconta                     
	
	OPEN plano_cursor 
	FETCH NEXT FROM plano_cursor 
	INTO @IdConta, @grupo, @codconta, @nomeconta, @analitico                                                 
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
	    	SET @contaformatada = LEFT(@codconta, 1)        
	    	SET @codaux = @codconta        
	    	IF @grupo > 2
	    		BEGIN
	    	    	IF @analitico = 0
	    	    	    SET @codaux = REPLACE(RTRIM(REPLACE(@codconta, '0', ' ')), ' ', '0')         
	    	    	
	    	    	IF (LEN(@codaux) > 1) AND (LEN(@codaux) % 2) <> 0
	    	    		BEGIN
	    	    	    	EXECUTE Sp_CalculaContaFilho @codconta, @grupo, @Exercicio, 
	    	    	    	@TemFilho OUTPUT        
	    	    	    	IF @TemFilho = 1
	    	    	    	    SET @codaux = @codaux + '0'
	    	    		END         
	    	    	
	    	    	SET @i = 2        
	    	    	WHILE @i <= LEN(@codconta)
	    	    		BEGIN
	    	    	    	IF @i < 4
	    	    	    	    SET @contaformatada = @contaformatada + '.'
	    	    	    	ELSE         
	    	    	    	IF @i % 2 = 1
	    	    	    	    SET @contaformatada = @contaformatada + '.'
	    	    	    	
	    	    	    	SET @contaformatada = @contaformatada + SUBSTRING(@codconta, @i, 1)        
	    	    	    	SET @i = (@i + 1)
	    	    		END
	    		END 
	    	ELSE 
	    		BEGIN
	    	    	SET @i = 2        
	    	    	WHILE @i <= LEN(@codconta)
	    	    		BEGIN
	    	    	    	IF @i < 5
	    	    	    	    SET @contaformatada = @contaformatada + '.'
	    	    	    	ELSE         
	    	    	    	IF @i % 2 = 0
	    	    	    	    SET @contaformatada = @contaformatada + '.'
	    	    	    	
	    	    	    	SET @contaformatada = @contaformatada + SUBSTRING(@codconta, @i, 1)        
	    	    	    	SET @i = @i + 1
	    	    		END
	    		END        
	    	
	    	SET @periodo = (SELECT
	    	                	ISNULL(SUM(Periodo), 0)
	    	                FROM
	    	                	#TABPER
	    	                WHERE 
	    	                	#TABPER.Grupo = @grupo
	    	                    AND #TABPER.CodConta >= @codaux
	    	                    AND #TABPER.CodConta < (@codaux + 'a'))        
	    	
	    	SET @PCS = (SELECT
	    	            	ISNULL(COUNT(*), 0)
	    	            FROM
	    	            	Web_Dotacoes WD
	    	            	INNER JOIN PlanoContas PC ON PC.IdConta = WD.IdConta
	    	            WHERE 
	    	            	PC.Grupo = @grupo
	    	                AND PC.CodConta >= @codaux
	    	                AND PC.CodConta < (@codaux + 'a'))        
	    	
	    	INSERT #TABTEMP1
	    	SELECT
	    		@IdConta,
	    	    @grupo,
	    	    @contaformatada,
	    	    @nomeconta,
	    	    @analitico,
	    	    @periodo,
	    	    @PCS 
	    	
	    	FETCH NEXT FROM plano_cursor 
	    	INTO @IdConta, @grupo, @codconta, @nomeconta, @analitico
		END 
	CLOSE plano_cursor 
	DEALLOCATE plano_cursor        
	
	
	EXEC ('SELECT ''&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;''+#TABTEMP1.codConta + ''-'' +  NomeConta as Conta,      
			identificador,      
			periodo as valor,      
			IdCentroCusto,      
			DataDotacao,      
			(year(dataDotacao))as [Ano Dotação],isnull(Analitica ,0) as Analitica,      
			dbo.format_currency(cast(Periodo as varchar)) as  ValorFormatado      		       
			FROM #TABTEMP1      
				LEFT JOIN web_dotacoes wt on wt.idConta = #TABTEMP1.idConta       
				and wt.idCentroCusto =' + @IdCentroCusto + '      
				AND year(wt.DataDotacao) = ' + @Exercicio + '  
			WHERE PCS > 0 ' + @strWhere + ' 
	       order by REPLACE(#TABTEMP1.CodConta,''.'','''') ') 
	
	/*      
	SELECT       
	'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+codConta + '-' + NomeConta as Conta,      
	identificador,      
	
	periodo as valor,      
	IdCentroCusto,      
	DataDotacao,      
	(year(dataDotacao))as [Ano Dotação],isnull(Analitica ,0) as Analitica,      
	dbo.format_currency(cast(Periodo as varchar)) as  ValorFormatado      
	
	FROM #TABTEMP1       
	LEFT JOIN web_dotacoes wt on wt.idConta = #TABTEMP1.idConta       
	and wt.idCentroCusto = @IdCentroCusto      
	AND year(wt.DataDotacao) = @Exercicio  
	
	WHERE PCS > 0        
	
	*/
	
	DROP TABLE #TABPER 
	DROP TABLE #TABTEMP1 
	DROP TABLE #tblConta

