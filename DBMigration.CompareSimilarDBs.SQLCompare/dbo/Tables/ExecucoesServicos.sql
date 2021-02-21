CREATE TABLE [dbo].[ExecucoesServicos] (
    [IdExecucaoServico] INT          IDENTITY (1, 1) NOT NULL,
    [IdOrdem]           INT          NOT NULL,
    [DataExecucao]      DATETIME     NULL,
    [IdResponsavel]     INT          NULL,
    [NomeTecnico]       VARCHAR (50) NULL,
    [Observacao]        TEXT         NULL,
    CONSTRAINT [PK_ExecucoesServicos] PRIMARY KEY CLUSTERED ([IdExecucaoServico] ASC),
    CONSTRAINT [FK_ExecucoesServicos_Ordens] FOREIGN KEY ([IdOrdem]) REFERENCES [dbo].[Ordens] ([IdOrdem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExecucoesServicos_Responsaveis] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel])
);


GO
CREATE TRIGGER [TrgLog_ExecucoesServicos] ON [Implanta_CRPAM].[dbo].[ExecucoesServicos] 
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
SET @TableName = 'ExecucoesServicos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdExecucaoServico : «' + RTRIM( ISNULL( CAST (IdExecucaoServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTecnico : «' + RTRIM( ISNULL( CAST (NomeTecnico AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdExecucaoServico : «' + RTRIM( ISNULL( CAST (IdExecucaoServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTecnico : «' + RTRIM( ISNULL( CAST (NomeTecnico AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdExecucaoServico : «' + RTRIM( ISNULL( CAST (IdExecucaoServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTecnico : «' + RTRIM( ISNULL( CAST (NomeTecnico AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdExecucaoServico : «' + RTRIM( ISNULL( CAST (IdExecucaoServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTecnico : «' + RTRIM( ISNULL( CAST (NomeTecnico AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
