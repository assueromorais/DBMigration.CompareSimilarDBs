CREATE TABLE [dbo].[HistoricoSolicitacao] (
    [IdHistoricoSolicitacao]    INT             IDENTITY (1, 1) NOT NULL,
    [IdPessoaSolicitacaoViagem] INT             NOT NULL,
    [DataAlteracao]             DATETIME        NOT NULL,
    [IdPessoaSispad]            INT             NOT NULL,
    [IdNivelAutorizacao]        INT             NULL,
    [SequenciaAutorizacao]      INT             NULL,
    [IdCentroCusto]             INT             NULL,
    [IdSituacaoSolicitacao]     INT             NULL,
    [Concluido]                 BIT             NULL,
    [Observacao]                NVARCHAR (1000) NULL,
    CONSTRAINT [PK_HistoricoAutorizacao] PRIMARY KEY CLUSTERED ([IdHistoricoSolicitacao] ASC),
    CONSTRAINT [FK_HistoricoAutorizacao_CentroCusto] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_HistoricoAutorizacao_NiveisAutorizacao] FOREIGN KEY ([IdNivelAutorizacao]) REFERENCES [dbo].[NiveisAutorizacao] ([IdNivelAutorizacao]),
    CONSTRAINT [FK_HistoricoAutorizacao_PessoasSispad] FOREIGN KEY ([IdPessoaSispad]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad]),
    CONSTRAINT [FK_HistoricoAutorizacao_PessoasSolicitacoesViagem] FOREIGN KEY ([IdPessoaSolicitacaoViagem]) REFERENCES [dbo].[PessoasSolicitacoesViagem] ([IdPessoaSolicitacaoViagem])
);


GO
CREATE TRIGGER [TrgLog_HistoricoSolicitacao] ON [Implanta_CRPAM].[dbo].[HistoricoSolicitacao] 
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
SET @TableName = 'HistoricoSolicitacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistoricoSolicitacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlteracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracao, 113 ),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaAutorizacao : «' + RTRIM( ISNULL( CAST (SequenciaAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Concluido IS NULL THEN ' Concluido : «Nulo» '
                                              WHEN  Concluido = 0 THEN ' Concluido : «Falso» '
                                              WHEN  Concluido = 1 THEN ' Concluido : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdHistoricoSolicitacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlteracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracao, 113 ),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaAutorizacao : «' + RTRIM( ISNULL( CAST (SequenciaAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Concluido IS NULL THEN ' Concluido : «Nulo» '
                                              WHEN  Concluido = 0 THEN ' Concluido : «Falso» '
                                              WHEN  Concluido = 1 THEN ' Concluido : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdHistoricoSolicitacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlteracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracao, 113 ),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaAutorizacao : «' + RTRIM( ISNULL( CAST (SequenciaAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Concluido IS NULL THEN ' Concluido : «Nulo» '
                                              WHEN  Concluido = 0 THEN ' Concluido : «Falso» '
                                              WHEN  Concluido = 1 THEN ' Concluido : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistoricoSolicitacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlteracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracao, 113 ),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaAutorizacao : «' + RTRIM( ISNULL( CAST (SequenciaAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Concluido IS NULL THEN ' Concluido : «Nulo» '
                                              WHEN  Concluido = 0 THEN ' Concluido : «Falso» '
                                              WHEN  Concluido = 1 THEN ' Concluido : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
