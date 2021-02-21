CREATE TABLE [dbo].[Licitacoes] (
    [IdLicitacao]      INT          IDENTITY (1, 1) NOT NULL,
    [IdModalidade]     INT          NOT NULL,
    [IdComissao]       INT          NOT NULL,
    [IdFaseAtual]      INT          NULL,
    [IdTipoLicitacao]  INT          NOT NULL,
    [NumeroLicitacao]  VARCHAR (20) NOT NULL,
    [DataEncerramento] DATETIME     NULL,
    [DataCancelamento] DATETIME     NULL,
    [Objeto]           TEXT         NULL,
    [DataInicio]       DATETIME     NOT NULL,
    [IdUnidade]        INT          NULL,
    [NumeroProcesso]   VARCHAR (20) NULL,
    [NumeroProtocolo]  VARCHAR (20) NULL,
    CONSTRAINT [PK_Licitacoes] PRIMARY KEY CLUSTERED ([IdLicitacao] ASC),
    CONSTRAINT [FK_Licitacoes_Comissoes] FOREIGN KEY ([IdComissao]) REFERENCES [dbo].[Comissoes] ([IdComissao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Licitacoes_Modalidades] FOREIGN KEY ([IdModalidade]) REFERENCES [dbo].[Modalidades] ([IdModalidade]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Licitacoes_TiposLicitacoes] FOREIGN KEY ([IdTipoLicitacao]) REFERENCES [dbo].[TiposLicitacoes] ([IdTipoLicitacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Licitacoes_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_Licitacoes] ON [Implanta_CRPAM].[dbo].[Licitacoes] 
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
SET @TableName = 'Licitacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidade : «' + RTRIM( ISNULL( CAST (IdModalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaseAtual : «' + RTRIM( ISNULL( CAST (IdFaseAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoLicitacao : «' + RTRIM( ISNULL( CAST (IdTipoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLicitacao : «' + RTRIM( ISNULL( CAST (NumeroLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEncerramento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEncerramento, 113 ),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidade : «' + RTRIM( ISNULL( CAST (IdModalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaseAtual : «' + RTRIM( ISNULL( CAST (IdFaseAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoLicitacao : «' + RTRIM( ISNULL( CAST (IdTipoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLicitacao : «' + RTRIM( ISNULL( CAST (NumeroLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEncerramento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEncerramento, 113 ),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidade : «' + RTRIM( ISNULL( CAST (IdModalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaseAtual : «' + RTRIM( ISNULL( CAST (IdFaseAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoLicitacao : «' + RTRIM( ISNULL( CAST (IdTipoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLicitacao : «' + RTRIM( ISNULL( CAST (NumeroLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEncerramento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEncerramento, 113 ),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidade : «' + RTRIM( ISNULL( CAST (IdModalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdComissao : «' + RTRIM( ISNULL( CAST (IdComissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFaseAtual : «' + RTRIM( ISNULL( CAST (IdFaseAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoLicitacao : «' + RTRIM( ISNULL( CAST (IdTipoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLicitacao : «' + RTRIM( ISNULL( CAST (NumeroLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEncerramento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEncerramento, 113 ),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
