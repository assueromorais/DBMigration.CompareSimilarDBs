
/*Criada pelo Gino - Ocorr. 74687 - 01/11/2011*/

 	

CREATE PROCEDURE [dbo].[sp_Rel_Lista_Campos] 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TP.IDTIPOPROCESSO,
	       TP.PROCESSOTIPO,
	       UPPER(ltrim(rtrim(TD.NOMECAMPO))) NOMECAMPO,
	       UPPER(ltrim(rtrim(TD.TITULOMONITOR))) TITULOCAMPO,
	       UPPER(ltrim(rtrim(NOMETABELAAUX))) TABELAAUXILIAR,
	       TP2.TipoCampo
	       INTO #DIRETOS
	FROM   DBO.TELASDEFINICOES TD
	       JOIN DBO.TIPOPROCESSO TP 
	            ON  TP.IDTIPOPROCESSO = TD.IDTIPOPROCESSO
	       JOIN TelasParametros tp2
	            ON  TD.IdTipoProcesso = TP2.IdTipoProcesso
	                AND TD.CodigoTela = tp2.CodigoTela
	                AND td.NomeTabela = tp2.NomeTabela
	                AND td.NomeCampo = tp2.NomeCampo
	WHERE  TD.NOMETABELA = 'PROCESSOS'
	       AND MODELOTIPOPROCESSO = 'Fiscal (D.A.)'
	       AND TD.NOMECAMPO NOT LIKE '%GRID%'
	       AND TD.NomeTabelaAux IS NULL
	       AND TP2.TipoCampo NOT IN ('C', 'P', 'T', 'U')
	
	SELECT TP.IDTIPOPROCESSO,
	       TP.PROCESSOTIPO,
	       UPPER(ltrim(rtrim(TD.NOMECAMPO))) NOMECAMPO,
	       UPPER(ltrim(rtrim(TD.TITULOMONITOR))) TITULOCAMPO,
	       UPPER(ltrim(rtrim(NOMETABELAAUX))) TABELAAUXILIAR,
	       TP2.TipoCampo,
	       CASE TP2.TipoCampo
	            WHEN 'C' THEN 'NomeCidade'
	            WHEN 'U' THEN 'SiglaUF'
	            WHEN 'P' THEN 'Nome'
	            ELSE 'Descricao'
	       END AS CampoDados,
	       CASE TP2.TipoCampo
	            WHEN 'C' THEN 'IdCidade'
	            WHEN 'U' THEN 'IdEstado'
	            WHEN 'P' THEN ''
	            ELSE  UPPER(ltrim(rtrim(TD.NOMECAMPO)))
	       END AS ChaveEstrangeira
	       INTO #INDIRETOS
	FROM   DBO.TELASDEFINICOES TD
	       JOIN DBO.TIPOPROCESSO TP
	            ON  TP.IDTIPOPROCESSO = TD.IDTIPOPROCESSO
	       JOIN TelasParametros tp2
	            ON  TD.IdTipoProcesso = TP2.IdTipoProcesso
	                AND TD.CodigoTela = tp2.CodigoTela
	                AND td.NomeTabela = tp2.NomeTabela
	                AND td.NomeCampo = tp2.NomeCampo
	WHERE  TD.NOMETABELA = 'PROCESSOS'
	       AND MODELOTIPOPROCESSO = 'Fiscal (D.A.)'
	       AND TD.NOMECAMPO NOT LIKE '%GRID%'
	       AND TP2.TipoCampo IN ('C', 'P', 'T', 'U')

    SELECT D.TITULOCAMPO
    FROM #DIRETOS D 		 
	UNION
    SELECT I.TITULOCAMPO
    FROM #INDIRETOS I 	
    ORDER BY 1	 
END
