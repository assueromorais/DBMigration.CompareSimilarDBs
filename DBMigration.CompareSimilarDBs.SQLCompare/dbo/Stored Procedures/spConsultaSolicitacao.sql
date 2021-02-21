



























CREATE PROCEDURE dbo.spConsultaSolicitacao AS

CREATE TABLE #ConsultaSolicitacao
        (
                IdSolicitacao	int,
                Descricao	varchar(60),
                DataSolicitacao varchar(10),
		DataPrazo	varchar(10),
		Quantidade	float,
		IdResponsavel	int,
		IdUnidade	int,
		NumeroProcesso	varchar(20),
		NumeroLicitacao	varchar(20),
		NumeroContrato	varchar(20),
		NumeroOrdem	varchar(20)
        )

DECLARE 
@IdSolicitacao 		int, 
@Descricao 		varchar(60),
@DataSolicitacao 	varchar(10), 
@DataPrazo 		varchar(10), 
@Quantidade 		float, 
@IdResponsavel 		int,
@IdUnidade		int, 
@IdProcesso		int,
@NumeroProcesso		varchar(20),
@IdLicitacao		int, 
@NumeroLicitacao	varchar(20),
@IdContrato		int, 
@NumeroContrato		varchar(20),
@IdOrdem		int, 
@NumeroOrdem		varchar(20)

DECLARE ConsultaSolicitacao_Cursor
CURSOR FAST_FORWARD FOR

SELECT IdSolicitacao, Descricao, CONVERT(VarChar(10),DataSolicitacao,103), CONVERT(VarChar(10),DataPrazo,103), Quantidade, Solicitacoes.IdResponsavel, Responsaveis.IdUnidade FROM Solicitacoes
INNER JOIN Responsaveis ON Responsaveis.IdResponsavel = Solicitacoes.IdResponsavel

OPEN ConsultaSolicitacao_Cursor

FETCH NEXT FROM ConsultaSolicitacao_Cursor
INTO @IdSolicitacao, @Descricao, @DataSolicitacao, @DataPrazo, @Quantidade, @IdResponsavel, @IdUnidade

WHILE @@FETCH_STATUS = 0
BEGIN

	SET @IdProcesso = 0
	SET @NumeroProcesso = ''
	SET @IdLicitacao = 0
	SET @NumeroLicitacao = ''
	SET @IdContrato = 0
	SET @NumeroContrato = ''
	SET @IdOrdem = 0
	SET @NumeroOrdem = ''

	IF @IdSolicitacao <> 0
	BEGIN

		SELECT @IdProcesso = ProcessosCompServ.IdProcesso, @NumeroProcesso = NumeroProcesso FROM ProcessosCompServ
		INNER JOIN ProcessosCompServSolicitacoes ON ProcessosCompServSolicitacoes.IdProcesso = ProcessosCompServ.IdProcesso
		WHERE IdSolicitacao = @IdSolicitacao


		IF @IdProcesso <> 0
		BEGIN
		
			SELECT @IdLicitacao = Licitacoes.IdLicitacao, @NumeroLicitacao = NumeroLicitacao FROM Licitacoes
			INNER JOIN ProcessosCompServ ON ProcessosCompServ.IdLicitacao = Licitacoes.IdLicitacao
			WHERE IdProcesso = @IdProcesso
			
			SELECT @IdContrato = IdContrato, @NumeroContrato = NumeroContrato FROM Contratos
			INNER JOIN Licitacoes ON Licitacoes.IdLicitacao = Contratos.IdLicitacao
			WHERE Contratos.IdLicitacao = @IdLicitacao
			
			SELECT @IdOrdem = IdOrdem, @NumeroOrdem = NumeroOrdem FROM Ordens
			WHERE IdContrato = @IdContrato

		END
		ELSE

			SELECT @IdOrdem = Ordens.IdOrdem, @NumeroOrdem = NumeroOrdem FROM Ordens
			INNER JOIN SolicitacoesOrdens ON SolicitacoesOrdens.IdOrdem = Ordens.IdOrdem
			WHERE IdSolicitacao = @IdSolicitacao
		

		INSERT #ConsultaSolicitacao
		VALUES(
			@IdSolicitacao, 
			@Descricao, 
			@DataSolicitacao, 
			@DataPrazo, 
			@Quantidade, 
			@IdResponsavel,
			@IdUnidade,
			@NumeroProcesso,
			@NumeroLicitacao,
			@NumeroContrato,
			@NumeroOrdem
			)
	END	

	FETCH NEXT FROM ConsultaSolicitacao_Cursor
	INTO @IdSolicitacao, @Descricao, @DataSolicitacao, @DataPrazo, @Quantidade, @IdResponsavel, @IdUnidade
END

CLOSE ConsultaSolicitacao_Cursor
DEALLOCATE ConsultaSolicitacao_Cursor

SELECT * FROM #ConsultaSolicitacao
























































