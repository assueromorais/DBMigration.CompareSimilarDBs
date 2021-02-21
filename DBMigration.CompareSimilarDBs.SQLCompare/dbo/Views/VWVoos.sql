/*
Criação das views do Sispad
André - 17/09/2009
*/

CREATE VIEW [dbo].[VWVoos]
AS
SELECT     dbo.Voos.*
FROM         dbo.Voos INNER JOIN
                      dbo.Companhias ON dbo.Voos.IdPessoaCompanhia = dbo.Companhias.IdPessoaCompanhia INNER JOIN
                      dbo.Pessoas ON dbo.Companhias.IdPessoa = dbo.Pessoas.IdPessoa
WHERE     (dbo.Pessoas.Ativo = 1)
