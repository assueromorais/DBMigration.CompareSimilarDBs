/*Oc 135761 Task 1996 Seila Adicionado por Rafaela*/
CREATE  VIEW [dbo].[vw_ExpRespTec]
AS
SELECT EP.IdProfissional,EP.IdExperienciaProfissional    
FROM ExperienciasProfissionais EP LEFT JOIN 
   ResponsaveisTecnicosPJ RT ON RT.IdExperienciaProfissional = EP.IdExperienciaProfissional
WHERE CASE 
    WHEN (
             RT.DataFim IS NULL
             OR RT.DataFim >= GETDATE()
         ) AND (
             RT.IdExperienciaProfissional IS NOT 
             NULL
         ) THEN 'Sim'
    ELSE 'Não'
END = 'Sim'  
