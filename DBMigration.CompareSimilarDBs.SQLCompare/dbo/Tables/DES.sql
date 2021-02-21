CREATE TABLE [dbo].[DES] (
    [IdPagamento]       INT           NULL,
    [SerieDocumento]    VARCHAR (5)   NULL,
    [DataEmissao]       DATETIME      NULL,
    [CodServico]        VARCHAR (5)   NULL,
    [ObsDocumento]      VARCHAR (200) NULL,
    [IdDES]             INT           IDENTITY (1, 1) NOT NULL,
    [IdRestosPagamento] INT           NULL,
    [IdServico]         INT           NULL,
    [CidadeNota]        VARCHAR (30)  NULL,
    [SiglaUFNota]       VARCHAR (2)   NULL,
    CONSTRAINT [PK_DES] PRIMARY KEY NONCLUSTERED ([IdDES] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DES_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_DES_RestosPagamento] FOREIGN KEY ([IdRestosPagamento]) REFERENCES [dbo].[RestosPagamento] ([IdRestosPagamento]),
    CONSTRAINT [FK_DES_ServicosDES] FOREIGN KEY ([IdServico]) REFERENCES [dbo].[ServicosDES] ([IdServico])
);


GO
CREATE TRIGGER [TrgLog_DES] ON [Implanta_CRPAM].[dbo].[DES] 
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
SET @TableName = 'DES'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SerieDocumento : «' + RTRIM( ISNULL( CAST (SerieDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| CodServico : «' + RTRIM( ISNULL( CAST (CodServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ObsDocumento : «' + RTRIM( ISNULL( CAST (ObsDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDES : «' + RTRIM( ISNULL( CAST (IdDES AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CidadeNota : «' + RTRIM( ISNULL( CAST (CidadeNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUFNota : «' + RTRIM( ISNULL( CAST (SiglaUFNota AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SerieDocumento : «' + RTRIM( ISNULL( CAST (SerieDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| CodServico : «' + RTRIM( ISNULL( CAST (CodServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ObsDocumento : «' + RTRIM( ISNULL( CAST (ObsDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDES : «' + RTRIM( ISNULL( CAST (IdDES AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CidadeNota : «' + RTRIM( ISNULL( CAST (CidadeNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUFNota : «' + RTRIM( ISNULL( CAST (SiglaUFNota AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SerieDocumento : «' + RTRIM( ISNULL( CAST (SerieDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| CodServico : «' + RTRIM( ISNULL( CAST (CodServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ObsDocumento : «' + RTRIM( ISNULL( CAST (ObsDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDES : «' + RTRIM( ISNULL( CAST (IdDES AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CidadeNota : «' + RTRIM( ISNULL( CAST (CidadeNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUFNota : «' + RTRIM( ISNULL( CAST (SiglaUFNota AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SerieDocumento : «' + RTRIM( ISNULL( CAST (SerieDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| CodServico : «' + RTRIM( ISNULL( CAST (CodServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ObsDocumento : «' + RTRIM( ISNULL( CAST (ObsDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDES : «' + RTRIM( ISNULL( CAST (IdDES AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CidadeNota : «' + RTRIM( ISNULL( CAST (CidadeNota AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUFNota : «' + RTRIM( ISNULL( CAST (SiglaUFNota AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
