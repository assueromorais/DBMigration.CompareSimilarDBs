/* Task 4257 */ 

CREATE PROCEDURE [dbo].[sp_ResponsaValidaFaixa]  @IdProfissional      Int,
                                        @IdPJ			       Int,
                                        @Tipo                Int,
                                        @DataI			       DateTime, 
                                        @DataF			       DateTime,
                                        @IdResponsaExcluir   Int = -1,
                                        @IdSetorResponsabilidade Int

AS

SET NOCOUNT ON  
  
IF @DataF IS NOT Null OR ( @DataF IS NULL AND NOT EXISTS  
                                           (  SELECT TOP 1 IdProfissional, IdPessoaJuridica  
                                                     FROM ResponsaveisTecnicosPJ, ExperienciasProfissionais  
                                          WHERE IdProfissional = @IdProfissional
                                          AND ResponsaveisTecnicosPJ.IdSetorResponsabilidade = @IdSetorResponsabilidade
                                            
                                          AND ResponsaveisTecnicosPJ.IdExperienciaProfissional =    
                                          ExperienciasProfissionais.IdExperienciaProfissional  
                                          And (   
                                                            ( ( @Tipo = 0 ) AND ( IdPessoa = @IdPJ ) )   
                                                             OR    
                                                            ( ( @Tipo = 1 ) AND ( IdPessoaJuridica = @IdPJ ) )   
                                                          )  
                                                      AND DataFim IS NULL ) )  
BEGIN  
  IF @DataF Is Null  
     SET @DataF = '30001231'  
/*  SELECT TOP 1 IdProfissional */  
  SELECT * FROM ResponsaveisTecnicosPJ, ExperienciasProfissionais  
  WHERE IdProfissional = @IdProfissional   
    AND ResponsaveisTecnicosPJ.IdSetorResponsabilidade = @IdSetorResponsabilidade
    AND ResponsaveisTecnicosPJ.IdExperienciaProfissional =    
        ExperienciasProfissionais.IdExperienciaProfissional  
        AND IdResponsavelTecnico <> @IdResponsaExcluir   
        AND ( ( ( @Tipo = 0 ) AND ( IdPessoa = @IdPJ ) ) OR ( ( @Tipo = 1 ) AND ( IdPessoaJuridica = @IdPJ ) ) )  
        AND ( ( @DataI <= DataInicio AND @DataF >= DataFim    ) OR    
              ( @DataI <= DataInicio AND @DataF >= DataInicio ) OR    
              ( @DataI <= DataFim    AND @DataF >= DataFim    ) OR    
              ( @DataI >= DataInicio AND @DataF <= DataFim    ) OR  
              ( @DataF >= DataInicio And DataFim IS NULL  ) )  
  
END  
ELSE  
BEGIN  
  SELECT TOP 1 IdProfissional, IdPessoaJuridica  
        FROM ResponsaveisTecnicosPJ, ExperienciasProfissionais  
   WHERE IdProfissional = @IdProfissional  
     AND ResponsaveisTecnicosPJ.IdSetorResponsabilidade = @IdSetorResponsabilidade
     AND ResponsaveisTecnicosPJ.IdExperienciaProfissional =    
     ExperienciasProfissionais.IdExperienciaProfissional  
       AND ( ( ( @Tipo = 0 ) AND ( IdPessoa = @IdPJ ) ) OR ( ( @Tipo = 1 ) 
       AND ( IdPessoaJuridica = @IdPJ ) ) )  
       AND DataFim IS NULL  
END  
 
SET NOCOUNT OFF
