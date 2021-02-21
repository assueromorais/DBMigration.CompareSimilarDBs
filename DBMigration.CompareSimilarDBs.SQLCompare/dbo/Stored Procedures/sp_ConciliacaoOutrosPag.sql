/*André - Oc. 35232 - 08/12/2008 - Sipro*/
/*Kleber - 13/10/2009 - OC 50811*/
/*Alteração da procedure para consultar também os estornos de pagamento*/

CREATE PROCEDURE [dbo].[sp_ConciliacaoOutrosPag]
@IdBanco int,
@Valor money,
@Data varchar(8),
@IdFavorecido int = 0,
@Historico varchar(8000) = '',
@Ids varchar(8000) = '',
@DataAte varchar(8) = @Data,
@Conciliado bit = 0,
@ValorMenor bit = 0

AS
Create Table #Pagamentos (Id int)
CREATE TABLE #Ids (Id int)

IF @Ids <> ''
BEGIN
	SET @Ids = 'SELECT ' + REPLACE(@Ids, ',', ' UNION ALL SELECT ')
	EXEC('INSERT INTO #Ids ' + @Ids);
END

IF @ValorMenor = 1
BEGIN
	Insert Into #Pagamentos
	Select FormasPagamento.IdFormaPagamento From FormasPagamento
	Left Join Pagamentos On Pagamentos.IdFormaPagamento = FormasPagamento.IdFormaPagamento
	Where ISNULL(Conciliado, 0) = @Conciliado
	And IdContaBanco = (Select IdConta From Bancos Where IdBanco = @IdBanco)
	And ((@Valor = 0) Or (ValorPagto <= @Valor))
	And DataPagto BETWEEN @Data AND @DataAte
	And IdTipoPagamento <> (Select IdTipoPagamento From TiposPagamentos Where TipoPagamento = 'Cheque')
	And ((IdPessoa = @IdFavorecido) or (@IdFavorecido = 0))
	And ((Pagamentos.Historico Like '%' + @Historico + '%') or (@Historico = ''))
	AND (FormasPagamento.IdFormaPagamento NOT IN (SELECT Id FROM #Ids))
	Insert Into #Pagamentos
	Select FormasPagamento.IdFormaPagamento From FormasPagamento
	Left Join RestosPagamento On RestosPagamento.IdFormaPagamento = FormasPagamento.IdFormaPagamento
	Where ISNULL(Conciliado, 0) = @Conciliado
	And IdContaBanco = (Select IdConta From Bancos Where IdBanco = @IdBanco)
	And ((@Valor = 0) Or (ValorPagto <= @Valor))
	And DataPagto BETWEEN @Data AND @DataAte
	And IdTipoPagamento <> (Select IdTipoPagamento From TiposPagamentos Where TipoPagamento = 'Cheque')
	And ((IdPessoa = @IdFavorecido) or (@IdFavorecido = 0))
	And ((RestosPagamento.Historico Like '%' + @Historico + '%') or (@Historico = ''))
	AND (FormasPagamento.IdFormaPagamento NOT IN (SELECT Id FROM #Ids))
	Insert Into #Pagamentos
	Select FormasPagamento.IdFormaPagamento From FormasPagamento
	Left Join Receitas On Receitas.IdFormaPagamento = FormasPagamento.IdFormaPagamento
	Where ISNULL(FormasPagamento.Conciliado, 0) = @Conciliado
	And FormasPagamento.IdContaBanco = (Select IdConta From Bancos Where IdBanco = @IdBanco)
	And ((@Valor = 0) Or (ABS(ValorReceita) = @Valor))
	AND ValorReceita < 0
	And DataReceita BETWEEN @Data AND @DataAte
	And IdTipoPagamento <> (Select IdTipoPagamento From TiposPagamentos Where TipoPagamento = 'Cheque')
	And ((IdPessoa = @IdFavorecido) or (@IdFavorecido = 0))
	And ((Receitas.Historico Like '%' + @Historico + '%') or (@Historico = ''))
	AND (FormasPagamento.IdFormaPagamento NOT IN (SELECT Id FROM #Ids))
END
ELSE
BEGIN
	Insert Into #Pagamentos
	Select FormasPagamento.IdFormaPagamento From FormasPagamento
	Left Join Pagamentos On Pagamentos.IdFormaPagamento = FormasPagamento.IdFormaPagamento
	Where ISNULL(Conciliado, 0) = @Conciliado
	And IdContaBanco = (Select IdConta From Bancos Where IdBanco = @IdBanco)
	And ((@Valor = 0) Or (ValorPagto = @Valor))
	And DataPagto BETWEEN @Data AND @DataAte
	And IdTipoPagamento <> (Select IdTipoPagamento From TiposPagamentos Where TipoPagamento = 'Cheque')
	And ((IdPessoa = @IdFavorecido) or (@IdFavorecido = 0))
	And ((Pagamentos.Historico Like '%' + @Historico + '%') or (@Historico = ''))
	AND (FormasPagamento.IdFormaPagamento NOT IN (SELECT Id FROM #Ids))
	Insert Into #Pagamentos
	Select FormasPagamento.IdFormaPagamento From FormasPagamento
	Left Join RestosPagamento On RestosPagamento.IdFormaPagamento = FormasPagamento.IdFormaPagamento
	Where ISNULL(Conciliado, 0) = @Conciliado
	And IdContaBanco = (Select IdConta From Bancos Where IdBanco = @IdBanco)
	And ((@Valor = 0) Or (ValorPagto = @Valor))
	And DataPagto BETWEEN @Data AND @DataAte
	And IdTipoPagamento <> (Select IdTipoPagamento From TiposPagamentos Where TipoPagamento = 'Cheque')
	And ((IdPessoa = @IdFavorecido) or (@IdFavorecido = 0))
	And ((RestosPagamento.Historico Like '%' + @Historico + '%') or (@Historico = ''))
	AND (FormasPagamento.IdFormaPagamento NOT IN (SELECT Id FROM #Ids))
	Insert Into #Pagamentos
	Select FormasPagamento.IdFormaPagamento From FormasPagamento
	Left Join Receitas On Receitas.IdFormaPagamento = FormasPagamento.IdFormaPagamento
	Where ISNULL(FormasPagamento.Conciliado, 0) = @Conciliado
	And FormasPagamento.IdContaBanco = (Select IdConta From Bancos Where IdBanco = @IdBanco)
	And ((@Valor = 0) Or (ABS(ValorReceita) = @Valor))
	AND ValorReceita < 0
	And DataReceita BETWEEN @Data AND @DataAte
	And IdTipoPagamento <> (Select IdTipoPagamento From TiposPagamentos Where TipoPagamento = 'Cheque')
	And ((IdPessoa = @IdFavorecido) or (@IdFavorecido = 0))
	And ((Receitas.Historico Like '%' + @Historico + '%') or (@Historico = ''))
	AND (FormasPagamento.IdFormaPagamento NOT IN (SELECT Id FROM #Ids))
END
/*
Delete From #Pagamentos
Where Id In (Select IdFormaPagamento From Pagamentos Where Origem Is Not Null)
*/
Create Table #CNAB (Id int)

Insert Into #CNAB
Select Pagamentos.IdFormaPagamento From Pagamentos Inner Join DetalheArquivos On DetalheArquivos.SeuNumero = 'P'+Cast(Pagamentos.NumeroPagamento As Varchar)+'/'+Cast(Pagamentos.AnoExercicio As Varchar)

Insert Into #CNAB
Select MovimentoFinanceiro.IdFormaPagamento From MovimentoFinanceiro Inner Join DetalheArquivos On DetalheArquivos.SeuNumero = 'M'+Cast(MovimentoFinanceiro.NumeroMovimentoFinanceiro As Varchar)+'/'+Cast(MovimentoFinanceiro.AnoExercicio As Varchar)

Delete From #Pagamentos
Where Id In (Select Id From #CNAB)

Create Table #OutrosPag (Id int)

Insert Into #OutrosPag
Select Distinct #Pagamentos.Id From #Pagamentos

SELECT * FROM (
Select FormasPagamento.IdFormaPagamento, 'P'+Cast(NumeroPagamento As Varchar)+'/'+Cast(AnoExercicio As Varchar) Numero, ValorPagto ValorPgto, DataPagto From Pagamentos
Inner Join #OutrosPag On #OutrosPag.Id = Pagamentos.IdFormaPagamento
Inner Join FormasPagamento On FormasPagamento.IdFormaPagamento = #OutrosPag.Id
Union All
Select FormasPagamento.IdFormaPagamento, 'E'+Cast(NumeroReceita As Varchar)+'/'+Cast(AnoExercicio As Varchar), FormasPagamento.ValorPagto ValorPgto, DataReceita DataPagto From Receitas
Inner Join #OutrosPag On #OutrosPag.Id = Receitas.IdFormaPagamento
Inner Join FormasPagamento On FormasPagamento.IdFormaPagamento = #OutrosPag.Id
Union All
Select FormasPagamento.IdFormaPagamento, 'M'+Cast(NumeroMovimentoFinanceiro As Varchar)+'/'+Cast(AnoExercicio As Varchar), ValorPagto ValorPgto, DataPagto From MovimentoFinanceiro
Inner Join #OutrosPag On #OutrosPag.Id = MovimentoFinanceiro.IdFormaPagamento
Inner Join FormasPagamento On FormasPagamento.IdFormaPagamento = #OutrosPag.Id
Union All
Select FormasPagamento.IdFormaPagamento, 'R'+Cast(NumeroPagamento As Varchar)+'/'+Cast(AnoExercicio As Varchar), ValorPagto ValorPgto, DataPgto From RestosPagamento
Inner Join #OutrosPag On #OutrosPag.Id = RestosPagamento.IdFormaPagamento
Inner Join FormasPagamento On FormasPagamento.IdFormaPagamento = #OutrosPag.Id) A
Order By DataPagto DESC, Numero

DROP TABLE #Pagamentos
DROP TABLE #CNAB
DROP TABLE #OutrosPag
DROP TABLE #Ids
