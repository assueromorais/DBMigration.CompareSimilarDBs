


CREATE FUNCTION dbo.CLASSE(@IdProfissional INT, @DataBase DATETIME,  @DataServidor DATETIME)
RETURNS CHAR(1)
AS
	BEGIN
		DECLARE
			@RegistroConselhoAtual VARCHAR(20),
			@DataCompromisso DATETIME,
			@IdTipoInscricao INT,
			@TipoInscricao VARCHAR(50),
			@ReIngresso BIT,
			@CLASSE CHAR(1)

		/*****************************************************************************
		 * Seleciona os dados necessários
		 *****************************************************************************/
		SELECT
			@RegistroConselhoAtual = P.RegistroConselhoAtual,
			@DataCompromisso = P.Data1prof,
			@IdTipoInscricao = P.IdTipoInscricao,
			@TipoInscricao = TI.TipoInscricao,
			@DataBase = CASE  /*A DATABASE TEM QUE SER 01/01/"ANO POSTERIOR"*/
							WHEN @DataBase IS NULL THEN @DataServidor
							
							/*NO SQL 2000 NÃO E POSSIVEL USAR GETDATE DENTRO DE UMA FUNÇAO*/
							/*WHEN @DataBase IS NULL THEN GETDATE()*/
							
							ELSE @DataBase
						END,
			@ReIngresso = 0
		FROM
			Profissionais P
			LEFT JOIN TiposInscricao TI ON TI.IdTipoInscricao = P.IdTipoInscricao
		WHERE
			P.IdProfissional = @IdProfissional
			
		/*****************************************************************************
		 * Verifica se o advogado tem mais de uma inscrição definitiva "RE-INGRESSO"
		 *****************************************************************************/

		SELECT
			@ReIngresso =	CASE
								WHEN COUNT(*) > 1 THEN 1
								ELSE 0
							END
		FROM
			Profissionais_CategoriasProf PFC
			JOIN TiposInscricao TI ON TI.IdTipoInscricao = PFC.IdTipoInscricao
		WHERE
			PFC.IdProfissional = @IdProfissional
			AND TI.TipoInscricao = 'DEFINITIVA'

		/*****************************************************************************
		 * Define a classe do advogado
		 *****************************************************************************/
		IF @DataCompromisso IS NOT NULL
			SELECT
				@CLASSE =	CASE
								WHEN @DataCompromisso >= '20080101' AND  @TipoInscricao IN ('SUPLEMENTAR','TRANSFERÊNCIA') THEN 'A'
								WHEN @ReIngresso = 1 AND @DataCompromisso >= '20080101' AND @TipoInscricao NOT LIKE 'ESTAGI%' THEN 'A'
								WHEN @TipoInscricao LIKE 'ESTAGI%' THEN 'D'
								ELSE
									CASE
										WHEN YEAR(@DataServidor) - YEAR(@DataCompromisso) <= 3 THEN 'C'
										WHEN (YEAR(@DataServidor) - YEAR(@DataCompromisso) >= 4) AND
                                                                                     (YEAR(@DataServidor) - YEAR(@DataCompromisso) <= 5) THEN 'B'
										WHEN YEAR(@DataServidor) - YEAR(@DataCompromisso) >  5 THEN 'A'
									END
							END
			
		RETURN @CLASSE
	END



