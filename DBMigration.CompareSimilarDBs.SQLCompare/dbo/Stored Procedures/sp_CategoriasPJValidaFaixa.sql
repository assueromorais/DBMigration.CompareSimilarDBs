

CREATE Procedure dbo.sp_CategoriasPJValidaFaixa @IdPessoaJuridica Int,      /* Id do profissional*/
                                            @DataI DateTime,                /* Data inicial*/
                                            @DataF DateTime,                /* Data final*/
                                            @IdCategoriaExcluir Int = -1    /* Categoria atual que não será considerada*/

AS

SET NOCOUNT ON

IF @DataF IS NOT Null OR ( @DataF IS NULL AND NOT EXISTS( SELECT TOP 1 IdPessoaJuridica
                                                            FROM PessoasJuridicas_CategoriaPJ
                                                           WHERE IdPessoaJuridica = @IdPessoaJuridica
                                                                 AND IdCategoriaPJ IS NOT NULL
                                                                 AND DataFim IS NULL ) )
BEGIN
  IF @DataF Is Null
     SET @DataF = '30001231'

  SELECT * 
     FROM PessoasJuridicas_CategoriaPJ
  WHERE IdPessoaJuridica = @IdPessoaJuridica 
        AND IdPessoaJuridicaCategoriaPJ <> @IdCategoriaExcluir
        AND ( ( @DataI <= DataInicio AND @DataF >= DataFim    ) OR  
              ( @DataI <= DataInicio AND @DataF >= DataInicio ) OR  
              ( @DataI <= DataFim    AND @DataF >= DataFim    ) OR  
              ( @DataI >= DataInicio AND @DataF <= DataFim    ) OR
              ( @DataF >= DataInicio And DataFim IS NULL  ) )

END
ELSE
BEGIN
  SELECT TOP 1 IdPessoaJuridica
    FROM PessoasJuridicas_CategoriaPJ
   WHERE IdPessoaJuridica = @IdPessoaJuridica
         AND IdCategoriaPJ IS NOT NULL
         AND DataFim IS NULL
         AND IdPessoaJuridicaCategoriaPJ <> @IdCategoriaExcluir
END
SET NOCOUNT OFF




