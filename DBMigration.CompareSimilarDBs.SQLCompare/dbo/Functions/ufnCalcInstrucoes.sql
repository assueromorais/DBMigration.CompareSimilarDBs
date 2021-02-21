/* Oc. 180315 Criado por Seila e Adicionado por Wanderson */

/*Script02=======================================================================================================================================*/
CREATE FUNCTION [dbo].[ufnCalcInstrucoes] 
        (@IdConfigGeracaoDebito INT, 
         @IdMsgBoletoBancarioI INT,
         @Formato BIT, 
         @DescontoVlr BIT)
        
RETURNS @result TABLE  (
						IdConfigGeracaoDebito INT, 
						IdMsgBoletoBancarioI  INT,  
						NumeroParcela         INT,  
						CodJuros      VARCHAR(40),  
						ValorJuros          MONEY,  
						CodMulta      VARCHAR(40),  
						ValorMulta          MONEY,  
						CodProtesto   VARCHAR(40),  
						DiasProtesto          INT,  
						DescCod1              INT,  
						DescData1        DATETIME,  
						DescValor1          MONEY,  
						DescCod2              INT,  
						DescData2        DATETIME,  
						DescValor2          MONEY, 
						DescCod3              INT,  
						DescData3        DATETIME,  
						DescValor3          MONEY 
						)      
AS
BEGIN   
	IF @IdConfigGeracaoDebito > 0
	BEGIN 
		IF @Formato = 0  /*Pivot*/
        BEGIN 
		   INSERT INTO @result  (IdConfigGeracaoDebito,IdMsgBoletoBancarioI,NumeroParcela,DescCod1,DescCod2,DescCod3,  
                                 DescData1,DescData2,DescData3,DescValor1,DescValor2,DescValor3)
				SELECT  IdConfigGeracaoDebito,@IdMsgBoletoBancarioI,NumeroParcela 
						,DescCod1 = (MAX(case when Coluna=1 then case @DescontoVlr WHEN 1 then 0 ELSE CAST(E_Percentual AS INT) END END)) + 1
						,DescCod2 = (MAX(case when Coluna=2 then case @DescontoVlr WHEN 1 then 0 ELSE CAST(E_Percentual AS INT) END END)) + 1 
						,DescCod3 = (MAX(case when Coluna=3 then case @DescontoVlr WHEN 1 then 0 ELSE CAST(E_Percentual AS INT) END END)) + 1
						,DescData1 = MAX(case when Coluna=1 then DataPgtoDesconto end)
						,DescData2 = MAX(case when Coluna=2 then DataPgtoDesconto end)
						,DescData3 = MAX(case when Coluna=3 then DataPgtoDesconto end) 
						,DescValor1 = ISNULL(MAX(case when Coluna=1 then case @DescontoVlr WHEN 1 then DescontoEmValor ELSE ValorPgtoDesconto  END END),0)
						,DescValor2 = ISNULL(MAX(case when Coluna=2 then case @DescontoVlr WHEN 1 then DescontoEmValor ELSE ValorPgtoDesconto  END END),0)
						,DescValor3 = ISNULL(MAX(case when Coluna=3 then case @DescontoVlr WHEN 1 then DescontoEmValor ELSE ValorPgtoDesconto  END END),0) 
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
         ELSE
         BEGIN  
                 INSERT INTO @result (IdConfigGeracaoDebito,IdMsgBoletoBancarioI,NumeroParcela,DescCod1,DescData1,DescValor1)  
                 SELECT CP.IdConfigGeracaoDebito,@IdMsgBoletoBancarioI,CP.Numeroparcela,
                        DescCod1 = CASE @DescontoVlr WHEN 1 THEN 1 ELSE CAST(Op.E_Percentual AS INT) + 1 END,OP.DataPgtoDesconto,
                        CASE @DescontoVlr WHEN 1 THEN CAST(((CP.ValorParcela * OP.ValorPgtoDesconto)/100) AS MONEY) 
                                        ELSE OP.ValorPgtoDesconto END   
                 FROM   ConfigParcelasDebito CP  
                        INNER JOIN OpcoesPgtoDesconto OP  
                             ON  CP.IdConfigParcelaDebito = OP.IdConfigParcelaDebito  
                 WHERE  CP.IdConfigGeracaoDebito = CAST(@IdConfigGeracaoDebito AS VARCHAR)
                    AND ((CONVERT(VARCHAR,OP.DataPgtoDesconto,112) >= CONVERT(VARCHAR,GETDATE(),112)) OR (OP.DataPgtoDesconto IS NULL ))   
         END 
      
		 IF (SELECT COUNT(*) FROM @result ) > 0  /*Devido a crítica da DataPgtoDesconto, apesar de haver configuração de desconto, pode ser que não retorno resultados*/
		 BEGIN   
		   UPDATE @result  
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
					LEFT JOIN @result CC  
						 ON  MS.IdMsgBoletoBancario = @IdMsgBoletoBancarioI
		 END
		 ELSE
		 BEGIN
			INSERT INTO @result (IdMsgBoletoBancarioI,CodJuros,ValorJuros,CodMulta,ValorMulta,CodProtesto,DiasProtesto,  
                                    DescCod1,DescCod2,DescCod3)  
    		SELECT IdMsgBoletoBancario,CodJuros = SUBSTRING(ISNULL(CodJuros, 0), 1, 1),ValorJuros,CodMulta = SUBSTRING(ISNULL(CodMulta, 0), 1, 1),  
				   ValorMulta,CodProtesto = SUBSTRING(ISNULL(CodProtesto, 3), 1, 1), DiasProtesto, 0,0,0  
			FROM   MsgBoletosBancarios  
			WHERE  IdMsgBoletoBancario = @IdMsgBoletoBancarioI  	
		 END   
    END 
    ELSE 
    BEGIN
		INSERT INTO @result (IdMsgBoletoBancarioI,CodJuros,ValorJuros,CodMulta,ValorMulta,CodProtesto,DiasProtesto,  
                                    DescCod1,DescCod2,DescCod3)  
    	SELECT IdMsgBoletoBancario,CodJuros = SUBSTRING(ISNULL(CodJuros, 0), 1, 1),ValorJuros,CodMulta = SUBSTRING(ISNULL(CodMulta, 0), 1, 1),  
               ValorMulta,CodProtesto = SUBSTRING(ISNULL(CodProtesto, 3), 1, 1), DiasProtesto, 0,0,0  
        FROM   MsgBoletosBancarios  
        WHERE  IdMsgBoletoBancario = @IdMsgBoletoBancarioI 
    END
    RETURN
END
