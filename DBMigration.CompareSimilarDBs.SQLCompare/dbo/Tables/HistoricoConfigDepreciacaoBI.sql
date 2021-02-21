CREATE TABLE [dbo].[HistoricoConfigDepreciacaoBI] (
    [IdHistoricoConfigDepreciacaoBI] INT        IDENTITY (1, 1) NOT NULL,
    [IdItemImovel]                   INT        NOT NULL,
    [IdReavaliacao]                  INT        NULL,
    [ConfigAlteradaPorItem]          BIT        NULL,
    [Data]                           DATETIME   NULL,
    [VResidualPercent]               FLOAT (53) NULL,
    [VidaUtilAnos]                   INT        NOT NULL,
    [QtdMesesRestantes]              INT        NOT NULL,
    [TaxaDepreciacaoMensal]          FLOAT (53) NOT NULL,
    CONSTRAINT [PK_HistoricoConfigDepreciacaoBI] PRIMARY KEY CLUSTERED ([IdHistoricoConfigDepreciacaoBI] ASC),
    CONSTRAINT [FK_HistoricoConfigDepreciacaoBI_ItensImoveis] FOREIGN KEY ([IdItemImovel]) REFERENCES [dbo].[ItensImoveis] ([IdItem]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_HistoricoConfigDepreciacaoBI] ON [Implanta_CRPAM].[dbo].[HistoricoConfigDepreciacaoBI] 
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
SET @TableName = 'HistoricoConfigDepreciacaoBI'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistoricoConfigDepreciacaoBI : «' + RTRIM( ISNULL( CAST (IdHistoricoConfigDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemImovel : «' + RTRIM( ISNULL( CAST (IdItemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReavaliacao : «' + RTRIM( ISNULL( CAST (IdReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigAlteradaPorItem IS NULL THEN ' ConfigAlteradaPorItem : «Nulo» '
                                              WHEN  ConfigAlteradaPorItem = 0 THEN ' ConfigAlteradaPorItem : «Falso» '
                                              WHEN  ConfigAlteradaPorItem = 1 THEN ' ConfigAlteradaPorItem : «Verdadeiro» '
                                    END 
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| VResidualPercent : «' + RTRIM( ISNULL( CAST (VResidualPercent AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilAnos : «' + RTRIM( ISNULL( CAST (VidaUtilAnos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesRestantes : «' + RTRIM( ISNULL( CAST (QtdMesesRestantes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaDepreciacaoMensal : «' + RTRIM( ISNULL( CAST (TaxaDepreciacaoMensal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistoricoConfigDepreciacaoBI : «' + RTRIM( ISNULL( CAST (IdHistoricoConfigDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemImovel : «' + RTRIM( ISNULL( CAST (IdItemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReavaliacao : «' + RTRIM( ISNULL( CAST (IdReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigAlteradaPorItem IS NULL THEN ' ConfigAlteradaPorItem : «Nulo» '
                                              WHEN  ConfigAlteradaPorItem = 0 THEN ' ConfigAlteradaPorItem : «Falso» '
                                              WHEN  ConfigAlteradaPorItem = 1 THEN ' ConfigAlteradaPorItem : «Verdadeiro» '
                                    END 
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| VResidualPercent : «' + RTRIM( ISNULL( CAST (VResidualPercent AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilAnos : «' + RTRIM( ISNULL( CAST (VidaUtilAnos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesRestantes : «' + RTRIM( ISNULL( CAST (QtdMesesRestantes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaDepreciacaoMensal : «' + RTRIM( ISNULL( CAST (TaxaDepreciacaoMensal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistoricoConfigDepreciacaoBI : «' + RTRIM( ISNULL( CAST (IdHistoricoConfigDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemImovel : «' + RTRIM( ISNULL( CAST (IdItemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReavaliacao : «' + RTRIM( ISNULL( CAST (IdReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigAlteradaPorItem IS NULL THEN ' ConfigAlteradaPorItem : «Nulo» '
                                              WHEN  ConfigAlteradaPorItem = 0 THEN ' ConfigAlteradaPorItem : «Falso» '
                                              WHEN  ConfigAlteradaPorItem = 1 THEN ' ConfigAlteradaPorItem : «Verdadeiro» '
                                    END 
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| VResidualPercent : «' + RTRIM( ISNULL( CAST (VResidualPercent AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilAnos : «' + RTRIM( ISNULL( CAST (VidaUtilAnos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesRestantes : «' + RTRIM( ISNULL( CAST (QtdMesesRestantes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaDepreciacaoMensal : «' + RTRIM( ISNULL( CAST (TaxaDepreciacaoMensal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistoricoConfigDepreciacaoBI : «' + RTRIM( ISNULL( CAST (IdHistoricoConfigDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemImovel : «' + RTRIM( ISNULL( CAST (IdItemImovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReavaliacao : «' + RTRIM( ISNULL( CAST (IdReavaliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigAlteradaPorItem IS NULL THEN ' ConfigAlteradaPorItem : «Nulo» '
                                              WHEN  ConfigAlteradaPorItem = 0 THEN ' ConfigAlteradaPorItem : «Falso» '
                                              WHEN  ConfigAlteradaPorItem = 1 THEN ' ConfigAlteradaPorItem : «Verdadeiro» '
                                    END 
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| VResidualPercent : «' + RTRIM( ISNULL( CAST (VResidualPercent AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VidaUtilAnos : «' + RTRIM( ISNULL( CAST (VidaUtilAnos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesRestantes : «' + RTRIM( ISNULL( CAST (QtdMesesRestantes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaDepreciacaoMensal : «' + RTRIM( ISNULL( CAST (TaxaDepreciacaoMensal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
