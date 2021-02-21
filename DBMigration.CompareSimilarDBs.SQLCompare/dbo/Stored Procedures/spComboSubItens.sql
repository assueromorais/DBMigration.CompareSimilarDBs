CREATE PROCEDURE dbo.spComboSubItens

@Id int, 
@Tipo varchar(7) = 'STRING', 
@Dado varchar(60)

AS

IF @Id <> 0
BEGIN
	SELECT IdSubItem, CodigoItem, NomeSubItem, SubItens.IdItem 
	FROM SubItens
	INNER JOIN Itens ON Itens.IdItem = SubItens.IdItem
	WHERE SubItens.IdItem = @Id
	ORDER BY NomeSubItem
END
ELSE IF @Tipo = 'STRING'
BEGIN
	SELECT IdSubItem, CodigoItem, NomeSubItem, SubItens.IdItem 
	FROM SubItens
	INNER JOIN Itens ON Itens.IdItem = SubItens.IdItem
	WHERE NomeItem LIKE @Dado + '%'
	ORDER BY NomeSubItem
END
ELSE IF @Tipo <> 'STRING'
BEGIN
	SELECT IdSubItem, CodigoItem, NomeSubItem, SubItens.IdItem 
	FROM SubItens
	INNER JOIN Itens ON Itens.IdItem = SubItens.IdItem
	WHERE CodigoItem LIKE @Dado + '%'
	ORDER BY NomeSubItem
END
