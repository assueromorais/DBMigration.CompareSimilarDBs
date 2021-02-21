/*
PCS
André - 07/10/2009
Oc. 50733
*/

CREATE PROCEDURE [dbo].[proc_PCS_PagamentosPrevistosRealizados] 
	@exibirRetencoesDeTributos bit  ,
	@idCentroCusto varchar(10) = '0' ,
	@idCentroCustoReceita varchar(10) = '0' ,   
	@DataPrevistaInicial datetime = null,
	@DataPrevistaFinal datetime = null,
	@valorPrevistoDe  varchar(25) = '0',
	@valorPrevistoAte varchar(25) = '0',
	@DataEfetiva datetime = null,
	@valorEfetivo varchar(25) = '0', 
	@fornecedor varchar(100) = '',
	@ContaDespesa varchar(1000) = '' ,
	@IdTipoDocumentoPagamento varchar(10) = '0' ,
	@hist  varchar(200) = '',
	@somentePagos bit = 0 ,
	@somenteRetencaoTributos bit = 0 ,
	@NaoPagos bit = 0 ,
	@ordernarPor int = 0,/**/
	@IdContaFinanceira int = 0    , 
	@IdUsuarioLogado varchar(5) = 0

AS
SET NOCOUNT ON
declare @dataVarchar varchar(20),
		@sqlFinal varchar(8000) , 
		@sqlWhere varchar(8000),
		@sqlOrderBy varchar(50),
		@fornecedorCursor varchar (500), 
		@DataPrevistaCursor varchar (500),
		@valorPrevistoCursor varchar (500),
		@dataEfetivaCursor varchar (500),
		@ValorEfetivoCursor varchar (500),
		@ContaDespesaCursor varchar (500) ,
		@ContaFinanceiraCursor varchar (500),
		@TipoDocumentoCursor varchar (500) ,
		@NumeroDocumentoCursor varchar (500),
		@HistoricoCursor varchar (500),@IdDespesa int


set @sqlWhere = ''
set @sqlOrderBy = ''



create table #tempRel(
ident int identity ,
IdDespesa int ,
Fornecedor varchar(150),
DataPrevista datetime,
ValorPrevisto money,
DataEfetiva datetime,
ValorEfetivo money ,
ContaDespesa varchar(100),
ContaFinanceira varchar(100),
TipoDoc varchar(100),
NumeroDoc varchar(100), 
Historico varchar(5000))

if @idCentroCusto > 0 
  set @sqlWhere =  @sqlWhere + ' and  idCentroCusto = '+ @idCentroCusto

if @DataPrevistaInicial is not null 
begin
	select @dataVarchar = convert(varchar,convert(VARCHAR, @DataPrevistaInicial ,120) )
	  set @sqlWhere =  + '  and  DataDespesa >= '''+ @dataVarchar+''''
end

if @DataPrevistaFinal is not null 
begin
	select @dataVarchar = convert(varchar,convert(VARCHAR, @DataPrevistaFinal ,120) )
	  set @sqlWhere = @sqlWhere + '  and  DataDespesa <= '''+ @dataVarchar+''''
end

if @valorPrevistoDe <>  '0' 
  set @sqlWhere =  @sqlWhere + '  and  Valor is not null and  Valor >= '+ @valorPrevistoDe
if @valorPrevistoAte <> '0' 
  set @sqlWhere =  @sqlWhere + '  and  Valor is not null and  Valor <= '+ @valorPrevistoAte

if @DataEfetiva is not null 
begin
	select @dataVarchar = convert(varchar,convert(VARCHAR, @DataEfetiva ,120) )

	set @sqlWhere =  @sqlWhere + '  and  DataEfetiva = '''+ @dataVarchar+ ''''
end

if @fornecedor <> ''
  set @sqlWhere =  @sqlWhere + '  and  forn.nome like '+ ''''+ @Fornecedor+ '%'+''''
if @valorEfetivo <> '0'
  set @sqlWhere =  @sqlWhere + '  and   ValorEfetivo is not null and   ValorEfetivo = '+ @valorEfetivo 

if @ContaDespesa <> ''
  set @sqlWhere =  @sqlWhere + '  and  pc.IdConta IN( '+ @ContaDespesa + ')'

if @IdTipoDocumentoPagamento <> '0'
  set @sqlWhere =  @sqlWhere + '  and  td.IdTipoDocumentoPagamento = '+@IdTipoDocumentoPagamento

if @hist  <> ''
  set @sqlWhere =  @sqlWhere + '  and  historico like '+ ''''+ @hist+ '%'+''''

if @somentePagos  = 1
  set @sqlWhere =  @sqlWhere + '  and  (DataEfetiva is not null and ValorEfetivo > 0) '

if @somenteRetencaoTributos  = 1
  set @sqlWhere =  @sqlWhere + '  and  wp.IdDespesa IN(select idDespesa from WEB_DetalhesDespesa) '

if @NaoPagos  = 1 or @NaoPagos  = '1'
  set @sqlWhere =  @sqlWhere + '  and  (DataEfetiva is null and valorEfetivo is null)'

if @IdContaFinanceira > 0 
  set @sqlWhere = @sqlWhere + '  and  (wc.idContaFinanceira ='+cast ( @IdContaFinanceira as varchar(15))+')'

if @ordernarPor > 0 
begin
  if @ordernarPor = 1
    set @sqlOrderby = ' ORDER BY DATADESPESA'
  if @ordernarPor = 2
    set @sqlOrderby = ' ORDER BY DATAEFETIVA'
  if @ordernarPor = 3
    set @sqlOrderby = ' ORDER BY forn.nome'
  if @ordernarPor = 4
    set @sqlOrderby = ' ORDER BY NomeContaFinanceira'
  if @ordernarPor = 5
    set @sqlOrderby = ' ORDER BY pc.NomeConta'
end



set @sqlWhere  = 'select wp.IdDespesa , 
	forn.nome as Fornecedor,
	DataDespesa [Data prevista],
	Valor [Valor previsto],
	DataEfetiva [Data efetiva],
	ValorEfetivo as  [Valor efetivo],
	pc.NomeConta as [Conta despesa],
	NomeContaFinanceira as [Conta Financeira],
	TipoDocumentoPagamento as [Tipo doc.],
	Documento as [Número documento],
	Historico as  [Histórico]
		from web_despesas wp
		left join pessoas forn on forn.idPessoa =  wp.idPessoa
		left join tiposDocumentosPagamentos td on td.IdTipoDocumentoPagamento = wp.IdTipoDocumentoPagamento
		left join web_contasFinanceiras wc on wc.IdContaFinanceira = wp.IdContaFinanceira
		left join planoContas pc on pc.IdConta = wp.IdConta ' +

		' where 1=1 ' + @sqlWhere + @sqlOrderby

exec ( ' insert into #tempRel '+ @sqlWhere)

if @exibirRetencoesDeTributos = 1
begin
	create table #tempRelTributos(ident int identity , idDespesa int ,
	Fornecedor varchar(150),
	DataPrevista datetime,
	ValorPrevisto money,
	DataEfetiva datetime,
	ValorEfetivo money ,
	ContaDespesa varchar(100),
	ContaFinanceira varchar(100),
	TipoDoc varchar(100),  
	NumeroDoc varchar(100),  
	Historico varchar(5000))
	
DECLARE Procedimentos_Cursor
	CURSOR FAST_FORWARD FOR
	select  IdDespesa,Fornecedor ,DataPrevista ,ValorPrevisto ,
			DataEfetiva ,ValorEfetivo ,ContaDespesa ,ContaFinanceira ,
			TipoDoc ,NumeroDoc, Historico from  #tempRel 
	
		OPEN Procedimentos_Cursor	
		FETCH NEXT FROM Procedimentos_Cursor
		INTO @IdDespesa,@fornecedorCursor, @DataPrevistaCursor, @valorPrevistoCursor,
			@dataEfetivaCursor,@ValorEfetivoCursor,@ContaDespesaCursor,@ContaFinanceiraCursor,
			@TipoDocumentoCursor, @NumeroDocumentoCursor, @HistoricoCursor
		WHILE @@FETCH_STATUS = 0  
		BEGIN
			insert into #tempRelTributos 
			select @IdDespesa,@fornecedorCursor, @DataPrevistaCursor,
					@valorPrevistoCursor,
			 @dataEfetivaCursor,@ValorEfetivoCursor,@ContaDespesaCursor,@ContaFinanceiraCursor,
			@TipoDocumentoCursor,@NumeroDocumentoCursor,@HistoricoCursor

			
			/*insert into #tempRelTributos (fornecedor,DataPrevista)
				select '--------',''*/
			insert into #tempRelTributos (fornecedor,ValorPrevisto)
				select NomeTributo,Valor from WEB_DetalhesDespesa wr
					inner join tributos wt on wt.idTributo = wr.IdTributo
					and wr.idDespesa = @IdDespesa

			FETCH NEXT FROM Procedimentos_Cursor
			INTO @IdDespesa,@fornecedorCursor, @DataPrevistaCursor, @valorPrevistoCursor,
			@dataEfetivaCursor,@ValorEfetivoCursor,@ContaDespesaCursor,@ContaFinanceiraCursor,
			@TipoDocumentoCursor,@NumeroDocumentoCursor, @HistoricoCursor
		END
		CLOSE Procedimentos_Cursor
		DEALLOCATE Procedimentos_Cursor
	/*select Fornecedor,DataPrevista,ValorPrevisto,DataEfetiva,ValorEfetivo,ContaDespesa,ContaFinanceira,TipoDoc,Historico from #tempRelTributos
	order by ident*/

	/*Inserindo totalizadores de valores*/
	insert into #tempRelTributos	
	SELECT  null,'TOTAL:', null,
			sum(valorPrevisto),
			null,Sum(valorEfetivo),null,null,
			null,null,null from #tempRelTributos
			where contaDespesa is not null


	select  isNull(Fornecedor,'-')as Fornecedor,
		isnull(convert(varchar(10), DataPrevista ,103),'')  as [Data prevista]  ,
		dbo.format_currency(ValorPrevisto) as [Valor previsto],
		isnull(convert(varchar(10), DataEfetiva ,103),'')  as [Data efetiva]  ,
		dbo.format_currency(ValorEfetivo ) as [Valor efetivo],
		/*isNull(cast(ValorEfetivo as varchar(20)),'') as [Valor efetivo],*/
		isNull(ContaDespesa,'-') as [Conta despesa],
		isNull(ContaFinanceira,'-') as [Conta financeira],
		isNull(TipoDoc,'') as [Tipo documento],
		isNull(NumeroDoc,'') as [Número documento],
		isNull(Historico,'')  as [Histórico] from #tempRelTributos
	order by ident
end
else
begin


    /*Inserindo totalizadores de valores*/
	insert into #tempRel	
	SELECT  null,
			null,
		    null ,
		    SUM(ValorPrevisto) ,
			null ,
			SUM(ValorEfetivo ) ,
			
			null,
			null,
			null,
			null,
			null from #tempRel

	SELECT  /*Ident,*/isNull(Fornecedor,'')as Fornecedor,
		    isnull(convert(varchar(10), DataPrevista ,103),'')  as [Data prevista]  ,
		    dbo.format_currency(ValorPrevisto) as [Valor previsto],
			isnull(convert(VARCHAR(10), DataEfetiva ,103),'')  as [Data efetiva]  ,
			dbo.format_currency(ValorEfetivo ) as [Valor efetivo],
			/*isNull(cast(ValorEfetivo as varchar(20)),'') as [Valor efetivo],*/
			isNull(ContaDespesa,'') as [Conta despesa],
			isNull(ContaFinanceira,'') as [Conta financeira],
			isNull(TipoDoc,'') as [Tipo documento],
			isNull(NumeroDoc,'') as [Número documento],
			isNull(Historico,'')  as [Histórico] from #tempRel
	

	order by ident
	

	

end
drop table #tempRel



