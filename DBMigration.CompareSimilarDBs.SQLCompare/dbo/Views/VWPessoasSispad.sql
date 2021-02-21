/*
Criação das views do Sispad
André - 17/09/2009
*/

CREATE VIEW [dbo].[VWPessoasSispad]
AS
SELECT     dbo.Pessoas.IdPessoa, dbo.Pessoas.Nome, dbo.Pessoas.CNPJCPF, dbo.PessoasSispad.IdPessoaSispad
FROM         dbo.Pessoas INNER JOIN
                      dbo.PessoasSispad ON dbo.Pessoas.IdPessoa = dbo.PessoasSispad.IdPessoa
WHERE dbo.Pessoas.E_PessoaJuridica = 0                      
AND dbo.Pessoas.ModuloSispad = 4
