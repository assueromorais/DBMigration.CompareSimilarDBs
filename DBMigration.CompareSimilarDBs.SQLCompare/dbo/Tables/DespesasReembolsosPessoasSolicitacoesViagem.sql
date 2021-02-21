CREATE TABLE [dbo].[DespesasReembolsosPessoasSolicitacoesViagem] (
    [IdDespesaPessoaSolicitacaoViagem] INT        IDENTITY (1, 1) NOT NULL,
    [IdPessoaSolicitacaoViagem]        INT        NOT NULL,
    [IdTipoDespesa]                    INT        NOT NULL,
    [QtdDespesa]                       FLOAT (53) NULL,
    [ValorDespesa]                     MONEY      NOT NULL,
    [ValorAPagar]                      MONEY      NULL,
    [ValorPago]                        MONEY      NULL,
    [ValorGasto]                       MONEY      CONSTRAINT [DF_DespesasReembolsosPessoasSolicitacoesViagem_ValorGasto] DEFAULT ((0)) NULL,
    [DiferencaPrestacaoContas]         MONEY      NULL,
    [PrestarContaDespesa]              BIT        CONSTRAINT [DF_DespesasReembolsosPessoasSolicitacoesViagem_PrestarContaDespesa] DEFAULT ((0)) NULL,
    [IdSituacaoDespesa]                INT        NOT NULL,
    [Origem]                           CHAR (1)   NULL,
    [IdTrechoPessoaSolicitacaoViagem]  INT        NULL,
    [Observacoes]                      TEXT       NULL,
    [DataRecusa]                       DATETIME   NULL,
    [DataInicial]                      DATETIME   NULL,
    [DataFinal]                        DATETIME   NULL,
    CONSTRAINT [PK_DespesasReembolsosPessoasSolicitacoesViagem] PRIMARY KEY CLUSTERED ([IdDespesaPessoaSolicitacaoViagem] ASC),
    CONSTRAINT [FK_DespesasReembolsosPessoasSolicitacoesViagem_PessoasSolicitacoesViagem] FOREIGN KEY ([IdPessoaSolicitacaoViagem]) REFERENCES [dbo].[PessoasSolicitacoesViagem] ([IdPessoaSolicitacaoViagem]),
    CONSTRAINT [FK_DespesasReembolsosPessoasSolicitacoesViagem_TiposDespesas] FOREIGN KEY ([IdTipoDespesa]) REFERENCES [dbo].[TiposDespesas] ([IdTipoDespesa])
);


GO
CREATE TRIGGER [TrgLog_DespesasReembolsosPessoasSolicitacoesViagem] ON [Implanta_CRPAM].[dbo].[DespesasReembolsosPessoasSolicitacoesViagem] 
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
SET @TableName = 'DespesasReembolsosPessoasSolicitacoesViagem'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDespesa : «' + RTRIM( ISNULL( CAST (QtdDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAPagar : «' + RTRIM( ISNULL( CAST (ValorAPagar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorGasto : «' + RTRIM( ISNULL( CAST (ValorGasto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiferencaPrestacaoContas : «' + RTRIM( ISNULL( CAST (DiferencaPrestacaoContas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PrestarContaDespesa IS NULL THEN ' PrestarContaDespesa : «Nulo» '
                                              WHEN  PrestarContaDespesa = 0 THEN ' PrestarContaDespesa : «Falso» '
                                              WHEN  PrestarContaDespesa = 1 THEN ' PrestarContaDespesa : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoDespesa : «' + RTRIM( ISNULL( CAST (IdSituacaoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTrechoPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdTrechoPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecusa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecusa, 113 ),'Nulo'))+'» '
                         + '| DataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicial, 113 ),'Nulo'))+'» '
                         + '| DataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFinal, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDespesa : «' + RTRIM( ISNULL( CAST (QtdDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAPagar : «' + RTRIM( ISNULL( CAST (ValorAPagar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorGasto : «' + RTRIM( ISNULL( CAST (ValorGasto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiferencaPrestacaoContas : «' + RTRIM( ISNULL( CAST (DiferencaPrestacaoContas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PrestarContaDespesa IS NULL THEN ' PrestarContaDespesa : «Nulo» '
                                              WHEN  PrestarContaDespesa = 0 THEN ' PrestarContaDespesa : «Falso» '
                                              WHEN  PrestarContaDespesa = 1 THEN ' PrestarContaDespesa : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoDespesa : «' + RTRIM( ISNULL( CAST (IdSituacaoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTrechoPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdTrechoPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecusa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecusa, 113 ),'Nulo'))+'» '
                         + '| DataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicial, 113 ),'Nulo'))+'» '
                         + '| DataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFinal, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDespesa : «' + RTRIM( ISNULL( CAST (QtdDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAPagar : «' + RTRIM( ISNULL( CAST (ValorAPagar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorGasto : «' + RTRIM( ISNULL( CAST (ValorGasto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiferencaPrestacaoContas : «' + RTRIM( ISNULL( CAST (DiferencaPrestacaoContas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PrestarContaDespesa IS NULL THEN ' PrestarContaDespesa : «Nulo» '
                                              WHEN  PrestarContaDespesa = 0 THEN ' PrestarContaDespesa : «Falso» '
                                              WHEN  PrestarContaDespesa = 1 THEN ' PrestarContaDespesa : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoDespesa : «' + RTRIM( ISNULL( CAST (IdSituacaoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTrechoPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdTrechoPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecusa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecusa, 113 ),'Nulo'))+'» '
                         + '| DataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicial, 113 ),'Nulo'))+'» '
                         + '| DataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFinal, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDespesa : «' + RTRIM( ISNULL( CAST (IdTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDespesa : «' + RTRIM( ISNULL( CAST (QtdDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAPagar : «' + RTRIM( ISNULL( CAST (ValorAPagar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorGasto : «' + RTRIM( ISNULL( CAST (ValorGasto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiferencaPrestacaoContas : «' + RTRIM( ISNULL( CAST (DiferencaPrestacaoContas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PrestarContaDespesa IS NULL THEN ' PrestarContaDespesa : «Nulo» '
                                              WHEN  PrestarContaDespesa = 0 THEN ' PrestarContaDespesa : «Falso» '
                                              WHEN  PrestarContaDespesa = 1 THEN ' PrestarContaDespesa : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoDespesa : «' + RTRIM( ISNULL( CAST (IdSituacaoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTrechoPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdTrechoPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecusa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecusa, 113 ),'Nulo'))+'» '
                         + '| DataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicial, 113 ),'Nulo'))+'» '
                         + '| DataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFinal, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
