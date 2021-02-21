CREATE TABLE [dbo].[ConfigEmissaoBoleto] (
    [IdConfigEmissaoBoleto] INT      IDENTITY (1, 1) NOT NULL,
    [IdTipoDebito]          INT      NOT NULL,
    [IdSituacaoDebito]      INT      NOT NULL,
    [Exercicio]             INT      NOT NULL,
    [DataLimiteVencimento]  DATETIME NULL,
    CONSTRAINT [PK_ConfigEmissaoBoleto] PRIMARY KEY CLUSTERED ([IdConfigEmissaoBoleto] ASC),
    CONSTRAINT [FK_ConfigEmissaoBoleto_SituacoesDebito] FOREIGN KEY ([IdSituacaoDebito]) REFERENCES [dbo].[SituacoesDebito] ([IdSituacaoDebito]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ConfigEmissaoBoleto_TiposDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ConfigEmissaoBoleto] ON [Implanta_CRPAM].[dbo].[ConfigEmissaoBoleto] 
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
SET @TableName = 'ConfigEmissaoBoleto'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigEmissaoBoleto : «' + RTRIM( ISNULL( CAST (IdConfigEmissaoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLimiteVencimento, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigEmissaoBoleto : «' + RTRIM( ISNULL( CAST (IdConfigEmissaoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLimiteVencimento, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigEmissaoBoleto : «' + RTRIM( ISNULL( CAST (IdConfigEmissaoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLimiteVencimento, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigEmissaoBoleto : «' + RTRIM( ISNULL( CAST (IdConfigEmissaoBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLimiteVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLimiteVencimento, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
