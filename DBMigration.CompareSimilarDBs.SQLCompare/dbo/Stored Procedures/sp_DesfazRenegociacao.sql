/* OC. 239364
* Criado por Gustavo
*/

CREATE PROCEDURE [dbo].[sp_DesfazRenegociacao] @TextoSQL varchar (8000) 
/* Oc 41576 - Italo*/
/* Oc 40551 - Mundin */
/* Oc 40541 - AntonioA */
/* Oc 40790 - Seila */
/* Oc 41788 - Seila 26-12-2008*/
/* Oc 43259 - Seila 20-01-2009*/
/* Oc 49865 - Gustavo*/
/* Oc 51160 - PauloR */
/* Oc 55059 - Robério */
/* Oc 70509 - Robério */
/* Oc 78579 - Gustavo - 25/07/2011*/
/* Oc 86574 - Gustavo - 03/02/2012 */
/* Oc 97424 - Gustavo - 05/09/2012 */
/* Oc 239364- Gustavo - 27/02/2020 */

AS


SET NOCOUNT ON


/*
declare @TextoSQL varchar (8000)
SELECT @TextoSQL = 'select 16972, 1 , 1, 1 , ''OK'''

*/

DECLARE @teste INT

SELECT @teste = 0


IF @teste = 1
	BEGIN TRAN

/*Oc132475 - Garante a transação*/
SET XACT_ABORT ON


/*Declarações de variáveis*/
DECLARE
	
  /* Decimal */
  @ValorPago                   Decimal(20,2),
  @ValorDevido                 Decimal(20,2),
  @ValorEsperado               Decimal(20,2),
  @ValorOrig                   Decimal(20,2),
  @ValorPagoParc               Decimal(20,2),
  @ValorPagoOrig               Decimal(20,2),
  @FValorPrincipal             Decimal(20,2),
  @FValorDevidoOrigem          Decimal(20,2),
  @FValorJuros                 Decimal(20,2),
  @FValorMulta                 Decimal(20,2),
  @FValorAtualizado            Decimal(20,2),
  @FValorPgPrincipal           Decimal(20,2),
  @FValorPgJuros               Decimal(20,2),
  @FValorPgMulta               Decimal(20,2),
  @FValorPgAtualizado          Decimal(20,2),
  @FValorTotal                 Decimal(20,2),
  @FTotalPago                  Decimal(20,2),
  @MRPercent                   Decimal(20,2),
  @MRValor                     Decimal(20,2),
  @MRDif                       Decimal(20,2),
  @PercentualRepasse           Decimal(20,2),
  @ValorPagoPrincipal          Decimal(20,2),
  @ValorPagoAtualizacao        Decimal(20,2),
  @ValorPagoMulta              Decimal(20,2),
  @ValorPagoJuros              Decimal(20,2),
  @ValorPagoDespBco            Decimal(20,2),
  @ValorPagoDespAdv            Decimal(20,2),
  @ValorPagoDespPostais        Decimal(20,2),
  @ValorPagoDAPrincipal        Decimal(20,2),
  @ValorPagoDAAtualizacao      Decimal(20,2),
  @ValorPagoDAMulta            Decimal(20,2),
  @ValorPagoDAJuros            Decimal(20,2),
  @ValorPagoDADespBco          Decimal(20,2),
  @ValorPagoDADespAdv          Decimal(20,2),
  @ValorPagoDADespPostais      Decimal(20,2),
  @ValorEsperadoPrincipal      Decimal(20,2),
  @ValorEsperadoAtualizacao    Decimal(20,2),
  @ValorEsperadoMulta          Decimal(20,2),
  @ValorEsperadoJuros          Decimal(20,2),
  @ValorEsperadoDespBco        Decimal(20,2),
  @ValorEsperadoDespAdv        Decimal(20,2),
  @ValorEsperadoDespPostais    Decimal(20,2),
  @ValorEsperadoDAPrincipal    Decimal(20,2),
  @ValorEsperadoDAAtualizacao  Decimal(20,2),
  @ValorEsperadoDAMulta        Decimal(20,2),
  @ValorEsperadoDAJuros        Decimal(20,2),
  @ValorEsperadoDADespBco      Decimal(20,2),
  @ValorEsperadoDADespAdv      Decimal(20,2),
  @ValorEsperadoDADespPostais  Decimal(20,2),
  @TotalEsperadoMulta          Decimal(20,2),
  @TotalEsperadoJuros          Decimal(20,2),
  @TotalEsperadoAtualizacao    Decimal(20,2),
  @TotalPagoMulta              Decimal(20,2),
  @TotalPagoJuros              Decimal(20,2),
  @TotalPagoAtualizacao        Decimal(20,2),
  @TmpMulta                    Decimal(20,2),
  @TmpJuros                    Decimal(20,2),
  @TmpAtualizacao              Decimal(20,2),
  @AcrescentarPgto             Decimal(20,2),
  @FValorPgDespesas            Decimal(20,2),
  @FValorDespesas              Decimal(20,2), /*dm41788*/
  
  /* Int */
  @IdDebitoOrig                Int,
  @IdMoedaOrig                 Int,
  @IdTpDebito                  Int,
  @IdSituacaoAtual             Int,
  @IdDebitoDest                Int,
  @IdRenegociacao              Int,
  @IdRecobranca                Int,
  @IdProfissional              Int,
  @NumConjRen          Int,
  @lFisica                     Int,
  @IdSituacao                  Int,
  @IdTipoPagamento             Int,
  @IdOrigTmp                   Int,
  @idComp                      Int,
  @Id                          Int,
  @IdTmpDesfazer               Int,
  @IdOrig                      Int,
  @IdDest                      Int,
  @NovaSituacao                Int,
  @NumConjParcelasRen          INT,

  /* Datetime */
  @DataVcto                    Datetime,
  @DataPgtoParc                Datetime,
  @DataPgtoOrig                Datetime,
  @DataCredito                 Datetime,

  /* Bit */
  @Desfazer                    Bit,

  /* Varchar */
  @Usuario                     Varchar(50),
  @Departamento                Varchar(60),   
  @ProfPJ                      Varchar(20),
  @FDataAtual                  Varchar(10),
  @Parcela                     Varchar(20),
  @CodBanco                    Varchar(3),
  @CodAgencia                  Varchar(4),
  @CodOperacao                 Varchar(3),
  @CodCC_Conv_Ced              Varchar(16),
  @NumConjEmissao INT, @TpEmissaoConjunta INT  
/*********************************************************/

/**** Criação de Tabelas Temporárias *********************/

CREATE TABLE #TblTmp (IdOrigem Int)

CREATE TABLE #TblComp (IdComposicaoDebito Int,
                       ValorAcrescentar   Money,
                       Atualizacao        Money,
                       Multa              Money,
                       Juros              Money)

CREATE TABLE #tmpDesfazer (Id             Int IDENTITY(1,1),
                           IdProfissional Int,
                           NumConjRen     Int,
                           Ok             Bit,
                           Fisica         Int,
                           Causa          Varchar(30) COLLATE database_default)

CREATE TABLE #tblOrigens  (Id                 Int IDENTITY(1,1),
                           IdDebito           Int,
                           IdMoeda            Int,
                           ValorDevido        Money,
                           DataVencimento     Datetime,
                           IdTipoDebito       Int,
                           IdSituacaoAtual    Int,
                           ValorPago          Money,
                           DataPgto           Datetime,
                           IdTipoPagamento    Int,
                           DataCredito        Datetime,
                           ValorPrincipal     Money,
                           ValorAtualizacao   Money,
                           ValorMulta         Money,
                           ValorJuros         Money,
                           ValorPgPrincipal   Money,
                           ValorPgAtualizacao Money,
                           ValorPgMulta       Money,
                           ValorPgJuros       Money,
                           ValorTotal         Money,
                           TotalPago          Money,
                           DataAtual          Varchar(10) COLLATE database_default,
                           Parcela            Varchar(20) COLLATE database_default,
                           Obs                Varchar(4000) COLLATE database_default,
                           ValorDevidoOrigem  Money,
                           NumConjReneg       Int,
                           NumeroRenegociacao Varchar(50) COLLATE database_default,
                           UsuarioRen         Varchar(50) COLLATE database_default,
                           DepartamentoRen    Varchar(50) COLLATE database_default,
                           ValorPagoOrigem    Money)

CREATE TABLE #tblDestino  (Id                 Int IDENTITY(1,1),
                           IdDebito           Int,
                           ValorPago          Money,
                           DataPgto           Datetime,
                           IdTipoPagamento    Int,
              DataCredito        Datetime,
                           Obs                Varchar(4000) COLLATE database_default,
                           NumConjReneg       Int,
                           NumeroRenegociacao Varchar(50) COLLATE database_default,
                           UsuarioRen         Varchar(50) COLLATE database_default,
                           DepartamentoRen    Varchar(50) COLLATE database_default,
                           PercentualRepasse  Money,
                           CodBanco           Varchar(3),
                           CodAgencia         Varchar(4),
                           CodOperacao        Varchar(3),
                           CodCC_Conv_Ced     Varchar(16))

CREATE TABLE #tblComposicoes  (Id                         Int IDENTITY(1,1),
                               IdDebito                   Int,
                               IdProcedimentoAtraso       Int,
                               ValorEsperadoPrincipal     Money,
                               IdMoedaValorEsperado       Int,
                               ValorEsperadoAtualizacao   Money,
                               ValorEsperadoMulta         Money,
                               ValorEsperadoJuros         Money,
                               ValorEsperadoDespBco       Money,
                               ValorEsperadoDespAdv       Money,
                               ValorEsperadoDespPostais   Money,
                               ValorPagoPrincipal         Money,
                               ValorPagoAtualizacao       Money,
                               ValorPagoMulta             Money,
                               ValorPagoJuros             Money,
                               ValorPagoDespBco           Money,
                               ValorPagoDespAdv           Money,
                               ValorPagoDespPostais       Money,
                               IdDebitoOrigemRen          Int,
                               ValorEsperadoDAPrincipal   Money,
                               ValorEsperadoDAAtualizacao Money,
                               ValorEsperadoDAMulta       Money,
                               ValorEsperadoDAJuros       Money,
                               ValorEsperadoDADespBco     Money,
                               ValorEsperadoDADespAdv     Money,
                               ValorEsperadoDADespPostais Money,
                               ValorPagoDAPrincipal       Money,
                               ValorPagoDAAtualizacao     Money,
                               ValorPagoDAMulta           Money,
                               ValorPagoDAJuros           Money,
                               ValorPagoDADespBco         Money,
                               ValorPagoDADespAdv         Money,
                               ValorPagoDADespPostais     Money,
                               RegistraLog                Int)

CREATE TABLE #tblDebitos_SituacoesDebito (Id                Int IDENTITY(1,1),
                                          IdDebito          Int,
                                          IdSituacaoDebito  Int,
                                          DataSituacao      Datetime)
/**********************************************************************/  


CREATE TABLE #tmp (id INT IDENTITY(1,1), IdComposicao INT, IdOrigem INT,  ValorPrincipal NUMERIC(10,2))
DECLARE @idtmp INT, @SomaPrincipalOrigem Decimal(20,2), @ValorPrincipal NUMERIC(10,2), @idOrigem INT,  @SomaEncargos Decimal(20,2), @IdComposicao INT, @Distribuir_em char(1)
DECLARE @EncargosAtu DECIMAL(10,2), @EncargosMulta DECIMAL(10,2), @EncargosJuros DECIMAL(10,2) 




SELECT @IdRenegociacao = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Renegociação'
SELECT @IdRecobranca   = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Recobrança'

SELECT @MRPercent      = ISNULL(ValorMargemRecebPercentual, 0), 
       @MRValor        = ISNULL(ValorMargemReceb, 0) FROM ParametrosSiscafW

INSERT INTO #tmpDesfazer EXEC( @TextoSQl )


SELECT TOP 1 @lFisica = t.Fisica  FROM #tmpDesfazer t
SET @usuario = HOST_NAME();

SET @Departamento =(SELECT ISNULL(d.NomeDepto,'')
                      FROM Departamentos d WHERE d.IdDepto = (SELECT top 1 u.IdDepartamento
                                                                FROM Usuarios u WHERE u.NomeUsuario = @usuario))
	 
/*1ª Interação*/
SELECT @IdTmpDesfazer = min(t.Id) FROM #tmpDesfazer t

WHILE @IdTmpDesfazer IS NOT NULL
BEGIN
    SELECT @IdProfissional = t.IdProfissional, 
           @NumConjRen     = t.NumConjRen, 
           @lFisica        = t.Fisica
    FROM   #tmpDesfazer t
    WHERE  t.Id = @IdTmpDesfazer
    
    IF @lFisica = 1
    BEGIN
        INSERT INTO #tblOrigens(IdDebito,			
								IdMoeda,			
								ValorDevido,		
								DataVencimento,			
								IdTipoDebito, 
                                IdSituacaoAtual,	
                                ValorPago,		
                                DataPgto,			
                                IdTipoPagamento,		
                                DataCredito, 
                                Obs,			
                                NumConjReneg,		
                                NumeroRenegociacao,		
                                UsuarioRen,		
                                DepartamentoRen,
                                ValorDevidoOrigem,  
                                ValorPagoOrigem)                                
						 SELECT IdDebito,			
								IdMoeda,		
								ValorDevido,		
								DataVencimento,			
								IdTipoDebito,
								IdSituacaoAtual,	
								ValorPago,		
								DataPgto,			
								IdTipoPagamento,		
								DataCredito,
								ObsDebito,		
								NumConjReneg,		
								NumeroRenegociacao,		
								UsuarioRen,
								DepartamentoRen,
								ValorDevidoOrigem = (SELECT dbo.AtualizaDebitos(DataVencimento,
																				DataPgto, 
																				ValorDevido, 
																				@lFisica, 
																				IdTipoDebito, 
																				IdMoeda, 0, 0, 0, 0 ) 
								                       FROM Debitos d1  
								                      WHERE d1.IdDebito = Debitos.IdDebito),
								isnull(CASE  WHEN ValorPago > 0 THEN valorDevido -	dbo.Calc_PagoMenor(IdDebito, 1) END  ,0) 
						   FROM Debitos 
						  WHERE	IdProfissional = @IdProfissional 
						    AND	NumConjReneg   = @NumConjRen 
						    AND	IdSituacaoAtual IN (6, 14) 
					   ORDER BY NumConjReneg, DataReferencia, NumeroParcela /* APMF - oc 40551*/
        
        INSERT INTO #tblDestino	(IdDebito,
								 ValorPago, 
								 DataPgto, 
								 IdTipoPagamento, 
								 DataCredito, 
								 Obs, 
								 NumConjReneg, 
								 NumeroRenegociacao, 
								 UsuarioRen, 
								 DepartamentoRen,
								 PercentualRepasse, 
								 CodBanco, 
								 CodAgencia, 
								 CodOperacao, 
								 CodCC_Conv_Ced)								 
						  SELECT IdDebito,
						         ValorPago,
						         DataPgto,
						         IdTipoPagamento,
						         DataCredito,
						         ObsDebito,
						         NumConjReneg,
						         NumeroRenegociacao,
						         UsuarioRen,
						         DepartamentoRen,
						         PercentualRepasse,
						         CodBanco,
						         CodAgencia,
						         CodOperacao,
						         CodCC_Conv_Ced 
						    FROM Debitos 
						   WHERE IdProfissional = @IdProfissional 
						     AND NumConjReneg   = @NumConjRen 
						     AND IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) 
						ORDER BY NumConjReneg, DataReferencia, NumeroParcela
						  
    END
    ELSE IF @lFisica = 0
    BEGIN
	    INSERT INTO #tblOrigens(IdDebito, 
	                            IdMoeda, 
	                            ValorDevido, 
	                            DataVencimento, 
	                            IdTipoDebito, 
	                            IdSituacaoAtual, 
	                            ValorPago, 
	                            DataPgto,
	                            IdTipoPagamento, 
	                            DataCredito, 
	                            Obs,
	                            ValorDevidoOrigem,
	                            NumConjReneg,
	                            NumeroRenegociacao,
	                            UsuarioRen,
	                            DepartamentoRen)      
		                 SELECT IdDebito,
								IdMoeda,
								ValorDevido,
								DataVencimento,
								IdTipoDebito,
								IdSituacaoAtual,
								ValorPago,
								DataPgto,
								IdTipoPagamento,
								DataCredito,
								ObsDebito,
								ValorDevidoOrigem = (SELECT dbo.AtualizaDebitos(DataVencimento, 
																				DataPgto, 
																				ValorDevido, 
																				@lFisica, 
																				IdTipoDebito, 
																				IdMoeda, 0, 0, 0, 0 ) 
								                       FROM Debitos d1 
								                      WHERE d1.IdDebito = Debitos.IdDebito),
								NumConjReneg,
								NumeroRenegociacao,
								UsuarioRen,
								DepartamentoRen	
		                   FROM Debitos 
		                  WHERE IdPessoaJuridica = @IdProfissional	  
		                    AND NumConjReneg     = @NumConjRen  
		                    AND IdSituacaoAtual IN (6, 14)	
		               ORDER BY NumConjReneg, DataReferencia, NumeroParcela /* APMF - oc 40551*/
        
        INSERT INTO #tblDestino	(IdDebito, 
								 ValorPago, 
								 DataPgto, 
								 IdTipoPagamento, 
								 DataCredito, 
								 Obs, 
								 NumConjReneg, 
								 NumeroRenegociacao, 
								 UsuarioRen, 
								 DepartamentoRen,
								 PercentualRepasse, 
								 CodBanco, 
								 CodAgencia, 
								 CodOperacao, 
								 CodCC_Conv_Ced)
						  SELECT IdDebito,
								 ValorPago, 
								 DataPgto, 
								 IdTipoPagamento, 
								 DataCredito, 
								 ObsDebito, 
								 NumConjReneg, 
								 NumeroRenegociacao, 
								 UsuarioRen, 
								 DepartamentoRen, 
								 PercentualRepasse, 
								 CodBanco, 
								 CodAgencia, 
								 CodOperacao, 
								 CodCC_Conv_Ced 
						    FROM Debitos 
						   WHERE IdPessoaJuridica = @IdProfissional  
						     AND NumConjReneg     = @NumConjRen  
						     AND IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*DM40790-COMENTADO AND  ValorPago > 0 */ 
						ORDER BY NumConjReneg,DataReferencia,NumeroParcela
    END
    ELSE IF @lFisica = 2
    BEGIN
		INSERT INTO #tblOrigens(IdDebito, 
								IdMoeda, 
								ValorDevido, 
								DataVencimento, 
								IdTipoDebito, 
								IdSituacaoAtual, 
								ValorPago, 
								DataPgto, 
								IdTipoPagamento, 
								DataCredito, 
								Obs,
								ValorDevidoOrigem,
								NumConjReneg,
								NumeroRenegociacao,
								UsuarioRen,
								DepartamentoRen)
						 SELECT IdDebito,
								IdMoeda,
								ValorDevido,
								DataVencimento,
								IdTipoDebito,
								IdSituacaoAtual,
								ValorPago,
								DataPgto,
								IdTipoPagamento,
								DataCredito,
								ObsDebito,
								ValorDevidoOrigem = (SELECT dbo.AtualizaDebitos(DataVencimento, 
																				DataPgto, 
																				ValorDevido, 
																				@lFisica, 
																				IdTipoDebito, 
																				IdMoeda, 0, 0, 0, 0 )
													   FROM Debitos d1
								                      WHERE d1.IdDebito = Debitos.IdDebito),
								NumConjReneg,
								NumeroRenegociacao,
								UsuarioRen,
								DepartamentoRen 
						   FROM Debitos 
						  WHERE IdPessoa     = @IdProfissional  
						    AND NumConjReneg = @NumConjRen  
						    AND IdSituacaoAtual IN (6, 14)	
					   ORDER BY NumConjReneg, DataReferencia, NumeroParcela /*APMF - oc 40551*/
        
    INSERT INTO #tblDestino	(IdDebito,
								 ValorPago,
								 DataPgto,
								 IdTipoPagamento,
								 DataCredito,
								 Obs,
								 NumConjReneg,
								 NumeroRenegociacao,
								 UsuarioRen,
								 DepartamentoRen,
								 PercentualRepasse,
								 CodBanco,
								 CodAgencia,
								 CodOperacao,
								 CodCC_Conv_Ced)
						  SELECT IdDebito,
								 ValorPago,
								 DataPgto,
								 IdTipoPagamento,
								 DataCredito,
								 ObsDebito,
								 NumConjReneg,
								 NumeroRenegociacao,
								 UsuarioRen,
								 DepartamentoRen,
								 PercentualRepasse,
								 CodBanco,
								 CodAgencia,
								 CodOperacao,
								 CodCC_Conv_Ced  
						    FROM Debitos   
						   WHERE IdPessoa     = @IdProfissional  
						     AND NumConjReneg = @NumConjRen  
						     AND IdTipoDebito IN (@IdRenegociacao, @IdRecobranca)  /*DM40790-COMENTADO AND  ValorPago > 0 */  
						ORDER BY NumConjReneg, DataReferencia, NumeroParcela
	END

	UPDATE t
	   SET t.ValorTotal = isnull(t.ValorPrincipal  + t.ValorAtualizacao   + t.ValorMulta   + t.ValorJuros,  0),
		   t.TotalPago  = isnull(t.ValorPgPrincipal+ t.ValorPgAtualizacao + t.ValorPgMulta + t.ValorPgJuros,0)
	  FROM #tblOrigens t 

	SELECT @Desfazer = 0, 
	       @ProfPJ   = CASE @lFisica 
							WHEN 1 THEN 'IdProfissional' 
	                        WHEN 0 THEN 'IdPessoaJuridica' 
	                        ELSE 'IdPessoa' 
	                   END 
    
    /* iteração nas origens */
    SELECT @IdOrig = min(t.Id) FROM #tblOrigens t
	WHILE @IdOrig IS NOT NULL 
	BEGIN
		SET @Desfazer = 1
		
		SELECT @IdDebitoOrig       = t.IdDebito, 
		       @IdMoedaOrig        = t.IdMoeda, 
		       @ValorOrig          = t.ValorDevido, 
		       @DataVcto           = t.DataVencimento,
		       @IdTpDebito         = t.IdTipoDebito, 
		       @IdSituacaoAtual    = t.IdSituacaoAtual, 
		       @ValorPagoOrig      = t.ValorPago, 
		       @DataPgtoOrig       = t.DataPgto, 
		       @FValorPrincipal    = t.ValorPrincipal, 
		       @FValorAtualizado   = t.ValorAtualizacao, 
		       @FValorMulta        = t.ValorMulta, 
		       @FValorJuros        = t.ValorJuros, 
		       @FValorPgPrincipal  = t.ValorPgPrincipal, 
		       @FValorPgAtualizado = t.ValorPgAtualizacao, 
		       @FValorPgMulta      = t.ValorPgMulta, 
		       @FValorPgJuros      = t.ValorPgJuros, 
		       @FValorTotal        = t.ValorTotal, 
		       @FTotalPago         = t.TotalPago, 
		       @FDataAtual         = t.DataAtual, 
		       @Parcela            = t.Parcela, 
		       @FValorDevidoOrigem = t.ValorDevidoOrigem  
		  FROM #tblOrigens t 
		 WHERE t.Id = @IdOrig	
		 
		 /* Valor Esperado */ 	        
		SELECT @FValorPrincipal  = SUM(ISNULL(cd.ValorEsperadoPrincipal, 0)),
		       @FValorAtualizado = SUM(ISNULL(ValorEsperadoAtualizacao,  0)), 
		       @FValorMulta      = SUM(ISNULL(ValorEsperadoMulta,        0)), 
		       @FValorJuros      = SUM(ISNULL(ValorEsperadoJuros,        0)) /*DM41788INI*/, 
		       @FValorDespesas   = (SELECT SUM(ISNULL(cdx.ValorEsperadoDespBco,     0)) +
										   SUM(ISNULL(cdx.ValorEsperadoDespPostais, 0)) +
										   SUM(ISNULL(cdx.ValorEsperadoDespAdv,     0))
									  FROM ComposicoesDebito cdx
		                             WHERE cdx.IdDebito IN (SELECT cdx2.IdDebito
		                                                      FROM composicoesdebito cdx2 
																   INNER JOIN Debitos dbx ON dbx.IdDebito = cdx2.IdDebito
															 WHERE cdx2.IdDebitoOrigemRen = @IdDebitoOrig
		                                                       AND dbx.IdSituacaoAtual <> 9
															   AND dbx.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
		                                                       AND dbx.NumConjReneg = @NumConjRen)
									   AND (ISNULL(CDx.ValorEsperadoPrincipal, 0) + ISNULL(CDx.ValorDescontoPrincipal, 0)) = 0)
		  FROM ComposicoesDebito cd
		 WHERE cd.IdDebitoOrigemRen = @IdDebitoOrig
		   AND cd.IdDebito IN (SELECT d1.IdDebito
		                         FROM Debitos d1
		                        WHERE d1.IdDebito = cd.IdDebito
		                          AND d1.IdSituacaoAtual <> 9
		                          AND d1.IdDebito        <> cd.IdDebitoOrigemRen
                                  AND d1.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
                                  AND d1.NumConjReneg = @NumConjRen)
		   AND (ISNULL(cd.ValorEsperadoPrincipal, 0) + ISNULL(cd.ValorDescontoPrincipal, 0)) > 0 /*ITALO*/
		
		/* Valor Pago */
		SELECT @FValorPgPrincipal  = SUM(ISNULL(ValorPagoPrincipal,   0)), 
		       @FValorPgAtualizado = SUM(ISNULL(ValorPagoAtualizacao, 0)), 
		       @FValorPgMulta      = SUM(ISNULL(ValorPagoMulta,       0)), 
		       @FValorPgJuros      = SUM(ISNULL(ValorPagoJuros,       0)) /*DM41788INI*/, 
		       @FValorPgDespesas   = (SELECT SUM(ISNULL(cdx.ValorPagoDespBco,     0)) +
		                                     SUM(ISNULL(cdx.ValorPagoDespPostais, 0)) +
		                                     SUM(ISNULL(cdx.ValorPagoDespAdv,     0))
										FROM ComposicoesDebito cdx
								  	   WHERE cdx.IdDebito IN (SELECT cdx2.IdDebito
		                                                        FROM composicoesdebito cdx2 
																	 INNER JOIN Debitos dbx ON dbx.IdDebito = cdx2.IdDebito
															   WHERE cdx2.IdDebitoOrigemRen = @IdDebitoOrig
		                                                         AND dbx.IdSituacaoAtual <> 9
																 AND dbx.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
																 AND dbx.NumConjReneg = @NumConjRen)
		                                 AND (ISNULL(cdx.ValorEsperadoPrincipal, 0) + ISNULL(cdx.ValorDescontoPrincipal, 0)) = 0) /*DM41788FIM*/
		  FROM ComposicoesDebito cd
		 WHERE cd.IdDebitoOrigemRen = @IdDebitoOrig
		   AND cd.IdDebito IN (SELECT d1.IdDebito
		                         FROM Debitos d1
		                        WHERE d1.IdDebito = cd.IdDebito
		                          AND d1.ValorPago > 0
		                          AND d1.IdSituacaoAtual <> 9
		                          AND d1.IdDebito <> cd.IdDebitoOrigemRen
                                  AND d1.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
                                  AND d1.NumConjReneg = @NumConjRen)
		   AND (ISNULL(cd.ValorEsperadoPrincipal, 0) + ISNULL(cd.ValorDescontoPrincipal, 0)) > 0 /*ITALO*/ 
		   
		/*DM41788INI*/
		IF @IdOrig > 1
		BEGIN
			SET @FValorDespesas   = 0
			SET @FValorPgDespesas = 0
		END 
			
		SET @FValorTotal = ROUND(ISNULL(@FValorPrincipal,   0) + 
		                         ISNULL(@FValorMulta,       0) + 
		                         ISNULL(@FValorJuros,       0) + 
		                         ISNULL(@FValorAtualizado,  0) + 
		                         ISNULL(@FValorDespesas,    0), 2)
		                         
	    SET @FTotalPago  = ROUND(ISNULL(@FValorPgPrincipal, 0) + 
	                             ISNULL(@FValorPgMulta,     0) + 
	                             ISNULL(@FValorPgJuros,     0) + 
	                             ISNULL(@FValorPgAtualizado,0) + 
	                             ISNULL(@FValorPgDespesas,  0), 2)
        /*DM41788FIM*/

		SELECT TOP 1 @FDataAtual      = ISNULL(CONVERT(CHAR(10),  d1.DataPgto, 112), NULL), /*Oc 44107 Wesley*/
		             @Parcela         = RTRIM(CAST(NumeroParcela AS CHAR(2))) + '/' + CAST(DATEPART( YYYY, DataReferencia ) AS CHAR(4)), 
		             @IdTipoPagamento = CAST(d1.IdTipoPagamento AS INT), 
		             @DataCredito     = DataCredito 
		  FROM Debitos d1	
		 WHERE d1.IdDebito IN (SELECT cd.IdDebito 
		                         FROM ComposicoesDebito cd 
		                        WHERE cd.IdDebitoOrigemRen = @IdDebitoOrig) 
		   AND D1.NumConjReneg IS NOT NULL
		 ORDER BY d1.DataPgto DESC	 /* Oc 55059 - Robério */	
			 	
		IF @FTotalPago > 0 
		BEGIN	
			
			INSERT INTO #tblComposicoes
			SELECT @IdDebitoOrig, 
			       IdProcedimentoAtraso, 
			       SUM(ISNULL(ValorEsperadoPrincipal, 0)), 
			       IdMoedaValorEsperado, 
			       SUM(ISNULL(ValorEsperadoAtualizacao, 0)), 
			       SUM(ISNULL(ValorEsperadoMulta, 0)), 
			       SUM(ISNULL(ValorEsperadoJuros, 0)), /*DM41788INI*/
			       ValorEsperadoDespBco = (
			           SELECT SUM(ISNULL(cdx.ValorEsperadoDespBco, 0))
			           FROM   ComposicoesDebito cdx
			           WHERE  cdx.IdDebito IN (SELECT cdx2.IdDebito
			                                   FROM   composicoesdebito cdx2 
			                                   INNER JOIN Debitos dbx ON dbx.IdDebito = cdx2.IdDebito
			                                   WHERE  cdx2.IdDebitoOrigemRen = @IdDebitoOrig			                                          
			                                          AND dbx.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
			                                          AND dbx.NumConjReneg = @NumConjRen)
			                  AND (ISNULL(cdx.ValorEsperadoPrincipal, 0) + ISNULL(cdx.ValorDescontoPrincipal, 0)) = 0
			                  AND @FValorDespesas > 0), 
			       ValorEsperadoDespAdv = (
			           SELECT SUM(ISNULL(cdx.ValorEsperadoDespAdv, 0))
			           FROM   ComposicoesDebito cdx
			           WHERE  cdx.IdDebito IN (SELECT cdx2.IdDebito
			                                   FROM   composicoesdebito cdx2 
			                                   INNER JOIN Debitos dbx ON dbx.IdDebito = cdx2.IdDebito
			                                   WHERE  cdx2.IdDebitoOrigemRen = @IdDebitoOrig
			                                          AND dbx.IdSituacaoAtual <> 9
			                                          AND dbx.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
			                                          AND dbx.NumConjReneg = @NumConjRen)
			                  AND (ISNULL(cdx.ValorEsperadoPrincipal, 0) + ISNULL(cdx.ValorDescontoPrincipal, 0)) = 0
			                  AND @FValorDespesas > 0), 
			       ValorEsperadoDespPostais = (
			           SELECT SUM(ISNULL(cdx.ValorEsperadoDespPostais, 0))
			           FROM   ComposicoesDebito cdx
			           WHERE  cdx.IdDebito IN (SELECT cdx2.IdDebito
			                                   FROM   composicoesdebito cdx2 
			                                   INNER JOIN Debitos dbx ON dbx.IdDebito = cdx2.IdDebito
			                                   WHERE  cdx2.IdDebitoOrigemRen = @IdDebitoOrig			                                          
			                                          AND dbx.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
			                                          AND dbx.NumConjReneg = @NumConjRen)
			                  AND (ISNULL(cdx.ValorEsperadoPrincipal, 0) + ISNULL(cdx.ValorDescontoPrincipal, 0)) = 0			                  
			                  AND @FValorDespesas > 0), /*DM41788FIM*/ 
			       SUM(ISNULL(ValorPagoPrincipal, 0)), 
			       SUM(ISNULL(ValorPagoAtualizacao, 0)), 
			       SUM(ISNULL(ValorPagoMulta, 0)), 
			       SUM(ISNULL(ValorPagoJuros, 0)), /*DM41788INI */
			       ValorPagoDespBco = (
			           SELECT SUM(ISNULL(cdx.ValorPagoDespBco, 0))
			           FROM   ComposicoesDebito cdx
			           WHERE  cdx.IdDebito IN (SELECT cdx2.IdDebito
			                                   FROM   composicoesdebito cdx2 
			                                   INNER JOIN Debitos dbx ON dbx.IdDebito = cdx2.IdDebito
			                                   WHERE  cdx2.IdDebitoOrigemRen = @IdDebitoOrig
			                                          AND dbx.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
			                                          AND dbx.NumConjReneg = @NumConjRen)
			                  AND (ISNULL(cdx.ValorEsperadoPrincipal, 0) + ISNULL(cdx.ValorDescontoPrincipal, 0)) = 0
			                  AND @FValorPgDespesas > 0), 
			       ValorPagoDespAdv = (
			           SELECT SUM(ISNULL(cdx.ValorPagoDespAdv, 0))
			           FROM   ComposicoesDebito cdx
			           WHERE  cdx.IdDebito IN (SELECT cdx2.IdDebito
			                                   FROM   composicoesdebito cdx2 
			                                   INNER JOIN Debitos dbx ON dbx.IdDebito = cdx2.IdDebito
			                                   WHERE  cdx2.IdDebitoOrigemRen = @IdDebitoOrig
			                                          AND dbx.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
			                                          AND dbx.NumConjReneg = @NumConjRen)
			                  AND (ISNULL(cdx.ValorEsperadoPrincipal, 0) + ISNULL(cdx.ValorDescontoPrincipal, 0)) = 0
			                  AND @FValorPgDespesas > 0),
			       ValorPagoDespPostais = (
			           SELECT SUM(ISNULL(cdx.ValorPagoDespPostais, 0))
			           FROM   ComposicoesDebito cdx
			           WHERE  cdx.IdDebito IN (SELECT cdx2.IdDebito
			                                   FROM   composicoesdebito cdx2 
			                                   INNER JOIN Debitos dbx ON dbx.IdDebito = cdx2.IdDebito
			                                   WHERE  cdx2.IdDebitoOrigemRen = @IdDebitoOrig
			                                          AND dbx.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
			                                          AND dbx.NumConjReneg = @NumConjRen)
			                  AND (ISNULL(cdx.ValorEsperadoPrincipal, 0) + ISNULL(cdx.ValorDescontoPrincipal, 0)) = 0
			                  AND @FValorPgDespesas > 0), /*DM41788FIM*/
			       IdDebitoOrigemRen, 
			       SUM(ISNULL(ValorEsperadoDAPrincipal, 0)), 
			       SUM(ISNULL(ValorEsperadoDAAtualizacao, 0)), 
			       SUM(ISNULL(ValorEsperadoDAMulta, 0)), 
			       SUM(ISNULL(ValorEsperadoDAJuros, 0)), 
			       SUM(ISNULL(ValorEsperadoDADespBco, 0)), 
			       SUM(ISNULL(ValorEsperadoDADespAdv, 0)), 
			       SUM(ISNULL(ValorEsperadoDADespPostais, 0)), 
			       SUM(ISNULL(ValorPagoDAPrincipal, 0)), 
			       SUM(ISNULL(ValorPagoDAAtualizacao, 0)), 
			       SUM(ISNULL(ValorPagoDAMulta, 0)), 
			       SUM(ISNULL(ValorPagoDAJuros, 0)), 
			       SUM(ISNULL(ValorPagoDADespBco, 0)), 
			       SUM(ISNULL(ValorPagoDADespAdv, 0)), 
			       SUM(ISNULL(ValorPagoDADespPostais, 0)), 
			       RegistraLog
			FROM   ComposicoesDebito cd
			WHERE  cd.IdDebitoOrigemRen = @IdDebitoOrig
			       AND cd.IdDebito IN (SELECT d1.IdDebito
			                           FROM   Debitos d1
			                           WHERE  d1.IdDebito = cd.IdDebito
			                                  AND d1.IdDebito <> cd.IdDebitoOrigemRen
	                                          AND d1.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) /*Oc 47155 */
	                                          AND d1.NumConjReneg = @NumConjRen)
			       AND (ISNULL(cd.ValorEsperadoPrincipal, 0) + ISNULL(cd.ValorDescontoPrincipal, 0)) > 0 /*ITALO*/
			GROUP BY
			       cd.RegistraLog, IdProcedimentoAtraso, IdMoedaValorEsperado, IdDebitoOrigemRen
			
			UPDATE t
			SET    t.ValorPago       = isnull(t.ValorPago,0) + @FTotalPago,
			       t.NumConjReneg    = NULL,
			       t.NumeroRenegociacao = NULL,
			       t.UsuarioRen      = NULL,
			       t.DepartamentoRen = NULL,
			       t.DataPgto        = CASE WHEN @FDataAtual IS NOT NULL THEN @FDataAtual ELSE NULL END,
			       t.IdTipoPagamento = @IdTipoPagamento,
			       t.DataCredito     = @DataCredito			        
			FROM   #tblOrigens t
			WHERE  t.IdDebito = @IdDebitoOrig
		END		
		ELSE
		BEGIN			
			UPDATE t
			SET    t.NumConjReneg = NULL,
			       t.NumeroRenegociacao = NULL,
			       t.UsuarioRen = NULL,
			       t.DepartamentoRen = NULL
			FROM   #tblOrigens t
			WHERE t.IdDebito = @IdDebitoOrig
		END	
		SELECT @IdOrig = min(t.Id) FROM #tblOrigens t WHERE t.Id > @IdOrig
	END
		
	/* Aqui fazemos um ajuste para recalcular o valor pago em DA porque temos casos em que o valor principal esperado
	*  se refere ao valor com desconto no principal. Então identificamos primeiro o valor esperado principal correto
	*  e em seguida recalculamos os valores pagos em DA. */
	
	/* Atualizamos o valor esperado principal chamando a função Calc_PagoMenor que irá fazer um cálculo para saber
	* o saldo devedor. No entanto caso a origem não tenha pagamento (estava com situação igual a não pago) será retornado
	* nulo desta função. */
	UPDATE #tblComposicoes
	SET    ValorEsperadoPrincipal = ISNULL(dbo.Calc_PagoMenor(IdDebitoOrigemRen, @lFisica), 0)
	
	/* Para os casos de origem sem pagamento em que a função Calc_PagoMenor retornou nulo vamos atualizar
	*  novamente inserindo agora o valor devido do débito. */
	UPDATE t
	SET    t.ValorEsperadoPrincipal = d.ValorDevido
	FROM   #tblComposicoes t
	       JOIN Debitos d ON d.IdDebito = t.IdDebitoOrigemRen
	WHERE  t.ValorEsperadoPrincipal = 0

	UPDATE #tblComposicoes
	SET    ValorPagoDAPrincipal   = CAST((ValorEsperadoDAPrincipal   * ValorPagoPrincipal / ValorEsperadoPrincipal) AS NUMERIC(10,2)),
		   ValorPagoDAAtualizacao = CAST((ValorEsperadoDAAtualizacao * ValorPagoPrincipal / ValorEsperadoPrincipal) AS NUMERIC(10,2)),
		   ValorPagoDAMulta       = CAST((ValorEsperadoDAMulta       * ValorPagoPrincipal / ValorEsperadoPrincipal) AS NUMERIC(10,2)),
		   ValorPagoDAJuros       = CAST((ValorEsperadoDAJuros       * ValorPagoPrincipal / ValorEsperadoPrincipal) AS NUMERIC(10,2))  		
		
	SELECT @IdDest = min(t.id) FROM #tblDestino t
	WHILE (@IdDest IS NOT NULL ) AND (@Desfazer = 1)
	BEGIN
		SELECT @IdDebitoDest  = t.IdDebito, 
		       @ValorPagoParc = t.ValorPago, 
		       @DataPgtoParc  = t.DataPgto, 
		       @FTotalPago    = isnull(t.ValorPago,0) 
		  FROM #tblDestino t 
		 WHERE t.Id = @IdDest		
		
		SELECT @FTotalPago = isnull(ValorPago,0) 
		  FROM Debitos 
		 WHERE IdDebito = @IdDebitoDest
		
		IF @FTotalPago > 0
			INSERT INTO #TblTmp (IdOrigem) SELECT @IdDebitoDest

		UPDATE t
		SET    t.NumConjReneg = NULL,
		       t.NumeroRenegociacao = NULL,
		       t.UsuarioRen = NULL,
		       t.DepartamentoRen = NULL,
		       t.Obs = 'Cancelado em ' + CONVERT(CHAR(10), GETDATE(), 103) + ' e ativado o(s) débito(s) original(is)'
		FROM  #tblDestino t
		WHERE t.IdDebito = @IdDebitoDest

        /* Oc 49865 - Atualiza o campo observação, informando o número da parcela de renegociação onde foi realizado o pagamento.*/
		UPDATE o
		SET    o.Obs = 'Pagamento através da parcela ' + Cast(d.NumeroParcela AS VARCHAR(4)) + ' renegociada' + CHAR(13) + cast(isnull(o.Obs,'') AS VARCHAR(5000))
		FROM   #tblOrigens o 
		JOIN   ComposicoesDebito cd ON cd.IdDebitoOrigemRen = o.IdDebito
		JOIN   Debitos d ON cd.IdDebito = d.IdDebito
		WHERE  cd.IdDebito = @IdDebitoDest		
		  AND  d.ValorPago > 0
		  AND (ISNULL(cd.ValorEsperadoPrincipal, 0) + ISNULL(cd.ValorDescontoPrincipal, 0)) > 0 	      
		
		INSERT INTO #tblDebitos_SituacoesDebito 
		SELECT @IdDebitoDest, 9, getdate()	
		 WHERE NOT EXISTS(SELECT TOP 1 1 
		                    FROM #tblDebitos_SituacoesDebito tds 
		                   WHERE tds.IdDebito = @IdDebitoDest)				
		                   
		/*
		* inicio                    
		*/
		/* interação nos débitos de origem */  /* PauloR */
		
		SELECT @NumConjEmissao = d.NumConjEmissao,
			   @TpEmissaoConjunta = d.TpEmissaoConjunta
		FROM   Debitos d
		WHERE  d.IdDebito = @IdDebitoDest 


		IF (@TpEmissaoConjunta = 3) AND (ISNULL(@NumConjEmissao,0) = 0)
			UPDATE d
			SET    TpEmissaoConjunta = 0,
				   NumConjEmissao = 0,
				   TpCompDespesas = 0,
				   NossoNumero = NULL
			FROM   Debitos D
			WHERE  d.IdDebito IN (SELECT ce.IdDebito
								  FROM   ComposicoesEmissao ce
								  WHERE  ce.IdDetalheEmissao IN (SELECT TOP 1 ce3.IdDetalheEmissao
																 FROM   ComposicoesEmissao ce3
																 WHERE  ce3.IdDebito = @IdDebitoDest
																 ORDER BY ce3.IdDetalheEmissao DESC))         		
		ELSE 
		BEGIN     
			IF (@lFisica = 1) AND (ISNULL(@NumConjEmissao,0) > 0)		
				UPDATE d
					SET d.TpEmissaoConjunta = 0,
						d.NumConjEmissao = 0,
						d.TpCompDespesas = 0,
						d.NossoNumero    = NULL
				FROM Debitos d
				WHERE d.IdProfissional = @IdProfissional
				AND ISNULL(d.TpEmissaoConjunta, 0) > 0 
				AND d.NumConjEmissao = @NumConjEmissao

			IF (@lFisica = 0) AND (ISNULL(@NumConjEmissao,0) > 0)		
				UPDATE d
					SET d.TpEmissaoConjunta = 0,
						d.NumConjEmissao = 0,
						d.TpCompDespesas = 0,
						d.NossoNumero    = NULL
				FROM Debitos d
				WHERE d.IdPessoaJuridica = @IdProfissional
				AND ISNULL(d.TpEmissaoConjunta, 0) > 0 
				AND d.NumConjEmissao = @NumConjEmissao

			IF (@lFisica = 2) AND (ISNULL(@NumConjEmissao,0) > 0)		
				UPDATE d
					SET d.TpEmissaoConjunta = 0,
						d.NumConjEmissao = 0,
						d.TpCompDespesas = 0,
						d.NossoNumero    = NULL
				FROM Debitos d
				WHERE d.IdPessoa = @IdProfissional
				AND ISNULL(d.TpEmissaoConjunta, 0) > 0 
				AND d.NumConjEmissao = @NumConjEmissao
		END 
		
		/*
		*  fim
		*/
		
		SELECT @IdDest = min(t.id) FROM #tblDestino t WHERE t.Id > @IdDest
	END

	IF @Desfazer = 1
	BEGIN
		IF @lFisica = 1 /* Pessoa Física (profissional) */
		BEGIN
			INSERT INTO #tblDebitos_SituacoesDebito 
			SELECT d1.IdDebito, 9, getDate()	
			  FROM Debitos d1 
			 WHERE d1.IdProfissional = @IdProfissional 
			   AND d1.NumConjReneg = @NumConjRen  
			   AND d1.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) 
			   AND d1.ValorPago IS NULL 
			   AND NOT EXISTS(SELECT TOP 1 1 
			                    FROM #tblDebitos_SituacoesDebito t 
			                   WHERE d1.IdDebito = d1.IdDebito)	
		END 
		IF @lFisica = 0 /* Pessoa Jurídica */
		BEGIN
			INSERT INTO #tblDebitos_SituacoesDebito 
			SELECT d1.IdDebito, 9, getDate()	
			  FROM Debitos d1 
			 WHERE d1.IdPessoaJuridica = @IdProfissional 
			   AND d1.NumConjReneg = @NumConjRen 
			   AND d1.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca) 
			   AND d1.ValorPago IS NULL 
			   AND NOT EXISTS(SELECT TOP 1 1 
			                    FROM #tblDebitos_SituacoesDebito t 
			                   WHERE d1.IdDebito = d1.IdDebito)		
		END
		IF @lFisica = 2 /* Outras pessoas */
		BEGIN
			INSERT INTO #tblDebitos_SituacoesDebito 
			SELECT d1.IdDebito, 9, getDate()	
			  FROM Debitos d1 
			 WHERE d1.IdPessoa = @IdProfissional 
			   AND d1.NumConjReneg = @NumConjRen  
			   AND d1.IdTipoDebito IN (@IdRenegociacao, @IdRecobranca)  
			   AND d1.ValorPago IS NULL	
			   AND NOT EXISTS(SELECT TOP 1 1 
			                    FROM #tblDebitos_SituacoesDebito t 
			                   WHERE d1.IdDebito = d1.IdDebito)		
		END				  
	END	
	SELECT @IdTmpDesfazer = min(id) FROM #tmpDesfazer t WHERE id > @IdTmpDesfazer
END

/*2ª Interação*/ 
/* Distribuir encargos pagos por atraso para origem da renegociacao*/


SELECT @IdOrigTmp = MAX(IdOrigem) FROM #TblTmp
WHILE @IdOrigTmp IS NOT NULL
BEGIN
	DELETE #tmp
	
			
	INSERT INTO #TblComp (IdComposicaoDebito) 
	SELECT IdComposicaoDebito 
	  FROM ComposicoesDebito 
	 WHERE IdDebito = @IdOrigTmp 
	   AND (ISNULL(ValorEsperadoPrincipal, 0) + ISNULL(ValorDescontoPrincipal, 0)) <> 0 

	SELECT @TotalEsperadoMulta = 0, @TotalEsperadoJuros = 0, @TotalEsperadoAtualizacao = 0,	@TotalPagoMulta = 0, @TotalPagoJuros = 0, @TotalPagoAtualizacao = 0
    
	SELECT @TotalEsperadoMulta       = CAST(CAST(SUM(Isnull(ValorEsperadoMulta,      0)) as Numeric(18,2)) AS Decimal(20,2)),
	       @TotalEsperadoJuros       = CAST(CAST(SUM(Isnull(ValorEsperadoJuros,      0)) as Numeric(18,2)) AS Decimal(20,2)),	
	       @TotalEsperadoAtualizacao = CAST(CAST(SUM(Isnull(ValorEsperadoAtualizacao,0)) as Numeric(18,2)) AS Decimal(20,2)) 
	  FROM ComposicoesDebito 
	 WHERE IdDebito = @IdOrigTmp 
	   AND (ISNULL(ValorEsperadoPrincipal, 0) + ISNULL(ValorDescontoPrincipal, 0)) <> 0 	
	
	
	IF @TotalEsperadoMulta >0 OR @TotalEsperadoJuros > 0 OR @TotalEsperadoAtualizacao >0
	BEGIN
	
		SELECT @TotalPagoMulta       = isnull(CAST(CAST(SUM(Isnull(ValorPagoMulta,      0)) as Numeric(18,2)) AS Decimal(20,2)),0),	
		       @TotalPagoJuros       = isnull(CAST(CAST(SUM(Isnull(ValorPagoJuros,      0)) as Numeric(18,2)) AS Decimal(20,2)),0),
		       @TotalPagoAtualizacao = isnull(CAST(CAST(SUM(Isnull(ValorPagoAtualizacao,0)) as Numeric(18,2)) AS Decimal(20,2)),0)	
		  FROM ComposicoesDebito	
		 WHERE IdDebito = @IdOrigTmp	
		   AND (ISNULL(ValorEsperadoPrincipal, 0) + ISNULL(ValorDescontoPrincipal, 0)) = 0 
		
		SELECT @idComp = MAX(IdComposicaoDebito) FROM #TblComp
		
		SELECT @AcrescentarPgto = 0
		
		WHILE @idComp IS NOT NULL
		BEGIN		
            IF EXISTS (SELECT TOP 1 1 FROM #TblComp WHERE #TblComp.IdComposicaoDebito <> @idComp) 
			BEGIN 			
				SELECT @TmpMulta = CASE WHEN @TotalEsperadoMulta <> 0 
										THEN ISNULL(ROUND((ValorPagoMulta * @TotalPagoMulta / @TotalEsperadoMulta),2),0) 
										ELSE 0 END,
					   @TmpJuros = CASE WHEN @TotalEsperadoJuros <> 0 
										THEN ISNULL(ROUND((ValorPagoJuros * @TotalPagoJuros / @TotalEsperadoJuros),2),0) 
										ELSE 0 END,
					   @TmpAtualizacao = CASE WHEN @TotalEsperadoAtualizacao <> 0 
											  THEN ISNULL(ROUND((ValorPagoAtualizacao * @TotalPagoAtualizacao / @TotalEsperadoAtualizacao),2),0) 
											  ELSE 0 END 
				  FROM ComposicoesDebito 
				 WHERE IdComposicaoDebito =  @idComp
			END 
			ELSE
			BEGIN
				/* Se só existe uma origem não é necessário fazer cálculo proporcional */
				SELECT @TmpMulta       = @TotalPagoMulta,
					   @TmpJuros       = @TotalPagoJuros,
					   @TmpAtualizacao = @TotalPagoAtualizacao
			END
							
			SELECT @AcrescentarPgto = @AcrescentarPgto + @TmpMulta + @TmpJuros + @TmpAtualizacao             

			UPDATE t
			   SET t.ValorPago = isnull(t.ValorPago,0) + @AcrescentarPgto
			  FROM #tblOrigens t
			 WHERE t.IdDebito in (select IdDebitoOrigemRen 
			                        from ComposicoesDebito 
			                       where IdComposicaoDebito = @idComp)
			
			UPDATE t
			   SET t.Atualizacao = @TmpAtualizacao,
			       t.Multa = @TmpMulta,
				   t.Juros = @TmpJuros
			  FROM #TblComp t
			 WHERE t.IdComposicaoDebito = @idComp
						
            SELECT @IdOrig = IdDebitoOrigemRen from ComposicoesDebito where IdComposicaoDebito = @idComp
            
			/*ITALO oc 41369 - oc 48206*/    
            IF NOT EXISTS (SELECT TOP 1 1 FROM #tblComposicoes WHERE ISNULL(ValorEsperadoPrincipal,0) = 0
                                                                 AND IdDebito = @IdOrig )
            BEGIN          
			 INSERT INTO #tblComposicoes (IdDebito,
			                              ValorPagoMulta,
			                              ValorPagoJuros,
			                              ValorPagoAtualizacao)
     		                      VALUES (@IdOrig,
     		                              @TmpMulta,
     		                              @TmpJuros,
     		                              @TmpAtualizacao)			
     		END 
     		ELSE 
     		BEGIN /* oc 48206 */
     			UPDATE #tblComposicoes SET ValorPagoMulta = (ValorPagoMulta + @TmpMulta),
     		                               ValorPagoJuros = (ValorPagoJuros + @TmpJuros),
     		                               ValorPagoAtualizacao = (ValorPagoAtualizacao + @TmpAtualizacao)
     			                     WHERE IdDebito = @IdOrig
     			                       AND ISNULL(ValorEsperadoPrincipal,0) = 0
     		END            
     					
			SELECT @AcrescentarPgto = 0
			
			SELECT @idComp = MAX(IdComposicaoDebito) FROM #TblComp WHERE IdComposicaoDebito < @idComp			
		END
	END
	ELSE
	BEGIN	
		
		/*-------------------------------------*/
		INSERT INTO #tmp
		SELECT DISTINCT  
			 cd.IdComposicaoDebito, cd.IdDebitoOrigemRen, cd.ValorEsperadoPrincipal
		FROM ComposicoesDebito cd
		WHERE cd.IdDebito IN (SELECT 
								   t.IdOrigem
							  FROM #TblTmp t WHERE cd.IdDebito = @IdOrigTmp)
			 AND (ISNULL(cd.ValorEsperadoPrincipal, 0) + ISNULL(cd.ValorDescontoPrincipal, 0)) > 0
			 AND cd.IdDebito = @IdOrigTmp 


		SELECT 
			 @SomaPrincipalOrigem = ISNULL(SUM(ISNULL(cd.ValorEsperadoPrincipal, 0)), 0)
		FROM ComposicoesDebito cd
		WHERE cd.IdDebito IN (SELECT 
								   t.IdOrigem
							  FROM #TblTmp t WHERE cd.IdDebito = @IdOrigTmp)
			 AND (ISNULL(cd.ValorEsperadoPrincipal, 0) + ISNULL(cd.ValorDescontoPrincipal, 0)) > 0
			 AND cd.IdDebito = @IdOrigTmp 

		SELECT 
			 @SomaEncargos = ISNULL(SUM(ISNULL(cd.ValorPagoAtualizacao, 0) + 
			 ISNULL(cd.ValorPagoMulta,0) + ISNULL(cd.ValorPagoJuros,0)), 0)
		FROM ComposicoesDebito cd
		WHERE cd.IdDebito IN (SELECT 
								   t.IdOrigem
							  FROM #TblTmp t WHERE cd.IdDebito = @IdOrigTmp)
			 AND (ISNULL(cd.ValorEsperadoPrincipal, 0) + ISNULL(cd.ValorDescontoPrincipal, 0)) = 0
			 AND cd.IdDebito = @IdOrigTmp 

		SELECT 
			 @EncargosAtu = SUM(ISNULL(cd.ValorPagoAtualizacao, 0)) ,
			 @EncargosMulta = sum(ISNULL(cd.ValorPagoMulta,0)),
			 @EncargosJuros =  sum(ISNULL(cd.ValorPagoJuros,0))
		FROM ComposicoesDebito cd
		WHERE cd.IdDebito IN (SELECT 
								   t.IdOrigem
							  FROM #TblTmp t)
			 AND (ISNULL(cd.ValorEsperadoPrincipal, 0) + ISNULL(cd.ValorDescontoPrincipal, 0)) = 0
			 AND cd.IdDebito = @IdOrigTmp 
     	/*-------------------------------------*/
		
	
		
		SELECT @idComp = min(t.id) FROM #Tmp t
		WHILE @idComp IS NOT NULL
		BEGIN
			
			SELECT @ValorPrincipal = t.ValorPrincipal, @idOrigem = t.IdOrigem, @IdComposicao = t.IdComposicao 
			  FROM #Tmp t WHERE t.id = @idComp
								
				
				SELECT @TmpMulta = CASE WHEN @EncargosMulta <> 0 /* @SomaEncargos*/
										THEN ISNULL(ROUND((@ValorPrincipal * @EncargosMulta / @SomaPrincipalOrigem),2),0) 
										ELSE 0 END,
					   @TmpJuros = CASE WHEN @EncargosJuros <> 0 
										THEN ISNULL(ROUND((@ValorPrincipal * @EncargosJuros / @SomaPrincipalOrigem),2),0) 
										ELSE 0 END,
					   @TmpAtualizacao = CASE WHEN @EncargosAtu <> 0 
											  THEN ISNULL(ROUND((@ValorPrincipal * @EncargosAtu / @SomaPrincipalOrigem),2),0) 
											  ELSE 0 END 
											  

				  FROM ComposicoesDebito cd 
					WHERE cd.IdComposicaoDebito = @IdComposicao
	
				

			UPDATE t
			   SET t.ValorPagoAtualizacao =  isnull(t.ValorPagoAtualizacao,0) + @TmpAtualizacao,
				   t.ValorPagoMulta  = ISNULL(t.ValorPagoMulta,0) + @TmpMulta,
				   t.ValorPagoJuros = isnull(t.ValorPagoJuros,0) + @TmpJuros
			FROM #tblComposicoes t
			WHERE t.IdDebito = @idOrigem
		      AND ISNULL(ValorEsperadoPrincipal,0) = 0
			
			/* oc 48614 */	
			
			UPDATE #tblOrigens
			SET ValorPago = isnull(ValorPago,0) + isnull(@TmpMulta+@TmpJuros+@TmpAtualizacao,0)
			WHERE IdDebito = @idOrigem 
		 
		 SELECT @idComp = min(t.id) FROM #Tmp t WHERE id > @idComp
		 			
		END		
	END	

	SELECT @IdOrigTmp = MAX(IdOrigem) FROM #TblTmp WHERE IdOrigem < @IdOrigTmp  
    DELETE #TblComp
END

/*3ª Interação*/
SELECT  @IdOrigTmp = MAX(IdDebito) FROM #tblComposicoes GROUP BY IdDebito
WHILE @IdOrigTmp IS NOT NULL
BEGIN 
  IF NOT EXISTS(SELECT TOP 1 1 FROM ComposicoesDebito	WHERE IdDebito = @IdOrigTmp	 )
  BEGIN
    /* Se entrou aqui é porque não tem composição. Mas isso não quer dizer que não tem
       valor pago, porque se foi um pagamento feito antes do vencimento (sem encargos)
       o valor pago só ficará registrado na tabela de débitos sem composição.
       Então, devemos somar este valor pago e jogar no campo ValorPagoPrincipal da 
       composição que será criada agora. */
	SELECT @ValorPago = ISNULL(d.ValorPago, 0) 
	FROM   Debitos d
	WHERE  d.IdDebito = @IdOrigTmp  
  
	/* Insere Composições dos débitos */
	/* Oc. 97424 */
   	SELECT @ValorEsperadoPrincipal = d.ValorDevido 
   	FROM   Debitos d 
   	WHERE  d.IdDebito = @IdOrigTmp	

	/*ITALO oc 41369*/
	INSERT INTO ComposicoesDebito (IdDebito,
	                               IdProcedimentoAtraso,
	                               ValorEsperadoPrincipal,
	                               IdMoedaValorEsperado,
	                               ValorEsperadoAtualizacao,
	                               ValorEsperadoMulta,
	                               ValorEsperadoJuros,
	                               ValorEsperadoDespBco,
	                               ValorEsperadoDespAdv,
	                               ValorEsperadoDespPostais,
	                               ValorPagoPrincipal,
	                               ValorPagoAtualizacao,
	                               ValorPagoMulta,
	                               ValorPagoJuros,
	                               ValorPagoDespBco,
	                               ValorPagoDespAdv,
	                               ValorPagoDespPostais,
	                               
	                               ValorEsperadoDAPrincipal,
	                               ValorEsperadoDAAtualizacao,
	                               ValorEsperadoDAMulta,
	                               ValorEsperadoDAJuros,
	                               ValorEsperadoDADespBco,
	                               ValorEsperadoDADespAdv,
	                               ValorEsperadoDADespPostais,
	                               
	                               ValorPagoDAPrincipal,
	                               ValorPagoDAAtualizacao,
	                               ValorPagoDAMulta,
	                               ValorPagoDAJuros,
	                               ValorPagoDADespBco,
	                               ValorPagoDADespAdv,
	                               ValorPagoDADespPostais,
	                               
	                               IdDebitoOrigemRen,
	                               RegistraLog)
					  	    SELECT IdDebito,
					  			   MAX(IdProcedimentoAtraso),
					  			   @ValorEsperadoPrincipal,
					  			   MAX(IdMoedaValorEsperado),
					  			   SUM(ISNULL(ValorEsperadoAtualizacao, 0)),
					  			   SUM(ISNULL(ValorEsperadoMulta, 0)),
					  			   SUM(ISNULL(ValorEsperadoJuros, 0)),
					  			   SUM(ISNULL(ValorEsperadoDespBco, 0)),
					  			   SUM(ISNULL(ValorEsperadoDespAdv, 0)),
					  			   SUM(ISNULL(ValorEsperadoDespPostais, 0)),
					  			   SUM(ISNULL(ValorPagoPrincipal, 0)) + @ValorPago,
					  			   SUM(ISNULL(ValorPagoAtualizacao, 0)),
					  			   SUM(ISNULL(ValorPagoMulta, 0)),
					  			   SUM(ISNULL(ValorPagoJuros, 0)),
					  			   SUM(ISNULL(ValorPagoDespBco, 0)),
					  			   SUM(ISNULL(ValorPagoDespAdv, 0)),
					  			   SUM(ISNULL(ValorPagoDespPostais, 0)),
					  			   
	                               SUM(ISNULL(ValorEsperadoDAPrincipal, 0)),
	                               SUM(ISNULL(ValorEsperadoDAAtualizacao, 0)),
	                               SUM(ISNULL(ValorEsperadoDAMulta, 0)),
	                               SUM(ISNULL(ValorEsperadoDAJuros, 0)),
	                               SUM(ISNULL(ValorEsperadoDADespBco, 0)),
	                               SUM(ISNULL(ValorEsperadoDADespAdv, 0)),
	                               SUM(ISNULL(ValorEsperadoDADespPostais, 0)),
	                               SUM(ISNULL(ValorPagoDAPrincipal, 0)),
	                               SUM(ISNULL(ValorPagoDAAtualizacao, 0)),
	                               SUM(ISNULL(ValorPagoDAMulta, 0)),
	                               SUM(ISNULL(ValorPagoDAJuros, 0)),
	                               SUM(ISNULL(ValorPagoDADespBco, 0)),
	                               SUM(ISNULL(ValorPagoDADespAdv, 0)),
	                               SUM(ISNULL(ValorPagoDADespPostais, 0)),
	                               
					  			   MAX(IdDebitoOrigemRen),
					  			   MAX(RegistraLog) 
							  FROM #tblComposicoes 
							 WHERE IdDebito = @IdOrigTmp 
							 GROUP BY IdDebito
  END
  ELSE
  BEGIN
	  IF EXISTS (SELECT 1  FROM ComposicoesDebito cd WHERE cd.IdDebito = @IdOrigTmp HAVING count(1) > 1 )  	   
	  BEGIN
		/*Italo quando existir na origem debito do TPCompDespesas e criar uma composisao de encargos juntar em uma unica composicao*/
	   	SELECT @ValorEsperadoPrincipal   = sum(isnull(ValorEsperadoPrincipal,0)), 
	   	       @ValorEsperadoAtualizacao = sum(isnull(ValorEsperadoAtualizacao,0)),
	   	       @ValorEsperadoMulta       = sum(isnull(ValorEsperadoMulta,0)),
	   	       @ValorEsperadoJuros       = sum(isnull(ValorEsperadoJuros,0)), 
	   	       @ValorEsperadoDespBco     = sum(isnull(ValorEsperadoDespBco,0)),
	   	       @ValorEsperadoDespAdv     = sum(isnull(ValorEsperadoDespAdv,0)), 
	   	       @ValorEsperadoDespPostais = sum(isnull(ValorEsperadoDespPostais,0)) , 
	   	       @ValorPagoPrincipal       = sum(isnull(ValorPagoPrincipal,0)), 
	   	       @ValorPagoAtualizacao     = sum(isnull(ValorPagoAtualizacao,0)), 
	   	       @ValorPagoMulta           = sum(isnull(ValorPagoMulta,0)),
	   	       @ValorPagoJuros           = sum(isnull(ValorPagoJuros,0)),
	   	       @ValorPagoDespBco         = sum(isnull(ValorPagoDespBco,0)),
	   	       @ValorPagoDespAdv         = sum(isnull(ValorPagoDespAdv,0)), 
	   	       @ValorPagoDespPostais     = sum(isnull(ValorPagoDespPostais,0)) 
	   	  FROM ComposicoesDebito   
	   	 WHERE IdDebito = @IdOrigTmp	   
	   	
	   	DELETE FROM ComposicoesDebito WHERE IdDebito = @IdOrigTmp AND (ISNULL(ValorEsperadoPrincipal, 0) + ISNULL(ValorDescontoPrincipal, 0)) = 0
	   	 
		UPDATE ComposicoesDebito 
		   SET ValorEsperadoPrincipal    = @ValorEsperadoPrincipal, 
		   	   ValorEsperadoAtualizacao  = @ValorEsperadoAtualizacao ,
			   ValorEsperadoMulta   	 = @ValorEsperadoMulta,
			   ValorEsperadoJuros   	 = @ValorEsperadoJuros,
			   ValorEsperadoDespBco 	 = @ValorEsperadoDespBco,
			   ValorEsperadoDespAdv 	 = @ValorEsperadoDespAdv,
			   ValorEsperadoDespPostais  = @ValorEsperadoDespPostais,		
			   ValorPagoPrincipal   	 = @ValorPagoPrincipal, 
			   ValorPagoAtualizacao 	 = @ValorPagoAtualizacao ,
			   ValorPagoMulta       	 = @ValorPagoMulta,
			   ValorPagoJuros       	 = @ValorPagoJuros,
			   ValorPagoDespBco     	 = @ValorPagoDespBco,
			   ValorPagoDespAdv     	 = @ValorPagoDespAdv,
			   ValorPagoDespPostais 	 = @ValorPagoDespPostais
	     WHERE IdDebito = @IdOrigTmp 
		    
      END
	   
      SELECT @ValorPagoPrincipal     = sum(isnull(ValorPagoPrincipal,0)), 
             @ValorPagoAtualizacao   = sum(isnull(ValorPagoAtualizacao,0)), 
             @ValorPagoMulta         = sum(isnull(ValorPagoMulta,0)),
             @ValorPagoJuros         = sum(isnull(ValorPagoJuros,0)), 
             @ValorPagoDespBco       = sum(isnull(ValorPagoDespBco,0)),
             @ValorPagoDespAdv       = sum(isnull(ValorPagoDespAdv,0)), 
             @ValorPagoDespPostais   = sum(isnull(ValorPagoDespPostais,0)),
             @ValorPagoDAPrincipal   = sum(isnull(ValorPagoDAPrincipal,0)), 
             @ValorPagoDAAtualizacao = sum(isnull(ValorPagoDAAtualizacao,0)), 
             @ValorPagoDAMulta       = sum(isnull(ValorPagoDAMulta,0)), 
             @ValorPagoDAJuros       = sum(isnull(ValorPagoDAJuros,0)),              
             @ValorPagoDADespBco     = sum(isnull(ValorPagoDADespBco,0)), 
             @ValorPagoDADespAdv     = sum(isnull(ValorPagoDADespAdv,0)),
             @ValorPagoDADespPostais = sum(isnull(ValorPagoDADespPostais,0)) 
        FROM #tblComposicoes 
       WHERE IdDebito = @IdOrigTmp
      
      UPDATE ComposicoesDebito 
         SET ValorPagoPrincipal   	= isnull(ValorPagoPrincipal    ,0) + @ValorPagoPrincipal, 
			 ValorPagoAtualizacao 	= isnull(ValorPagoAtualizacao  ,0) + @ValorPagoAtualizacao,
		 	 ValorPagoMulta       	= isnull(ValorPagoMulta        ,0) + @ValorPagoMulta,
			 ValorPagoJuros       	= isnull(ValorPagoJuros        ,0) + @ValorPagoJuros,
			 ValorPagoDespBco     	= isnull(ValorPagoDespBco      ,0) + @ValorPagoDespBco,
			 ValorPagoDespAdv     	= isnull(ValorPagoDespAdv      ,0) + @ValorPagoDespAdv,
			 ValorPagoDespPostais 	= isnull(ValorPagoDespPostais  ,0) + @ValorPagoDespPostais,
			 ValorPagoDAPrincipal 	= isnull(ValorPagoDAPrincipal  ,0) + @ValorPagoDAPrincipal, 
             ValorPagoDAAtualizacao = isnull(ValorPagoDAAtualizacao,0) + @ValorPagoDAAtualizacao, 
             ValorPagoDAMulta       = isnull(ValorPagoDAMulta      ,0) + @ValorPagoDAMulta, 
             ValorPagoDAJuros       = isnull(ValorPagoDAJuros      ,0) + @ValorPagoDAJuros,              
             ValorPagoDADespBco     = isnull(ValorPagoDADespBco    ,0) + @ValorPagoDADespBco, 
             ValorPagoDADespAdv     = isnull(ValorPagoDADespAdv    ,0) + @ValorPagoDADespAdv,
             ValorPagoDADespPostais = isnull(ValorPagoDADespPostais,0) + @ValorPagoDADespPostais
   	   WHERE IdDebito = @IdOrigTmp	
   	   
		/* Identifica se na composição que já existe para a origem esta com os valores de dívida ativa */
		IF NOT EXISTS(SELECT TOP 1 1 FROM ComposicoesDebito WHERE ISNULL(ValorEsperadoDAPrincipal,0) > 0 AND IdDebito = @IdOrigTmp)
		BEGIN
			SELECT	@ValorEsperadoDAPrincipal   = sum(isnull(ValorEsperadoDAPrincipal,0)), 
					@ValorEsperadoDAAtualizacao = sum(isnull(ValorEsperadoDAAtualizacao,0)), 
					@ValorEsperadoDAMulta       = sum(isnull(ValorEsperadoDAMulta,0)), 
					@ValorEsperadoDAJuros       = sum(isnull(ValorEsperadoDAJuros,0)),              
					@ValorEsperadoDADespBco     = sum(isnull(ValorEsperadoDADespBco,0)), 
					@ValorEsperadoDADespAdv     = sum(isnull(ValorEsperadoDADespAdv,0)),
					@ValorEsperadoDADespPostais = sum(isnull(ValorEsperadoDADespPostais,0)) 
			FROM #tblComposicoes 
			WHERE IdDebito = @IdOrigTmp
			
			UPDATE ComposicoesDebito 
			SET ValorEsperadoDAPrincipal   = isnull(ValorEsperadoDAPrincipal  ,0) + @ValorEsperadoDAPrincipal, 
				ValorEsperadoDAAtualizacao = isnull(ValorEsperadoDAAtualizacao,0) + @ValorEsperadoDAAtualizacao, 
				ValorEsperadoDAMulta       = isnull(ValorEsperadoDAMulta      ,0) + @ValorEsperadoDAMulta, 
				ValorEsperadoDAJuros       = isnull(ValorEsperadoDAJuros      ,0) + @ValorEsperadoDAJuros,              
				ValorEsperadoDADespBco     = isnull(ValorEsperadoDADespBco    ,0) + @ValorEsperadoDADespBco, 
				ValorEsperadoDADespAdv     = isnull(ValorEsperadoDADespAdv    ,0) + @ValorEsperadoDADespAdv,
				ValorEsperadoDADespPostais = isnull(ValorEsperadoDADespPostais,0) + @ValorEsperadoDADespPostais
			WHERE IdDebito = @IdOrigTmp			      	
		END   	   	
   	END	
  SELECT @IdOrigTmp = MAX(IdDebito) FROM #tblComposicoes WHERE IdDebito < @IdOrigTmp
END

/*4ª Interação*/
/*verificando a situações das origens */
BEGIN
	SELECT  @IdOrigTmp = min(Id) FROM #tblOrigens
	WHILE @IdOrigTmp IS NOT NULL
	BEGIN 
		SELECT @IdDebitoOrig    = IdDebito, 
			   @IdSituacaoAtual = IdSituacaoAtual,
			   @ValorDevido     = isnull(ValorDevido,0),
			   @ValorOrig       = ValorPagoOrigem	  
		  FROM #tblOrigens 
		 WHERE Id = @IdOrigTmp   

		SET @ValorPago = ISNULL((SELECT SUM(ISNULL(ValorPagoPrincipal  , 0)) +
		                                SUM(ISNULL(ValorPagoAtualizacao, 0)) +
		                                SUM(ISNULL(ValorPagoMulta      , 0)) +
		                                SUM(ISNULL(ValorPagoJuros      , 0)) 
								   FROM ComposicoesDebito 
								  WHERE IdDebito = @IdDebitoOrig), 0)
								  
		SET @ValorEsperado = ISNULL((SELECT SUM(ISNULL(ValorEsperadoPrincipal  , 0)) +
		                                    SUM(ISNULL(ValorEsperadoAtualizacao, 0)) +
		                                    SUM(ISNULL(ValorEsperadoMulta      , 0)) +
		                                    SUM(ISNULL(ValorEsperadoJuros      , 0)) 
							  	       FROM ComposicoesDebito 
								      WHERE IdDebito =@IdDebitoOrig), 0)								  
	 
		SELECT @IdOrigTmp = min(Id) 
		  FROM #tblOrigens 
		 WHERE Id > @IdOrigTmp
	END
END /*DM43259*/

-- APMF - oc 40551
-- Pegar do destino e jogar na origem o percentual de repasse e os dados da conta que sempre são os mesmos (Sérgio).
-- (início alteração)
SELECT @PercentualRepasse = PercentualRepasse FROM #tblDestino WHERE PercentualRepasse IS NOT NULL
SELECT @CodBanco          = CodBanco          FROM #tblDestino WHERE CodBanco          IS NOT NULL
SELECT @CodAgencia        = CodAgencia        FROM #tblDestino WHERE CodAgencia        IS NOT NULL
SELECT @CodOperacao       = CodOperacao       FROM #tblDestino WHERE CodOperacao       IS NOT NULL
SELECT @CodCC_Conv_Ced    = CodCC_Conv_Ced    FROM #tblDestino WHERE CodCC_Conv_Ced    IS NOT NULL
-- (fim alteração)

/* Oc. 78579 */
SET @NumConjParcelasRen = (SELECT MAX(ISNULL(Debitos.NumConjParcelasRen,0)) + 1 FROM Debitos)

/* Update nas Origens e parcelas relacionadas a renegociação */
UPDATE d
   SET d.IdSituacaoAtual    = CASE WHEN o.IdDebito = d.IdDebito THEN d.IdSituacaoAtual     ELSE 9                     END,
       d.NumConjReneg       = CASE WHEN o.IdDebito = d.IdDebito THEN o.NumConjReneg        ELSE td.NumConjReneg       END,
       d.NumeroRenegociacao = CASE WHEN o.IdDebito = d.IdDebito THEN o.NumeroRenegociacao  ELSE td.NumeroRenegociacao END,
       d.UsuarioRen         = CASE WHEN o.IdDebito = d.IdDebito THEN o.UsuarioRen          ELSE td.UsuarioRen         END,
       d.DepartamentoRen    = CASE WHEN o.IdDebito = d.IdDebito THEN o.DepartamentoRen     ELSE td.DepartamentoRen    END,
       
       d.ValorPago          = CASE WHEN o.IdDebito = d.IdDebito 
                                   THEN CASE WHEN isnull(o.ValorPago,0) <> isnull(d.ValorPago,0) 
    				                         THEN o.ValorPago 
    				                         ELSE d.ValorPago END
                                   ELSE td.ValorPago END,
                                   
	   d.PercentualRepasse     = CASE WHEN o.ValorPago > 0 THEN @PercentualRepasse ELSE d.PercentualRepasse END, /* APMF oc 40551 (início alteração)*/
	   d.CodBanco              = CASE WHEN o.ValorPago > 0 THEN @CodBanco          ELSE d.CodBanco          END,
	   d.CodAgencia            = CASE WHEN o.ValorPago > 0 THEN @CodAgencia        ELSE d.CodAgencia        END,
	   d.CodOperacao           = CASE WHEN o.ValorPago > 0 THEN @CodOperacao       ELSE d.CodOperacao       END,
	   d.CodCC_Conv_Ced        = CASE WHEN o.ValorPago > 0 THEN @CodCC_Conv_Ced    ELSE d.CodCC_Conv_Ced    END,           /* (fim alteração)*/                   
	   
	   d.DataPgto              = CASE WHEN o.IdDebito  = d.IdDebito THEN o.DataPgto 
	   							      WHEN td.IdDebito = d.IdDebito THEN td.DataPgto    END,
	   
	   d.DataUltimoPgto        = CASE WHEN o.IdDebito  = d.IdDebito THEN d.DataPgto 
	   							      WHEN td.IdDebito = d.IdDebito THEN NULL           END,
	    
	   d.DataCredito           = CASE WHEN o.IdDebito  = d.IdDebito THEN o.DataCredito 
									  WHEN td.IdDebito = d.IdDebito THEN td.DataCredito END,
	    
	   d.DataUltimoCredito     = CASE WHEN o.IdDebito  = d.IdDebito THEN d.DataCredito 
	   							      WHEN td.IdDebito = d.IdDebito THEN NULL           END,
	   
	   d.IdTipoPagamento       = CASE WHEN o.IdTipoPagamento  <> 0  THEN O.IdTipoPagamento 
									  WHEN td.IdTipoPagamento <> 0  THEN td.IdTipoPagamento 
																	ELSE NULL END,
	    
	   d.ObsDebito             = CASE WHEN o.Obs IS NOT NULL        THEN o.Obs  
									  							    ELSE d.ObsDebito END,
	   /* Oc. 78579 */			  							    
	   d.NumConjParcelasRen    = CASE WHEN td.IdDebito = d.IdDebito THEN @NumConjParcelasRen 
	                                                                ELSE NULL END  												  							    
  FROM Debitos d
	   LEFT JOIN #tblOrigens o  ON o.IdDebito  = d.IdDebito
	   LEFT JOIN #tblDestino td ON td.IdDebito = d.IdDebito
 WHERE d.IdDebito IN (SELECT o.IdDebito  FROM #tblOrigens o
					   UNION 
					  SELECT td.IdDebito FROM #tblDestino td)

/* Aqui vamos calcular a nova situação das origens */
SELECT @IdOrig = min(t.Id) FROM #tblOrigens t
WHILE @IdOrig IS NOT NULL 
BEGIN
	SELECT @ValorEsperado   = ISNULL(CASE WHEN cd.IdComposicaoDebito IS NULL THEN d.ValorDevido ELSE ISNULL(cd.ValorEsperadoPrincipal, 0) END,0),
	       @ValorPago       = ISNULL(CASE WHEN cd.IdComposicaoDebito IS NULL THEN d.ValorPago   ELSE ISNULL(cd.ValorPagoPrincipal    , 0) END,0),
	       @IdSituacaoAtual = d.IdSituacaoAtual,
	       @IdDebitoOrig    = d.IdDebito
	FROM   Debitos d
	       JOIN #tblOrigens t
	            ON  d.IdDebito = t.IdDebito
	       LEFT JOIN ComposicoesDebito cd
	            ON  cd.IdDebito = d.IdDebito
	WHERE t.Id = @IdOrig 
	
	/* Cálculo da margem */
   	SET @MrDif = 0
   	
  	IF @MRPercent > 0 
 		SET @MRDif = (@ValorDevido / 100) * @MRPercent
      	
	IF @MRValor > 0 
		SET @MRDif = @MRValor		  
		  		  
	IF (( @ValorPago + @MRDif ) >= @ValorEsperado) AND (( @ValorPago - @MRDif ) <= @ValorEsperado )
	BEGIN 
		IF @IdSituacaoAtual = 14
			SELECT @NovaSituacao = 11
		ELSE
			SELECT @NovaSituacao = 2
	END
	ELSE IF (@ValorPago - @MRDif) > @ValorEsperado  	
	BEGIN
		IF @IdSituacaoAtual = 14
			SELECT @NovaSituacao = 11
		ELSE
			SELECT @NovaSituacao = 4
	END    
	ELSE IF (@ValorPago + @MRDif) < @ValorEsperado  		
	BEGIN
		IF @IdSituacaoAtual = 14
			SELECT @NovaSituacao = 15
		ELSE
			SELECT @NovaSituacao = 3
	END
		
	IF @ValorPago = 0
	BEGIN 		
		IF @IdSituacaoAtual = 14
			SELECT @NovaSituacao = 10 	      
		ELSE 	   	
			SELECT @NovaSituacao = 1
	END 
	
	IF @IdSituacaoAtual <> @NovaSituacao
	BEGIN		
		UPDATE Debitos 
		SET    IdSituacaoAtual = @NovaSituacao 
		WHERE  IdDebito = @IdDebitoOrig
		
		INSERT INTO #tblDebitos_SituacoesDebito 
		SELECT @IdDebitoOrig, 
		       @NovaSituacao, 
		       GETDATE() 
		 WHERE NOT EXISTS(SELECT TOP 1 1 
		                    FROM #tblDebitos_SituacoesDebito tds 
		                   WHERE tds.IdDebito = @IdDebitoOrig)
	END	
		
	SELECT @IdOrig = min(t.Id) FROM #tblOrigens t WHERE t.Id > @IdOrig
END	

/* aqui vamos inserir os históricos de situação das parcelas */
INSERT INTO #tblDebitos_SituacoesDebito (IdDebito, IdSituacaoDebito, DataSituacao)
SELECT t.IdDebito, 9, GETDATE() 
FROM   #tblDestino t 
WHERE  NOT EXISTS(SELECT TOP 1 1 
                  FROM   #tblDebitos_SituacoesDebito tds 
                  WHERE  tds.IdDebito = t.IdDebito)

/* Insere Debitos_SituacoesDebito 
INSERT INTO Debitos_SituacoesDebito(IdDebito,
                                    UsuarioUltimaAtualizacao,
                                    IdSituacaoDebito,
                                    DataSituacao,
                                    DepartamentoUltimaAtualizacao)
                             SELECT tdsd.IdDebito, 
                                    @Usuario AS Usuario,
                                    tdsd.IdSituacaoDebito, 
                                    tdsd.DataSituacao,
                                    @Departamento AS Departamento 
                               FROM #tblDebitos_SituacoesDebito tdsd	
*/
IF @teste = 1
BEGIN
	SELECT 'origem',  * FROM #tblOrigens to1
	SELECT 'destino', * FROM #tblDestino td
	SELECT 'composicao', * FROM #tblComposicoes tc
	SELECT YEAR(d.DataReferencia) ano, cd.ValorPagoPrincipal,
	       cd.ValorPagoAtualizacao, cd.ValorPagoMulta, cd.ValorPagoJuros, cd.ValorPagoDespBco,
	       cd.ValorPagoDespAdv, cd.ValorPagoDespPostais 
	  FROM Debitos d
	JOIN ComposicoesDebito cd ON cd.IdDebito = d.IdDebito
	JOIN #tblOrigens to1 ON to1.IdDebito = d.IdDebito 
	
	ROLLBACK TRAN
END 

IF @teste = 0
BEGIN
    DROP TABLE #TblTmp
    DROP TABLE #TblComp
    DROP TABLE #tmpDesfazer
    DROP TABLE #tblOrigens
    DROP TABLE #tblDestino
    DROP TABLE #tblComposicoes
    DROP TABLE #tblDebitos_SituacoesDebito
    DROP TABLE #tmp
END
