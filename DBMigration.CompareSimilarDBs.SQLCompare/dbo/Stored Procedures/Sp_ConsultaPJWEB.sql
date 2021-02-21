

CREATE PROCEDURE dbo.Sp_ConsultaPJWEB 
  @Registro VarChar(20) = '',
  @CNPJ VarChar(14) = '', 
  @Nome VarChar(50) = '',
  @UF Char(2) = '',
  @Cidade VarChar(30) = '',
  @Categoria Varchar(50) = '',
  @Regiao Int = 0
AS

SET NOCOUNT ON

DECLARE @strSQL VarChar(1500)
 SET @strSQL = 'SELECT PessoasJuridicas.IdPessoaJuridica, PessoasJuridicas.RegistroConselhoAtual, '+
              'PessoasJuridicas.Nome, Pessoas.Sigla, PessoasJuridicas.CategoriaAtual, '+
              'ISNULL( PessoasJuridicas.ExibirDadosWeb, 1) As ExibirDadosWeb '+
              'FROM PessoasJuridicas '+
              'LEFT JOIN Pessoas ON Pessoas.IdPessoa = PessoasJuridicas.IdUnidadeConselho '+
              'WHERE '
 If @Registro <> ''
  SET @strSQL = @strSQL + ' Upper(PessoasJuridicas.RegistroConselhoAtual) = Upper('''+@Registro+''') AND '
 If @CNPJ <> ''
  SET @strSQL = @strSQL + ' PessoasJuridicas.CNPJ = '''+@CNPJ+''' AND '
 If @Nome <> ''
  SET @strSQL = @strSQL + ' PessoasJuridicas.Nome LIKE '''+@Nome+''' AND '
 If @UF <> ''
  SET @strSQL = @strSQL + ' PessoasJuridicas.SiglaUF = '''+@UF+''' AND '
 If @Cidade <> ''
  SET @strSQL = @strSQL + ' PessoasJuridicas.NomeCidade LIKE '''+@Cidade+'%'' AND '
 If @Categoria <> ''
  SET @strSQL = @strSQL + ' PessoasJuridicas.CategoriaAtual LIKE LIKE '''+@Categoria+'%'
 If Right(RTrim(@strSQL), 3) = 'AND'
   SET @strSQL = SubString(@strSQL,1,Len(@strSQL)-3) If Right(@strSQL,6) <> 'WHERE'

Exec(@strSQL)

SET NOCOUNT OFF




