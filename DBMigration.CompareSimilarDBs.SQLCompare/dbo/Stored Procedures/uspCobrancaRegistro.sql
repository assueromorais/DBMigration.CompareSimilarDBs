/* Oc. 180315 Criado por Seila e Adicionado por Wanderson */

CREATE PROCEDURE [dbo].[uspCobrancaRegistro]  
   @RemessaRegistro BIT, /*Utilizado para informar se é remessa para registro*/  
   @IdConfigRegistro INT, /*IdRelatorio da CA =>Obrigatorio se @RemessaRegistro = 1, para pegar as configurações de Juros, multa e protesto.*/        
   @CodBanco CHAR(3), /*001-Banco do Brasil ; 104-Caixa =>Obrigatorio se @RemessaRegistro = 1*/  
   @Convenio VARCHAR(7),/*CodConvenio  =>Obrigatorio se @RemessaRegistro = 1*/      
   @TipoPessoa INT, /*0-PF 1-PJ 2-PE  =>Obrigatorio se @RemessaRegistro = 1*/  
   @SituacaoRegistro INT, /*Dominio de situação do boleto   =>Obrigatorio se @RemessaRegistro = 1*/  
   @IdPessoa INT,         /*Não Obrigatório*/  
   @NossoNumero VARCHAR(20),       /*Não Obrigatório*/  
   @SeuNumero VARCHAR(20),       /*Não Obrigatório*/  
   @DataEmissaoIni VARCHAR(30),    /*Não Obrigatório*/  
   @DataEmissaoFim VARCHAR(30),    /*Não Obrigatório*/
   @SomenteUltimaEmissao BIT,    /*Não Obrigatório*/       
   @PermiteDuplicidadeCUnica BIT,  /*Configurações de desconto do BB =>Não Obrigatório*/  
   @IdMsgBoletoBancarioI INT,   /*Instruções*/  
   @SqlCA VARCHAR(MAX),       /*Não Obrigatório*/   
   @DesconsideraConfig BIT = 0,	/*Para geração do remessa registro*/  
   @Unificada BIT = 0, /*Para emissão unificada*/
   @ValidaCPFCNPJEndereco BIT = 1 
AS     
 SET NOCOUNT ON   
 
/*@Versao3.0@*/    
/*===================================================================================================================================================  
01-Declarações de variáveis e tabelas temporárias  
===================================================================================================================================================*/   
 DECLARE @Erro                         BIT,  
         @sSql                         VARCHAR(MAX),  
         @sWhere                       VARCHAR(1000),  
         @sWhereII                     VARCHAR(300),  
         @TabelaPessoa                 VARCHAR(20),  
         @CampoPessoa                  VARCHAR(20),  
         @sSqlPessoa                   VARCHAR(3000),  
         @sSqlSomenteUltimaEmissao     CHAR(300),  
         @IdConfigGeracaoDebito        INT	
   
 SET @sWhere = ''  
 SET @sWhereII = ''  
 SET @sSqlSomenteUltimaEmissao = ''  


IF OBJECT_ID('TEMPDB.dbo.#FiltroRemessaRegistro') IS NOT NULL  
     DROP TABLE #FiltroRemessaRegistro  
   
 CREATE TABLE #FiltroRemessaRegistro  
 (IdProfissional            INT,  
  IdPessoaJuridica          INT,  
  IdPessoa                  INT,  
  Nome                      VARCHAR(120),  
  RegistroConselhoAtual     VARCHAR(20),  
  CNPJCPF                   VARCHAR(14),  
  Processo                  VARCHAR(15),  
  NProc                     VARCHAR(20),  
  TipoInscricao             VARCHAR(26),  
  CategoriaAtual            VARCHAR(40),  
  Situacao                  VARCHAR(60),  
  E_PessoaJuridica          BIT,  
  Endereco                  VARCHAR(60),  
  NomeBairro                VARCHAR(50),  
  NomeCidade                VARCHAR(30),  
  SiglaUF                   VARCHAR(2),  
  CaixaPostal               VARCHAR(15),  
  Cep                       VARCHAR(8),  
  [Pelo menos um end.]      VARCHAR(200),  
  NomeDebito                VARCHAR(25),  
  SiglaDebito               VARCHAR(10),  
  DataReferencia            DATETIME,  
  [Ano referÃªncia]         INT,  
  AnoRef                    VARCHAR(4),  
  SeuNumero                 CHAR(11),  
  NossoNumero               VARCHAR(20),  
  NumeroParcela             INT,  
  DataVencimento            DATETIME,  
  ValorDevido               MONEY,  
  ValorOriginal             MONEY,  
  Moeda                     VARCHAR(20),  
  IdMoeda                   INT,  
  IdDebito                  INT,  
  IdTipoDebito              INT,  
  NumConjReneg              INT,  
  NumConjTpDebito           INT,  
  NumConjEmissao            INT,  
  ValorPago                 MONEY,  
  TpEmissaoConjunta         INT,  
  ValorPgPrincipal          MONEY,  
  CodBanco                  VARCHAR(3),  
  CodCC_Conv_Ced            VARCHAR(16),  
  IdDetalheEmissao          INT,  
  DataEmissao               DATETIME,  
  ValorEmissao              MONEY,  
  ValorDespBco              MONEY,  
  ValorDespAdv              MONEY,  
  ValorDespPostais          MONEY,  
  TipoDaEmissao             VARCHAR(20),
  TipoComposicao            INT,
  Forma                     VARCHAR(10),  
  Situacao_Registro         VARCHAR(20),  
  IdConfigRegistro          INT,  
  IdMsgBoletoBancarioI      INT,
  DescontoAplicado          BIT  
 ) 
 
IF OBJECT_ID('TEMPDB.dbo.#ConfigCNAB') IS NOT NULL  
     DROP TABLE #ConfigCNAB  
   
 CREATE TABLE #ConfigCNAB  
 (  
  IdConfigGeracaoDebito     INT,  
  IdMsgBoletoBancarioI      INT,  
  NumeroParcela             INT,  
  CodJuros                  VARCHAR(40),  
  ValorJuros                MONEY,  
  CodMulta                  VARCHAR(40),  
  ValorMulta                MONEY,  
  CodProtesto               VARCHAR(40),  
  DiasProtesto              INT,  
  DescCod1                  INT,  
  DescData1                 DATETIME,  
  DescValor1                MONEY,  
  DescCod2                  INT,  
  DescData2                 DATETIME,  
  DescValor2                MONEY, 
  DescCod3                  INT,  
  DescData3                 DATETIME,  
  DescValor3                MONEY 
 )      

/*===================================================================================================================================================  
02-@DesconsideraConfig = 1 (Utilizado na Geração de Remessa para Registro- While em todas as configurações de desconto) 
===================================================================================================================================================*/  
 IF @DesconsideraConfig = 1 --Inicio desconsideraconfig  
 BEGIN  
     DECLARE CrBoletos CURSOR FAST_FORWARD READ_ONLY   
     FOR 
        SELECT DISTINCT mb.IdConfigGeracaoDebito,de.IdMsgBoletoBancarioI          
		FROM   DetalhesEmissao de  
			 JOIN  MsgBoletosBancarios mb ON mb.IdMsgBoletoBancario = de.IdMsgBoletoBancarioI  
		     JOIN  ComposicoesEmissao ce ON ce.IdDetalheEmissao = de.IdDetalheEmissao  
	         JOIN  debitos d ON d.iddebito = ce.iddebito              
		 WHERE ((@TipoPessoa = 0  AND d.IdProfissional IS NOT NULL)
             OR (@TipoPessoa = 1  AND d.IdPessoaJuridica IS NOT NULL)
             OR (@TipoPessoa = 2  AND d.IdPessoa IS NOT NULL) )                
		  AND ((convert(nvarchar(30),DataEmissao,112) BETWEEN @DataEmissaoIni AND @DataEmissaofIM)
		    OR ( @DataEmissaoIni = '' OR  @DataEmissaoIni IS NULL )) 
        ORDER BY  mb.IdConfigGeracaoDebito,de.IdMsgBoletoBancarioI    
      
     OPEN CrBoletos  
       
     FETCH FROM CrBoletos INTO @IdConfigGeracaoDebito,@IdMsgBoletoBancarioI  
       
     WHILE @@FETCH_STATUS = 0  
     BEGIN          
         IF @IdConfigGeracaoDebito > 0 /*Se possui configuração de desconto*/  
         BEGIN
/*===============================================================================================================================================
02.1-PIVOT limitados a 3 descontos por parcela
===============================================================================================================================================*/       	  
             IF @PermiteDuplicidadeCUnica = 0   
             BEGIN                
                 INSERT INTO #ConfigCNAB (IdConfigGeracaoDebito,IdMsgBoletoBancarioI,NumeroParcela,
                                           DescCod1,DescCod2,DescCod3,DescData1,DescData2,DescData3, 
                                           DescValor1,DescValor2,DescValor3)                
				 SELECT IdConfigGeracaoDebito,@IdMsgBoletoBancarioI,NumeroParcela 
						,DescCod1 = (MAX(case when Coluna=1 then case @unificada WHEN 1 then 0 ELSE CAST(E_Percentual AS INT) END END)) + 1
						,DescCod2 = (MAX(case when Coluna=2 then case @unificada WHEN 1 then 0 ELSE CAST(E_Percentual AS INT) END END)) + 1 
						,DescCod3 = (MAX(case when Coluna=3 then case @unificada WHEN 1 then 0 ELSE CAST(E_Percentual AS INT) END END)) + 1
						,DescData1 = MAX(case when Coluna=1 then DataPgtoDesconto end)
						,DescData2 = MAX(case when Coluna=2 then DataPgtoDesconto end)
						,DescData3 = MAX(case when Coluna=3 then DataPgtoDesconto end) 
						,DescValor1 = ISNULL(MAX(case when Coluna=1 then case @unificada WHEN 1 then DescontoEmValor ELSE ValorPgtoDesconto  END END),0)
						,DescValor2 = ISNULL(MAX(case when Coluna=2 then case @unificada WHEN 1 then DescontoEmValor ELSE ValorPgtoDesconto  END END),0)
						,DescValor3 = ISNULL(MAX(case when Coluna=3 then case @unificada WHEN 1 then DescontoEmValor ELSE ValorPgtoDesconto  END END),0) 
				 FROM 
					(SELECT Coluna=ROW_NUMBER() OVER (PARTITION BY CG.IdConfigGeracaoDebito,CP.NumeroParcela ORDER BY CG.IdConfigGeracaoDebito,CP.NumeroParcela,OP.DataPgtoDesconto),
							CG.IdConfigGeracaoDebito,CG.IdTipoDebito,CG.NomeConfiguracao,CG.DataReferenciaDebito,
							CG.DataGeracao,CG.Valor,CG.QtdeParcelas, CP.NumeroParcela,CP.DataVencimentoParcela,
							CP.ValorParcela,OP.DataPgtoDesconto,OP.ValorPgtoDesconto, OP.E_Percentual,
							DescontoEmValor = CASE OP.E_Percentual WHEN 1 THEN CAST( ((CP.ValorParcela * OP.ValorPgtoDesconto)/100) AS MONEY) 
																	ELSE OP.ValorPgtoDesconto END 
					FROM ConfigGeracaoDebito CG	 INNER JOIN 
							ConfigParcelasDebito CP ON CP.IdConfigGeracaoDebito = CG.IdConfigGeracaoDebito INNER JOIN 
							OpcoesPgtoDesconto OP ON OP.IdConfigParcelaDebito = CP.IdConfigParcelaDebito
				    WHERE ((CONVERT(VARCHAR,OP.DataPgtoDesconto,112) >= CONVERT(VARCHAR,GETDATE(),112)) OR (OP.DataPgtoDesconto IS NULL )) 
					GROUP BY CG.IdConfigGeracaoDebito,CG.IdTipoDebito,CG.NomeConfiguracao,CG.DataReferenciaDebito,
					         CG.DataGeracao,CG.Valor,CG.QtdeParcelas, CP.NumeroParcela,CP.DataVencimentoParcela,
							 CP.ValorParcela,OP.DataPgtoDesconto,OP.ValorPgtoDesconto, OP.E_Percentual					 									 
					)X	
				WHERE IdConfigGeracaoDebito = @IdConfigGeracaoDebito
				GROUP BY IdConfigGeracaoDebito,IdTipoDebito,NomeConfiguracao,NumeroParcela
				ORDER BY IdConfigGeracaoDebito,IdTipoDebito,NomeConfiguracao,NumeroParcela  
			 END 
/*===============================================================================================================================================
02.2-NÃO PIVOT, aqui as opções de desconto levam em consideração apenas as ainda não vencidas
===============================================================================================================================================*/ 		  
             ELSE                  
             BEGIN                 
                 INSERT INTO #ConfigCNAB (IdConfigGeracaoDebito,IdMsgBoletoBancarioI,NumeroParcela,DescCod1,DescData1,DescValor1)  
                 SELECT CP.IdConfigGeracaoDebito,@IdMsgBoletoBancarioI,CP.Numeroparcela,
                        DescCod1 = CASE @unificada WHEN 1 THEN 1 ELSE CAST(Op.E_Percentual AS INT) + 1 END,OP.DataPgtoDesconto,
                        CASE @unificada WHEN 1 THEN CAST(((CP.ValorParcela * OP.ValorPgtoDesconto)/100) AS MONEY) 
                                        ELSE OP.ValorPgtoDesconto END  
                 FROM   ConfigParcelasDebito CP  
                        INNER JOIN OpcoesPgtoDesconto OP  
                             ON  CP.IdConfigParcelaDebito = OP.IdConfigParcelaDebito  
                 WHERE  CP.IdConfigGeracaoDebito = CAST(@IdConfigGeracaoDebito AS VARCHAR)
                    AND ((CONVERT(VARCHAR,OP.DataPgtoDesconto,112) >= CONVERT(VARCHAR,GETDATE(),112)) OR (OP.DataPgtoDesconto IS NULL ))   
             END             
/*===============================================================================================================================================
02.3-Atualiza a #ConfigCNAB, com os valores de Juros,Multa e Protesto, de MsgBoletosBancarios.
===============================================================================================================================================*/ 		               
             IF (SELECT COUNT(*) FROM #ConfigCNAB WHERE IdConfigGeracaoDebito = @IdConfigGeracaoDebito) > 0  /*Devido a crítica da DataPgtoDesconto, apesar de haver configuração de desconto, pode ser que não retorne resultados*/
			 BEGIN   
				 UPDATE CC  
				 SET    CC.DescCod1 = ISNULL(CC.DescCod1, 0), 
						CC.DescCod2 = ISNULL(CC.DescCod2, 0), 
						CC.DescCod3 = ISNULL(CC.DescCod3, 0), 
						CC.CodJuros = SUBSTRING(ISNULL(MS.CodJuros, 0), 1, 1),  
						CC.ValorJuros = MS.ValorJuros,  
						CC.CodMulta = SUBSTRING(ISNULL(MS.CodMulta, 0), 1, 1),  
						CC.ValorMulta = MS.ValorMulta,  
						CC.CodProtesto = SUBSTRING(ISNULL(MS.CodProtesto, 3), 1, 1),  
						CC.DiasProtesto = MS.DiasProtesto,  
						CC.IdMsgBoletoBancarioI = MS.IdMsgBoletoBancario  
				 FROM   MsgBoletosBancarios MS  
						LEFT JOIN #ConfigCNAB CC ON  MS.IdMsgBoletoBancario = @IdMsgBoletoBancarioI  
				  WHERE CC.IdConfigGeracaoDebito = @IdConfigGeracaoDebito 
					AND CC.IdmsgBoletoBancarioI =  @IdMsgBoletoBancarioI
			 END 
			 ELSE 
			 BEGIN
      			 INSERT INTO #ConfigCNAB (IdMsgBoletoBancarioI,CodJuros,ValorJuros,CodMulta,ValorMulta,CodProtesto,DiasProtesto,  
											DescCod1,DescCod2,DescCod3)  
				 SELECT IdMsgBoletoBancario,CodJuros = SUBSTRING(ISNULL(CodJuros, 0), 1, 1),ValorJuros,CodMulta = SUBSTRING(ISNULL(CodMulta, 0), 1, 1),  
					   ValorMulta,CodProtesto = SUBSTRING(ISNULL(CodProtesto, 3), 1, 1), DiasProtesto, 0,0,0  
				 FROM   MsgBoletosBancarios  
				 WHERE  IdMsgBoletoBancario = @IdMsgBoletoBancarioI  
			 END        
         END 
/*===============================================================================================================================================
02.4-Se NÃO possui de desconto, insere apenas as configurações de MsgBoletosBancarios, Juros,Multa,Protestos
===============================================================================================================================================*/ 	          
         ELSE            
         BEGIN  
             INSERT INTO #ConfigCNAB (IdMsgBoletoBancarioI,CodJuros,ValorJuros,CodMulta,ValorMulta,CodProtesto,DiasProtesto,  
                                       DescCod1,DescCod2,DescCod3)  
             SELECT IdMsgBoletoBancario,CodJuros = SUBSTRING(ISNULL(CodJuros, 0), 1, 1),ValorJuros,CodMulta = SUBSTRING(ISNULL(CodMulta, 0), 1, 1),  
                    ValorMulta,CodProtesto = SUBSTRING(ISNULL(CodProtesto, 3), 1, 1), DiasProtesto, 0,0,0  
             FROM   MsgBoletosBancarios  
             WHERE  IdMsgBoletoBancario = @IdMsgBoletoBancarioI  
         END          
           
         FETCH FROM CrBoletos INTO @IdConfigGeracaoDebito,@IdMsgBoletoBancarioI  
     END         
     CLOSE CrBoletos         
     DEALLOCATE CrBoletos  
 END  
 ELSE  
/*===================================================================================================================================================  
03-@DesconsideraConfig = 0 (Apenas uma configuração de desconto) 
===================================================================================================================================================*/   
 BEGIN  
     SELECT @IdConfigGeracaoDebito = ISNULL(IdConfigGeracaoDebito, 0)  
     FROM   MsgBoletosBancarios  
     WHERE  IdMsgBoletoBancario = @IdMsgBoletoBancarioI
        
     IF @IdConfigGeracaoDebito > 0 /*Se possui configuração de desconto*/  
     BEGIN 
/*===============================================================================================================================================
03.1-PIVOT limitados a 3 descontos por parcela
===============================================================================================================================================*/      	 
         IF @PermiteDuplicidadeCUnica = 0 /*PIVOT limitados a 3 descontos por parcela*/ 
         BEGIN  
             /*PIVOT em opções de PgtoDesconto limitados a 3 descontos por parcela*/   
             INSERT INTO #ConfigCNAB (IdConfigGeracaoDebito,IdMsgBoletoBancarioI,NumeroParcela,DescCod1,DescCod2,DescCod3,  
                                       DescData1,DescData2,DescData3,DescValor1,DescValor2,DescValor3)                
              SELECT IdConfigGeracaoDebito,@IdMsgBoletoBancarioI,NumeroParcela 
						,DescCod1 = (MAX(case when Coluna=1 then case @unificada WHEN 1 then 0 ELSE CAST(E_Percentual AS INT) END END)) + 1
						,DescCod2 = (MAX(case when Coluna=2 then case @unificada WHEN 1 then 0 ELSE CAST(E_Percentual AS INT) END END)) + 1 
						,DescCod3 = (MAX(case when Coluna=3 then case @unificada WHEN 1 then 0 ELSE CAST(E_Percentual AS INT) END END)) + 1
						,DescData1 = MAX(case when Coluna=1 then DataPgtoDesconto end)
						,DescData2 = MAX(case when Coluna=2 then DataPgtoDesconto end)
						,DescData3 = MAX(case when Coluna=3 then DataPgtoDesconto end) 
						,DescValor1 = ISNULL(MAX(case when Coluna=1 then case @unificada WHEN 1 then DescontoEmValor ELSE ValorPgtoDesconto  END END),0)
						,DescValor2 = ISNULL(MAX(case when Coluna=2 then case @unificada WHEN 1 then DescontoEmValor ELSE ValorPgtoDesconto  END END),0)
						,DescValor3 = ISNULL(MAX(case when Coluna=3 then case @unificada WHEN 1 then DescontoEmValor ELSE ValorPgtoDesconto  END END),0) 
				 FROM 
					(SELECT Coluna=ROW_NUMBER() OVER (PARTITION BY CG.IdConfigGeracaoDebito,CP.NumeroParcela ORDER BY CG.IdConfigGeracaoDebito,CP.NumeroParcela,OP.DataPgtoDesconto),
							CG.IdConfigGeracaoDebito,CG.IdTipoDebito,CG.NomeConfiguracao,CG.DataReferenciaDebito,
							CG.DataGeracao,CG.Valor,CG.QtdeParcelas, CP.NumeroParcela,CP.DataVencimentoParcela,
							CP.ValorParcela,OP.DataPgtoDesconto,OP.ValorPgtoDesconto, OP.E_Percentual,
							DescontoEmValor = CASE OP.E_Percentual WHEN 1 THEN CAST( ((CP.ValorParcela * OP.ValorPgtoDesconto)/100) AS MONEY) 
																	ELSE OP.ValorPgtoDesconto END 
					FROM ConfigGeracaoDebito CG	 INNER JOIN 
							ConfigParcelasDebito CP ON CP.IdConfigGeracaoDebito = CG.IdConfigGeracaoDebito INNER JOIN 
							OpcoesPgtoDesconto OP ON OP.IdConfigParcelaDebito = CP.IdConfigParcelaDebito
					WHERE ((CONVERT(VARCHAR,OP.DataPgtoDesconto,112) >= CONVERT(VARCHAR,GETDATE(),112)) OR (OP.DataPgtoDesconto IS NULL ))
					GROUP BY CG.IdConfigGeracaoDebito,CG.IdTipoDebito,CG.NomeConfiguracao,CG.DataReferenciaDebito,
					         CG.DataGeracao,CG.Valor,CG.QtdeParcelas, CP.NumeroParcela,CP.DataVencimentoParcela,
							 CP.ValorParcela,OP.DataPgtoDesconto,OP.ValorPgtoDesconto, OP.E_Percentual					 									 
					)X	
				WHERE IdConfigGeracaoDebito = @IdConfigGeracaoDebito
				GROUP BY IdConfigGeracaoDebito,IdTipoDebito,NomeConfiguracao,NumeroParcela
				ORDER BY IdConfigGeracaoDebito,IdTipoDebito,NomeConfiguracao,NumeroParcela   
         END
/*===============================================================================================================================================
03.2-NÃO PIVOT, aqui as opções de desconto levam em consideração apenas as ainda não vencidas
===============================================================================================================================================*/             
         ELSE
         BEGIN  
             INSERT INTO #ConfigCNAB (IdConfigGeracaoDebito,IdMsgBoletoBancarioI,NumeroParcela,DescCod1,DescData1,DescValor1)  
                 SELECT CP.IdConfigGeracaoDebito,@IdMsgBoletoBancarioI,CP.Numeroparcela,
                        DescCod1 = CASE @unificada WHEN 1 THEN 1 ELSE CAST(Op.E_Percentual AS INT) + 1 END,OP.DataPgtoDesconto,
                        CASE @unificada WHEN 1 THEN CAST(((CP.ValorParcela * OP.ValorPgtoDesconto)/100) AS MONEY) 
                                        ELSE OP.ValorPgtoDesconto END   
                 FROM   ConfigParcelasDebito CP  
                        INNER JOIN OpcoesPgtoDesconto OP  
                             ON  CP.IdConfigParcelaDebito = OP.IdConfigParcelaDebito  
                 WHERE  CP.IdConfigGeracaoDebito = CAST(@IdConfigGeracaoDebito AS VARCHAR)
                    AND ((CONVERT(VARCHAR,OP.DataPgtoDesconto,112) >= CONVERT(VARCHAR,GETDATE(),112)) OR (OP.DataPgtoDesconto IS NULL ))   
         END  
/*===============================================================================================================================================
03.3-Atualiza a #ConfigCNAB, com os valores de Juros,Multa e Protesto, de MsgBoletosBancarios.
===============================================================================================================================================*/             
       IF (SELECT COUNT(*) FROM #ConfigCNAB ) > 0  /*Devido a crítica da DataPgtoDesconto, apesar de haver configuração de desconto, pode ser que não retorne resultados*/
	   BEGIN 
		   UPDATE CC  
		   SET CC.DescCod1 = ISNULL(CC.DescCod1, 0), 
			   CC.DescCod2 = ISNULL(CC.DescCod2, 0), 
			   CC.DescCod3 = ISNULL(CC.DescCod3, 0),       
			   CC.CodJuros = SUBSTRING(ISNULL(MS.CodJuros, 0), 1, 1),  
			   CC.ValorJuros = MS.ValorJuros,  
			   CC.CodMulta = SUBSTRING(ISNULL(MS.CodMulta, 0), 1, 1),  
			   CC.ValorMulta = MS.ValorMulta,  
			   CC.CodProtesto = SUBSTRING(ISNULL(MS.CodProtesto, 3), 1, 1),  
			   CC.DiasProtesto = MS.DiasProtesto,  
			   CC.IdMsgBoletoBancarioI = MS.IdMsgBoletoBancario  
			 FROM   MsgBoletosBancarios MS  
					LEFT JOIN #ConfigCNAB CC  
						 ON  MS.IdMsgBoletoBancario = @IdMsgBoletoBancarioI 
	   END
	   ELSE 
       BEGIN
      	 INSERT INTO #ConfigCNAB (IdMsgBoletoBancarioI,CodJuros,ValorJuros,CodMulta,ValorMulta,CodProtesto,DiasProtesto,  
                                    DescCod1,DescCod2,DescCod3)  
		 SELECT IdMsgBoletoBancario,CodJuros = SUBSTRING(ISNULL(CodJuros, 0), 1, 1),ValorJuros,CodMulta = SUBSTRING(ISNULL(CodMulta, 0), 1, 1),  
               ValorMulta,CodProtesto = SUBSTRING(ISNULL(CodProtesto, 3), 1, 1), DiasProtesto, 0,0,0  
         FROM   MsgBoletosBancarios  
         WHERE  IdMsgBoletoBancario = @IdMsgBoletoBancarioI  
      END        
     END 
/*===============================================================================================================================================
03.4-Se NÃO possui de desconto, insere apenas as configurações de MsgBoletosBancarios, Juros,Multa,Protestos
===============================================================================================================================================*/      
     ELSE  /*Se não possui de desconto, insere apenas as configurações de MsgBoletosBancarios, Juros,Multa,Protestos*/          
     BEGIN  
        INSERT INTO #ConfigCNAB (IdMsgBoletoBancarioI,CodJuros,ValorJuros,CodMulta,ValorMulta,CodProtesto,DiasProtesto,  
                                    DescCod1,DescCod2,DescCod3)  
        SELECT IdMsgBoletoBancario,CodJuros = SUBSTRING(ISNULL(CodJuros, 0), 1, 1),ValorJuros,CodMulta = SUBSTRING(ISNULL(CodMulta, 0), 1, 1),  
               ValorMulta,CodProtesto = SUBSTRING(ISNULL(CodProtesto, 3), 1, 1), DiasProtesto, 0,0,0  
        FROM   MsgBoletosBancarios  
        WHERE  IdMsgBoletoBancario = @IdMsgBoletoBancarioI   
     END  
 END --end desconsideraconfig    
   
 /*===================================================================================================================================================  
 04-Efetua a consulta utilizada na Unit uGeraRemessaRegistro.  
 ===================================================================================================================================================*/   
 IF @RemessaRegistro = 1  
 BEGIN  
     IF @TipoPessoa = 0  
     BEGIN  
         SET @TabelaPessoa = 'Profissionais'  
         SET @CampoPessoa = 'IdProfissional'  
         SET @sSqlPessoa =   
             'SELECT PF.IdProfissional,PF.Nome,PF.RegistroConselhoAtual,CNPJCPF = PF.CPF,PF.Processo,PF.CategoriaAtual,PF.SituacaoAtual,PF.Endereco,  
			         PF.NomeBairro,PF.NomeCidade,PF.SiglaUF,PF.CaixaPostal,PF.CEP,PF.IdTipoInscricao,
			         Pelomenosumend = ISNULL(ISNULL(PF.endereco, NULL) + CHAR(9) + ISNULL(PF.nomebairro, '' '') + CHAR(9) + ISNULL(PF.nomecidade, '' '') +
			                          CHAR(9) + ISNULL(PF.SiglaUF, '' '') + CHAR(9) + ISNULL(PF.CaixaPostal, '' '') + CHAR(9) + ISNULL(PF.CEP, '' ''),
									  (SELECT TOP 1 ISNULL(ED.endereco, '' '') + CHAR(9) + ISNULL(ED.nomebairro, '' '') + CHAR(9) + 
									                ISNULL(ED.nomecidade, '' '') + CHAR(9) + ISNULL(ED.SiglaUF, '' '') + CHAR(9) + 
									                ISNULL(ED.CaixaPostal, '' '') + CHAR(9) + ISNULL(ED.CEP, '' '')
										FROM Enderecos ED
										WHERE ED.IdProfissional = PF.IdProfissional
									   ORDER BY ED.correspondencia DESC
									   )) 
              FROM  Profissionais PF '
     END  
     ELSE   
     IF @TipoPessoa = 1  
     BEGIN  
         SET @TabelaPessoa = 'PessoasJuridicas'  
         SET @CampoPessoa = 'IdPessoaJuridica'   
         SET @sSqlPessoa =   
             'SELECT PJ.IdPessoaJuridica,PJ.Nome,PJ.RegistroConselhoAtual,CNPJCPF = PJ.CNPJ,PJ.Processo,PJ.CategoriaAtual,PJ.SituacaoAtual,PJ.Endereco,  
                     PJ.NomeBairro,PJ.NomeCidade,PJ.SiglaUF,PJ.CaixaPostal,PJ.CEP,PJ.IdTipoInscricao,                        
                     Pelomenosumend = ISNULL(ISNULL(PJ.endereco, NULL) + CHAR(9) + ISNULL(PJ.nomebairro, '' '') + CHAR(9) + ISNULL(PJ.nomecidade, '' '') +
			                          CHAR(9) + ISNULL(PJ.SiglaUF, '' '') + CHAR(9) + ISNULL(PJ.CaixaPostal, '' '') + CHAR(9) + ISNULL(PJ.CEP, '' ''),
									  (SELECT TOP 1 ISNULL(ED.endereco, '' '') + CHAR(9) + ISNULL(ED.nomebairro, '' '') + CHAR(9) + 
									                ISNULL(ED.nomecidade, '' '') + CHAR(9) + ISNULL(ED.SiglaUF, '' '') + CHAR(9) + 
									                ISNULL(ED.CaixaPostal, '' '') + CHAR(9) + ISNULL(ED.CEP, '' '')
										FROM Enderecos ED
										WHERE ED.IdPessoaJuridica = PJ.IdPessoaJuridica
									   ORDER BY ED.correspondencia DESC
									   ))   
             FROM PessoasJuridicas PJ '
     END  
     ELSE   
     IF @TipoPessoa = 2  
     BEGIN  
         SET @TabelaPessoa = 'Pessoas'  
         SET @CampoPessoa = 'IdPessoa'  
         SET @sSqlPessoa =   
             'SELECT PE.IdPessoa,PE.Nome,RegistroConselhoAtual = '''',PE.CNPJCPF,Processo = PE.NumeroProcessoPessoas,CategoriaAtual = '''',  
                     SituacaoAtual = '''',PE.Endereco,PE.NomeBairro,PE.NomeCidade,PE.SiglaUF,PE.CaixaPostal,PE.CEP,PE.IdTipoInscricao,  
                     Pelomenosumend = ISNULL(ISNULL(PE.endereco, NULL) + CHAR(9) + ISNULL(PE.nomebairro, '' '') + CHAR(9) + ISNULL(PE.nomecidade, '' '') +
			                          CHAR(9) + ISNULL(PE.SiglaUF, '' '') + CHAR(9) + ISNULL(PE.CaixaPostal, '' '') + CHAR(9) + ISNULL(PE.CEP, '' ''),
									  (SELECT TOP 1 ISNULL(ED.endereco,'' '') + CHAR(9) + ISNULL(ED.nomebairro, '' '') + CHAR(9) + 
									                ISNULL(ED.nomecidade, '' '') + CHAR(9) + ISNULL(ED.SiglaUF, '' '') + CHAR(9) + 
									                ISNULL(ED.CaixaPostal, '' '') + CHAR(9) + ISNULL(ED.CEP, '' '')
										FROM Enderecos ED
										WHERE ED.IdPessoa = PE.IdPessoa
									   ORDER BY ED.correspondencia DESC
									   ))  
             FROM Pessoas PE'
     END  
     ELSE  
         SET @ERRO = 1  
       
       
     IF @SomenteUltimaEmissao = 1  
         SET @sSqlSomenteUltimaEmissao =   
             ' WHERE (DE.IdDetalheEmissao = (SELECT TOP 1 DEI.IdDetalheEmissao FROM DetalhesEmissao DEI INNER JOIN ComposicoesEmissao CEI ON  
                     CEI.IdDetalheEmissao = DEI.IdDetalheEmissao WHERE CEI.IdDebito = CE.IdDebito ORDER BY DEI.DataEmissao DESC,DEI.IdDetalheEmissao DESC))'     
       
       
       
     SET @sWhere = ' AND CodBanco = ' + CHAR(39) + @CodBanco + CHAR(39) +  
                   ' AND CodCC_Conv_Ced = ' + CHAR(39) + @Convenio + CHAR(39)   
       
     IF @SituacaoRegistro <> 0  
         SET @sWhere = @sWhere + ' AND SituacaoRegistro = ' + CAST(@SituacaoRegistro AS VARCHAR)  
       
     IF @IdConfigRegistro <> 0  
         SET @sWhere = @sWhere + ' AND IdConfigRegistro = ' + CAST(@IdConfigRegistro AS VARCHAR)    
       
     IF @DesconsideraConfig = 0 
     IF @IdMsgBoletoBancarioI <> 0  
         SET @sWhere = @sWhere + ' AND IdMsgBoletoBancarioI = ' + CAST(@IdMsgBoletoBancarioI AS VARCHAR)     
       
     IF @NossoNumero <> ''  
         SET @sWhere = @sWhere + ' AND NossoNumero = ' + CHAR(39) + @NossoNumero   
             + CHAR(39)  
       
     IF @SeuNumero <> ''  
         SET @sWhere = @sWhere + ' AND SeuNumero = ' + CHAR(39) + @SeuNumero   
             + CHAR(39)  
       
     IF (@DataEmissaoIni <> '')  
        AND (@DataEmissaoFim <> '')  
         SET @sWhere = @sWhere +   
             ' AND (CONVERT(nvarchar(30), DataEmissao, 112)) ' +  
             ' BETWEEN (CONVERT(nvarchar(30), ' + @DataEmissaoIni +   
             ', 112)) ' +  
             '     AND (CONVERT(nvarchar(30), ' + @DataEmissaoFim +   
             ', 112)) '  
             
     IF @IdPessoa <> 0  
         SET @sWhereII = ' AND ' + @CampoPessoa + ' = ' + CAST(@IdPessoa AS VARCHAR) 
 
           
     SET @sSql = ' INSERT INTO #FiltroRemessaRegistro ' +  
				 '           (IdProfissional, ' +  
				 '            IdPessoaJuridica, ' +  
				 '            IdPessoa, ' +  
				 '            Nome, ' +  
				 '            RegistroConselhoAtual, ' +  
				 '            CNPJCPF, ' +  
				 '            Processo, ' +  
				 '            NProc, ' +  
				 '            CategoriaAtual, ' +  
				 '            Situacao, ' +  
				 '            E_PessoaJuridica, ' +  
				 '            Endereco, ' +  
				 '            NomeBairro, ' +  
				 '            NomeCidade, ' +  
				 '            SiglaUF, ' +  
				 '            CaixaPostal, ' +  
				 '            Cep, ' +  
				 '            [Pelo menos um end.],' +  
				 '            TipoInscricao, ' +  
				 '            NomeDebito, ' +  
				 '            SiglaDebito, ' +  
				 '            Moeda,' +  
				 '            DataReferencia, ' +  
				 '            [Ano referÃªncia],' +  
				 '            AnoRef, ' +  
				 '            NumeroParcela, ' +  
				 '            IdMoeda, ' +  
				 '            IdDebito, ' +  
				 '            IdTipoDebito,' +  
				 '            NumConjReneg, ' +  
				 '            NumConjTpDebito, ' +  
				 '            NumConjEmissao, ' +  
				 '            ValorPago,' +  
				 '            ValorDevido, ' +  
				 '            ValorOriginal, ' +  
				 '            TpEmissaoConjunta,' +  
				 '            SeuNumero, ' +  
				 '            NossoNumero, ' +  
				 '            DataVencimento, ' +  
				 '            ValorEmissao, ' +  
				 '            CodBanco, ' +  
				 '            CodCC_Conv_Ced, ' +  
				 '            IdDetalheEmissao,  ' +  
				 '            DataEmissao, ' +  
				 '            ValorDespBco, ' +  
				 '            ValorDespAdv, ' +  
				 '            ValorDespPostais, ' +  
				 '            TipoDaEmissao, ' + 
				 '            TipoComposicao, ' +  
				 '            Forma, ' +   
				 '            Situacao_Registro, ' +  
				 '            IdConfigRegistro, ' +  
				 '            IdMsgBoletoBancarioI,' + 
				 '            DescontoAplicado )' +  
           
				 ' SELECT DISTINCT  ' +  
				 '      DB.IdProfissional, ' +  
				 '      DB.IdPessoaJuridica, ' +  
				 '      DB.IdPessoa, ' +  
				 '      PP.Nome, ' +  
				 '      PP.RegistroConselhoAtual, ' +  
				 '      PP.CNPJCPF, ' +  
				 '      PP.Processo, ' +  
				 '      REPLICATE(''0'', 20 - LEN(PP.Processo)) + PP.Processo AS NProc, '   +  
				 '      PP.CategoriaAtual, ' +  
				 '      PP.SituacaoAtual, ' +  
				 '      0, ' +  
				 '      PP.Endereco, ' +  
				 '      PP.NomeBairro, ' +  
				 '      PP.NomeCidade, ' +  
				 '      PP.SiglaUF, ' +  
				 '      PP.CaixaPostal, ' +  
				 '      PP.CEP, ' +  
				 '      [Pelo menos um end.] = PP.Pelomenosumend,' +  
				 '      TI.TipoInscricao, ' +  
				 '      TD.NomeDebito, ' +  
                 '      TD.SiglaDebito, ' +  
				 '      Md.Moeda, ' +  
				 '      DB.DataReferencia, ' +  
				 '      YEAR(DB.DataReferencia), ' +  
				 '      CAST(YEAR(DB.DataReferencia) AS VARCHAR(4)), ' +  
				 '      DB.NumeroParcela, ' +  
				 '      DB.IdMoeda, ' +  
				 '      DB.IdDebito, ' +  
				 '      DB.IdTipoDebito,' +    
				 '      DB.NumConjReneg, ' +  
				 '      DB.NumConjTpDebito, ' +  
				 '      DB.NumConjEmissao, ' +  
				 '      DB.ValorPago, ' +  
				 '      DE.ValorEmissao, ' +  
				 '      DE.ValorEmissao, ' +  
				 '      DB.TpEmissaoConjunta, ' +  
				 '      DE.SeuNumero, ' +  
				 '      DE.NossoNumero, ' +  
				 '      DE.DataVencimento, ' +  
				 '      DE.ValorEmissao, ' +  
				 '      DE.CodBanco, ' +  
				 '      DE.CodCC_Conv_Ced, ' +  
				 '      DE.IdDetalheEmissao, ' +  
				 '      DE.DataEmissao, ' +  
				 '      CE.ValorDespBco, ' +  
				 '      CE.ValorDespAdv, ' +  
				 '      CE.ValorDespPostais, ' +  
				 '      TipoDaEmissao = CASE WHEN TipoEmissao = 1 THEN ''Impressão em boletas'' ' +  
				 '                           WHEN TipoEmissao = 2 THEN ''Arquivo para o banco'' ' +   
				 '                           WHEN TipoEmissao = 3 THEN ''Impressão de recibo'' ' +   
				 '                           WHEN TipoEmissao = 5 THEN ''Débito em Conta'' ' +  
				 '                           WHEN TipoEmissao = 6 THEN ''Envio de email'' END,' + 
				 '      TipoComposicao, ' + 				 
				 '      Forma = CASE WHEN TipoComposicao = 0 THEN ''Normal'' '+ 
				 '                   WHEN TipoComposicao = 1 THEN ''Unificada'' ' + 
				 '                   WHEN TipoComposicao = 2 THEN ''Conjunta'' ' + 
				 '                   WHEN TipoComposicao = 3 THEN ''Associada'' END, ' +
				 '      [Situacao_Registro] = CASE SituacaoRegistro WHEN 1 THEN ''Aguardando Remessa''  ' +   
				 '                                                  WHEN 2 THEN ''RemessaGerada'' ' +   
				 '                                                  WHEN 3 THEN ''Registrado'' ' +  
				 '                                                  WHEN 4 THEN ''Recusado'' ' +  
				 '                                                  WHEN 5 THEN ''2ªViaEmissão''' +    
				 '                                                  ELSE  '''' END,  ' +          
				 '      DE.IdConfigRegistro, ' +  
				 '      DE.IdMsgBoletoBancarioI, ' +
				 '      DE.DescontoAplicado ' +   
				 ' FROM (SELECT IdDetalheEmissao,NossoNumero,SeuNumero,DataEmissao,DataVencimento,DataAtualizacaoEncargos,' +  
				 '    ValorEmissao,TipoEmissao,TipoComposicao,CodBanco,CodAgencia,CodOperacao,CodCC_Conv_Ced,' 	 +  
				 '    SituacaoRegistro,IdConfigRegistro,IdMsgBoletoBancarioI,DescontoAplicado '  +  
				 '   FROM   DetalhesEmissao  ' +  
				 '   WHERE SituacaoRegistro IS NOT NULL ' + @sWhere +  
				 '  )DE ' +  
				 '  INNER JOIN  ' +  
				 '  (SELECT IdDetalheEmissao,IdDebito,IdMoedaDevida,SiglaDebito,NumeroParcela,DataReferenciaDebito,DataVencimentoDebito,ValorDevido, '  +  
				 '    ValorPrincipal,ValorAtualizacao,ValorMulta,ValorJuros,ValorDespBco,ValorDespAdv,ValorDespPostais,IdProcedimento  ' 			 +  
				 '  FROM ComposicoesEmissao  ' +  
				 '  )CE ON CE.IdDetalheEmissao = DE.IdDetalheEmissao ' +  
				 '  INNER JOIN  ' +  
				 '  (SELECT IdDebito,IdProfissional,IdPessoaJuridica,IdPessoa,DataReferencia,NumeroParcela,IdMoeda,IdSituacaoAtual, ' 	 +  
				 '    IdTipoDebito,NumConjReneg,NumConjTpDebito,NumConjEmissao,ValorPago,ValorDevido,TpEmissaoConjunta ' 				 +  
				 '   FROM Debitos ' +  
				 '   WHERE IdSituacaoAtual IN (''1'', ''3'', ''10'', ''15'') AND (NossoNumero IS NOT NULL) AND (NossoNumero <> '''') ' 	 +  
				 '  AND (ISNULL(AutorizaDebitoConta,0) = 0) ' + @sWhereII +  
				 '  ) DB ON DB.IdDebito = CE.IdDebito ' +  
				 ' INNER JOIN SituacoesDebito SD ON  SD.IdSituacaoDebito = DB.IdSituacaoAtual '  +  
				 ' INNER JOIN TiposDebito TD ON  TD.IdTipoDebito = DB.IdTipoDebito '  			 +  
				 ' INNER JOIN Moedas MD ON  MD.IdMoeda = DB.IdMoeda ' +  
				 ' INNER JOIN  ' +  
				 ' (' + @sSqlPessoa +
				 ' ) PP ON  DB.' + @CampoPessoa + ' = PP.' + @CampoPessoa +  
				 ' LEFT JOIN TiposInscricao TI ON  TI.IdTipoInscricao = PP.IdTipoInscricao  '   
				 + @sSqlSomenteUltimaEmissao +  
				 ' ORDER BY PP.Nome, PP.RegistroConselhoAtual, DB.DataReferencia, DB.NumeroParcela '  
       
     EXEC (@ssql)  
 END  
 /*===================================================================================================================================================  
 05-Efetua as consultas  
 ===================================================================================================================================================*/   
 IF @RemessaRegistro = 1 /*Consulta utilizada na Unit uGeraRemessaRegistro*/  
 BEGIN 
 	IF @ValidaCPFCNPJEndereco = 1 
 	BEGIN   	 
		 SELECT FR.*,  
				CC.* 
		 FROM   #FiltroRemessaRegistro FR  
				LEFT JOIN #ConfigCNAB CC  
					 ON CC.IdMsgBoletoBancarioI = FR.IdMsgBoletoBancarioI
			WHERE CASE ISNULL(CC.NumeroParcela,999) WHEN 999 THEN 999 ELSE CC.NumeroParcela END = 
    			  CASE ISNULL(CC.NumeroParcela,999) WHEN 999 THEN 999 ELSE FR.NumeroParcela END
     		AND (dbo.ValidaCpfCnpj(FR.CNPJCPF) = 1) AND (FR.[Pelo menos um end.] IS NOT NULL)
     	
 	END
 	ELSE 
 	BEGIN 	
		 SELECT FR.*,  
				CC.* 
		 FROM   #FiltroRemessaRegistro FR  
				LEFT JOIN #ConfigCNAB CC  
					 ON CC.IdMsgBoletoBancarioI = FR.IdMsgBoletoBancarioI
			WHERE CASE ISNULL(CC.NumeroParcela,999) WHEN 999 THEN 999 ELSE CC.NumeroParcela END = 
    			  CASE ISNULL(CC.NumeroParcela,999) WHEN 999 THEN 999 ELSE FR.NumeroParcela END
			AND (dbo.ValidaCpfCnpj(FR.CNPJCPF) = 0) OR (FR.[Pelo menos um end.] IS NULL)
    END      
 END  
 ELSE  
 BEGIN  
     /*Consulta que retorna as opções de juros,multa,protesto,descontos*/  
     SELECT *  
     FROM   #ConfigCNAB  
     WHERE  IdMsgBoletoBancarioI = @IdMsgBoletoBancarioI  
 END
