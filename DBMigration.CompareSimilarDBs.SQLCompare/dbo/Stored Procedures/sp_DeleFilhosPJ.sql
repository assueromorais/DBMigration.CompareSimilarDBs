CREATE PROCEDURE [sp_DeleFilhosPJ]( @IdPessoaJuridica INT )
AS
SET NOCOUNT ON
SELECT TOP 1 * FROM Debitos                WHERE IdPessoaJuridica = @IdPessoaJuridica
IF @@RowCount = 0
BEGIN
    /* Não destruir PJ se ela for relacionada como Matriz por outrasPJ (autorelacionamento) */
  SELECT TOP 1 IdPessoaJuridica FROM PessoasJuridicas WHERE IdMatriz = @IdPessoaJuridica
  IF @@RowCount = 0
  BEGIN
    DELETE AreasAtuacao_PessoasJuridicas   WHERE IdPessoaJuridica = @IdPessoaJuridica
    DELETE CapitaisSocial                  WHERE IdPessoaJuridica = @IdPessoaJuridica
    DELETE Credenciados                    WHERE IdPessoaJuridica = @IdPessoaJuridica
    DELETE Enderecos                       WHERE IdPessoaJuridica = @IdPessoaJuridica
    /* DELETE DocumentosSisdoc              WHERE IdPessoaJuridica = @IdPessoaJuridica  ( tem filhos ) */


    /* Emissoes e seus detalhes */
    DECLARE @IdEmissao INT
    DECLARE Cursor_Emissoes CURSOR FAST_FORWARD READ_ONLY
    FOR SELECT IdEmissao
          FROM Emissoes
         WHERE IdPessoaJuridica = @IdPessoaJuridica

    /*Deleção detalhes da emissão */
    OPEN Cursor_Emissoes
    FETCH NEXT FROM Cursor_Emissoes INTO @IdEmissao
    WHILE (@@fetch_status <> -1)
    BEGIN
      DELETE FROM DetalhesEmissao
            WHERE IdEmissao = @IdEmissao
      FETCH NEXT FROM Cursor_Emissoes INTO @IdEmissao
    END
    DELETE Emissoes                         WHERE IdPessoaJuridica = @IdPessoaJuridica
    CLOSE Cursor_Emissoes
    DEALLOCATE Cursor_Emissoes

    /*Deleção de Experiencias profissionais relacionados com esta PJ */
    DECLARE @IdExperienciaProfissional INT
    DECLARE @IdResponsavelTecnico      INT

    DECLARE Cursor_Experiencias CURSOR FAST_FORWARD READ_ONLY
    FOR SELECT IdExperienciaProfissional
          FROM ExperienciasProfissionais
         WHERE IdPessoaJuridica = @IdPessoaJuridica

    OPEN Cursor_Experiencias
    FETCH NEXT FROM Cursor_Experiencias INTO @IdExperienciaProfissional
    WHILE (@@fetch_status <> -1)
    BEGIN
      DECLARE Cursor_Responsaveis CURSOR FAST_FORWARD READ_ONLY
      FOR SELECT IdResponsavelTecnico
       FROM ResponsaveisTecnicosPJ
           WHERE IdExperienciaProfissional = @IdExperienciaProfissional

      OPEN Cursor_Responsaveis
      FETCH NEXT FROM Cursor_Responsaveis INTO @IdResponsavelTecnico
      WHILE (@@fetch_status <> -1)
      BEGIN
        DELETE FROM HorariosResponsavelTecnico
              WHERE IdResponsavelTecnico = @IdResponsavelTecnico
        FETCH NEXT FROM Cursor_Responsaveis INTO @IdResponsavelTecnico
      END
      DELETE FROM ResponsaveisTecnicosPJ
            WHERE IdExperienciaProfissional = @IdExperienciaProfissional
      CLOSE Cursor_Responsaveis

      DEALLOCATE Cursor_Responsaveis
      FETCH NEXT FROM Cursor_Experiencias INTO @IdExperienciaProfissional
    END
    DELETE ExperienciasProfissionais       WHERE IdPessoaJuridica = @IdPessoaJuridica
    CLOSE Cursor_Experiencias
    DEALLOCATE Cursor_Experiencias

    /* Em Fiscalizacoes, pessoa jurídica entra como denunciante */
    UPDATE Fiscalizacoes
       SET IdPessoaJuridica_Denunciante = NULL
     WHERE IdPessoaJuridica_Denunciante = @IdPessoaJuridica

    /* Fiscalizacoes_Prof_PJ contém o registro das fiscalizações da pessoa jurídica */
    DECLARE @IdFiscalizacao INT
    DECLARE Cursor_Fiscalizacao CURSOR FAST_FORWARD READ_ONLY
    FOR SELECT IdFiscalizacao
          FROM Fiscalizacoes_Prof_PJ
         WHERE IdPessoaJuridica = @IdPessoaJuridica

    OPEN Cursor_Fiscalizacao
    FETCH NEXT FROM Cursor_Fiscalizacao   INTO @IdFiscalizacao
    WHILE (@@fetch_status <> -1)
    BEGIN
      EXEC sp_DeletarFiscalizacao @IdFiscalizacao, 1
      FETCH NEXT FROM Cursor_Fiscalizacao INTO @IdFiscalizacao
    END
    DELETE FROM Fiscalizacoes_Prof_PJ
          WHERE IdPessoaJuridica = @IdPessoaJuridica
    CLOSE Cursor_Fiscalizacao

    DEALLOCATE Cursor_Fiscalizacao

    /* Processos_Prof_PJ contém o registro dos processos da pessoa jurídica */
    DECLARE @IdProcesso INT
    DECLARE Cursor_Processos CURSOR FAST_FORWARD READ_ONLY
    FOR SELECT IdProcesso
          FROM Processos_Prof_PJ
         WHERE IdPessoaJuridica = @IdPessoaJuridica

    OPEN Cursor_Processos
    FETCH NEXT FROM Cursor_Processos   INTO @IdProcesso
    WHILE (@@fetch_status <> -1)
    BEGIN
      EXEC sp_DeletarProcesso @IdProcesso, 1, 1, 1, 1
      FETCH NEXT FROM Cursor_Processos INTO @IdProcesso
    END
    DELETE FROM Processos_Prof_PJ
          WHERE IdPessoaJuridica = @IdPessoaJuridica
    CLOSE Cursor_Processos

    DEALLOCATE Cursor_Processos

    EXEC sp_DeleOcorrencias 'J', @IdPessoaJuridica
    DELETE OutrasResponsabilidades         WHERE IdPessoaJuridica = @IdPessoaJuridica
    DELETE PessoasJuridicas_CategoriaPJ    WHERE IdPessoaJuridica = @IdPessoaJuridica
    DELETE PessoasJuridicas_SituacoesPFPJ  WHERE IdPessoaJuridica = @IdPessoaJuridica
    DELETE RespostasPFPJ                   WHERE IdPessoaJuridica = @IdPessoaJuridica
    DELETE SetoresAtuacao_PessoasJuridicas WHERE IdPessoaJuridica = @IdPessoaJuridica
    DELETE TiposPessoa_PessoasJuridicas    WHERE IdPessoaJuridica = @IdPessoaJuridica
  END
END
SET NOCOUNT OFF
