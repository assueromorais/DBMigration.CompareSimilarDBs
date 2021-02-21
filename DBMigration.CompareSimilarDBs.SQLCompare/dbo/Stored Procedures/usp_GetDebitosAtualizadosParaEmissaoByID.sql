
CREATE PROCEDURE usp_GetDebitosAtualizadosParaEmissaoByID ( @EmissaoComDesconto        INT,
															@TipoPessoa                INT,
															@DataVencimentoBoleto      DATETIME,
															@DataAtualizacao           DATETIME,
															@IdProcedimentoAtraso      INT, 
                                                            @TipoComposicao            INT,
                                                            @DataMinimaASerConsiderada DATETIME,
															@ListaDebitos              VARCHAR(1000) )
AS 
BEGIN       
	SET NOCOUNT ON

	DECLARE @Debitos Debitos
	
	INSERT INTO @Debitos ( IdDebito )
	EXEC ('SELECT IdDebito FROM Debitos WHERE IdDebito IN (' + @ListaDebitos + ')')	 
	
	EXEC usp_GetDebitosAtualizadosParaEmissaoByUserType @EmissaoComDesconto,  
														@TipoPessoa,
														@DataVencimentoBoleto,
														@DataAtualizacao,     
														@IdProcedimentoAtraso,
                                                        @TipoComposicao,
                                                        @DataMinimaASerConsiderada,
														@Debitos
END
