CREATE PROCEDURE [dbo].[SP_VALIDACAO_CONVERSAO_SIALM]
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

DELETE FROM Ocorrencias_Validacao

-- Unidades
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Unidades', 'Nome repetido: '+NomeUnidade
FROM (SELECT NomeUnidade, count(*) AS conta FROM Unidades GROUP BY NomeUnidade) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Unidades', 'Código repetido: '+CodigoUnidade
FROM (SELECT CodigoUnidade, count(*) AS conta FROM Unidades GROUP BY CodigoUnidade) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Responsaveis', 'Nome repetido: '+NomeResponsavel
FROM (SELECT NomeResponsavel, count(*) AS conta FROM Responsaveis GROUP BY NomeResponsavel) u WHERE conta > 1


-- Modalidades Compra
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'ModalidadesCompra', 'Nome repetido: '+ModalidadeCompra
FROM (SELECT ModalidadeCompra, count(*) AS conta FROM ModalidadesCompra GROUP BY ModalidadeCompra) u WHERE conta > 1


-- Unidades de Medida
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Medidas', 'Nome repetido: '+NomeMedida
FROM (SELECT NomeMedida, count(*) AS conta FROM Medidas GROUP BY NomeMedida) u WHERE conta > 1

-- Naturezas Almoxarifado

-- Grupos Itens
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Grupos Itens', 'Nome repetido: '+NomeGrupoItem
FROM (SELECT NomeGrupoItem, count(*) AS conta FROM GruposItens GROUP BY NomeGrupoItem) u WHERE conta > 1

-- Itens
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Itens', 'Nome repetido: ' + CodigoItem + ' - ' + u.NomeItem
FROM (SELECT NomeItem, count(*) AS conta FROM itens GROUP BY NomeItem) u 
JOIN Itens i ON i.NomeItem = u.NomeItem
WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Itens', 'Código repetido: ' + CodigoItem + ' - ' + CodigoItem
FROM (SELECT CodigoItem, count(*) AS conta FROM itens GROUP BY CodigoItem) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
select 'Itens', 'Com estoque sem movimentação: ' + CodigoItem + ' - ' + NomeItem from (
SELECT i.NomeItem, mi.IdMovimentacaoItem, esi.EstoqueAtual, mi.Qtd, i.CodigoItem FROM EstoquesporSubItens esi
INNER JOIN Subitens si ON si.IdSubItem = esi.IdSubItem
INNER JOIN Itens i ON i.IdItem = si.IdItem
LEFT  JOIN MovimentacoesItens mi on mi.IdSubItem = si.IdSubItem and mi.Qtd > 0) e
where Qtd is null

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
select 'Itens', 'Com estoque negativo: ' + CodigoItem + ' - ' + NomeItem from (
SELECT i.NomeItem, esi.EstoqueAtual, i.CodigoItem FROM EstoquesporSubItens esi
INNER JOIN Subitens si ON si.IdSubItem = esi.IdSubItem
INNER JOIN Itens i ON i.IdItem = si.IdItem) e
WHERE EstoqueAtual < 0

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
select 'Itens', 'Com estoque sem valor de movimentação: ' + CodigoItem + ' - ' + NomeItem from (
SELECT i.NomeItem, esi.EstoqueAtual, i.CodigoItem, si.IdSubItem, i.SemValorReferencia
FROM EstoquesporSubItens esi
INNER JOIN Subitens si ON si.IdSubItem = esi.IdSubItem
INNER JOIN Itens i ON i.IdItem = si.IdItem) e
WHERE e.EstoqueAtual > 0 AND ISNULL(e.SemValorReferencia,0) = 0
AND (SELECT SUM(mi2.ValorMovimento) FROM MovimentacoesItens mi2 WHERE mi2.IdSubItem = e.IdSubItem) <= 0 

-- Subitens
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'SubItens', 'Nome repetido: '+NomeSubItem
FROM (SELECT NomeSubItem, count(*) AS conta FROM SubItens GROUP BY NomeSubItem) u WHERE conta > 1

-- Locais Entregas
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'LocaisEntrega', 'Nome repetido: '+TituloLocal
FROM (SELECT TituloLocal, count(*) AS conta FROM LocaisEntrega GROUP BY TituloLocal) u WHERE conta > 1

SELECT *
FROM Ocorrencias_Validacao
ORDER BY Tabela, Mensagem



