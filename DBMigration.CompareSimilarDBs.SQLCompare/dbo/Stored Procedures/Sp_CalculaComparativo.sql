/*OC 109386 - Caroline*/ 

CREATE PROCEDURE [dbo].[Sp_CalculaComparativo]  
@DataInicial datetime,  
@DataFinal datetime,  
@Receita bit = 1 AS    
    
SET NOCOUNT ON  
  
DECLARE @Exercicio VARCHAR(4)  -- OC 17219 - Rodrigo - Plurianual  
SELECT @Exercicio = CASE WHEN (SELECT TOP 1 1 FROM PlanoContas pc WHERE pc.Exercicio = YEAR(@DataInicial)) = 1 THEN YEAR(@DataInicial) ELSE 0 END -- OC 17219 - Rodrigo - Plurianual  

DECLARE @TemFilho BIT  
SET @TemFilho = 0  
   
CREATE TABLE #TABPER  
        (  
                Grupo  int,  
                CodConta varchar(18) COLLATE database_default,  
                Periodo  money  
        )  
CREATE INDEX TEMPIND ON #TABPER (Grupo, CodConta, Periodo)  
IF @Receita= 1  
        INSERT #TABPER  
                SELECT  
                Grupo,  
                CodConta,  
                Sum(ValorDebito) - Sum(ValorCredito)  
                FROM  
                PlanoContas, Movimentos, Lancamentos  
                WHERE  
                PlanoContas.IdConta= Movimentos.IdConta and  
                Movimentos.IdLancamento= Lancamentos.IdLancamento and  
                Lancamentos.Encerramento= 0 and  
                ISNULL(Exercicio,0) = @Exercicio AND -- OC 17219 - Rodrigo - Plurianual     
                Movimentos.DataLancamento >= @DataInicial and  
                Movimentos.DataLancamento <= @DataFinal and  
                ((PlanoContas.Grupo= 3) or (PlanoContas.Grupo= 6)) 
                GROUP BY  
                Grupo, CodConta  
ELSE  
        INSERT #TABPER  
                SELECT  
                Grupo,  
                CodConta,  
                Sum(ValorDebito) - Sum(ValorCredito)  
                FROM  
                PlanoContas, Movimentos, Lancamentos  
                WHERE  
                PlanoContas.IdConta= Movimentos.IdConta and  
                Movimentos.IdLancamento= Lancamentos.IdLancamento and  
                Lancamentos.Encerramento= 0 and  
                ISNULL(Exercicio,0) = @Exercicio AND -- OC 17219 - Rodrigo - Plurianual     
                Movimentos.DataLancamento >= @DataInicial and  
                Movimentos.DataLancamento <= @DataFinal and  
                ((PlanoContas.Grupo= 4) or (PlanoContas.Grupo= 5))  
                GROUP BY  
                Grupo, CodConta  
  
CREATE TABLE #TABANO  
        (  
                Grupo  int,  
                CodConta varchar(18) COLLATE database_default,  
                Ano  money  
        )  
CREATE INDEX TEMPIND ON #TABANO (Grupo, CodConta, Ano)  
IF @Receita = 1  
        INSERT #TABANO  
                SELECT  
                Grupo,  
                CodConta,  
                Sum(ValorDebito) - Sum(ValorCredito)  
                FROM  
                PlanoContas, Movimentos, Lancamentos  
                WHERE  
                PlanoContas.IdConta= Movimentos.IdConta and  
                Movimentos.IdLancamento= Lancamentos.IdLancamento and  
                Lancamentos.Encerramento= 0 and  
                ISNULL(Exercicio,0) = @Exercicio AND -- OC 17219 - Rodrigo - Plurianual     
                Year(Movimentos.DataLancamento) = Year(@DataInicial) and  
                Movimentos.DataLancamento <= @DataFinal and  
                ((PlanoContas.Grupo= 3) or (PlanoContas.Grupo= 6))  
                GROUP BY  
                Grupo, CodConta  
ELSE  
        INSERT #TABANO  
                SELECT  
                Grupo,  
                CodConta,  
                Sum(ValorDebito) - Sum(ValorCredito)  
                FROM  
                PlanoContas, Movimentos, Lancamentos  
                WHERE  
                PlanoContas.IdConta= Movimentos.IdConta and  
                Movimentos.IdLancamento= Lancamentos.IdLancamento and  
                Lancamentos.Encerramento= 0 and  
                ISNULL(Exercicio,0) = @Exercicio AND -- OC 17219 - Rodrigo - Plurianual     
                Year(Movimentos.DataLancamento) = Year(@DataInicial) and  
                Movimentos.DataLancamento <= @DataFinal and  
                ((PlanoContas.Grupo= 4) or (PlanoContas.Grupo= 5))  
                GROUP BY  
                Grupo, CodConta  
  
CREATE TABLE #TABORC  
        (  
                Grupo  int,  
                CodConta varchar(18) COLLATE database_default,  
                Orcado money  
        )   
  
CREATE INDEX TEMPIND ON #TABORC (Grupo, CodConta, Orcado)  
        INSERT #TABORC  
                SELECT  
                Grupo,  
                CodConta,  
                SUM(ValorDotacao) ValorDotacao  
                FROM  
                PlanoContas, DotacoesConta  
                WHERE  
                ISNULL(Exercicio,0) = @Exercicio AND -- OC 17219 - Rodrigo - Plurianual     
                PlanoContas.IdConta = DotacoesConta.IdConta and  
                DotacoesConta.DataDotacao <= @DataFinal and  
                YEAR(DotacoesConta.DataDotacao) = YEAR(@DataFinal)  
                GROUP BY  
                Grupo, CodConta  
  
CREATE TABLE #TABTEMP1  
        (  
                Grupo  int,  
                CodConta varchar(27) COLLATE database_default,  
                NomeConta varchar(50) COLLATE database_default,  
                Analitico bit,  
                Orcado money,  
                Periodo  money,  
                Ano money  
        )  
DECLARE @grupo int, @codconta varchar(18), @nomeconta varchar(50), @analitico bit, @codaux varchar(18), @i int, @contaformatada varchar(27), @orcado money, @periodo money, @ano money  

IF @Receita= 1  
        DECLARE plano_cursor CURSOR FAST_FORWARD FOR   
                SELECT Grupo, CodConta, NomeConta, Analitico  
                FROM PlanoContas  
                WHERE ISNULL(Exercicio,0) = @Exercicio  -- OC 17219 - Rodrigo - Plurianual     
                AND ((PlanoContas.Grupo= 3) or (PlanoContas.Grupo= 6))   -- OC 17219 - Rodrigo - Plurianual
                ORDER BY Grupo, Codconta  
ELSE  
        DECLARE plano_cursor CURSOR FAST_FORWARD FOR   
                SELECT Grupo, CodConta, NomeConta, Analitico  
                FROM PlanoContas  
                WHERE ISNULL(Exercicio,0) = @Exercicio    -- OC 17219 - Rodrigo - Plurianual
                AND ((PlanoContas.Grupo= 4) or (PlanoContas.Grupo= 5))  -- OC 17219 - Rodrigo - Plurianual
                ORDER BY Grupo, Codconta  
  
OPEN plano_cursor  
FETCH NEXT FROM plano_cursor  
INTO @grupo, @codconta, @nomeconta, @analitico  
  
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
  
        SET @orcado=(  
                SELECT IsNull(Sum(Orcado),0)  
                FROM  
                #TABORC  
                WHERE  
                #TABORC.Grupo = @grupo and  
                #TABORC.CodConta >= @codaux  and  
                #TABORC.CodConta < (@codaux+'a'))  
  
        SET @periodo=(  
                SELECT IsNull(Sum(Periodo),0)  
                FROM  
                #TABPER  
                WHERE  
                #TABPER.Grupo = @grupo and  
                #TABPER.CodConta >= @codaux  and  
                #TABPER.CodConta < (@codaux+'a'))  
  
        SET @ano=(  
                SELECT IsNull(Sum(Ano),0)  
                FROM  
                #TABANO  
                WHERE  
                #TABANO.Grupo = @grupo and  
                #TABANO.CodConta >= @codaux  and  
                #TABANO.CodConta < (@codaux+'a'))  
  
        INSERT #TABTEMP1  
                SELECT  
                @grupo,  
                @contaformatada,  
                @nomeconta,  
                @analitico,  
                @orcado,  
                @periodo,                  @ano  
  
        FETCH NEXT FROM plano_cursor  
        INTO @grupo, @codconta, @nomeconta, @analitico  
END  
CLOSE plano_cursor  
DEALLOCATE plano_cursor  
  
SELECT * FROM #TABTEMP1  
  
DROP TABLE #TABPER  
DROP TABLE #TABANO  
DROP TABLE #TABORC  
DROP TABLE #TABTEMP1  
  
  
