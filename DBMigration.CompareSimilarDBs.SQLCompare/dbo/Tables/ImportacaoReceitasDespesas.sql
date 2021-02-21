CREATE TABLE [dbo].[ImportacaoReceitasDespesas] (
    [IdImportacaoReceitaDespesa] INT          IDENTITY (1, 1) NOT NULL,
    [IdConjuntoReceita]          INT          NULL,
    [Tipo]                       VARCHAR (1)  NULL,
    [Data]                       DATETIME     NULL,
    [IdContaDebito]              INT          NOT NULL,
    [IdContaCredito]             INT          NOT NULL,
    [IdCentroCustoReceita]       INT          NULL,
    [QtdReceita]                 INT          NULL,
    [Valor]                      MONEY        NULL,
    [ValorUnitario]              MONEY        NULL,
    [Historico]                  TEXT         NULL,
    [IdReceita]                  INT          NULL,
    [IdLancamento]               INT          NULL,
    [IdOrigem]                   INT          NULL,
    [Status]                     VARCHAR (10) NULL,
    [IdControleArquivoCob]       INT          NULL,
    [IdConvenioSipro]            INT          NULL,
    [RegistraLog]                BIT          CONSTRAINT [DF__Importaca__Regis__0AE879F5] DEFAULT ((1)) NULL,
    [IdMovimentoFinanceiro]      INT          NULL,
    [IdDebito]                   INT          NULL,
    [IdConjuntoOperacao]         INT          NULL,
    [Evento]                     VARCHAR (40) NULL,
    [DataImportacao]             DATETIME     NULL,
    [IdParametroContabilDetalhe] INT          NULL,
    [DataPrevisao]               DATETIME     NULL,
    [ValorPrevisao]              MONEY        NULL,
    CONSTRAINT [PK_ImportacaoReceitasDespesas] PRIMARY KEY CLUSTERED ([IdImportacaoReceitaDespesa] ASC),
    CONSTRAINT [FK_ImportacaoReceitasDespesas_CentroCustosReceita] FOREIGN KEY ([IdCentroCustoReceita]) REFERENCES [dbo].[CentroCustosReceita] ([IdCentroCustoReceita]),
    CONSTRAINT [FK_ImportacaoReceitasDespesas_ControleArquivosCobranca] FOREIGN KEY ([IdControleArquivoCob]) REFERENCES [dbo].[ControleArquivosCobranca] ([IdControleArquivoCob]),
    CONSTRAINT [FK_ImportacaoReceitasDespesas_ConveniosSipro] FOREIGN KEY ([IdConvenioSipro]) REFERENCES [dbo].[ConveniosSipro] ([IdConvenioSipro]),
    CONSTRAINT [FK_ImportacaoReceitasDespesas_ImportacaoReceitasDespesas] FOREIGN KEY ([IdConjuntoReceita]) REFERENCES [dbo].[ImportacaoReceitasDespesas] ([IdImportacaoReceitaDespesa]),
    CONSTRAINT [FK_ImportacaoReceitasDespesas_ImportacaoReceitasDespesas1] FOREIGN KEY ([IdOrigem]) REFERENCES [dbo].[ImportacaoReceitasDespesas] ([IdImportacaoReceitaDespesa]),
    CONSTRAINT [FK_ImportacaoReceitasDespesas_Lancamentos] FOREIGN KEY ([IdLancamento]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_ImportacaoReceitasDespesas_PlanoContas] FOREIGN KEY ([IdContaDebito]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ImportacaoReceitasDespesas_PlanoContas1] FOREIGN KEY ([IdContaCredito]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ImportacaoReceitasDespesas_Receitas] FOREIGN KEY ([IdReceita]) REFERENCES [dbo].[Receitas] ([IdReceita])
);


GO
ALTER TABLE [dbo].[ImportacaoReceitasDespesas] NOCHECK CONSTRAINT [FK_ImportacaoReceitasDespesas_ControleArquivosCobranca];


GO
ALTER TABLE [dbo].[ImportacaoReceitasDespesas] NOCHECK CONSTRAINT [FK_ImportacaoReceitasDespesas_ConveniosSipro];


GO
ALTER TABLE [dbo].[ImportacaoReceitasDespesas] NOCHECK CONSTRAINT [FK_ImportacaoReceitasDespesas_ImportacaoReceitasDespesas];


GO
ALTER TABLE [dbo].[ImportacaoReceitasDespesas] NOCHECK CONSTRAINT [FK_ImportacaoReceitasDespesas_ImportacaoReceitasDespesas1];


GO
ALTER TABLE [dbo].[ImportacaoReceitasDespesas] NOCHECK CONSTRAINT [FK_ImportacaoReceitasDespesas_Lancamentos];


GO
ALTER TABLE [dbo].[ImportacaoReceitasDespesas] NOCHECK CONSTRAINT [FK_ImportacaoReceitasDespesas_PlanoContas];


GO
ALTER TABLE [dbo].[ImportacaoReceitasDespesas] NOCHECK CONSTRAINT [FK_ImportacaoReceitasDespesas_PlanoContas1];


GO
ALTER TABLE [dbo].[ImportacaoReceitasDespesas] NOCHECK CONSTRAINT [FK_ImportacaoReceitasDespesas_Receitas];


GO
CREATE TRIGGER [TrgLog_ImportacaoReceitasDespesas] ON [Implanta_CRPAM].[dbo].[ImportacaoReceitasDespesas] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
DECLARE 	@RegistraLogI	BIT 
DECLARE 	@RegistraLogD	BIT 
SELECT @RegistraLogI = RegistraLog FROM INSERTED 
SELECT @RegistraLogD = RegistraLog FROM DELETED 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'ImportacaoReceitasDespesas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdImportacaoReceitaDespesa : «' + RTRIM( ISNULL( CAST (IdImportacaoReceitaDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoReceita : «' + RTRIM( ISNULL( CAST (IdConjuntoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdContaDebito : «' + RTRIM( ISNULL( CAST (IdContaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCredito : «' + RTRIM( ISNULL( CAST (IdContaCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdReceita : «' + RTRIM( ISNULL( CAST (QtdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrigem : «' + RTRIM( ISNULL( CAST (IdOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Status : «' + RTRIM( ISNULL( CAST (Status AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenioSipro : «' + RTRIM( ISNULL( CAST (IdConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoOperacao : «' + RTRIM( ISNULL( CAST (IdConjuntoOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| IdParametroContabilDetalhe : «' + RTRIM( ISNULL( CAST (IdParametroContabilDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisao : «' + RTRIM( ISNULL( CAST (ValorPrevisao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdImportacaoReceitaDespesa : «' + RTRIM( ISNULL( CAST (IdImportacaoReceitaDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoReceita : «' + RTRIM( ISNULL( CAST (IdConjuntoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdContaDebito : «' + RTRIM( ISNULL( CAST (IdContaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCredito : «' + RTRIM( ISNULL( CAST (IdContaCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdReceita : «' + RTRIM( ISNULL( CAST (QtdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrigem : «' + RTRIM( ISNULL( CAST (IdOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Status : «' + RTRIM( ISNULL( CAST (Status AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenioSipro : «' + RTRIM( ISNULL( CAST (IdConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoOperacao : «' + RTRIM( ISNULL( CAST (IdConjuntoOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| IdParametroContabilDetalhe : «' + RTRIM( ISNULL( CAST (IdParametroContabilDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisao : «' + RTRIM( ISNULL( CAST (ValorPrevisao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
 END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
AND @RegistraLogI = 1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'IdImportacaoReceitaDespesa : «' + RTRIM( ISNULL( CAST (IdImportacaoReceitaDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoReceita : «' + RTRIM( ISNULL( CAST (IdConjuntoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdContaDebito : «' + RTRIM( ISNULL( CAST (IdContaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCredito : «' + RTRIM( ISNULL( CAST (IdContaCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdReceita : «' + RTRIM( ISNULL( CAST (QtdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrigem : «' + RTRIM( ISNULL( CAST (IdOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Status : «' + RTRIM( ISNULL( CAST (Status AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenioSipro : «' + RTRIM( ISNULL( CAST (IdConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoOperacao : «' + RTRIM( ISNULL( CAST (IdConjuntoOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| IdParametroContabilDetalhe : «' + RTRIM( ISNULL( CAST (IdParametroContabilDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisao : «' + RTRIM( ISNULL( CAST (ValorPrevisao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdImportacaoReceitaDespesa : «' + RTRIM( ISNULL( CAST (IdImportacaoReceitaDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoReceita : «' + RTRIM( ISNULL( CAST (IdConjuntoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdContaDebito : «' + RTRIM( ISNULL( CAST (IdContaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCredito : «' + RTRIM( ISNULL( CAST (IdContaCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdReceita : «' + RTRIM( ISNULL( CAST (QtdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrigem : «' + RTRIM( ISNULL( CAST (IdOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Status : «' + RTRIM( ISNULL( CAST (Status AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenioSipro : «' + RTRIM( ISNULL( CAST (IdConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConjuntoOperacao : «' + RTRIM( ISNULL( CAST (IdConjuntoOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Evento : «' + RTRIM( ISNULL( CAST (Evento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| IdParametroContabilDetalhe : «' + RTRIM( ISNULL( CAST (IdParametroContabilDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisao : «' + RTRIM( ISNULL( CAST (ValorPrevisao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
