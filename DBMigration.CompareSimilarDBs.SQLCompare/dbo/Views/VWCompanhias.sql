/*
Criação das views do Sispad
André - 17/09/2009
*/

CREATE VIEW [dbo].[VWCompanhias]
AS
SELECT     
dbo.Companhias.IdPessoaCompanhia, 
dbo.Companhias.IdPessoa,
dbo.Companhias.SiglaCompanhia,
dbo.Pessoas.Nome, 
dbo.Pessoas.CNPJCPF, 
dbo.Pessoas.Ativo, 
dbo.Pessoas.ModuloSispad
FROM         dbo.Pessoas INNER JOIN
                      dbo.Companhias ON dbo.Pessoas.IdPessoa = dbo.Companhias.IdPessoa
