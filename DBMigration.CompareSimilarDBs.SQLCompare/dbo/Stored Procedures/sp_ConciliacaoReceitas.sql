

/*Lucimara - 10/02/2009 - Sipro - Oc. 44056*/
/*André - 03/08/2007 - Sipro - Oc. 22775*/
CREATE PROCEDURE [dbo].[sp_ConciliacaoReceitas]
@IdBanco int,
@Valor money = 0,
@DataDe varchar(8),
@DataAte varchar(8) = @DataDe,
@Historico varchar(8000) = '',
@ValorInicial money = @Valor
AS
Create Table #Receitas (IdReceita int, NumeroReceita int, AnoExercicio int, DataReceita datetime, ValorReceita money, Tipo int, Total Money)

Insert Into #Receitas
Select IdReceita, NumeroReceita, AnoExercicio, DataReceita, ValorUnitario, 1, 0 From Receitas
Where (Conciliado Is Null Or Conciliado = 0)
And IdContaBanco = (Select IdConta From Bancos Where IdBanco = @IdBanco)
And ((ValorUnitario BETWEEN @ValorInicial AND @Valor) or (@Valor = 0))
And DataReceita Between @DataDe And @DataAte
And ((Historico Like '%' + @Historico + '%') OR (@Historico = ''))

--Insert Into #Receitas
--Select IdReceita, NumeroReceita, AnoExercicio, DataReceita, ValorUnitario, 2, 0 From Receitas
--Where (Conciliado Is Null Or Conciliado = 0)
--And IdContaBanco = (Select IdConta From Bancos Where IdBanco = @IdBanco)
--And ((ValorUnitario <> @Valor) or (@Valor = 0))
--And DataReceita Between @DataDe And @DataAte
--And ((Historico Like '%' + @Historico + '%') OR (@Historico = ''))

Create Table #Totais (Data datetime, Total money)

Insert Into #Totais
Select DataReceita, Sum(ValorReceita) From #Receitas
Where Tipo = 2
Group By DataReceita

Update #Receitas
Set #Receitas.Total = TT.Total
From #Totais TT
Where DataReceita = Data
And Tipo = 2

Update #Receitas
Set Total = ValorReceita
Where Tipo = 1

Select *,
(Select IsNull(Count(IdReceita), 0) From #Receitas Where Tipo = 1) UN,
(Select IsNull(Count(IdReceita), 0) From #Receitas Where Tipo = 2) DV, @DataDe, @DataAte
From #Receitas
Where ((@Valor = 0) Or (Total BETWEEN @ValorInicial AND @Valor))
Order By DataReceita, Tipo




