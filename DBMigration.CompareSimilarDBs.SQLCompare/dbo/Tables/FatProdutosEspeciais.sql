CREATE TABLE [dbo].[FatProdutosEspeciais] (
    [IdProduto]               INT          IDENTITY (1, 1) NOT NULL,
    [NomeProduto]             VARCHAR (60) NOT NULL,
    [DescricaoProduto]        TEXT         NULL,
    [ValorVenda]              MONEY        NULL,
    [DataUltAtualizacaoValor] DATETIME     NULL,
    [Ativo]                   BIT          CONSTRAINT [DF_FatProdutosEspeciais_Ativo] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_FatProdutosEspeciais] PRIMARY KEY CLUSTERED ([IdProduto] ASC)
);


GO
CREATE TRIGGER [TrgLog_FatProdutosEspeciais] ON [Implanta_CRPAM].[dbo].[FatProdutosEspeciais] 
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
SET @TableName = 'FatProdutosEspeciais'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdProduto : «' + RTRIM( ISNULL( CAST (IdProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeProduto : «' + RTRIM( ISNULL( CAST (NomeProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorVenda : «' + RTRIM( ISNULL( CAST (ValorVenda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltAtualizacaoValor : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltAtualizacaoValor, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdProduto : «' + RTRIM( ISNULL( CAST (IdProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeProduto : «' + RTRIM( ISNULL( CAST (NomeProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorVenda : «' + RTRIM( ISNULL( CAST (ValorVenda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltAtualizacaoValor : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltAtualizacaoValor, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdProduto : «' + RTRIM( ISNULL( CAST (IdProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeProduto : «' + RTRIM( ISNULL( CAST (NomeProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorVenda : «' + RTRIM( ISNULL( CAST (ValorVenda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltAtualizacaoValor : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltAtualizacaoValor, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdProduto : «' + RTRIM( ISNULL( CAST (IdProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeProduto : «' + RTRIM( ISNULL( CAST (NomeProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorVenda : «' + RTRIM( ISNULL( CAST (ValorVenda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltAtualizacaoValor : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltAtualizacaoValor, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
