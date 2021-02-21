CREATE TABLE [dbo].[DetalhesArquivoRemessa] (
    [IdDetalheArquivoRemessa] INT          IDENTITY (1, 1) NOT NULL,
    [IdArquivoRemessa]        INT          NOT NULL,
    [NossoNumero]             VARCHAR (20) NOT NULL,
    [Vencimento]              DATETIME     NULL,
    [Valor]                   MONEY        NULL,
    [Estornado]               BIT          NULL,
    CONSTRAINT [PK_DetalhesArquivoRemessa] PRIMARY KEY CLUSTERED ([IdDetalheArquivoRemessa] ASC),
    CONSTRAINT [FK_DetalhesArquivoRemessa_ArquivosRemessa] FOREIGN KEY ([IdArquivoRemessa]) REFERENCES [dbo].[ArquivosRemessa] ([IdArquivoRemessa])
);


GO
CREATE TRIGGER [TrgLog_DetalhesArquivoRemessa] ON [Implanta_CRPAM].[dbo].[DetalhesArquivoRemessa] 
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
SET @TableName = 'DetalhesArquivoRemessa'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDetalheArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdDetalheArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Vencimento, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Estornado IS NULL THEN ' Estornado : «Nulo» '
                                              WHEN  Estornado = 0 THEN ' Estornado : «Falso» '
                                              WHEN  Estornado = 1 THEN ' Estornado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdDetalheArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdDetalheArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Vencimento, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Estornado IS NULL THEN ' Estornado : «Nulo» '
                                              WHEN  Estornado = 0 THEN ' Estornado : «Falso» '
                                              WHEN  Estornado = 1 THEN ' Estornado : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdDetalheArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdDetalheArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Vencimento, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Estornado IS NULL THEN ' Estornado : «Nulo» '
                                              WHEN  Estornado = 0 THEN ' Estornado : «Falso» '
                                              WHEN  Estornado = 1 THEN ' Estornado : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDetalheArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdDetalheArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, Vencimento, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Estornado IS NULL THEN ' Estornado : «Nulo» '
                                              WHEN  Estornado = 0 THEN ' Estornado : «Falso» '
                                              WHEN  Estornado = 1 THEN ' Estornado : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
