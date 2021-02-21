CREATE TABLE [dbo].[Itens] (
    [IdItem]                    INT          IDENTITY (1, 1) NOT NULL,
    [CodigoItem]                VARCHAR (20) NOT NULL,
    [NomeItem]                  VARCHAR (60) NOT NULL,
    [IdMedidaPadrao]            INT          NOT NULL,
    [IdGrupoItem]               INT          NOT NULL,
    [Patrimonio]                BIT          NOT NULL,
    [EstoqueMinimo]             REAL         NOT NULL,
    [EstoqueMaximo]             REAL         NOT NULL,
    [IntervaloAquisicao]        TINYINT      NULL,
    [TempoAquisicao]            TINYINT      NULL,
    [PercentualEstoqueMinimo]   TINYINT      NULL,
    [ValorReferencia]           MONEY        NULL,
    [DataValorReferencia]       DATETIME     NULL,
    [Descricao]                 TEXT         NULL,
    [Ativo]                     BIT          NULL,
    [IdContrato]                INT          NULL,
    [IdPessoa]                  INT          NULL,
    [ItemEmModalidadeRegPreco]  BIT          NULL,
    [RegPrecoDataInicio]        DATETIME     NULL,
    [RegPrecoDataFim]           DATETIME     NULL,
    [RegPrecoValor]             MONEY        NULL,
    [RegPrecoQtdItensPrevistos] FLOAT (53)   NULL,
    [SemValorReferencia]        BIT          CONSTRAINT [DF__Itens__SemValorR__604C5F30] DEFAULT ((0)) NULL,
    [imagemItem]                IMAGE        NULL,
    [ItemFaturavel]             BIT          CONSTRAINT [DF_Itens_ItemFaturavel] DEFAULT ((0)) NOT NULL,
    [ValorVenda]                MONEY        NULL,
    [PontoReposicao]            REAL         NULL,
    CONSTRAINT [PK_Itens] PRIMARY KEY NONCLUSTERED ([IdItem] ASC),
    CONSTRAINT [FK_Itens_Contratos] FOREIGN KEY ([IdContrato]) REFERENCES [dbo].[Contratos] ([IdContrato]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Itens_GrupoItens] FOREIGN KEY ([IdGrupoItem]) REFERENCES [dbo].[GruposItens] ([IdGrupoItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Itens_Medidas] FOREIGN KEY ([IdMedidaPadrao]) REFERENCES [dbo].[Medidas] ([IdMedida]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Itens_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_Itens] ON [Implanta_CRPAM].[dbo].[Itens] 
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
SET @TableName = 'Itens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoItem : «' + RTRIM( ISNULL( CAST (CodigoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaPadrao : «' + RTRIM( ISNULL( CAST (IdMedidaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoItem : «' + RTRIM( ISNULL( CAST (IdGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Patrimonio IS NULL THEN ' Patrimonio : «Nulo» '
                                              WHEN  Patrimonio = 0 THEN ' Patrimonio : «Falso» '
                                              WHEN  Patrimonio = 1 THEN ' Patrimonio : «Verdadeiro» '
                                    END 
                         + '| EstoqueMinimo : «' + RTRIM( ISNULL( CAST (EstoqueMinimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstoqueMaximo : «' + RTRIM( ISNULL( CAST (EstoqueMaximo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntervaloAquisicao : «' + RTRIM( ISNULL( CAST (IntervaloAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAquisicao : «' + RTRIM( ISNULL( CAST (TempoAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualEstoqueMinimo : «' + RTRIM( ISNULL( CAST (PercentualEstoqueMinimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorReferencia : «' + RTRIM( ISNULL( CAST (ValorReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValorReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValorReferencia, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ItemEmModalidadeRegPreco IS NULL THEN ' ItemEmModalidadeRegPreco : «Nulo» '
                                              WHEN  ItemEmModalidadeRegPreco = 0 THEN ' ItemEmModalidadeRegPreco : «Falso» '
                                              WHEN  ItemEmModalidadeRegPreco = 1 THEN ' ItemEmModalidadeRegPreco : «Verdadeiro» '
                                    END 
                         + '| RegPrecoDataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, RegPrecoDataInicio, 113 ),'Nulo'))+'» '
                         + '| RegPrecoDataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, RegPrecoDataFim, 113 ),'Nulo'))+'» '
                         + '| RegPrecoValor : «' + RTRIM( ISNULL( CAST (RegPrecoValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegPrecoQtdItensPrevistos : «' + RTRIM( ISNULL( CAST (RegPrecoQtdItensPrevistos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SemValorReferencia IS NULL THEN ' SemValorReferencia : «Nulo» '
                                              WHEN  SemValorReferencia = 0 THEN ' SemValorReferencia : «Falso» '
                                              WHEN  SemValorReferencia = 1 THEN ' SemValorReferencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ItemFaturavel IS NULL THEN ' ItemFaturavel : «Nulo» '
                                              WHEN  ItemFaturavel = 0 THEN ' ItemFaturavel : «Falso» '
                                              WHEN  ItemFaturavel = 1 THEN ' ItemFaturavel : «Verdadeiro» '
                                    END 
                         + '| ValorVenda : «' + RTRIM( ISNULL( CAST (ValorVenda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PontoReposicao : «' + RTRIM( ISNULL( CAST (PontoReposicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoItem : «' + RTRIM( ISNULL( CAST (CodigoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaPadrao : «' + RTRIM( ISNULL( CAST (IdMedidaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoItem : «' + RTRIM( ISNULL( CAST (IdGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Patrimonio IS NULL THEN ' Patrimonio : «Nulo» '
                                              WHEN  Patrimonio = 0 THEN ' Patrimonio : «Falso» '
                                              WHEN  Patrimonio = 1 THEN ' Patrimonio : «Verdadeiro» '
                                    END 
                         + '| EstoqueMinimo : «' + RTRIM( ISNULL( CAST (EstoqueMinimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstoqueMaximo : «' + RTRIM( ISNULL( CAST (EstoqueMaximo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntervaloAquisicao : «' + RTRIM( ISNULL( CAST (IntervaloAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAquisicao : «' + RTRIM( ISNULL( CAST (TempoAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualEstoqueMinimo : «' + RTRIM( ISNULL( CAST (PercentualEstoqueMinimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorReferencia : «' + RTRIM( ISNULL( CAST (ValorReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValorReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValorReferencia, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ItemEmModalidadeRegPreco IS NULL THEN ' ItemEmModalidadeRegPreco : «Nulo» '
                                              WHEN  ItemEmModalidadeRegPreco = 0 THEN ' ItemEmModalidadeRegPreco : «Falso» '
                                              WHEN  ItemEmModalidadeRegPreco = 1 THEN ' ItemEmModalidadeRegPreco : «Verdadeiro» '
                                    END 
                         + '| RegPrecoDataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, RegPrecoDataInicio, 113 ),'Nulo'))+'» '
                         + '| RegPrecoDataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, RegPrecoDataFim, 113 ),'Nulo'))+'» '
                         + '| RegPrecoValor : «' + RTRIM( ISNULL( CAST (RegPrecoValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegPrecoQtdItensPrevistos : «' + RTRIM( ISNULL( CAST (RegPrecoQtdItensPrevistos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SemValorReferencia IS NULL THEN ' SemValorReferencia : «Nulo» '
                                              WHEN  SemValorReferencia = 0 THEN ' SemValorReferencia : «Falso» '
                                              WHEN  SemValorReferencia = 1 THEN ' SemValorReferencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ItemFaturavel IS NULL THEN ' ItemFaturavel : «Nulo» '
                                              WHEN  ItemFaturavel = 0 THEN ' ItemFaturavel : «Falso» '
                                              WHEN  ItemFaturavel = 1 THEN ' ItemFaturavel : «Verdadeiro» '
                                    END 
                         + '| ValorVenda : «' + RTRIM( ISNULL( CAST (ValorVenda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PontoReposicao : «' + RTRIM( ISNULL( CAST (PontoReposicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaPadrao : «' + RTRIM( ISNULL( CAST (IdMedidaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoItem : «' + RTRIM( ISNULL( CAST (IdGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Patrimonio IS NULL THEN ' Patrimonio : «Nulo» '
                                              WHEN  Patrimonio = 0 THEN ' Patrimonio : «Falso» '
                                              WHEN  Patrimonio = 1 THEN ' Patrimonio : «Verdadeiro» '
                                    END 
                         + '| EstoqueMinimo : «' + RTRIM( ISNULL( CAST (EstoqueMinimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstoqueMaximo : «' + RTRIM( ISNULL( CAST (EstoqueMaximo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntervaloAquisicao : «' + RTRIM( ISNULL( CAST (IntervaloAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAquisicao : «' + RTRIM( ISNULL( CAST (TempoAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualEstoqueMinimo : «' + RTRIM( ISNULL( CAST (PercentualEstoqueMinimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorReferencia : «' + RTRIM( ISNULL( CAST (ValorReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValorReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValorReferencia, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ItemEmModalidadeRegPreco IS NULL THEN ' ItemEmModalidadeRegPreco : «Nulo» '
                                              WHEN  ItemEmModalidadeRegPreco = 0 THEN ' ItemEmModalidadeRegPreco : «Falso» '
                                              WHEN  ItemEmModalidadeRegPreco = 1 THEN ' ItemEmModalidadeRegPreco : «Verdadeiro» '
                                    END 
                         + '| RegPrecoDataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, RegPrecoDataInicio, 113 ),'Nulo'))+'» '
                         + '| RegPrecoDataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, RegPrecoDataFim, 113 ),'Nulo'))+'» '
                         + '| RegPrecoValor : «' + RTRIM( ISNULL( CAST (RegPrecoValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegPrecoQtdItensPrevistos : «' + RTRIM( ISNULL( CAST (RegPrecoQtdItensPrevistos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SemValorReferencia IS NULL THEN ' SemValorReferencia : «Nulo» '
                                              WHEN  SemValorReferencia = 0 THEN ' SemValorReferencia : «Falso» '
                                              WHEN  SemValorReferencia = 1 THEN ' SemValorReferencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ItemFaturavel IS NULL THEN ' ItemFaturavel : «Nulo» '
                                              WHEN  ItemFaturavel = 0 THEN ' ItemFaturavel : «Falso» '
                                              WHEN  ItemFaturavel = 1 THEN ' ItemFaturavel : «Verdadeiro» '
                                    END 
                         + '| ValorVenda : «' + RTRIM( ISNULL( CAST (ValorVenda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PontoReposicao : «' + RTRIM( ISNULL( CAST (PontoReposicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoItem : «' + RTRIM( ISNULL( CAST (CodigoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeItem : «' + RTRIM( ISNULL( CAST (NomeItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaPadrao : «' + RTRIM( ISNULL( CAST (IdMedidaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoItem : «' + RTRIM( ISNULL( CAST (IdGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Patrimonio IS NULL THEN ' Patrimonio : «Nulo» '
                                              WHEN  Patrimonio = 0 THEN ' Patrimonio : «Falso» '
                                              WHEN  Patrimonio = 1 THEN ' Patrimonio : «Verdadeiro» '
                                    END 
                         + '| EstoqueMinimo : «' + RTRIM( ISNULL( CAST (EstoqueMinimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstoqueMaximo : «' + RTRIM( ISNULL( CAST (EstoqueMaximo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntervaloAquisicao : «' + RTRIM( ISNULL( CAST (IntervaloAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAquisicao : «' + RTRIM( ISNULL( CAST (TempoAquisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualEstoqueMinimo : «' + RTRIM( ISNULL( CAST (PercentualEstoqueMinimo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorReferencia : «' + RTRIM( ISNULL( CAST (ValorReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValorReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValorReferencia, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ItemEmModalidadeRegPreco IS NULL THEN ' ItemEmModalidadeRegPreco : «Nulo» '
                                              WHEN  ItemEmModalidadeRegPreco = 0 THEN ' ItemEmModalidadeRegPreco : «Falso» '
                                              WHEN  ItemEmModalidadeRegPreco = 1 THEN ' ItemEmModalidadeRegPreco : «Verdadeiro» '
                                    END 
                         + '| RegPrecoDataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, RegPrecoDataInicio, 113 ),'Nulo'))+'» '
                         + '| RegPrecoDataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, RegPrecoDataFim, 113 ),'Nulo'))+'» '
                         + '| RegPrecoValor : «' + RTRIM( ISNULL( CAST (RegPrecoValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegPrecoQtdItensPrevistos : «' + RTRIM( ISNULL( CAST (RegPrecoQtdItensPrevistos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SemValorReferencia IS NULL THEN ' SemValorReferencia : «Nulo» '
                                              WHEN  SemValorReferencia = 0 THEN ' SemValorReferencia : «Falso» '
                                              WHEN  SemValorReferencia = 1 THEN ' SemValorReferencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ItemFaturavel IS NULL THEN ' ItemFaturavel : «Nulo» '
                                              WHEN  ItemFaturavel = 0 THEN ' ItemFaturavel : «Falso» '
                                              WHEN  ItemFaturavel = 1 THEN ' ItemFaturavel : «Verdadeiro» '
                                    END 
                         + '| ValorVenda : «' + RTRIM( ISNULL( CAST (ValorVenda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PontoReposicao : «' + RTRIM( ISNULL( CAST (PontoReposicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
