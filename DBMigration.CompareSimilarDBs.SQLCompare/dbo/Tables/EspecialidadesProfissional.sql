CREATE TABLE [dbo].[EspecialidadesProfissional] (
    [IdProfissional]           INT            NOT NULL,
    [IdEspecialidade]          INT            NOT NULL,
    [NumeroPlenaria]           VARCHAR (10)   NULL,
    [DataPlenaria]             DATETIME       NULL,
    [DtInicioEspecializacao]   DATETIME       NULL,
    [DtFimEspecializacao]      DATETIME       NULL,
    [NumRegistroEspecialidade] INT            NULL,
    [AtualizacaoWeb]           VARCHAR (8000) NULL,
    [EspecialidadeDivulgacao]  BIT            DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_EspecialidadesProfissional] PRIMARY KEY NONCLUSTERED ([IdProfissional] ASC, [IdEspecialidade] ASC),
    CONSTRAINT [FK_EspecialidadesProfissionais_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_EspecialidadesProfissional_Especialidade] FOREIGN KEY ([IdEspecialidade]) REFERENCES [dbo].[Especialidades] ([IdEspecialidade]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_EspecialidadesProfissional] ON [Implanta_CRPAM].[dbo].[EspecialidadesProfissional] 
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
SET @TableName = 'EspecialidadesProfissional'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEspecialidade : «' + RTRIM( ISNULL( CAST (IdEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPlenaria : «' + RTRIM( ISNULL( CAST (NumeroPlenaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPlenaria : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPlenaria, 113 ),'Nulo'))+'» '
                         + '| DtInicioEspecializacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioEspecializacao, 113 ),'Nulo'))+'» '
                         + '| DtFimEspecializacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtFimEspecializacao, 113 ),'Nulo'))+'» '
                         + '| NumRegistroEspecialidade : «' + RTRIM( ISNULL( CAST (NumRegistroEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EspecialidadeDivulgacao IS NULL THEN ' EspecialidadeDivulgacao : «Nulo» '
                                              WHEN  EspecialidadeDivulgacao = 0 THEN ' EspecialidadeDivulgacao : «Falso» '
                                              WHEN  EspecialidadeDivulgacao = 1 THEN ' EspecialidadeDivulgacao : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEspecialidade : «' + RTRIM( ISNULL( CAST (IdEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPlenaria : «' + RTRIM( ISNULL( CAST (NumeroPlenaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPlenaria : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPlenaria, 113 ),'Nulo'))+'» '
                         + '| DtInicioEspecializacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioEspecializacao, 113 ),'Nulo'))+'» '
                         + '| DtFimEspecializacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtFimEspecializacao, 113 ),'Nulo'))+'» '
                         + '| NumRegistroEspecialidade : «' + RTRIM( ISNULL( CAST (NumRegistroEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EspecialidadeDivulgacao IS NULL THEN ' EspecialidadeDivulgacao : «Nulo» '
                                              WHEN  EspecialidadeDivulgacao = 0 THEN ' EspecialidadeDivulgacao : «Falso» '
                                              WHEN  EspecialidadeDivulgacao = 1 THEN ' EspecialidadeDivulgacao : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEspecialidade : «' + RTRIM( ISNULL( CAST (IdEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPlenaria : «' + RTRIM( ISNULL( CAST (NumeroPlenaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPlenaria : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPlenaria, 113 ),'Nulo'))+'» '
                         + '| DtInicioEspecializacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioEspecializacao, 113 ),'Nulo'))+'» '
                         + '| DtFimEspecializacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtFimEspecializacao, 113 ),'Nulo'))+'» '
                         + '| NumRegistroEspecialidade : «' + RTRIM( ISNULL( CAST (NumRegistroEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EspecialidadeDivulgacao IS NULL THEN ' EspecialidadeDivulgacao : «Nulo» '
                                              WHEN  EspecialidadeDivulgacao = 0 THEN ' EspecialidadeDivulgacao : «Falso» '
                                              WHEN  EspecialidadeDivulgacao = 1 THEN ' EspecialidadeDivulgacao : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEspecialidade : «' + RTRIM( ISNULL( CAST (IdEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPlenaria : «' + RTRIM( ISNULL( CAST (NumeroPlenaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPlenaria : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPlenaria, 113 ),'Nulo'))+'» '
                         + '| DtInicioEspecializacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInicioEspecializacao, 113 ),'Nulo'))+'» '
                         + '| DtFimEspecializacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtFimEspecializacao, 113 ),'Nulo'))+'» '
                         + '| NumRegistroEspecialidade : «' + RTRIM( ISNULL( CAST (NumRegistroEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EspecialidadeDivulgacao IS NULL THEN ' EspecialidadeDivulgacao : «Nulo» '
                                              WHEN  EspecialidadeDivulgacao = 0 THEN ' EspecialidadeDivulgacao : «Falso» '
                                              WHEN  EspecialidadeDivulgacao = 1 THEN ' EspecialidadeDivulgacao : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
