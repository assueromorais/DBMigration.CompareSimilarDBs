CREATE TABLE [dbo].[ComposicoesEmissaoConfig] (
    [IdComposicaoEmissaoConfig] INT            IDENTITY (1, 1) NOT NULL,
    [IdComposicaoEmissao]       INT            NOT NULL,
    [CodDesconto1]              TINYINT        NULL,
    [DataDesconto1]             DATETIME       NULL,
    [ValorDesconto1]            MONEY          NULL,
    [CodDesconto2]              TINYINT        NULL,
    [DataDesconto2]             DATETIME       NULL,
    [ValorDesconto2]            MONEY          NULL,
    [CodDesconto3]              TINYINT        NULL,
    [DataDesconto3]             DATETIME       NULL,
    [ValorDesconto3]            MONEY          NULL,
    [AtualizacaoWeb]            VARCHAR (5000) NULL,
    CONSTRAINT [PK_ComposicoesEmissaoConfig] PRIMARY KEY CLUSTERED ([IdComposicaoEmissaoConfig] ASC),
    CONSTRAINT [FK_ComposicoesEmissaoConfig_ComposicoesEmissao] FOREIGN KEY ([IdComposicaoEmissao]) REFERENCES [dbo].[ComposicoesEmissao] ([IdComposicaoEmissao])
);


GO
CREATE NONCLUSTERED INDEX [IX_ComposicoesEmissaoConfig_IdComposicaoEmissao_Desconto]
    ON [dbo].[ComposicoesEmissaoConfig]([IdComposicaoEmissao] ASC)
    INCLUDE([CodDesconto1], [DataDesconto1]);


GO
CREATE TRIGGER [TrgLog_ComposicoesEmissaoConfig] ON [Implanta_CRPAM].[dbo].[ComposicoesEmissaoConfig] 
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
SET @TableName = 'ComposicoesEmissaoConfig'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdComposicaoEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComposicaoEmissao : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto1 : «' + RTRIM( ISNULL( CAST (CodDesconto1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto1 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto1, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto1 : «' + RTRIM( ISNULL( CAST (ValorDesconto1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto2 : «' + RTRIM( ISNULL( CAST (CodDesconto2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto2 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto2, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto2 : «' + RTRIM( ISNULL( CAST (ValorDesconto2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto3 : «' + RTRIM( ISNULL( CAST (CodDesconto3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto3 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto3, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto3 : «' + RTRIM( ISNULL( CAST (ValorDesconto3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdComposicaoEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComposicaoEmissao : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto1 : «' + RTRIM( ISNULL( CAST (CodDesconto1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto1 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto1, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto1 : «' + RTRIM( ISNULL( CAST (ValorDesconto1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto2 : «' + RTRIM( ISNULL( CAST (CodDesconto2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto2 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto2, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto2 : «' + RTRIM( ISNULL( CAST (ValorDesconto2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto3 : «' + RTRIM( ISNULL( CAST (CodDesconto3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto3 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto3, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto3 : «' + RTRIM( ISNULL( CAST (ValorDesconto3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdComposicaoEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComposicaoEmissao : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto1 : «' + RTRIM( ISNULL( CAST (CodDesconto1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto1 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto1, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto1 : «' + RTRIM( ISNULL( CAST (ValorDesconto1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto2 : «' + RTRIM( ISNULL( CAST (CodDesconto2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto2 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto2, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto2 : «' + RTRIM( ISNULL( CAST (ValorDesconto2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto3 : «' + RTRIM( ISNULL( CAST (CodDesconto3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto3 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto3, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto3 : «' + RTRIM( ISNULL( CAST (ValorDesconto3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdComposicaoEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComposicaoEmissao : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto1 : «' + RTRIM( ISNULL( CAST (CodDesconto1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto1 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto1, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto1 : «' + RTRIM( ISNULL( CAST (ValorDesconto1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto2 : «' + RTRIM( ISNULL( CAST (CodDesconto2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto2 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto2, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto2 : «' + RTRIM( ISNULL( CAST (ValorDesconto2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodDesconto3 : «' + RTRIM( ISNULL( CAST (CodDesconto3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDesconto3 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDesconto3, 113 ),'Nulo'))+'» '
                         + '| ValorDesconto3 : «' + RTRIM( ISNULL( CAST (ValorDesconto3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
