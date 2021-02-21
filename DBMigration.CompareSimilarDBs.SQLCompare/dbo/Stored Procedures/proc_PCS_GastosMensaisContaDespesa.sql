/*
PCS
André - 07/10/2009
Oc. 50733
*/

CREATE Procedure [dbo].[proc_PCS_GastosMensaisContaDespesa] 
   @idCentroCusto varchar(10) = '0' ,@idCentroCustoReceita varchar(10) = '0' ,@DataInicial datetime,
   @DataFinal datetime,@mov bit = 0 ,@IdContaFinanceira int = 0   ,@IdUsuario varchar(5)

AS
SET NOCOUNT ON
declare @inserirContasMOV varchar(8000),@inserirContasMOVDESTINO varchar(8000),@sqlAExec nvarchar ( 3500),@sqlAndContaFinanceira varchar(50),

@sqlTableTempMOV varchar (8000),
@sqlTableTempMOVDestino varchar (8000),
@sqlInserirSaldoFinal varchar(1000) ,

@sqlValoresIniciaisTRANSF varchar(8000),
@sqlValoresFINAIS varchar(8000),
@sqlValoresIniciais varchar(5000),
@sqlValoresIniciaisReceitas varchar(5000) ,
@sqlValoresIniciaisDESP varchar(5000) , 
@sqlValoresIniciaisMOV varchar(5000) , 

@Alias_campo varchar(20),
@Valor varchar(25),@ValorNegativo varchar(25),@sqlTableTemp varchar(8000),
@sqlTableTempDESP varchar(8000),
@inserirContasReceita varchar(8000) , 
@inserirContasDespesa varchar (8000) ,
@sqlCamposTemp varchar(8000),
@sVirgula varchar(1),
@sqlSelectFinal varchar(8000),
@sqlSelectFormatado varchar(8000),
@sqlCamposFiltroMovimentacao varchar(8000),
@sqlsDias varchar(8000),
@MesInicial int,
@qtdMes int,
@NomeCampo varchar(30),
@nomeCampoAlias varchar(15),
@DataLoop datetime,
@sqlCampoACampo varchar(1000),
/*@DataInicial Datetime,
@DataFinal Datetime,*/
@i int,
@dataVarchar nvarchar(10)

/*set @DataInicial = '20080628'
set @DataFinal = '20080705'*/

set @sqlValoresIniciaisTRANSF  = ''
set @sqlValoresFINAIS  = ''
set @sqlValoresIniciais  = ''
set @sqlValoresIniciaisReceitas  = ''
set @sqlValoresIniciaisDESP  = ''
set @sqlValoresIniciaisMOV = ''

set @MesInicial = month(@DataInicial)
set @sqlInserirSaldoFinal = ''
set @qtdMes = DateDiff(month, @DataInicial, @DataFinal) 
set @i = @MesInicial 
set @sqlCamposTemp = ''
set @inserirContasReceita = ''
set @inserirContasDespesa = ''
set @sqlSelectFinal = ''
set @sqlSelectFormatado = ''
set @sVirgula = ''
set @sqlCamposFiltroMovimentacao = ' where 1=0 or nomeConta =''__TOTAL DE GASTOS AGREGADOS POR CONTA->'''


if @IdContaFinanceira > 0
begin
  set @sqlAndContaFinanceira = ' =  ' + cast(@IdContaFinanceira as varchar(10))
end
else 
begin
  set @sqlAndContaFinanceira = ' >  ' + cast(@IdContaFinanceira as varchar(10))
end



set @DataLoop = @DataInicial
set @sqlCampoACampo = ''
WHILE (@i <= (@qtdMes + @mesInicial))
begin    
    select @dataVarchar = convert(varchar,convert(VARCHAR, @dataLoop ,120) )

	select @Alias_campo = '[' +Case cast(month(@DataLoop) as int) 
    when 1 then 'Janeiro' 
	when 2 then 'Fevereiro'
	when 3 then 'Março'
	when 4 then 'Abril'
	when 5 then  'Maio'
			when 6 then 'Junho'
			when 7 then 'Julho'
			when 8 then 'Agosto'
			when 9 then 'Setembro'
			when 10 then 'Outubro'
			when 11 then 'Novembro'
			when 12 then  'Dezembro'
	end + '/'+ cast(year(@DataLoop) as varchar(4)) + ']'

    set @nomeCampo = '_'+cast(month(@DataLoop) as varchar(2))+'_'+cast(year(@DataLoop) as varchar(4))	

	set @sqlSelectFormatado = @sqlSelectFormatado +@sVirgula+ ' dbo.format_currency(mes'+@nomeCampo+') as '+@Alias_campo

	set @sqlCamposTemp = @sqlCamposTemp + ',' + 'mes'+@nomeCampo+ ' money'    

    set @sqlCampoACampo = @sqlCampoACampo + ',' + 'MES'+@nomeCampo  
    	
    set @sqlCamposFiltroMovimentacao = @sqlCamposFiltroMovimentacao + ' or ' + 'mes'+@nomeCampo+ ' <> 0'      	
	
	/*-----------VALORES FINAIS --------------------------*/

	set @sqlAExec = 'select @Valor = sum(valor)  from (
	select 
	 sum(isNull(wp.ValorEfetivo,0))
	 as valor	
	from web_ContasFinanceiras wcf 

	LEFT JOIN  WEB_Despesas wp ON 
	wp.IdContaFinanceira = wcf.IdContaFinanceira
	and month(dataEfetiva) = month(''' +  @dataVarchar + ''')
	and year(dataEfetiva) = year(''' +  @dataVarchar + ''')	
	and wp.IdCentroCusto = '+ @idCentroCusto +'		

	where wcf.IdContaFinanceira ' + @sqlAndContaFinanceira + '
	group by wcf.IdContaFinanceira,saldoInicial
	) a'

	 exec sp_executesql @sqlAExec, N'@Valor money output', @valor output
	/*-------------------------------------*/
	if @Valor is null
	  set @Valor = '0'
	set @sqlValoresFINAIS = @sqlValoresFINAIS + ',' + @Valor

    set @sVirgula = ','
	set @DataLoop = DATEADD(month, 1, @DataLoop)
	set @i = @i + 1 ;
end

set @sqlCamposTemp = @sqlCamposTemp + ')'
set @sVirgula = ''
set @i = @mesInicial 
set @DataLoop = @DataInicial


set @sqlValoresFINAIS =  'select ''__TOTAL DE GASTOS AGREGADOS POR CONTA->'' as nomeConta ' + @sqlValoresFINAIS 


/*-----------------DESPESAS*/

set @mesInicial = month(@DataInicial)
set @qtdMes = DateDiff(month, @DataInicial, @DataFinal) 
set @i = @mesInicial 
set @sqlCamposTemp = ''

set @sqlSelectFinal = ''
set @sVirgula = ''
set @sqlTableTempDESP = 'CREATE TABLE #tempRelDESPESAS (identificador int  ,nomeConta varchar(200) ';


set @DataLoop = @DataInicial
WHILE (@i <= (@qtdMes + @mesInicial))
begin    
    set @nomeCampo = '_'+cast(month(@DataLoop) as varchar(2))+'_'+cast(year(@DataLoop) as varchar(4))
	
	set @sqlCamposTemp = @sqlCamposTemp + ',' + 'mes'+@nomeCampo+ ' money'    
    
	set @DataLoop = DATEADD(month, 1, @DataLoop)
	set @i = @i + 1 ;
end
set @sqlCamposTemp = @sqlCamposTemp + ')'
set @sqlTableTempDESP = @sqlTableTempDESP + @sqlCamposTemp


set @i = @mesInicial 
set @DataLoop = @DataInicial


print 's'


WHILE (@i <= (@qtdMes + @mesInicial))
begin
	set @nomeCampo = '_'+cast(month(@DataLoop) as varchar(2))+'_'+cast(year(@DataLoop) as varchar(4))
    set @sqlSelectFinal = @sqlSelectFinal +@sVirgula+ ' sum(mes'+@nomeCampo+') as mes'+@nomeCampo

    set @sqlTableTempDESP = @sqlTableTempDesp+ ' '+
' insert into #tempRelDESPESAS(identificador,nomeConta,mes'+@nomeCampo+') '+
    'select web_DESPESAS.idConta,
		nomeConta,
		 sum(-ValorEfetivo ) as ValorTotal
from PlanoContas p
 INNER '+
' JOIN   ContasPersonalizada cp '+
'   ON   p.IdConta = cp.IdConta INNER '+
' JOIN   Usuarios u '+
'   ON   u.NomeContaPersonalizada = cp.NomePersonalizado 

LEFT JOIN web_DESPESAS on web_DESPESAS.idConta = p.idConta
and 1 = 1 '+
' and month(dataEfetiva) ='+ cast(month(@DataLoop) as varchar(2))+
' and year(dataEfetiva) ='+ cast(year(@DataLoop) as varchar(4))+
' and web_DESPESAS.IdCentroCusto = '+ @idCentroCusto +
' and web_DESPESAS.IdContaFinanceira ' + @sqlAndContaFinanceira + 
' WHERE p.Grupo IN (4,5) AND u.IdUsuario =  '+ @IdUsuario + 
' group by  web_DESPESAS.idConta,nomeConta,month(dataDESPESA)'
	
	set @DataLoop = DATEADD(month, 1, @DataLoop)
	set @i = @i + 1 ;
    set @sVirgula = ','

end
if  @mov = 0 
	set @sqlCamposFiltroMovimentacao = ''
print 'l'
print '-'
print @sqlTableTempDesp
print '-'
print @sqlCamposTemp
print '-'
print @sqlCampoACampo
print '-'
print @sqlSelectFinal
print '-'
print @sqlCamposFiltroMovimentacao
print 'valores finais'
print @sqlValoresFINAIS
print '-'
print @sqlSelectFormatado
print '-'
exec( 
' CREATE Table #Resultado (nomeConta varchar(200)'+@sqlCamposTemp+' '+
@sqlTableTempDesp + 
' insert into #Resultado(nomeConta'+@sqlCampoACampo+')' +  
' select nomeConta,'+ @sqlSelectFinal+' from #tempRelDESPESAS
'+ @sqlCamposFiltroMovimentacao + '
group by identificador,nomeConta UNION ALL '+
  @sqlValoresFINAIS +' 

select NomeConta as [Nome da conta],'+@sqlSelectFormatado+' from #Resultado
'  )
