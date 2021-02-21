/*
Criação das views do Sispad
André - 17/09/2009
*/

CREATE VIEW [dbo].[VWHoteis]
AS
SELECT
IdPessoa
, Nome
, CNPJCPF
, Ativo
, ModuloSispad
FROM         dbo.Pessoas
WHERE     (ModuloSispad = 3)
