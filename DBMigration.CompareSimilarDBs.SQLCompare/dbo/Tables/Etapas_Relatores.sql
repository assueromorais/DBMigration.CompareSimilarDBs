﻿CREATE TABLE [dbo].[Etapas_Relatores] (
    [IdEtapa_Relator] INT IDENTITY (1, 1) NOT NULL,
    [IdProfissional]  INT NOT NULL,
    [IdEtapa]         INT NOT NULL,
    [AnoDistribuicao] INT NULL,
    CONSTRAINT [PK_Etapas_Relatores] PRIMARY KEY CLUSTERED ([IdEtapa_Relator] ASC),
    CONSTRAINT [FK_Etapas_Relatores_Etapas] FOREIGN KEY ([IdEtapa]) REFERENCES [dbo].[Etapas] ([IdEtapa]),
    CONSTRAINT [FK_Etapas_Relatores_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_Etapas_Relatores] ON [Implanta_CRPAM].[dbo].[Etapas_Relatores] 
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
SET @TableName = 'Etapas_Relatores'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEtapa_Relator : «' + RTRIM( ISNULL( CAST (IdEtapa_Relator AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoDistribuicao : «' + RTRIM( ISNULL( CAST (AnoDistribuicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEtapa_Relator : «' + RTRIM( ISNULL( CAST (IdEtapa_Relator AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoDistribuicao : «' + RTRIM( ISNULL( CAST (AnoDistribuicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEtapa_Relator : «' + RTRIM( ISNULL( CAST (IdEtapa_Relator AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoDistribuicao : «' + RTRIM( ISNULL( CAST (AnoDistribuicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEtapa_Relator : «' + RTRIM( ISNULL( CAST (IdEtapa_Relator AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoDistribuicao : «' + RTRIM( ISNULL( CAST (AnoDistribuicao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
