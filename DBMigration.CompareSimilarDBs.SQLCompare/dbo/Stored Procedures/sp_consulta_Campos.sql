/*Oc. 64821 - Victor*/

CREATE PROCEDURE [dbo].[sp_consulta_Campos] (@Id_Assunto SMALLINT)
AS
BEGIN
	SELECT Id_Campo_Log,
	       Nome_Campo = Tabela + ' - ' +
	       CASE 
	            WHEN Nome_Titulo IS NULL THEN Nome_Campo
	            ELSE Nome_Titulo
	       END
	FROM   ImplantaLog.dbo.Assunto_Tabela_Log t1,
	       ImplantaLog.dbo.Campo_Log t2,
	       ImplantaLog.dbo.Tabela_Log t3
	WHERE  t1.Id_Tabela = t2.Id_Tabela
	       AND Id_Assunto = @Id_Assunto
	       AND (ApresentaCampo IS NULL OR ApresentaCampo = 'S')
	       AND t1.Id_Tabela = t3.Id_Tabela
	ORDER BY
	       Nome_Campo
END
