/* OC 107595 */

CREATE FUNCTION [dbo].[ufnProjetosSolicitacaoViagem]  
(  
 @IdProcessoSolicitacaoViagem INT  
)  
RETURNS VARCHAR(MAX)  
AS  
BEGIN  
 DECLARE @Projetos VARCHAR(MAX)  
 SET @Projetos = '';  
 declare @Projeto VARCHAR(80)
 SET @Projeto = '';

 DECLARE cSolicitacoes CURSOR LOCAL FOR
 SELECT sv.NumeroProjeto 
   FROM SolicitacoesViagem sv 
   WHERE sv.IdProcessoSolicitacaoViagem = @IdProcessoSolicitacaoViagem;
 OPEN cSolicitacoes;
 FETCH NEXT FROM cSolicitacoes INTO @Projeto
 WHILE (@@FETCH_STATUS = 0)
 BEGIN
  IF @Projetos <> '' 
	 SET @Projetos = @Projetos + CHAR(13)+CHAR(10) + ISNULL(@Projeto, '') 
  ELSE
	 SET @Projetos = @Projetos + ISNULL(@Projeto, '') 
  FETCH NEXT FROM cSolicitacoes INTO @Projeto;
 END 
 CLOSE      cSolicitacoes;  
 DEALLOCATE cSolicitacoes;
 RETURN @Projetos;  
END 

