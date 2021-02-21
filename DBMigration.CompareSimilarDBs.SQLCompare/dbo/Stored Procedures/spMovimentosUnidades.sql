
/* Caroline Crisóstomo - 28/05/2012 - Oc.91233
 Alteração de Descrição do Nome da Unidade. Incluído um caase para alternar entre 
 'Itens Devolvidos ao Fornecedor' e 'Itens Ajustados via Inventário' */
/* Lucimara - 28/08/2012 - Oc.97099 - Exibir itens devolvidos ao Almoxarifado */
/*Oc. 120606 - BUG 494 - Sergio*/ 

CREATE PROCEDURE [dbo].[spMovimentosUnidades]    
@DataInicial datetime,   
@DataFinal datetime, 
@MovimentacaoRP1 bit,
@MovimentacaoRP2 bit,
@IdTipoMovimentacao INT,
@ItensDevolvidosAlmox BIT
AS
SET NOCOUNT ON  

CREATE TABLE #Referencia  
 (  
  IdItem   int,  
  DataReferencia  datetime,  
  ValorReferencia  money  
 )  
  
INSERT #Referencia  
 SELECT Itens.IdItem, ItemReferencia.DataValorReferencia, IsNull(ItemReferencia.ValorReferencia ,0)  
 FROM Itens  
 LEFT JOIN   
 (  
  SELECT IdItem, DataValorReferencia, ValorReferencia  
  FROM Itens  
  WHERE /*DataValorReferencia <= @datafinal  
  and */DataValorReferencia Is Not Null  
 -- and ValorReferencia Is Not Null  -- Alteração para a Oc. 89721 
 ) ItemReferencia  
 ON ItemReferencia.IdItem = Itens.IdItem  
  
UPDATE #Referencia  
 SET ValorReferencia= UltimaEntrega.ValorReferencia  
 FROM #Referencia,  
 (  
  SELECT IdItem, Max(DataReferencia) As DataReferencia, Max(ValorReferencia) As ValorReferencia  
  FROM EntregasOrdens  
    INNER JOIN SubItens ON SubItens.IdSubItem = EntregasOrdens.IdSubItem  
  WHERE DataReferencia <= @datafinal  
  GROUP BY IdItem  
 ) UltimaEntrega  
 WHERE #Referencia.IdItem = UltimaEntrega.IdItem  
 and (UltimaEntrega.DataReferencia > #Referencia.DataReferencia  
 or #Referencia.DataReferencia Is Null)  

SELECT * FROM (  
SELECT  
 SubItens.IdSubItem, Itens.CodigoItem, SubItens.NomeSubItem, 
 ISNULL(Unidades.CodigoUnidade, 9999) AS CodigoUnidade, 
 ISNULL(Unidades.NomeUnidade, CASE WHEN MovimentacoesItens.IdInventario IS NULL THEN 'Itens Devolvidos ao Fornecedor'
				   ELSE 'Itens Ajustados via Inventário' END) AS NomeUnidade,   
 Unidades.SiglaUnidade,  GruposItens.NomeGrupoItem, SUM(-MovimentacoesItens.Qtd) AS Qtd,   
 -- SUM(-MovimentacoesItens.Qtd * #Referencia.ValorReferencia) AS Valor,
 SUM(-ValorMovimento) AS Valor,  
 ( SELECT  ISNULL(SUM(Qtd),0) FROM MovimentacoesItens  
 WHERE DataMovimentacao <= @DataFinal  
       AND MovimentacoesItens.IdSubItem = SubItens.IdSubItem  
       AND MovimentacoesItens.IdMovimentacaoItem <=  
          ( SELECT TOP 1 IdMovimentacaoItem FROM MovimentacoesItens  
             WHERE DataMovimentacao <= @DataFinal  
                   AND MovimentacoesItens.IdSubItem = SubItens.IdSubItem  
            ORDER BY IdMovimentacaoItem desc ) ) AS SaldoMovimento  ,
Itens.SemValorReferencia -- Oc. 89721 - Alteração para exibir os itens sem valor de referência.
FROM MovimentacoesItens   
LEFT JOIN Unidades ON MovimentacoesItens.IdUnidade = Unidades.IdUnidade  
inner JOIN SubItens ON MovimentacoesItens.IdSubItem = SubItens.IdSubItem  
inner JOIN Itens ON Itens.IdItem = SubItens.IdItem 
inner JOIN GruposItens ON Itens.IdGrupoItem = GruposItens.IdGrupoItem      
inner JOIN #Referencia ON SubItens.IdItem = #Referencia.IdItem  
WHERE DataMovimentacao >= @DataInicial  
  AND DataMovimentacao <= @DataFinal 
  AND ((MovimentacoesItens.Qtd < 0) or ((@ItensDevolvidosAlmox = 1) AND (MovimentacoesItens.Qtd > 0) and (MovimentacoesItens.IdTipoMovimentacao = @IdTipoMovimentacao)))
  AND ((MovimentacaoDeRegistroPreco = @MovimentacaoRP1) or (MovimentacaoDeRegistroPreco = @MovimentacaoRP2))  
GROUP BY SubItens.IdSubItem, Itens.CodigoItem, SubItens.NomeSubItem, Unidades.CodigoUnidade, Unidades.NomeUnidade, Unidades.SiglaUnidade, GruposItens.NomeGrupoItem, Itens.SemValorReferencia, MovimentacoesItens.IdInventario  

) AS MovPorUnidade
 WHERE  (( Valor <> 0  and SemValorReferencia = 0 )
    or ( Valor = 0 and SemValorReferencia = 1)) 
 --  Oc. 58948 - Foi colocada esta restrição para NÃO exibir movimentações cujo somatório dos atendimentos menos as devoluções ao almoxarifado seja igual a zero.
 --  Oc. 89721 - Alteração para exibir os itens sem valor de referência.

ORDER BY CodigoUnidade, NomeUnidade, NomeSubItem  

DROP TABLE #Referencia


