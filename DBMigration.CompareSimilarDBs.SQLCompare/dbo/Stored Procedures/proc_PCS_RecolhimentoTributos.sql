/*
PCS
André - 07/10/2009
Oc. 50733
*/

CREATE Procedure [dbo].[proc_PCS_RecolhimentoTributos] 
	@idCentroCusto varchar(10) = '0' ,@idCentroCustoReceita varchar(10) = '0' ,
	@DataPrevistaInicial datetime = null,
	@DataPrevistaFinal datetime = null,
	@valorPrevistoDe  varchar(25) = '0',
	@valorPrevistoAte varchar(25) = '0',
	@DataEfetiva datetime = null,
	@valorEfetivo money  = 0, 
	@IdTributo int = 0 ,
	@hist  varchar(200) = '',
	@somenteEfetivados bit = 0 ,
	@somenteNaoEfetivados bit = 0 ,
	@ordernarPor int = 0

AS
SET NOCOUNT ON

declare @dataVarchar varchar(20),@sqlFinal varchar(8000) , 
		@sqlWhere varchar(8000),@sqlOrderBy varchar(50)

set @sqlWhere = ''
set @sqlOrderBy = ''

create table #tempRel(ident int identity ,tributo varchar (150), 
				DataDespesa datetime,Valor money,
				DataEfetiva datetime,ValorEfetivo money ,
				Favorecido varchar(100),ContaFinanceira varchar(100),
				Historico varchar(5000))

/*if @idCentroCusto > 0 
  set @sqlWhere =  @sqlWhere + ' and  idCentroCusto = '+ @idCentroCusto
if @idCentroCustoReceita > 0 
  set @sqlWhere =  @sqlWhere + ' and  idCentroCustoReceita = '+ @idCentroCustoReceita
*/

if @DataPrevistaInicial is not null 
begin
  select @dataVarchar = convert(varchar,convert(VARCHAR, @DataPrevistaInicial ,120) )
  set @sqlWhere =  @sqlWhere + '  and  wr.DATADESPESA >= '''+ @dataVarchar+ ''''
end

if @DataPrevistaFinal is not null 
begin
  select @dataVarchar = convert(varchar,convert(VARCHAR, @DataPrevistaFinal ,120) )
  set @sqlWhere =  @sqlWhere + '  and  wr.DATADESPESA <= '''+ @dataVarchar+ ''''
end

if @valorPrevistoDe <>  '0' 
  set @sqlWhere =  @sqlWhere + '  and wr.Valor is not Null and  wr.Valor >= '+ @valorPrevistoDe
if @valorPrevistoAte <> '0' 
  set @sqlWhere =  @sqlWhere + '  and wr.Valor is not Null and  wr.Valor <= '+ @valorPrevistoAte


if @DataEfetiva is not null 
begin
  select @dataVarchar = convert(varchar,convert(VARCHAR, @DataEfetiva ,120) )
  set @sqlWhere =  @sqlWhere + '  and  wr.DataEfetiva = '''+ @dataVarchar+ ''''
end

if @valorEfetivo > 0
  set @sqlWhere =  @sqlWhere + '  and   wr.ValorEfetivo = '+ cast(@valorEfetivo as varchar(20))

if cast(@IdTributo as varchar(10)) <> 0
  set @sqlWhere =  @sqlWhere + '  and  ws.IdTributo  = '+ cast(@IdTributo as varchar(10)) 


if @hist  <> ''
  set @sqlWhere =  @sqlWhere + '  and  wr.Historico like '+ ''''+ @hist+ '%'+''''


if @somenteEfetivados  = 1
  set @sqlWhere =  @sqlWhere + '  and  (wr.DataEfetiva is not null ) '

if @somenteNaoEfetivados  = 1
  set @sqlWhere =  @sqlWhere + '  and  (wr.DataEfetiva is null )'

if @ordernarPor > 0 
begin
  if @ordernarPor = 1
    set @sqlOrderby = ' ORDER BY wr.DATADESPESA'
  if @ordernarPor = 2
    set @sqlOrderby = ' ORDER BY wr.DATAEFETIVA'
  if @ordernarPor = 3
    set @sqlOrderby = ' ORDER BY NomeTributo '
  if @ordernarPor = 4
    set @sqlOrderby = ' ORDER BY NomeContaFinanceira'
end



set @sqlWhere  = ' select NomeTributo ,wr.DATADESPESA ,ws.valor , '+
' wr.dataEfetiva, '+
' ValorEfetivo, '+
' Favorecido.nome, '+
' nomeContaFinanceira, '+
' wr.historico '+
' from web_Despesas wr '+
' left join web_detalhesDespesa ws on ws.idDespesa =  wr.IdDespesa '+
' left join tributos wt on wt.idTributo =  ws.IdTributo '+
' left join pessoas Favorecido on Favorecido.idPessoa =  wt.idPessoa '+
' left join web_contasFinanceiras wc on wc.IdContaFinanceira = wr.IdContaFinanceira '+

' where IdCentroCusto ='+@IdCentroCusto +  @sqlWhere + @sqlOrderby

print @sqlWhere 


/*insert into #tempRel*/

exec ( ' insert into #tempRel '+ @sqlWhere)

select isnull(Tributo,'') as Tributo , 
isnull(convert(varchar,convert(VARCHAR (10), DATADESPESA ,103) ),'') as [Data prevista] ,
dbo.format_currency(ValorEfetivo)as [Valor efetivo despesa],
dbo.format_currency(Valor)as [Valor do tributo],
isnull(convert(varchar,convert(VARCHAR (10), DATAEFETIVA ,103) ),'') [Data efetiva]  ,
isnull(Favorecido,'')as Favorecido ,ContaFinanceira as [Conta financeira] ,
Historico as [Histório] from #tempRel
order by ident

