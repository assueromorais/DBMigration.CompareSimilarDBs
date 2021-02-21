/*PCI Gaspar Oc.66904 30/08/2010*/

CREATE PROCEDURE [dbo].[Sp_CalculaOrcamentoPCI]       
@Exercicio int,        
@IdCentroCusto INT ,@IdUsuario INT = 0 AS        
      
        
SET NOCOUNT ON        
        
DECLARE @TemFilho BIT        
SET @TemFilho = 0        
         
CREATE TABLE #TABPER        
		(        
				Grupo  int,        
				CodConta varchar(18),        
				Periodo  money       
		)        
CREATE INDEX TEMPIND ON #TABPER (Grupo, CodConta, Periodo)        
INSERT #TABPER        
		SELECT        
		Grupo,        
		CodConta,        
		Sum(Valor)        
		FROM        
		PlanoContas, Web_Dotacoes        
		WHERE        
		PlanoContas.IdConta= Web_Dotacoes.IdConta and        
		year(Web_Dotacoes.DataDotacao) = @Exercicio/* and        
		Web_Dotacoes.DataDotacao <= @DataFinal*/ and        PlanoContas.IdConta = Web_Dotacoes.IdConta AND /*66904 Gaspar*/
		PlanoContas.Grupo IN (3,4,5,6)    
		and Web_Dotacoes.IdCentroCusto = @idCentroCusto      
		GROUP BY        
		Grupo, CodConta        
        
      
      
        
CREATE TABLE #TABTEMP1        
		(        
				IdConta int,        
				Grupo  int,        
				CodConta varchar(27),        
				NomeConta varchar(50),        
				Analitico bit,        
				Periodo  money,        
				PCS int        
		)        
        
        
 /******ITALO OC.62814 */
 
 CREATE TABLE #tblConta       
		(        
        
				CodConta varchar(27)        
                    
		)
 
	 INSERT INTO  #tblConta
 SELECT 
		pc.CodConta 
	   FROM PlanoContas pc INNER JOIN ContasPersonalizada cp  
		ON pc.IdConta = cp.IdConta INNER JOIN Usuarios u  ON u.NomeContaPersonalizada = 
	   cp.NomePersonalizado WHERE pc.Grupo IN (4, 5) AND u.IdUsuario = @IdUsuario  
 UNION 
	SELECT DISTINCT SUBSTRING(pc.CodConta, 1, LEN(pc.CodConta)-2)  
	FROM PlanoContas pc INNER JOIN ContasPersonalizada cp  
		ON pc.IdConta = cp.IdConta INNER JOIN Usuarios u  ON u.NomeContaPersonalizada = 
	   cp.NomePersonalizado WHERE pc.Grupo IN (4, 5) AND u.IdUsuario = @IdUsuario  
 UNION 
	SELECT DISTINCT SUBSTRING(pc.CodConta, 1, LEN(pc.CodConta)-2) + '00' 
	FROM PlanoContas pc INNER JOIN ContasPersonalizada cp  
		ON pc.IdConta = cp.IdConta INNER JOIN Usuarios u  ON u.NomeContaPersonalizada = 
	   cp.NomePersonalizado WHERE pc.Grupo IN (4, 5) AND u.IdUsuario = @IdUsuario 
	 --  order BY CAST(codconta AS VARCHAR(50))
	 
DECLARE @strWhere VARCHAR(80) 
SET @strWhere ='and 0=0'
IF @IdUsuario > 0 
   SET @strWhere ='AND  REPLACE(#TABTEMP1.CodConta,''.'','''') IN (SELECT CodConta  FROM #tblConta  )  ' 
 
 
 /*FIM OC.62814 */        
	        
        
                
DECLARE @IdConta int, @grupo int, @codconta varchar(18),   
 @nomeconta varchar(50), @analitico bit,   
 @codaux varchar(18), @i int,   
 @contaformatada varchar(27),   
 @periodo money, @PCS int  
 
      
DECLARE plano_cursor CURSOR FAST_FORWARD FOR         
	SELECT IdConta, Grupo, CodConta, NomeConta, Analitico        
	FROM PlanoContas        
		WHERE PlanoContas.Grupo IN (3,4,5,6) 
		AND ISNULL(Exercicio, 0) = CASE WHEN (SELECT TOP 1 1 FROM PlanoContas WHERE Exercicio = @Exercicio) = 1 THEN @Exercicio ELSE 0 end
		--AND IdConta IN (SELECT IdConta FROM Web_Dotacoes WHERE YEAR(DataDotacao) = @Exercicio)  
		ORDER BY Grupo, Codconta        
        
OPEN plano_cursor        
FETCH NEXT FROM plano_cursor        
INTO @IdConta, @grupo, @codconta, @nomeconta, @analitico        
        
WHILE @@FETCH_STATUS = 0        
BEGIN        
		SET @contaformatada= Left(@codconta, 1)        
		SET @codaux= @codconta        
		IF @grupo> 2         
		BEGIN        
				IF @analitico= 0        
						SET @codaux= replace(rtrim(replace(@codconta, '0', ' ')),' ','0')         
        
  IF (LEN(@codaux) > 1) AND (LEN(@codaux) % 2) <> 0        
  BEGIN        
	 EXECUTE Sp_CalculaContaFilho @codconta, @grupo, @Exercicio, @TemFilho OUTPUT        
   IF @TemFilho = 1         
		SET @codaux = @codaux + '0'        
  END        
        
				SET @i= 2        
				WHILE @i <= len(@codconta)        
				BEGIN            
						IF @i < 4        
								SET @contaformatada= @contaformatada + '.'        
						ELSE        
								IF @i % 2 = 1        
										SET @contaformatada= @contaformatada + '.'        
						SET @contaformatada= @contaformatada + substring(@codconta,@i,1)        
						SET @i= (@i + 1)        
				END        
		END        
		ELSE        
		BEGIN                
				SET @i= 2        
				WHILE @i <= len(@codconta)        
				BEGIN           
						IF @i < 5        
								SET @contaformatada= @contaformatada + '.'        
						ELSE        
								IF @i % 2 = 0         
										SET @contaformatada= @contaformatada + '.'        
								SET @contaformatada= @contaformatada + substring(@codconta,@i,1)        
								SET @i= @i + 1        
				END        
		END        
        
		SET @periodo=(        
			SELECT IsNull(Sum(Periodo),0)        
				FROM        
				#TABPER        
				WHERE        
				#TABPER.Grupo = @grupo and        
				#TABPER.CodConta >= @codaux  and        
				#TABPER.CodConta < (@codaux+'a'))        
        
		SET @PCS=(        
				SELECT ISNULL(COUNT(*), 0)        
				FROM        
				Web_Dotacoes WD        
				INNER JOIN PlanoContas PC ON PC.IdConta = WD.IdConta        
				WHERE        
				PC.Grupo = @grupo and        
	PC.CodConta >= @codaux  and        
				PC.CodConta < (@codaux+'a'))        
        
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
      
      
		EXEC('SELECT       
		''&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;''+#TABTEMP1.codConta + ''-'' +  NomeConta as Conta,      
		identificador,      
		      
		periodo as valor,      
		IdCentroCusto,      
		DataDotacao,      
		(year(dataDotacao))as [Ano Dotação],isnull(Analitica ,0) as Analitica,      
		dbo.format_currency(cast(Periodo as varchar)) as  ValorFormatado      
		       
		FROM #TABTEMP1      
		LEFT JOIN web_dotacoes wt on wt.idConta = #TABTEMP1.idConta       
		and wt.idCentroCusto ='+ @IdCentroCusto+'      
		AND year(wt.DataDotacao) = '+@Exercicio+'  
		    
		WHERE PCS > 0 '+@strWhere+' order by REPLACE(#TABTEMP1.CodConta,''.'','''') '  )   
      
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

