/* OC 17219 - Rodrigo Souza */ 
CREATE PROCEDURE [dbo].[sp_BalancoOrcamentario]   
@DataInicial varchar(8),    
@DataFinal varchar(8),    
@IncluirAnaliticas bit = 0    
    
AS    
    
DECLARE @Exercicio VARCHAR(4)  -- OC 17219 - Rodrigo - Plurianual  
SELECT @Exercicio = CASE WHEN (SELECT TOP 1 1 FROM PlanoContas pc WHERE pc.Exercicio = YEAR(@DataInicial)) = 1 THEN YEAR(@DataInicial) ELSE 0 END -- OC 17219 - Rodrigo - Plurianual  

CREATE TABLE #BalancoOrc (Grupo int, Analitico bit, IdConta int, CodConta varchar(18) COLLATE database_default, CodConta2 varchar(18) COLLATE database_default, NomeConta varchar(50) COLLATE database_default, ValorPrevisto money)    
CREATE TABLE #CalculaPlano (IdConta int, Grupo int, CodConta varchar(18) COLLATE database_default, NomeConta varchar(50) COLLATE database_default, Analitico bit, SaldoInicial money, Debitos money, Creditos money, Saldo money)    
    
Insert Into #CalculaPlano (Grupo, CodConta, NomeConta, Analitico, SaldoInicial, Debitos, Creditos, Saldo)    
Exec('sp_calculaplano ''' + @DataInicial + ''', ''' + @DataFinal + ''',0,0,0,0,1,1,1,1,0,1,' + @Exercicio)  -- OC 17219 - Rodrigo - Plurianual    

Update #CalculaPlano Set #CalculaPlano.IdConta = PlanoContas.IdConta From #CalculaPlano, PlanoContas    
Where #CalculaPlano.Grupo = PlanoContas.Grupo    
And Replace(#CalculaPlano.CodConta, '.', '') = PlanoContas.CodConta    
AND ISNULL(PlanoContas.Exercicio,0) = @Exercicio  -- OC 17219 - Rodrigo - Plurianual  
    
/*RECEITAS*/    
Insert Into #BalancoOrc     
Select PlanoContas.Grupo, PlanoContas.Analitico, PlanoContas.IdConta, PlanoContas.CodConta,     
Case When Substring(PlanoContas.CodConta, Len(PlanoContas.CodConta), 1) = '0' And Substring(PlanoContas.CodConta, Len(PlanoContas.CodConta) - 1, 1) <> '0' Then PlanoContas.CodConta    
Else Replace(RTrim(Replace(PlanoContas.CodConta, '0', ' ')), ' ', '0') End CodConta2,    
PlanoContas.NomeConta,     
(Select IsNull(Sum(ValorDotacao), 0) From DotacoesConta Where DotacoesConta.IdConta = PlanoContas.IdConta And DotacoesConta.DataDotacao <= @DataFinal And Year(DotacoesConta.DataDotacao) = Year(@DataInicial))     
From PlanoContas    
Where PlanoContas.Grupo = 3    
And PlanoContas.CodConta Like '1%'    
AND ISNULL(PlanoContas.Exercicio,0) = @Exercicio  -- OC 17219 - Rodrigo - Plurianual  
/*RECEITAS DE CAPITAL*/    
Insert Into #BalancoOrc     
Select PlanoContas.Grupo, PlanoContas.Analitico, PlanoContas.IdConta, PlanoContas.CodConta,     
Case When Substring(PlanoContas.CodConta, Len(PlanoContas.CodConta), 1) = '0' And Substring(PlanoContas.CodConta, Len(PlanoContas.CodConta) - 1, 1) <> '0' Then PlanoContas.CodConta    
Else Replace(RTrim(Replace(PlanoContas.CodConta, '0', ' ')), ' ', '0') End CodConta2,    
PlanoContas.NomeConta,     
(Select IsNull(Sum(ValorDotacao), 0) From DotacoesConta Where DotacoesConta.IdConta = PlanoContas.IdConta And DotacoesConta.DataDotacao <= @DataFinal And Year(DotacoesConta.DataDotacao) = Year(@DataInicial))     
From PlanoContas    
Where PlanoContas.Grupo = 6    
AND ISNULL(PlanoContas.Exercicio,0) = @Exercicio  -- OC 17219 - Rodrigo - Plurianual  
/*DESPESAS*/    
Insert Into #BalancoOrc     
Select Grupo, Analitico, PlanoContas.IdConta, CodConta,     
Case When Substring(CodConta, Len(CodConta), 1) = '0' And Substring(CodConta, Len(CodConta) - 1, 1) <> '0' Then CodConta    
Else Replace(RTrim(Replace(CodConta, '0', ' ')), ' ', '0') End CodConta2,    
NomeConta,     
(Select IsNull(Sum(ValorDotacao), 0) From DotacoesConta Where DotacoesConta.IdConta = PlanoContas.IdConta And DotacoesConta.DataDotacao <= @DataFinal And Year(DotacoesConta.DataDotacao) = Year(@DataInicial))    
From PlanoContas    
Where Grupo = 4    
AND ISNULL(PlanoContas.Exercicio,0) = @Exercicio  -- OC 17219 - Rodrigo - Plurianual  
/*DESPESAS DE CAPITAL*/    
Insert Into #BalancoOrc     
Select Grupo, Analitico, PlanoContas.IdConta, CodConta,     
Case When Substring(CodConta, Len(CodConta), 1) = '0' And Substring(CodConta, Len(CodConta) - 1, 1) <> '0' Then CodConta    
Else Replace(RTrim(Replace(CodConta, '0', ' ')), ' ', '0') End CodConta2,    
NomeConta,     
(Select IsNull(Sum(ValorDotacao), 0) From DotacoesConta Where DotacoesConta.IdConta = PlanoContas.IdConta And DotacoesConta.DataDotacao <= @DataFinal And Year(DotacoesConta.DataDotacao) = Year(@DataInicial))    
From PlanoContas    
Where Grupo = 5    
AND ISNULL(PlanoContas.Exercicio,0) = @Exercicio  -- OC 17219 - Rodrigo - Plurianual  

Select #BalancoOrc.Grupo, #BalancoOrc.Analitico, #BalancoOrc.IdConta, #BalancoOrc.CodConta, #BalancoOrc.NomeConta,    
(  
 Select IsNull(Sum(BO2.ValorPrevisto), 0)   
 From #BalancoOrc BO2   
 Where BO2.CodConta Like #BalancoOrc.CodConta2 + '%'   
 And BO2.Grupo = Grupo And Analitico = 1) ValorPrevisto,    
Case When #BalancoOrc.Grupo in (4,5) Then (Creditos - Debitos) * -1 Else (Creditos - Debitos) End ValorExecutado    
/*(Select Sum(BO2.ValorExecutado) From #BalancoOrc BO2 Where BO2.CodConta Like #BalancoOrc.CodConta2 + '%' And BO2.Grupo = Grupo And Analitico = 1) ValorExecutado*/    
From #BalancoOrc    
Left Join #CalculaPlano On #CalculaPlano.IdConta = #BalancoOrc.IdConta    
Where (@IncluirAnaliticas = 0 And #BalancoOrc.Analitico = 0) Or @IncluirAnaliticas = 1    
Order By #BalancoOrc.Grupo, #BalancoOrc.CodConta, #BalancoOrc.NomeConta    
  
  
