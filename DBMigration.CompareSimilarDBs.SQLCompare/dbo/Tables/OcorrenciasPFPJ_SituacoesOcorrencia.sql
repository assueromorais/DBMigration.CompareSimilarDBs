CREATE TABLE [dbo].[OcorrenciasPFPJ_SituacoesOcorrencia] (
    [IdOcorrenciaPFPJ]                      INT          NOT NULL,
    [IdSituacaoOcorrencia]                  INT          NOT NULL,
    [DataRegistroSituacao]                  DATETIME     NULL,
    [DataSituacao]                          DATETIME     NULL,
    [Observacoes]                           TEXT         NULL,
    [IdOcorrenciasPFPJ_SituacoesOcorrencia] INT          IDENTITY (1, 1) NOT NULL,
    [UsuarioUltimaAtualizacao]              VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao]         VARCHAR (60) NULL,
    CONSTRAINT [FK_OcorrenciasPFPJ_SituacoesOcorrencia_OcorrenciasPFPJ] FOREIGN KEY ([IdOcorrenciaPFPJ]) REFERENCES [dbo].[OcorrenciasPFPJ] ([IdOcorrenciaPFPJ]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OcorrenciasPFPJ_SituacoesOcorrencia_SituacoesOcorrencia] FOREIGN KEY ([IdSituacaoOcorrencia]) REFERENCES [dbo].[SituacoesOcorrencia] ([IdSituacaoOcorrencia])
);


GO
CREATE TRIGGER [TrgLog_OcorrenciasPFPJ_SituacoesOcorrencia] ON [Implanta_CRPAM].[dbo].[OcorrenciasPFPJ_SituacoesOcorrencia] 
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
SET @TableName = 'OcorrenciasPFPJ_SituacoesOcorrencia'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOcorrenciaPFPJ : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRegistroSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistroSituacao, 113 ),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| IdOcorrenciasPFPJ_SituacoesOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrenciasPFPJ_SituacoesOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdOcorrenciaPFPJ : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRegistroSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistroSituacao, 113 ),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| IdOcorrenciasPFPJ_SituacoesOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrenciasPFPJ_SituacoesOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdOcorrenciaPFPJ : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRegistroSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistroSituacao, 113 ),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| IdOcorrenciasPFPJ_SituacoesOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrenciasPFPJ_SituacoesOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOcorrenciaPFPJ : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRegistroSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistroSituacao, 113 ),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| IdOcorrenciasPFPJ_SituacoesOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrenciasPFPJ_SituacoesOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
