
/*
Criação das views do Sispad
André - 17/09/2009
*/

CREATE VIEW [dbo].[VWAeroportos]
AS
SELECT 
dbo.Aeroportos.IdPessoaAeroporto
, dbo.Aeroportos.IdPessoa
, dbo.Aeroportos.SiglaAeroporto
, dbo.Pessoas.Nome + CASE WHEN dbo.Aeroportos.SiglaAeroporto IS NOT NULL 

THEN ' - ' + dbo.Aeroportos.SiglaAeroporto COLLATE database_default ELSE '' END Nome
, dbo.Pessoas.CNPJCPF 
, dbo.Pessoas.Ativo 
, dbo.Pessoas.ModuloSispad
FROM     dbo.Aeroportos INNER JOIN
               dbo.Pessoas ON dbo.Aeroportos.IdPessoa = 

dbo.Pessoas.IdPessoa
WHERE dbo.Aeroportos.SiglaAeroporto IS NOT NULL
