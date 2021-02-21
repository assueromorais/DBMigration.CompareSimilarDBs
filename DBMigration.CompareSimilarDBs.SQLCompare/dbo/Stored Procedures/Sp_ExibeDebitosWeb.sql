
		
-- ============================================================================
--	sp_ExibeDebitosWeb
-- ============================================================================			
CREATE PROCEDURE [dbo].[Sp_ExibeDebitosWeb]
	@data VARCHAR(10),
	@idProf VARCHAR(10),
	@Ren INT = 0,
	@criterios VARCHAR(8000) = '' ,
	@exbDebDivAtivaAdm INT = 1,
	@exbDebDivAtivaExec INT = 1,
	@DBMainName VARCHAR(100) = 'siscafweb_java',
	@utilizarOpcoesDescontoMensagensInstrucao BIT = 0,
	@sqlAuxiliar VARCHAR(1000) = ''
AS
BEGIN
	DECLARE @sql                                          VARCHAR(8000),
	        @sqlWhere                                     VARCHAR(8000),
	        @sqlOrderBy                                   VARCHAR(8000),
	        @sqlDeleteDivAtiva                            VARCHAR(1000),
	        @Complemento                                  VARCHAR(5000),
	        @Filtro                                       VARCHAR(8000),
	        @sqlFromTemporaria                            VARCHAR(100),
	        @sqlDivAtiva                                  VARCHAR(200),
	        @sqlSelectCaseDividaAtiva                     VARCHAR(1000),
	        @bloquearDebitosDividaAtivaAdministrativa     BIT,
	        @bloquearDebitosDividaAtivaExecutiva          BIT,
	        @sqlUtilizarOpcoesDescontoMensagensInstrucao  VARCHAR(1000),
	        @rdv                                          BIT,
	        @limitarDataVencimento                        VARCHAR(300)
	
	
	
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
															                     AND ConfigParcelasDebito.NumeroParcela = d.NumeroParcela
															WHERE d.IdDebito = Debitos.IdDebito
															)
															),CONVERT(VARCHAR(10), Debitos.DataVencimento, 103)) AS DataVencimento,  '
	END
	
	SET @sqlSelectCaseDividaAtiva = 
	    '
	   CASE WHEN Debitos.TipoDividaAtiva IS NOT NULL AND Debitos.TipoDividaAtiva > 0  THEN 
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
	    SELECT @rdv = RenegociarDebitosVencer
	    FROM   ParametrosSiscafweb
	    
	    PRINT @rdv
	    IF (@rdv = 0)
	    BEGIN
	        SET @limitarDataVencimento = 
	            'WHEN ( DATEADD(DAY,@AddDias,Debitos.DataVencimento) > getDate() ) THEN 0 '
	    END
	    
	    
	    SET @Complemento = ' AND CASE   ' + @limitarDataVencimento +
	        ' WHEN EXISTS   ( SELECT 1 FROM ParametrosSiscafweb WHERE RenegociarAnoCorrente = 0 ) ' 
	        +
	        ' AND (YEAR(debitos.DataReferencia) = YEAR(getDate()) ) then 0                        ' 
	        +
	        ' WHEN YEAR(debitos.DataReferencia) < ( YEAR(getDate()) - (select RenegociarAnoCorrenteMenor from ParametrosSiscafweb ) )' 
	        +
	        ' THEN 0' +
	        ' WHEN ( Debitos.IdTipoDebito = 2 ) THEN 0  ' +
	        ' ELSE  ' +
	        ' ISNULL( (select permite from Param_Ren_Debitos where Param_Ren_Debitos.IdTipoDebito = Debitos.IdTipoDebito  ),1)  ' 
	        +
	        '  end = 1 '                               
	    
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
	    '
	    DECLARE @AddDias             INT,
        @ProcedimentoPadrao  INT 

SELECT @AddDias = QuantidadeDiasAposVencidoAplicarProcedimentoAtraso,
       @ProcedimentoPadrao = IdProcedimentoAtrasoPadrao
FROM   ' + @DBMainName + 
	    '.dbo.regionais
WHERE  NomeDB = DB_NAME()  
	   
SELECT ' + @sqlSelectCaseDividaAtiva + 
	    ',
       IdDebito,
       Debitos.IdTipoDebito,
       TiposDebito.SiglaDebito,
       YEAR(Debitos.DataReferencia) AS AnoRef,
       NumeroParcela,
       Moedas.Moeda,
       Debitos.TpEmissaoConjunta,
       Debitos.NumConjEmissao,
       CASE 
            WHEN (ISNULL(Debitos.ValorPago, 0) > 0) AND (Debitos.IdSituacaoAtual IN (3, 15)) THEN 
                 dbo.Calc_PagoMenor(Debitos.IdDebito, 1)
            ELSE CASE 
                      WHEN Debitos.IdMoeda = 2 THEN DBO.Calc_Ufir(
                               Debitos.ValorDevido,
                               DATEADD(DAY, @AddDias, Debitos.DataVencimento),
                               CASE 
                                    WHEN Debitos.DataPgto IS NULL THEN GETDATE()
                                    ELSE Debitos.DataPgto
                               END,
                               Debitos.IdMoeda
                           )
                      WHEN Debitos.IdMoeda = 3 THEN DBO.Calc_URH(
                               Debitos.ValorDevido,
                               CASE 
                                    WHEN Debitos.DataPgto IS NULL THEN GETDATE()
                                    ELSE Debitos.DataPgto
                               END,
                               Debitos.IdMoeda
                           )
                      ELSE Debitos.ValorDevido
                 END
       END AS ValorDevido,
       NumConjTpDebito,
       NumConjReneg,'
	    +
	    @sqlUtilizarOpcoesDescontoMensagensInstrucao
	    +
	    '       ISNULL(
           dbo.AtualizaDebitos(
               DATEADD(DAY, @AddDias, Debitos.DataVencimento),
               CONVERT(VARCHAR(10), ' + @data + 
	    ', 112),
               Debitos.ValorDevido,
               1,
               Debitos.IdTipoDebito,
               Debitos.IdMoeda,
               @ProcedimentoPadrao,
               3,
               Debitos.IdDebito,
               CASE 
                    WHEN ValorPago > 0 THEN 3
                    ELSE Debitos.IdSituacaoAtual
               END
           ),
           0
       ) AS Atualizacao,
       ISNULL(
           dbo.AtualizaDebitos(
               DATEADD(DAY, @AddDias, Debitos.DataVencimento),
               CONVERT(VARCHAR(10), ' + @data + 
	    ', 112),
               Debitos.ValorDevido,
               1,
               Debitos.IdTipoDebito,
               Debitos.IdMoeda,
               @ProcedimentoPadrao,
               1,
               Debitos.IdDebito,
               CASE 
                    WHEN ValorPago > 0 THEN 3
                    ELSE Debitos.IdSituacaoAtual
               END
           ),
           0
       ) AS Multa,
       ISNULL(
           dbo.AtualizaDebitos(
               DATEADD(DAY, @AddDias, Debitos.DataVencimento),
               CONVERT(VARCHAR(10), ' + @data + 
	    ', 112),
               Debitos.ValorDevido,
               1,
               Debitos.IdTipoDebito,
               Debitos.IdMoeda,
               @ProcedimentoPadrao,
               2,
               Debitos.IdDebito,
               CASE 
                    WHEN ValorPago > 0 THEN 3
                    ELSE Debitos.IdSituacaoAtual
               END
           ),
           0
       ) AS Juros,
       ISNULL(
           dbo.AtualizaDebitos(
               DATEADD(DAY, @AddDias, Debitos.DataVencimento),
               CONVERT(VARCHAR(10), ' + @data + 
	    ', 112),
               Debitos.ValorDevido,
               1,
               Debitos.IdTipoDebito,
               Debitos.IdMoeda,
               @ProcedimentoPadrao,
               0,
               Debitos.IdDebito,
               CASE 
                    WHEN ValorPago > 0 THEN 3
                    ELSE Debitos.IdSituacaoAtual
               END
           ),
           0
       ) AS ValorTotal,
       CASE 
            WHEN DATEADD(DAY, @AddDias, Debitos.DataVencimento) >= CONVERT(VARCHAR(10), '
	    + @data + 
	    ', 112) THEN 
                 0
            ELSE ISNULL(
                     dbo.AtualizaDebitos(
                         DATEADD(DAY, @AddDias, Debitos.DataVencimento),
                         CONVERT(VARCHAR(10), ' + @data + 
	    ', 112),
                         Debitos.ValorDevido,
                         1,
                         Debitos.IdTipoDebito,
                         Debitos.IdMoeda,
                         @ProcedimentoPadrao,
                         5,
                         Debitos.IdDebito,
                         CASE 
                              WHEN ValorPago > 0 THEN 3
                              ELSE Debitos.IdSituacaoAtual
                         END
                     ),
                     0
                 )
       END AS CodErro,
       CASE             
            WHEN EXISTS(
                     SELECT  top 1 1
                     FROM    ParametrosSiscafweb
                     WHERE  RenegociarAnoCorrente = 0
                 ) 
                 AND (YEAR(debitos.DataReferencia) = YEAR(GETDATE())) THEN 0
            WHEN YEAR(debitos.DataReferencia) < (
                     YEAR(GETDATE()) -(
                         SELECT top 1 RenegociarAnoCorrenteMenor
                         FROM   ParametrosSiscafweb
                     )
                 ) THEN 0
            WHEN (Debitos.IdTipoDebito = 2) THEN 0
            ELSE ISNULL(
                     (
                         SELECT permite
                         FROM   Param_Ren_Debitos
                         WHERE  Param_Ren_Debitos.IdTipoDebito = Debitos.IdTipoDebito
                     ),
                     1
                 )
       END AS Renegociar,
       Debitos.IdSituacaoAtual,
       SituacoesDebito.SituacaoDebito,
       Debitos.TipoDividaAtiva,
       Debitos.IdConfigGeracaoDebito 
       INTO #Debitos
FROM   Debitos
       INNER JOIN TiposDebito
            ON  TiposDebito.IdTipoDebito = Debitos.IdTipoDebito
       INNER JOIN Moedas
            ON  Moedas.IdMoeda = Debitos.IdMoeda
       LEFT JOIN SituacoesDebito
            ON  Debitos.IdSituacaoAtual = SituacoesDebito.IdSituacaoDebito '
	
	SET @sqlWhere = ' WHERE  Debitos.IdProfissional = ' + @idProf + 
	    '
       AND Debitos.IdSituacaoAtual IN (1, 3, 10, 15) ' + @Complemento + @criterios 
	    + @Filtro + 
	    '
       AND ISNULL(
               dbo.AtualizaDebitos(
                   DATEADD(DAY, @AddDias, Debitos.DataVencimento),
                   CONVERT(VARCHAR(10), ' + @data + 
	    ', 112),
                   Debitos.ValorDevido,
                   1,
                   Debitos.IdTipoDebito,
                   Debitos.IdMoeda,
                   @ProcedimentoPadrao,
                   0,
                   Debitos.IdDebito,
                   CASE 
                        WHEN ValorPago > 0 THEN 3
                        ELSE Debitos.IdSituacaoAtual
                   END
               ),
               0
           ) > 0 
           ' + @sqlDivAtiva + @sqlAuxiliar
	
	SET @sqlOrderBy = 
	    ' ORDER BY
       Debitos.DataReferencia DESC,
       TiposDebito.SiglaDebito DESC,
       Debitos.NumConjReneg DESC,
       Debitos.NumeroParcela,
       Debitos.DataVencimento ASC  '
	
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
	
	
	PRINT @sql 
	PRINT @sqlWhere 
	PRINT @sqlOrderBy 
	PRINT @sqlDeleteDivAtiva 
	PRINT @sqlFromTemporaria
	
	
	EXEC (
	         @sql + @sqlWhere + @sqlOrderBy + @sqlDeleteDivAtiva + @sqlFromTemporaria
	     )
END
