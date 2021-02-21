CREATE TABLE [dbo].[ExameOrdem] (
    [IdExame]         INT           IDENTITY (1, 1) NOT NULL,
    [DataExame]       DATETIME      NULL,
    [Descricao]       VARCHAR (50)  NULL,
    [DataInicio]      DATETIME      NULL,
    [DataTermino]     DATETIME      NULL,
    [MaxInscritos]    INT           NULL,
    [IdSituacaoExame] INT           NULL,
    [Observacoes]     TEXT          NULL,
    [Gabarito]        VARCHAR (100) NULL,
    [AnoSemestre]     VARCHAR (7)   NULL,
    CONSTRAINT [PK_ExameOrdem] PRIMARY KEY CLUSTERED ([IdExame] ASC),
    CONSTRAINT [FK_ExameOrdem_SituacoesExameOrdem] FOREIGN KEY ([IdSituacaoExame]) REFERENCES [dbo].[SituacoesExameOrdem] ([IdSituacaoExame])
);


GO
CREATE TRIGGER [TrgLog_ExameOrdem] ON [Implanta_CRPAM].[dbo].[ExameOrdem] 
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
SET @TableName = 'ExameOrdem'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExame : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExame, 113 ),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| MaxInscritos : «' + RTRIM( ISNULL( CAST (MaxInscritos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoExame : «' + RTRIM( ISNULL( CAST (IdSituacaoExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Gabarito : «' + RTRIM( ISNULL( CAST (Gabarito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoSemestre : «' + RTRIM( ISNULL( CAST (AnoSemestre AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExame : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExame, 113 ),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| MaxInscritos : «' + RTRIM( ISNULL( CAST (MaxInscritos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoExame : «' + RTRIM( ISNULL( CAST (IdSituacaoExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Gabarito : «' + RTRIM( ISNULL( CAST (Gabarito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoSemestre : «' + RTRIM( ISNULL( CAST (AnoSemestre AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExame : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExame, 113 ),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| MaxInscritos : «' + RTRIM( ISNULL( CAST (MaxInscritos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoExame : «' + RTRIM( ISNULL( CAST (IdSituacaoExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Gabarito : «' + RTRIM( ISNULL( CAST (Gabarito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoSemestre : «' + RTRIM( ISNULL( CAST (AnoSemestre AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExame : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExame, 113 ),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| MaxInscritos : «' + RTRIM( ISNULL( CAST (MaxInscritos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoExame : «' + RTRIM( ISNULL( CAST (IdSituacaoExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Gabarito : «' + RTRIM( ISNULL( CAST (Gabarito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoSemestre : «' + RTRIM( ISNULL( CAST (AnoSemestre AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
