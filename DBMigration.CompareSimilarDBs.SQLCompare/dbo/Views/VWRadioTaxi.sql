/*
Criação das views do Sispad
André - 17/09/2009
*/

CREATE VIEW [dbo].[VWRadioTaxi]
AS
SELECT     dbo.RadioTaxi.IdRadioTaxi, dbo.Pessoas.Nome
FROM         dbo.RadioTaxi INNER JOIN
                      dbo.Pessoas ON dbo.RadioTaxi.IdPessoa = dbo.Pessoas.IdPessoa
