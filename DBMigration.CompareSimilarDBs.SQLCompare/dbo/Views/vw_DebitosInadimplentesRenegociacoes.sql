
CREATE VIEW  [dbo].[vw_DebitosInadimplentesRenegociacoes] WITH  SCHEMABINDING AS                       
SELECT IdDebito,  
       IdSituacaoAtual,  
       DataVencimento,  
       NumConjReneg,  
       DataReferencia,  
       NumeroParcela,  
       IdProfissional,  
       IdTipoDebito,  
IdPessoaJuridica,
       NPossuiCotaUnica  
FROM   dbo.Debitos WHERE NumConjReneg IS NOT null     
