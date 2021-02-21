

-- ============================================================================
--	sp_ExibeDebitosPjWeb
-- ============================================================================																							
CREATE PROCEDURE [dbo].[sp_ExibeDebitosPjWeb]
	@data VARCHAR(10),
	@idPj VARCHAR(10),
	@Ren INT = 0,
	@criterios VARCHAR(8000) = '' ,
	@exbDebDivAtivaAdm INT = 1,
	@exbDebDivAtivaExec INT = 1,
	@utilizarOpcoesDescontoMensagensInstrucao BIT,
	@sqlAuxiliar VARCHAR(1000) = '',
	@DBMainName VARCHAR(100) = 'siscafweb_java'
AS
BEGIN
	DECLARE @sql                                          VARCHAR(8000),
	        @sqlWhere                                     VARCHAR(8000),
	        @sqlOrderBy                                   VARCHAR(8000),
	        @sqlDeleteDivAtiva                            VARCHAR(1000),
	        @Complemento                                  VARCHAR(5000),
	        @Filtro                                       VARCHAR(5000),
	        @sqlFromTemporaria                            VARCHAR(100),
	        @sqlSelectCaseDividaAtiva                     VARCHAR(1000),
	        @sqlDivAtiva                                  VARCHAR(200),
	        @bloquearDebitosDividaAtivaAdministrativa     BIT,
	        @bloquearDebitosDividaAtivaExecutiva          BIT,
	        @sqlUtilizarOpcoesDescontoMensagensInstrucao  VARCHAR(1000),
	        @rdv                                          BIT,
	        @limitarDataVencimento                        VARCHAR(300),
	        @limitarDataVencimentoCampo                   VARCHAR(300)
	
	
	IF (@utilizarOpcoesDescontoMensagensInstrucao = 1)
	BEGIN
	    SET @sqlUtilizarOpcoesDescontoMensagensInstrucao = 
	        ' CONVERT(varchar(10), Debitos.DataVencimento, 103) AS DataVencimento, '
	END
	ELSE
	BEGIN
	    SET @sqlUtilizarOpcoesDescontoMensagensInstrucao = 
	        '  ISNULL ((SELECT CONVERT(VARCHAR(10), MIN(opd.DataPgtoDesconto), 103) FROM OpcoesPgtoDesconto opd
															WHERE opd.DataPgtoDesconto > '''
	        + @data +
	        '''
															and idconfigparceladebito IN (SELECT idconfigparceladebito
															FROM   ConfigParcelasDebito
															INNER JOIN debitos d ON d.IdConfigGeracaoDebito = ConfigParcelasDebito.IdConfigGeracaoDebito
															WHERE d.IdDebito = Debitos.IdDebito
															)
															),CONVERT(VARCHAR(10), Debitos.DataVencimento, 103)) AS DataVencimento,  '
	END
	
	SET @sqlSelectCaseDividaAtiva = 
	    '
		CASE WHEN Debitos.TipoDividaAtiva IS NOT NULL AND Debitos.TipoDividaAtiva <> ''''  THEN 
		(SELECT max(IdDividaAtiva) FROM DebitosDividaAtiva dda WHERE dda.IdDebito = Debitos.iddebito)
		ELSE NULL
		END AS IdDividaAtiva
	'
	
	SET @sqlDivAtiva = ' '	        
	
	IF (@exbDebDivAtivaAdm = 0 AND @exbDebDivAtivaExec = 0)
	BEGIN
	    SET @sqlDivAtiva = 
	        ' AND (Debitos.TipoDividaAtiva IS NULL or Debitos.TipoDividaAtiva = '''' ) '
	END
	ELSE 
	IF (@exbDebDivAtivaAdm = 0)
	BEGIN
	    SET @sqlDivAtiva = ' AND (ISNULL(Debitos.TipoDividaAtiva,0) <> 1 ) '
	END
	ELSE 
	IF (@exbDebDivAtivaExec = 0)
	BEGIN
	    SET @sqlDivAtiva = ' AND (ISNULL(Debitos.TipoDividaAtiva,0) <> 2 ) '
	END
	
	
	IF @Ren = 0
	BEGIN
	    SET @Complemento = ' '            
	    SET @Filtro = ''
	END
	ELSE
	BEGIN
	    SET @limitarDataVencimento = ''
	    SET @limitarDataVencimentoCampo = ' '
	    SELECT @rdv = RenegociarDebitosVencer
	    FROM   ParametrosSiscafweb
	    
	    PRINT @rdv
	    IF (@rdv = 0)
	    BEGIN
	        SET @limitarDataVencimentoCampo = 
	            ' WHEN ( Debitos.DataVencimento > getDate() ) THEN 0 '
	        
	        SET @limitarDataVencimento = 
	            ' WHEN ( DATEADD(DAY,@AddDias,Debitos.DataVencimento) > getDate() ) THEN 0 '
	    END
	    
	    
	    SET @Complemento = ' AND CASE ' + @limitarDataVencimento + +
	        '      WHEN EXISTS(SELECT 1 FROM ParametrosSiscafweb WHERE RenegociarAnoCorrente = 0 ) ' 
	        +
	        '        AND (YEAR(debitos.DataReferencia) = YEAR(getDate()) ) THEN 0' 
	        +
	        '      WHEN YEAR(debitos.DataReferencia) < ( YEAR(getDate()) - (SELECT top 1 RenegociarAnoCorrenteMenor FROM ParametrosSiscafweb ) ) THEN 0' 
	        +
	        '      WHEN ( Debitos.IdTipoDebito = 2 ) THEN 0  ' +
	        '  ELSE  ' +
	        '    ISNULL( (SELECT permite FROM Param_Ren_DebitosPJ WHERE Param_Ren_DebitosPJ.IdTipoDebito = Debitos.IdTipoDebito  ),1)  ' 
	        +
	        '  END = 1 '                   
	    
	    SELECT @bloquearDebitosDividaAtivaAdministrativa = 
	           bloquearDebitosDividaAtivaAdministrativa,
	           @bloquearDebitosDividaAtivaExecutiva = 
	           bloquearDebitosDividaAtivaExecutiva
	    FROM   ParametrosSiscafWeb psw
	    
	    IF (
	           @bloquearDebitosDividaAtivaAdministrativa = 1
	           AND @bloquearDebitosDividaAtivaExecutiva = 1
	       )
	    BEGIN
	        SET @sqlDivAtiva = 
	            ' AND (Debitos.TipoDividaAtiva IS NULL or Debitos.TipoDividaAtiva = '''' ) '
	    END
	    ELSE 
	    IF (@bloquearDebitosDividaAtivaAdministrativa = 1)
	    BEGIN
	        SET @sqlDivAtiva = ' AND (ISNULL(Debitos.TipoDividaAtiva,0) <> 1 ) '
	    END
	    ELSE 
	    IF (@bloquearDebitosDividaAtivaExecutiva = 1)
	    BEGIN
	        SET @sqlDivAtiva = ' AND (ISNULL(Debitos.TipoDividaAtiva,0) <> 2 ) '
	    END
	    
	    SET @Filtro = ' '
	END              
	
	SET @sql = 
	    ' DECLARE @AddDias             INT, @ProcedimentoPadrao  INT  SELECT @AddDias = QuantidadeDiasAposVencidoAplicarProcedimentoAtraso, @ProcedimentoPadrao = IdProcedimentoAtrasoPadrao FROM   '
	    + @DBMainName + '.dbo.regionais WHERE  NomeDB = DB_NAME()  SELECT ' + @sqlSelectCaseDividaAtiva
	    +
	    '       ,IdDebito, 
	            Debitos.IdTipoDebito, 
	            TiposDebito.SiglaDebito, 
	            YEAR(Debitos.DataReferencia) AS AnoRef, 
	            NumeroParcela, MoedAS.Moeda, Debitos.ValorDevido, 
							Debitos.TpEmissaoConjunta, Debitos.NumConjEmissao, '
	    +
	    @sqlUtilizarOpcoesDescontoMensagensInstrucao
	    +
	    ' ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, 
										 CONVERT( VARCHAR(10), ''' + @data +
	    ''' ,112 ), 
										 Debitos.ValorDevido, 
										 1, 
										 Debitos.IdTipoDebito, 
										 Debitos.IdMoeda, 
										 0, 
										 3, 
										 Debitos.IdDebito,
										 CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END)
				, 0) AS Atualizacao, ' + CHAR(13) +
	    
	    /* Multa */
	    ' ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, 
										 CONVERT( VARCHAR(10), ''' + @data +
	    ''' ,112 ), 
										 Debitos.ValorDevido, 
										 1, 
										 Debitos.IdTipoDebito, 
										 Debitos.IdMoeda, 
										 0, 
										 1, 
										 Debitos.IdDebito, 
										 CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END)
				, 0) AS Multa, ' + CHAR(13) +
	    
	    /* Juros */
	    ' ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, 
									   CONVERT( VARCHAR(10), ''' + @data +
	    ''' ,112 ), 
										 Debitos.ValorDevido, 
										 1, 
										 Debitos.IdTipoDebito, 
										 Debitos.IdMoeda, 
										 0, 
										 2, 
										 Debitos.IdDebito, 
										 CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END)
				, 0) AS Juros, ' + CHAR(13) +
	    
	    /* Valor Total */
	    ' ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, 
									   CONVERT( VARCHAR(10), ''' + @data +
	    ''' ,112 ), 
										 Debitos.ValorDevido, 
										 1, 
										 Debitos.IdTipoDebito, 
										 Debitos.IdMoeda, 
										 0, 
										 0, 
										 Debitos.IdDebito ,
										 CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END)
			  , 0) AS ValorTotal, ' + CHAR(13) +
	    
	    /* CÃ³digo Erro */ 
	    ' ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, 
										 CONVERT( VARCHAR(10), ''' + @data +
	    ''' ,112 ), 
										 Debitos.ValorDevido, 
										 1, 
										 Debitos.IdTipoDebito, 
										 Debitos.IdMoeda, 
										 0, 
										 5, 
										 Debitos.IdDebito, 
										 CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END)
			  , 0) AS CodErro, ' + CHAR(13) +
	    
	    /* Novo campo para mostrar ou nÃ£o o dÃ©bito para renegociaÃ§Ã£o */ 
	    ' CASE 
										  WHEN EXISTS(SELECT 1 FROM ParametrosSiscafweb WHERE RenegociarAnoCorrente = 0 ) 
										  AND (YEAR(debitos.DataReferencia) = YEAR(getDate()) ) THEN 0
	                  WHEN YEAR(debitos.DataReferencia) < ( YEAR(getDate()) - (SELECT top 1 RenegociarAnoCorrenteMenor FROM ParametrosSiscafweb ) ) THEN 0 
							      WHEN ( Debitos.IdTipoDebito = 2 ) THEN 0
							 ELSE 
									ISNULL( (SELECT permite FROM Param_Ren_DebitosPJ WHERE Param_Ren_DebitosPJ.IdTipoDebito = Debitos.IdTipoDebito  ),1)
							  END AS Renegociar,					
							  		
							 Debitos.IdSituacaoAtual, 
							 SituacoesDebito.SituacaoDebito, 
							 Debitos.TipoDividaAtiva, 
							 Debitos.NumConjReneg, 
							 Debitos.NumConjTpDebito, 
							 Debitos.IdConfigGeracaoDebito 
							 INTO #Debitos
	     FROM Debitos  
	           INNER JOIN TiposDebito ON TiposDebito.IdTipoDebito = Debitos.IdTipoDebito  
				     INNER JOIN MoedAS ON MoedAS.IdMoeda = Debitos.IdMoeda
						 LEFT JOIN SituacoesDebito ON Debitos.IdSituacaoAtual = SituacoesDebito.IdSituacaoDebito ' 
	
	
	SET @sqlWhere = ' WHERE Debitos.IdPessoaJuridica = ' + @idPj +
	    '   AND Debitos.IdSituacaoAtual IN (1,3,10) ' 
	    + @Complemento + @criterios 
	    + @Filtro +
	    ' AND ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, 
										   CONVERT( VARCHAR(10), ''' + @data +
	    ''' ,112 ),       
											 Debitos.ValorDevido, 
											 1, 
											 Debitos.IdTipoDebito, 
											 Debitos.IdMoeda, 
											 0, 
											 0, 
											 Debitos.IdDebito, 
											 CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END), 0) > 0 '
	    + @sqlDivAtiva + @sqlAuxiliar
	
	SET @sqlOrderBy = 
	    ' 	 ORDER BY  
					Debitos.DataReferencia Desc, 
					TiposDebito.SiglaDebito Desc,
					Debitos.NumeroParcela,
					Debitos.DataVencimento ASC'
	
	SET @sqlDeleteDivAtiva = ''
	IF (@Ren = 1)
	    SET @sqlDeleteDivAtiva = 
	        ' DELETE 
	FROM   #Debitos
	WHERE  IdDividaAtiva IN (SELECT dda.IdDividaAtiva
							FROM   DebitosDividaAtiva dda
									LEFT JOIN Debitos d
										ON  d.IdDebito = dda.IdDebito
							WHERE   d.IdSituacaoAtual IN (10,15) AND d.IdDebito NOT IN (SELECT idDebito
													FROM   #Debitos)
									AND dda.IdDividaAtiva IN (SELECT idDividaAtiva
															FROM   #Debitos))'       
	
	
	SET @sqlFromTemporaria = ' select * FROM #Debitos ' 
	
	
	/*PRINT @sql 
	PRINT @sqlWhere 
	PRINT @sqlOrderBy 
	PRINT @sqlDeleteDivAtiva 
	PRINT @sqlFromTemporaria*/
	PRINT @sql + @sqlWhere + @sqlOrderBy + @sqlDeleteDivAtiva + @sqlFromTemporaria
	
	EXEC (
	         @sql + @sqlWhere + @sqlOrderBy + @sqlDeleteDivAtiva + @sqlFromTemporaria
	     )
END
