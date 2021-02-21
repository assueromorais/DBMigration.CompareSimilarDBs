CREATE TABLE [dbo].[DevolucoesReceita] (
    [IdDevolucaoReceita]           INT              IDENTITY (1, 1) NOT NULL,
    [IdDespachoExpediente]         INT              NULL,
    [IdCentroCustoReceita]         INT              NULL,
    [IdProfissional]               INT              NULL,
    [IdSolicitante]                INT              NULL,
    [Folha]                        NVARCHAR (10)    NULL,
    [NossoControle]                NVARCHAR (20)    NULL,
    [IdMotivoDevolucao]            INT              NULL,
    [IdSituacaoDevolucao]          INT              NULL,
    [NumProtocolo]                 NVARCHAR (20)    NULL,
    [Deferido]                     BIT              NULL,
    [ValorRestituir]               MONEY            NULL,
    [DataCredito]                  DATETIME         NULL,
    [Observacao]                   NTEXT            NULL,
    [JustificativaIndeferido]      NTEXT            NULL,
    [DataEntradaUnidade]           DATETIME         NULL,
    [DataEnvioFinanceiro]          DATETIME         NULL,
    [DataRecebimentoFinanceiro]    DATETIME         NULL,
    [Data1Indeferimento]           DATETIME         NULL,
    [Data2Indeferimento]           DATETIME         NULL,
    [Data1Retorno]                 DATETIME         NULL,
    [Data2Retorno]                 DATETIME         NULL,
    [IdProcessoDevolucaoReceita]   INT              NULL,
    [IdCentroCustoReceitaCadastro] INT              NULL,
    [IdRecebimentoSISCONTNET]      UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_DevolucaoReceita] PRIMARY KEY CLUSTERED ([IdDevolucaoReceita] ASC),
    CONSTRAINT [FK_DevolucoesReceita_CentroCustosReceita] FOREIGN KEY ([IdCentroCustoReceita]) REFERENCES [dbo].[CentroCustosReceita] ([IdCentroCustoReceita]),
    CONSTRAINT [FK_DevolucoesReceita_DespachosExpediente] FOREIGN KEY ([IdDespachoExpediente]) REFERENCES [dbo].[DespachosExpediente] ([IdDespachoExpediente]),
    CONSTRAINT [FK_DevolucoesReceita_MotivosDevolucao] FOREIGN KEY ([IdMotivoDevolucao]) REFERENCES [dbo].[MotivosDevolucao] ([IdMotivoDevolucao]),
    CONSTRAINT [FK_DevolucoesReceita_PessoasProfissional] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_DevolucoesReceita_PessoasSolicitante] FOREIGN KEY ([IdSolicitante]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_DevolucoesReceita_ProcessosDevolucaoReceita] FOREIGN KEY ([IdProcessoDevolucaoReceita]) REFERENCES [dbo].[ProcessosDevolucaoReceita] ([IdProcessoDevolucaoReceita]),
    CONSTRAINT [FK_DevolucoesReceita_SituacoesDevolucao] FOREIGN KEY ([IdSituacaoDevolucao]) REFERENCES [dbo].[SituacoesDevolucao] ([IdSituacaoDevolucao])
);


GO
CREATE TRIGGER [TrgLog_DevolucoesReceita] ON [Implanta_CRPAM].[dbo].[DevolucoesReceita] 
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
SET @TableName = 'DevolucoesReceita'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDespachoExpediente : «' + RTRIM( ISNULL( CAST (IdDespachoExpediente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitante : «' + RTRIM( ISNULL( CAST (IdSolicitante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDevolucao : «' + RTRIM( ISNULL( CAST (IdSituacaoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Deferido IS NULL THEN ' Deferido : «Nulo» '
                                              WHEN  Deferido = 0 THEN ' Deferido : «Falso» '
                                              WHEN  Deferido = 1 THEN ' Deferido : «Verdadeiro» '
                                    END 
                         + '| ValorRestituir : «' + RTRIM( ISNULL( CAST (ValorRestituir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| DataEntradaUnidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntradaUnidade, 113 ),'Nulo'))+'» '
                         + '| DataEnvioFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvioFinanceiro, 113 ),'Nulo'))+'» '
                         + '| DataRecebimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| Data1Indeferimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Indeferimento, 113 ),'Nulo'))+'» '
                         + '| Data2Indeferimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Indeferimento, 113 ),'Nulo'))+'» '
                         + '| Data1Retorno : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Retorno, 113 ),'Nulo'))+'» '
                         + '| Data2Retorno : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Retorno, 113 ),'Nulo'))+'» '
                         + '| IdProcessoDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdProcessoDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceitaCadastro : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceitaCadastro AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDespachoExpediente : «' + RTRIM( ISNULL( CAST (IdDespachoExpediente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitante : «' + RTRIM( ISNULL( CAST (IdSolicitante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDevolucao : «' + RTRIM( ISNULL( CAST (IdSituacaoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Deferido IS NULL THEN ' Deferido : «Nulo» '
                                              WHEN  Deferido = 0 THEN ' Deferido : «Falso» '
                                              WHEN  Deferido = 1 THEN ' Deferido : «Verdadeiro» '
                                    END 
                         + '| ValorRestituir : «' + RTRIM( ISNULL( CAST (ValorRestituir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| DataEntradaUnidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntradaUnidade, 113 ),'Nulo'))+'» '
                         + '| DataEnvioFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvioFinanceiro, 113 ),'Nulo'))+'» '
                         + '| DataRecebimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| Data1Indeferimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Indeferimento, 113 ),'Nulo'))+'» '
                         + '| Data2Indeferimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Indeferimento, 113 ),'Nulo'))+'» '
                         + '| Data1Retorno : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Retorno, 113 ),'Nulo'))+'» '
                         + '| Data2Retorno : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Retorno, 113 ),'Nulo'))+'» '
                         + '| IdProcessoDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdProcessoDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceitaCadastro : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceitaCadastro AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDespachoExpediente : «' + RTRIM( ISNULL( CAST (IdDespachoExpediente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitante : «' + RTRIM( ISNULL( CAST (IdSolicitante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDevolucao : «' + RTRIM( ISNULL( CAST (IdSituacaoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Deferido IS NULL THEN ' Deferido : «Nulo» '
                                              WHEN  Deferido = 0 THEN ' Deferido : «Falso» '
                                              WHEN  Deferido = 1 THEN ' Deferido : «Verdadeiro» '
                                    END 
                         + '| ValorRestituir : «' + RTRIM( ISNULL( CAST (ValorRestituir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| DataEntradaUnidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntradaUnidade, 113 ),'Nulo'))+'» '
                         + '| DataEnvioFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvioFinanceiro, 113 ),'Nulo'))+'» '
                         + '| DataRecebimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| Data1Indeferimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Indeferimento, 113 ),'Nulo'))+'» '
                         + '| Data2Indeferimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Indeferimento, 113 ),'Nulo'))+'» '
                         + '| Data1Retorno : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Retorno, 113 ),'Nulo'))+'» '
                         + '| Data2Retorno : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Retorno, 113 ),'Nulo'))+'» '
                         + '| IdProcessoDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdProcessoDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceitaCadastro : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceitaCadastro AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDespachoExpediente : «' + RTRIM( ISNULL( CAST (IdDespachoExpediente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitante : «' + RTRIM( ISNULL( CAST (IdSolicitante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDevolucao : «' + RTRIM( ISNULL( CAST (IdSituacaoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Deferido IS NULL THEN ' Deferido : «Nulo» '
                                              WHEN  Deferido = 0 THEN ' Deferido : «Falso» '
                                              WHEN  Deferido = 1 THEN ' Deferido : «Verdadeiro» '
                                    END 
                         + '| ValorRestituir : «' + RTRIM( ISNULL( CAST (ValorRestituir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| DataEntradaUnidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntradaUnidade, 113 ),'Nulo'))+'» '
                         + '| DataEnvioFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvioFinanceiro, 113 ),'Nulo'))+'» '
                         + '| DataRecebimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| Data1Indeferimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Indeferimento, 113 ),'Nulo'))+'» '
                         + '| Data2Indeferimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Indeferimento, 113 ),'Nulo'))+'» '
                         + '| Data1Retorno : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Retorno, 113 ),'Nulo'))+'» '
                         + '| Data2Retorno : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Retorno, 113 ),'Nulo'))+'» '
                         + '| IdProcessoDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdProcessoDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceitaCadastro : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceitaCadastro AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
