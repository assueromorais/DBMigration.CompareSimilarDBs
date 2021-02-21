CREATE TABLE [dbo].[ConfiguracaoEncerramento] (
    [IdContaOrigem]        INT  NOT NULL,
    [IdContaContrapartida] INT  NOT NULL,
    [Historico]            TEXT NULL,
    CONSTRAINT [PK_ConfiguracaoEncerramento] PRIMARY KEY NONCLUSTERED ([IdContaOrigem] ASC),
    CONSTRAINT [FK_ConfiguracaoEncerramento_PlanoContas2] FOREIGN KEY ([IdContaOrigem]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ConfiguracaoEncerramento_PlanoContas3] FOREIGN KEY ([IdContaContrapartida]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE TRIGGER [TrgLog_ConfiguracaoEncerramento] ON [Implanta_CRPAM].[dbo].[ConfiguracaoEncerramento] 
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
SET @TableName = 'ConfiguracaoEncerramento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContaOrigem : «' + RTRIM( ISNULL( CAST (IdContaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaContrapartida : «' + RTRIM( ISNULL( CAST (IdContaContrapartida AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContaOrigem : «' + RTRIM( ISNULL( CAST (IdContaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaContrapartida : «' + RTRIM( ISNULL( CAST (IdContaContrapartida AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdContaOrigem : «' + RTRIM( ISNULL( CAST (IdContaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaContrapartida : «' + RTRIM( ISNULL( CAST (IdContaContrapartida AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContaOrigem : «' + RTRIM( ISNULL( CAST (IdContaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaContrapartida : «' + RTRIM( ISNULL( CAST (IdContaContrapartida AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
