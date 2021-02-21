CREATE TABLE [dbo].[AnB_RelatorioInconsistencia] (
    [IdRelatorio]           INT           IDENTITY (1, 1) NOT NULL,
    [IdResultadoAnalise]    INT           NOT NULL,
    [IdItemAnalisado]       SMALLINT      NOT NULL,
    [DetalheInconsistencia] VARCHAR (250) NULL,
    [IdentificadorRegistro] VARCHAR (20)  NULL,
    [IdCorrecaoExecucao]    INT           NULL,
    CONSTRAINT [PK_AnB_RelatorioInconsistencia] PRIMARY KEY CLUSTERED ([IdRelatorio] ASC),
    CONSTRAINT [FK_AnB_RelatorioInconsistencia_AnB_ResultadoItensAnalisados] FOREIGN KEY ([IdResultadoAnalise], [IdItemAnalisado]) REFERENCES [dbo].[AnB_ResultadoItensAnalisados] ([IdResultadoAnalise], [IdItemAnalisado])
);


GO
CREATE TRIGGER [TrgLog_AnB_RelatorioInconsistencia] ON [Implanta_CRPAM].[dbo].[AnB_RelatorioInconsistencia] 
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
SET @TableName = 'AnB_RelatorioInconsistencia'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DetalheInconsistencia : «' + RTRIM( ISNULL( CAST (DetalheInconsistencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorRegistro : «' + RTRIM( ISNULL( CAST (IdentificadorRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecaoExecucao : «' + RTRIM( ISNULL( CAST (IdCorrecaoExecucao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DetalheInconsistencia : «' + RTRIM( ISNULL( CAST (DetalheInconsistencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorRegistro : «' + RTRIM( ISNULL( CAST (IdentificadorRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecaoExecucao : «' + RTRIM( ISNULL( CAST (IdCorrecaoExecucao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DetalheInconsistencia : «' + RTRIM( ISNULL( CAST (DetalheInconsistencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorRegistro : «' + RTRIM( ISNULL( CAST (IdentificadorRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecaoExecucao : «' + RTRIM( ISNULL( CAST (IdCorrecaoExecucao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DetalheInconsistencia : «' + RTRIM( ISNULL( CAST (DetalheInconsistencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorRegistro : «' + RTRIM( ISNULL( CAST (IdentificadorRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecaoExecucao : «' + RTRIM( ISNULL( CAST (IdCorrecaoExecucao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
