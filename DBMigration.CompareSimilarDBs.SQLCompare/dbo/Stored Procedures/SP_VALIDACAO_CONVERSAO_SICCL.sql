CREATE PROCEDURE [dbo].[SP_VALIDACAO_CONVERSAO_SICCL] @DataConversao DATETIME = NULL
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

-- Tipo Contrato
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Tipos Contrato', 'Tipo Contrato: ' + TipoContrato + '. Está com nome duplicado'
FROM (SELECT TipoContrato, count(*) AS conta FROM TiposContratos GROUP BY TipoContrato) u WHERE conta > 1

-- Modalidade de Compras
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Modalidade de Compra', 'Modalidade de Compra: ' + ModalidadeCompra + '. Está com nome duplicado'
FROM (SELECT ModalidadeCompra, count(*) AS conta FROM ModalidadesCompra GROUP BY ModalidadeCompra) u WHERE conta > 1

-- Tipos documentos 
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Tipos Documento', 'Tipo Documento: ' + TipoDocumento + '. Está com nome duplicado'
FROM (SELECT TipoDocumento, count(*) AS conta FROM TiposDocumentos GROUP BY TipoDocumento) u WHERE conta > 1

-- Natureza de Compra
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Natureza de Compras', 'Natureza de Compras: ' + NaturezaOrdem + '. Está com nome duplicado'
FROM (SELECT NaturezaOrdem, count(*) AS conta FROM NaturezasOrdens WHERE TipoNatureza = 'C' GROUP BY NaturezaOrdem) u WHERE conta > 1

-- Natureza de Serviços
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Natureza de Serviços', 'Natureza de Serviçõs: ' + NaturezaOrdem + '. Está com nome duplicado'
FROM (SELECT NaturezaOrdem, count(*) AS conta FROM NaturezasOrdens WHERE TipoNatureza = 'S' GROUP BY NaturezaOrdem) u WHERE conta > 1

-- Tipos de serviço
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Tipos de serviço', 'Tipos de serviço: ' + Descricao + '. Está com nome duplicado'
FROM (SELECT Descricao, count(*) AS conta FROM Servicos WHERE Descricao IS NOT NULL GROUP BY Descricao ) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Tipos de serviço', 'Tipos de serviço: ' + cast(ISNULL(DescricaoDetalhada,'') AS VARCHAR(153)) + ' | Id: ' + CAST(IdServico AS VARCHAR)+ '. Está sem descrição'
FROM (SELECT IdServico, Descricao, DescricaoDetalhada FROM Servicos ) u WHERE LTRIM(isnull(u.Descricao,'')) = ''

-- Unidades de Medida
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Medidas', 'Medida: ' + NomeMedida + '. Está com nome duplicado'
FROM (SELECT NomeMedida, count(*) AS conta FROM Medidas GROUP BY NomeMedida) u WHERE conta > 1

-- Setores Tramitações
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Setores Tramitações', 'Setor: ' + SetoresTramitacaoPCS + '. Está com nome duplicado'
FROM (SELECT stp.SetoresTramitacaoPCS, count(*) AS conta FROM SetoresTramitacaoPCS stp GROUP BY SetoresTramitacaoPCS) u WHERE conta > 1

-- Unidades
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Unidades', 'Unidade: ' + NomeUnidade + '. Está com nome duplicado'
FROM (SELECT NomeUnidade, count(*) AS conta FROM Unidades GROUP BY NomeUnidade) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Unidades',' Código= ' + T1.CodigoUnidade + ' Unidade: ' + NomeUnidade + '. Unidade com código duplicado'  
FROM (SELECT CodigoUnidade
		FROM Unidades
		GROUP BY CodigoUnidade
		HAVING COUNT(*) > 1) T1
	 INNER JOIN Unidades T2 ON T1.CodigoUnidade=T2.CodigoUnidade

-- Justificativas Processos Compra
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Justificativa Processos Compra', 'Justificativas Processos Compra: ' + NomeJustificativa + 'Está com nome duplicado'
FROM (SELECT NomeJustificativa, count(*) AS conta FROM JustificativaProcessoCompra GROUP BY NomeJustificativa) u WHERE conta > 1

-- Itens Compras
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Itens Compras', 'Iten Compra: ' + NomeItemCompra + '. Está com nome duplicado' 
FROM (SELECT NomeItemCompra, count(*) AS conta FROM ItensCompras GROUP BY NomeItemCompra) u WHERE conta > 1

-- Itens Almoxarifado
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Itens', 'Item: ' + NomeItem + '. Está com nome duplicado'
FROM (SELECT NomeItem, count(*) AS conta FROM itens GROUP BY NomeItem) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Itens', 'Item: ' + CodigoItem + '. Está com código duplicado'
FROM (SELECT CodigoItem, count(*) AS conta FROM itens GROUP BY CodigoItem) u WHERE conta > 1

-- Contratos
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Contratos', 'Número Contrato: ' + NumeroContrato + ' | Número Aditivo: ' + CAST(isnull(NumeroAditivo,'') AS VARCHAR)+ '. Está com número duplicado'
FROM (SELECT NumeroContrato, NumeroAditivo, count(*) AS conta FROM Contratos 
      WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND InicioVigencia >= @DataConversao)) 
      GROUP BY NumeroContrato, NumeroAditivo) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)      
SELECT 'Contratos', 'Número Contrato: ' + c.NumeroContrato + ' | Número Aditivo: ' + CAST(isnull(c.NumeroAditivo,'') AS VARCHAR)+ '. Está com número duplicado'
FROM Contratos c
JOIN (SELECT IdContratoPrincipal, NumeroAditivo, count(*) AS conta FROM Contratos 
      WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND InicioVigencia >= @DataConversao))
      AND IdContratoPrincipal IS NOT NULL  
      GROUP BY IdContratoPrincipal, NumeroAditivo) u ON u.IdContratoPrincipal = c.IdContratoPrincipal AND u.NumeroAditivo = c.NumeroAditivo 
														AND u.conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Contratos', 'Número Contrato: ' + NumeroContrato + ' | Número Aditivo: ' + CAST(isnull(NumeroAditivo,'') AS VARCHAR)+ '. Aditivo não possui contrato principal'
FROM (	SELECT NumeroContrato, IdContratoPrincipal, NumeroAditivo FROM Contratos 
      	WHERE NumeroAditivo IS NOT NULL 
		AND  ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND InicioVigencia >= @DataConversao)) 
		) u WHERE IdContratoPrincipal IS NULL 
		
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Contratos', 'Número Contrato: ' + NumeroContrato + '. Tem contrato principal mas não possui número de aditivo'
FROM (	SELECT NumeroContrato, IdContratoPrincipal, NumeroAditivo FROM Contratos 
      	WHERE IdContratoPrincipal IS NOT NULL 
		AND  ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND InicioVigencia >= @DataConversao)) 
		) u WHERE  NumeroAditivo IS NULL  

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'Contratos', 'Número Contrato: ' + NumeroContrato + ' | Contratado: ' + Nome + '. O contratrado possui CPF/CNPJ inexistente ou inválido'
FROM (SELECT c.NumeroContrato, p.CNPJCPF, p.Nome, p.E_PessoaJuridica
        FROM Contratos c LEFT JOIN Pessoas p ON p.IdPessoa = c.IdPessoa
		WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND InicioVigencia >= @DataConversao)) 
		) u WHERE ((E_PessoaJuridica = 0 AND dbo.CPF_VALIDO(ISNULL(LTRIM(u.CNPJCPF), '')) = 0)
					OR (E_PessoaJuridica = 1 AND dbo.VALIDACNPJ(ISNULL(LTRIM(CNPJCPF), '')) = 'N'))

-- Termos Contrato
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Termos de Contratos', 'Número Contrato: ' + NumeroContrato + '. Termo de Recebimento sem Número de Nota Fiscal'
FROM (SELECT c.NumeroContrato, ct.NumeroNotaFiscal FROM Contratos c INNER JOIN ContratosTermos ct ON ct.IdContrato = c.IdContrato 
      WHERE ct.TipoTermo = 'RECNF'
	  AND ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND InicioVigencia >= @DataConversao)) 
	  ) u 
	WHERE ISNULL(LTRIM(NumeroNotaFiscal), '') = ''
	
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Termos de Contratos', 'Número Contrato: ' + NumeroContrato + '. Termo de Recebimento sem Data de Entrada da Nota Fiscal'
FROM (SELECT c.NumeroContrato, ct.DataEntradaNota FROM Contratos c INNER JOIN ContratosTermos ct ON ct.IdContrato = c.IdContrato 
      WHERE ct.TipoTermo = 'RECNF'
	  AND ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND InicioVigencia >= @DataConversao)) 	
	  ) u 
	WHERE DataEntradaNota IS NULL	

-- Ordens Compras
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Ordens Compras', 'Número da ordem: ' + NumeroOrdem + '. Está com número da ordem duplicado'
FROM (SELECT NumeroOrdem, count(*) AS conta FROM Ordens 
      WHERE IdServico IS NULL 
      AND ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataOrdem >= @DataConversao))
      GROUP BY NumeroOrdem) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Ordens Compras', 'Número da ordem: ' + NumeroOrdem + '. O valor da ordem está menor que o desconto'
FROM (SELECT NumeroOrdem, Valor, Desconto FROM Ordens 
      WHERE IdServico IS NULL 
	  AND ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataOrdem >= @DataConversao))	
	  ) u WHERE u.Valor < u.Desconto

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'Ordens Compras', 'Número da ordem: ' + NumeroOrdem + ' | Fornecedor: ' + ISNULL(Nome,'') + '. O fornecedor possui CPF/CNPJ inexistente ou inválido'
FROM (SELECT o.NumeroOrdem, p.CNPJCPF, p.Nome, p.E_PessoaJuridica
        FROM Ordens o LEFT JOIN Pessoas p ON p.IdPessoa = o.IdPessoa 
      WHERE IdServico IS NULL
	  AND ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataOrdem >= @DataConversao))	
	  ) u WHERE ((E_PessoaJuridica = 0 AND dbo.CPF_VALIDO(ISNULL(LTRIM(u.CNPJCPF), '')) = 0)
					OR (E_PessoaJuridica = 1 AND dbo.VALIDACNPJ(ISNULL(LTRIM(CNPJCPF), '')) = 'N'))

-- Ordens Serviços
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Ordens Serviços', 'Número da ordem: ' + NumeroOrdem + '. Está com número da ordem duplicado: '+NumeroOrdem
FROM (SELECT NumeroOrdem, count(*) AS conta FROM Ordens 
      WHERE IdServico IS NOT NULL 
      AND ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataOrdem >= @DataConversao))
      GROUP BY NumeroOrdem) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Ordens Serviços', 'Número da ordem: ' + NumeroOrdem + '. O valor da ordem está menor que o desconto'
FROM (SELECT NumeroOrdem, Valor, Desconto FROM Ordens 
      WHERE IdServico IS NOT NULL 
	  AND ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataOrdem >= @DataConversao))	
	  ) u WHERE u.Valor < u.Desconto

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'Ordens Serviços', 'Número da ordem: ' + NumeroOrdem + ' | Fornecedor: ' + ISNULL(Nome,'') + '. O fornecedor possui CPF/CNPJ inexistente ou inválido'
FROM (SELECT o.NumeroOrdem, p.CNPJCPF, p.Nome, p.E_PessoaJuridica 
        FROM Ordens o LEFT JOIN Pessoas p ON p.IdPessoa = o.IdPessoa 
      WHERE IdServico IS NOT NULL
	  AND ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataOrdem >= @DataConversao))
	  ) u WHERE ((E_PessoaJuridica = 0 AND dbo.CPF_VALIDO(ISNULL(LTRIM(u.CNPJCPF), '')) = 0)
					OR (E_PessoaJuridica = 1 AND dbo.VALIDACNPJ(ISNULL(LTRIM(CNPJCPF), '')) = 'N'))

-- Locais Entregas
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'LocaisEntrega', 'Local entrega: ' + TituloLocal + '. Está com nome duplicado'
FROM (SELECT TituloLocal, count(*) AS conta FROM LocaisEntrega GROUP BY TituloLocal) u WHERE conta > 1

-- Indices Reajuste
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Índices de Reajuste', 'Indice: ' + Descricao + '. Está com nome duplicado'
FROM (SELECT Descricao, count(*) AS conta FROM NomesIndices GROUP BY Descricao) u WHERE conta > 1

-- Solicitações
IF EXISTS (SELECT 1 FROM (SELECT s.Descricao, s.IdUnidade FROM Solicitacoes s
	  WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataSolicitacao >= @DataConversao))
	  ) u WHERE IdUnidade IS NULL )
BEGIN	  
	--INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
	--SELECT 'Solicitações', ''
	INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
	SELECT 'Solicitações', 'PARA AS SOLICITAÇÕES ABAIXO QUE NÃO POSSUÍREM UNIDADE SERÁ UTILIZADA UNIDADE PADRÃO CONFIGURADA NO PASSO 02 DAS CONFIGURAÇÕES PARA MIGRAÇÃO.'
END

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Solicitações', 'Solicitação: ' + CAST(Descricao AS VARCHAR(153)) + '. A solicitação não possui unidade'
FROM (SELECT s.Descricao, s.IdUnidade FROM Solicitacoes s
	  WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataSolicitacao >= @DataConversao))
	  ) u WHERE IdUnidade IS NULL 
	
IF EXISTS (SELECT 1 FROM (SELECT s.Descricao, s.IdResponsavel FROM Solicitacoes s
	  WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataSolicitacao >= @DataConversao))
	  ) u WHERE IdResponsavel IS NULL )
BEGIN	  
	INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
	SELECT 'Solicitações', 'PARA AS SOLICITAÇÕES ABAIXO QUE NÃO POSSUÍREM RESPONSÁVEL SERÁ UTILIZADA UNIDADE PADRÃO CONFIGURADA NO PASSO 02 DAS CONFIGURAÇÕES PARA MIGRAÇÃO.'
END

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Solicitações', 'Solicitação: ' + CAST(Descricao AS VARCHAR(153)) + '. A solicitação não possui responsável'
FROM (SELECT s.Descricao, s.IdResponsavel FROM Solicitacoes s
	  WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataSolicitacao >= @DataConversao))
	  ) u WHERE u.IdResponsavel IS NULL 
	 
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT ' Solicitações', 'Solicitação: ' + CAST(Descricao AS VARCHAR(153)) + '. A solicitação não possui quantidade ou a quantidade é igual a 0.'
FROM (SELECT s.Descricao, s.Quantidade FROM Solicitacoes s
	  WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataSolicitacao >= @DataConversao))
	  ) u WHERE u.Quantidade IS NULL OR u.Quantidade = 0

-- Processos de Compras/Serviços
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Processos de Compras/Serviços', 'Número processo: ' + NumeroProcesso + '. Está com número duplicado'
FROM (SELECT NumeroProcesso, count(*) AS conta FROM ProcessosCompServ 
      WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataInicio >= @DataConversao))
      GROUP BY NumeroProcesso) u WHERE conta > 1
/*
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Processos de Compras/Serviços', 'Número processo: ' + NumeroProcesso + '. Não possui lista de itens ou itens não existem'
FROM(SELECT pcs.NumeroProcesso, 
	CASE WHEN lp.IdItem IS NOT NULL THEN ISNULL((SELECT TOP 1 1 FROM Itens i WHERE i.IdItem = lp.IdItem), 0)
		 WHEN lp.IdServico IS NOT NULL THEN ISNULL((SELECT TOP 1 1 FROM Servicos s WHERE s.IdServico = lp.IdServico), 0)
		 WHEN lp.IdItemCompra IS NOT NULL THEN ISNULL((SELECT TOP 1 1 FROM ItensCompras ic WHERE ic.IdItemCompra = lp.IdItemCompra), 0) ELSE 0 END Item 
FROM ProcessosCompServ pcs
LEFT JOIN ListaProcessos lp ON lp.IdProcesso = pcs.IdProcesso) u WHERE u.Item = 0
*/
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'Processos de Compras/Serviços', 'Número processo: ' + NumeroProcesso + ' | Fornecedor:' + ISNULL(u.Nome,'') + '. O fornecedor da cotação possui CPF/CNPJ inexistente ou inválido'
FROM (SELECT pcs.NumeroProcesso, p.CNPJCPF, p.Nome, p.E_PessoaJuridica
	  FROM ProcessosCompServ pcs 
	  INNER JOIN ListaProcessos lp ON lp.IdProcesso = pcs.IdProcesso
	  INNER JOIN Cotacoes c ON c.IdListaProcesso = lp.IdListaProcesso
	  LEFT JOIN Pessoas p ON p.IdPessoa = c.IdPessoa
	  WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataInicio >= @DataConversao))
	  ) u WHERE ((E_PessoaJuridica = 0 AND dbo.CPF_VALIDO(ISNULL(LTRIM(u.CNPJCPF), '')) = 0)
					OR (E_PessoaJuridica = 1 AND dbo.VALIDACNPJ(ISNULL(LTRIM(CNPJCPF), '')) = 'N'))

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT DISTINCT 'Processos de Compras/Serviços', 'Número processo: ' + NumeroProcesso + ' | Fornecedor:' + ISNULL(u.Nome,'') + '. Valor da Cotação inválido'
FROM (SELECT pcs.NumeroProcesso, p.CNPJCPF, p.Nome, c.ValorCotacao
	  FROM ProcessosCompServ pcs 
	  INNER JOIN ListaProcessos lp ON lp.IdProcesso = pcs.IdProcesso
	  INNER JOIN Cotacoes c ON c.IdListaProcesso = lp.IdListaProcesso
	  LEFT JOIN Pessoas p ON p.IdPessoa = c.IdPessoa
	  WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataInicio >= @DataConversao))	
	  ) u WHERE ISNULL(ValorCotacao, 0) <= 0

-- Grupos Itens
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Grupos Itens', 'Grupo Item: ' + NomeGrupoItem + '. Está com nome duplicado'
FROM (SELECT NomeGrupoItem, count(*) AS conta FROM GruposItens GROUP BY NomeGrupoItem) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Grupos Itens', 'Grupo Item: ' + NomeGrupoItem + '. Não possui Conta de entrata\saída configurada com plano de contas do SISCONT.NET'
FROM (SELECT NomeGrupoItem, IdPlanoContaMCASP, IdPlanoContaMCASPEntradaAlmoxarifado FROM GruposItens) u 
WHERE u.IdPlanoContaMCASP IS NULL OR u.IdPlanoContaMCASPEntradaAlmoxarifado IS NULL 

-- Tipos Licitações
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Tipos Licitações', 'Tipo Licitação: ' + TipoLicitacao + '. Está com nome duplicado'
FROM (SELECT TipoLicitacao, count(*) AS conta FROM TiposLicitacoes GROUP BY TipoLicitacao) u WHERE conta > 1

-- Modalidades Licitações
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Modalidades Licitações', 'Modalidade: ' + Modalidade + '. Está com nome duplicado'
FROM (SELECT Modalidade, count(*) AS conta FROM Modalidades GROUP BY Modalidade) u WHERE conta > 1

-- Modalidades Licitações
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Modalidades Licitações', 'Modalidade: ' + Modalidade + '. Não há tipo de licitação associado a modalidade'
FROM (SELECT Modalidade FROM Modalidades 
      WHERE NOT EXISTS(SELECT 1 FROM TiposLicitacoes tl WHERE tl.IdModalidade = Modalidades.IdModalidade)
		) u 	
		
-- Fases Licitações
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Fases Licitações', 'Fase Licitação: ' + Fase + '. Está com nome duplicado'
FROM (SELECT Fase, count(*) AS conta FROM Fases 
    JOIN FasesLicitacoes fl ON fl.IdFase = Fases.IdFase
    WHERE EXISTS(SELECT 1 FROM Fases f WHERE f.IdFase <> Fases.IdFase AND f.Fase = Fases.Fase) 
	GROUP BY Fase) u WHERE conta > 1

-- Licitações
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Licitações', 'Número da licitação: ' + NumeroLicitacao + '. Está com número da licitação duplicado'
FROM (SELECT NumeroLicitacao, count(*) AS conta FROM Licitacoes 
      WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataInicio >= @DataConversao))	
      GROUP BY NumeroLicitacao) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Licitações', 'Número da licitação: ' + NumeroLicitacao + '. Não possui lista de itens ou itens não existem'
FROM(SELECT l.NumeroLicitacao, 
	CASE WHEN ll.IdItem IS NOT NULL THEN ISNULL((SELECT TOP 1 1 FROM Itens i WHERE i.IdItem = ll.IdItem), 0)
		 WHEN ll.IdServico IS NOT NULL THEN ISNULL((SELECT TOP 1 1 FROM Servicos s WHERE s.IdServico = ll.IdServico), 0)
		 WHEN ll.IdItemCompra IS NOT NULL THEN ISNULL((SELECT TOP 1 1 FROM ItensCompras ic WHERE ic.IdItemCompra = ll.IdItemCompra), 0) ELSE 0 END Item 
FROM Licitacoes l
LEFT JOIN ListaLicitacoes ll ON ll.IdLicitacao = l.IdLicitacao
WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataInicio >= @DataConversao))
) u WHERE u.Item = 0 OR u.Item IS NULL 

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Licitações', 'Número da licitação: ' + NumeroLicitacao + '. Existe mais de uma fase em andamento'
FROM (SELECT NumeroLicitacao, count(*) AS conta FROM Licitacoes
	  JOIN FasesLicitacoes fl ON fl.IdLicitacao = Licitacoes.IdLicitacao 
      WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND Licitacoes.DataInicio >= @DataConversao))	
      AND fl.DataFim IS NULL
      GROUP BY NumeroLicitacao) u WHERE conta > 1

INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Licitações', 'Número da licitação: ' + NumeroLicitacao + '. Existe proposta com valor zero ou sem valor'
FROM (SELECT NumeroLicitacao FROM Licitacoes
	  JOIN ListaLicitacoes ll ON ll.IdLicitacao = Licitacoes.IdLicitacao
	  JOIN Propostas p ON p.IdListaLicitacao = ll.IdListaLicitacao
      WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND Licitacoes.DataInicio >= @DataConversao))	
      AND ISNULL(p.Valor,0) = 0
      GROUP BY NumeroLicitacao) u 

-- Solicitação de reserva orçamentária
INSERT INTO Ocorrencias_Validacao (Tabela,Mensagem)
SELECT 'Solicitação de Empenho', 'Histórico: ' + cast(u.Historico AS Varchar(100)) + '. Está com número da licitação duplicado'
FROM (SELECT Historico, IdProcesso, IdOrdem FROM AlertaEmpenhoSG 
      WHERE ((@DataConversao IS NULL) OR (@DataConversao IS NOT NULL AND DataSolicitacao >= @DataConversao))
      ) u WHERE IdProcesso IS NULL AND IdOrdem IS NULL

-- Alertas empenho
DELETE FROM AlertaEmpenhoSG
WHERE IdOrdem IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM Ordens o WHERE o.IdOrdem = AlertaEmpenhoSG.IdOrdem)

DELETE FROM AlertaEmpenhoSG
WHERE IdProcesso IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM ProcessosCompServ pcs WHERE pcs.IdProcesso = AlertaEmpenhoSG.IdProcesso)

SELECT *
FROM Ocorrencias_Validacao
ORDER BY Tabela, Mensagem
