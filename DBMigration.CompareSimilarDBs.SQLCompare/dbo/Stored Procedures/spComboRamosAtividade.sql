



























CREATE PROCEDURE spComboRamosAtividade

@Id integer,  
@Tipo varchar(7) = 'STRING', 
@Dado varchar(60)
AS

SET NOCOUNT ON

CREATE TABLE #ComboRamosAtividade
        (
                IdConta             int,
	   CodConta      varchar(18),
                NomeConta   varchar(50)
        )  

DECLARE @IdConta int, @CodConta varchar(18), @NomeConta varchar(50)

DECLARE RamosAtividade_Cursor
CURSOR FAST_FORWARD FOR

SELECT IdConta, CodConta, NomeConta
FROM PlanoContas
WHERE Grupo = 4
      AND (CodConta like '312%' OR CodConta like '313%')
      AND Analitico = 1
ORDER BY NomeConta

OPEN RamosAtividade_Cursor

FETCH NEXT FROM RamosAtividade_Cursor
INTO @IdConta, @CodConta, @NomeConta

	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT #ComboRamosAtividade
		VALUES(
			@IdConta,
			@CodConta,
			@NomeConta
			)

		FETCH NEXT FROM RamosAtividade_Cursor
		INTO @IdConta, @CodConta, @NomeConta
	END

CLOSE RamosAtividade_Cursor
DEALLOCATE RamosAtividade_Cursor

SELECT * FROM #ComboRamosAtividade





























































