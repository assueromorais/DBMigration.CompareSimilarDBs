CREATE TABLE [dbo].[DocumentosSisdocWEB] (
    [IdDocumento]                 INT           IDENTITY (1, 1) NOT NULL,
    [IdProfissional]              INT           NULL,
    [IdPessoaJuridica]            INT           NULL,
    [IdPessoa]                    INT           NULL,
    [IdModeloDocumento]           INT           NULL,
    [IdTipoDocumento]             INT           NULL,
    [IdSituacaoDocumento]         INT           NULL,
    [IdNivelDocumento]            INT           NOT NULL,
    [IdFuncao]                    INT           NULL,
    [IndOrigemDoc]                CHAR (1)      NOT NULL,
    [Pessoa]                      VARCHAR (120) NULL,
    [NumeroDocumento]             VARCHAR (50)  NULL,
    [ComplementoRemetente]        VARCHAR (100) NULL,
    [Assunto]                     TEXT          NULL,
    [Referencia]                  VARCHAR (80)  NULL,
    [DataHoraEmissao]             DATETIME      NULL,
    [DataDocumento]               DATETIME      NULL,
    [DataPrevistaSolucao]         DATETIME      NULL,
    [DataSolucao]                 DATETIME      NULL,
    [NumProtocolo]                INT           NULL,
    [AnoProtocolo]                INT           NULL,
    [CaminhoFisico]               VARCHAR (60)  NULL,
    [Vinculos]                    VARCHAR (120) NULL,
    [PrazoRespostaDias]           INT           NULL,
    [Observacoes]                 TEXT          NULL,
    [Plenaria]                    BIT           NULL,
    [DataRecebimento]             DATETIME      NULL,
    [IdComplementoRemetente]      INT           NULL,
    [IdUsuarioCriacao]            INT           NULL,
    [IdProcessoOriginou]          INT           NULL,
    [IdProfissionalRequerido]     INT           NULL,
    [IdPessoaRequerido]           INT           NULL,
    [IdPessoaJuridicaRequerido]   INT           NULL,
    [IdDepartamentoCriacao]       INT           NULL,
    [idFormaEntregaDocumento]     INT           NULL,
    [Arquivo]                     IMAGE         NULL,
    [ValorDespesaCustas]          MONEY         NULL,
    [ValorDespesaCopiasPagas]     MONEY         NULL,
    [ValorDespesaCopiasFaturadas] MONEY         NULL,
    [ValorDespesaCorreio]         MONEY         NULL,
    [ValorTaxaServico]            MONEY         NULL,
    [CodiAutenticidadeWeb]        VARCHAR (50)  NULL,
    [DadosArquivo]                IMAGE         NULL,
    [CodigoAutenticidadeWeb]      VARCHAR (50)  NULL
);


GO
CREATE TRIGGER [TrgLog_DocumentosSisdocWEB] ON [Implanta_CRPAM].[dbo].[DocumentosSisdocWEB] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'DocumentosSisdocWEB'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelDocumento : «' + RTRIM( ISNULL( CAST (IdNivelDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndOrigemDoc : «' + RTRIM( ISNULL( CAST (IndOrigemDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pessoa : «' + RTRIM( ISNULL( CAST (Pessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoRemetente : «' + RTRIM( ISNULL( CAST (ComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Referencia : «' + RTRIM( ISNULL( CAST (Referencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraEmissao, 113 ),'Nulo'))+'» '
                         + '| DataDocumento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDocumento, 113 ),'Nulo'))+'» '
                         + '| DataPrevistaSolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevistaSolucao, 113 ),'Nulo'))+'» '
                         + '| DataSolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolucao, 113 ),'Nulo'))+'» '
                         + '| NumProtocolo : «' + RTRIM( ISNULL( CAST (NumProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoProtocolo : «' + RTRIM( ISNULL( CAST (AnoProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoFisico : «' + RTRIM( ISNULL( CAST (CaminhoFisico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vinculos : «' + RTRIM( ISNULL( CAST (Vinculos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoRespostaDias : «' + RTRIM( ISNULL( CAST (PrazoRespostaDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Plenaria IS NULL THEN ' Plenaria : «Nulo» '
                                              WHEN  Plenaria = 0 THEN ' Plenaria : «Falso» '
                                              WHEN  Plenaria = 1 THEN ' Plenaria : «Verdadeiro» '
                                    END 
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| IdComplementoRemetente : «' + RTRIM( ISNULL( CAST (IdComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoOriginou : «' + RTRIM( ISNULL( CAST (IdProcessoOriginou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalRequerido : «' + RTRIM( ISNULL( CAST (IdProfissionalRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaRequerido : «' + RTRIM( ISNULL( CAST (IdPessoaRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaRequerido : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFormaEntregaDocumento : «' + RTRIM( ISNULL( CAST (idFormaEntregaDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCustas : «' + RTRIM( ISNULL( CAST (ValorDespesaCustas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCopiasPagas : «' + RTRIM( ISNULL( CAST (ValorDespesaCopiasPagas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCopiasFaturadas : «' + RTRIM( ISNULL( CAST (ValorDespesaCopiasFaturadas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCorreio : «' + RTRIM( ISNULL( CAST (ValorDespesaCorreio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTaxaServico : «' + RTRIM( ISNULL( CAST (ValorTaxaServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiAutenticidadeWeb : «' + RTRIM( ISNULL( CAST (CodiAutenticidadeWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAutenticidadeWeb : «' + RTRIM( ISNULL( CAST (CodigoAutenticidadeWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelDocumento : «' + RTRIM( ISNULL( CAST (IdNivelDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndOrigemDoc : «' + RTRIM( ISNULL( CAST (IndOrigemDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pessoa : «' + RTRIM( ISNULL( CAST (Pessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoRemetente : «' + RTRIM( ISNULL( CAST (ComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Referencia : «' + RTRIM( ISNULL( CAST (Referencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraEmissao, 113 ),'Nulo'))+'» '
                         + '| DataDocumento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDocumento, 113 ),'Nulo'))+'» '
                         + '| DataPrevistaSolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevistaSolucao, 113 ),'Nulo'))+'» '
                         + '| DataSolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolucao, 113 ),'Nulo'))+'» '
                         + '| NumProtocolo : «' + RTRIM( ISNULL( CAST (NumProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoProtocolo : «' + RTRIM( ISNULL( CAST (AnoProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoFisico : «' + RTRIM( ISNULL( CAST (CaminhoFisico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vinculos : «' + RTRIM( ISNULL( CAST (Vinculos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoRespostaDias : «' + RTRIM( ISNULL( CAST (PrazoRespostaDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Plenaria IS NULL THEN ' Plenaria : «Nulo» '
                                              WHEN  Plenaria = 0 THEN ' Plenaria : «Falso» '
                                              WHEN  Plenaria = 1 THEN ' Plenaria : «Verdadeiro» '
                                    END 
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| IdComplementoRemetente : «' + RTRIM( ISNULL( CAST (IdComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoOriginou : «' + RTRIM( ISNULL( CAST (IdProcessoOriginou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalRequerido : «' + RTRIM( ISNULL( CAST (IdProfissionalRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaRequerido : «' + RTRIM( ISNULL( CAST (IdPessoaRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaRequerido : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFormaEntregaDocumento : «' + RTRIM( ISNULL( CAST (idFormaEntregaDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCustas : «' + RTRIM( ISNULL( CAST (ValorDespesaCustas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCopiasPagas : «' + RTRIM( ISNULL( CAST (ValorDespesaCopiasPagas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCopiasFaturadas : «' + RTRIM( ISNULL( CAST (ValorDespesaCopiasFaturadas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCorreio : «' + RTRIM( ISNULL( CAST (ValorDespesaCorreio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTaxaServico : «' + RTRIM( ISNULL( CAST (ValorTaxaServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiAutenticidadeWeb : «' + RTRIM( ISNULL( CAST (CodiAutenticidadeWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAutenticidadeWeb : «' + RTRIM( ISNULL( CAST (CodigoAutenticidadeWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelDocumento : «' + RTRIM( ISNULL( CAST (IdNivelDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndOrigemDoc : «' + RTRIM( ISNULL( CAST (IndOrigemDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pessoa : «' + RTRIM( ISNULL( CAST (Pessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoRemetente : «' + RTRIM( ISNULL( CAST (ComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Referencia : «' + RTRIM( ISNULL( CAST (Referencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraEmissao, 113 ),'Nulo'))+'» '
                         + '| DataDocumento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDocumento, 113 ),'Nulo'))+'» '
                         + '| DataPrevistaSolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevistaSolucao, 113 ),'Nulo'))+'» '
                         + '| DataSolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolucao, 113 ),'Nulo'))+'» '
                         + '| NumProtocolo : «' + RTRIM( ISNULL( CAST (NumProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoProtocolo : «' + RTRIM( ISNULL( CAST (AnoProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoFisico : «' + RTRIM( ISNULL( CAST (CaminhoFisico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vinculos : «' + RTRIM( ISNULL( CAST (Vinculos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoRespostaDias : «' + RTRIM( ISNULL( CAST (PrazoRespostaDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Plenaria IS NULL THEN ' Plenaria : «Nulo» '
                                              WHEN  Plenaria = 0 THEN ' Plenaria : «Falso» '
                                              WHEN  Plenaria = 1 THEN ' Plenaria : «Verdadeiro» '
                                    END 
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| IdComplementoRemetente : «' + RTRIM( ISNULL( CAST (IdComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoOriginou : «' + RTRIM( ISNULL( CAST (IdProcessoOriginou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalRequerido : «' + RTRIM( ISNULL( CAST (IdProfissionalRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaRequerido : «' + RTRIM( ISNULL( CAST (IdPessoaRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaRequerido : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFormaEntregaDocumento : «' + RTRIM( ISNULL( CAST (idFormaEntregaDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCustas : «' + RTRIM( ISNULL( CAST (ValorDespesaCustas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCopiasPagas : «' + RTRIM( ISNULL( CAST (ValorDespesaCopiasPagas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCopiasFaturadas : «' + RTRIM( ISNULL( CAST (ValorDespesaCopiasFaturadas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCorreio : «' + RTRIM( ISNULL( CAST (ValorDespesaCorreio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTaxaServico : «' + RTRIM( ISNULL( CAST (ValorTaxaServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiAutenticidadeWeb : «' + RTRIM( ISNULL( CAST (CodiAutenticidadeWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAutenticidadeWeb : «' + RTRIM( ISNULL( CAST (CodigoAutenticidadeWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDocumento : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelDocumento : «' + RTRIM( ISNULL( CAST (IdNivelDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndOrigemDoc : «' + RTRIM( ISNULL( CAST (IndOrigemDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pessoa : «' + RTRIM( ISNULL( CAST (Pessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoRemetente : «' + RTRIM( ISNULL( CAST (ComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Referencia : «' + RTRIM( ISNULL( CAST (Referencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraEmissao, 113 ),'Nulo'))+'» '
                         + '| DataDocumento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDocumento, 113 ),'Nulo'))+'» '
                         + '| DataPrevistaSolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevistaSolucao, 113 ),'Nulo'))+'» '
                         + '| DataSolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolucao, 113 ),'Nulo'))+'» '
                         + '| NumProtocolo : «' + RTRIM( ISNULL( CAST (NumProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoProtocolo : «' + RTRIM( ISNULL( CAST (AnoProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoFisico : «' + RTRIM( ISNULL( CAST (CaminhoFisico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vinculos : «' + RTRIM( ISNULL( CAST (Vinculos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoRespostaDias : «' + RTRIM( ISNULL( CAST (PrazoRespostaDias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Plenaria IS NULL THEN ' Plenaria : «Nulo» '
                                              WHEN  Plenaria = 0 THEN ' Plenaria : «Falso» '
                                              WHEN  Plenaria = 1 THEN ' Plenaria : «Verdadeiro» '
                                    END 
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| IdComplementoRemetente : «' + RTRIM( ISNULL( CAST (IdComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoOriginou : «' + RTRIM( ISNULL( CAST (IdProcessoOriginou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalRequerido : «' + RTRIM( ISNULL( CAST (IdProfissionalRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaRequerido : «' + RTRIM( ISNULL( CAST (IdPessoaRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaRequerido : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaRequerido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFormaEntregaDocumento : «' + RTRIM( ISNULL( CAST (idFormaEntregaDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCustas : «' + RTRIM( ISNULL( CAST (ValorDespesaCustas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCopiasPagas : «' + RTRIM( ISNULL( CAST (ValorDespesaCopiasPagas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCopiasFaturadas : «' + RTRIM( ISNULL( CAST (ValorDespesaCopiasFaturadas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesaCorreio : «' + RTRIM( ISNULL( CAST (ValorDespesaCorreio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTaxaServico : «' + RTRIM( ISNULL( CAST (ValorTaxaServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiAutenticidadeWeb : «' + RTRIM( ISNULL( CAST (CodiAutenticidadeWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAutenticidadeWeb : «' + RTRIM( ISNULL( CAST (CodigoAutenticidadeWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
