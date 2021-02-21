CREATE TABLE [dbo].[ItensImoveis] (
    [IdItem]                       INT              IDENTITY (1, 1) NOT NULL,
    [CodigoItem]                   VARCHAR (20)     NOT NULL,
    [IdTipo]                       INT              NOT NULL,
    [IdConta]                      INT              NOT NULL,
    [IdValorAtual]                 INT              NULL,
    [IdFormaAquisicao]             INT              NULL,
    [IdFormaBaixa]                 INT              NULL,
    [IdResponsavel]                INT              NULL,
    [IdComissao]                   INT              NULL,
    [IdComarca]                    INT              NULL,
    [IdAluguel]                    INT              NULL,
    [IdCartorio]                   INT              NULL,
    [IdPessoa]                     INT              NULL,
    [NomeItem]                     VARCHAR (60)     NOT NULL,
    [Endereco]                     VARCHAR (60)     NULL,
    [NomeBairro]                   VARCHAR (35)     NULL,
    [NomeCidade]                   VARCHAR (30)     NULL,
    [CEP]                          VARCHAR (9)      NULL,
    [SiglaUF]                      VARCHAR (2)      NULL,
    [NumeroRegistroCartorio]       VARCHAR (10)     NULL,
    [NumeroLivroCartorio]          VARCHAR (10)     NULL,
    [NumeroFolhaCartorio]          VARCHAR (10)     NULL,
    [Empenho]                      VARCHAR (30)     NULL,
    [NumeroProcesso]               VARCHAR (20)     NULL,
    [ValorAquisicao]               MONEY            NOT NULL,
    [DataAquisicao]                DATETIME         NOT NULL,
    [DataBaixa]                    DATETIME         NULL,
    [ValorBaixa]                   MONEY            NULL,
    [NumeroProcessoBaixa]          VARCHAR (10)     NULL,
    [DataUltimaModificacao]        DATETIME         NULL,
    [Descricao]                    TEXT             NULL,
    [MotivoBaixa]                  TEXT             NULL,
    [AnoEmpenho]                   SMALLINT         NULL,
    [IdContaAquisicao]             INT              NULL,
    [IdContaAlienacao]             INT              NULL,
    [IdContaReavaliacao]           INT              NULL,
    [IdMoedaSG]                    INT              NULL,
    [IdLiquidacao]                 UNIQUEIDENTIFIER NULL,
    [NumeroLiquidacao]             INT              NULL,
    [IdContaMCASP]                 UNIQUEIDENTIFIER NULL,
    [ValorAcumuladoDepreciacao]    MONEY            NULL,
    [DataUltimaDepreciacao]        DATETIME         NULL,
    [DataPrimeiraDepreciacao]      DATETIME         NULL,
    [PercentValResidualBI]         FLOAT (53)       NULL,
    [VidaUtilBI]                   INT              NULL,
    [HistoricoDepreciacaoBI]       TEXT             NULL,
    [QtdMesesDepreciacaoAcumulada] INT              DEFAULT ((0)) NULL,
    [E_Doacao]                     BIT              DEFAULT ((0)) NOT NULL,
    [IdContaVPAMCASP]              UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_ItensImoveis] PRIMARY KEY NONCLUSTERED ([IdItem] ASC),
    CONSTRAINT [FK_ItensImoveis_Alugueis] FOREIGN KEY ([IdAluguel]) REFERENCES [dbo].[Alugueis] ([IdAluguel]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensImoveis_Cartorios] FOREIGN KEY ([IdCartorio]) REFERENCES [dbo].[Cartorios] ([IdCartorio]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensImoveis_Comarcas] FOREIGN KEY ([IdComarca]) REFERENCES [dbo].[Comarcas] ([IdComarca]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensImoveis_Comissoes] FOREIGN KEY ([IdComissao]) REFERENCES [dbo].[Comissoes] ([IdComissao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensImoveis_FormasAquisicao] FOREIGN KEY ([IdFormaAquisicao]) REFERENCES [dbo].[FormasAquisicao] ([IdFormaAquisicao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensImoveis_FormasBaixa] FOREIGN KEY ([IdFormaBaixa]) REFERENCES [dbo].[FormasBaixa] ([IdFormaBaixa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensImoveis_MoedasSG] FOREIGN KEY ([IdMoedaSG]) REFERENCES [dbo].[MoedasSG] ([IdMoedaSG]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensImoveis_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensImoveis_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ItensImoveis_Reavaliacoes] FOREIGN KEY ([IdValorAtual]) REFERENCES [dbo].[Reavaliacoes] ([IdValorAtual]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensImoveis_TiposBens] FOREIGN KEY ([IdTipo]) REFERENCES [dbo].[TiposBens] ([IdTipo]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[ItensImoveis] NOCHECK CONSTRAINT [FK_ItensImoveis_Alugueis];


GO
ALTER TABLE [dbo].[ItensImoveis] NOCHECK CONSTRAINT [FK_ItensImoveis_Comissoes];


GO
ALTER TABLE [dbo].[ItensImoveis] NOCHECK CONSTRAINT [FK_ItensImoveis_Pessoas];


GO
CREATE TRIGGER [TrgLog_ItensImoveis] ON [Implanta_CRPAM].[dbo].[ItensImoveis] 
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
SET @TableName = 'ItensImoveis'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoItem : «' + RTRIM( ISNULL( CAST (CodigoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipo : «' + RTRIM( ISNULL( CAST (IdTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtual : «' + RTRIM( ISNULL( CAST (IdValorAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaAquisicao : «' + RTRIM( ISNULL( CAST (IdFormaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComarca : «' + RTRIM( ISNULL( CAST (IdComarca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAluguel : «' + RTRIM( ISNULL( CAST (IdAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCartorio : «' + RTRIM( ISNULL( CAST (IdCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRegistroCartorio : «' + RTRIM( ISNULL( CAST (NumeroRegistroCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLivroCartorio : «' + RTRIM( ISNULL( CAST (NumeroLivroCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFolhaCartorio : «' + RTRIM( ISNULL( CAST (NumeroFolhaCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAquisicao : «' + RTRIM( ISNULL( CAST (ValorAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAquisicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAquisicao, 113 ),'Nulo'))+'» '
                         + '| DataBaixa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBaixa, 113 ),'Nulo'))+'» '
                         + '| ValorBaixa : «' + RTRIM( ISNULL( CAST (ValorBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcessoBaixa : «' + RTRIM( ISNULL( CAST (NumeroProcessoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaModificacao, 113 ),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicao : «' + RTRIM( ISNULL( CAST (IdContaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacao : «' + RTRIM( ISNULL( CAST (IdContaAlienacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacao : «' + RTRIM( ISNULL( CAST (IdContaReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLiquidacao : «' + RTRIM( ISNULL( CAST (NumeroLiquidacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| PercentValResidualBI : «' + RTRIM( ISNULL( CAST (PercentValResidualBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilBI : «' + RTRIM( ISNULL( CAST (VidaUtilBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesDepreciacaoAcumulada : «' + RTRIM( ISNULL( CAST (QtdMesesDepreciacaoAcumulada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Doacao IS NULL THEN ' E_Doacao : «Nulo» '
                                              WHEN  E_Doacao = 0 THEN ' E_Doacao : «Falso» '
                                              WHEN  E_Doacao = 1 THEN ' E_Doacao : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoItem : «' + RTRIM( ISNULL( CAST (CodigoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipo : «' + RTRIM( ISNULL( CAST (IdTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtual : «' + RTRIM( ISNULL( CAST (IdValorAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaAquisicao : «' + RTRIM( ISNULL( CAST (IdFormaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComarca : «' + RTRIM( ISNULL( CAST (IdComarca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAluguel : «' + RTRIM( ISNULL( CAST (IdAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCartorio : «' + RTRIM( ISNULL( CAST (IdCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRegistroCartorio : «' + RTRIM( ISNULL( CAST (NumeroRegistroCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLivroCartorio : «' + RTRIM( ISNULL( CAST (NumeroLivroCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFolhaCartorio : «' + RTRIM( ISNULL( CAST (NumeroFolhaCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAquisicao : «' + RTRIM( ISNULL( CAST (ValorAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAquisicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAquisicao, 113 ),'Nulo'))+'» '
                         + '| DataBaixa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBaixa, 113 ),'Nulo'))+'» '
                         + '| ValorBaixa : «' + RTRIM( ISNULL( CAST (ValorBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcessoBaixa : «' + RTRIM( ISNULL( CAST (NumeroProcessoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaModificacao, 113 ),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicao : «' + RTRIM( ISNULL( CAST (IdContaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacao : «' + RTRIM( ISNULL( CAST (IdContaAlienacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacao : «' + RTRIM( ISNULL( CAST (IdContaReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLiquidacao : «' + RTRIM( ISNULL( CAST (NumeroLiquidacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| PercentValResidualBI : «' + RTRIM( ISNULL( CAST (PercentValResidualBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilBI : «' + RTRIM( ISNULL( CAST (VidaUtilBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesDepreciacaoAcumulada : «' + RTRIM( ISNULL( CAST (QtdMesesDepreciacaoAcumulada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Doacao IS NULL THEN ' E_Doacao : «Nulo» '
                                              WHEN  E_Doacao = 0 THEN ' E_Doacao : «Falso» '
                                              WHEN  E_Doacao = 1 THEN ' E_Doacao : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoItem : «' + RTRIM( ISNULL( CAST (CodigoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipo : «' + RTRIM( ISNULL( CAST (IdTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtual : «' + RTRIM( ISNULL( CAST (IdValorAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaAquisicao : «' + RTRIM( ISNULL( CAST (IdFormaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComarca : «' + RTRIM( ISNULL( CAST (IdComarca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAluguel : «' + RTRIM( ISNULL( CAST (IdAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCartorio : «' + RTRIM( ISNULL( CAST (IdCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRegistroCartorio : «' + RTRIM( ISNULL( CAST (NumeroRegistroCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLivroCartorio : «' + RTRIM( ISNULL( CAST (NumeroLivroCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFolhaCartorio : «' + RTRIM( ISNULL( CAST (NumeroFolhaCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAquisicao : «' + RTRIM( ISNULL( CAST (ValorAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAquisicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAquisicao, 113 ),'Nulo'))+'» '
                         + '| DataBaixa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBaixa, 113 ),'Nulo'))+'» '
                         + '| ValorBaixa : «' + RTRIM( ISNULL( CAST (ValorBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcessoBaixa : «' + RTRIM( ISNULL( CAST (NumeroProcessoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaModificacao, 113 ),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicao : «' + RTRIM( ISNULL( CAST (IdContaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacao : «' + RTRIM( ISNULL( CAST (IdContaAlienacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacao : «' + RTRIM( ISNULL( CAST (IdContaReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLiquidacao : «' + RTRIM( ISNULL( CAST (NumeroLiquidacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| PercentValResidualBI : «' + RTRIM( ISNULL( CAST (PercentValResidualBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilBI : «' + RTRIM( ISNULL( CAST (VidaUtilBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesDepreciacaoAcumulada : «' + RTRIM( ISNULL( CAST (QtdMesesDepreciacaoAcumulada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Doacao IS NULL THEN ' E_Doacao : «Nulo» '
                                              WHEN  E_Doacao = 0 THEN ' E_Doacao : «Falso» '
                                              WHEN  E_Doacao = 1 THEN ' E_Doacao : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoItem : «' + RTRIM( ISNULL( CAST (CodigoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipo : «' + RTRIM( ISNULL( CAST (IdTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtual : «' + RTRIM( ISNULL( CAST (IdValorAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaAquisicao : «' + RTRIM( ISNULL( CAST (IdFormaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComarca : «' + RTRIM( ISNULL( CAST (IdComarca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAluguel : «' + RTRIM( ISNULL( CAST (IdAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCartorio : «' + RTRIM( ISNULL( CAST (IdCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRegistroCartorio : «' + RTRIM( ISNULL( CAST (NumeroRegistroCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLivroCartorio : «' + RTRIM( ISNULL( CAST (NumeroLivroCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFolhaCartorio : «' + RTRIM( ISNULL( CAST (NumeroFolhaCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAquisicao : «' + RTRIM( ISNULL( CAST (ValorAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAquisicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAquisicao, 113 ),'Nulo'))+'» '
                         + '| DataBaixa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBaixa, 113 ),'Nulo'))+'» '
                         + '| ValorBaixa : «' + RTRIM( ISNULL( CAST (ValorBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcessoBaixa : «' + RTRIM( ISNULL( CAST (NumeroProcessoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaModificacao, 113 ),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicao : «' + RTRIM( ISNULL( CAST (IdContaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacao : «' + RTRIM( ISNULL( CAST (IdContaAlienacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacao : «' + RTRIM( ISNULL( CAST (IdContaReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLiquidacao : «' + RTRIM( ISNULL( CAST (NumeroLiquidacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| PercentValResidualBI : «' + RTRIM( ISNULL( CAST (PercentValResidualBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilBI : «' + RTRIM( ISNULL( CAST (VidaUtilBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesDepreciacaoAcumulada : «' + RTRIM( ISNULL( CAST (QtdMesesDepreciacaoAcumulada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Doacao IS NULL THEN ' E_Doacao : «Nulo» '
                                              WHEN  E_Doacao = 0 THEN ' E_Doacao : «Falso» '
                                              WHEN  E_Doacao = 1 THEN ' E_Doacao : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
