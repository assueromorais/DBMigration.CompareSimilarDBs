


























CREATE PROCEDURE dbo.sp_DeleOcorrencias @TipoPessoa Char(1),
                                    @IdPessoa Int
AS

SET NOCOUNT ON

DECLARE @IdOcorrenciaPFPJ Int

/*                                                   INICIO DO CURSOR PARA DELEÇÃO DOS HISTÓRICOS DA SITUAÇÃO*/
/* OCORRÊNCIAS DO PROFISSIONAL @IdPessoa*/
IF @TipoPessoa = 'F' 
BEGIN
  DECLARE Cursor_Ocorrencia CURSOR FAST_FORWARD READ_ONLY
  FOR SELECT IdOcorrenciaPFPJ
        FROM OcorrenciasPFPJ
       WHERE IdProfissional = @IdPessoa
END

/* OCORRÊNCIAS DA ENTIDADE @IdPessoa*/
IF @TipoPessoa = 'J'  
BEGIN
  DECLARE Cursor_Ocorrencia CURSOR FAST_FORWARD READ_ONLY
  FOR SELECT IdOcorrenciaPFPJ
        FROM OcorrenciasPFPJ
       WHERE IdPessoaJuridica = @IdPessoa


END  

/*DELEÇÃO DOS HISTÓRICOS DA SITUAÇÃO*/
OPEN Cursor_Ocorrencia
FETCH NEXT FROM Cursor_Ocorrencia INTO @IdOcorrenciaPFPJ
WHILE (@@fetch_status <> -1)
BEGIN
  DELETE FROM OcorrenciasPFPJ_SituacoesOcorrencia 
        WHERE IdOcorrenciaPFPJ = @IdOcorrenciaPFPJ
  
  FETCH NEXT FROM Cursor_Ocorrencia INTO @IdOcorrenciaPFPJ
END
CLOSE cursor_Ocorrencia
DEALLOCATE cursor_Ocorrencia
/*                                                   FINAL DO CURSOR PARA DELEÇÃO DOS HISTÓRICOS DA SITUAÇÃO*/

/* DELEÇÃO DAS OCORRÊNCIAS DO PROFISSIONAL*/
IF @TipoPessoa = 'F'
  DELETE FROM OcorrenciasPFPJ
        WHERE IdProfissional = @IdPessoa

/* DELEÇÃO DAS OCORRÊNCIAS DA ENTIDADE @IdPessoa*/
IF @TipoPessoa = 'J'  
  DELETE FROM OcorrenciasPFPJ
        WHERE IdPessoaJuridica = @IdPessoa


SET NOCOUNT OFF






















































