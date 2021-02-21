CREATE TABLE [dbo].[ItensMoveis] (
    [IdItem]                       INT              IDENTITY (1, 1) NOT NULL,
    [CodigoItem]                   VARCHAR (20)     NOT NULL,
    [CodigoBarra]                  VARCHAR (30)     NULL,
    [IdTipo]                       INT              NOT NULL,
    [IdConta]                      INT              NOT NULL,
    [IdMovimentacaoBem]            INT              NULL,
    [IdValorAtual]                 INT              NULL,
    [IdFormaAquisicao]             INT              NULL,
    [IdFormaBaixa]                 INT              NULL,
    [IdResponsavel]                INT              NULL,
    [IdUnidade]                    INT              NULL,
    [IdComissao]                   INT              NULL,
    [IdPessoa]                     INT              NULL,
    [IdMedidaDuracaoGarantia]      INT              NULL,
    [NomeItem]                     VARCHAR (60)     NOT NULL,
    [Marca]                        VARCHAR (40)     NULL,
    [Modelo]                       VARCHAR (40)     NULL,
    [NumeroSerie]                  VARCHAR (30)     NULL,
    [NotaFiscal]                   VARCHAR (10)     NULL,
    [Empenho]                      VARCHAR (30)     NULL,
    [NumeroProcesso]               VARCHAR (20)     NULL,
    [ValorAquisicao]               MONEY            NOT NULL,
    [DataAquisicao]                DATETIME         NOT NULL,
    [DuracaoGarantia]              INT              NULL,
    [FimGarantia]                  DATETIME         NULL,
    [DataBaixa]                    DATETIME         NULL,
    [ValorBaixa]                   MONEY            NULL,
    [NumeroProcessoBaixa]          VARCHAR (10)     NULL,
    [DataUltimaModificacao]        DATETIME         NULL,
    [Descricao]                    TEXT             NULL,
    [MotivoBaixa]                  TEXT             NULL,
    [CodigoItemAnterior]           VARCHAR (12)     NULL,
    [AnoEmpenho]                   SMALLINT         NULL,
    [IdContaAquisicao]             INT              NULL,
    [IdContaAlienacao]             INT              NULL,
    [IdContaReavaliacao]           INT              NULL,
    [IdMoedaSG]                    INT              NULL,
    [Foto]                         IMAGE            NULL,
    [PercentValResidualBM]         FLOAT (53)       NULL,
    [VidaUtilBM]                   INT              NULL,
    [HistoricoDepreciacaoBM]       TEXT             NULL,
    [IdLocalEntrega]               INT              NULL,
    [IdLiquidacao]                 UNIQUEIDENTIFIER NULL,
    [NumeroLiquidacao]             INT              NULL,
    [IdContaMCASP]                 UNIQUEIDENTIFIER NULL,
    [DataPrimeiraDepreciacao]      DATETIME         NULL,
    [DataUltimaDepreciacao]        DATETIME         NULL,
    [ValorAcumuladoDepreciacao]    MONEY            DEFAULT ((0)) NOT NULL,
    [E_Biblioteca]                 INT              CONSTRAINT [DF_ItensMoveis_E_Biblioteca] DEFAULT ((0)) NULL,
    [Data_Edicao]                  DATETIME         NULL,
    [Autor_da_Obra]                VARCHAR (50)     NULL,
    [Nome_da_Obra]                 VARCHAR (50)     NULL,
    [QtdMesesDepreciacaoAcumulada] INT              DEFAULT ((0)) NULL,
    [E_Doacao]                     BIT              DEFAULT ((0)) NOT NULL,
    [IdContaVPAMCASP]              UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_ItensMoveis] PRIMARY KEY NONCLUSTERED ([IdItem] ASC),
    CONSTRAINT [FK_ItensMoveis_Comissoes] FOREIGN KEY ([IdComissao]) REFERENCES [dbo].[Comissoes] ([IdComissao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_FormasAquisicao] FOREIGN KEY ([IdFormaAquisicao]) REFERENCES [dbo].[FormasAquisicao] ([IdFormaAquisicao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_FormasBaixa] FOREIGN KEY ([IdFormaBaixa]) REFERENCES [dbo].[FormasBaixa] ([IdFormaBaixa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_LocaisEntrega] FOREIGN KEY ([IdLocalEntrega]) REFERENCES [dbo].[LocaisEntrega] ([IdLocalEntrega]),
    CONSTRAINT [FK_ItensMoveis_MedidasGarantia] FOREIGN KEY ([IdMedidaDuracaoGarantia]) REFERENCES [dbo].[MedidasGarantia] ([IdMedidaDuracaoGarantia]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_MoedasSG] FOREIGN KEY ([IdMoedaSG]) REFERENCES [dbo].[MoedasSG] ([IdMoedaSG]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_MovimentacoesBens] FOREIGN KEY ([IdMovimentacaoBem]) REFERENCES [dbo].[MovimentacoesBens] ([IdMovimentacaoBem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_Reavaliacoes] FOREIGN KEY ([IdValorAtual]) REFERENCES [dbo].[Reavaliacoes] ([IdValorAtual]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_Responsaveis] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_TiposBens] FOREIGN KEY ([IdTipo]) REFERENCES [dbo].[TiposBens] ([IdTipo]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensMoveis_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[ItensMoveis] NOCHECK CONSTRAINT [FK_ItensMoveis_Comissoes];


GO
ALTER TABLE [dbo].[ItensMoveis] NOCHECK CONSTRAINT [FK_ItensMoveis_Pessoas];


GO
CREATE NONCLUSTERED INDEX [IX_ItensMoveis_IdConta]
    ON [dbo].[ItensMoveis]([IdConta] ASC);


GO
CREATE STATISTICS [STAT_ItensMoveis_AnoEmpenho_IdConta]
    ON [dbo].[ItensMoveis]([AnoEmpenho], [IdConta]);


GO
CREATE TRIGGER [TrgLog_ItensMoveis] ON [Implanta_CRPAM].[dbo].[ItensMoveis] 
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
SET @TableName = 'ItensMoveis'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoItem : «' + RTRIM( ISNULL( CAST (CodigoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarra : «' + RTRIM( ISNULL( CAST (CodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipo : «' + RTRIM( ISNULL( CAST (IdTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtual : «' + RTRIM( ISNULL( CAST (IdValorAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaAquisicao : «' + RTRIM( ISNULL( CAST (IdFormaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaDuracaoGarantia : «' + RTRIM( ISNULL( CAST (IdMedidaDuracaoGarantia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Marca : «' + RTRIM( ISNULL( CAST (Marca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modelo : «' + RTRIM( ISNULL( CAST (Modelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSerie : «' + RTRIM( ISNULL( CAST (NumeroSerie AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAquisicao : «' + RTRIM( ISNULL( CAST (ValorAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAquisicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAquisicao, 113 ),'Nulo'))+'» '
                         + '| DuracaoGarantia : «' + RTRIM( ISNULL( CAST (DuracaoGarantia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimGarantia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimGarantia, 113 ),'Nulo'))+'» '
                         + '| DataBaixa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBaixa, 113 ),'Nulo'))+'» '
                         + '| ValorBaixa : «' + RTRIM( ISNULL( CAST (ValorBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcessoBaixa : «' + RTRIM( ISNULL( CAST (NumeroProcessoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaModificacao, 113 ),'Nulo'))+'» '
                         + '| CodigoItemAnterior : «' + RTRIM( ISNULL( CAST (CodigoItemAnterior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicao : «' + RTRIM( ISNULL( CAST (IdContaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacao : «' + RTRIM( ISNULL( CAST (IdContaAlienacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacao : «' + RTRIM( ISNULL( CAST (IdContaReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentValResidualBM : «' + RTRIM( ISNULL( CAST (PercentValResidualBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilBM : «' + RTRIM( ISNULL( CAST (VidaUtilBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLiquidacao : «' + RTRIM( ISNULL( CAST (NumeroLiquidacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| E_Biblioteca : «' + RTRIM( ISNULL( CAST (E_Biblioteca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data_Edicao : «' + RTRIM( ISNULL( CONVERT (CHAR, Data_Edicao, 113 ),'Nulo'))+'» '
                         + '| Autor_da_Obra : «' + RTRIM( ISNULL( CAST (Autor_da_Obra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome_da_Obra : «' + RTRIM( ISNULL( CAST (Nome_da_Obra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesDepreciacaoAcumulada : «' + RTRIM( ISNULL( CAST (QtdMesesDepreciacaoAcumulada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Doacao IS NULL THEN ' E_Doacao : «Nulo» '
                                              WHEN  E_Doacao = 0 THEN ' E_Doacao : «Falso» '
                                              WHEN  E_Doacao = 1 THEN ' E_Doacao : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoItem : «' + RTRIM( ISNULL( CAST (CodigoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBarra : «' + RTRIM( ISNULL( CAST (CodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipo : «' + RTRIM( ISNULL( CAST (IdTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtual : «' + RTRIM( ISNULL( CAST (IdValorAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaAquisicao : «' + RTRIM( ISNULL( CAST (IdFormaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaDuracaoGarantia : «' + RTRIM( ISNULL( CAST (IdMedidaDuracaoGarantia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Marca : «' + RTRIM( ISNULL( CAST (Marca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modelo : «' + RTRIM( ISNULL( CAST (Modelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSerie : «' + RTRIM( ISNULL( CAST (NumeroSerie AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAquisicao : «' + RTRIM( ISNULL( CAST (ValorAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAquisicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAquisicao, 113 ),'Nulo'))+'» '
                         + '| DuracaoGarantia : «' + RTRIM( ISNULL( CAST (DuracaoGarantia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimGarantia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimGarantia, 113 ),'Nulo'))+'» '
                         + '| DataBaixa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBaixa, 113 ),'Nulo'))+'» '
                         + '| ValorBaixa : «' + RTRIM( ISNULL( CAST (ValorBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcessoBaixa : «' + RTRIM( ISNULL( CAST (NumeroProcessoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaModificacao, 113 ),'Nulo'))+'» '
                         + '| CodigoItemAnterior : «' + RTRIM( ISNULL( CAST (CodigoItemAnterior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicao : «' + RTRIM( ISNULL( CAST (IdContaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacao : «' + RTRIM( ISNULL( CAST (IdContaAlienacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacao : «' + RTRIM( ISNULL( CAST (IdContaReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentValResidualBM : «' + RTRIM( ISNULL( CAST (PercentValResidualBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilBM : «' + RTRIM( ISNULL( CAST (VidaUtilBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLiquidacao : «' + RTRIM( ISNULL( CAST (NumeroLiquidacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| E_Biblioteca : «' + RTRIM( ISNULL( CAST (E_Biblioteca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data_Edicao : «' + RTRIM( ISNULL( CONVERT (CHAR, Data_Edicao, 113 ),'Nulo'))+'» '
                         + '| Autor_da_Obra : «' + RTRIM( ISNULL( CAST (Autor_da_Obra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome_da_Obra : «' + RTRIM( ISNULL( CAST (Nome_da_Obra AS VARCHAR(3500)),'Nulo'))+'» '
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
                         + '| CodigoBarra : «' + RTRIM( ISNULL( CAST (CodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipo : «' + RTRIM( ISNULL( CAST (IdTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtual : «' + RTRIM( ISNULL( CAST (IdValorAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaAquisicao : «' + RTRIM( ISNULL( CAST (IdFormaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaDuracaoGarantia : «' + RTRIM( ISNULL( CAST (IdMedidaDuracaoGarantia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Marca : «' + RTRIM( ISNULL( CAST (Marca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modelo : «' + RTRIM( ISNULL( CAST (Modelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSerie : «' + RTRIM( ISNULL( CAST (NumeroSerie AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAquisicao : «' + RTRIM( ISNULL( CAST (ValorAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAquisicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAquisicao, 113 ),'Nulo'))+'» '
                         + '| DuracaoGarantia : «' + RTRIM( ISNULL( CAST (DuracaoGarantia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimGarantia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimGarantia, 113 ),'Nulo'))+'» '
                         + '| DataBaixa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBaixa, 113 ),'Nulo'))+'» '
                         + '| ValorBaixa : «' + RTRIM( ISNULL( CAST (ValorBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcessoBaixa : «' + RTRIM( ISNULL( CAST (NumeroProcessoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaModificacao, 113 ),'Nulo'))+'» '
                         + '| CodigoItemAnterior : «' + RTRIM( ISNULL( CAST (CodigoItemAnterior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicao : «' + RTRIM( ISNULL( CAST (IdContaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacao : «' + RTRIM( ISNULL( CAST (IdContaAlienacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacao : «' + RTRIM( ISNULL( CAST (IdContaReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentValResidualBM : «' + RTRIM( ISNULL( CAST (PercentValResidualBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilBM : «' + RTRIM( ISNULL( CAST (VidaUtilBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLiquidacao : «' + RTRIM( ISNULL( CAST (NumeroLiquidacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| E_Biblioteca : «' + RTRIM( ISNULL( CAST (E_Biblioteca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data_Edicao : «' + RTRIM( ISNULL( CONVERT (CHAR, Data_Edicao, 113 ),'Nulo'))+'» '
                         + '| Autor_da_Obra : «' + RTRIM( ISNULL( CAST (Autor_da_Obra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome_da_Obra : «' + RTRIM( ISNULL( CAST (Nome_da_Obra AS VARCHAR(3500)),'Nulo'))+'» '
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
                         + '| CodigoBarra : «' + RTRIM( ISNULL( CAST (CodigoBarra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipo : «' + RTRIM( ISNULL( CAST (IdTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtual : «' + RTRIM( ISNULL( CAST (IdValorAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaAquisicao : «' + RTRIM( ISNULL( CAST (IdFormaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaDuracaoGarantia : «' + RTRIM( ISNULL( CAST (IdMedidaDuracaoGarantia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Marca : «' + RTRIM( ISNULL( CAST (Marca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modelo : «' + RTRIM( ISNULL( CAST (Modelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroSerie : «' + RTRIM( ISNULL( CAST (NumeroSerie AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAquisicao : «' + RTRIM( ISNULL( CAST (ValorAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAquisicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAquisicao, 113 ),'Nulo'))+'» '
                         + '| DuracaoGarantia : «' + RTRIM( ISNULL( CAST (DuracaoGarantia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimGarantia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimGarantia, 113 ),'Nulo'))+'» '
                         + '| DataBaixa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBaixa, 113 ),'Nulo'))+'» '
                         + '| ValorBaixa : «' + RTRIM( ISNULL( CAST (ValorBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcessoBaixa : «' + RTRIM( ISNULL( CAST (NumeroProcessoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaModificacao, 113 ),'Nulo'))+'» '
                         + '| CodigoItemAnterior : «' + RTRIM( ISNULL( CAST (CodigoItemAnterior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAquisicao : «' + RTRIM( ISNULL( CAST (IdContaAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAlienacao : «' + RTRIM( ISNULL( CAST (IdContaAlienacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReavaliacao : «' + RTRIM( ISNULL( CAST (IdContaReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentValResidualBM : «' + RTRIM( ISNULL( CAST (PercentValResidualBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilBM : «' + RTRIM( ISNULL( CAST (VidaUtilBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLiquidacao : «' + RTRIM( ISNULL( CAST (NumeroLiquidacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| E_Biblioteca : «' + RTRIM( ISNULL( CAST (E_Biblioteca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data_Edicao : «' + RTRIM( ISNULL( CONVERT (CHAR, Data_Edicao, 113 ),'Nulo'))+'» '
                         + '| Autor_da_Obra : «' + RTRIM( ISNULL( CAST (Autor_da_Obra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome_da_Obra : «' + RTRIM( ISNULL( CAST (Nome_da_Obra AS VARCHAR(3500)),'Nulo'))+'» '
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
