CREATE PROCEDURE dbo.spComboItens

@Id int, 
@Tipo varchar(7) = 'STRING', 
@Dado varchar(60)

AS

IF @Id <> 0
BEGIN
	SELECT IdItem, CodigoItem, NomeItem 
	FROM Itens
	WHERE IdItem = @Id
	ORDER BY NomeItem
END
ELSE IF @Tipo = 'STRING'
BEGIN
	SELECT IdItem, CodigoItem, NomeItem 
	FROM Itens
	WHERE NomeItem LIKE @Dado + '%'
	ORDER BY NomeItem
END
ELSE IF @Tipo <> 'STRING'
BEGIN
	SELECT IdItem, CodigoItem, NomeItem 
	FROM Itens
	WHERE CodigoItem LIKE @Dado + '%'
	ORDER BY NomeItem
END
