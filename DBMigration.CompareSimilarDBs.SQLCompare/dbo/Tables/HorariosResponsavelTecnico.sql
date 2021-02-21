CREATE TABLE [dbo].[HorariosResponsavelTecnico] (
    [IdHorarioResponsavelTecnico] INT      IDENTITY (1, 1) NOT NULL,
    [IdResponsavelTecnico]        INT      NOT NULL,
    [DiaSemana]                   CHAR (1) NOT NULL,
    [HoraInicio]                  DATETIME NULL,
    [HoraFim]                     DATETIME NULL,
    CONSTRAINT [PK_HorariosResponsavelTecnico] PRIMARY KEY CLUSTERED ([IdHorarioResponsavelTecnico] ASC),
    CONSTRAINT [FK_HorariosResponsavelTecnico_ResponsaveisTecnicosPJ] FOREIGN KEY ([IdResponsavelTecnico]) REFERENCES [dbo].[ResponsaveisTecnicosPJ] ([IdResponsavelTecnico])
);


GO
CREATE TRIGGER [TrgLog_HorariosResponsavelTecnico] ON [Implanta_CRPAM].[dbo].[HorariosResponsavelTecnico] 
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
SET @TableName = 'HorariosResponsavelTecnico'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHorarioResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdHorarioResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaSemana : «' + RTRIM( ISNULL( CAST (DiaSemana AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraInicio, 113 ),'Nulo'))+'» '
                         + '| HoraFim : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraFim, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHorarioResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdHorarioResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaSemana : «' + RTRIM( ISNULL( CAST (DiaSemana AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraInicio, 113 ),'Nulo'))+'» '
                         + '| HoraFim : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraFim, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHorarioResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdHorarioResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaSemana : «' + RTRIM( ISNULL( CAST (DiaSemana AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraInicio, 113 ),'Nulo'))+'» '
                         + '| HoraFim : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraFim, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHorarioResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdHorarioResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelTecnico : «' + RTRIM( ISNULL( CAST (IdResponsavelTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaSemana : «' + RTRIM( ISNULL( CAST (DiaSemana AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraInicio, 113 ),'Nulo'))+'» '
                         + '| HoraFim : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraFim, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
