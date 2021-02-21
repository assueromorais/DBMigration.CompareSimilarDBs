CREATE TABLE [dbo].[ItensFaturasSispad] (
    [IdItemFaturaSispad]     INT   IDENTITY (1, 1) NOT NULL,
    [IdFaturaSispad]         INT   NOT NULL,
    [IdPassagemAereaEmitida] INT   NOT NULL,
    [OutrasTaxas]            MONEY NULL,
    [Multas]                 MONEY NULL,
    [Total]                  MONEY NOT NULL,
    CONSTRAINT [PK_ItensFaturasSispad] PRIMARY KEY CLUSTERED ([IdItemFaturaSispad] ASC),
    CONSTRAINT [FK_ItensFaturasSispad_FaturasSispad] FOREIGN KEY ([IdFaturaSispad]) REFERENCES [dbo].[FaturasSispad] ([IdFaturaSispad]),
    CONSTRAINT [FK_ItensFaturasSispad_PassagensAereasEmitidas] FOREIGN KEY ([IdPassagemAereaEmitida]) REFERENCES [dbo].[PassagensAereasEmitidas] ([IdPassagemAereaEmitida])
);


GO
CREATE TRIGGER [TrgLog_ItensFaturasSispad] ON [Implanta_CRPAM].[dbo].[ItensFaturasSispad] 
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
SET @TableName = 'ItensFaturasSispad'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItemFaturaSispad : «' + RTRIM( ISNULL( CAST (IdItemFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaturaSispad : «' + RTRIM( ISNULL( CAST (IdFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrasTaxas : «' + RTRIM( ISNULL( CAST (OutrasTaxas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Multas : «' + RTRIM( ISNULL( CAST (Multas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Total : «' + RTRIM( ISNULL( CAST (Total AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItemFaturaSispad : «' + RTRIM( ISNULL( CAST (IdItemFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaturaSispad : «' + RTRIM( ISNULL( CAST (IdFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrasTaxas : «' + RTRIM( ISNULL( CAST (OutrasTaxas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Multas : «' + RTRIM( ISNULL( CAST (Multas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Total : «' + RTRIM( ISNULL( CAST (Total AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItemFaturaSispad : «' + RTRIM( ISNULL( CAST (IdItemFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaturaSispad : «' + RTRIM( ISNULL( CAST (IdFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrasTaxas : «' + RTRIM( ISNULL( CAST (OutrasTaxas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Multas : «' + RTRIM( ISNULL( CAST (Multas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Total : «' + RTRIM( ISNULL( CAST (Total AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItemFaturaSispad : «' + RTRIM( ISNULL( CAST (IdItemFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaturaSispad : «' + RTRIM( ISNULL( CAST (IdFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrasTaxas : «' + RTRIM( ISNULL( CAST (OutrasTaxas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Multas : «' + RTRIM( ISNULL( CAST (Multas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Total : «' + RTRIM( ISNULL( CAST (Total AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
