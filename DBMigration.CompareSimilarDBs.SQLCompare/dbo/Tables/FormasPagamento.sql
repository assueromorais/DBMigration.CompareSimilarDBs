CREATE TABLE [dbo].[FormasPagamento] (
    [IdFormaPagamento]         INT           IDENTITY (1, 1) NOT NULL,
    [IdTipoPagamento]          INT           NOT NULL,
    [IdContaBanco]             INT           NOT NULL,
    [DataPagto]                DATETIME      NOT NULL,
    [ValorPagto]               MONEY         NOT NULL,
    [NumPagto]                 VARCHAR (20)  NULL,
    [DataEmissao]              DATETIME      NULL,
    [DataAnulacao]             DATETIME      NULL,
    [DataModificacao]          DATETIME      NULL,
    [DataDigitacao]            DATETIME      NOT NULL,
    [IdPessoa]                 INT           NOT NULL,
    [Historico]                TEXT          NULL,
    [Conciliado]               BIT           NULL,
    [IdTipoDocumentoPagamento] INT           NULL,
    [NumDocumento]             VARCHAR (50)  NULL,
    [CodigoBarra]              VARCHAR (250) NULL,
    [CodigoBarraCNAB]          VARCHAR (44)  NULL,
    [ValorDescontoCNAB]        MONEY         NULL,
    [ValorMoraMultaCNAB]       MONEY         NULL,
    [NossoNumeroCNAB]          VARCHAR (20)  NULL,
    [Desativado]               BIT           CONSTRAINT [DF_FormasPagamentoDesativado] DEFAULT ((0)) NULL,
    [NumeroProcessoFP]         VARCHAR (20)  NULL,
    CONSTRAINT [PK_FormasPagamento] PRIMARY KEY CLUSTERED ([IdFormaPagamento] ASC),
    CONSTRAINT [FK_FormasPagamento_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_FormasPagamento_PlanoContas] FOREIGN KEY ([IdContaBanco]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_FormasPagamento_TiposDocumentosPagamentos] FOREIGN KEY ([IdTipoDocumentoPagamento]) REFERENCES [dbo].[TiposDocumentosPagamentos] ([IdTipoDocumentoPagamento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_FormasPagamento_TiposPagamentos] FOREIGN KEY ([IdTipoPagamento]) REFERENCES [dbo].[TiposPagamentos] ([IdTipoPagamento])
);


GO
CREATE NONCLUSTERED INDEX [IX_FormasPagamento_IdContaBanco]
    ON [dbo].[FormasPagamento]([IdContaBanco] ASC);


GO
CREATE TRIGGER [TrgLog_FormasPagamento] ON [Implanta_CRPAM].[dbo].[FormasPagamento] 
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
SET @TableName = 'FormasPagamento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBanco : «' + RTRIM( ISNULL( CAST (IdContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagto, 113 ),'Nulo'))+'» '
                         + '| ValorPagto : «' + RTRIM( ISNULL( CAST (ValorPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumPagto : «' + RTRIM( ISNULL( CAST (NumPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataAnulacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnulacao, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| DataDigitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDigitacao, 113 ),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Conciliado IS NULL THEN ' Conciliado : «Nulo» '
                                              WHEN  Conciliado = 0 THEN ' Conciliado : «Falso» '
                                              WHEN  Conciliado = 1 THEN ' Conciliado : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumDocumento : «' + RTRIM( ISNULL( CAST (NumDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarra : «' + RTRIM( ISNULL( CAST (CodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarraCNAB : «' + RTRIM( ISNULL( CAST (CodigoBarraCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDescontoCNAB : «' + RTRIM( ISNULL( CAST (ValorDescontoCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMoraMultaCNAB : «' + RTRIM( ISNULL( CAST (ValorMoraMultaCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumeroCNAB : «' + RTRIM( ISNULL( CAST (NossoNumeroCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| NumeroProcessoFP : «' + RTRIM( ISNULL( CAST (NumeroProcessoFP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBanco : «' + RTRIM( ISNULL( CAST (IdContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagto, 113 ),'Nulo'))+'» '
                         + '| ValorPagto : «' + RTRIM( ISNULL( CAST (ValorPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumPagto : «' + RTRIM( ISNULL( CAST (NumPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataAnulacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnulacao, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| DataDigitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDigitacao, 113 ),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Conciliado IS NULL THEN ' Conciliado : «Nulo» '
                                              WHEN  Conciliado = 0 THEN ' Conciliado : «Falso» '
                                              WHEN  Conciliado = 1 THEN ' Conciliado : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumDocumento : «' + RTRIM( ISNULL( CAST (NumDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarra : «' + RTRIM( ISNULL( CAST (CodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarraCNAB : «' + RTRIM( ISNULL( CAST (CodigoBarraCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDescontoCNAB : «' + RTRIM( ISNULL( CAST (ValorDescontoCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMoraMultaCNAB : «' + RTRIM( ISNULL( CAST (ValorMoraMultaCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumeroCNAB : «' + RTRIM( ISNULL( CAST (NossoNumeroCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| NumeroProcessoFP : «' + RTRIM( ISNULL( CAST (NumeroProcessoFP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBanco : «' + RTRIM( ISNULL( CAST (IdContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagto, 113 ),'Nulo'))+'» '
                         + '| ValorPagto : «' + RTRIM( ISNULL( CAST (ValorPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumPagto : «' + RTRIM( ISNULL( CAST (NumPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataAnulacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnulacao, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| DataDigitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDigitacao, 113 ),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Conciliado IS NULL THEN ' Conciliado : «Nulo» '
                                              WHEN  Conciliado = 0 THEN ' Conciliado : «Falso» '
                                              WHEN  Conciliado = 1 THEN ' Conciliado : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumDocumento : «' + RTRIM( ISNULL( CAST (NumDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarra : «' + RTRIM( ISNULL( CAST (CodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarraCNAB : «' + RTRIM( ISNULL( CAST (CodigoBarraCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDescontoCNAB : «' + RTRIM( ISNULL( CAST (ValorDescontoCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMoraMultaCNAB : «' + RTRIM( ISNULL( CAST (ValorMoraMultaCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumeroCNAB : «' + RTRIM( ISNULL( CAST (NossoNumeroCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| NumeroProcessoFP : «' + RTRIM( ISNULL( CAST (NumeroProcessoFP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBanco : «' + RTRIM( ISNULL( CAST (IdContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagto, 113 ),'Nulo'))+'» '
                         + '| ValorPagto : «' + RTRIM( ISNULL( CAST (ValorPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumPagto : «' + RTRIM( ISNULL( CAST (NumPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataAnulacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnulacao, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| DataDigitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDigitacao, 113 ),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Conciliado IS NULL THEN ' Conciliado : «Nulo» '
                                              WHEN  Conciliado = 0 THEN ' Conciliado : «Falso» '
                                              WHEN  Conciliado = 1 THEN ' Conciliado : «Verdadeiro» '
                                    END 
                         + '| IdTipoDocumentoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumDocumento : «' + RTRIM( ISNULL( CAST (NumDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarra : «' + RTRIM( ISNULL( CAST (CodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarraCNAB : «' + RTRIM( ISNULL( CAST (CodigoBarraCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDescontoCNAB : «' + RTRIM( ISNULL( CAST (ValorDescontoCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMoraMultaCNAB : «' + RTRIM( ISNULL( CAST (ValorMoraMultaCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumeroCNAB : «' + RTRIM( ISNULL( CAST (NossoNumeroCNAB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| NumeroProcessoFP : «' + RTRIM( ISNULL( CAST (NumeroProcessoFP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
