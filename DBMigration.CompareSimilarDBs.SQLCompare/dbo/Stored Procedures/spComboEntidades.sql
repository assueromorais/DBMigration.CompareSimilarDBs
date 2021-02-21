/*Ocorr. 60606 - Seila*/

CREATE PROCEDURE [dbo].[spComboEntidades]

@Id integer,  
@Tipo varchar(7) = 'STRING', 
@Dado varchar(120)
AS

SET NOCOUNT ON

CREATE TABLE #ComboPessoas
	(
		IdPessoa	int,
		Codigo		varchar(5) COLLATE database_default,
		Nome		varchar(120) COLLATE database_default,
		Habilitado	int,
		E_PessoaJuridica bit,
		E_InstituicaoEnsino bit
	)

DECLARE @IdPessoa int, @NomePessoa varchar(120), @Codigo varchar(5), 
	@Contador int, @Dado2 varchar(120), @Habilitado int, @E_PessoaJuridica bit, @E_InstituicaoEnsino bit

IF @Id <> NULL
BEGIN
	SELECT IdPessoa, Codigo, Nome, Habilitado, E_PessoaJuridica, E_InstituicaoEnsino
	FROM Pessoas
	WHERE IdPessoa = @Id
	ORDER BY Nome
END
ELSE
IF @Tipo = 'STRING'
BEGIN
	DECLARE ComboPessoas_Cursor 
	CURSOR FAST_FORWARD FOR 

	SELECT IdPessoa, Codigo, Nome, Habilitado, E_PessoaJuridica, E_InstituicaoEnsino
	FROM Pessoas
	WHERE Nome LIKE @Dado + '%'
	ORDER BY Nome

END
ELSE
BEGIN
	DECLARE ComboPessoas_Cursor 
	CURSOR FAST_FORWARD FOR 

	SELECT IdPessoa, Codigo, Nome, Habilitado, E_PessoaJuridica, E_InstituicaoEnsino
	FROM Pessoas
	WHERE Codigo LIKE @Dado + '%'
	ORDER BY Codigo, Nome

END

OPEN ComboPessoas_Cursor

FETCH NEXT FROM ComboPessoas_Cursor
INTO @IdPessoa, @Codigo, @NomePessoa, @Habilitado, @E_PessoaJuridica, @E_InstituicaoEnsino

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT #ComboPessoas
		VALUES(
			@IdPessoa,
			@Codigo,
			@NomePessoa,
			@Habilitado,
			@E_PessoaJuridica,
			@E_InstituicaoEnsino
			)

	FETCH NEXT FROM ComboPessoas_Cursor
	INTO @IdPessoa, @Codigo, @NomePessoa, @Habilitado, @E_PessoaJuridica, @E_InstituicaoEnsino
END

CLOSE ComboPessoas_Cursor
DEALLOCATE ComboPessoas_Cursor

SELECT * FROM #ComboPessoas

SET NOCOUNT OFF
