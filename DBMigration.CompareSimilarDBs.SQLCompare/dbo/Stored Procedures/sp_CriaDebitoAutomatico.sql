/* OC 145717 - Claudio */

          
CREATE PROCEDURE [dbo].[sp_CriaDebitoAutomatico] (      
 @Id_Pessoa int,    
 @TipoPessoa char(2),    
 @AmbienteExecucao char(1),    
 @Situacao int,    
 @Categoria int,    
 @TipoInscricao int,    
 @Clase char(1),    
 @RetornaConsulta bit,    
 @DetalheSituacao INT = 0,  
 @ValorCapital FLOAT = 0,  
 @IdProcedimentoOperacional INT = 0    
)    
AS    
/*  
DECLARE     
 @Id_Pessoa int,    
 @TipoPessoa char(2),    
 @AmbienteExecucao char(2),    
 @Situacao int,    
 @Categoria int,    
 @TipoInscricao int,    
 @Clase char(1),    
 @RetornaConsulta bit,    
 @DetalheSituacao INT,  
 @ValorCapital FLOAT  
SELECT     
 @Id_Pessoa = 4776,    
 @TipoPessoa = 'PF',    
 @AmbienteExecucao = 'D',    
 @Situacao = 2,    
 @Categoria = 5,    
 @TipoInscricao = 1,    
 @Clase = NULL,    
 @RetornaConsulta = 0,    
 @DetalheSituacao = 1,  
 @ValorCapital = 500015    
*/  
SET NOCOUNT ON    
  
 BEGIN TRAN /* Inicia uma transação */    
     
 DECLARE @Teste bit    
    
 SET @Teste = 0 /* Indica se a SP será executada como teste, se 1 sim se 0 não */    
     
 /* Nesta tabela teremos a configuração que melhor se encaixa com os parametros enviados */    
 CREATE TABLE #tmpProcedimento (Id int IDENTITY(1,1), idProcedimento int, NomeProcedimento varchar(100), Automatico bit,     
  DataBaseCalc char(1), IdSisutacaoPFPJ int, IdTipoInscricao int, IdVigencia int, IdDadosPFPJ int , IdCategoriaPFPJ int)    
 CREATE TABLE #tmpVigencias(idVigencia int, idFaixaCapital int, DataInicialVigencia datetime,     
  DataFinalVigencia datetime, Valor decimal(10,2), AplicarDuodecimo bit, IdTipoDebito int,    
  IdDadosPFPJ int, PrazoVencimento int, NumParcelas int, TipoParcelamento char(2), idConfigGeracaoDebito INT) /*Oc125939- Bug437*/   
 CREATE TABLE #tmpDebitos (Id INT IDENTITY,IdProfissional int, IdTipoDebito int, IdSituacaoAtual int, IdMoeda int,    
  DataGeracao datetime, DataVencimento datetime, DataReferencia datetime, ValorDevido decimal(10,2),    
  NumeroParcela int, Emitido bit, IdPessoa int, IdProcedimentoOperacional int, NumConjTpDebito int, idConfigGeracaoDebito INT,DL BIT ) /*Oc125939- Bug437*/   
       
 /*Declaração de variáveis*/    
 DECLARE    
  @SQL varchar(8000), /* Conterá as SQL para execução de testes */    
  @TotalSel int,      /* Recebe o total de registros retornado da primeira consulta */    
  @IdProcedimento int, /* Recebe o código do procedimento encontrado para execução */    
  @DataBase DATETIME   /* Recebe a data base para criação dos débitos*/    
      
 /* Primeiro verificamos se já tem alguma configuração igual aos parametros passados */    
 SET @SQL = 'INSERT INTO #tmpProcedimento SELECT DISTINCT po.IdProcedimentoOperacional, po.ProcedimentoOperacional, '+    
   ' po.E_Automatico, v.DataBaseCalc, dp.IdSituacaoPFPJ, dp.IdTipoInscricao, v.IdVigencia, dp.IdDadosPFPJ, '    
       
     
 IF (@TipoPessoa = 'PF')    
  SET @SQL = @SQL + ' dp.IdCategoriaProf'    
 ELSE    
  SET @SQL = @SQL + ' dp.IdCategoriaPJ'    
      
 SET @SQL = @SQL + ' FROM ProcedimentosOperacionais po LEFT JOIN DadosPFPJ dp ON '+    
   ' dp.IdProcedimentoOperacional = po.IdProcedimentoOperacional '    
       
 /* Adiciona faixa de capital caso seja pessoa juridica */    
 IF (@TipoPessoa = 'PJ')    
  SET @SQL = @SQL + 'LEFT JOIN FaixasCapital fc ON   FC.IdDadosPFPJ = dp.IdDadosPFPJ '+    
   'LEFT JOIN Vigencias v ON   v.IdDadosPFPJ = dp.IdDadosPFPJ AND   v.IdFaixaCapital = fc.IdFaixaCapital'    
 ELSE    
  SET @SQL = @SQL + ' LEFT JOIN Vigencias v ON v.IdDadosPFPJ = dp.IdDadosPFPJ '    
      
 /*Monta where.*/    
 SET @SQL = @SQL + ' WHERE isnull(dp.IdSituacaoPFPJ,0)  = ' + cast(@Situacao AS varchar) +    
   ' AND isnull(dp.IdTipoInscricao,0) = ' + cast(@TipoInscricao AS varchar)    
      
 /* Nem todos os clientes possuem o controle de classe então temos que tratar */    
 IF (@Clase IS NOT NULL)    
   SET @SQL = @SQL + ' AND dp.Classe = ''' + cast(@Clase AS varchar) + ''''    
       
     
 /*Se o ambiente de execução for W = "Web", então devemos trazer somente configurações montadas para Web e     
   para Ambos, caso seja D = "Descktop" então o sistema deverá consultar somente configurações que foram    
   montadas para Ambos e Descktop*/    
 IF (@AmbienteExecucao = 'W')    
  SET @SQL = @SQL + ' AND AmbienteExecucao IN ( ''W'' , ''A'' )'    
 ELSE    
  SET @SQL = @SQL + ' AND AmbienteExecucao IN ( ''D'' , ''A'' )'    
         
 /* Se o tipo de pesso for PF então a categoria será pesquisada no campo "IdCategoriaProf" caso contrário    
    devemos pesquisar no campo "IdCategoriaPJ" */     
 IF (@TipoPessoa = 'PF')    
  SET @SQL = @SQL + ' AND isnull(dp.IdCategoriaProf,0) = ' + cast(@Categoria AS varchar) +    
                    ' AND po.TipoPessoa = 0'    
 ELSE    
  SET @SQL = @SQL + ' AND isnull(dp.IdCategoriaPJ,0) = ' + cast(@Categoria AS varchar) +    
                    ' AND po.TipoPessoa = 1'    
                        
 /* Este case vefica de onde deve vir o valor da database, para calculo, se o valor do campo "DataBaseCalc",    
    da tabela "Vigencias", for B significa que devemos utilizar a data atual, ou seja, "GetDate()", agora    
    se for I o sistema deverá utilizar a data presente do campo "DataCompromisso", da tabela Profissionais.    
    E se este não estiver preenchido então vamos utilizar a data do campo "DataInscricaoConselho".    
    Este tratamento somende deverá ocorrer para pessoas físicas*/    
 IF (@TipoPessoa = 'PF')    
  SET @SQL = @SQL + ' AND  (CASE WHEN v.DataBaseCalc = ''B'' THEN GETDATE() '+    
   ' WHEN v.DataBaseCalc = ''I'' THEN (SELECT TOP 1 CASE WHEN p.DataCompromisso '+    
   ' IS NULL THEN p.DataInscricaoConselho ELSE p.DataCompromisso '+    
   ' END AS DataBaseCalcProf FROM Profissionais p ' +    
   ' WHERE p.IdProfissional = ' + cast(@Id_Pessoa AS varchar) + ') END) '+    
   ' BETWEEN v.DataInicialVigencia AND convert(varchar(10), isnull(v.DataFinalVigencia, DATEADD(MONTH,12,getdate())), 112) + '' 23:59:59'' '     
       
 /* Se for uma Pessoa Juridica, devemos verificar se o capital social deste está dentro da faixa configurada    
    no procedimento. */    
 IF (@TipoPessoa = 'PJ')    
 BEGIN  
  IF @ValorCapital = 0  
  SET @SQL = @SQL + ' AND (SELECT ISNULL( (SELECT TOP 1 cs.CapitalSocial FROM   CapitaisSocial cs WHERE '+ /*DM103046*/   
  'cs.IdPessoaJuridica = '+ cast(@Id_Pessoa AS varchar) +' ORDER BY cs.Data DESC) ,0)) '+  /*DM103046*/  
  'BETWEEN isnull(fc.ValorInicialFaixa,0) AND isnull(fc.ValorFinalFaixa,0)'  
 ELSE  
  SET @SQL = @SQL + ' AND ' + CAST(@ValorCapital AS VARCHAR) + ' BETWEEN isnull(fc.ValorInicialFaixa,0) AND isnull(fc.ValorFinalFaixa,0)'  
 END     
 EXEC(@SQL)    
 /* Verificamos se foi encontrado alguma configuração */    
 SET @TotalSel = (SELECT count(isnull(idProcedimento,0)) FROM #tmpProcedimento)    
  
 /* Se a consulta acima não retornar nenhum valor então vamos buscar o item mais próximo da configuracao     
    informada. */    
    
 IF (@TotalSel = 0)    
 BEGIN    
  /*Calculamos os pesos conforme regra abaixo    
    Se Texto <> Texto = -1 (Ligação Muito Fraca)    
    Se Nulo  E  Nulo  = 0  (Ligação Fraca)    
    Se Nulo  E  Texto = 1  (Ligação Média)    
    Se Texto =  Texto = 2  (Ligação Forte)    
    Calculamos o peso de cada campo e somamos o total de pesos    
  */    
      
  SET @SQL = 'SELECT IdProcedimentoOperacional, ProcedimentoOperacional, E_Automatico, DataBaseCalc, '+    
       'IdSituacaoPFPJ, IdTipoInscricao, IdVigencia, IdDadosPFPJ, CategoriaPFPJ  FROM ( '+    
       'SELECT po.IdProcedimentoOperacional, po.ProcedimentoOperacional, po.AmbienteExecucao, '+    
       '   dp.IdSituacaoPFPJ, dp.IdTipoInscricao, '    
           
  IF (@TipoPessoa = 'PF')    
   SET @SQL = @SQL + ' dp.IdCategoriaProf AS CategoriaPFPJ, '    
  ELSE    
   SET @SQL = @SQL + ' dp.IdCategoriaPJ as CategoriaPFPJ, '    
       
  SET @SQL = @SQL + '  po.E_Automatico, v.DataBaseCalc, v.DataInicialVigencia, v.DataFinalVigencia, v.IdVigencia, dp.IdDadosPFPJ, '+    
             '  CASE '+    
             '    WHEN (dp.IdSituacaoPFPJ = '+ cast(@Situacao AS varchar) + ') THEN 2'+    
             ' WHEN (isnull(dp.IdSituacaoPFPJ,0) = 0 AND (' + cast(@Situacao AS varchar) + ' > 0)OR'+    
             '    isnull(dp.IdSituacaoPFPJ,0) > 0 AND (' + cast(@Situacao AS varchar) + ' = 0)) THEN 1'+    
             ' WHEN (isnull(dp.IdSituacaoPFPJ,0) = ' + cast(@Situacao AS varchar) + ') THEN 0'+    
             ' WHEN (dp.IdSituacaoPFPJ <> ' + cast(@Situacao AS varchar) + ') THEN -1'+    
             '  END  AS PesoSituacao,'+    
             '  CASE '    
                 
   IF (@TipoPessoa = 'PF')    
   SET @SQL = @SQL +      
             '    WHEN (dp.IdCategoriaProf = ' + cast(@Categoria AS varchar) + ') THEN 2'+    
             '    WHEN (isnull(dp.IdCategoriaProf,0) = 0 AND (' + cast(@Categoria AS varchar) + ' > 0) OR'+    
             '    isnull(dp.IdCategoriaProf,0) > 0 AND (' + cast(@Categoria AS varchar) + ' = 0)) THEN 1'+               ' WHEN (isnull(dp.IdCategoriaProf,0) = ' + cast(@Categoria AS varchar) + ') THEN 0'+    
             ' WHEN (dp.IdCategoriaProf <> ' + cast(@Categoria AS varchar) + ') THEN -1'+    
             '  END  AS PesoCategoria,'    
   ELSE    
    SET @SQL = @SQL +      
             '    WHEN (dp.IdCategoriaPJ = ' + cast(@Categoria AS varchar) + ') THEN 2'+    
             '    WHEN (isnull(dp.IdCategoriaPJ,0) = 0 AND (' + cast(@Categoria AS varchar) + ' > 0) OR'+    
             '    isnull(dp.IdCategoriaPJ,0) > 0 AND (' + cast(@Categoria AS varchar) + ' = 0)) THEN 1'+    
             ' WHEN (isnull(dp.IdCategoriaPJ,0) = ' + cast(@Categoria AS varchar) + ') THEN 0'+    
             ' WHEN (dp.IdCategoriaPJ <> ' + cast(@Categoria AS varchar) + ') THEN -1'+    
             '  END  AS PesoCategoria,'    
       
   SET @SQL = @SQL +     
             '  CASE '+    
             '    WHEN (dp.IdTipoInscricao = ' + cast(@TipoInscricao AS varchar) + ') THEN 2'+    
             ' WHEN (isnull(dp.IdTipoInscricao,0) = 0 AND (' + cast(@TipoInscricao AS varchar) + ' > 0) OR'+    
             '    isnull(dp.IdTipoInscricao,0) > 0 AND (' + cast(@TipoInscricao AS varchar) + ' = 0)) THEN 1'+    
             ' WHEN (isnull(dp.IdTipoInscricao,0) = ' + cast(@TipoInscricao AS varchar) + ') THEN 0'+    
             ' WHEN (dp.IdTipoInscricao <> ' + cast(@TipoInscricao AS varchar) + ') THEN -1'+    
             '  END  AS PesoTipoInscricao '    
  /* Tratamos novamente o caso da classe, pois pode existir clientes que não possui classe */    
  IF (@Clase IS NOT NULL)    
   SET @SQL = @SQL +     
       ', CASE '+    
             '    WHEN (dp.Classe = ''' + @Clase + ''') THEN 2'+    
             ' WHEN (dp.Classe = 0 AND (''' + @Clase + ''' > 0) OR'+    
             '    dp.Classe > 0 AND (''' + @Clase + ''' = 0)) THEN 1'+    
             ' WHEN (dp.Classe = ''' + @Clase + ''') THEN 0'+    
             ' WHEN (dp.Classe <> ''' + @Clase + ''') THEN -1'+    
             '  END  AS PesoClasse '    
                 
  SET @SQL = @SQL +                 
             'FROM ProcedimentosOperacionais po'+    
             '  LEFT JOIN DadosPFPJ dp'+    
             '  ON dp.IdProcedimentoOperacional = po.IdProcedimentoOperacional '    
                 
  /* Se o tipo de pessoa for PJ, então temos que considerar a faixa de capital. */    
  IF (@TipoPessoa = 'PJ')    
   SET @SQL = @SQL + 'LEFT JOIN FaixasCapital fc ON fc.IdDadosPFPJ = dp.IdDadosPFPJ '+    
    ' LEFT JOIN Vigencias v ON v.IdDadosPFPJ = dp.IdDadosPFPJ AND v.IdFaixaCapital = fc.IdFaixaCapital '    
  ELSE    
   SET @SQL = @SQL + 'LEFT JOIN Vigencias v ON v.IdDadosPFPJ = dp.IdDadosPFPJ '    
      
  IF (@TipoPessoa = 'PF')    
  BEGIN     
   SET @SQL = @SQL + ' WHERE po.TipoPessoa = 0 )X '    
   /* Tratamento do campo Classe */    
   IF (@Clase IS NOT NULL)    
    SET @SQL = @SQL +     
     'WHERE X.PesoSituacao + X.PesoCategoria + X.PesoTipoInscricao + X.PesoClasse > -1 '+    
     'AND X.PesoSituacao <> -1 AND X.PesoCategoria <> -1 AND X.PesoTipoInscricao <> -1 ' +    
     'AND X.PesoClasse <> -1 '    
   ELSE    
    SET @SQL = @SQL +     
     'WHERE X.PesoSituacao + X.PesoCategoria + X.PesoTipoInscricao > -1 '+    
     'AND X.PesoSituacao <> -1 AND X.PesoCategoria <> -1 AND X.PesoTipoInscricao <> -1 '    
    
   /* Tratamento do campo classe */    
   IF (@Clase IS NOT NULL)    
    SET @SQL = @SQL + ' AND X.PesoClasse <> -1 '    
  END    
  ELSE    
  BEGIN    
   /* Verificamos também o capital social da empresa, este deve estar na faixa cadastrada,    
      nas configurações. */    
   IF @ValorCapital = 0  
  SET @SQL = @SQL + ' WHERE po.TipoPessoa = 1 '+    
  'AND (SELECT ISNULL((SELECT TOP 1 cs.CapitalSocial FROM CapitaisSocial cs '+  /*DM103046*/  
  ' WHERE cs.IdPessoaJuridica = ' + cast(@Id_Pessoa AS varchar) +    
  ' ORDER BY cs.Data DESC),0)) BETWEEN isnull(fc.ValorInicialFaixa,0) '+  /*DM103046*/  
  ' AND ISNULL(fc.ValorFinalFaixa,0))X '  
   ELSE     
  SET @SQL = @SQL + ' WHERE po.TipoPessoa = 1 '+    
  'AND ' + CAST(@ValorCapital AS VARCHAR) + ' BETWEEN isnull(fc.ValorInicialFaixa,0) '+    
  ' AND ISNULL(fc.ValorFinalFaixa,0))X '  
       
   /* Tratamento do campo Classe */    
   IF (@Clase IS NOT NULL)    
    SET @SQL = @SQL +     
     'WHERE X.PesoSituacao + X.PesoCategoria + X.PesoTipoInscricao + X.PesoClasse > -1 ' +    
     'AND X.PesoSituacao <> -1 AND X.PesoCategoria <> -1 AND X.PesoTipoInscricao <> -1 ' +    
     'AND X.PesoClasse <> -1 '    
   ELSE    
    SET @SQL = @SQL +     
     'WHERE X.PesoSituacao + X.PesoCategoria + X.PesoTipoInscricao > -1 ' +    
     'AND X.PesoSituacao <> -1 AND X.PesoCategoria <> -1 AND X.PesoTipoInscricao <> -1 '    
          
   /* Tratamento do campo classe */    
   IF (@Clase IS NOT NULL)    
    SET @SQL = @SQL + ' AND X.PesoClasse <> -1 '    
  END    
      
  IF (@AmbienteExecucao = 'W')    
   SET @SQL = @SQL + ' AND X.AmbienteExecucao IN ( ''W'' , ''A'' )'    
  ELSE    
   SET @SQL = @SQL + ' AND X.AmbienteExecucao IN ( ''D'' , ''A'' )'    
       
  /* Este case vefica de onde deve vir o valor da database, para calculo, se o valor do campo "DataBaseCalc",    
  da tabela "Vigencias", for B significa que devemos utilizar a data atual, ou seja, "GetDate()", agora    
  se for I o sistema deverá utilizar a data presente do campo "DataCompromisso", da tabela Profissionais.    
  E se este não estiver preenchido então vamos utilizar a data do campo "DataInscricaoConselho" */    
  IF (@TipoPessoa = 'PF')    
   SET @SQL = @SQL + ' AND  (CASE WHEN X.DataBaseCalc = ''B'' THEN GETDATE() '+    
    ' WHEN X.DataBaseCalc = ''I'' THEN (SELECT TOP 1 CASE WHEN p.DataCompromisso '+    
    ' IS NULL THEN p.DataInscricaoConselho ELSE p.DataCompromisso '+    
    ' END AS DataBaseCalcProf FROM Profissionais p ' +    
    ' WHERE p.IdProfissional = ' + cast(@Id_Pessoa AS varchar) + ') END) '+    
    ' BETWEEN X.DataInicialVigencia AND convert(varchar(10), isnull(X.DataFinalVigencia, DATEADD(MONTH,12,getdate())), 112) + '' 23:59:59'' '    
       
  SET @SQL = @SQL + 'ORDER BY (PesoSituacao + PesoCategoria + PesoTipoInscricao) DESC'    
    
  INSERT INTO #tmpProcedimento    
  EXEC(@SQL)    
 END     
 /* Caso o programador queira que retorna apenas o resultado da consulta então não geramos o débito */    
 IF (@RetornaConsulta = 1)     
  SELECT DISTINCT  idProcedimento,NomeProcedimento,Automatico,DataBaseCalc,IdSisutacaoPFPJ,IdTipoInscricao,IdDadosPFPJ,IdCategoriaPFPJ /*Oc.127489 TOP 1*/   
  FROM #tmpProcedimento    
  ORDER BY Automatico ASC,IdDadosPFPJ   
 ELSE      
 BEGIN     
  /*Há a opção para a escolha do procedimento.Sendo assim quando houver procedimentos iguais ele não pode pegar o Menor, mas sim o @IdProcedimento informado. */   
  IF @IdProcedimentoOperacional > 0   
   DELETE FROM #tmpProcedimento   
   WHERE IdProcedimento <> @IdProcedimentoOperacional AND Automatico = 0 /*Ficará o procedimento escolhido e os automáticos*/  
  ELSE    
   DELETE FROM #tmpProcedimento     
   WHERE Automatico = 0 /*Ficará os procedimentos automáticos*/  
  
  DECLARE @ID int /* Utilizado para percorrer a tabela de procedimentos */    
      
  /* Verificamos se foi encontrado alguma configuração novamente */    
  SET @TotalSel = (SELECT count(isnull(idProcedimento,0)) FROM #tmpProcedimento)    
      
  /* Preparamos para percorrer os procedimentos pois pode acontecer do sistema retornar mais de    
     configuração, por exemplo se tivermos duas vigências uma utilizando data base igual a data     
     corrente e outra utilizando a data da inscrição. Apesar de ser o mesmo procedimento, existem    
     vigências diferentes com informações diferentes. */    
  SELECT @ID = min(p.Id) FROM #tmpProcedimento p   /*Oc.127489*/  
      
  WHILE (@ID IS NOT NULL )    
  BEGIN    
    
   /* Pegamos o código do procedimento */    
   SELECT @IdProcedimento = idProcedimento    
   FROM #tmpProcedimento WHERE Id = @ID    
      
   /* Preenchemos a variável @DataBase, com o valor segundo regra. ver SQL Acima*/    
   IF ( (SELECT DataBaseCalc FROM #tmpProcedimento WHERE Id = @ID) = 'B')    
    SET @DataBase = GETDATE()    
   ELSE    
    SET @DataBase = (    
     SELECT TOP 1     
      CASE    
       WHEN p.DataCompromisso IS NULL THEN p.DataInscricaoConselho    
       ELSE p.DataCompromisso    
      END AS DataBaseCalcProf    
      FROM Profissionais p     
      WHERE p.IdProfissional = @Id_Pessoa)    
    
   /* Ajusta database para ficar apenas a data */    
   SET @DataBase = CONVERT(Varchar(10), @DataBase, 112)    
    
   /* Se existir algum procedimento então vamos executa-lo */      
   IF NOT (@TotalSel = 0)    
   BEGIN    
    /*Primeiro vamos incluir somente os débitos que não devem ser parcelados em mais de 1 vez.    
      Lembrando que a data base deve estar entre a data de inicio e fim da vigência*/    
          
    SET @SQL = 'SELECT v.IdVigencia, v.IdFaixaCapital, v.DataInicialVigencia, v.DataFinalVigencia, '+    
     'v.Valor, v.AplicarDuodecimo, v.IdTipoDebito, v.IdDadosPFPJ, v.PrazoVencimento, v.NumParcelas,'+    
     'v.TipoParcelamento,v.IdConfigGeracaoDebito FROM #tmpProcedimento po '+  /*Oc125939- Bug437*/  
     'LEFT JOIN DadosPFPJ dp ON dp.IdProcedimentoOperacional = po.idProcedimento '+    
     'AND isnull(dp.IdSituacaoPFPJ,0) = isnull(po.IdSisutacaoPFPJ,0) AND isnull(dp.IdTipoInscricao,0) = isnull(po.IdTipoInscricao,0) '+    
     'AND (CASE WHEN '''+ @TipoPessoa+''' = ''PF'' THEN isnull(dp.IdCategoriaProf,0) ELSE isnull(dp.IdCategoriaPJ,0) '+    
     'END) = isnull(po.IdCategoriaPFPJ,0) '    
        
    /* Se o tipo de pessoa for Pessoa Juridica, o sistema deverá incluir somente vigências     
       que obedecem a faixa de capital informada. */    
    IF (@TipoPessoa = 'PJ')    
     SET @SQL = @SQL + 'LEFT JOIN FaixasCapital fc ON fc.IdDadosPFPJ = dp.IdDadosPFPJ '+    
      'LEFT JOIN Vigencias v ON dp.IdDadosPFPJ = v.IdDadosPFPJ AND v.IdFaixaCapital = fc.IdFaixaCapital and v.IdVigencia = po.IdVigencia '    
    ELSE    
     SET @SQL = @SQL + 'LEFT JOIN Vigencias v ON dp.IdDadosPFPJ = v.IdDadosPFPJ and v.IdVigencia = po.IdVigencia '    
         
    /*Monta where para inclusão de vigências*/     
    SET @SQL = @SQL + 'WHERE po.Id = ' + cast(@ID AS varchar) + ' AND '+    
    'dp.IdProcedimentoOperacional  = po.idProcedimento AND isnull(v.NumParcelas,0) <= 1 '+    
    'AND '''+CONVERT(varchar(10), @database, 112)+' 00:00:00' +''' BETWEEN v.DataInicialVigencia AND '+    
    'convert(varchar(10), isnull(v.DataFinalVigencia, DATEADD(MONTH, 12, getdate())), 112) + '' 23:59:59'' '    
        
    /* Para PJ temos que considerar o valor da faixa de capital social. */    
    IF (@TipoPessoa = 'PJ')    
    BEGIN  
     IF @ValorCapital = 0  
   SET @SQL = @SQL + 'AND (SELECT ISNULL((SELECT TOP 1 cs.CapitalSocial FROM CapitaisSocial cs '+ /*DM103046*/   
   'WHERE cs.IdPessoaJuridica = ' + cast(@Id_Pessoa AS varchar) +    
   ' ORDER BY cs.Data),0)) BETWEEN isnull(fc.ValorInicialFaixa,0) AND isnull(fc.ValorFinalFaixa,0)'/*DM103046*/  
  ELSE  
   SET @SQL = @SQL + 'and ' + CAST(@ValorCapital AS VARCHAR) + ' between isnull(fc.ValorInicialFaixa,0) and isnull(fc.ValorFinalFaixa,0)'  
 END    
    
    INSERT INTO #tmpVigencias     
  EXEC (@SQL)     
  
  
    /* Inserimos na tabela de débitos, os valores presentes na tabela vigência */    
    INSERT INTO #tmpDebitos     
    SELECT    
     @Id_Pessoa,    
     v.IdTipoDebito,    
     1,    
     1,    
     @DataBase,    
     DATEADD(DAY, ISNULL(V.PrazoVencimento,0), @DataBase),    
     @DataBase,    
     CASE     
      WHEN (isnull(v.AplicarDuodecimo,0) = 0 )THEN v.Valor    
      ELSE (SELECT TOP 1 dbo.Calc_Duodecimo(v.Valor, @DataBase))          
     END,    
     0,    
     0,    
     NULL,    
     @IdProcedimento,    
     NULL,  
     v.IdConfigGeracaoDebito /*Oc125939- Bug437*/    
     ,DL = NULL  
    FROM     
     #tmpVigencias v   
    ORDER BY V.idConfigGeracaoDebito   
        
    /* Agora que já temos os débitos que possuem no máximo 1 parcela, vamos incluir os débito que     
       necessitam de parcelamento. */    
         
    /* Removemos os dados da tabela temporária "#tmpVigencias", para que possamos ter nela apenas    
       as vigências que possuem o "NumParcelas" maior que 1 */    
    DELETE FROM #tmpVigencias    
        
    /*Agora vamos adicionar todas as vigências que tem mais de uma parcela.*/    
    SET @SQL = 'SELECT v.IdVigencia, v.IdFaixaCapital, v.DataInicialVigencia, v.DataFinalVigencia, '+    
     'CASE WHEN (isnull(v.AplicarDuodecimo,0) = 0 )THEN v.Valor '+    
     'ELSE (SELECT TOP 1 dbo.Calc_Duodecimo(v.Valor, '''+ CONVERT(varchar(10), @database, 112) +''')) '+    
     'END, v.AplicarDuodecimo, v.IdTipoDebito, v.IdDadosPFPJ, v.PrazoVencimento, v.NumParcelas, '+    
     'v.TipoParcelamento,v.IdConfigGeracaoDebito FROM #tmpProcedimento po LEFT JOIN DadosPFPJ dp ON '+  /*Oc125939- Bug437*/   
     'dp.IdProcedimentoOperacional = po.idProcedimento AND isnull(dp.IdSituacaoPFPJ,0) = isnull(po.IdSisutacaoPFPJ,0) '+    
     'AND isnull(dp.IdTipoInscricao,0) = isnull(po.IdTipoInscricao,0) AND ( CASE WHEN '''+ @TipoPessoa +''' = ''PF'' '+    
     'THEN isnull(dp.IdCategoriaProf,0) ELSE isnull(dp.IdCategoriaPJ,0) END) = isnull(po.IdCategoriaPFPJ,0) '    
         
    /* Para pessoa juridica devemos montar o tratamento de faixa de capital. */    
    IF (@TipoPessoa = 'PJ')    
     SET @SQL = @SQL + 'LEFT JOIN FaixasCapital fc ON fc.IdDadosPFPJ = dp.IdDadosPFPJ '+    
      'LEFT JOIN Vigencias v ON dp.IdDadosPFPJ = v.IdDadosPFPJ AND v.IdFaixaCapital = fc.IdFaixaCapital and v.IdVigencia = po.IdVigencia '    
    ELSE    
     SET @SQL = @SQL + 'LEFT JOIN Vigencias v ON dp.IdDadosPFPJ = v.IdDadosPFPJ and v.IdVigencia = po.IdVigencia '    
        
    SET @SQL = @SQL + 'WHERE po.Id = '+ cast(@Id AS varchar) +' AND dp.IdProcedimentoOperacional '+    
     '= po.idProcedimento AND isnull(v.NumParcelas,0) > 1 AND '''+CONVERT(varchar(10), @database, 112)+' 00:00:00'+''' BETWEEN v.DataInicialVigencia '+    
     'AND convert(varchar(10), isnull(v.DataFinalVigencia, DATEADD(MONTH, 12, getdate())), 112) + '' 23:59:59'' '    
         
    /* Para PJ temos que considerar o valor da faixa de capital social. */    
    IF (@TipoPessoa = 'PJ')    
    BEGIN  
     IF @ValorCapital = 0  
   SET @SQL = @SQL + 'AND (SELECT ISNULL((SELECT TOP 1 cs.CapitalSocial FROM CapitaisSocial cs '+  /*DM103046*/  
   'WHERE cs.IdPessoaJuridica = ' + cast(@Id_Pessoa AS varchar) +    
   ' ORDER BY cs.Data),0)) BETWEEN isnull(fc.ValorInicialFaixa,0) AND isnull(fc.ValorFinalFaixa,0)'/*DM103046*/  
  ELSE  
   SET @SQL = @SQL + 'and ' + CAST(@ValorCapital AS VARCHAR) + ' between isnull(fc.ValorInicialFaixa,0) and isnull(fc.ValorFinalFaixa,0)'    
 END  
        
    
    INSERT INTO #tmpVigencias     
    EXEC (@SQL)    
  
    
    /*Vamos percorrer todos os valores presente na tabela de vigência *  */    
    /* Declaração de variáveis necessárias para o processamento */    
    DECLARE     
     @Int int, /* Utilizado para fazer o laço na tabela "#tmpVigencias" */    
     @QtdParcelas int, /* Recebe a quantidade de parcelas */    
     @ValorDebito decimal(10,2), /* Contém o valor total do débito*/    
     @ValorParcela decimal(10,2), /* Recebe o valor da parcela */    
     @ValorDiferenca decimal(10,2), /* Recebe o valor da diferença, para aplicar na ultima parcela*/    
     @NumConjTpDebito int, /* Utilizado qndo tiver cota única é o agrupador */    
     @NumParcela int, /* Contador de parcelas */    
     @DataVencimento datetime, /* Recebe a data de vencimento das parcelas */    
     @IncData int, /* Incrementador da data de vencimento */    
     @TipoParcel char(2) /* Contém o tipo de parcelamento a ser criado segundo lista CO = Somente cota única  CP = Cota única e Parcelas PA = Somente Parcelas*/    
         
    SELECT @Int = min(v.idVigencia) FROM #tmpVigencias v    
        
    WHILE (@Int IS NOT NULL)    
    BEGIN    
     /* Pegamos o valor total do débito, a quantidade de parcelas e o tipo de parcelamento */        
     SELECT     
      @QtdParcelas = isnull(v.NumParcelas,0),    
      @ValorDebito = isnull(v.Valor,0),     
      @TipoParcel  = v.TipoParcelamento        
     FROM     
      #tmpVigencias v    
     WHERE     
      v.idVigencia = @Int    
          
     /* Agora vamos calcular o valor aproximado de cada parcela */        
     SET @ValorParcela = @ValorDebito / @QtdParcelas    
         
     /* Pode acontecer de termos uma diferença na divisão das parcelas, quando ocorrer isto devemos    
        colocar esta diferença na ultima parcela. Para isto vamos pegar a diferença da divisão*/    
     SET @ValorDiferenca = @ValorDebito - (@ValorParcela * @QtdParcelas)    
         
     SET @NumConjTpDebito = 0    
         
     /* Se for necessário a inclusão de cota única, então vamos inseri-la primeiro e depois    
        vamos inserir as demais parcelas */    
     IF (@TipoParcel = 'CP')    
     BEGIN    
      /* Selecionamos o novo agrupador para o parcelamento */    
      SELECT @NumConjTpDebito = isnull(max(d.NumConjTpDebito),0) + 1    
      FROM     
       Debitos d    
      WHERE    
       @Id_Pessoa = (CASE     
           WHEN @TipoPessoa = 'PF' THEN d.IdProfissional    
           WHEN @TipoPessoa = 'PJ' THEN d.IdPessoaJuridica    
            END)    
    
      /* Incluimos o débito referente a cota unica. */     
      INSERT INTO #tmpDebitos     
      SELECT    
       @Id_Pessoa,    
       v.IdTipoDebito,    
       1,    
       1,    
       @DataBase,    
       DATEADD(DAY, ISNULL(V.PrazoVencimento,0), @DataBase),    
       CASE  
         WHEN v.IdTipoDebito = 1 THEN CAST(CAST(YEAR(@DataBase) AS VARCHAR(4))+'0101' AS DATETIME)    
         ELSE @DataBase  
       END AS DataReferencia ,  
       @ValorDebito,    
       0,    
       0,    
       NULL,    
       @IdProcedimento,    
       @NumConjTpDebito,  
       v.IdConfigGeracaoDebito /*Oc125939- Bug437*/   
       ,DL = NULL    
      FROM     
       #tmpVigencias v     
      WHERE     
       v.idVigencia = @Int    
      ORDER BY V.idConfigGeracaoDebito  
           
     END    
         
     /* Incluimos agora a primeira parcela que tem o a mesma configuração da cota unica    
        alterando apenas o valor e o número da parcela */    
     INSERT INTO #tmpDebitos     
     SELECT    
      @Id_Pessoa,    
      v.IdTipoDebito,    
      1,    
      1,    
      @DataBase,    
      DATEADD(DAY, ISNULL(V.PrazoVencimento,0), @DataBase),    
       CASE  
         WHEN v.IdTipoDebito = 1 THEN CAST(CAST(YEAR(@DataBase) AS VARCHAR(4))+'0101' AS DATETIME)    
         ELSE @DataBase  
       END AS DataReferencia ,   
      @ValorParcela,    
      1,    
      0,    
      NULL,    
      @IdProcedimento,    
      @NumConjTpDebito,  
      v.IdConfigGeracaoDebito /*Oc125939- Bug437*/     
      ,DL = NULL  
     FROM     
      #tmpVigencias v     
     WHERE     
      v.idVigencia = @Int    
     ORDER BY V.idConfigGeracaoDebito  
     /* Como a primeira parcela já foi incluida acima então vamos reduzir a quantidade de parcelas */    
     SET @QtdParcelas = @QtdParcelas - 1    
         
     /* Pegamos a data de vencimento da primeira parcela*/    
     SELECT @DataVencimento = DATEADD(DAY, ISNULL(V.PrazoVencimento,0), @DataBase)    
     FROM #tmpVigencias v     
     WHERE v.idVigencia = @Int    
    
     /* Adicionamos um mes na data de vencimento da primeira parcela, para montar as demais parcelas */    
     SET @DataVencimento = DATEADD(MONTH, 1, @DataVencimento)    
         
     /* Setamos o contador que tem o número da parcela, para começar da parcela 2*/    
     SET @NumParcela = 2    
     SET @IncData = 0    
         
     /* Vamos percorrer agora a quantidade de parcelas para gerar os débitos. */    
     WHILE NOT (@QtdParcelas = 0)    
     BEGIN    
      /* Se tiver diferença e estivermos na ultima parcela então aplicamos a diferença*/    
      IF ((@QtdParcelas - 1) = 0)AND (@ValorDiferenca <> 0)    
       SET @ValorParcela = @ValorParcela + @ValorDiferenca    
          
    
      /* Incluimos o resto das parcelas */    
      INSERT INTO #tmpDebitos     
      SELECT    
       @Id_Pessoa,    
       v.IdTipoDebito,    
       1,    
       1,    
       @DataBase,    
       DATEADD(MONTH, @IncData, @DataVencimento),    
        CASE  
         WHEN v.IdTipoDebito = 1 THEN CAST(CAST(YEAR(@DataBase) AS VARCHAR(4))+'0101' AS DATETIME)    
         ELSE @DataBase  
       END AS DataReferencia ,    
       @ValorParcela,    
       @NumParcela,    
       0,    
       NULL,    
       @IdProcedimento,    
       @NumConjTpDebito,  
       v.IdConfigGeracaoDebito /*Oc125939- Bug437*/     
       ,DL = NULL  
      FROM     
       #tmpVigencias v     
      WHERE     
       v.idVigencia = @Int    
      ORDER BY V.idConfigGeracaoDebito  
           
      /* Vamos para a próxima parcela */    
      SET @QtdParcelas = @QtdParcelas - 1    
      /* Incrementa o número da parcela */    
      SET @NumParcela = @NumParcela + 1    
      /* Adicionamos um mes na data de vencimento da primeira parcela, para montar as demais parcelas */    
    
      SET @IncData = @IncData + 1    
     END    
    
     /* Vamos para o próximo registro */    
     SELECT @Int = min(v.idVigencia) FROM #tmpVigencias v WHERE v.idVigencia > @Int    
    END       
   END    
   /* Limpamos as vigências */    
   DELETE FROM #tmpVigencias    
    
   SELECT @ID = min(p.Id) FROM #tmpProcedimento p WHERE p.Id > @ID   /*Oc.127489*/     
  END    
/*Oc134545-INI_======================================================================================================================================  
===================================================================================================================================================*/  
 /*   Deleta de #tmpDebitos os débitos repetidos nas configurações, utilizando IdPessoa,IdTipoDebito,Year(DataReferencia).  
  *    Isto pq pode existir por exemplo Config A = Anuidade R$100,00  
  *                                                 Taxa R$20,00  
  *                                      Config B = Anuidade R$50,00  
  *                                                 Carteira R$10,00  
  *    Retirando a duplicidade será criado Anuidade R$100,00  
  *                                          Taxa R$20,00  
  *                                          Carteira R$ 10,00  
  *    Quando o @IdProcedimentoOperacional = 0, ou seja só existem débitos automáticos,  
  *    será deixado o de menor Id, caso contrário a prioridade para a criação do débito repetido será a configuração selecionada.                                            
  */     
  
 IF @IdProcedimentoOperacional > 0 --> quando se deve priorizar o @IdProcedimentoOperacional  
 BEGIN   
  /*Marco para não deletar os débitos do @IdProcedimentoOperacional escolhido*/  
  UPDATE #tmpDebitos  
  SET DL = 0  
  WHERE IdProcedimentoOperacional = @IdProcedimentoOperacional   
       
  /*Deleto o IdTipoDebito de todas as outras configurações que sejam iguais ao @IdProcedimentoOperacional escolhido */  
  DELETE #tmpDebitos  
  WHERE ID IN( SELECT X.ID  
      FROM (SELECT TD.ID,TD.IdTipoDebito,TD.IdProcedimentoOperacional,TD.DL  
         FROM #tmpDebitos TD  
         WHERE TD.DL IS NULL)X INNER JOIN   
        (SELECT TD.ID,TD.IdTipoDebito,TD.IdProcedimentoOperacional,TD.DL  
         FROM #tmpDebitos TD  
         WHERE TD.DL = 0) Y ON X.IdTipoDebito = Y.IdTipoDebito     
     )      
 END  
   
 /*Marco para não deletar os débitos do Maior @IdProcedimentoOperacional automático, ou seja o procedimento automático  
 * cadastrado por último.*/  
 UPDATE TD  
 SET DL = 0  
 FROM #tmpDebitos TD INNER JOIN    
   (SELECT IdTipoDebito,IdProcedimentoOperacional = MAX(IdProcedimentoOperacional)  
    FROM #tmpDebitos   
    GROUP BY IdTipoDebito)X ON X.IdTipoDebito = TD.IdTipoDebito AND X.IdProcedimentoOperacional = TD.IdProcedimentoOperacional  
   
 /*Deleto os repetidos*/  
    DELETE  
    FROM #tmpDebitos   
    WHERE DL IS NULL  
   
/*Oc134545-FIM_======================================================================================================================================  
===================================================================================================================================================*/  
  
  INSERT INTO Debitos    
  (    
   IdProfissional, IdPessoaJuridica, IdTipoDebito, IdSituacaoAtual,    
   IdMoeda, DataGeracao, DataVencimento, DataReferencia, ValorDevido,     
   NumeroParcela, IdPessoa, Emitido, IdProcedimentoOperacional, NumConjTpDebito,  
   IdConfigGeracaoDebito /*Oc125939- Bug437*/       
  )    
  SELECT     
   CASE     
    WHEN @TipoPessoa = 'PF' THEN d.IdProfissional    
    ELSE NULL    
   END,    
   CASE     
    WHEN @TipoPessoa = 'PJ' THEN d.IdProfissional    
    ELSE NULL    
   END,    
   d.IdTipoDebito,     
   d.IdSituacaoAtual, d.IdMoeda,    
   d.DataGeracao,     
   d.DataVencimento,     
   d.DataReferencia,     
   d.ValorDevido,    
   d.NumeroParcela,     
   d.IdPessoa,     
   d.Emitido,     
   d.IdProcedimentoOperacional,    
   d.NumConjTpDebito,  
   d.IdConfigGeracaoDebito /*Oc125939- Bug437*/     
  FROM     
   #tmpDebitos d   
/*Oc134545-INI_======================================================================================================================================  
===================================================================================================================================================*/  
  /*01-Evita no momento da inserção dos dados da tabela #tmpDebitos em débitos a repetição de débitos para o mesmo profissional/pessoajurídica,   
   *    utilizando como filtro tipo de débito ano referência.  
   */   
   LEFT JOIN Debitos DB ON D.IdProfissional =
   CASE 
     WHEN @TipoPessoa = 'PF' THEN DB.IdProfissional
     WHEN @TipoPessoa = 'PJ' THEN DB.IdPessoaJuridica
   END    
     
                       AND D.IdTipoDebito = DB.IdTipoDebito   
                       AND YEAR(D.DataReferencia) = YEAR(DB.DataReferencia)   
  WHERE DB.IdDebito IS NULL   
  ORDER BY d.IdProcedimentoOperacional  
/*Oc134545-FIM_======================================================================================================================================  
===================================================================================================================================================*/     
 END    
 /* Removemos a tabela temporária */    
 DROP TABLE #tmpProcedimento    
 DROP TABLE #tmpVigencias    
 DROP TABLE #tmpDebitos    
     
 /* Se a SP estiver em modo teste o banco deve cancelar a transação, caso contrário salvamos     
  * a mesma */    
 IF (@Teste = 1)    
  ROLLBACK     
 ELSE    
  COMMIT  
     
