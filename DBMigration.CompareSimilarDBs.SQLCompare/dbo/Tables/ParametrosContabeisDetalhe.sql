CREATE TABLE [dbo].[ParametrosContabeisDetalhe] (
    [IdParametroContabilDetalhe] INT  IDENTITY (1, 1) NOT NULL,
    [IdParametroContabil]        INT  NOT NULL,
    [Tipo]                       INT  NOT NULL,
    [IdContaDebito]              INT  NOT NULL,
    [IdContaCredito]             INT  NOT NULL,
    [Historico]                  TEXT NULL,
    CONSTRAINT [PK_ParametrosContabeisDetalhe] PRIMARY KEY CLUSTERED ([IdParametroContabilDetalhe] ASC),
    CONSTRAINT [FK_ParametrosContabeisDetalhe_ParametrosContabeis] FOREIGN KEY ([IdParametroContabil]) REFERENCES [dbo].[ParametrosContabeis] ([IdParametroContabil]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ParametrosContabeisDetalhe_PlanoContas] FOREIGN KEY ([IdContaDebito]) REFERENCES [dbo].[PlanoContas] ([IdConta]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ParametrosContabeisDetalhe_PlanoContas1] FOREIGN KEY ([IdContaCredito]) REFERENCES [dbo].[PlanoContas] ([IdConta]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ParametrosContabeisDetalhe] ON [Implanta_CRPAM].[dbo].[ParametrosContabeisDetalhe] 
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
SET @TableName = 'ParametrosContabeisDetalhe'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdParametroContabilDetalhe : «' + RTRIM( ISNULL( CAST (IdParametroContabilDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdParametroContabil : «' + RTRIM( ISNULL( CAST (IdParametroContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebito : «' + RTRIM( ISNULL( CAST (IdContaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCredito : «' + RTRIM( ISNULL( CAST (IdContaCredito AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdParametroContabilDetalhe : «' + RTRIM( ISNULL( CAST (IdParametroContabilDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdParametroContabil : «' + RTRIM( ISNULL( CAST (IdParametroContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebito : «' + RTRIM( ISNULL( CAST (IdContaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCredito : «' + RTRIM( ISNULL( CAST (IdContaCredito AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdParametroContabilDetalhe : «' + RTRIM( ISNULL( CAST (IdParametroContabilDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdParametroContabil : «' + RTRIM( ISNULL( CAST (IdParametroContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebito : «' + RTRIM( ISNULL( CAST (IdContaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCredito : «' + RTRIM( ISNULL( CAST (IdContaCredito AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdParametroContabilDetalhe : «' + RTRIM( ISNULL( CAST (IdParametroContabilDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdParametroContabil : «' + RTRIM( ISNULL( CAST (IdParametroContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDebito : «' + RTRIM( ISNULL( CAST (IdContaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCredito : «' + RTRIM( ISNULL( CAST (IdContaCredito AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
