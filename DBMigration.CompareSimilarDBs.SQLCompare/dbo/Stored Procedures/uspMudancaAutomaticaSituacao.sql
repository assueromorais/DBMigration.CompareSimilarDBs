

/*Oc. 63102 - Diego 10/06/10 */  
/*Oc. 57271 - Gustavo 22/07/2010*/
/*OC. 70712 - Robério 01/12/2010*/
/*OC. 71618 - Nivaldo 20/12/2010*/

CREATE PROCEDURE [dbo].[uspMudancaAutomaticaSituacao]   
 @IdProfissional      INT,  
 @QtdSituacoesCriadas INT OUTPUT  
AS  
BEGIN  
 SET @QtdSituacoesCriadas = 0
   
 DECLARE @AtivaAtualizacaoAut_Situacoes  BIT,  
         @IdSituacaoPFPJANT    INT,  
         @IdSituacaoPFPJPOS              INT,  
         @IdTipoInscricaoANT             INT,
         @IdCategoriaProfANT			 INT, 
         @IdDetalheSituacaoANT           INT,  
         @IdDetalheSituacaoPOS           INT,  
         @FiltroProfissional             VARCHAR(800),  
         @FiltroDetalheSitAnt            VARCHAR(800),  
         @FiltroTipoInscrAnt             VARCHAR(800),
         @FiltroCategoriaAnt             VARCHAR(800),
         @FiltroSituacaoAnt              VARCHAR(800),  
         @FiltroInverso					 VARCHAR(800),
         /* Oc. 64186 
         * @FiltroInverso -> Este filtro visa sanar uma falha na tela de configurações da mudança automática 
         * de situação. Esta falha consiste em que o usuário pode configurar apenas as situações anterior e posterior.
         * Sendo assim, imagine que seja configurado a situação anterior "ATIVO" e a nova situação seja "ATIVO". Desta
         * forma quando o sistema procurar pelos profissionais que estiverem na situação ativo, imagine que neste exemplo
         * são 1000 profissionais, a SP irá criar uma nova situação, que será a situação "ATIVO". Na próxima vez que o sistema
         * fizer a mesma verificação estes 1000 profissionais serão encontrados, ou seja, entar em LOOP. 
         * A mesma coisa acontece se além das duas situações informadas acima for informado o novo detalhe de situação. Não
         * importa qual será o novo detalhe de situação, pois se não foi informado o detalhe anterior, será recuperado
         * os profissionais de tal situação com qualquer detalhe (inclusive com o novo detalhe). Outra erro 
         * seria setar os detalhes anterior e novo igual, o que não parece ter lógica mas que caso o usuário
         * o faça também causará o erro.*/
         
         @NovaSituacao                   VARCHAR(100),  
         @NovoDetalhe                    VARCHAR(100),  
         @NomeCampo                      VARCHAR(100),  
         @CriterioSelecao                VARCHAR(100),  
         @AnoMesDia                      VARCHAR(100),  
         @Operador                       VARCHAR(100),  
         @FiltroAnoMesDia                VARCHAR(200),  
         @Qtd                            VARCHAR(100),
         @UsuarioUltimaAtualizacao		 VARCHAR(100)
  
 IF EXISTS (SELECT TOP 1 1 FROM ParametrosSiscafw PS WHERE PS.ATIVAATUALIZACAOAUT_SITUACOES = 1)   
 BEGIN  
  CREATE TABLE #TblTmp (IdProfissionalSituacaoPF INT, /*Id da Situacao que será encerrada*/  
                        IdProfissional   INT,  
                        
               UsuarioUltimaAtualizacao VARCHAR(100), /*Nome do usuário que cadastrou a situacao que será encerrada*/  
                        IdNovaSituacao   INT,   
                        IdNovoDetalhe    INT)   
                          
  
            
  IF @IdProfissional > 0  
   SET @FiltroProfissional = ' AND IdProfissional = '+CAST(@IdProfissional AS VARCHAR)+' '  
  ELSE  
   SET @FiltroProfissional = ''
   
  SET @UsuarioUltimaAtualizacao = '''Alteração Automática pelo Sistema'''   
 
 PRINT @UsuarioUltimaAtualizacao  
    
  DECLARE crSituacao CURSOR FAST_FORWARD READ_ONLY FOR  
   SELECT  
    ISNULL(IdSituacaoPFPJANT,0), 
    ISNULL(IdSituacaoPFPJPOS,0),   
    ISNULL(IdTipoInscricaoANT,0),
    ISNULL(IdCategoriaProfANT,0),
    ISNULL(IdDetalheSituacaoANT,0),
    ISNULL(IdDetalheSituacaoPOS,0),
    Qtd,  
    NomeCampo,  
    CASE Criterio  
     WHEN 'Anos' THEN 'YEAR'  
     WHEN 'Meses' THEN 'MONTH'  
     WHEN 'Dias' THEN 'DAY'  
    END AS AnoMesDia,  
    CriterioSelecao,  
    CASE CriterioSelecao  
     WHEN 'Maior que' THEN ' < '  
     WHEN 'Menor que' THEN ' > '  
     WHEN 'Maior ou igual a' THEN ' <= '  
     WHEN 'Menor ou igual a' THEN ' >= '  
     WHEN 'Igual a' THEN ' = '  
     WHEN 'No ano que se completa' THEN ' = '  
     WHEN 'No mês que se completa' THEN ' = '  
    END AS CS  
   FROM  
    ConfigSituacoes   
    
  OPEN crSituacao  
    
  FETCH FROM crSituacao INTO @IdSituacaoPFPJANT, @IdSituacaoPFPJPOS, @IdTipoInscricaoANT, @IdCategoriaProfANT,  
         @IdDetalheSituacaoANT, @IdDetalheSituacaoPOS, @Qtd, @NomeCampo,  
         @AnoMesDia, @CriterioSelecao,@Operador  
  
    
  WHILE @@FETCH_STATUS = 0  
  BEGIN  
         
   SELECT  
    @FiltroSituacaoAnt = ' AND IdSituacaoPFPJ = ' + CAST(@IdSituacaoPFPJANT AS VARCHAR)+' ',   
    @NovaSituacao = CAST(@IdSituacaoPFPJPOS AS VARCHAR)   
 
    SELECT @FiltroInverso = ''
   
	IF @IdSituacaoPFPJANT = @IdSituacaoPFPJPOS
	BEGIN
								
		SELECT @FiltroInverso = ' AND IdProfissional NOT IN (SELECT IdProfissional FROM Profissionais_SituacoesPF WHERE IdSituacaoPFPJ = ' + CAST(@IdSituacaoPFPJPos AS VARCHAR) + ' '
		
			 + ' AND IdDetalheSituacao = ' + CAST(@IdDetalheSituacaoPos AS VARCHAR) + ') '												
	    
	END		    
     
   IF @IdDetalheSituacaoPOS > 0   
    SET @NovoDetalhe = CAST(@IdDetalheSituacaoPOS AS VARCHAR)+' '  
   ELSE  
    SET @NovoDetalhe = ' NULL '   
     
   IF @IdDetalheSituacaoANT > 0   
    SET @FiltroDetalheSitAnt= ' AND IdDetalheSituacao = '+ CAST(@IdDetalheSituacaoANT AS VARCHAR)+' '  
   ELSE  
    SET @FiltroDetalheSitAnt= ''  
      
   IF @IdTipoInscricaoANT > 0   
    SET @FiltroTipoInscrAnt = ' AND EXISTS (SELECT TOP 1 1 '+   
                              '             FROM Profissionais p '+  
                                    '             WHERE p.IdProfissional = Profissionais_SituacoesPF.IdProfissional AND '+  
                                    '                   p.IdTipoInscricao = '+CAST(@IdTipoInscricaoANT AS VARCHAR)+') '  
   ELSE  
    SET @FiltroTipoInscrAnt = ''       
   
   IF @IdCategoriaProfANT > 0   
    SET @FiltroCategoriaAnt = ' AND EXISTS (SELECT TOP 1 1 '+   
                              '             FROM Profissionais p '+  
                                    '             WHERE p.IdProfissional = Profissionais_SituacoesPF.IdProfissional AND '+  
                                    '                   p.CategoriaAtual = (SELECT NomeCategoriaProf FROM CategoriasProf WHERE IdCategoriaProf = '+CAST(@IdCategoriaProfANT AS VARCHAR)+')) '  
   ELSE  
    SET @FiltroCategoriaAnt = ''
      
   /*******************************************  
    * Mudança automática após vencimento  
   
   *******************************************/  
   
   IF @NomeCampo IS NULL                               
    EXEC('INSERT INTO #TblTmp(IdProfissionalSituacaoPF, IdProfissional, UsuarioUltimaAtualizacao, IdNovaSituacao, IdNovoDetalhe) '+  
      ' SELECT IdProfissionalSituacaoPF, '+  
      '       IdProfissional, '+  
      '       '+@UsuarioUltimaAtualizacao+', '+  
      '       '+@NovaSituacao+','+  
      '       '+@NovoDetalhe+  
      ' FROM   Profissionais_SituacoesPF '+  
      ' WHERE  CAST(CONVERT(VARCHAR(10), DataValidade, 112) AS DATETIME) < CAST(CONVERT(VARCHAR(10), GETDATE(), 112) AS DATETIME) '+  
      '     AND DataFimSituacao IS NULL '+  
      @FiltroSituacaoAnt+  
      @FiltroProfissional+  
      @FiltroDetalheSitAnt+  
      @FiltroTipoInscrAnt+
	  @FiltroCategoriaAnt +
	  @FiltroInverso)  
   ELSE  
   /************************************  
   * Mudança automática mediante critério  
   *************************************/  
    BEGIN  
     IF @CriterioSelecao = 'No ano que se completa'  
      SET @FiltroAnoMesDia = @AnoMesDia + '(DATEADD('+ @AnoMesDia+  ',' +@Qtd+',CONVERT(CHAR, ' +@NomeCampo+',112)))'+  
              @Operador + ' ' + @AnoMesDia+'(CONVERT(VARCHAR,GETDATE(),112)))'  
                
     ELSE IF @CriterioSelecao = 'No mês que se completa'  
      SET @FiltroAnoMesDia = @AnoMesDia + '(DATEADD( ' +@AnoMesDia+ ',' +@Qtd+ ',CONVERT(CHAR,' +@NomeCampo + ',112))) ' +  
              @Operador+ ' ' + @AnoMesDia+ '(CONVERT(VARCHAR,GETDATE(),112)) '+  
                                   'AND MONTH(CONVERT(CHAR, ' +@NomeCampo+ ',112)) = MONTH((CONVERT(VARCHAR,GETDATE(),112)))'  
                                       
     ELSE  
      SET @FiltroAnoMesDia ='DATEADD( ' + @AnoMesDia+  ',' +@Qtd+ ',' +' CONVERT(CHAR, ' +@NomeCampo+ ',112)) ' +  
              @Operador + ' (CONVERT(VARCHAR,GETDATE(),112))) '  
       
       
         
     EXEC('INSERT INTO #TblTmp(IdProfissionalSituacaoPF, IdProfissional, UsuarioUltimaAtualizacao, IdNovaSituacao, IdNovoDetalhe) '+  
       'SELECT IdProfissionalSituacaoPF, '+  
       '       IdProfissional, '+  
       '	   '+@UsuarioUltimaAtualizacao+', '+  
       '       '+@NovaSituacao+','+  
       '       '+@NovoDetalhe+  
       'FROM   Profissionais_SituacoesPF '+  
       'WHERE  (DataFimSituacao IS NULL) '+  
       @FiltroProfissional+  
       @FiltroSituacaoAnt+  
       @FiltroDetalheSitAnt+  
       @FiltroTipoInscrAnt+
       @FiltroCategoriaAnt+  
       ' AND IdProfissional IN (SELECT IdProfissional FROM Profissionais '+  
       '                        WHERE '+  
       @FiltroAnoMesDia +
       @FiltroInverso)  
    END  
   FETCH FROM crSituacao INTO @IdSituacaoPFPJANT, @IdSituacaoPFPJPOS, @IdTipoInscricaoANT, @IdCategoriaProfANT,  
          @IdDetalheSituacaoANT, @IdDetalheSituacaoPOS, @Qtd, @NomeCampo,  
          @AnoMesDia, @CriterioSelecao,@Operador  
  END  
    
  CLOSE crSituacao  
  DEALLOCATE crSituacao  
    
          
  /* Coloca data fim na situacao anterior */  
  UPDATE  
   Profissionais_SituacoesPF  
  SET   
   DataFimSituacao = CONVERT(VARCHAR(100),GETDATE(),112),  
            UsuarioUltimaAtualizacao = T.UsuarioUltimaAtualizacao  
  FROM  
   Profissionais_SituacoesPF   
      INNER JOIN #TblTmp T ON T.IdProfissionalSituacaoPF = Profissionais_SituacoesPF.IdProfissionalSituacaoPF  
  
  /* Insere nova situacao sem data de validade */  
  INSERT INTO Profissionais_SituacoesPF (IdProfissional,DataInicioSituacao,IdSituacaoPFPJ,IdDetalheSituacao,InseriuAutomaticamente,UsuarioUltimaAtualizacao)  
   SELECT  
    T.IdProfissional,  
    CONVERT(VARCHAR(100),  
    DATEADD(DAY,1,GETDATE()),112),  
    T.IdNovaSituacao,  
    T.IdNovoDetalhe,  
    1,  
    T.UsuarioUltimaAtualizacao   
   FROM  
    #TblTmp T   
           
  /* Update situacao atual do profissional */  
  UPDATE  
   Profissionais  
  SET   
   SituacaoAtual = (SELECT NomeSituacao FROM SituacoesPFPJ where IdSituacaoPFPJ = T.IdNovaSituacao)  
  FROM  
   Profissionais   
   INNER JOIN #TblTmp T ON T.IdProfissional = Profissionais.IdProfissional      
         
  SET @QtdSituacoesCriadas = @QtdSituacoesCriadas + (SELECT @@ROWCOUNT)            
  
  DROP TABLE #TblTmp   
 END  
END
