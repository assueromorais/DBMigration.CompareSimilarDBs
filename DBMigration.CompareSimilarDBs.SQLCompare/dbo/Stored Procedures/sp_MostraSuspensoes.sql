																			
-- ============================================================================
--	sp_MostraSuspensoes
-- ============================================================================	
CREATE PROCEDURE [dbo].[sp_MostraSuspensoes]
	@IdProfissional VARCHAR(10)
AS
BEGIN
	DECLARE @sql                     VARCHAR(8000),
	        @sqlProcesso             VARCHAR(5000),
	        @PrefSufNumDoc_Processo  VARCHAR(100),
	        @FiscPrefSufProc         VARCHAR(100) 
	
	SET @sqlProcesso = ' (CAST(NumeroProc AS varchar) + ''/'' + anoProc )'     
	
	SET @sql = 
	    'SELECT Suspensoes.idsuspensao,
						 (
								 CAST(ISNULL(NumeroProc, '') AS VARCHAR(20)) + ''/'' +
								 CAST(ISNULL(anoProc, ''-'') AS VARCHAR)
						 ) AS [numeroproc],
						 (
								 SELECT TOP 1 ISNULL(Descricao, ''-'')
									 FROM ProcessosLista1 
												PL,
												Processos_ProcessosLista1 PPL
									WHERE PL.IdProcessoLista1 = PPL.IdProcessoLista1
										AND PPL.IdProcesso = Suspensoes.IdProcesso
						 ) AS [materia],
						 (CONVERT(VARCHAR, CONVERT(VARCHAR, datainicio, 105))) AS [transjulg],
						 (
								 ISNULL(CAST(DuracaoMeses AS VARCHAR) + '' mes(es) '', '') +
								 ISNULL(CAST(Duracao AS VARCHAR) + '' dias '', '') +
								 CASE 
											WHEN ProrrogavelDebito = 1 THEN 
													 ''ProrrogÃ¡vel atÃ© quitaÃ§Ã£o do dÃ©bito''
											WHEN ProrrogavelOutros = 1 THEN 
													 ''ProrrogÃ¡vel atÃ© prestaÃ§Ã£o de contAS''
											ELSE ''
								 END
						 ) AS [duracao],
						 (
								 SELECT nome
									 FROM profissionais
									WHERE idProfissional = suspensoes.IdRepresentadoProf
						 ) AS nomeprof,
						 (
								 SELECT ISNULL(registroconselhoatual, ''-'')
									 FROM profissionais
									WHERE idProfissional = suspensoes.IdRepresentadoProf
						 ) AS registroconselhoatual
				FROM Suspensoes,
						 processos
			 WHERE processos.IdProcesso = suspensoes.IdProcesso
				 AND Suspensoes.DataFim IS NULL
				 AND Suspensoes.IdRepresentadoProf = ' + @IdProfissional 
	
	EXEC (@sql)
END
