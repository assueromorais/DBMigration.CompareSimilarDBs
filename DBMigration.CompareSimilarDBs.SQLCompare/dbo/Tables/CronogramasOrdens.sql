CREATE TABLE [dbo].[CronogramasOrdens] (
    [IdCronograma] INT        IDENTITY (1, 1) NOT NULL,
    [IdItensOrdem] INT        NULL,
    [QtdPrevista]  FLOAT (53) NULL,
    [DataPrevista] DATETIME   NOT NULL,
    [IdItemCompra] INT        NULL,
    CONSTRAINT [PK_CronogramasOrdens] PRIMARY KEY CLUSTERED ([IdCronograma] ASC),
    CONSTRAINT [FK_CronogramasOrdens_ItensCompras] FOREIGN KEY ([IdItemCompra]) REFERENCES [dbo].[ItensCompras] ([IdItemCompra]) NOT FOR REPLICATION,
    CONSTRAINT [FK_CronogramasOrdens_ItensOrdens] FOREIGN KEY ([IdItensOrdem]) REFERENCES [dbo].[ItensOrdens] ([IdItensOrdem]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[CronogramasOrdens] NOCHECK CONSTRAINT [FK_CronogramasOrdens_ItensCompras];


GO
ALTER TABLE [dbo].[CronogramasOrdens] NOCHECK CONSTRAINT [FK_CronogramasOrdens_ItensOrdens];


GO
CREATE TRIGGER [TrgLog_CronogramasOrdens] ON [Implanta_CRPAM].[dbo].[CronogramasOrdens] 
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
SET @TableName = 'CronogramasOrdens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCronograma : «' + RTRIM( ISNULL( CAST (IdCronograma AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItensOrdem : «' + RTRIM( ISNULL( CAST (IdItensOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdPrevista : «' + RTRIM( ISNULL( CAST (QtdPrevista AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCronograma : «' + RTRIM( ISNULL( CAST (IdCronograma AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItensOrdem : «' + RTRIM( ISNULL( CAST (IdItensOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdPrevista : «' + RTRIM( ISNULL( CAST (QtdPrevista AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCronograma : «' + RTRIM( ISNULL( CAST (IdCronograma AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItensOrdem : «' + RTRIM( ISNULL( CAST (IdItensOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdPrevista : «' + RTRIM( ISNULL( CAST (QtdPrevista AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCronograma : «' + RTRIM( ISNULL( CAST (IdCronograma AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItensOrdem : «' + RTRIM( ISNULL( CAST (IdItensOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdPrevista : «' + RTRIM( ISNULL( CAST (QtdPrevista AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
