CREATE TABLE [dbo].[HistValoresCampo] (
    [IdHistValorCampo]      INT           IDENTITY (1, 1) NOT NULL,
    [IdValorAtualizacao]    INT           NOT NULL,
    [ValorCampo]            VARCHAR (200) NOT NULL,
    [CodigoIdCampo]         VARCHAR (100) NOT NULL,
    [IdDetalhe]             INT           NULL,
    [AplicarRelacionamento] BIT           CONSTRAINT [DF__HistValor__Aplic__1885CB5B] DEFAULT ((1)) NOT NULL,
    [CodigoIdCampoDetalhe]  VARCHAR (100) NULL,
    [ValorCampoDetalhe]     VARCHAR (200) NULL,
    CONSTRAINT [Pk_HistValoresCampo] PRIMARY KEY CLUSTERED ([IdHistValorCampo] ASC),
    CONSTRAINT [FL_005] FOREIGN KEY ([IdValorAtualizacao]) REFERENCES [dbo].[ValoresAtualizacao] ([IdValorAtualizacao]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FL_006] FOREIGN KEY ([IdDetalhe]) REFERENCES [dbo].[ValoresAtualizacao] ([IdValorAtualizacao])
);


GO
CREATE TRIGGER [TrgLog_HistValoresCampo] ON [Implanta_CRPAM].[dbo].[HistValoresCampo] 
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
SET @TableName = 'HistValoresCampo'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistValorCampo : «' + RTRIM( ISNULL( CAST (IdHistValorCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtualizacao : «' + RTRIM( ISNULL( CAST (IdValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCampo : «' + RTRIM( ISNULL( CAST (ValorCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoIdCampo : «' + RTRIM( ISNULL( CAST (CodigoIdCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalhe : «' + RTRIM( ISNULL( CAST (IdDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarRelacionamento IS NULL THEN ' AplicarRelacionamento : «Nulo» '
                                              WHEN  AplicarRelacionamento = 0 THEN ' AplicarRelacionamento : «Falso» '
                                              WHEN  AplicarRelacionamento = 1 THEN ' AplicarRelacionamento : «Verdadeiro» '
                                    END 
                         + '| CodigoIdCampoDetalhe : «' + RTRIM( ISNULL( CAST (CodigoIdCampoDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCampoDetalhe : «' + RTRIM( ISNULL( CAST (ValorCampoDetalhe AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistValorCampo : «' + RTRIM( ISNULL( CAST (IdHistValorCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtualizacao : «' + RTRIM( ISNULL( CAST (IdValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCampo : «' + RTRIM( ISNULL( CAST (ValorCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoIdCampo : «' + RTRIM( ISNULL( CAST (CodigoIdCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalhe : «' + RTRIM( ISNULL( CAST (IdDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarRelacionamento IS NULL THEN ' AplicarRelacionamento : «Nulo» '
                                              WHEN  AplicarRelacionamento = 0 THEN ' AplicarRelacionamento : «Falso» '
                                              WHEN  AplicarRelacionamento = 1 THEN ' AplicarRelacionamento : «Verdadeiro» '
                                    END 
                         + '| CodigoIdCampoDetalhe : «' + RTRIM( ISNULL( CAST (CodigoIdCampoDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCampoDetalhe : «' + RTRIM( ISNULL( CAST (ValorCampoDetalhe AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistValorCampo : «' + RTRIM( ISNULL( CAST (IdHistValorCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtualizacao : «' + RTRIM( ISNULL( CAST (IdValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCampo : «' + RTRIM( ISNULL( CAST (ValorCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoIdCampo : «' + RTRIM( ISNULL( CAST (CodigoIdCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalhe : «' + RTRIM( ISNULL( CAST (IdDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarRelacionamento IS NULL THEN ' AplicarRelacionamento : «Nulo» '
                                              WHEN  AplicarRelacionamento = 0 THEN ' AplicarRelacionamento : «Falso» '
                                              WHEN  AplicarRelacionamento = 1 THEN ' AplicarRelacionamento : «Verdadeiro» '
                                    END 
                         + '| CodigoIdCampoDetalhe : «' + RTRIM( ISNULL( CAST (CodigoIdCampoDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCampoDetalhe : «' + RTRIM( ISNULL( CAST (ValorCampoDetalhe AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistValorCampo : «' + RTRIM( ISNULL( CAST (IdHistValorCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdValorAtualizacao : «' + RTRIM( ISNULL( CAST (IdValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCampo : «' + RTRIM( ISNULL( CAST (ValorCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoIdCampo : «' + RTRIM( ISNULL( CAST (CodigoIdCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalhe : «' + RTRIM( ISNULL( CAST (IdDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AplicarRelacionamento IS NULL THEN ' AplicarRelacionamento : «Nulo» '
                                              WHEN  AplicarRelacionamento = 0 THEN ' AplicarRelacionamento : «Falso» '
                                              WHEN  AplicarRelacionamento = 1 THEN ' AplicarRelacionamento : «Verdadeiro» '
                                    END 
                         + '| CodigoIdCampoDetalhe : «' + RTRIM( ISNULL( CAST (CodigoIdCampoDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCampoDetalhe : «' + RTRIM( ISNULL( CAST (ValorCampoDetalhe AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
