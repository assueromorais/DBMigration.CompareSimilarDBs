CREATE PROCEDURE [dbo].[sp_ConciliacaoTarifasTaxas]
@IdTipoPagamento int,
@IdBanco int,
@Valor money,
@DataDe varchar(8),
@DataAte varchar(8)
AS
Create Table #Pagamentos (Id int)

Insert Into #Pagamentos
Select FormasPagamento.IdFormaPagamento From FormasPagamento
Inner Join Pagamentos On Pagamentos.IdFormaPagamento = FormasPagamento.IdFormaPagamento
Where (Conciliado Is Null Or Conciliado = 0)
And IdContaBanco = (Select IdConta From Bancos Where IdBanco = @IdBanco)
And ((@Valor = 0) Or (ValorPagto = @Valor))
And DataPagto Between @DataDe And @DataAte
And IdTipoPagamento = @IdTipoPagamento
And Origem Is Null

Create Table #CNAB (Id int)

Insert Into #CNAB
Select Pagamentos.IdFormaPagamento From Pagamentos Inner Join DetalheArquivos On DetalheArquivos.SeuNumero = 'P'+Cast(Pagamentos.NumeroPagamento As Varchar)+'/'+Cast(Pagamentos.AnoExercicio As Varchar)

Delete From #Pagamentos Where Id In (Select Id From #CNAB)

Create Table #TarifasTaxas (IdFormaPagamento int, Numero varchar(20) COLLATE database_default, Valor money, Data datetime)

Insert Into #TarifasTaxas
Select Distinct #Pagamentos.Id, 'P'+Cast(NumeroPagamento As Varchar)+'/'+Cast(AnoExercicio As Varchar), ValorPgto, DataPgto From #Pagamentos
Inner Join Pagamentos On Pagamentos.IdFormaPagamento = #Pagamentos.Id

Select * From #TarifasTaxas
Order By Data
