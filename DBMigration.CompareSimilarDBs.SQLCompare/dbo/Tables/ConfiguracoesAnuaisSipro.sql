CREATE TABLE [dbo].[ConfiguracoesAnuaisSipro] (
    [Exercicio]                       VARCHAR (4)  NOT NULL,
    [IdsContaDespesaPessoal]          TEXT         NULL,
    [IdContaCreditoAnulacaoRP]        INT          NULL,
    [IdContaCreditoPatAnulacaoRP]     INT          NULL,
    [IdContaDebitoPatAnulacaoRP]      INT          NULL,
    [IdContaCusto]                    INT          NULL,
    [IdContaTransfReceita]            INT          NULL,
    [IdContaCustodia]                 INT          NULL,
    [IdContaDevolucaoRecARealizar]    INT          NULL,
    [IdContaCustoRecRealiz]           INT          NULL,
    [IdCCCustoRepasseReceita]         INT          NULL,
    [IdCCCustoReceita]                INT          NULL,
    [IdCCCustoRecRealiz]              INT          NULL,
    [IdContaEntrada]                  INT          NULL,
    [IdContaSaida]                    INT          NULL,
    [IdContaPatrimonioAL]             INT          NULL,
    [IdContaAquisicaoBM]              INT          NULL,
    [IdContaAlienacaoBM]              INT          NULL,
    [IdContaReavaliacaoBM]            INT          NULL,
    [IdContaAquisicaoBI]              INT          NULL,
    [IdContaAlienacaoBI]              INT          NULL,
    [IdContaReavaliacaoBI]            INT          NULL,
    [IdContaBensMoveis]               INT          NULL,
    [IdContaBensImoveis]              INT          NULL,
    [DataContabilizacaoAL]            DATETIME     NULL,
    [DataContabilizacaoPAT]           DATETIME     NULL,
    [MascaraCCusto]                   VARCHAR (20) NULL,
    [MascaraEvento]                   VARCHAR (15) NULL,
    [UsaSubArea]                      BIT          NULL,
    [TravamentoSubArea]               BIT          NULL,
    [DigitosSubArea]                  INT          NULL,
    [IdContaDepreciacaoBM]            INT          NULL,
    [IdContaPatrimonialFat]           INT          NULL,
    [TravamentoCCustoAnulacao]        BIT          NULL,
    [TravamentoCCustoEmpenho]         BIT          NULL,
    [TravamentoCCustoPagamento]       BIT          NULL,
    [TravamentoCCustoPreEmpenho]      BIT          NULL,
    [TravamentoCCustoPrestacaoConta]  BIT          NULL,
    [TravamentoCCustoRestosAnulacao]  BIT          NULL,
    [TravamentoCCustoRestosEmpenho]   BIT          NULL,
    [TravamentoCCustoRestosPagamento] BIT          NULL,
    [OrcamentoCCustoporConta]         BIT          CONSTRAINT [DF_ConfiguracoesAnuaisSiproOrcamentoCCustoporConta] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ConfiguracoesAnuaisSipro] PRIMARY KEY CLUSTERED ([Exercicio] ASC),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_CentroCustos] FOREIGN KEY ([IdCCCustoReceita]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_CentroCustos1] FOREIGN KEY ([IdCCCustoRecRealiz]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_CentroCustos2] FOREIGN KEY ([IdCCCustoRepasseReceita]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_PlanoContas] FOREIGN KEY ([IdContaCreditoAnulacaoRP]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_PlanoContas1] FOREIGN KEY ([IdContaCreditoPatAnulacaoRP]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_PlanoContas2] FOREIGN KEY ([IdContaCusto]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_PlanoContas3] FOREIGN KEY ([IdContaCustodia]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_PlanoContas4] FOREIGN KEY ([IdContaCustoRecRealiz]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_PlanoContas5] FOREIGN KEY ([IdContaDebitoPatAnulacaoRP]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_PlanoContas6] FOREIGN KEY ([IdContaDevolucaoRecARealizar]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ConfiguracoesAnuaisSipro_PlanoContas7] FOREIGN KEY ([IdContaTransfReceita]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE TRIGGER [TrgLog_ConfiguracoesAnuaisSipro] ON [Implanta_CRPAM].[dbo].[ConfiguracoesAnuaisSipro] 
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
SET @TableName = 'ConfiguracoesAnuaisSipro'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebitoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaDebitoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCusto : «' + RTRIM( ISNULL( CAST (IdContaCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaTransfReceita : «' + RTRIM( ISNULL( CAST (IdContaTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustodia : «' + RTRIM( ISNULL( CAST (IdContaCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDevolucaoRecARealizar : «' + RTRIM( ISNULL( CAST (IdContaDevolucaoRecARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustoRecRealiz : «' + RTRIM( ISNULL( CAST (IdContaCustoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRepasseReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoRepasseReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRecRealiz : «' + RTRIM( ISNULL( CAST (IdCCCustoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaEntrada : «' + RTRIM( ISNULL( CAST (IdContaEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaSaida : «' + RTRIM( ISNULL( CAST (IdContaSaida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonioAL : «' + RTRIM( ISNULL( CAST (IdContaPatrimonioAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBM : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBM : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBM : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBI : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBI : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBI : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensMoveis : «' + RTRIM( ISNULL( CAST (IdContaBensMoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensImoveis : «' + RTRIM( ISNULL( CAST (IdContaBensImoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT, 113 ),'Nulo'))+'» '
                         + '| MascaraCCusto : «' + RTRIM( ISNULL( CAST (MascaraCCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MascaraEvento : «' + RTRIM( ISNULL( CAST (MascaraEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaSubArea IS NULL THEN ' UsaSubArea : «Nulo» '
                                              WHEN  UsaSubArea = 0 THEN ' UsaSubArea : «Falso» '
                                              WHEN  UsaSubArea = 1 THEN ' UsaSubArea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoSubArea IS NULL THEN ' TravamentoSubArea : «Nulo» '
                                              WHEN  TravamentoSubArea = 0 THEN ' TravamentoSubArea : «Falso» '
                                              WHEN  TravamentoSubArea = 1 THEN ' TravamentoSubArea : «Verdadeiro» '
                                    END 
                         + '| DigitosSubArea : «' + RTRIM( ISNULL( CAST (DigitosSubArea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDepreciacaoBM : «' + RTRIM( ISNULL( CAST (IdContaDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialFat : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialFat AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoAnulacao IS NULL THEN ' TravamentoCCustoAnulacao : «Nulo» '
                                              WHEN  TravamentoCCustoAnulacao = 0 THEN ' TravamentoCCustoAnulacao : «Falso» '
                                              WHEN  TravamentoCCustoAnulacao = 1 THEN ' TravamentoCCustoAnulacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoEmpenho IS NULL THEN ' TravamentoCCustoEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoEmpenho = 0 THEN ' TravamentoCCustoEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoEmpenho = 1 THEN ' TravamentoCCustoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPagamento IS NULL THEN ' TravamentoCCustoPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoPagamento = 0 THEN ' TravamentoCCustoPagamento : «Falso» '
                                              WHEN  TravamentoCCustoPagamento = 1 THEN ' TravamentoCCustoPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPreEmpenho IS NULL THEN ' TravamentoCCustoPreEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoPreEmpenho = 0 THEN ' TravamentoCCustoPreEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoPreEmpenho = 1 THEN ' TravamentoCCustoPreEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPrestacaoConta IS NULL THEN ' TravamentoCCustoPrestacaoConta : «Nulo» '
                                              WHEN  TravamentoCCustoPrestacaoConta = 0 THEN ' TravamentoCCustoPrestacaoConta : «Falso» '
                                              WHEN  TravamentoCCustoPrestacaoConta = 1 THEN ' TravamentoCCustoPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosAnulacao IS NULL THEN ' TravamentoCCustoRestosAnulacao : «Nulo» '
                                              WHEN  TravamentoCCustoRestosAnulacao = 0 THEN ' TravamentoCCustoRestosAnulacao : «Falso» '
                                              WHEN  TravamentoCCustoRestosAnulacao = 1 THEN ' TravamentoCCustoRestosAnulacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosEmpenho IS NULL THEN ' TravamentoCCustoRestosEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoRestosEmpenho = 0 THEN ' TravamentoCCustoRestosEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoRestosEmpenho = 1 THEN ' TravamentoCCustoRestosEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosPagamento IS NULL THEN ' TravamentoCCustoRestosPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoRestosPagamento = 0 THEN ' TravamentoCCustoRestosPagamento : «Falso» '
                                              WHEN  TravamentoCCustoRestosPagamento = 1 THEN ' TravamentoCCustoRestosPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OrcamentoCCustoporConta IS NULL THEN ' OrcamentoCCustoporConta : «Nulo» '
                                              WHEN  OrcamentoCCustoporConta = 0 THEN ' OrcamentoCCustoporConta : «Falso» '
                                              WHEN  OrcamentoCCustoporConta = 1 THEN ' OrcamentoCCustoporConta : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebitoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaDebitoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCusto : «' + RTRIM( ISNULL( CAST (IdContaCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaTransfReceita : «' + RTRIM( ISNULL( CAST (IdContaTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustodia : «' + RTRIM( ISNULL( CAST (IdContaCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDevolucaoRecARealizar : «' + RTRIM( ISNULL( CAST (IdContaDevolucaoRecARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustoRecRealiz : «' + RTRIM( ISNULL( CAST (IdContaCustoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRepasseReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoRepasseReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRecRealiz : «' + RTRIM( ISNULL( CAST (IdCCCustoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaEntrada : «' + RTRIM( ISNULL( CAST (IdContaEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaSaida : «' + RTRIM( ISNULL( CAST (IdContaSaida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonioAL : «' + RTRIM( ISNULL( CAST (IdContaPatrimonioAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBM : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBM : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBM : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBI : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBI : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBI : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensMoveis : «' + RTRIM( ISNULL( CAST (IdContaBensMoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensImoveis : «' + RTRIM( ISNULL( CAST (IdContaBensImoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT, 113 ),'Nulo'))+'» '
                         + '| MascaraCCusto : «' + RTRIM( ISNULL( CAST (MascaraCCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MascaraEvento : «' + RTRIM( ISNULL( CAST (MascaraEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaSubArea IS NULL THEN ' UsaSubArea : «Nulo» '
                                              WHEN  UsaSubArea = 0 THEN ' UsaSubArea : «Falso» '
                                              WHEN  UsaSubArea = 1 THEN ' UsaSubArea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoSubArea IS NULL THEN ' TravamentoSubArea : «Nulo» '
                                              WHEN  TravamentoSubArea = 0 THEN ' TravamentoSubArea : «Falso» '
                                              WHEN  TravamentoSubArea = 1 THEN ' TravamentoSubArea : «Verdadeiro» '
                                    END 
                         + '| DigitosSubArea : «' + RTRIM( ISNULL( CAST (DigitosSubArea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDepreciacaoBM : «' + RTRIM( ISNULL( CAST (IdContaDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialFat : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialFat AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoAnulacao IS NULL THEN ' TravamentoCCustoAnulacao : «Nulo» '
                                              WHEN  TravamentoCCustoAnulacao = 0 THEN ' TravamentoCCustoAnulacao : «Falso» '
                                              WHEN  TravamentoCCustoAnulacao = 1 THEN ' TravamentoCCustoAnulacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoEmpenho IS NULL THEN ' TravamentoCCustoEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoEmpenho = 0 THEN ' TravamentoCCustoEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoEmpenho = 1 THEN ' TravamentoCCustoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPagamento IS NULL THEN ' TravamentoCCustoPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoPagamento = 0 THEN ' TravamentoCCustoPagamento : «Falso» '
                                              WHEN  TravamentoCCustoPagamento = 1 THEN ' TravamentoCCustoPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPreEmpenho IS NULL THEN ' TravamentoCCustoPreEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoPreEmpenho = 0 THEN ' TravamentoCCustoPreEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoPreEmpenho = 1 THEN ' TravamentoCCustoPreEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPrestacaoConta IS NULL THEN ' TravamentoCCustoPrestacaoConta : «Nulo» '
                                              WHEN  TravamentoCCustoPrestacaoConta = 0 THEN ' TravamentoCCustoPrestacaoConta : «Falso» '
                                              WHEN  TravamentoCCustoPrestacaoConta = 1 THEN ' TravamentoCCustoPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosAnulacao IS NULL THEN ' TravamentoCCustoRestosAnulacao : «Nulo» '
                                              WHEN  TravamentoCCustoRestosAnulacao = 0 THEN ' TravamentoCCustoRestosAnulacao : «Falso» '
                                              WHEN  TravamentoCCustoRestosAnulacao = 1 THEN ' TravamentoCCustoRestosAnulacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosEmpenho IS NULL THEN ' TravamentoCCustoRestosEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoRestosEmpenho = 0 THEN ' TravamentoCCustoRestosEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoRestosEmpenho = 1 THEN ' TravamentoCCustoRestosEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosPagamento IS NULL THEN ' TravamentoCCustoRestosPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoRestosPagamento = 0 THEN ' TravamentoCCustoRestosPagamento : «Falso» '
                                              WHEN  TravamentoCCustoRestosPagamento = 1 THEN ' TravamentoCCustoRestosPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OrcamentoCCustoporConta IS NULL THEN ' OrcamentoCCustoporConta : «Nulo» '
                                              WHEN  OrcamentoCCustoporConta = 0 THEN ' OrcamentoCCustoporConta : «Falso» '
                                              WHEN  OrcamentoCCustoporConta = 1 THEN ' OrcamentoCCustoporConta : «Verdadeiro» '
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
		SELECT @Conteudo = 'Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebitoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaDebitoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCusto : «' + RTRIM( ISNULL( CAST (IdContaCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaTransfReceita : «' + RTRIM( ISNULL( CAST (IdContaTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustodia : «' + RTRIM( ISNULL( CAST (IdContaCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDevolucaoRecARealizar : «' + RTRIM( ISNULL( CAST (IdContaDevolucaoRecARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustoRecRealiz : «' + RTRIM( ISNULL( CAST (IdContaCustoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRepasseReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoRepasseReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRecRealiz : «' + RTRIM( ISNULL( CAST (IdCCCustoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaEntrada : «' + RTRIM( ISNULL( CAST (IdContaEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaSaida : «' + RTRIM( ISNULL( CAST (IdContaSaida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonioAL : «' + RTRIM( ISNULL( CAST (IdContaPatrimonioAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBM : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBM : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBM : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBI : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBI : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBI : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensMoveis : «' + RTRIM( ISNULL( CAST (IdContaBensMoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensImoveis : «' + RTRIM( ISNULL( CAST (IdContaBensImoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT, 113 ),'Nulo'))+'» '
                         + '| MascaraCCusto : «' + RTRIM( ISNULL( CAST (MascaraCCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MascaraEvento : «' + RTRIM( ISNULL( CAST (MascaraEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaSubArea IS NULL THEN ' UsaSubArea : «Nulo» '
                                              WHEN  UsaSubArea = 0 THEN ' UsaSubArea : «Falso» '
                                              WHEN  UsaSubArea = 1 THEN ' UsaSubArea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoSubArea IS NULL THEN ' TravamentoSubArea : «Nulo» '
                                              WHEN  TravamentoSubArea = 0 THEN ' TravamentoSubArea : «Falso» '
                                              WHEN  TravamentoSubArea = 1 THEN ' TravamentoSubArea : «Verdadeiro» '
                                    END 
                         + '| DigitosSubArea : «' + RTRIM( ISNULL( CAST (DigitosSubArea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDepreciacaoBM : «' + RTRIM( ISNULL( CAST (IdContaDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialFat : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialFat AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoAnulacao IS NULL THEN ' TravamentoCCustoAnulacao : «Nulo» '
                                              WHEN  TravamentoCCustoAnulacao = 0 THEN ' TravamentoCCustoAnulacao : «Falso» '
                                              WHEN  TravamentoCCustoAnulacao = 1 THEN ' TravamentoCCustoAnulacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoEmpenho IS NULL THEN ' TravamentoCCustoEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoEmpenho = 0 THEN ' TravamentoCCustoEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoEmpenho = 1 THEN ' TravamentoCCustoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPagamento IS NULL THEN ' TravamentoCCustoPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoPagamento = 0 THEN ' TravamentoCCustoPagamento : «Falso» '
                                              WHEN  TravamentoCCustoPagamento = 1 THEN ' TravamentoCCustoPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPreEmpenho IS NULL THEN ' TravamentoCCustoPreEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoPreEmpenho = 0 THEN ' TravamentoCCustoPreEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoPreEmpenho = 1 THEN ' TravamentoCCustoPreEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPrestacaoConta IS NULL THEN ' TravamentoCCustoPrestacaoConta : «Nulo» '
                                              WHEN  TravamentoCCustoPrestacaoConta = 0 THEN ' TravamentoCCustoPrestacaoConta : «Falso» '
                                              WHEN  TravamentoCCustoPrestacaoConta = 1 THEN ' TravamentoCCustoPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosAnulacao IS NULL THEN ' TravamentoCCustoRestosAnulacao : «Nulo» '
                                              WHEN  TravamentoCCustoRestosAnulacao = 0 THEN ' TravamentoCCustoRestosAnulacao : «Falso» '
                                              WHEN  TravamentoCCustoRestosAnulacao = 1 THEN ' TravamentoCCustoRestosAnulacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosEmpenho IS NULL THEN ' TravamentoCCustoRestosEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoRestosEmpenho = 0 THEN ' TravamentoCCustoRestosEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoRestosEmpenho = 1 THEN ' TravamentoCCustoRestosEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosPagamento IS NULL THEN ' TravamentoCCustoRestosPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoRestosPagamento = 0 THEN ' TravamentoCCustoRestosPagamento : «Falso» '
                                              WHEN  TravamentoCCustoRestosPagamento = 1 THEN ' TravamentoCCustoRestosPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OrcamentoCCustoporConta IS NULL THEN ' OrcamentoCCustoporConta : «Nulo» '
                                              WHEN  OrcamentoCCustoporConta = 0 THEN ' OrcamentoCCustoporConta : «Falso» '
                                              WHEN  OrcamentoCCustoporConta = 1 THEN ' OrcamentoCCustoporConta : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaCreditoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebitoPatAnulacaoRP : «' + RTRIM( ISNULL( CAST (IdContaDebitoPatAnulacaoRP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCusto : «' + RTRIM( ISNULL( CAST (IdContaCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaTransfReceita : «' + RTRIM( ISNULL( CAST (IdContaTransfReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustodia : «' + RTRIM( ISNULL( CAST (IdContaCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDevolucaoRecARealizar : «' + RTRIM( ISNULL( CAST (IdContaDevolucaoRecARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCustoRecRealiz : «' + RTRIM( ISNULL( CAST (IdContaCustoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRepasseReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoRepasseReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoReceita : «' + RTRIM( ISNULL( CAST (IdCCCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCCCustoRecRealiz : «' + RTRIM( ISNULL( CAST (IdCCCustoRecRealiz AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaEntrada : «' + RTRIM( ISNULL( CAST (IdContaEntrada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaSaida : «' + RTRIM( ISNULL( CAST (IdContaSaida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonioAL : «' + RTRIM( ISNULL( CAST (IdContaPatrimonioAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBM : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBM : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBM : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicaoBI : «' + RTRIM( ISNULL( CAST (IdContaAquisicaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacaoBI : «' + RTRIM( ISNULL( CAST (IdContaAlienacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacaoBI : «' + RTRIM( ISNULL( CAST (IdContaReavaliacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensMoveis : «' + RTRIM( ISNULL( CAST (IdContaBensMoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBensImoveis : «' + RTRIM( ISNULL( CAST (IdContaBensImoveis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContabilizacaoAL : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoAL, 113 ),'Nulo'))+'» '
                         + '| DataContabilizacaoPAT : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContabilizacaoPAT, 113 ),'Nulo'))+'» '
                         + '| MascaraCCusto : «' + RTRIM( ISNULL( CAST (MascaraCCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MascaraEvento : «' + RTRIM( ISNULL( CAST (MascaraEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaSubArea IS NULL THEN ' UsaSubArea : «Nulo» '
                                              WHEN  UsaSubArea = 0 THEN ' UsaSubArea : «Falso» '
                                              WHEN  UsaSubArea = 1 THEN ' UsaSubArea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoSubArea IS NULL THEN ' TravamentoSubArea : «Nulo» '
                                              WHEN  TravamentoSubArea = 0 THEN ' TravamentoSubArea : «Falso» '
                                              WHEN  TravamentoSubArea = 1 THEN ' TravamentoSubArea : «Verdadeiro» '
                                    END 
                         + '| DigitosSubArea : «' + RTRIM( ISNULL( CAST (DigitosSubArea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDepreciacaoBM : «' + RTRIM( ISNULL( CAST (IdContaDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialFat : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialFat AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoAnulacao IS NULL THEN ' TravamentoCCustoAnulacao : «Nulo» '
                                              WHEN  TravamentoCCustoAnulacao = 0 THEN ' TravamentoCCustoAnulacao : «Falso» '
                                              WHEN  TravamentoCCustoAnulacao = 1 THEN ' TravamentoCCustoAnulacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoEmpenho IS NULL THEN ' TravamentoCCustoEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoEmpenho = 0 THEN ' TravamentoCCustoEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoEmpenho = 1 THEN ' TravamentoCCustoEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPagamento IS NULL THEN ' TravamentoCCustoPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoPagamento = 0 THEN ' TravamentoCCustoPagamento : «Falso» '
                                              WHEN  TravamentoCCustoPagamento = 1 THEN ' TravamentoCCustoPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPreEmpenho IS NULL THEN ' TravamentoCCustoPreEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoPreEmpenho = 0 THEN ' TravamentoCCustoPreEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoPreEmpenho = 1 THEN ' TravamentoCCustoPreEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoPrestacaoConta IS NULL THEN ' TravamentoCCustoPrestacaoConta : «Nulo» '
                                              WHEN  TravamentoCCustoPrestacaoConta = 0 THEN ' TravamentoCCustoPrestacaoConta : «Falso» '
                                              WHEN  TravamentoCCustoPrestacaoConta = 1 THEN ' TravamentoCCustoPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosAnulacao IS NULL THEN ' TravamentoCCustoRestosAnulacao : «Nulo» '
                                              WHEN  TravamentoCCustoRestosAnulacao = 0 THEN ' TravamentoCCustoRestosAnulacao : «Falso» '
                                              WHEN  TravamentoCCustoRestosAnulacao = 1 THEN ' TravamentoCCustoRestosAnulacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosEmpenho IS NULL THEN ' TravamentoCCustoRestosEmpenho : «Nulo» '
                                              WHEN  TravamentoCCustoRestosEmpenho = 0 THEN ' TravamentoCCustoRestosEmpenho : «Falso» '
                                              WHEN  TravamentoCCustoRestosEmpenho = 1 THEN ' TravamentoCCustoRestosEmpenho : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoCCustoRestosPagamento IS NULL THEN ' TravamentoCCustoRestosPagamento : «Nulo» '
                                              WHEN  TravamentoCCustoRestosPagamento = 0 THEN ' TravamentoCCustoRestosPagamento : «Falso» '
                                              WHEN  TravamentoCCustoRestosPagamento = 1 THEN ' TravamentoCCustoRestosPagamento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OrcamentoCCustoporConta IS NULL THEN ' OrcamentoCCustoporConta : «Nulo» '
                                              WHEN  OrcamentoCCustoporConta = 0 THEN ' OrcamentoCCustoporConta : «Falso» '
                                              WHEN  OrcamentoCCustoporConta = 1 THEN ' OrcamentoCCustoporConta : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
