CREATE TABLE [dbo].[AssociacoesPagamentos] (
    [IdAssociacaoPagamento] INT      IDENTITY (1, 1) NOT NULL,
    [IdTipoPagtoAssociacao] INT      NULL,
    [IdPagamento]           INT      NULL,
    [DataReferenciaInicio]  DATETIME NULL,
    [DataReferenciaFim]     DATETIME NULL,
    [IdRestosPagamento]     INT      NULL,
    CONSTRAINT [PK_AssociacoesPagamentos] PRIMARY KEY NONCLUSTERED ([IdAssociacaoPagamento] ASC)
);


GO
CREATE TRIGGER [TrgLog_AssociacoesPagamentos] ON [Implanta_CRPAM].[dbo].[AssociacoesPagamentos] 
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
SET @TableName = 'AssociacoesPagamentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAssociacaoPagamento : «' + RTRIM( ISNULL( CAST (IdAssociacaoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagtoAssociacao : «' + RTRIM( ISNULL( CAST (IdTipoPagtoAssociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaInicio, 113 ),'Nulo'))+'» '
                         + '| DataReferenciaFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaFim, 113 ),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAssociacaoPagamento : «' + RTRIM( ISNULL( CAST (IdAssociacaoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagtoAssociacao : «' + RTRIM( ISNULL( CAST (IdTipoPagtoAssociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaInicio, 113 ),'Nulo'))+'» '
                         + '| DataReferenciaFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaFim, 113 ),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAssociacaoPagamento : «' + RTRIM( ISNULL( CAST (IdAssociacaoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagtoAssociacao : «' + RTRIM( ISNULL( CAST (IdTipoPagtoAssociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaInicio, 113 ),'Nulo'))+'» '
                         + '| DataReferenciaFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaFim, 113 ),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAssociacaoPagamento : «' + RTRIM( ISNULL( CAST (IdAssociacaoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagtoAssociacao : «' + RTRIM( ISNULL( CAST (IdTipoPagtoAssociacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaInicio, 113 ),'Nulo'))+'» '
                         + '| DataReferenciaFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaFim, 113 ),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
