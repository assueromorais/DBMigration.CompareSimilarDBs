CREATE TABLE [dbo].[MovimentacoesBens] (
    [IdMovimentacaoBem]      INT         IDENTITY (1, 1) NOT NULL,
    [IdItem]                 INT         NOT NULL,
    [IdUnidade]              INT         NULL,
    [IdResponsavel]          INT         NULL,
    [DataMovimentacao]       DATETIME    NOT NULL,
    [HistoricoMovimentacao]  TEXT        NULL,
    [TipoMovimentacao]       VARCHAR (1) NULL,
    [DataImportacao]         DATETIME    NULL,
    [NumeroMovimentacoesBem] VARCHAR (5) NULL,
    [bMovimentacaoWeb]       BIT         NULL,
    CONSTRAINT [PK_MovimentacoesBens] PRIMARY KEY NONCLUSTERED ([IdMovimentacaoBem] ASC),
    CONSTRAINT [FK_MovimentacoesBens_ItensMoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensMoveis] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_MovimentacoesBens_Responsaveis] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]) NOT FOR REPLICATION,
    CONSTRAINT [FK_MovimentacoesBens_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[MovimentacoesBens] NOCHECK CONSTRAINT [FK_MovimentacoesBens_ItensMoveis];


GO
CREATE TRIGGER [TrgLog_MovimentacoesBens] ON [Implanta_CRPAM].[dbo].[MovimentacoesBens] 
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
SET @TableName = 'MovimentacoesBens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| TipoMovimentacao : «' + RTRIM( ISNULL( CAST (TipoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| NumeroMovimentacoesBem : «' + RTRIM( ISNULL( CAST (NumeroMovimentacoesBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bMovimentacaoWeb IS NULL THEN ' bMovimentacaoWeb : «Nulo» '
                                              WHEN  bMovimentacaoWeb = 0 THEN ' bMovimentacaoWeb : «Falso» '
                                              WHEN  bMovimentacaoWeb = 1 THEN ' bMovimentacaoWeb : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| TipoMovimentacao : «' + RTRIM( ISNULL( CAST (TipoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| NumeroMovimentacoesBem : «' + RTRIM( ISNULL( CAST (NumeroMovimentacoesBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bMovimentacaoWeb IS NULL THEN ' bMovimentacaoWeb : «Nulo» '
                                              WHEN  bMovimentacaoWeb = 0 THEN ' bMovimentacaoWeb : «Falso» '
                                              WHEN  bMovimentacaoWeb = 1 THEN ' bMovimentacaoWeb : «Verdadeiro» '
                                    END  FROM INSERTED 
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
		SELECT @Conteudo = 'IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| TipoMovimentacao : «' + RTRIM( ISNULL( CAST (TipoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| NumeroMovimentacoesBem : «' + RTRIM( ISNULL( CAST (NumeroMovimentacoesBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bMovimentacaoWeb IS NULL THEN ' bMovimentacaoWeb : «Nulo» '
                                              WHEN  bMovimentacaoWeb = 0 THEN ' bMovimentacaoWeb : «Falso» '
                                              WHEN  bMovimentacaoWeb = 1 THEN ' bMovimentacaoWeb : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| TipoMovimentacao : «' + RTRIM( ISNULL( CAST (TipoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| NumeroMovimentacoesBem : «' + RTRIM( ISNULL( CAST (NumeroMovimentacoesBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bMovimentacaoWeb IS NULL THEN ' bMovimentacaoWeb : «Nulo» '
                                              WHEN  bMovimentacaoWeb = 0 THEN ' bMovimentacaoWeb : «Falso» '
                                              WHEN  bMovimentacaoWeb = 1 THEN ' bMovimentacaoWeb : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
