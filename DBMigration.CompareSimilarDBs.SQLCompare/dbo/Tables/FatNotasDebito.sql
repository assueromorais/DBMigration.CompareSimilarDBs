CREATE TABLE [dbo].[FatNotasDebito] (
    [IdNotaDebito]                    INT            IDENTITY (1, 1) NOT NULL,
    [IdUnidade]                       INT            NOT NULL,
    [IdSituacaoNotaDebito]            INT            NOT NULL,
    [NumeroNotaDebito]                VARCHAR (20)   NOT NULL,
    [DataEmissao]                     DATETIME       NULL,
    [DataVencimento]                  DATETIME       NULL,
    [ValorTotalNota]                  MONEY          NULL,
    [HistoricoSolicitacao]            VARCHAR (6000) NULL,
    [IdUsuarioEmissao]                INT            NULL,
    [DataPagamento]                   DATETIME       NULL,
    [ValorPago]                       MONEY          NULL,
    [DataCancelamento]                DATETIME       NULL,
    [IdUsuarioCancelamento]           INT            NULL,
    [MotivoCancelamento]              VARCHAR (2000) NULL,
    [IdLancamentoPatrimonial_Emissao] INT            NULL,
    [IdReceita]                       INT            NULL,
    [IdNotaDebito_Lancamentos]        INT            NULL,
    CONSTRAINT [PK_FatNotasDebito] PRIMARY KEY CLUSTERED ([IdNotaDebito] ASC),
    CONSTRAINT [FK_FatNotasDebito_FatNotasDebitoLancamentos] FOREIGN KEY ([IdNotaDebito_Lancamentos]) REFERENCES [dbo].[FatNotasDebitoLancamentos] ([IdNotaDebito_Lancamentos]),
    CONSTRAINT [FK_FatNotasDebito_FatSituacoesNotaDebito] FOREIGN KEY ([IdSituacaoNotaDebito]) REFERENCES [dbo].[FatSituacoesNotaDebito] ([IdSituacaoNotaDebito]),
    CONSTRAINT [FK_FatNotasDebito_Lancamentos] FOREIGN KEY ([IdLancamentoPatrimonial_Emissao]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_FatNotasDebito_Receitas] FOREIGN KEY ([IdReceita]) REFERENCES [dbo].[Receitas] ([IdReceita]),
    CONSTRAINT [FK_FatNotasDebito_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade]),
    CONSTRAINT [FK_FatNotasDebito_Usuarios] FOREIGN KEY ([IdUsuarioCancelamento]) REFERENCES [dbo].[Usuarios] ([IdUsuario]),
    CONSTRAINT [FK_FatNotasDebitoEmissao_Usuarios] FOREIGN KEY ([IdUsuarioEmissao]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
CREATE TRIGGER [TrgLog_FatNotasDebito] ON [Implanta_CRPAM].[dbo].[FatNotasDebito] 
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
SET @TableName = 'FatNotasDebito'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoNotaDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroNotaDebito : «' + RTRIM( ISNULL( CAST (NumeroNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorTotalNota : «' + RTRIM( ISNULL( CAST (ValorTotalNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HistoricoSolicitacao : «' + RTRIM( ISNULL( CAST (HistoricoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioEmissao : «' + RTRIM( ISNULL( CAST (IdUsuarioEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCancelamento : «' + RTRIM( ISNULL( CAST (IdUsuarioCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoCancelamento : «' + RTRIM( ISNULL( CAST (MotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoPatrimonial_Emissao : «' + RTRIM( ISNULL( CAST (IdLancamentoPatrimonial_Emissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNotaDebito_Lancamentos : «' + RTRIM( ISNULL( CAST (IdNotaDebito_Lancamentos AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoNotaDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroNotaDebito : «' + RTRIM( ISNULL( CAST (NumeroNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorTotalNota : «' + RTRIM( ISNULL( CAST (ValorTotalNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HistoricoSolicitacao : «' + RTRIM( ISNULL( CAST (HistoricoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioEmissao : «' + RTRIM( ISNULL( CAST (IdUsuarioEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCancelamento : «' + RTRIM( ISNULL( CAST (IdUsuarioCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoCancelamento : «' + RTRIM( ISNULL( CAST (MotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoPatrimonial_Emissao : «' + RTRIM( ISNULL( CAST (IdLancamentoPatrimonial_Emissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNotaDebito_Lancamentos : «' + RTRIM( ISNULL( CAST (IdNotaDebito_Lancamentos AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoNotaDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroNotaDebito : «' + RTRIM( ISNULL( CAST (NumeroNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorTotalNota : «' + RTRIM( ISNULL( CAST (ValorTotalNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HistoricoSolicitacao : «' + RTRIM( ISNULL( CAST (HistoricoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioEmissao : «' + RTRIM( ISNULL( CAST (IdUsuarioEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCancelamento : «' + RTRIM( ISNULL( CAST (IdUsuarioCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoCancelamento : «' + RTRIM( ISNULL( CAST (MotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoPatrimonial_Emissao : «' + RTRIM( ISNULL( CAST (IdLancamentoPatrimonial_Emissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNotaDebito_Lancamentos : «' + RTRIM( ISNULL( CAST (IdNotaDebito_Lancamentos AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoNotaDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroNotaDebito : «' + RTRIM( ISNULL( CAST (NumeroNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorTotalNota : «' + RTRIM( ISNULL( CAST (ValorTotalNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HistoricoSolicitacao : «' + RTRIM( ISNULL( CAST (HistoricoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioEmissao : «' + RTRIM( ISNULL( CAST (IdUsuarioEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCancelamento : «' + RTRIM( ISNULL( CAST (IdUsuarioCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoCancelamento : «' + RTRIM( ISNULL( CAST (MotivoCancelamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoPatrimonial_Emissao : «' + RTRIM( ISNULL( CAST (IdLancamentoPatrimonial_Emissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNotaDebito_Lancamentos : «' + RTRIM( ISNULL( CAST (IdNotaDebito_Lancamentos AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
