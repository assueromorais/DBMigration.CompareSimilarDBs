/*
Criação das procedures do Sispad
André - 17/09/2009
*/

CREATE PROCEDURE [dbo].[spComboPessoaJuridica] @Id INTEGER, @Tipo VARCHAR(7) = 'STRING', @Dado VARCHAR( 60 )

AS

SET NOCOUNT ON

DECLARE @IdPessoaJuridica INT, @Nome  VARCHAR(60), @RegistroConselho VARCHAR( 20 ), @I INT

-- RETORNAR IdPessoaJuridica, Nome, RegistroConselhoAtual SE POSSUIR O ID
IF @Id <> NULL
	SELECT IdPessoaJuridica, RegistroConselhoAtual, Nome
     FROM PessoasJuridicas
    WHERE IdPessoaJuridica = @Id
	ORDER BY Nome
ELSE
BEGIN
   -- SE EXISTIR ALGUM DIGITO NO DADO INFORMADO, O TIPO PASSA A SER INTEGER
   SET @i = 1
   WHILE @i <= 6
   BEGIN
   	IF ISNUMERIC( SUBSTRING( @Dado, @i, 1 ) ) = 1
   		SET @Tipo = 'INTEGER'
   	SET @i = @i + 1
   END
   
   
   IF @Tipo = 'STRING'
      -- SELEÇÃO PELO NOME DA ENTIDADE
      SELECT IdPessoaJuridica, RegistroConselhoAtual, Nome
        FROM PessoasJuridicas
       WHERE Nome LIKE @Dado + '%' 
       ORDER BY Nome
   ELSE
      -- SELEÇÃO PELO REGISTRO CONSELHO ( INCLUSIVE HISTÓRICO )
      SELECT IdPessoaJuridica, RegistroConselhoAtual, Nome
        FROM PessoasJuridicas
       WHERE  IdPessoaJuridica IN ( SELECT IdPessoaJuridica  FROM PessoasJuridicas_CategoriaPJ
                             		 WHERE RegistroConselho IS NOT NULL AND 
                                    		PessoasJuridicas_CategoriaPJ.IdPessoaJuridica = PessoasJuridicas.IdPessoaJuridica AND
				RegistroConselho LIKE '%' + @Dado + '%' )

       ORDER BY RegistroConselhoAtual 
END
