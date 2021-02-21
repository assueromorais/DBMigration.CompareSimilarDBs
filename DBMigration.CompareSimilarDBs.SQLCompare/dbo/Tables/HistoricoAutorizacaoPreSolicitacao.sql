CREATE TABLE [dbo].[HistoricoAutorizacaoPreSolicitacao] (
    [IdHistorico]          INT           IDENTITY (1, 1) NOT NULL,
    [IdPreSolicitacao]     INT           NOT NULL,
    [IdResponsavel]        INT           NULL,
    [IdUnidade]            INT           NULL,
    [IdNivelAutorizacao]   INT           NULL,
    [SequenciaAutorizacao] INT           NULL,
    [DataAlteracao]        DATETIME      NULL,
    [Concluido]            BIT           NULL,
    [Observacao]           VARCHAR (250) NULL,
    CONSTRAINT [PK_HistoricoAutorizacaoPreSolicitacao] PRIMARY KEY CLUSTERED ([IdHistorico] ASC),
    CONSTRAINT [FK_HistoricoAutorizacaoPreSolicitacao_NiveisAutorizacao] FOREIGN KEY ([IdNivelAutorizacao]) REFERENCES [dbo].[NiveisAutorizacao] ([IdNivelAutorizacao]),
    CONSTRAINT [FK_HistoricoAutorizacaoPreSolicitacao_PreSolicitacoes] FOREIGN KEY ([IdPreSolicitacao]) REFERENCES [dbo].[PreSolicitacoes] ([IdPreSolicitacao]),
    CONSTRAINT [FK_HistoricoAutorizacaoPreSolicitacao_Responsaveis] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_HistoricoAutorizacaoPreSolicitacao_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);


GO
CREATE TRIGGER [TrgLog_HistoricoAutorizacaoPreSolicitacao] ON [Implanta_CRPAM].[dbo].[HistoricoAutorizacaoPreSolicitacao] 
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
SET @TableName = 'HistoricoAutorizacaoPreSolicitacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistorico : «' + RTRIM( ISNULL( CAST (IdHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreSolicitacao : «' + RTRIM( ISNULL( CAST (IdPreSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaAutorizacao : «' + RTRIM( ISNULL( CAST (SequenciaAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlteracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Concluido IS NULL THEN ' Concluido : «Nulo» '
                                              WHEN  Concluido = 0 THEN ' Concluido : «Falso» '
                                              WHEN  Concluido = 1 THEN ' Concluido : «Verdadeiro» '
                                    END 
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistorico : «' + RTRIM( ISNULL( CAST (IdHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreSolicitacao : «' + RTRIM( ISNULL( CAST (IdPreSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaAutorizacao : «' + RTRIM( ISNULL( CAST (SequenciaAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlteracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Concluido IS NULL THEN ' Concluido : «Nulo» '
                                              WHEN  Concluido = 0 THEN ' Concluido : «Falso» '
                                              WHEN  Concluido = 1 THEN ' Concluido : «Verdadeiro» '
                                    END 
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistorico : «' + RTRIM( ISNULL( CAST (IdHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreSolicitacao : «' + RTRIM( ISNULL( CAST (IdPreSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaAutorizacao : «' + RTRIM( ISNULL( CAST (SequenciaAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlteracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Concluido IS NULL THEN ' Concluido : «Nulo» '
                                              WHEN  Concluido = 0 THEN ' Concluido : «Falso» '
                                              WHEN  Concluido = 1 THEN ' Concluido : «Verdadeiro» '
                                    END 
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistorico : «' + RTRIM( ISNULL( CAST (IdHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreSolicitacao : «' + RTRIM( ISNULL( CAST (IdPreSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaAutorizacao : «' + RTRIM( ISNULL( CAST (SequenciaAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlteracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlteracao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Concluido IS NULL THEN ' Concluido : «Nulo» '
                                              WHEN  Concluido = 0 THEN ' Concluido : «Falso» '
                                              WHEN  Concluido = 1 THEN ' Concluido : «Verdadeiro» '
                                    END 
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
