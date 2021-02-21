

CREATE VIEW dbo.Estoques_DataUltimasCompras AS
SELECT IdSubItem, MAX(DataReferencia) AS DataUltimaCompra
FROM dbo.EntregasOrdens
GROUP BY IdSubItem




