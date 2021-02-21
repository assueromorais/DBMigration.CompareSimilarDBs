	
-- ============================================================================
--	sp_ExibeListaDebitosWeb
-- ============================================================================	
CREATE PROCEDURE [dbo].[Sp_ExibeListaDebitosWeb]
	@data VARCHAR(10),
	@idsDebitos VARCHAR(1000),
	@exbDebDivAtivaAdm INT = 1,
	@exbDebDivAtivaExec INT = 1,
	@DBMainName VARCHAR(100) = 'siscafweb_java',
	@utilizarOpcoesDescontoMensagensInstrucao BIT = 1,
	@sqlAuxiliar VARCHAR(1000) = ''
AS
BEGIN
	DECLARE @sql                                          VARCHAR(5000),
			@sqlutilizarOpcoesDescontoMensagensInstrucao  VARCHAR(1000),
			@sqlDivAtiva                                  VARCHAR(200)   
	
	
	SET @sqlDivAtiva = ' '
	
	IF (@exbDebDivAtivaAdm = 0 AND @exbDebDivAtivaExec = 0)
	BEGIN
		SET @sqlDivAtiva = 
			' AND (Debitos.TipoDividaAtiva IS NULL or Debitos.TipoDividaAtiva = '''' ) '
	END
	ELSE 
	IF (@exbDebDivAtivaAdm = 0)
	BEGIN
		SET @sqlDivAtiva = 
			' AND (Debitos.TipoDividaAtiva <> 1 OR Debitos.TipoDividaAtiva IS NULL OR  Debitos.TipoDividaAtiva = '''' ) '
	END
	ELSE 
	IF (@exbDebDivAtivaExec = 0)
	BEGIN
		SET @sqlDivAtiva = 
			' AND (Debitos.TipoDividaAtiva <> 2 OR Debitos.TipoDividaAtiva IS NULL OR  Debitos.TipoDividaAtiva = '''' ) '
	END	
	
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
	
	SET @sql = 
		'
 DECLARE @AddDias             INT,
@ProcedimentoPadrao  INT 

SELECT @AddDias = QuantidadeDiasAposVencidoAplicarProcedimentoAtraso,
   @ProcedimentoPadrao = IdProcedimentoAtrasoPadrao
FROM   ' + @DBMainName + 
		    '.dbo.regionais
WHERE  NomeDB = DB_NAME()  

    
    SELECT CASE WHEN Debitos.TipoDividaAtiva IS NOT NULL AND Debitos.TipoDividaAtiva <> ''''  THEN 
    (SELECT max(IdDividaAtiva) FROM DebitosDividaAtiva dda WHERE dda.IdDebito = Debitos.iddebito)
	ELSE NULL
	END AS IdDividaAtiva ,IdDebito, Debitos.IdTipoDebito, TiposDebito.SiglaDebito, YEAR(Debitos.DataReferencia) AS AnoRef, NumeroParcela, 
	Moedas.Moeda, ' +
		    'convert(varchar(12), Debitos.ValorDevido) AS ValorDevido, NumConjTpDebito, TpEmissaoConjunta, NumConjEmissao, NumConjReneg, '
		    +
		    @sqlUtilizarOpcoesDescontoMensagensInstrucao
		    +
		    'ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, CONVERT( VARCHAR(10), '
		    +
		    @data 
		    +
		    ' ,112 ), Debitos.ValorDevido, 1, Debitos.IdTipoDebito, Debitos.IdMoeda, @ProcedimentoPadrao, 3, Debitos.IdDebito , CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END), 0) AS Atualizacao, '
		    +
		    'ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, CONVERT( VARCHAR(10), '
		    +
		    @data 
		    +
		    ' ,112 ), Debitos.ValorDevido, 1, Debitos.IdTipoDebito, Debitos.IdMoeda, @ProcedimentoPadrao, 1, Debitos.IdDebito , CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END), 0) AS Multa, '
		    +
		    'ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, CONVERT( VARCHAR(10), '
		    +
		    @data 
		    +
		    ' ,112 ), Debitos.ValorDevido, 1, Debitos.IdTipoDebito, Debitos.IdMoeda, @ProcedimentoPadrao, 2, Debitos.IdDebito , CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END), 0) AS Juros, '
		    +
		    'ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, CONVERT( VARCHAR(10), '
		    +
		    @data 
		    +
		    ' ,112 ), Debitos.ValorDevido, 1, Debitos.IdTipoDebito, Debitos.IdMoeda, @ProcedimentoPadrao, 0, Debitos.IdDebito , CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END), 0) AS ValorTotal, '
		    +
		    'ISNULL( dbo.AtualizaDebitos( Debitos.DataVencimento, CONVERT( VARCHAR(10), '
		    +
		    @data 
		    +
		    ' ,112 ), Debitos.ValorDevido, 1, Debitos.IdTipoDebito, Debitos.IdMoeda, @ProcedimentoPadrao, 5, Debitos.IdDebito , CASE WHEN ValorPago > 0 THEN 3 ELSE Debitos.IdSituacaoAtual END), 0) AS CodErro, '
		    +
		    'CASE '
		    +
		    ' WHEN ( Debitos.DataVencimento > GETDATE() ) THEN 0 '
		    +
		    ' WHEN EXISTS(SELECT 1 FROM ParametrosSiscafweb WHERE RenegociarAnoCorrente = 0 ) '
		    +
		    '  AND (YEAR(debitos.DataReferencia) = YEAR(GETDATE()) ) THEN 0 '
		    +
		    ' WHEN YEAR(debitos.DataReferencia) < ( YEAR(GETDATE()) - (SELECT TOP 1 RenegociarAnoCorrenteMenor FROM ParametrosSiscafweb ) ) THEN 0 '
		    +
		    ' WHEN ( Debitos.IdTipoDebito = 2 OR Debitos.IdTipoDebito = 10 ) THEN 0 '
		    +
		    'ELSE ISNULL( (SELECT permite FROM Param_Ren_Debitos WHERE Param_Ren_Debitos.IdTipoDebito = Debitos.IdTipoDebito  ),1) '
		    +
		    'END AS Renegociar, Debitos.IdSituacaoAtual, SituacoesDebito.SituacaoDebito, Debitos.TipoDividaAtiva, Debitos.IdConfigGeracaoDebito  '
		    +
		    'FROM Debitos '
		    +
		    'INNER JOIN TiposDebito ON TiposDebito.IdTipoDebito = Debitos.IdTipoDebito '
		    +
		    'INNER JOIN MoedAS ON MoedAS.IdMoeda = Debitos.IdMoeda '
		    +
		    'LEFT JOIN SituacoesDebito ON Debitos.IdSituacaoAtual = SituacoesDebito.IdSituacaoDebito '
		    +
		    'WHERE Debitos.IdDebito IN ('
		    +
		    @idsDebitos 
		    +
		    ') ' + @sqlDivAtiva + @sqlAuxiliar
		    +
		    'ORDER BY  ' 
		    +
		    ' Debitos.DataReferencia Desc,  ' 
		    +
		    ' TiposDebito.SiglaDebito Desc,  ' 
		    +
		    ' Debitos.NumeroParcela,  ' 
		    +
		    ' Debitos.DataVencimento ASC' 
		
		--PRINT @sql    
		EXEC (@sql)
		
END
