CREATE TABLE [dbo].[MovimentacoesRegPrecos] (
    [IdMovimentacoesRegPrecos] INT        IDENTITY (1, 1) NOT NULL,
    [DataMovimentacao]         DATETIME   NOT NULL,
    [IdSubItem]                INT        NOT NULL,
    [Qtd]                      FLOAT (53) NULL,
    [IdUnidade]                INT        NULL,
    [IdOrdem]                  INT        NULL,
    CONSTRAINT [PK_MovimentacoesRegPrecos] PRIMARY KEY CLUSTERED ([IdMovimentacoesRegPrecos] ASC),
    CONSTRAINT [FK_MovimentacoesRegPrecos_Ordens] FOREIGN KEY ([IdOrdem]) REFERENCES [dbo].[Ordens] ([IdOrdem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_MovimentacoesRegPrecos_SubItens] FOREIGN KEY ([IdSubItem]) REFERENCES [dbo].[SubItens] ([IdSubItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_MovimentacoesRegPrecos_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_MovimentacoesRegPrecos] ON [Implanta_CRPAM].[dbo].[MovimentacoesRegPrecos] 
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
SET @TableName = 'MovimentacoesRegPrecos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMovimentacoesRegPrecos : «' + RTRIM( ISNULL( CAST (IdMovimentacoesRegPrecos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMovimentacoesRegPrecos : «' + RTRIM( ISNULL( CAST (IdMovimentacoesRegPrecos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMovimentacoesRegPrecos : «' + RTRIM( ISNULL( CAST (IdMovimentacoesRegPrecos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMovimentacoesRegPrecos : «' + RTRIM( ISNULL( CAST (IdMovimentacoesRegPrecos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
