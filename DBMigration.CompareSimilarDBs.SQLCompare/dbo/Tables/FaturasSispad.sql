CREATE TABLE [dbo].[FaturasSispad] (
    [IdFaturaSispad]  INT          IDENTITY (1, 1) NOT NULL,
    [Tipo]            CHAR (1)     NOT NULL,
    [DataEmissao]     DATETIME     NOT NULL,
    [Numero]          VARCHAR (50) NOT NULL,
    [Valor]           MONEY        NULL,
    [NumeroDuplicata] VARCHAR (50) NULL,
    [DataVencimento]  DATETIME     NULL,
    CONSTRAINT [PK_FaturasSispad] PRIMARY KEY CLUSTERED ([IdFaturaSispad] ASC)
);


GO
CREATE TRIGGER [TrgLog_FaturasSispad] ON [Implanta_CRPAM].[dbo].[FaturasSispad] 
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
SET @TableName = 'FaturasSispad'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFaturaSispad : «' + RTRIM( ISNULL( CAST (IdFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDuplicata : «' + RTRIM( ISNULL( CAST (NumeroDuplicata AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFaturaSispad : «' + RTRIM( ISNULL( CAST (IdFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDuplicata : «' + RTRIM( ISNULL( CAST (NumeroDuplicata AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdFaturaSispad : «' + RTRIM( ISNULL( CAST (IdFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDuplicata : «' + RTRIM( ISNULL( CAST (NumeroDuplicata AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFaturaSispad : «' + RTRIM( ISNULL( CAST (IdFaturaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDuplicata : «' + RTRIM( ISNULL( CAST (NumeroDuplicata AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
