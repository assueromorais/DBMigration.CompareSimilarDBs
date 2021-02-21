CREATE TABLE [dbo].[Contratos] (
    [IdContrato]              INT          IDENTITY (1, 1) NOT NULL,
    [IdContratoPrincipal]     INT          NULL,
    [IdTipoContrato]          INT          NOT NULL,
    [IdPessoa]                INT          NOT NULL,
    [IdIndice]                INT          NULL,
    [IdLicitacao]             INT          NULL,
    [IdResponsavel]           INT          NULL,
    [NumeroContrato]          VARCHAR (20) NOT NULL,
    [InicioVigencia]          DATETIME     NOT NULL,
    [FimVigencia]             DATETIME     NOT NULL,
    [DataRescisao]            DATETIME     NULL,
    [ValorTotal]              MONEY        NULL,
    [NumeroParcelas]          INT          NULL,
    [TermoReajuste]           VARCHAR (30) NULL,
    [NumeroProcesso]          VARCHAR (20) NULL,
    [Assunto]                 TEXT         NULL,
    [Observacao]              TEXT         NULL,
    [SaldoContrato]           MONEY        NULL,
    [SaldoInicialContrato]    MONEY        NULL,
    [TipoAditivoContrato]     INT          NULL,
    [LimiteAditivoContrato]   FLOAT (53)   NULL,
    [IdUnidade]               INT          NULL,
    [NumeroAditivo]           INT          NULL,
    [NumeroProtocolo]         VARCHAR (20) NULL,
    [TipoAditivoReducao]      INT          NULL,
    [TipoAditivoPrazo]        INT          NULL,
    [DataEmailAviso]          DATETIME     NULL,
    [TipoAditivoOutros]       INT          NULL,
    [ValorParcela]            FLOAT (53)   NULL,
    [IdResponsavelSubstituto] INT          NULL,
    [IdSituacaoContrato]      INT          NULL,
    [DataPublicacao]          DATETIME     NULL,
    [QuantidadeFuncionarios]  INT          NULL,
    [IdModalidadeContrato]    INT          NULL,
    CONSTRAINT [PK_Contratos] PRIMARY KEY CLUSTERED ([IdContrato] ASC),
    CONSTRAINT [FK_Contratos_Contratos] FOREIGN KEY ([IdContratoPrincipal]) REFERENCES [dbo].[Contratos] ([IdContrato]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Contratos_IdSituacaoContrato] FOREIGN KEY ([IdSituacaoContrato]) REFERENCES [dbo].[SituacoesContrato] ([IdSituacaoContrato]),
    CONSTRAINT [FK_Contratos_Licitacoes] FOREIGN KEY ([IdLicitacao]) REFERENCES [dbo].[Licitacoes] ([IdLicitacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Contratos_NomesIndices] FOREIGN KEY ([IdIndice]) REFERENCES [dbo].[NomesIndices] ([IdIndice]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Contratos_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Contratos_Responsaveis] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Contratos_TiposContratos] FOREIGN KEY ([IdTipoContrato]) REFERENCES [dbo].[TiposContratos] ([IdTipoContrato]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Contratos_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);


GO
ALTER TABLE [dbo].[Contratos] NOCHECK CONSTRAINT [FK_Contratos_Licitacoes];


GO
ALTER TABLE [dbo].[Contratos] NOCHECK CONSTRAINT [FK_Contratos_Responsaveis];


GO
CREATE TRIGGER [TrgLog_Contratos] ON [Implanta_CRPAM].[dbo].[Contratos] 
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
SET @TableName = 'Contratos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContratoPrincipal : «' + RTRIM( ISNULL( CAST (IdContratoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoContrato : «' + RTRIM( ISNULL( CAST (IdTipoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdIndice : «' + RTRIM( ISNULL( CAST (IdIndice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroContrato : «' + RTRIM( ISNULL( CAST (NumeroContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, InicioVigencia, 113 ),'Nulo'))+'» '
                         + '| FimVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimVigencia, 113 ),'Nulo'))+'» '
                         + '| DataRescisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRescisao, 113 ),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcelas : «' + RTRIM( ISNULL( CAST (NumeroParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TermoReajuste : «' + RTRIM( ISNULL( CAST (TermoReajuste AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoContrato : «' + RTRIM( ISNULL( CAST (SaldoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoInicialContrato : «' + RTRIM( ISNULL( CAST (SaldoInicialContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoContrato : «' + RTRIM( ISNULL( CAST (TipoAditivoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LimiteAditivoContrato : «' + RTRIM( ISNULL( CAST (LimiteAditivoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroAditivo : «' + RTRIM( ISNULL( CAST (NumeroAditivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoReducao : «' + RTRIM( ISNULL( CAST (TipoAditivoReducao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoPrazo : «' + RTRIM( ISNULL( CAST (TipoAditivoPrazo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmailAviso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmailAviso, 113 ),'Nulo'))+'» '
                         + '| TipoAditivoOutros : «' + RTRIM( ISNULL( CAST (TipoAditivoOutros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorParcela : «' + RTRIM( ISNULL( CAST (ValorParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelSubstituto : «' + RTRIM( ISNULL( CAST (IdResponsavelSubstituto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoContrato : «' + RTRIM( ISNULL( CAST (IdSituacaoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPublicacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPublicacao, 113 ),'Nulo'))+'» '
                         + '| QuantidadeFuncionarios : «' + RTRIM( ISNULL( CAST (QuantidadeFuncionarios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidadeContrato : «' + RTRIM( ISNULL( CAST (IdModalidadeContrato AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContratoPrincipal : «' + RTRIM( ISNULL( CAST (IdContratoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoContrato : «' + RTRIM( ISNULL( CAST (IdTipoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdIndice : «' + RTRIM( ISNULL( CAST (IdIndice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroContrato : «' + RTRIM( ISNULL( CAST (NumeroContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, InicioVigencia, 113 ),'Nulo'))+'» '
                         + '| FimVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimVigencia, 113 ),'Nulo'))+'» '
                         + '| DataRescisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRescisao, 113 ),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcelas : «' + RTRIM( ISNULL( CAST (NumeroParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TermoReajuste : «' + RTRIM( ISNULL( CAST (TermoReajuste AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoContrato : «' + RTRIM( ISNULL( CAST (SaldoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoInicialContrato : «' + RTRIM( ISNULL( CAST (SaldoInicialContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoContrato : «' + RTRIM( ISNULL( CAST (TipoAditivoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LimiteAditivoContrato : «' + RTRIM( ISNULL( CAST (LimiteAditivoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroAditivo : «' + RTRIM( ISNULL( CAST (NumeroAditivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoReducao : «' + RTRIM( ISNULL( CAST (TipoAditivoReducao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoPrazo : «' + RTRIM( ISNULL( CAST (TipoAditivoPrazo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmailAviso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmailAviso, 113 ),'Nulo'))+'» '
                         + '| TipoAditivoOutros : «' + RTRIM( ISNULL( CAST (TipoAditivoOutros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorParcela : «' + RTRIM( ISNULL( CAST (ValorParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelSubstituto : «' + RTRIM( ISNULL( CAST (IdResponsavelSubstituto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoContrato : «' + RTRIM( ISNULL( CAST (IdSituacaoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPublicacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPublicacao, 113 ),'Nulo'))+'» '
                         + '| QuantidadeFuncionarios : «' + RTRIM( ISNULL( CAST (QuantidadeFuncionarios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidadeContrato : «' + RTRIM( ISNULL( CAST (IdModalidadeContrato AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContratoPrincipal : «' + RTRIM( ISNULL( CAST (IdContratoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoContrato : «' + RTRIM( ISNULL( CAST (IdTipoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdIndice : «' + RTRIM( ISNULL( CAST (IdIndice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroContrato : «' + RTRIM( ISNULL( CAST (NumeroContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, InicioVigencia, 113 ),'Nulo'))+'» '
                         + '| FimVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimVigencia, 113 ),'Nulo'))+'» '
                         + '| DataRescisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRescisao, 113 ),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcelas : «' + RTRIM( ISNULL( CAST (NumeroParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TermoReajuste : «' + RTRIM( ISNULL( CAST (TermoReajuste AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoContrato : «' + RTRIM( ISNULL( CAST (SaldoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoInicialContrato : «' + RTRIM( ISNULL( CAST (SaldoInicialContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoContrato : «' + RTRIM( ISNULL( CAST (TipoAditivoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LimiteAditivoContrato : «' + RTRIM( ISNULL( CAST (LimiteAditivoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroAditivo : «' + RTRIM( ISNULL( CAST (NumeroAditivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoReducao : «' + RTRIM( ISNULL( CAST (TipoAditivoReducao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoPrazo : «' + RTRIM( ISNULL( CAST (TipoAditivoPrazo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmailAviso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmailAviso, 113 ),'Nulo'))+'» '
                         + '| TipoAditivoOutros : «' + RTRIM( ISNULL( CAST (TipoAditivoOutros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorParcela : «' + RTRIM( ISNULL( CAST (ValorParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelSubstituto : «' + RTRIM( ISNULL( CAST (IdResponsavelSubstituto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoContrato : «' + RTRIM( ISNULL( CAST (IdSituacaoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPublicacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPublicacao, 113 ),'Nulo'))+'» '
                         + '| QuantidadeFuncionarios : «' + RTRIM( ISNULL( CAST (QuantidadeFuncionarios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidadeContrato : «' + RTRIM( ISNULL( CAST (IdModalidadeContrato AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContratoPrincipal : «' + RTRIM( ISNULL( CAST (IdContratoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoContrato : «' + RTRIM( ISNULL( CAST (IdTipoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdIndice : «' + RTRIM( ISNULL( CAST (IdIndice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroContrato : «' + RTRIM( ISNULL( CAST (NumeroContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, InicioVigencia, 113 ),'Nulo'))+'» '
                         + '| FimVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimVigencia, 113 ),'Nulo'))+'» '
                         + '| DataRescisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRescisao, 113 ),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcelas : «' + RTRIM( ISNULL( CAST (NumeroParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TermoReajuste : «' + RTRIM( ISNULL( CAST (TermoReajuste AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoContrato : «' + RTRIM( ISNULL( CAST (SaldoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoInicialContrato : «' + RTRIM( ISNULL( CAST (SaldoInicialContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoContrato : «' + RTRIM( ISNULL( CAST (TipoAditivoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LimiteAditivoContrato : «' + RTRIM( ISNULL( CAST (LimiteAditivoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroAditivo : «' + RTRIM( ISNULL( CAST (NumeroAditivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoReducao : «' + RTRIM( ISNULL( CAST (TipoAditivoReducao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoAditivoPrazo : «' + RTRIM( ISNULL( CAST (TipoAditivoPrazo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmailAviso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmailAviso, 113 ),'Nulo'))+'» '
                         + '| TipoAditivoOutros : «' + RTRIM( ISNULL( CAST (TipoAditivoOutros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorParcela : «' + RTRIM( ISNULL( CAST (ValorParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelSubstituto : «' + RTRIM( ISNULL( CAST (IdResponsavelSubstituto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoContrato : «' + RTRIM( ISNULL( CAST (IdSituacaoContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPublicacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPublicacao, 113 ),'Nulo'))+'» '
                         + '| QuantidadeFuncionarios : «' + RTRIM( ISNULL( CAST (QuantidadeFuncionarios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidadeContrato : «' + RTRIM( ISNULL( CAST (IdModalidadeContrato AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
