/*OC 130745 Claudio Marconi Bug709 Adicionado por Rafaela*/
CREATE PROCEDURE [dbo].[spComboPessoas]

@Id integer,  
@Tipo varchar(7) = 'STRING', 
@Dado varchar(60)
AS

SET NOCOUNT ON

CREATE TABLE #ComboPessoas
	(
		IdPessoa	int,
		CNPJCPF	varchar(18) COLLATE database_default,
		Nome		varchar(60) COLLATE database_default,
		Habilitado	int,
		E_PessoaJuridica bit
	)

DECLARE @IdPessoa int, @NomePessoa varchar(60), @CGCCPF varchar(14), 
	@CGCCPFFORMATADO varchar(18), @Contador int, @Dado2 varchar(60), @Habilitado int, @E_PessoaJuridica bit

IF @Id <> NULL
BEGIN
	SELECT IdPessoa, CNPJCPF, Nome, Habilitado, E_PessoaJuridica
	FROM Pessoas
	WHERE IdPessoa = @Id
	ORDER BY Nome
END
ELSE
--Original 
--IF @Tipo = 'STRING'
IF (@Tipo = 'STRING') OR (ISNUMERIC(@Dado) = 0) 
BEGIN
	DECLARE ComboPessoas_Cursor 
	CURSOR FAST_FORWARD FOR 

	SELECT IdPessoa, CNPJCPF, Nome, Habilitado, E_PessoaJuridica
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

	SELECT IdPessoa, CNPJCPF, Nome, Habilitado, E_PessoaJuridica
	FROM Pessoas
	WHERE CNPJCPF LIKE @Dado + '%'
	ORDER BY CNPJCPF, Nome

END

OPEN ComboPessoas_Cursor

FETCH NEXT FROM ComboPessoas_Cursor
INTO @IdPessoa, @CGCCPF, @NomePessoa, @Habilitado, @E_PessoaJuridica

WHILE @@FETCH_STATUS = 0
BEGIN
	IF LEN(@CGCCPF) = 14
		SET @CGCCPFFORMATADO = SUBSTRING(@CGCCPF,1,2)+'.'+SUBSTRING(@CGCCPF,3,3)+'.'+SUBSTRING(@CGCCPF,6,3)+'/'+SUBSTRING(@CGCCPF,9,4)+'-'+SUBSTRING(@CGCCPF,13,2)
	ELSE
	IF LEN(@CGCCPF) = 11
		SET @CGCCPFFORMATADO = SUBSTRING(@CGCCPF,1,3)+'.'+SUBSTRING(@CGCCPF,4,3)+'.'+SUBSTRING(@CGCCPF,7,3)+'-'+SUBSTRING(@CGCCPF,10,2)
	ELSE
		SET @CGCCPFFORMATADO = ''

	INSERT #ComboPessoas
		VALUES(
			@IdPessoa,
			@CGCCPFFORMATADO,
			@NomePessoa,
			@Habilitado,
			@E_PessoaJuridica
			)

	FETCH NEXT FROM ComboPessoas_Cursor
	INTO @IdPessoa, @CGCCPF, @NomePessoa, @Habilitado, @E_PessoaJuridica
END

CLOSE ComboPessoas_Cursor
DEALLOCATE ComboPessoas_Cursor

SELECT * FROM #ComboPessoas

