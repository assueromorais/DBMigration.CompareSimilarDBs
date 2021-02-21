


























CREATE PROCEDURE dbo.spComboProfissionais

@Id integer,  
@Tipo varchar(7) = 'STRING', 
@Dado varchar(60)
AS

SET NOCOUNT ON

DECLARE @IdProfissional int, @Nome varchar(60), @RegistroConselho varchar(20), @i int

IF @Id <> NULL
	SELECT      IdProfissional,  Nome , RegistroConselhoAtual 
	FROM         Profissionais
	WHERE      IdProfissional = @Id
	ORDER BY Nome

SET @i = 1
WHILE @i <= 6
BEGIN
	IF ISNUMERIC(SUBSTRING(@Dado, @i, 1)) = 1
		SET @Tipo = 'INTEGER'
	SET @i = @i + 1
END


IF @Tipo = 'STRING'
	SELECT      IdProfissional,  RegistroConselhoAtual , Nome
	FROM         Profissionais
	WHERE      Nome LIKE @Dado + '%'
	ORDER BY Nome
ELSE
	SELECT      IdProfissional,  RegistroConselhoAtual , Nome 
	FROM         Profissionais
	WHERE      RegistroConselhoAtual LIKE @Dado + '%'
	ORDER BY RegistroConselhoAtual























































