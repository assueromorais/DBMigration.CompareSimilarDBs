CREATE TABLE [dbo].[LivrosDividaAtiva] (
    [IdLivro]                INT           IDENTITY (1, 1) NOT NULL,
    [NumeroLivro]            VARCHAR (10)  NULL,
    [DataAbertura]           DATETIME      NULL,
    [TermoAbertura]          TEXT          NULL,
    [DataEncerramento]       DATETIME      NULL,
    [TermoEncerramento]      TEXT          NULL,
    [IndAtualizado]          BIT           NULL,
    [TamanhoNumCDA]          INT           CONSTRAINT [DF__LivrosDiv__Taman__029E180E] DEFAULT ((4)) NULL,
    [PrefixoNumTermo]        VARCHAR (20)  NULL,
    [TituloImpressao]        VARCHAR (100) NULL,
    [IncluiAbertContPag]     BIT           CONSTRAINT [DF__LivrosDiv__Inclu__20500D34] DEFAULT ((1)) NOT NULL,
    [TipoLivro]              INT           NULL,
    [QtdeCertidoesPagina]    INT           NULL,
    [QtdeCertidoesEmitidas]  INT           NULL,
    [IndEncerramentoLivro]   INT           NULL,
    [AnoReferenciaLivro]     INT           NULL,
    [QtdePaginasPermitidas]  INT           NULL,
    [PrefixoNumCDA]          VARCHAR (20)  NULL,
    [SufixoNumCDA]           VARCHAR (20)  NULL,
    [TextoInfCertidao]       TEXT          NULL,
    [TextoSupCertidao]       TEXT          NULL,
    [TextoInfAviso]          TEXT          NULL,
    [TextoSupAviso]          TEXT          NULL,
    [EncerrarAno]            BIT           NULL,
    [EncerrarQtdePagina]     BIT           NULL,
    [IdModeloDocumento]      INT           NULL,
    [ConfigPage]             VARCHAR (50)  NULL,
    [TextoInfPeticao]        TEXT          NULL,
    [TextoSupPeticao]        TEXT          NULL,
    [AtualizaDebitoCertidao] BIT           DEFAULT ((0)) NOT NULL,
    [AtualizaDebitoTermo]    BIT           DEFAULT ((0)) NOT NULL,
    [AtualizaDebitoPeticao]  BIT           DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_LivrosDividaAtiva] PRIMARY KEY CLUSTERED ([IdLivro] ASC)
);


GO
CREATE TRIGGER [TrgLog_LivrosDividaAtiva] ON [Implanta_CRPAM].[dbo].[LivrosDividaAtiva] 
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
SET @TableName = 'LivrosDividaAtiva'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLivro : «' + RTRIM( ISNULL( CAST (IdLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLivro : «' + RTRIM( ISNULL( CAST (NumeroLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAbertura : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAbertura, 113 ),'Nulo'))+'» '
                         + '| DataEncerramento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEncerramento, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndAtualizado IS NULL THEN ' IndAtualizado : «Nulo» '
                                              WHEN  IndAtualizado = 0 THEN ' IndAtualizado : «Falso» '
                                              WHEN  IndAtualizado = 1 THEN ' IndAtualizado : «Verdadeiro» '
                                    END 
                         + '| TamanhoNumCDA : «' + RTRIM( ISNULL( CAST (TamanhoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoNumTermo : «' + RTRIM( ISNULL( CAST (PrefixoNumTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloImpressao : «' + RTRIM( ISNULL( CAST (TituloImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncluiAbertContPag IS NULL THEN ' IncluiAbertContPag : «Nulo» '
                                              WHEN  IncluiAbertContPag = 0 THEN ' IncluiAbertContPag : «Falso» '
                                              WHEN  IncluiAbertContPag = 1 THEN ' IncluiAbertContPag : «Verdadeiro» '
                                    END 
                         + '| TipoLivro : «' + RTRIM( ISNULL( CAST (TipoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCertidoesPagina : «' + RTRIM( ISNULL( CAST (QtdeCertidoesPagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCertidoesEmitidas : «' + RTRIM( ISNULL( CAST (QtdeCertidoesEmitidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndEncerramentoLivro : «' + RTRIM( ISNULL( CAST (IndEncerramentoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoReferenciaLivro : «' + RTRIM( ISNULL( CAST (AnoReferenciaLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdePaginasPermitidas : «' + RTRIM( ISNULL( CAST (QtdePaginasPermitidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoNumCDA : «' + RTRIM( ISNULL( CAST (PrefixoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoNumCDA : «' + RTRIM( ISNULL( CAST (SufixoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EncerrarAno IS NULL THEN ' EncerrarAno : «Nulo» '
                                              WHEN  EncerrarAno = 0 THEN ' EncerrarAno : «Falso» '
                                              WHEN  EncerrarAno = 1 THEN ' EncerrarAno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EncerrarQtdePagina IS NULL THEN ' EncerrarQtdePagina : «Nulo» '
                                              WHEN  EncerrarQtdePagina = 0 THEN ' EncerrarQtdePagina : «Falso» '
                                              WHEN  EncerrarQtdePagina = 1 THEN ' EncerrarQtdePagina : «Verdadeiro» '
                                    END 
                         + '| IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigPage : «' + RTRIM( ISNULL( CAST (ConfigPage AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoCertidao IS NULL THEN ' AtualizaDebitoCertidao : «Nulo» '
                                              WHEN  AtualizaDebitoCertidao = 0 THEN ' AtualizaDebitoCertidao : «Falso» '
                                              WHEN  AtualizaDebitoCertidao = 1 THEN ' AtualizaDebitoCertidao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoTermo IS NULL THEN ' AtualizaDebitoTermo : «Nulo» '
                                              WHEN  AtualizaDebitoTermo = 0 THEN ' AtualizaDebitoTermo : «Falso» '
                                              WHEN  AtualizaDebitoTermo = 1 THEN ' AtualizaDebitoTermo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoPeticao IS NULL THEN ' AtualizaDebitoPeticao : «Nulo» '
                                              WHEN  AtualizaDebitoPeticao = 0 THEN ' AtualizaDebitoPeticao : «Falso» '
                                              WHEN  AtualizaDebitoPeticao = 1 THEN ' AtualizaDebitoPeticao : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdLivro : «' + RTRIM( ISNULL( CAST (IdLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLivro : «' + RTRIM( ISNULL( CAST (NumeroLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAbertura : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAbertura, 113 ),'Nulo'))+'» '
                         + '| DataEncerramento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEncerramento, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndAtualizado IS NULL THEN ' IndAtualizado : «Nulo» '
                                              WHEN  IndAtualizado = 0 THEN ' IndAtualizado : «Falso» '
                                              WHEN  IndAtualizado = 1 THEN ' IndAtualizado : «Verdadeiro» '
                                    END 
                         + '| TamanhoNumCDA : «' + RTRIM( ISNULL( CAST (TamanhoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoNumTermo : «' + RTRIM( ISNULL( CAST (PrefixoNumTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloImpressao : «' + RTRIM( ISNULL( CAST (TituloImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncluiAbertContPag IS NULL THEN ' IncluiAbertContPag : «Nulo» '
                                              WHEN  IncluiAbertContPag = 0 THEN ' IncluiAbertContPag : «Falso» '
                                              WHEN  IncluiAbertContPag = 1 THEN ' IncluiAbertContPag : «Verdadeiro» '
                                    END 
                         + '| TipoLivro : «' + RTRIM( ISNULL( CAST (TipoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCertidoesPagina : «' + RTRIM( ISNULL( CAST (QtdeCertidoesPagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCertidoesEmitidas : «' + RTRIM( ISNULL( CAST (QtdeCertidoesEmitidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndEncerramentoLivro : «' + RTRIM( ISNULL( CAST (IndEncerramentoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoReferenciaLivro : «' + RTRIM( ISNULL( CAST (AnoReferenciaLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdePaginasPermitidas : «' + RTRIM( ISNULL( CAST (QtdePaginasPermitidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoNumCDA : «' + RTRIM( ISNULL( CAST (PrefixoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoNumCDA : «' + RTRIM( ISNULL( CAST (SufixoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EncerrarAno IS NULL THEN ' EncerrarAno : «Nulo» '
                                              WHEN  EncerrarAno = 0 THEN ' EncerrarAno : «Falso» '
                                              WHEN  EncerrarAno = 1 THEN ' EncerrarAno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EncerrarQtdePagina IS NULL THEN ' EncerrarQtdePagina : «Nulo» '
                                              WHEN  EncerrarQtdePagina = 0 THEN ' EncerrarQtdePagina : «Falso» '
                                              WHEN  EncerrarQtdePagina = 1 THEN ' EncerrarQtdePagina : «Verdadeiro» '
                                    END 
                         + '| IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigPage : «' + RTRIM( ISNULL( CAST (ConfigPage AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoCertidao IS NULL THEN ' AtualizaDebitoCertidao : «Nulo» '
                                              WHEN  AtualizaDebitoCertidao = 0 THEN ' AtualizaDebitoCertidao : «Falso» '
                                              WHEN  AtualizaDebitoCertidao = 1 THEN ' AtualizaDebitoCertidao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoTermo IS NULL THEN ' AtualizaDebitoTermo : «Nulo» '
                                              WHEN  AtualizaDebitoTermo = 0 THEN ' AtualizaDebitoTermo : «Falso» '
                                              WHEN  AtualizaDebitoTermo = 1 THEN ' AtualizaDebitoTermo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoPeticao IS NULL THEN ' AtualizaDebitoPeticao : «Nulo» '
                                              WHEN  AtualizaDebitoPeticao = 0 THEN ' AtualizaDebitoPeticao : «Falso» '
                                              WHEN  AtualizaDebitoPeticao = 1 THEN ' AtualizaDebitoPeticao : «Verdadeiro» '
                                    END  FROM INSERTED 
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
		SELECT @Conteudo = 'IdLivro : «' + RTRIM( ISNULL( CAST (IdLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLivro : «' + RTRIM( ISNULL( CAST (NumeroLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAbertura : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAbertura, 113 ),'Nulo'))+'» '
                         + '| DataEncerramento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEncerramento, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndAtualizado IS NULL THEN ' IndAtualizado : «Nulo» '
                                              WHEN  IndAtualizado = 0 THEN ' IndAtualizado : «Falso» '
                                              WHEN  IndAtualizado = 1 THEN ' IndAtualizado : «Verdadeiro» '
                                    END 
                         + '| TamanhoNumCDA : «' + RTRIM( ISNULL( CAST (TamanhoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoNumTermo : «' + RTRIM( ISNULL( CAST (PrefixoNumTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloImpressao : «' + RTRIM( ISNULL( CAST (TituloImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncluiAbertContPag IS NULL THEN ' IncluiAbertContPag : «Nulo» '
                                              WHEN  IncluiAbertContPag = 0 THEN ' IncluiAbertContPag : «Falso» '
                                              WHEN  IncluiAbertContPag = 1 THEN ' IncluiAbertContPag : «Verdadeiro» '
                                    END 
                         + '| TipoLivro : «' + RTRIM( ISNULL( CAST (TipoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCertidoesPagina : «' + RTRIM( ISNULL( CAST (QtdeCertidoesPagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCertidoesEmitidas : «' + RTRIM( ISNULL( CAST (QtdeCertidoesEmitidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndEncerramentoLivro : «' + RTRIM( ISNULL( CAST (IndEncerramentoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoReferenciaLivro : «' + RTRIM( ISNULL( CAST (AnoReferenciaLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdePaginasPermitidas : «' + RTRIM( ISNULL( CAST (QtdePaginasPermitidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoNumCDA : «' + RTRIM( ISNULL( CAST (PrefixoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoNumCDA : «' + RTRIM( ISNULL( CAST (SufixoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EncerrarAno IS NULL THEN ' EncerrarAno : «Nulo» '
                                              WHEN  EncerrarAno = 0 THEN ' EncerrarAno : «Falso» '
                                              WHEN  EncerrarAno = 1 THEN ' EncerrarAno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EncerrarQtdePagina IS NULL THEN ' EncerrarQtdePagina : «Nulo» '
                                              WHEN  EncerrarQtdePagina = 0 THEN ' EncerrarQtdePagina : «Falso» '
                                              WHEN  EncerrarQtdePagina = 1 THEN ' EncerrarQtdePagina : «Verdadeiro» '
                                    END 
                         + '| IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigPage : «' + RTRIM( ISNULL( CAST (ConfigPage AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoCertidao IS NULL THEN ' AtualizaDebitoCertidao : «Nulo» '
                                              WHEN  AtualizaDebitoCertidao = 0 THEN ' AtualizaDebitoCertidao : «Falso» '
                                              WHEN  AtualizaDebitoCertidao = 1 THEN ' AtualizaDebitoCertidao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoTermo IS NULL THEN ' AtualizaDebitoTermo : «Nulo» '
                                              WHEN  AtualizaDebitoTermo = 0 THEN ' AtualizaDebitoTermo : «Falso» '
                                              WHEN  AtualizaDebitoTermo = 1 THEN ' AtualizaDebitoTermo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoPeticao IS NULL THEN ' AtualizaDebitoPeticao : «Nulo» '
                                              WHEN  AtualizaDebitoPeticao = 0 THEN ' AtualizaDebitoPeticao : «Falso» '
                                              WHEN  AtualizaDebitoPeticao = 1 THEN ' AtualizaDebitoPeticao : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLivro : «' + RTRIM( ISNULL( CAST (IdLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLivro : «' + RTRIM( ISNULL( CAST (NumeroLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAbertura : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAbertura, 113 ),'Nulo'))+'» '
                         + '| DataEncerramento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEncerramento, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndAtualizado IS NULL THEN ' IndAtualizado : «Nulo» '
                                              WHEN  IndAtualizado = 0 THEN ' IndAtualizado : «Falso» '
                                              WHEN  IndAtualizado = 1 THEN ' IndAtualizado : «Verdadeiro» '
                                    END 
                         + '| TamanhoNumCDA : «' + RTRIM( ISNULL( CAST (TamanhoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoNumTermo : «' + RTRIM( ISNULL( CAST (PrefixoNumTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloImpressao : «' + RTRIM( ISNULL( CAST (TituloImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncluiAbertContPag IS NULL THEN ' IncluiAbertContPag : «Nulo» '
                                              WHEN  IncluiAbertContPag = 0 THEN ' IncluiAbertContPag : «Falso» '
                                              WHEN  IncluiAbertContPag = 1 THEN ' IncluiAbertContPag : «Verdadeiro» '
                                    END 
                         + '| TipoLivro : «' + RTRIM( ISNULL( CAST (TipoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCertidoesPagina : «' + RTRIM( ISNULL( CAST (QtdeCertidoesPagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCertidoesEmitidas : «' + RTRIM( ISNULL( CAST (QtdeCertidoesEmitidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndEncerramentoLivro : «' + RTRIM( ISNULL( CAST (IndEncerramentoLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoReferenciaLivro : «' + RTRIM( ISNULL( CAST (AnoReferenciaLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdePaginasPermitidas : «' + RTRIM( ISNULL( CAST (QtdePaginasPermitidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoNumCDA : «' + RTRIM( ISNULL( CAST (PrefixoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoNumCDA : «' + RTRIM( ISNULL( CAST (SufixoNumCDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EncerrarAno IS NULL THEN ' EncerrarAno : «Nulo» '
                                              WHEN  EncerrarAno = 0 THEN ' EncerrarAno : «Falso» '
                                              WHEN  EncerrarAno = 1 THEN ' EncerrarAno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EncerrarQtdePagina IS NULL THEN ' EncerrarQtdePagina : «Nulo» '
                                              WHEN  EncerrarQtdePagina = 0 THEN ' EncerrarQtdePagina : «Falso» '
                                              WHEN  EncerrarQtdePagina = 1 THEN ' EncerrarQtdePagina : «Verdadeiro» '
                                    END 
                         + '| IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigPage : «' + RTRIM( ISNULL( CAST (ConfigPage AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoCertidao IS NULL THEN ' AtualizaDebitoCertidao : «Nulo» '
                                              WHEN  AtualizaDebitoCertidao = 0 THEN ' AtualizaDebitoCertidao : «Falso» '
                                              WHEN  AtualizaDebitoCertidao = 1 THEN ' AtualizaDebitoCertidao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoTermo IS NULL THEN ' AtualizaDebitoTermo : «Nulo» '
                                              WHEN  AtualizaDebitoTermo = 0 THEN ' AtualizaDebitoTermo : «Falso» '
                                              WHEN  AtualizaDebitoTermo = 1 THEN ' AtualizaDebitoTermo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtualizaDebitoPeticao IS NULL THEN ' AtualizaDebitoPeticao : «Nulo» '
                                              WHEN  AtualizaDebitoPeticao = 0 THEN ' AtualizaDebitoPeticao : «Falso» '
                                              WHEN  AtualizaDebitoPeticao = 1 THEN ' AtualizaDebitoPeticao : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
