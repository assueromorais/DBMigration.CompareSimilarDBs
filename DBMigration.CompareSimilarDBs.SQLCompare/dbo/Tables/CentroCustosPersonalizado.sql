CREATE TABLE [dbo].[CentroCustosPersonalizado] (
    [IdCentroCustosPersonalizado] INT          IDENTITY (1, 1) NOT NULL,
    [NomePersonalizado]           VARCHAR (60) NOT NULL,
    [IdCentroCusto]               INT          NOT NULL,
    [Exercicio]                   VARCHAR (4)  NULL,
    CONSTRAINT [PK_CentroCustosPersonalizado] PRIMARY KEY CLUSTERED ([IdCentroCustosPersonalizado] ASC),
    CONSTRAINT [FK_CentroCustosPersonalizado_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto])
);


GO
CREATE TRIGGER [TrgLog_CentroCustosPersonalizado] ON [Implanta_CRPAM].[dbo].[CentroCustosPersonalizado] 
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
SET @TableName = 'CentroCustosPersonalizado'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCentroCustosPersonalizado : «' + RTRIM( ISNULL( CAST (IdCentroCustosPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCentroCustosPersonalizado : «' + RTRIM( ISNULL( CAST (IdCentroCustosPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCentroCustosPersonalizado : «' + RTRIM( ISNULL( CAST (IdCentroCustosPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCentroCustosPersonalizado : «' + RTRIM( ISNULL( CAST (IdCentroCustosPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
