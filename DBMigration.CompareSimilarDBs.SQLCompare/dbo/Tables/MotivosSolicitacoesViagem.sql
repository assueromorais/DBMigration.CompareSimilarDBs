CREATE TABLE [dbo].[MotivosSolicitacoesViagem] (
    [IdMotivoSolicitacaoViagem] INT   IDENTITY (1, 1) NOT NULL,
    [IdPessoaSolicitacaoViagem] INT   NOT NULL,
    [IdMotivoSolicitacao]       INT   NOT NULL,
    [AtividadeConcluida]        BIT   CONSTRAINT [DF_MotivoSolicitacoesViagem_AtividadeConcluida] DEFAULT ((0)) NOT NULL,
    [AvaliacaoAtividade]        INT   CONSTRAINT [DF_MotivoSolicitacoesViagem_AvaliacaoAtividade] DEFAULT ((0)) NOT NULL,
    [Observacoes]               NTEXT NULL,
    [Justificativa]             NTEXT NULL,
    CONSTRAINT [PK_MotivoSolicitacoesViagem] PRIMARY KEY CLUSTERED ([IdMotivoSolicitacaoViagem] ASC),
    CONSTRAINT [FK_MotivoSolicitacoesViagem_PessoasSolicitacoesViagem] FOREIGN KEY ([IdPessoaSolicitacaoViagem]) REFERENCES [dbo].[PessoasSolicitacoesViagem] ([IdPessoaSolicitacaoViagem]),
    CONSTRAINT [FK_MotivosSolicitacoesViagem_MotivosSolicitacoes] FOREIGN KEY ([IdMotivoSolicitacao]) REFERENCES [dbo].[MotivosSolicitacoes] ([IdMotivoSolicitacao])
);


GO
CREATE TRIGGER [TrgLog_MotivosSolicitacoesViagem] ON [Implanta_CRPAM].[dbo].[MotivosSolicitacoesViagem] 
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
SET @TableName = 'MotivosSolicitacoesViagem'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMotivoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdMotivoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoSolicitacao : «' + RTRIM( ISNULL( CAST (IdMotivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtividadeConcluida IS NULL THEN ' AtividadeConcluida : «Nulo» '
                                              WHEN  AtividadeConcluida = 0 THEN ' AtividadeConcluida : «Falso» '
                                              WHEN  AtividadeConcluida = 1 THEN ' AtividadeConcluida : «Verdadeiro» '
                                    END 
                         + '| AvaliacaoAtividade : «' + RTRIM( ISNULL( CAST (AvaliacaoAtividade AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMotivoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdMotivoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoSolicitacao : «' + RTRIM( ISNULL( CAST (IdMotivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtividadeConcluida IS NULL THEN ' AtividadeConcluida : «Nulo» '
                                              WHEN  AtividadeConcluida = 0 THEN ' AtividadeConcluida : «Falso» '
                                              WHEN  AtividadeConcluida = 1 THEN ' AtividadeConcluida : «Verdadeiro» '
                                    END 
                         + '| AvaliacaoAtividade : «' + RTRIM( ISNULL( CAST (AvaliacaoAtividade AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMotivoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdMotivoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoSolicitacao : «' + RTRIM( ISNULL( CAST (IdMotivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtividadeConcluida IS NULL THEN ' AtividadeConcluida : «Nulo» '
                                              WHEN  AtividadeConcluida = 0 THEN ' AtividadeConcluida : «Falso» '
                                              WHEN  AtividadeConcluida = 1 THEN ' AtividadeConcluida : «Verdadeiro» '
                                    END 
                         + '| AvaliacaoAtividade : «' + RTRIM( ISNULL( CAST (AvaliacaoAtividade AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMotivoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdMotivoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoSolicitacao : «' + RTRIM( ISNULL( CAST (IdMotivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtividadeConcluida IS NULL THEN ' AtividadeConcluida : «Nulo» '
                                              WHEN  AtividadeConcluida = 0 THEN ' AtividadeConcluida : «Falso» '
                                              WHEN  AtividadeConcluida = 1 THEN ' AtividadeConcluida : «Verdadeiro» '
                                    END 
                         + '| AvaliacaoAtividade : «' + RTRIM( ISNULL( CAST (AvaliacaoAtividade AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
