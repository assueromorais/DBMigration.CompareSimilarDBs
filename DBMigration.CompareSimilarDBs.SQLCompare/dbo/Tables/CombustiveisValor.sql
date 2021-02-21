CREATE TABLE [dbo].[CombustiveisValor] (
    [IdCombustivelValor] INT      IDENTITY (1, 1) NOT NULL,
    [IdCombustivel]      INT      NULL,
    [Data]               DATETIME NULL,
    [Valor]              MONEY    NULL,
    [ValorInterior]      MONEY    NULL,
    CONSTRAINT [PK_CombustiveisValor] PRIMARY KEY CLUSTERED ([IdCombustivelValor] ASC),
    CONSTRAINT [FK_CombustiveisValor_Combustiveis] FOREIGN KEY ([IdCombustivel]) REFERENCES [dbo].[Combustiveis] ([IdCombustivel])
);


GO
CREATE TRIGGER [TrgLog_CombustiveisValor] ON [Implanta_CRPAM].[dbo].[CombustiveisValor] 
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
SET @TableName = 'CombustiveisValor'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCombustivelValor : «' + RTRIM( ISNULL( CAST (IdCombustivelValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCombustivel : «' + RTRIM( ISNULL( CAST (IdCombustivel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorInterior : «' + RTRIM( ISNULL( CAST (ValorInterior AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCombustivelValor : «' + RTRIM( ISNULL( CAST (IdCombustivelValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCombustivel : «' + RTRIM( ISNULL( CAST (IdCombustivel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorInterior : «' + RTRIM( ISNULL( CAST (ValorInterior AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCombustivelValor : «' + RTRIM( ISNULL( CAST (IdCombustivelValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCombustivel : «' + RTRIM( ISNULL( CAST (IdCombustivel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorInterior : «' + RTRIM( ISNULL( CAST (ValorInterior AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCombustivelValor : «' + RTRIM( ISNULL( CAST (IdCombustivelValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCombustivel : «' + RTRIM( ISNULL( CAST (IdCombustivel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorInterior : «' + RTRIM( ISNULL( CAST (ValorInterior AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
