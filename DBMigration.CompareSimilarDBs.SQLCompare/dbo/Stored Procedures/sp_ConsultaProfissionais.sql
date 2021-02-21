


























CREATE PROCEDURE dbo.sp_ConsultaProfissionais

@Id integer,  
@Tipo varchar(7) = 'STRING', 
@Dado varchar(60)
AS

SET NOCOUNT ON

CREATE TABLE #ComboPessoas
	(
		IdPessoa	integer,
		CNPJCPF	varchar(18),
		Nome		varchar(60),
		Habilitado	integer
	)

DECLARE @IdPessoa integer, @NomePessoa varchar(60), @CNPJCPF varchar(14), 
	@CNPJCPFFORMATADO varchar(18), @Contador integer, @Dado2 varchar(60), @Habilitado integer

IF @Id <> NULL
BEGIN
	SELECT IdPessoa, CNPJCPF, Nome, Habilitado 
	FROM Pessoas
	WHERE IdPessoa = @Id
	ORDER BY Nome
END
ELSE
IF @Tipo = 'STRING'
BEGIN
	DECLARE ComboPessoas_Cursor 
	CURSOR FAST_FORWARD FOR 

	SELECT IdPessoa, CNPJCPF, Nome, Habilitado 
	FROM Pessoas
	WHERE Nome LIKE @Dado + '%'
	ORDER BY Nome

END
ELSE
BEGIN
	IF CHARINDEX('.', @Dado) > 0
	BEGIN
		SET @Dado2 = ''
		SET @Contador = 0

		WHILE @Contador <= LEN(@Dado)
		BEGIN
			IF SUBSTRING(@Dado, @Contador, 1) <> '.' 
				SET @Dado2 = @Dado2 + SUBSTRING(@Dado, @Contador, 1)
			SET @Contador = @Contador + 1
		END

		SET @Dado = @Dado2
	END

	DECLARE ComboPessoas_Cursor 
	CURSOR FAST_FORWARD FOR 

	SELECT IdPessoa, CNPJCPF, Nome, Habilitado 
	FROM Pessoas
	WHERE CNPJCPF LIKE @Dado + '%'
	ORDER BY CNPJCPF, Nome

END

OPEN ComboPessoas_Cursor

FETCH NEXT FROM ComboPessoas_Cursor
INTO @IdPessoa, @CNPJCPF, @NomePessoa, @Habilitado

WHILE @@FETCH_STATUS = 0
BEGIN
	IF LEN(@CNPJCPF) = 14
		SET @CNPJCPFFORMATADO = SUBSTRING(@CNPJCPF,1,2)+'.'+SUBSTRING(@CNPJCPF,3,3)+'.'+SUBSTRING(@CNPJCPF,6,3)+'/'+SUBSTRING(@CNPJCPF,9,4)+'-'+SUBSTRING(@CNPJCPF,13,2)
	ELSE
	IF LEN(@CNPJCPF) = 11		SET @CNPJCPFFORMATADO = SUBSTRING(@CNPJCPF,1,3)+'.'+SUBSTRING(@CNPJCPF,4,3)+'.'+SUBSTRING(@CNPJCPF,7,3)+'-'+SUBSTRING(@CNPJCPF,10,2)
	ELSE
		SET @CNPJCPFFORMATADO = ''

	INSERT #ComboPessoas
		VALUES(
			@IdPessoa,
			@CNPJCPFFORMATADO,
			@NomePessoa,
			@Habilitado
			)

	FETCH NEXT FROM ComboPessoas_Cursor
	INTO @IdPessoa, @CNPJCPF, @NomePessoa, @Habilitado
END

CLOSE ComboPessoas_Cursor
DEALLOCATE ComboPessoas_Cursor

SELECT * FROM #ComboPessoas






















































