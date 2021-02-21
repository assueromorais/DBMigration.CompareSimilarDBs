/* oc. 124422 Selvino / Adicionado por Diego */
CREATE FUNCTION [dbo].[SomaData] 
(@DataInicio datetime, @Quantidade INT, @Medida CHAR(1), @DiasUteis bit)  
RETURNS DATETIME AS  
BEGIN
DECLARE @i int
SET @i = 0
DECLARE @DataTmp DATETIME
SET @DataTmp = @DataInicio
WHILE @I < @Quantidade
BEGIN
  IF @Medida = 'D' 
  BEGIN
    SET @DataTmp = DATEADD(DAY, 1, @DataTmp);
  END
  IF @Medida = 'H'
  BEGIN
    SET @DataTmp = DATEADD(HOUR, 1, @DataTmp);
    IF (@DiasUteis = 1) AND (dbo.DiaUtil(@DataTmp) = 0)
    BEGIN
      SET @DataTmp = DATEADD(HOUR, -1, @DataTmp);
      SET @DataTmp = DATEADD(DAY, 1, @DataTmp);
    END
  END
  IF (dbo.DiaUtil(@DataTmp) = 1) or (@DiasUteis = 0) 
  BEGIN
   	SET @i = @i + 1;
  END		  
END
RETURN @DataTmp
END
