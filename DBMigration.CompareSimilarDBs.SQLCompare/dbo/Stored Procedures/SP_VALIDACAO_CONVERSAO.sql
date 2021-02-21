 /*Oc137425 Task 2810 Sergio Adicionado por Michel*/

CREATE PROCEDURE [dbo].[SP_VALIDACAO_CONVERSAO]
AS

IF EXISTS (SELECT 1 FROM SYS.tables t WHERE t.name='Ocorrencias_Validacao')
BEGIN
		TRUNCATE TABLE Ocorrencias_Validacao
END
ELSE
BEGIN
		CREATE TABLE Ocorrencias_Validacao (
		Tabela VARCHAR(30),
		Mensagem VARCHAR(200))
END

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Unidades','Existe nome de unidade não preenchido'
FROM Unidades
WHERE NomeUnidade IS NULL

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Unidades','Existe nome de unidade não preenchido'
FROM Unidades
WHERE len(rtrim(ltrim(NomeUnidade))) < 2  


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Unidades','Unidade: ' + NomeUnidade + '. Está com nome duplicado'  
FROM Unidades
GROUP BY NomeUnidade
HAVING COUNT(*) > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Unidades',' Unidade: ' + NomeUnidade + '. Código da unidade não preenchido'
FROM Unidades
WHERE CodigoUnidade IS NULL

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Unidades', ' Unidade: ' + NomeUnidade + '. Código da unidade não preenchido'
FROM Unidades
WHERE len(CodigoUnidade) < 0

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Unidades',' Código= ' + T1.CodigoUnidade + ' Unidade: ' + NomeUnidade + '. Unidade com código duplicado'  
FROM (SELECT CodigoUnidade
		FROM Unidades
		GROUP BY CodigoUnidade
		HAVING COUNT(*) > 1) T1
	 INNER JOIN Unidades T2 ON T1.CodigoUnidade=T2.CodigoUnidade


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'TiposBens',' Tipo Bem: ' + Tipo + '. Nome tipo bem não preenchido'
FROM TiposBens
WHERE Tipo IS NULL

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'TiposBens',' Tipo Bem: ' + Tipo + '. Nome tipo bem não preenchido ou inválido'
FROM TiposBens
WHERE len(rtrim(ltrim(Tipo))) < 2


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'TiposBens',' Tipo bem = ' + T1.Tipo + '. Nome do tipo de bem duplicado'  
FROM (SELECT Tipo
		FROM TiposBens
		GROUP BY Tipo
		HAVING COUNT(*) > 1) T1
	 INNER JOIN TiposBens T2 ON T1.Tipo=T2.Tipo

/*
* 
* Tabelas de Cargos.
•	Campo “Nome” de preenchimento obrigatório.
•	Campo “Nome” com duplicidade.

*/

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Cargos',' Código: ' + CONVERT(VARCHAR(20),IdCargo) + '. Cargo não preenchido ou inválido'
FROM Cargos
WHERE len(rtrim(ltrim(Cargo))) < 2 OR Cargo IS NULL 


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'Cargos',' Cargo = ' + T1.Cargo + '. Nome do cargo duplicado'  
FROM (SELECT Cargo
		FROM Cargos
		GROUP BY Cargo
		HAVING COUNT(*) > 1) T1
	 INNER JOIN Cargos T2 ON T1.Cargo=T2.Cargo
	 
/*
* 5.	Tabelas de Tipos de Seguros.
•	Campo “Nome” de preenchimento obrigatório.
•	Campo “Nome” com duplicidade.
*/

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'TiposSeguros',' Código: ' + CONVERT(VARCHAR(20),IdTipoSeguro) + '. Tipo Seguro não preenchido ou inválido'
FROM dbo.TiposSeguros
WHERE len(rtrim(ltrim(TipoSeguro))) < 2 OR TipoSeguro IS NULL 


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'TipoSeguro',' Tipo Seguro = ' + T1.TipoSeguro + '. Nome do tipo seguro duplicado'  
FROM (SELECT TipoSeguro
		FROM TiposSeguros
		GROUP BY TipoSeguro
		HAVING COUNT(*) > 1) T1
	 INNER JOIN TiposSeguros T2 ON T1.TipoSeguro=T2.TipoSeguro

/*
* 6.	Tabelas de Medidas de Garantia.
•	Campo “Nome” de preenchimento obrigatório.
•	Campo “Nome” com duplicidade.

*/


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'MedidasGarantia',' Código: ' + CONVERT(VARCHAR(20),IdMedidaDuracaoGarantia) + '. Medidas duração garantia não preenchido ou inválido'
FROM dbo.MedidasGarantia
WHERE len(rtrim(ltrim(MedidaDuracaoGarantia))) < 2 OR MedidaDuracaoGarantia IS NULL 


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'MedidasGarantia',' Tipo Seguro = ' + T1.MedidaDuracaoGarantia + '. Nome do tipo seguro duplicado'  
FROM (SELECT MedidaDuracaoGarantia
		FROM MedidasGarantia
		GROUP BY MedidaDuracaoGarantia
		HAVING COUNT(*) > 1) T1
	 INNER JOIN MedidasGarantia T2 ON T1.MedidaDuracaoGarantia=T2.MedidaDuracaoGarantia

/*
* 
* Tabelas de Estado de Conservação
•	Campo “Nome” de preenchimento obrigatório.
•	Campo “Nome” com duplicidade.
	 
*/

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'EstadosConservacao',' Código: ' + CONVERT(VARCHAR(20),IdEstadoConservacao) + '. Estado de Conservação não preenchido ou inválido'
FROM dbo.EstadosConservacao
WHERE len(rtrim(ltrim(EstadoConservacao))) < 2 OR EstadoConservacao IS NULL 


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'EstadoConservacao',' Estado de Conservação = ' + T1.EstadoConservacao + '. Estado de Conservação duplicado'  
FROM (SELECT EstadoConservacao
		FROM EstadosConservacao
		GROUP BY EstadoConservacao
		HAVING COUNT(*) > 1) T1
	 INNER JOIN EstadosConservacao T2 ON T1.EstadoConservacao=T2.EstadoConservacao

/*
* 
* Tabelas de Formas de Aquisição.
•	Campo “Nome” de preenchimento obrigatório.
•	Campo “Nome” com duplicidade.
*/

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'FormasAquisicao',' Código: ' + CONVERT(VARCHAR(20),IdFormaAquisicao) + '. Formas de Aquisição não preenchido ou inválido'
FROM dbo.FormasAquisicao
WHERE len(rtrim(ltrim(FormaAquisicao))) < 2 OR FormaAquisicao IS NULL 


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'FormasAquisicao',' Formas de Aquisição = ' + T1.FormaAquisicao + '. Formas de Aquisição duplicado'  
FROM (SELECT FormaAquisicao
		FROM FormasAquisicao
		GROUP BY FormaAquisicao
		HAVING COUNT(*) > 1) T1
	 INNER JOIN FormasAquisicao T2 ON T1.FormaAquisicao=T2.FormaAquisicao

/*
* Tabelas de Formas de Baixa.
•	Campo “Nome” de preenchimento obrigatório.
•	Campo “Nome” com duplicidade.
* 
*/

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'FormasBaixa',' Código: ' + CONVERT(VARCHAR(20),IdFormaBaixa) + '. Formas de Baixa não preenchido ou inválido'
FROM dbo.FormasBaixa
WHERE len(rtrim(ltrim(FormaBaixa))) < 2 OR FormaBaixa IS NULL 


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'FormasBaixa',' Formas de Baixa = ' + T1.FormaBaixa + '. Formas de Baixa duplicado'  
FROM (SELECT FormaBaixa
		FROM FormasBaixa
		GROUP BY FormaBaixa
		HAVING COUNT(*) > 1) T1
	 INNER JOIN FormasBaixa T2 ON T1.FormaBaixa=T2.FormaBaixa

/*
* Tabelas de Comarca.
•	Campo “Nome” de preenchimento obrigatório.
•	Campo “Nome” com duplicidade.
*/

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Comarcas',' Código: ' + CONVERT(VARCHAR(20),IdComarca) + '. Nome da Comarca não preenchido ou inválido'
FROM dbo.Comarcas
WHERE len(rtrim(ltrim(NomeComarca))) < 2 OR NomeComarca IS NULL 


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'Comarcas',' Comarca = ' + T1.NomeComarca + '. Nome da Comarca duplicado'  
FROM (SELECT NomeComarca
		FROM Comarcas
		GROUP BY NomeComarca
		HAVING COUNT(*) > 1) T1
	 INNER JOIN Comarcas T2 ON T1.NomeComarca=T2.NomeComarca


/*
* Tabelas de Bens Móveis.
•	Campo “Descrição” de preenchimento obrigatório.
•	Campo “Código” de preenchimento obrigatório.
•	Campo “Código” com duplicidade.
•	Campo “Valor de aquisição” de preenchimento obrigatório.
•	Campo “Conta” de preenchimento obrigatório. Utilizado no “De – Para”.
*/

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensMoveis',' Código: ' + CodigoItem + '. Nome do item móvel não preenchido ou inválido'
FROM dbo.ItensMoveis
WHERE len(rtrim(ltrim(NomeItem))) < 2 OR NomeItem IS NULL 

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensMoveis',' Item Movel: ' + CodigoItem + ' - ' + NomeItem + '. Descrição do item móvel não preenchido ou inválido'
FROM dbo.ItensMoveis
WHERE len(rtrim(ltrim(CONVERT(VARCHAR(1000),Descricao)))) < 2 OR Descricao IS NULL 

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensMoveis',' Item Movel: ' + CodigoItem + ' - ' + NomeItem + '. Código não preenchido ou inválido'
FROM dbo.ItensMoveis
WHERE CodigoItem IS NULL 

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'ItensMoveis',' Item Movel = ' + t1.CodigoItem + ' - '+ T2.NomeItem + '. Código do item móvel duplicado'  
FROM (SELECT CodigoItem
		FROM ItensMoveis
		GROUP BY CodigoItem
		HAVING COUNT(*) > 1) T1
	 INNER JOIN ItensMoveis T2 ON T1.CodigoItem=T2.CodigoItem
	 
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensMoveis',' Item Movel: ' + CodigoItem + ' - ' + NomeItem + '. Valor de aquisição não preenchido ou inválido'
FROM dbo.ItensMoveis
WHERE ValorAquisicao <= 0

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensMoveis',' Item Movel: ' + NomeItem + '. Conta não preenchido ou inválido'
FROM dbo.ItensMoveis
WHERE IdConta IS NULL 


/*
* Tabelas de Bens Imóveis.
•	Campo “Descrição” de preenchimento obrigatório.
•	Campo “Código” de preenchimento obrigatório.
•	Campo “Código” com duplicidade.
•	Campo “Valor de aquisição” de preenchimento obrigatório.
•	Campo “Conta” de preenchimento obrigatório. Utilizado no “De – Para”.
* 
*/


INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensImoveis',' Código: ' + CodigoItem  + '. Nome do item imóvel não preenchido ou inválido'
FROM dbo.ItensImoveis
WHERE len(rtrim(ltrim(NomeItem))) < 2 OR NomeItem IS NULL 

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensImoveis',' Item Imóvel: ' + CodigoItem +' - '+ NomeItem + '. Descrição do item imóvel não preenchido ou inválido'
FROM dbo.ItensImoveis
WHERE len(rtrim(ltrim(CONVERT(VARCHAR(1000),Descricao)))) < 2 OR Descricao IS NULL 

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensImoveis',' Item Imóvel: ' + CodigoItem + ' - ' + NomeItem + '. Código não preenchido ou inválido'
FROM dbo.ItensImoveis
WHERE CodigoItem IS NULL 

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'ItensImoveis',' Item Imóvel = ' + t1.CodigoItem + ' - ' + T2.NomeItem + '. Código do item móvel duplicado'  
FROM (SELECT CodigoItem
		FROM ItensImoveis
		GROUP BY CodigoItem
		HAVING COUNT(*) > 1) T1
	 INNER JOIN ItensImoveis T2 ON T1.CodigoItem=T2.CodigoItem
	 
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensImoveis',' Item Imóvel: ' + CodigoItem + ' - ' + NomeItem + '. Valor de aquisição não preenchido ou inválido'
FROM dbo.ItensImoveis
WHERE ValorAquisicao <= 0

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensImoveis',' Item Imóvel: ' + CodigoItem + ' - '+ NomeItem + '. Conta não preenchido ou inválido'
FROM dbo.ItensImoveis
WHERE IdConta IS NULL 

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensImoveis',' Item Móvel: ' + CodigoItem + ' - '+ NomeItem + '. Reavaliado com data anterior a 01/07/1994'
FROM dbo.ItensMoveis
WHERE (
	SELECT TOP 1 r.DataReavaliacao 
	FROM dbo.Reavaliacoes r
	WHERE r.IdItem = dbo.ItensMoveis.IdItem
	ORDER BY r.DataReavaliacao DESC) < '19940701'
AND (DataBaixa IS NULL OR DataBaixa > '19940701')
	
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ItensImoveis',' Item Imóvel: ' + CodigoItem + ' - '+ NomeItem + '. Reavaliado com data anterior a 01/07/1994'
FROM dbo.ItensImoveis
WHERE (
	SELECT TOP 1 r.DataReavaliacao 
	FROM dbo.Reavaliacoes r
	WHERE r.IdItem = dbo.ItensImoveis.IdItem
	ORDER BY r.DataReavaliacao DESC) < '19940701'
AND (DataBaixa IS NULL OR DataBaixa > '19940701')

SELECT *
FROM Ocorrencias_Validacao
ORDER BY Tabela, Mensagem

