CREATE PROCEDURE [dbo].[sp_ConciliacaoFolhaPag]
@IdBanco int,
@IdConta varchar(8000),
@Valor money,
@DataDe varchar(8),
@DataAte varchar(8)
AS
Create Table #Contas(Id int)

Exec('Insert Into #Contas Select IdConta From PlanoContas Where IdConta In (' + @IdConta + ')')

Create Table #Pagamentos (Id int, Numero int, Ano int, Data datetime, Valor money, Total money, Tipo int)

Insert Into #Pagamentos
Select FormasPagamento.IdFormaPagamento, NumeroMovimentoFinanceiro, AnoExercicio, DataPagto, ValorPagto,  ValorPagto, 1 From FormasPagamento
Inner Join MovimentoFinanceiro On MovimentoFinanceiro.IdFormaPagamento = FormasPagamento.IdFormaPagamento
Where (Conciliado Is Null Or Conciliado = 0)
And IdContaDestino = (Select IdConta From Bancos Where IdBanco = @IdBanco)
And IdContaOrigem In (Select Id From #Contas)
And DataPagto Between @DataDe And @DataAte
And IdTipoPagamento <> (Select IdTipoPagamento From TiposPagamentos Where TipoPagamento = 'Cheque')
And ((ValorPagto = @Valor) or (@Valor = 0))
And Origem Is Null

Insert Into #Pagamentos
Select FormasPagamento.IdFormaPagamento, NumeroMovimentoFinanceiro, AnoExercicio, DataPagto, ValorPagto, 0, 2 From FormasPagamento
Inner Join MovimentoFinanceiro On MovimentoFinanceiro.IdFormaPagamento = FormasPagamento.IdFormaPagamento
Where (Conciliado Is Null Or Conciliado = 0)
And IdContaDestino =  (Select IdConta From Bancos Where IdBanco = @IdBanco)
And IdContaOrigem In (Select Id From #Contas)
And DataPagto Between @DataDe And @DataAte
And IdTipoPagamento <> (Select IdTipoPagamento From TiposPagamentos Where TipoPagamento = 'Cheque')
And ((ValorPagto < @Valor) or (@Valor = 0))
And Origem Is Null

Create Table #CNAB (Id int)

Insert Into #CNAB
Select MovimentoFinanceiro.IdFormaPagamento From MovimentoFinanceiro Inner Join DetalheArquivos On DetalheArquivos.SeuNumero = 'M'+Cast(MovimentoFinanceiro.NumeroMovimentoFinanceiro As Varchar)+'/'+Cast(MovimentoFinanceiro.AnoExercicio As Varchar)

Delete From #Pagamentos
Where Id In (Select Id From #CNAB)

Create Table #Totais (Data datetime, Total money)

Insert Into #Totais
Select Data, Sum(Valor) From #Pagamentos
Where Tipo = 2
Group By Data

Update #Pagamentos
Set #Pagamentos.Total = TT.Total
From #Totais TT
Where #Pagamentos.Data = TT.Data
And Tipo = 2

Create Table #Datas (Data datetime, Qtd int)

Insert Into #Datas
Select Data, Count(*) From #Pagamentos Where Tipo = 2 Group By Data

Select Id, 'M'+Cast(Numero As Varchar)+'/'+Cast(Ano As Varchar) NumMovFin, Valor, Data, Total, Tipo,
IsNull((Select Count(*) From #Pagamentos Where Tipo = 1), 0) UN,
IsNull((Select Count(*) From #Datas), 0) DV
From #Pagamentos
Where ((Total = @Valor) or (@Valor = 0))
Order By NumMovFin
