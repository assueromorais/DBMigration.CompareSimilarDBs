CREATE TABLE [dbo].[OficioProcesso] (
    [IdOficioProcesso]  INT          IDENTITY (1, 1) NOT NULL,
    [IdProcesso]        INT          NOT NULL,
    [DataSessao]        DATETIME     NOT NULL,
    [HoraSessao]        DATETIME     NOT NULL,
    [DataHoraImpressao] DATETIME     NOT NULL,
    [UsuarioImpressao]  VARCHAR (30) NULL,
    [DeptoImpressao]    VARCHAR (60) NOT NULL,
    CONSTRAINT [PK_OficioProcesso_1] PRIMARY KEY CLUSTERED ([IdOficioProcesso] ASC, [IdProcesso] ASC),
    CONSTRAINT [FK_OficioProcesso_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso])
);


GO
CREATE TRIGGER [TrgLog_OficioProcesso] ON [Implanta_CRPAM].[dbo].[OficioProcesso] 
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
SET @TableName = 'OficioProcesso'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOficioProcesso : «' + RTRIM( ISNULL( CAST (IdOficioProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSessao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSessao, 113 ),'Nulo'))+'» '
                         + '| HoraSessao : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraSessao, 113 ),'Nulo'))+'» '
                         + '| DataHoraImpressao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraImpressao, 113 ),'Nulo'))+'» '
                         + '| UsuarioImpressao : «' + RTRIM( ISNULL( CAST (UsuarioImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DeptoImpressao : «' + RTRIM( ISNULL( CAST (DeptoImpressao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdOficioProcesso : «' + RTRIM( ISNULL( CAST (IdOficioProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSessao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSessao, 113 ),'Nulo'))+'» '
                         + '| HoraSessao : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraSessao, 113 ),'Nulo'))+'» '
                         + '| DataHoraImpressao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraImpressao, 113 ),'Nulo'))+'» '
                         + '| UsuarioImpressao : «' + RTRIM( ISNULL( CAST (UsuarioImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DeptoImpressao : «' + RTRIM( ISNULL( CAST (DeptoImpressao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdOficioProcesso : «' + RTRIM( ISNULL( CAST (IdOficioProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSessao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSessao, 113 ),'Nulo'))+'» '
                         + '| HoraSessao : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraSessao, 113 ),'Nulo'))+'» '
                         + '| DataHoraImpressao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraImpressao, 113 ),'Nulo'))+'» '
                         + '| UsuarioImpressao : «' + RTRIM( ISNULL( CAST (UsuarioImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DeptoImpressao : «' + RTRIM( ISNULL( CAST (DeptoImpressao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOficioProcesso : «' + RTRIM( ISNULL( CAST (IdOficioProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSessao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSessao, 113 ),'Nulo'))+'» '
                         + '| HoraSessao : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraSessao, 113 ),'Nulo'))+'» '
                         + '| DataHoraImpressao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraImpressao, 113 ),'Nulo'))+'» '
                         + '| UsuarioImpressao : «' + RTRIM( ISNULL( CAST (UsuarioImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DeptoImpressao : «' + RTRIM( ISNULL( CAST (DeptoImpressao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
