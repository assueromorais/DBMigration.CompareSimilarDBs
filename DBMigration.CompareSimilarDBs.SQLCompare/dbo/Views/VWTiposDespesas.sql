/*
Alimentação das tabelas do Sispad
André - 05/10/2009
*/

CREATE VIEW [dbo].[VWTiposDespesas]
AS
SELECT     IdTipoDespesa, CASE WHEN TipoDespesa = 'Diária' THEN
                          (SELECT     ISNULL(DiariaDescricaosg, 'Diária')
                            FROM          ConfiguracoesSispad) ELSE CASE WHEN TipoDespesa = 'Indenização' THEN
                          (SELECT     ISNULL(IndenizacaoDescricaosg, 'Indenização')
                            FROM          ConfiguracoesSispad) ELSE TipoDespesa END END AS TipoDespesa
FROM         dbo.TiposDespesas AS TD
