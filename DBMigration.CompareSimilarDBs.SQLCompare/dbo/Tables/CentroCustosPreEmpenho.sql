CREATE TABLE [dbo].[CentroCustosPreEmpenho] (
    [IdCentroCustosPreEmpenho] INT   IDENTITY (1, 1) NOT NULL,
    [IdPreEmpenho]             INT   NOT NULL,
    [IdCentroCusto]            INT   NOT NULL,
    [Valor]                    MONEY NOT NULL,
    CONSTRAINT [PK_CentroCustosPreEmpenho] PRIMARY KEY CLUSTERED ([IdCentroCustosPreEmpenho] ASC),
    CONSTRAINT [FK_CentroCustosPreEmpenho_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_CentroCustosPreEmpenho_PreEmpenhos] FOREIGN KEY ([IdPreEmpenho]) REFERENCES [dbo].[PreEmpenhos] ([IdPreEmpenho])
);


GO
CREATE NONCLUSTERED INDEX [IX_CentroCustosPreEmpenho_IdCentroCusto]
    ON [dbo].[CentroCustosPreEmpenho]([IdCentroCusto] ASC);


GO
CREATE TRIGGER [TrgLog_CentroCustosPreEmpenho] ON [Implanta_CRPAM].[dbo].[CentroCustosPreEmpenho] 
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
SET @TableName = 'CentroCustosPreEmpenho'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCentroCustosPreEmpenho : «' + RTRIM( ISNULL( CAST (IdCentroCustosPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreEmpenho : «' + RTRIM( ISNULL( CAST (IdPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCentroCustosPreEmpenho : «' + RTRIM( ISNULL( CAST (IdCentroCustosPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreEmpenho : «' + RTRIM( ISNULL( CAST (IdPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCentroCustosPreEmpenho : «' + RTRIM( ISNULL( CAST (IdCentroCustosPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreEmpenho : «' + RTRIM( ISNULL( CAST (IdPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCentroCustosPreEmpenho : «' + RTRIM( ISNULL( CAST (IdCentroCustosPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreEmpenho : «' + RTRIM( ISNULL( CAST (IdPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
