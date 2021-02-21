/*André -09/02/2010 - OC 58296*/

CREATE PROCEDURE [dbo].[sp_ComboCCustoEventoPluri]  
  
@Id integer,  
@Tipo varchar(7) = 'STRING',  
@Dado varchar(60) = '',  
@Exercicio varchar(4) = ''  -- Plurianual  
AS  
SET NOCOUNT ON  
  
CREATE TABLE #CodigosCCustoEvento  
(  
 IdCentroCusto int,  
 CodigoCentroCusto varchar(15) COLLATE database_default,  
 Analitico int  
)  
INSERT INTO #CodigosCCustoEvento EXEC dbo.sp_CodigosCCustoEvento
  
IF @Id <> NULL  
BEGIN  
 SELECT DISTINCT A.IdCentroCusto,C.CodigoCentroCusto,A.NomeCentroCusto,C.Analitico,A.Evento,A.Exercicio  
 FROM CentroCustos A  
 LEFT JOIN CentroCustos B ON B.CodigoCentroCusto like A.CodigoCentroCusto+'%' /*AND B.Evento = A.Evento*/  
 LEFT JOIN #CodigosCCustoEvento C ON C.IdCentroCusto = A.IdCentroCusto  
 WHERE A.IdCentroCusto = @Id  
 ORDER BY A.Evento,C.CodigoCentroCusto  
END  
ELSE  
 If @Tipo = 'STRING'  
 BEGIN  
  SELECT DISTINCT A.IdCentroCusto,C.CodigoCentroCusto,A.NomeCentroCusto,C.Analitico,A.Evento,A.Exercicio  
  FROM CentroCustos A  
  LEFT JOIN CentroCustos B ON B.CodigoCentroCusto like A.CodigoCentroCusto+'%' /*AND B.Evento = A.Evento*/  
  LEFT JOIN #CodigosCCustoEvento C ON C.IdCentroCusto = A.IdCentroCusto  
  WHERE A.NomeCentroCusto LIKE @Dado + '%'  
  ORDER BY A.Evento,C.CodigoCentroCusto  
 END  
 ELSE  
 BEGIN  
  SELECT DISTINCT A.IdCentroCusto,CASE WHEN CHARINDEX('.', @Dado) > 0 THEN C.CodigoCentroCusto ELSE REPLACE(C.CodigoCentroCusto, '.', '') END CodigoCentroCusto,A.NomeCentroCusto,C.Analitico,A.Evento,A.Exercicio  
  FROM CentroCustos A  
  LEFT JOIN CentroCustos B ON B.CodigoCentroCusto like A.CodigoCentroCusto+'%' /*AND B.Evento = A.Evento*/  
  LEFT JOIN #CodigosCCustoEvento C ON C.IdCentroCusto = A.IdCentroCusto  
  WHERE A.CodigoCentroCusto LIKE REPLACE(@Dado,'.','') + '%'  
  ORDER BY A.Evento,CodigoCentroCusto  
 END

