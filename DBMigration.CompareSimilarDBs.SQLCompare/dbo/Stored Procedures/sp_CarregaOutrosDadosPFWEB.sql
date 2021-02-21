	 
-- ============================================================================
--	sp_CarregaOutrosDadosPFWEB
-- ============================================================================
CREATE PROCEDURE dbo.sp_CarregaOutrosDadosPFWEB
	@IdProfissional INT = 0
AS
BEGIN
	SET NOCOUNT ON
	
	IF @IdProfissional > 0
	    SELECT RegistroConselhoAtual,
	           Nome,
	           CONVERT(VARCHAR(10), DataNAScimento, 103) AS DataNAScimento,
	           TipoSanguineo,
	           Religioes.Religiao,
	           Sexo,
	           Nacionalidades.Nacionalidade,
	           Cidades.NomeCidade,
	           SiglaUFNaturalidade,
	           NomePai,
	           NomeMae,
	           Civil_Militar,
	           EstadoCivil,
	           Raca,
	           RG,
	           RGOrgaoEmissao,
	           SiglaUFRG,
	           CONVERT(VARCHAR(10), RGDataEmissao, 103) AS RGDataEmissao,
	           CPF,
	           CTPS,
	           SerieCTPS,
	           CertificadoReserv,
	           CertificadoReservCSM,
	           CONVERT(VARCHAR(10), CertificadoReservData, 103) AS 
	           CertificadoReservData,
	           TituloEleitorInscricao,
	           TituloEleitorZona,
	           TituloEleitorSecao,
	           CONVERT(VARCHAR(10), TituloEleitorDataEmissao, 103) AS 
	           TituloEleitorDataEmissao,
	           NomeCidadeTitEleitor,
	           SiglaUFTituloEleitor
	    FROM   Profissionais
	           LEFT JOIN Nacionalidades
	                ON  Nacionalidades.IdNacionalidade = Profissionais.IdNacionalidade
	           LEFT JOIN Cidades
	                ON  Cidades.IdCidade = Profissionais.IdCidadeNaturalidade
	           LEFT JOIN Religioes
	                ON  Religioes.IdReligiao = Profissionais.IdReligiao
	    WHERE  Profissionais.IdProfissional = @IdProfissional
	
	SET NOCOUNT OFF
END
