CREATE TABLE [dbo].[DiariasIndenizacoes] (
    [IdDiariaIndenizacao]         INT            IDENTITY (1, 1) NOT NULL,
    [IdProcessoSolicitacaoViagem] INT            NOT NULL,
    [IdTipoDespesa]               INT            NOT NULL,
    [Quantidade]                  NUMERIC (3, 1) NULL,
    [ValorOriginal]               MONEY          NULL,
    [IdMoeda]                     INT            NOT NULL,
    [ValorPago]                   MONEY          NULL,
    [ValorEstornado]              MONEY          NULL,
    [ValorTotal]                  MONEY          NULL,
    [Cotacao]                     MONEY          NULL,
    [DataCotacao]                 DATETIME       NULL,
    [DataExtorno]                 DATETIME       NULL,
    [QuantidadeExtorno]           NUMERIC (3, 1) NULL,
    [ObservacaoExtorno]           VARCHAR (1000) NULL,
    [Conta]                       VARCHAR (50)   NULL,
    [ContaStr]                    VARCHAR (300)  NULL,
    [ContaCodigo]                 VARCHAR (100)  NULL,
    CONSTRAINT [PK_DiariasIndenizacoes] PRIMARY KEY CLUSTERED ([IdDiariaIndenizacao] ASC),
    CONSTRAINT [FK_DiariasIndenizacoes_Moedas] FOREIGN KEY ([IdMoeda]) REFERENCES [dbo].[Moedas] ([IdMoeda]),
    CONSTRAINT [FK_DiariasIndenizacoes_ProcessosSolicitacaoViagem] FOREIGN KEY ([IdProcessoSolicitacaoViagem]) REFERENCES [dbo].[ProcessosSolicitacaoViagem] ([IdProcessoSolicitacaoViagem]),
    CONSTRAINT [FK_DiariasIndenizacoes_TiposDespesas] FOREIGN KEY ([IdTipoDespesa]) REFERENCES [dbo].[TiposDespesas] ([IdTipoDespesa])
);


GO
CREATE TRIGGER [TrgLog_DiariasIndenizacoes] ON [Implanta_CRPAM].[dbo].[DiariasIndenizacoes] 
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
SET @TableName = 'DiariasIndenizacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDiariaIndenizacao : «' + RTRIM( ISNULL( CAST (IdDiariaIndenizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quantidade : «' + RTRIM( ISNULL( CAST (Quantidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorOriginal : «' + RTRIM( ISNULL( CAST (ValorOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstornado : «' + RTRIM( ISNULL( CAST (ValorEstornado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cotacao : «' + RTRIM( ISNULL( CAST (Cotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCotacao, 113 ),'Nulo'))+'» '
                         + '| DataExtorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExtorno, 113 ),'Nulo'))+'» '
                         + '| QuantidadeExtorno : «' + RTRIM( ISNULL( CAST (QuantidadeExtorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ObservacaoExtorno : «' + RTRIM( ISNULL( CAST (ObservacaoExtorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaStr : «' + RTRIM( ISNULL( CAST (ContaStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCodigo : «' + RTRIM( ISNULL( CAST (ContaCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDiariaIndenizacao : «' + RTRIM( ISNULL( CAST (IdDiariaIndenizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quantidade : «' + RTRIM( ISNULL( CAST (Quantidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorOriginal : «' + RTRIM( ISNULL( CAST (ValorOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstornado : «' + RTRIM( ISNULL( CAST (ValorEstornado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cotacao : «' + RTRIM( ISNULL( CAST (Cotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCotacao, 113 ),'Nulo'))+'» '
                         + '| DataExtorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExtorno, 113 ),'Nulo'))+'» '
                         + '| QuantidadeExtorno : «' + RTRIM( ISNULL( CAST (QuantidadeExtorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ObservacaoExtorno : «' + RTRIM( ISNULL( CAST (ObservacaoExtorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaStr : «' + RTRIM( ISNULL( CAST (ContaStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCodigo : «' + RTRIM( ISNULL( CAST (ContaCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDiariaIndenizacao : «' + RTRIM( ISNULL( CAST (IdDiariaIndenizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quantidade : «' + RTRIM( ISNULL( CAST (Quantidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorOriginal : «' + RTRIM( ISNULL( CAST (ValorOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstornado : «' + RTRIM( ISNULL( CAST (ValorEstornado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cotacao : «' + RTRIM( ISNULL( CAST (Cotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCotacao, 113 ),'Nulo'))+'» '
                         + '| DataExtorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExtorno, 113 ),'Nulo'))+'» '
                         + '| QuantidadeExtorno : «' + RTRIM( ISNULL( CAST (QuantidadeExtorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ObservacaoExtorno : «' + RTRIM( ISNULL( CAST (ObservacaoExtorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaStr : «' + RTRIM( ISNULL( CAST (ContaStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCodigo : «' + RTRIM( ISNULL( CAST (ContaCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDiariaIndenizacao : «' + RTRIM( ISNULL( CAST (IdDiariaIndenizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quantidade : «' + RTRIM( ISNULL( CAST (Quantidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorOriginal : «' + RTRIM( ISNULL( CAST (ValorOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstornado : «' + RTRIM( ISNULL( CAST (ValorEstornado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cotacao : «' + RTRIM( ISNULL( CAST (Cotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCotacao, 113 ),'Nulo'))+'» '
                         + '| DataExtorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExtorno, 113 ),'Nulo'))+'» '
                         + '| QuantidadeExtorno : «' + RTRIM( ISNULL( CAST (QuantidadeExtorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ObservacaoExtorno : «' + RTRIM( ISNULL( CAST (ObservacaoExtorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaStr : «' + RTRIM( ISNULL( CAST (ContaStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCodigo : «' + RTRIM( ISNULL( CAST (ContaCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
