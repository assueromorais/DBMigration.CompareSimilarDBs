/*Oc. 133697 Task 2029 Seila Adicionado por Rafaela*/
CREATE PROCEDURE [dbo].[spErroRenRec]
AS
SET NOCOUNT ON 

/*Objetivo Detectar erros em renegociações "Ativas" do ano corrente. 
*           Ao primeiro erro encontrado já dispara a mensagem,e não verifica demais erros para agilizar a performace.
*				Erro 01 NumConjReneg está nulo
*				Erro 02 Não existe composição.Toda Ren/Rec precisa ter composição para associar a sua origem
*				Erro 03 A origem da Ren/Rec não existe na tabela de débitos
*/

DECLARE @Erro BIT , 
        @TipoErro VARCHAR(100)

SET @Erro = 0
SET @TipoErro = ''

IF @Erro = 0
BEGIN
/*Erro 01 NumConjReneg está nulo*/	
	IF (SELECT ISNULL(
						(SELECT COUNT(*) /*Usar COUNT, pois a performance com TOP, MAX ou MIN está menor*/ 
						 FROM Debitos DB
						 WHERE DB.IdTipoDebito IN(2,10) /*Ren/Rec*/ 
						   AND DB.IdSituacaoAtual NOT IN(9,12) /*Cancelado/Cancelado em D.A.*/
						   AND DB.NumConjReneg IS NULL 
						   AND YEAR(DB.DataReferencia) = YEAR(GETDATE())/*Ano corrente*/
						)
					  ,0)
	   ) > 0 
    SELECT @Erro = 1,@TipoErro = '01-NumConjReneg está nulo'			  
END 

IF @Erro = 0
BEGIN
/*Erro 02 Não existe composição para Ren/Rec.Toda Ren/Rec precisa ter composição para associar a sua origem*/
	IF (SELECT ISNULL(
						(SELECT COUNT(*) /*Usar COUNT, pois a performance com TOP, MAX ou MIN está menor*/ 
						 FROM (SELECT DB.IdDebito 
							   FROM Debitos DB
							   WHERE DB.IdTipoDebito IN(2,10)
								 AND DB.IdSituacaoAtual NOT IN(9,12)
								 AND YEAR(DB.DataReferencia) = YEAR(GETDATE()) 
							   )X LEFT JOIN /*Usar X,para melhorar a permormance diminuindo a quantidade de registros de débitos.*/ 
							   ComposicoesDebito CD ON CD.IdDebito = X.IdDebito
						 WHERE CD.IdDebito IS NULL 
						)
					,0)
	   ) > 0 /*Não Existe Composição*/
	SELECT @Erro = 1,@TipoErro = '02-Não Existe Composição para Ren/Rec'							
END

IF @Erro = 0
BEGIN
/*Erro 03 A origem da Ren/Rec não existe na tabela de débitos*/
	IF (SELECT ISNULL(
						(SELECT COUNT(*)
						 FROM (SELECT CD.IdDebito,CD.IdDebitoOrigemRen
							   FROM ComposicoesDebito CD
							   WHERE CD.IdDebitoOrigemRen IS NOT NULL
						       ) OrigRen LEFT JOIN /*Usar OrigRen,para melhorar a permormance diminuindo a quantidade de registros de ComposicoesDebito*/
							   Debitos DB ON DB.IdDebito = OrigRen.IdDebitoOrigemRen LEFT JOIN /*O débito informado no campo IdDebitoOrigemRen não existe na tabela de débitos*/
							   Debitos DB1 ON DB1.IdDebito = OrigRen.IdDebito  /*O débito é Ren/Rec e não está cancelado*/
						 WHERE DB.IdDebito IS NULL /*A origem não existe na tabela de débitos*/ 
						   AND DB1.IdTipoDebito IN(2,10)/*Ren/Rec*/ 
						   AND DB1.IdSituacaoAtual NOT IN(9,12)/*Cancelado/Cancelado em DA*/
						   AND YEAR(DB1.DataReferencia) = YEAR(GETDATE())/*Ano corrente*/
						 ),0)
	   ) > 0
	  SELECT @Erro = 1,@TipoErro = '03-A origem da Ren/Rec não existe na tabela de débitos'		
END  

	SELECT Erro = @Erro,
	       TipoErro = @TipoErro 
                        
SET NOCOUNT OFF
