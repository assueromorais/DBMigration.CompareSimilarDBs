CREATE PROCEDURE dbo.sp_ConsultaPrePedidos
@IdResponsavel int
 As 

SET NOCOUNT ON
DECLARE @NomeItem varchar(50), @Qtd int, @IdPrePedido int, @IdItensPrePedidos int, @IdItem int, @Apagar varchar(5)

CREATE TABLE #ITENS
(	NomeItem varchar(50) COLLATE database_default,
	Qtd int,
	IdPrePedido int,
	IdItensPrePedidos int,
	IdItem int,
	Apagar varchar(5) COLLATE database_default)
DECLARE ITENS_CURSOR CURSOR FAST_FORWARD FOR 
SELECT 
NomeItem, 
Qtd, 
PrePedidos.IdPrePedido,
IdItensPrePedidos, 
ItensPrePedidos.IdItem
FROM ItensPrePedidos 
INNER JOIN Itens ON Itens.IdItem = ItensPrePedidos.IdItem 
INNER JOIN PrePedidos ON PrePedidos.IdPrePedido = ItensPrePedidos.IdPrePedido
INNER JOIN Responsaveis ON Responsaveis.IdResponsavel = PrePedidos.IdResponsavel 
WHERE 
Responsaveis.IdResponsavel = @IdResponsavel
AND 
PrePedidos.IdPedido IS NULL
ORDER BY PrePedidos.IdPrePedido

OPEN ITENS_CURSOR
FETCH NEXT FROM ITENS_CURSOR
INTO @NomeItem, @Qtd, @IdPrePedido, @IdItensPrePedidos, @IdItem
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Apagar = (SELECT CASE COUNT(IdPrePedido) WHEN 1 THEN 'True' ELSE 'False' END FROM ItensPrePedidos WHERE IdPrePedido = @IdPrePedido) 

	INSERT #ITENS
	VALUES (@NomeItem,@Qtd,@IdPrePedido,@IdItensPrePedidos,@IdItem,@Apagar)

	FETCH NEXT FROM ITENS_CURSOR
	INTO @NomeItem, @Qtd, @IdPrePedido, @IdItensPrePedidos, @IdItem
END
CLOSE ITENS_CURSOR
DEALLOCATE ITENS_CURSOR

SELECT * FROM #ITENS
GO
