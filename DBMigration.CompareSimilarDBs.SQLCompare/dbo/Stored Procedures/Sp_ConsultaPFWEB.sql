

CREATE Procedure dbo.Sp_ConsultaPFWEB 
  @Registro VarChar(20) = '',
  @CPF VarChar(11) = '', 
  @Nome VarChar(50) = '',
  @UF Char(2) = '',
  @Cidade VarChar(30) = '',
  @Categoria VarChar(30) = '',
  @Regiao Int = 0
AS

SET NOCOUNT ON

DECLARE @strSQL VARCHAR(1500)

SET @strSQL = 'SELECT IdProfissional, Profissionais.Nome, Profissionais.RegistroConselhoAtual, Profissionais.CategoriaAtual, '+
              'Pessoas.Sigla, ISNULL( Profissionais.ExibirDadosWeb, 1) As ExibirDadosWeb  FROM Profissionais '+
              'LEFT JOIN Pessoas ON Pessoas.IdPessoa = Profissionais.IdUnidadeConselho '+
              'WHERE '

If @Registro <> ''
  SET @strSQL = @strSQL + ' Upper(Profissionais.RegistroConselhoAtual) = Upper('''+@Registro+''')'

If @CPF <> ''
  SET @strSQL = @strSQL + ' CPF = '''+@CPF+'''' If @Nome <> ''
  SET @strSQL = @strSQL + ' Profissionais.Nome LIKE '''+@Nome+''' AND'

If @UF <> '' 
  SET @strSQL = @strSQL + ' Profissionais.SiglaUF = '''+@UF+''' AND'

If @Cidade <> '' 
  SET @strSQL = @strSQL + ' Profissionais.NomeCidade LIKE '''+@Cidade+''' AND'

If @Categoria > 0
  SET @strSQL = @strSQL + ' Profissionais.CategoriaAtual LIKE '''+@Categoria+''' AND'

If @Regiao > 0
   SET @strSQL = @strSQL + 'IdPessoa = '+Cast(@Regiao As VarChar(5))+''

If Right(@strSQL, 3) = 'AND'
  SET @strSQL = SubString(@strSQL,1,Len(@strSQL)-3) 
If Right(@strSQL,6) <> 'WHERE'
  Exec(@strSQL)

SET NOCOUNT OFF




