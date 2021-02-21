/* OC 17219 - Rodrigo Souza */ 
CREATE PROCEDURE dbo.Sp_PlanoContasFinanceiro
@Tipo char(1) = '', @Exercicio varchar(4) = ''  -- Plurianual
AS 
SET NOCOUNT ON

DECLARE @IdContaFinanceira int, @NomeContaFinanceira varchar(60), @CodigoContaFinanceira varchar(60), @TipoConta char(1), @IdConta int,
   @Contador int, @MaiorNivel int, @Nivel int, @ProximoNivel int, @IdPai int, @OrdemIds int, 
   @CodPai varchar(20), @Sequencia varchar(3),@ChequeEspecial money

-- Plurianual
IF NOT EXISTS(SELECT TOP 1 1 FROM PlanoContasFinanceiro WHERE Exercicio = @Exercicio)
  SELECT @Exercicio = NULL
  
CREATE TABLE #PlContaFin (IdContaFinanceira int, NomeContaFinanceira varchar(60) COLLATE database_default, CodigoContaFinanceira varchar(1000) COLLATE database_default, Ordem int, Analitico int, TipoConta char(1), IdConta int,ChequeEspecial money)
CREATE TABLE #Ids (Ids int, Ordem int)
CREATE TABLE #Codigos (Codigo varchar(1000) COLLATE database_default, Sequencia int)
SELECT @MaiorNivel = MAX(Quantidade) FROM (
SELECT COUNT(*) AS Quantidade FROM AssociaPlanoContasFinanceiro 
WHERE IdContaFinanceiraPai IN (SELECT IdContaFinanceira FROM PlanoContasFinanceiro where ISNULL(Exercicio,0) = ISNULL(2010,0))  -- Plurianual
GROUP BY IdContaFinanceiraFilha) A

DECLARE planocontasfin_cursor CURSOR FAST_FORWARD FOR 
SELECT IdContaFinanceira, NomeContaFinanceira, TipoConta, IdConta,ChequeEspecial 
FROM PlanoContasFinanceiro
WHERE IdContaFinanceiraPai IS NULL
AND ((@Tipo = '') OR (TipoConta = @Tipo)) 
AND ISNULL(Exercicio,0) = ISNULL(@Exercicio,0)  -- Plurianual
ORDER BY NomeContaFinanceira
SET @Contador = 1
SET @OrdemIds = 1
SET @CodPai = '1'
OPEN planocontasfin_cursor
FETCH NEXT FROM planocontasfin_cursor
INTO @IdContaFinanceira, @NomeContaFinanceira, @TipoConta, @IdConta,@ChequeEspecial
WHILE @@FETCH_STATUS = 0
BEGIN
   SET @Nivel = 1
   SET @CodPai = REPLICATE('0', 3-LEN(@CodPai))+@CodPai
   INSERT INTO #PlContaFin VALUES (@IdContaFinanceira, @NomeContaFinanceira, @CodPai, @Contador, 1, @TipoConta, @IdConta,@ChequeEspecial)
   INSERT INTO #Ids VALUES(@IdContaFinanceira, @OrdemIds)
   INSERT INTO #Codigos VALUES(@CodPai, 0)
   SET @OrdemIds = @OrdemIds+1
   SET @Contador = @Contador+1
   SET @IdPai = @IdContaFinanceira
   WHILE (SELECT COUNT(*) FROM #Ids) > 0
   BEGIN
      IF (SELECT 1 FROM #Codigos WHERE Codigo = @CodPai) = 1 
         SELECT @Sequencia = CAST(Sequencia+1 AS varchar(3)) FROM #Codigos WHERE Codigo = @CodPai
      ELSE
      BEGIN
         SET @Sequencia = '1'
         INSERT INTO #Codigos VALUES (@CodPai, 0)
      END
      INSERT INTO #PlContaFin
      SELECT TOP 1 IdContaFinanceiraFilha, NomeContaFinanceira, @CodPai+REPLICATE('0', 3-LEN(@Sequencia))+@Sequencia, @Contador, 1, TipoConta, IdConta ,ChequeEspecial
      FROM AssociaPlanoContasFinanceiro, PlanoContasFinanceiro
      WHERE PlanoContasFinanceiro.IdContaFinanceira = AssociaPlanoContasFinanceiro.IdContaFinanceiraFilha
      AND IdContaFinanceiraFilha IN (SELECT IdContaFinanceiraFilha FROM AssociaPlanoContasFinanceiro WHERE IdContaFinanceiraPai = @IdPai)
      AND IdContaFinanceiraFilha NOT IN (SELECT IdContaFinanceira FROM #PlContaFin)
      GROUP BY IdContaFinanceiraFilha, NomeContaFinanceira, TipoConta, IdConta,ChequeEspecial
      HAVING COUNT(IdContaFinanceiraFilha) = @Nivel
      ORDER BY NomeContaFinanceira   
      IF @@ROWCOUNT > 0 
      BEGIN
         IF (SELECT 1 FROM #Codigos WHERE Codigo = @CodPai) = 1 
            UPDATE #Codigos SET Sequencia = Sequencia+1 WHERE Codigo = @CodPai
         ELSE
            INSERT INTO #Codigos VALUES (@CodPai, 0)
         SELECT TOP 1 @IdPai = IdContaFinanceira FROM #PlContaFin ORDER BY Ordem DESC
         INSERT INTO #Ids VALUES(@IdPai, @OrdemIds)
         SET @OrdemIds = @OrdemIds+1
         SET @Nivel = @Nivel+1
         SET @Contador = @Contador+1
      END
      ELSE
      BEGIN
         DELETE FROM #Ids WHERE Ids = @IdPai
         SELECT TOP 1 @IdPai = Ids FROM #Ids ORDER BY Ordem DESC
         SET @Nivel = @Nivel-1
      END
      SELECT @CodPai = CodigoContaFinanceira FROM #PlContaFin WHERE IdContaFinanceira = @IdPai
   END   
   SET @Contador = @Contador+1
   SET @CodPai = @CodPai+1
   FETCH NEXT FROM planocontasfin_cursor
   INTO @IdContaFinanceira, @NomeContaFinanceira, @TipoConta, @IdConta,@ChequeEspecial
END
CLOSE planocontasfin_cursor
DEALLOCATE planocontasfin_cursor
UPDATE #PlContaFin SET Analitico = 0 WHERE IdContaFinanceira IN 
(SELECT DISTINCT IdContaFinanceiraPai FROM AssociaPlanoContasFinanceiro)
SELECT * FROM #PlContaFin
