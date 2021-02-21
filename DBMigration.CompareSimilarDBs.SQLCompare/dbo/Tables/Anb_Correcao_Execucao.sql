CREATE TABLE [dbo].[Anb_Correcao_Execucao] (
    [IdCorrecaoExecucao] INT            IDENTITY (1, 1) NOT NULL,
    [IdCorrecao]         INT            NOT NULL,
    [DataExecucao]       DATETIME       NULL,
    [IdSituacaoExecucao] TINYINT        NOT NULL,
    [UsuarioExecucao]    VARCHAR (35)   NULL,
    [DataAgendamento]    DATETIME       NOT NULL,
    [DataCriacao]        DATETIME       NULL,
    [IdTipoAgendamento]  TINYINT        NOT NULL,
    [ErroExecucao]       VARCHAR (4000) NULL,
    CONSTRAINT [PK_Anb_Correcao_Execucao] PRIMARY KEY CLUSTERED ([IdCorrecaoExecucao] ASC),
    CONSTRAINT [FK_Anb_Correcao_Execucao_Anb_Correcao] FOREIGN KEY ([IdCorrecao]) REFERENCES [dbo].[Anb_Correcao] ([IdCorrecao]),
    CONSTRAINT [FK_Anb_Correcao_Execucao_Anb_Correcao_Situacao_Execucao] FOREIGN KEY ([IdSituacaoExecucao]) REFERENCES [dbo].[Anb_Correcao_Situacao_Execucao] ([IdSituacaoExecucao]),
    CONSTRAINT [FK_Anb_Correcao_Execucao_Anb_TipoAgendamento] FOREIGN KEY ([IdTipoAgendamento]) REFERENCES [dbo].[Anb_TipoAgendamento] ([IdTipoAgendamento])
);


GO
CREATE TRIGGER [TrgLog_Anb_Correcao_Execucao] ON [Implanta_CRPAM].[dbo].[Anb_Correcao_Execucao] 
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
SET @TableName = 'Anb_Correcao_Execucao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCorrecaoExecucao : «' + RTRIM( ISNULL( CAST (IdCorrecaoExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoExecucao : «' + RTRIM( ISNULL( CAST (IdSituacaoExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioExecucao : «' + RTRIM( ISNULL( CAST (UsuarioExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAgendamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAgendamento, 113 ),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| IdTipoAgendamento : «' + RTRIM( ISNULL( CAST (IdTipoAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErroExecucao : «' + RTRIM( ISNULL( CAST (ErroExecucao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCorrecaoExecucao : «' + RTRIM( ISNULL( CAST (IdCorrecaoExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoExecucao : «' + RTRIM( ISNULL( CAST (IdSituacaoExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioExecucao : «' + RTRIM( ISNULL( CAST (UsuarioExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAgendamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAgendamento, 113 ),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| IdTipoAgendamento : «' + RTRIM( ISNULL( CAST (IdTipoAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErroExecucao : «' + RTRIM( ISNULL( CAST (ErroExecucao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCorrecaoExecucao : «' + RTRIM( ISNULL( CAST (IdCorrecaoExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoExecucao : «' + RTRIM( ISNULL( CAST (IdSituacaoExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioExecucao : «' + RTRIM( ISNULL( CAST (UsuarioExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAgendamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAgendamento, 113 ),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| IdTipoAgendamento : «' + RTRIM( ISNULL( CAST (IdTipoAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErroExecucao : «' + RTRIM( ISNULL( CAST (ErroExecucao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCorrecaoExecucao : «' + RTRIM( ISNULL( CAST (IdCorrecaoExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoExecucao : «' + RTRIM( ISNULL( CAST (IdSituacaoExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioExecucao : «' + RTRIM( ISNULL( CAST (UsuarioExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAgendamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAgendamento, 113 ),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| IdTipoAgendamento : «' + RTRIM( ISNULL( CAST (IdTipoAgendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErroExecucao : «' + RTRIM( ISNULL( CAST (ErroExecucao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
