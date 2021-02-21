
CREATE VIEW  [dbo].[vw_DebitosInadimplentesOutros] WITH  SCHEMABINDING AS                       
SELECT IdDebito,  
       IdPessoaJuridica,
       IdSituacaoAtual,  
       DataVencimento,  
       NumConjReneg,  
       DataReferencia,  
       NumeroParcela,  
       IdProfissional,  
       IdTipoDebito,  
       NPossuiCotaUnica  
FROM   dbo.Debitos     
WHERE IdProfissional IS NOT NULL   
    
  AND  (  
           (     /*testar performance*/  
               (dbo.Debitos.IdSituacaoAtual IN (1, 3, 10,15 )   
                 
                  
            
          AND  (  
                   (  
                       dbo.Debitos.NumeroParcela = 0      
                         
                   )  
     OR  dbo.Debitos.NPossuiCotaUnica = 1  
               )  
           )      
               
           )  
             
        
  )  
