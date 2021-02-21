CREATE TABLE [dbo].[FatConfigContasFaturamento] (
    [IdConfigContasFaturamento] INT         IDENTITY (1, 1) NOT NULL,
    [Exercicio]                 VARCHAR (4) NOT NULL,
    [IdUnidade]                 INT         NOT NULL,
    [IdContaReceitaUnidade]     INT         NOT NULL,
    [IdContaBancoUnidade]       INT         NOT NULL,
    [IdContaPatrimonialUnidade] INT         NOT NULL,
    CONSTRAINT [PK_FatConfigContasFaturamento] PRIMARY KEY CLUSTERED ([IdConfigContasFaturamento] ASC),
    CONSTRAINT [FK_FatConfigContasFaturamento_PlanoContas1] FOREIGN KEY ([IdContaReceitaUnidade]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_FatConfigContasFaturamento_PlanoContas2] FOREIGN KEY ([IdContaBancoUnidade]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_FatConfigContasFaturamento_PlanoContas3] FOREIGN KEY ([IdContaPatrimonialUnidade]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_FatConfigContasFaturamento_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);


GO
CREATE TRIGGER [TrgLog_FatConfigContasFaturamento] ON [Implanta_CRPAM].[dbo].[FatConfigContasFaturamento] 
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
SET @TableName = 'FatConfigContasFaturamento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigContasFaturamento : «' + RTRIM( ISNULL( CAST (IdConfigContasFaturamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceitaUnidade : «' + RTRIM( ISNULL( CAST (IdContaReceitaUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBancoUnidade : «' + RTRIM( ISNULL( CAST (IdContaBancoUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialUnidade : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialUnidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigContasFaturamento : «' + RTRIM( ISNULL( CAST (IdConfigContasFaturamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceitaUnidade : «' + RTRIM( ISNULL( CAST (IdContaReceitaUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBancoUnidade : «' + RTRIM( ISNULL( CAST (IdContaBancoUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialUnidade : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialUnidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigContasFaturamento : «' + RTRIM( ISNULL( CAST (IdConfigContasFaturamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceitaUnidade : «' + RTRIM( ISNULL( CAST (IdContaReceitaUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBancoUnidade : «' + RTRIM( ISNULL( CAST (IdContaBancoUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialUnidade : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialUnidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigContasFaturamento : «' + RTRIM( ISNULL( CAST (IdConfigContasFaturamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceitaUnidade : «' + RTRIM( ISNULL( CAST (IdContaReceitaUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBancoUnidade : «' + RTRIM( ISNULL( CAST (IdContaBancoUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialUnidade : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialUnidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
