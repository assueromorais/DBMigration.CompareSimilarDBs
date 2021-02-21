/* OC. 213386
* Criado por Seila
*/

CREATE PROCEDURE [dbo].[Sp_ConsultaCEP]
	@CEPIN INT,
	@LOCALIDADE CHAR(60) OUTPUT,
 	@BAIRRO CHAR(60) OUTPUT ,
    @LOGRADOURO CHAR(60) OUTPUT,
	@CEP INT OUTPUT,
	@UF	CHAR(2) OUTPUT,
	@OPCAO CHAR(1) = '',
	@CLIENTE CHAR(1) = '0',
	@DESATIVADO BIT = 0 OUTPUT
AS
	
DECLARE @IDLOGRADOURO INT,
        @LOGRADOUROABREV VARCHAR(50) ,
	    @LOGCOMPL VARCHAR(100),
	    @LOGTIPO VARCHAR(50),
	    @DATAATUALIZACAO DATETIME ,
	    @ALTERADO BIT,
	    @IDLOGRADOURODNE INT,
	    @USALOGTIPO	CHAR(1)	 

	SET @LOCALIDADE = ''
	SET @BAIRRO = ''
	SET @LOGRADOURO = ''
	SET @CEP = ''
	SET @UF = '' 
	SET @DESATIVADO = 0
	SET @OPCAO = @CLIENTE
	SET @USALOGTIPO = 'N' 
	
	
	/*VERSAO:4.0=================================================================================================
	* Ocs.48795;50275;
	* Oc.210614 - Alterada para ser utilizada no Assistente de NovosCadastros para o CRESS/SP, igual ao SQL do 
	* artefato EnderecosECT
	* Oc.213386 - Versão dos CRQ's
	* 
	* Quando Cliente = 0, o CEP é buscado da tabela dos Correios. 
	* Quando Cliente = 1, o CEP deverá ser buscado da tabela Logradouro, onde o usuário tem opção de cadastro. 
	* Quando Cliente = 2, Versão criada para atender o CRESS/SP,é o SQL do Artefato EnderecosECT.
	* 
	* Obs.: Não realizei alteração de Nomenclatura dos parâmetros para algo mais "intuitivo", devido a esta stored de procedure
	*       ser utilizada no FrameWork e também utilizada individualmente no cadastro de cada projeto. 
	===========================================================================================================*/		
	IF @CLIENTE = '0'
	BEGIN
	    SELECT @LOCALIDADE     = ISNULL(CEP_LOC.NOME_LOCAL, ''),
	           @BAIRRO         = ISNULL(CEP_BAI.EXTENSO_BAI, ''),
	           @LOGRADOURO     = ISNULL(CEP_LOG.NOME_LOG, ''),
	           @CEP            = ISNULL(CEP_LOG.CEP8_LOG, ''),
	           @UF             = ISNULL(CEP_LOG.UF_LOG, ''),
	           @CLIENTE        = '0',
	           @DESATIVADO     = 0,
	           @IDLOGRADOURO   = CEP_LOG.CHAVE_LOG
	    FROM   CEP_LOG,
	           CEP_BAI,
	           CEP_LOC
	    WHERE  CEP_LOC.CHAVE_LOCAL = CEP_LOG.CHVLOCAL_LOG
	           AND CEP_LOC.CHAVE_LOCAL = CEP_BAI.CHVLOC_BAI
	           AND (
	                   CEP_LOG.CHVBAI1_LOG = CEP_BAI.CHAVE_BAI
	                   OR CEP_LOG.CHVBAI2_LOG = CEP_BAI.CHAVE_BAI
	               )
	           AND CEP_LOG.CEP8_LOG = @CEPin
	END
	ELSE 
	IF @CLIENTE = '1'
	BEGIN
	    SELECT TOP 1
	           @LOCALIDADE = ISNULL(Cidades.NomeCidade, ''),
	           @BAIRRO         = ISNULL(Bairros.NomeBairro, ''),
	           @LOGRADOURO     = ISNULL(CEP_Complementar.NomeLogradouro, ''),
	           @CEP            = ISNULL(CEP_Complementar.CEP, ''),
	           @UF             = ISNULL(Estados.SiglaUF, ''),
	           @CLIENTE        = '1',
	           @DESATIVADO     = ISNULL(CEP_Complementar.Desativado, 0),
	           @IDLOGRADOURO   = CEP_Complementar.IdCEP
	    FROM   CEP_Complementar
	           LEFT JOIN Bairros
	                ON  CEP_Complementar.IdBairro = Bairros.IdBairro
	           LEFT JOIN Cidades
	                ON  CEP_Complementar.IdCidade = Cidades.IdCidade
	           LEFT JOIN Estados
	                ON  CEP_Complementar.IdEstado = Estados.IdEstado
	    WHERE  CEP_Complementar.CEP = @CEPin
	END
	ELSE 
	IF @CLIENTE = '2'
	BEGIN
	    SELECT @LOCALIDADE      = ISNULL(X.NomeCidade, ''),
	           @BAIRRO          = ISNULL(X.NomeBairro, ''),
	           @LOGRADOURO      = ISNULL(X.Logradouro, ''),
	           @CEP             = ISNULL(X.CEP, ''),
	           @UF              = ISNULL(X.SiglaUf, ''),
	           @CLIENTE         = '2',
	           @DESATIVADO      = 0,
	           @IDLOGRADOURO    = X.idLogradouro,
	           @LOGRADOUROABREV   = ISNULL(X.LogradouroAbrev, ''),
	           @LOGCOMPL        = X.LogComplemento,
	           @LOGTIPO         = X.LogTipo,
	           @DATAATUALIZACAO = X.DataAtualizacao,
	           @ALTERADO        = x.Alterado,
	           @IDLOGRADOURODNE = X.IdLogradouroDNE,
	           @USALOGTIPO      = X.UsaLogTipo
	    FROM   (
	               SELECT DISTINCT  idLogradouro,
	                      e.SiglaUf,
	                      c.NomeCidade,
	                      b.NomeBairro,
	                      Logradouro = CASE 
	                                        WHEN l.UsaLogTipo = 'S' THEN l.LogTipo 
	                                             + ' ' +
	                                             l.Logradouro
	                                        ELSE l.Logradouro
	                                   END,
	                      l.LogradouroAbrev,
	                      l.LogComplemento,
	                      l.LogTipo,
	                      l.CEP,
	                      GETDATE()  AS DataAtualizacao,
	                      l.Alterado,
	                      l.IdLogradouroDNE,
	                      l.UsaLogTipo
	               FROM   Logradouros l
	                      LEFT JOIN Bairros b
	                           ON  b.IdBairro = l.IdBairro
	                      LEFT JOIN Cidades c
	                           ON  c.IdCidade = b.IdCidade
	                      LEFT JOIN Estados e
	                           ON  e.IdEstado = c.IdEstado
	               WHERE  (l.CEP = @CEPin) 
	               UNION  
	               SELECT DISTINCT CAST(0 AS INT) AS IdLogradouro,
	                      e.SiglaUf,
	                      c.NomeCidade,
	                      NULL            AS NomeBairro,
	                      NULL            AS Logradouro,
	                      NULL               LogradouroAbrev,
	                      NULL            AS LogComplemento,
	                      NULL            AS LogTipo,
	                      c.CEP,
	                      GETDATE()       AS DataAtualizacao,
	                      CAST(0 AS BIT)  AS Alterado,
	                      CAST(0 AS INT)  AS IdLogradouroDNE,
	                      CAST('' AS VARCHAR) AS UsaLogTipo
	               FROM   Cidades c
	                      LEFT JOIN Estados e
	                           ON  e.IdEstado = c.IdEstado
	               WHERE  (c.CEP = @CEPin) 
	               UNION   
	               SELECT DISTINCT NULL  AS IdLogradouro,
	                      e.SiglaUf,
	                      c.NomeCidade,
	                      b.NomeBairro,
	                      UPPER(l.GRU_ENDERECO) AS Logradouro,
	                      UPPER(l.GRU_ENDERECO) AS LogradouroAbrev,
	                      UPPER(l.GRU_NO_ABREV) AS LogComplemento,
	                      CAST('' AS VARCHAR) AS LogTipo,
	                      l.CEP,
	                      GETDATE()      AS DataAtualizacao,
	                      NULL           AS Alterado,
	                      NULL           AS IdLogradouroDNE,
	                      NULL           AS UsaLogTipo
	               FROM   log_grande_usuario l
	                      LEFT JOIN Bairros b
	                           ON  b.IdBairroDNE = l.BAI_NU
	                      LEFT JOIN Cidades c
	                           ON  c.IdCidade = b.IdCidade
	                      LEFT JOIN Estados e
	                           ON  e.IdEstado = c.IdEstado
	               WHERE  (l.CEP = @CEPin) 
	               UNION   
	               SELECT DISTINCT NULL  AS IdLogradouro,
	                      e.SiglaUf,
	                      c.NomeCidade,
	                      b.NomeBairro,
	                      UPPER(l.UOP_ENDERECO) AS Logradouro,
	                      UPPER(l.UOP_ENDERECO) AS LogradouroAbrev,
	                      CAST('' AS VARCHAR) AS LogComplemento,
	                      CAST('' AS VARCHAR) AS LogTipo,
	                      l.CEP,
	                      GETDATE()      AS DataAtualizacao,
	                      NULL           AS Alterado,
	                      NULL           AS IdLogradouroDNE,
	                      NULL           AS UsaLogTipo
	               FROM   LOG_UNID_OPER l
	                      LEFT JOIN Bairros b
	                           ON  b.IdBairroDNE = l.BAI_NU
	                      LEFT JOIN Cidades c
	                           ON  c.IdCidade = b.IdCidade
	                      LEFT JOIN Estados e
	                           ON  e.IdEstado = c.IdEstado
	               WHERE  (l.CEP = @CEPin) 
	               UNION   
	               SELECT DISTINCT NULL  AS IdLogradouro,
	                      e.SiglaUf,
	                      c.NomeCidade,
	                      CAST('' AS VARCHAR) AS NomeBairro,
	                      UPPER(log_cpc.cpc_endereco) AS Logradouro,
	                      UPPER(log_cpc.cpc_endereco) AS LogradouroAbrev,
	                      CAST('' AS VARCHAR) AS LogComplemento,
	                      CAST('' AS VARCHAR) AS LogTipo,
	                      log_cpc.CEP,
	                      GETDATE()      AS DataAtualizacao,
	                      NULL           AS Alterado,
	                      NULL           AS IdLogradouroDNE,
	                      NULL           AS UsaLogTipo
	               FROM   log_cpc
	                      JOIN cidades c
	                           ON  c.IdCidadeDNE = log_cpc.loc_nu
	                      LEFT JOIN Estados e
	                           ON  e.IdEstado = c.IdEstado
	               WHERE  (log_cpc.CEP = @CEPin)
	           )X
	END
	
	IF @Opcao <> ''
	BEGIN
		SELECT  @LOCALIDADE  AS Localidade,
				@BAIRRO      AS Bairro,
				@LOGRADOURO  AS Logradouro,
				@CEP         AS CEP,
				@UF          AS UF,
				@CLIENTE     AS Cliente,
				@IDLOGRADOURO AS IdLogradouro,
				@LOGRADOUROABREV AS LogradouroAbrev,
				@LOGCOMPL AS LogComplemento,
				@LOGTIPO AS LogTipo,
				@DATAATUALIZACAO AS DataAtualizacao,
				@ALTERADO AS Alterado,
				@IDLOGRADOURODNE AS IdLogradouroDNE,
				@USALOGTIPO	AS UsaLogTipo,
				@DESATIVADO AS Desativado
	END
