


























Create Procedure dbo.sp_SituacoesPFValidaFaixa @IdProfissional Int,            /* Id do profissional*/
                                           @DataI DateTime,                /* Data inicial*/
                                           @DataF DateTime,                /* Data final*/
                                           @IdSituacaoExcluir Int = -1     /* Situação atual que não será considerada*/

AS

SET NOCOUNT ON

IF @DataF IS NOT Null OR ( @DataF IS NULL AND NOT EXISTS( SELECT TOP 1 IdProfissional 
                                                            FROM Profissionais_SituacoesPF
                                                           WHERE IdProfissional = @IdProfissional 
                                                                 AND DataFimSituacao IS NULL ) )
BEGIN
  IF @DataF Is Null
     SET @DataF = '30001231'
  
/*  SELECT TOP 1 IdProfissional */
  SELECT * 
     FROM Profissionais_SituacoesPF
  WHERE IdProfissional = @IdProfissional 
        AND IdProfissionalSituacaoPF <> @IdSituacaoExcluir
        AND ( ( @DataI <= DataInicioSituacao AND @DataF >= DataFimSituacao    ) OR  
              ( @DataI <= DataInicioSituacao AND @DataF >= DataInicioSituacao ) OR  
              ( @DataI <= DataFimSituacao    AND @DataF >= DataFimSituacao    ) OR  
              ( @DataI >= DataInicioSituacao AND @DataF <= DataFimSituacao    ) OR
              ( @DataF >= DataInicioSituacao And DataFimSituacao IS NULL  ) )

END
ELSE
BEGIN
  SELECT TOP 1 IdProfissional 
    FROM Profissionais_SituacoesPF
   WHERE IdProfissional = @IdProfissional 
         AND DataFimSituacao IS NULL
         AND IdProfissionalSituacaoPF <> @IdSituacaoExcluir
END

SET NOCOUNT OFF






















































