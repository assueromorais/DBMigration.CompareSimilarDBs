CREATE TABLE [dbo].[AcervoResponsaveisTecnicos] (
    [IDAcervoResponsaveisTecnicos] INT IDENTITY (1, 1) NOT NULL,
    [IdAcervoTecnico]              INT NULL,
    [IdResponsavelTecnico]         INT NULL,
    [IdProfissional]               INT NULL,
    PRIMARY KEY CLUSTERED ([IDAcervoResponsaveisTecnicos] ASC),
    CONSTRAINT [FK_RIdAcervoTecnico] FOREIGN KEY ([IdAcervoTecnico]) REFERENCES [dbo].[AcervoTecnico] ([IdAcervoTecnico]),
    CONSTRAINT [FK_RIdProfissional] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_RIdResponsavelTecnico] FOREIGN KEY ([IdResponsavelTecnico]) REFERENCES [dbo].[ResponsaveisTecnicosPJ] ([IdResponsavelTecnico])
);


GO
CREATE TRIGGER [TrgLog_AcervoResponsaveisTecnicos] ON [Implanta_CRPAM].[dbo].[AcervoResponsaveisTecnicos] 
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
SET @TableName = 'AcervoResponsaveisTecnicos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IDAcervoResponsaveisTecnicos : «' + RTRIM( ISNULL( CAST (IDAcervoResponsaveisTecnicos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IDAcervoResponsaveisTecnicos : «' + RTRIM( ISNULL( CAST (IDAcervoResponsaveisTecnicos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IDAcervoResponsaveisTecnicos : «' + RTRIM( ISNULL( CAST (IDAcervoResponsaveisTecnicos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IDAcervoResponsaveisTecnicos : «' + RTRIM( ISNULL( CAST (IDAcervoResponsaveisTecnicos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
