CREATE PROCEDURE dbo.sp_DesfazRenegociacaoColetiva

@TextoSql varchar(8000),
@lFisica bit

AS

SET NOCOUNT ON 

DECLARE @IdProfissional int, @NumConjRen int, @DataVencimento DateTime  

CREATE TABLE #tmpProfDeb (IdProfissional int, NumConjRen int, DataVencimento DateTime)

INSERT INTO #tmpProfDeb
EXEC(@TextoSql)


DECLARE Renegociacoes_Cursor
CURSOR FAST_FORWARD FOR
SELECT IdProfissional int, NumConjRen int, DataVencimento DateTime
FROM #tmpProfDeb
	OPEN Renegociacoes_Cursor
	FETCH NEXT FROM Renegociacoes_Cursor
	INTO @IdProfissional, @NumConjRen, @DataVencimento
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC sp_DesfazRenegociacao @IdProfissional, @NumConjRen, @DataVencimento, @lFisica			
			
		FETCH NEXT FROM Renegociacoes_Cursor
		INTO @IdProfissional, @NumConjRen, @DataVencimento
	END
CLOSE Renegociacoes_Cursor
DEALLOCATE Renegociacoes_Cursor
