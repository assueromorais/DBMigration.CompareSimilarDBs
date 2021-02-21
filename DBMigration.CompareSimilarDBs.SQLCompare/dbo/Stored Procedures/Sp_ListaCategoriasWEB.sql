


























CREATE Procedure dbo.Sp_ListaCategoriasWEB 
  @TipoConsulta Char(2) = ''
AS

SET NOCOUNT ON

if @TipoConsulta <> '' 
  if @TipoConsulta = 'PF'
    SELECT IdCategoriaProfissional, NomeCategoriaPF FROM CategoriasProfissional
  if @TipoConsulta = 'PJ'
    SELECT IdCategoriaPJ, NomeCategoriaPJ FROM CategoriaPJ






















































