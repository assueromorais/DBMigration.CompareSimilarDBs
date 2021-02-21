/*
PCS
André - 07/10/2009
Oc. 50733
*/

CREATE PROCEDURE [dbo].[proc_PCS_FluxoDiario] 
@idCentroCusto varchar(10) = '0',
	@idCentroCustoReceita varchar(10) = '0',
	@DataInicial datetime,
	@DataFinal datetime,
	@mov bit = 0,
	@IdContaFinanceira int = 0,
	@idUsuario varchar(5) = 0
AS
SET NOCOUNT ON
DECLARE @inserirContasMOV varchar(8000),
        @inserirContasMOVDESTINO varchar(8000),
        @sqlAExec nvarchar ( 3500),
        @sqlAndContaFinanceira varchar(50),
        @sqlSelectFinalMOV varchar (8000),
        @sqlTableTempMOV varchar (8000),
        @sqlTableTempMOVDestino varchar (8000),
        @sqlInserirSaldoFinal varchar(1000),
        @sqlValoresIniciaisTRANSF varchar(8000),
        @sqlValoresFINAIS varchar(8000),
        @sqlValoresIniciais varchar(5000),
        @sqlValoresIniciaisReceitas varchar(5000),
        @sqlValoresIniciaisDESP varchar(5000),
        @sqlValoresIniciaisMOV varchar(5000),
        @ValorMoney money,
        @Valor varchar(25),
        @ValorNegativo varchar(25),
        @sqlTableTemp varchar(8000),
        @sqlTableTempDESP varchar(8000),
        @inserirContasReceita varchar(8000),
        @inserirContasDespesa varchar (8000),
        @sqlCamposTemp varchar(8000),
        @sVirgula varchar(1),
        @sqlSelectFinal varchar(8000),
        @sqlSelectFormatado varchar(8000),
        @sqlCamposFiltroMovimentacao varchar(8000),
        @sqlsDias varchar(8000),
        @diaInicial int,
        @qtdDias int,
        @NomeCampo varchar(30),
        @nomeCampoAlias varchar(15),
        @DataLoop datetime,
        @sqlCampoACampo varchar(1000),	/*@DataInicial Datetime,
        @DataFinal Datetime,*/
        @i int,
        @Alias_campo varchar(20),
        @dataVarchar nvarchar(10)
        
        /*set @DataInicial = '20080628'
        set @DataFinal = '20080705'*/
        
        SET @sqlValoresIniciaisTRANSF  = ''
        SET @sqlValoresFINAIS  = ''
        SET @sqlValoresIniciais  = ''
        SET @sqlValoresIniciaisReceitas  = ''
        SET @sqlValoresIniciaisDESP  = ''
        SET @sqlValoresIniciaisMOV = ''
        
        SET @diaInicial = day(@DataInicial)
        SET @sqlInserirSaldoFinal = ''
        SET @qtdDias = DateDiff(day, @DataInicial, @DataFinal) 
        SET @i = @diaInicial 
        SET @sqlCamposTemp = ''
        SET @inserirContasReceita = ''
        SET @inserirContasDespesa = ''
        SET @sqlSelectFinal = ''
        SET @sqlSelectFormatado = ''
        SET @sVirgula = ''
set @sqlTableTemp = 'CREATE TABLE #tempRelRECEITAS (identificador int  ,nomeConta varchar(200) ';
set @sqlCamposFiltroMovimentacao = ' where 1=0 or nomeConta =''__SALDO FINAL->'' or nomeConta =''__SALDO INICIAL->'' or nomeConta =''__SAÌDAS->'' or nomeConta =''__DESPESAS->'' or nomeConta =''__TRANSFERÊNCIAS->'' or nomeConta = ''__RECEITA->'''


IF @IdContaFinanceira > 0
BEGIN
    SET @sqlAndContaFinanceira = ' =  ' + cast(@IdContaFinanceira AS varchar(10)
    )
END
ELSE 
BEGIN
    SET @sqlAndContaFinanceira = ' >  ' + cast(@IdContaFinanceira AS varchar(10)
    )
END



set @DataLoop = @DataInicial
set @sqlCampoACampo = ''
WHILE (@i <= (@qtdDias + @diaInicial))
begin    
    select @dataVarchar = convert(varchar,convert(VARCHAR, @dataLoop ,120) )


	select @Alias_campo = '['+ cast(day(@DataLoop) as varchar(2)) + '/'+ cast(month(@DataLoop) as varchar(2))  + '/'+ cast(year(@DataLoop) as varchar(4)) + ']'


    set @nomeCampo = '_'+cast(day(@DataLoop) as varchar(2))+'_'+cast(month(@DataLoop) as varchar(2))+'_'+cast(year(@DataLoop) as varchar(4))
	

    set @sqlSelectFormatado = @sqlSelectFormatado +@sVirgula+ ' dbo.format_currency(dia'+@nomeCampo+') as '+@Alias_campo
	set @sqlCamposTemp = @sqlCamposTemp + ',' + 'dia'+@nomeCampo+ ' money '    

    set @sqlCampoACampo = @sqlCampoACampo + ',' + 'dia'+@nomeCampo  
    	
    set @sqlCamposFiltroMovimentacao = @sqlCamposFiltroMovimentacao + ' or ' + 'dia'+@nomeCampo+ ' <> 0'      	
	/*-----------valoresIniciasTOTAL--------------------------*/
	


    exec sp_saldoInicioPorDia  @dataVarchar ,@IdContaFinanceira,@idCentroCusto,@idCentroCustoReceita, @ValorMoney output
	SET @valor = cast(@ValorMoney    AS varchar)

	/*-------------------------------------*/

	set @sqlValoresIniciais = @sqlValoresIniciais + ',' + @Valor +  ' as '+ @Alias_campo

	/*-----------VALORES FINAIS --------------------------*/

	

	 exec sp_saldoFimPorDia  @dataVarchar ,@IdContaFinanceira,@IdCEntroCusto,@IdCentroCustoReceita, @valorMoney output
	 SET @valor = cast(@ValorMoney    AS varchar)
	/*-------------------------------------*/
	set @sqlValoresFINAIS = @sqlValoresFINAIS + ',' + @Valor

	
/*-----------valoresIniciasReceita--------------------------*/

	set @sqlAExec = ' select @Valor = isnull(sum(valor),0 ) from (
	select sum(wc.valorTotal) as valor
	from web_ContasFinanceiras wcf 
	LEFT JOIN  web_receitas wc on
	wc.IdContaFinanceira = wcf.IdContaFinanceira
	and dataReceita = ''' +  @dataVarchar + '''

	and wc.IdCentroCusto = '+@idCentroCusto+'
	and wc.IdCentroCustoReceita = '+@idCentroCustoReceita+'

	where wcf.IdContaFinanceira ' + @sqlAndContaFinanceira + '
and wc.DataReceita is not null
	group by wcf.IdContaFinanceira,saldoinicial
	)a'

	 exec sp_executesql @sqlAExec, N'@Valor money output', @valorMoney output
	 SET @valor = cast(@ValorMoney    AS varchar)

	/*-------------------------------------*/

	set @sqlValoresIniciaisRECEITAS = @sqlValoresIniciaisRECEITAS + ',' + @Valor


	/*-----------valoresIniciasDespesa--------------------------*/
	set @sqlAExec = 'select @Valor = isnull(sum(valor),0)  from (
	select sum(wc.valorEfetivo) as valor
	from web_ContasFinanceiras wcf 
	LEFT JOIN  web_Despesas wc on  
	wc.IdContaFinanceira = wcf.IdContaFinanceira
	and dataEfetiva = ''' +  @dataVarchar + '''

	and wc.IdCentroCusto = '+@idCentroCusto+'
	/*and wc.IdCentroCustoReceita = 42*/

	where wcf.IdContaFinanceira ' + @sqlAndContaFinanceira + '
	group by wcf.IdContaFinanceira,saldoinicial
	)a'
	exec sp_executesql @sqlAExec, N'@Valor money output', @valorMoney output
	SET @valor = cast(@ValorMoney    AS varchar)
	/*-------------------------------------*/

	set @sqlValoresIniciaisDESP = @sqlValoresIniciaisDESP + ',' + @Valor



	/*-----------valoresIniciasMovimentacoes--------------------------*/
	set @sqlAExec = 'select @ValorNegativo = isnull(sum(valor),0)  from (
	select sum(wc.valorPrevisto) as valor
	from web_ContasFinanceiras wcf 
	LEFT JOIN web_MovimentacoesFinanceiras wc on  
	wc.IdContaOrigem = wcf.IdContaFinanceira
	and dataTransacao = ''' +  @dataVarchar + '''

	and wc.IdCentroCusto = '+@idCentroCusto+'
	/*and wc.IdCentroCustoReceita = 42*/

	where wcf.IdContaFinanceira ' + @sqlAndContaFinanceira + '
	group by wcf.IdContaFinanceira,saldoinicial
	)a'
	 exec sp_executesql @sqlAExec, N'@valorNegativo money output', @valorMoney output
	 SET @valorNegativo = cast(@ValorMoney    AS varchar)

	set @sqlAExec = 'select @Valor = isnull(sum(valor),0)  from (
	select sum(wc.valorPrevisto) as valor
	from web_ContasFinanceiras wcf 
	LEFT JOIN web_MovimentacoesFinanceiras wc on  
	wc.IdContaDestino = wcf.IdContaFinanceira
	and dataTransacao = ''' +  @dataVarchar + '''

	and wc.IdCentroCusto = '+@idCentroCusto+'	
	/*and wc.IdCentroCustoReceita = 42*/

	where wcf.IdContaFinanceira ' + @sqlAndContaFinanceira + '
	group by wcf.IdContaFinanceira,saldoinicial
	)a'
	 exec sp_executesql @sqlAExec, N'@Valor money output', @valorMoney output
	 
	 SET @valor = cast(@ValorMoney    AS varchar)

	set @valor = cast(cast(@valor as money) - cast(@valorNegativo as money) as varchar(25))
	/*-------------------------------------*/

	set @sqlValoresIniciaisMOV = @sqlValoresIniciaisMOV + ',' + @Valor
	set @sVirgula = ','
	set @DataLoop = DATEADD(day, 1, @DataLoop)
	set @i = @i + 1 ;
end
set @sqlCamposTemp = @sqlCamposTemp + ')'
set @sqlTableTemp = @sqlTableTemp + @sqlCamposTemp 
set @sVirgula = ''
set @i = @diaInicial 
set @DataLoop = @DataInicial

set @sqlValoresIniciais =  'select ''__SALDO INICIAL->'' as nomeConta ' + @sqlValoresIniciais 
set @sqlValoresIniciaisRECEITAS =  'select ''__RECEITA->'' as nomeConta ' + @sqlValoresIniciaisRECEITAS 
set @sqlValoresIniciaisDesp =  'select ''__DESPESAS->'' as nomeConta ' + @sqlValoresIniciaisDESP
set @sqlValoresIniciaisTRANSF =  'select ''__TRANSFERÊNCIAS->'' as nomeConta ' + @sqlValoresIniciaisTRANSF 
set @sqlValoresFINAIS =  'select ''__SALDO FINAL->'' as nomeConta ' + @sqlValoresFINAIS 
set @sqlValoresIniciaisMOV =  'select ''__TRANSFERÊNCIAS->'' as nomeConta ' + @sqlValoresIniciaisMOV 

set @DataLoop = @DataInicial

WHILE (@i <= (@qtdDias + @diaInicial))
begin
	set @nomeCampo = '_'+cast(day(@DataLoop) as varchar(2))+'_'+cast(month(@DataLoop) as varchar(2))+'_'+cast(year(@DataLoop) as varchar(4))
    set @sqlSelectFinal = @sqlSelectFinal +@sVirgula+ ' dbo.format_Currency(sum(dia'+@nomeCampo+')) as dia'+@nomeCampo	
    set @sqlTableTemp = @sqlTableTemp+ ' '+

' insert into #tempRelRECEITAS(identificador,nomeConta,dia'+@nomeCampo+') '+
    'select wr.idConta,
		nomeConta,
		 sum(ValorTotal ) as ValorTotal
from PlanoContas p' +
' INNER '+
' JOIN   ContasPersonalizada cp '+
'   ON   p.IdConta = cp.IdConta INNER '+
' JOIN   Usuarios u '+
'   ON   u.NomeContaPersonalizada = cp.NomePersonalizado '+

' LEFT JOIN web_Receitas wr ON wr.IdConta = p.IdConta
and 1 = 1 '+
' and day(dataReceita) ='+ cast(day(@DataLoop) as varchar(2))+
' and month(dataReceita) ='+ cast(month(@DataLoop) as varchar(2))+
' and year(dataReceita) ='+ cast(year(@DataLoop) as varchar(4))+
' and wr.IdCentroCusto = '+ @idCentroCusto +
' and wr.IdCentroCustoReceita = '+ @idCentroCustoReceita +
' and wr.IdContaFinanceira ' + @sqlAndContaFinanceira + 

' WHERE p.Grupo IN (3,6) AND u.IdUsuario =  '+ @IdUsuario + 
' group by  wr.idConta,nomeConta,day(dataReceita)'
	
	set @DataLoop = DATEADD(day, 1, @DataLoop)
	set @i = @i + 1 ;
    set @sVirgula = ','

end

set @diaInicial = day(@DataInicial)
set @qtdDias = DateDiff(day, @DataInicial, @DataFinal) 
set @i = @diaInicial 
set @sqlCamposTemp = ''

set @sqlSelectFinal = ''
set @sVirgula = ''
set @sqlTableTempDESP = 'CREATE TABLE #tempRelDESPESAS (identificador int  ,nomeConta varchar(200) ';

set @DataLoop = @DataInicial
WHILE (@i <= (@qtdDias + @diaInicial))
begin    
    set @nomeCampo = '_'+cast(day(@DataLoop) as varchar(2))+'_'+cast(month(@DataLoop) as varchar(2))+'_'+cast(year(@DataLoop) as varchar(4))	
	set @sqlCamposTemp = @sqlCamposTemp + ',' + 'dia'+@nomeCampo+ ' money'        	
    set @sqlCamposFiltroMovimentacao = @sqlCamposFiltroMovimentacao + ' or ' + 'dia'+@nomeCampo+ ' <> 0'            
	set @DataLoop = DATEADD(day, 1, @DataLoop)
	set @i = @i + 1 ;
end
set @sqlCamposTemp = @sqlCamposTemp + ')'
set @sqlTableTempDESP = @sqlTableTempDESP + @sqlCamposTemp
set @i = @diaInicial 
set @DataLoop = @DataInicial
set @DataLoop = @DataInicial

WHILE (@i <= (@qtdDias + @diaInicial))
begin
	set @nomeCampo = '_'+cast(day(@DataLoop) as varchar(2))+'_'+cast(month(@DataLoop) as varchar(2))+'_'+cast(year(@DataLoop) as varchar(4))
    set @sqlSelectFinal = @sqlSelectFinal +@sVirgula+ ' sum(dia'+@nomeCampo+') as dia'+@nomeCampo
    set @sqlTableTempDESP = @sqlTableTempDesp+ ' '+
' insert into #tempRelDESPESAS(identificador,nomeConta,dia'+@nomeCampo+') '+
    'select wd.idConta,
		nomeConta,
		 sum(-ValorEfetivo ) as ValorTotal
from PlanoContas p '+
' INNER '+
' JOIN   ContasPersonalizada cp '+
'   ON   p.IdConta = cp.IdConta INNER '+
' JOIN   Usuarios u '+
'   ON   u.NomeContaPersonalizada = cp.NomePersonalizado '+

' LEFT JOIN web_DESPESAS wd on wd.idConta = p.idConta
and 1 = 1 '+
' and day(dataEfetiva) ='+ cast(day(@DataLoop) as varchar(2))+
' and month(dataEfetiva) ='+ cast(month(@DataLoop) as varchar(2))+
' and year(dataEfetiva) ='+ cast(year(@DataLoop) as varchar(4))+
' and wd.IdCentroCusto = '+ @idCentroCusto +
' and wd.IdContaFinanceira ' + @sqlAndContaFinanceira + 
' WHERE p.Grupo IN (4,5) AND u.IdUsuario =  '+ @IdUsuario + 
' group by  wd.idConta,nomeConta,day(dataDESPESA)'	
	set @DataLoop = DATEADD(day, 1, @DataLoop)
	set @i = @i + 1 ;
    set @sVirgula = ','
end

set @diaInicial = day(@DataInicial)
set @qtdDias = DateDiff(day, @DataInicial, @DataFinal) 
set @i = @diaInicial 
set @sqlCamposTemp = ''
set @sVirgula = ''
set @sqlTableTempMOV = ' CREATE TABLE #tempRelMOV (identificador int  ,nomeConta varchar(200) ';
set @sqlTableTempMOVDestino = ' CREATE TABLE #tempRelMOVDESTINO (identificador int  ,nomeConta varchar(200) ';
set @DataLoop = @DataInicial

WHILE (@i <= (@qtdDias + @diaInicial))
begin    
    set @nomeCampo = '_'+cast(day(@DataLoop) as varchar(2))+'_'+cast(month(@DataLoop) as varchar(2))+'_'+cast(year(@DataLoop) as varchar(4))	
	set @sqlCamposTemp = @sqlCamposTemp + ',' + 'dia'+@nomeCampo+ ' money'        
	set @DataLoop = DATEADD(day, 1, @DataLoop)
	set @i = @i + 1 ;
END

set @sqlCamposTemp = @sqlCamposTemp + ')'
set @sqlTableTempMOV = @sqlTableTempMOV + @sqlCamposTemp
set @sqlTableTempMOVDestino = @sqlTableTempMOVDestino + @sqlCamposTemp
set @i = @diaInicial 
set @DataLoop = @DataInicial
set @DataLoop = @DataInicial

WHILE (@i <= (@qtdDias + @diaInicial))
begin
	set @nomeCampo = '_'+cast(day(@DataLoop) as varchar(2))+'_'+cast(month(@DataLoop) as varchar(2))+'_'+cast(year(@DataLoop) as varchar(4))
    set @sqlSelectFinalMOV = @sqlSelectFinalMOV +@sVirgula+ ' sum(dia'+@nomeCampo+') as dia'+@nomeCampo    
    set @sqlTableTempMOV = @sqlTableTempMOV+ ' '+
    
	' insert into #tempRelMov(identificador,nomeConta,dia'+@nomeCampo+') '+
	' select wff.idContaOrigem,
		nomeContaFinanceira,
		 sum(-ValorPrevisto ) as ValorTotal
	from web_MovimentacoesFinanceiras wff,web_contasFinanceiras
	where wff.IdContaOrigem = web_contasFinanceiras.IdContaFinanceira'+
	' and day(DataTransacao) ='+ cast(day(@DataLoop) as varchar(2))+
	' and month(DataTransacao) ='+ cast(month(@DataLoop) as varchar(2))+
	' and year(DataTransacao) ='+ cast(year(@DataLoop) as varchar(4))+
	' and wff.IdCentroCusto = '+ @idCentroCusto +
	' and wff.IdCentroCustoReceita = '+ @idCentroCustoReceita +
	' and web_contasFinanceiras.IdContaFinanceira ' + @sqlAndContaFinanceira + 
	' group by  wff.idContaOrigem,nomeContaFinanceira,day(DataTransacao)'

	set @DataLoop = DATEADD(day, 1, @DataLoop)
	set @i = @i + 1 ;
    set @sVirgula = ','

END

set @DataLoop = @DataInicial
set @i = @diaInicial 
WHILE (@i <= (@qtdDias + @diaInicial))
begin
	set @nomeCampo = '_'+cast(day(@DataLoop) as varchar(2))+'_'+cast(month(@DataLoop) as varchar(2))+'_'+cast(year(@DataLoop) as varchar(4))
    set @sqlSelectFinalMOV = @sqlSelectFinalMOV +@sVirgula+ ' sum(dia'+@nomeCampo+') as dia'+@nomeCampo

    set @sqlTableTempMOVDESTINO = @sqlTableTempMOVDESTINO+ ' '+
' insert into #tempRelMovDESTINO(identificador,nomeConta,dia'+@nomeCampo+') '+
    'select wfa.idContaDestino,
		nomeContaFinanceira,
		 sum(ValorPrevisto ) as ValorTotal
from web_MovimentacoesFinanceiras wfa,web_contasFinanceiras
where wfa.idContaDestino = web_contasFinanceiras.IdContaFinanceira'+
' and day(DataTransacao) ='+ cast(day(@DataLoop) as varchar(2))+
' and month(DataTransacao) ='+ cast(month(@DataLoop) as varchar(2))+
' and year(DataTransacao) ='+ cast(year(@DataLoop) as varchar(4))+
' and wfa.IdCentroCusto = '+ @idCentroCusto +
' and wfa.IdCentroCustoReceita = '+ @idCentroCustoReceita +
' and web_contasFinanceiras.IdContaFinanceira ' + @sqlAndContaFinanceira + 
' group by  wfa.idContaDestino,nomeContaFinanceira,day(DataTransacao)'
	
	set @DataLoop = DATEADD(day, 1, @DataLoop)
	set @i = @i + 1 ;
    set @sVirgula = ','

end

if @mov = 0
  set @sqlCamposFiltroMovimentacao = ''


set @inserirContasReceita = 
' insert into #tempRelRECEITAS (identificador,nomeConta) select distinct p.idConta,nomeConta from planoContas p,web_Receitas w where p.idconta = w.idconta  '

set @inserirContasDespesa = 
' insert into #tempRelDESPESAS (identificador,nomeConta) select distinct p.idConta,nomeConta from planoContas p,web_Despesas w where p.idconta = w.idconta  ' 

exec (
' CREATE Table #Resultado (nomeConta varchar(200)'+@sqlCamposTemp+' '+

@sqlTableTemp + 
 @inserirContasReceita + 
 @sqlTableTempDesp + 
@sqlTableTempMOV + @sqlTableTempMOVDESTINO + 
@inserirContasDespesa +
 @inserirContasMOV + @inserirContasMOVDESTINO+ 
@sqlInserirSaldoFinal + 
' insert into #Resultado(nomeConta'+@sqlCampoACampo+')' + 
@sqlValoresIniciais +' UNION ALL '+ @sqlValoresIniciaisReceitas + ' UNION ALL '+
' select nomeConta,'+ @sqlSelectFinal+' from #tempRelRECEITAS
'+ @sqlCamposFiltroMovimentacao + '
group by identificador,nomeConta UNION ALL '+

@sqlValoresIniciaisDESP + '

UNION ALL
 select nomeConta,'+ @sqlSelectFinal+' from #tempRelDESPESAS
'+ @sqlCamposFiltroMovimentacao + '
group by identificador,nomeConta UNION ALL '+

@sqlValoresIniciaisMOV + '

UNION ALL
 select nomeConta,'+ @sqlSelectFinal+' from #tempRelMOV
'+ @sqlCamposFiltroMovimentacao + '
group by identificador,nomeConta
UNION ALL ' +

 ' select nomeConta,'+ @sqlSelectFinal+' from #tempRelMOVDESTINO
'+ @sqlCamposFiltroMovimentacao + '
group by identificador,nomeConta
UNION ALL ' +  @sqlValoresFINAIS +'

select NomeConta as [Nome da conta],'+@sqlSelectFormatado+' from #Resultado
'  )
