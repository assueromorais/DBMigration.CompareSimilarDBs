CREATE TABLE [dbo].[Logradouros] (
    [IdLogradouro]    INT           IDENTITY (1, 1) NOT NULL,
    [Logradouro]      VARCHAR (120) NULL,
    [LogradouroAbrev] VARCHAR (50)  NULL,
    [LogComplemento]  VARCHAR (100) NULL,
    [LogTipo]         VARCHAR (50)  NULL,
    [CEP]             CHAR (8)      NULL,
    [IdBairro]        INT           NULL,
    [IdLogradouroDNE] INT           NULL,
    [Alterado]        BIT           CONSTRAINT [DEF_Logradouros_Alterado] DEFAULT ((0)) NOT NULL,
    [UsaLogTipo]      CHAR (1)      NULL,
    CONSTRAINT [PK_Logradouros] PRIMARY KEY CLUSTERED ([IdLogradouro] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_Logradouros_Bairros] FOREIGN KEY ([IdBairro]) REFERENCES [dbo].[Bairros] ([IdBairro])
);


GO
CREATE TRIGGER [TrgLog_Logradouros] ON [Implanta_CRPAM].[dbo].[Logradouros] 
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
SET @TableName = 'Logradouros'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLogradouro : «' + RTRIM( ISNULL( CAST (IdLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroAbrev : «' + RTRIM( ISNULL( CAST (LogradouroAbrev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogComplemento : «' + RTRIM( ISNULL( CAST (LogComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogTipo : «' + RTRIM( ISNULL( CAST (LogTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBairro : «' + RTRIM( ISNULL( CAST (IdBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLogradouroDNE : «' + RTRIM( ISNULL( CAST (IdLogradouroDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Alterado IS NULL THEN ' Alterado : «Nulo» '
                                              WHEN  Alterado = 0 THEN ' Alterado : «Falso» '
                                              WHEN  Alterado = 1 THEN ' Alterado : «Verdadeiro» '
                                    END 
                         + '| UsaLogTipo : «' + RTRIM( ISNULL( CAST (UsaLogTipo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLogradouro : «' + RTRIM( ISNULL( CAST (IdLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroAbrev : «' + RTRIM( ISNULL( CAST (LogradouroAbrev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogComplemento : «' + RTRIM( ISNULL( CAST (LogComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogTipo : «' + RTRIM( ISNULL( CAST (LogTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBairro : «' + RTRIM( ISNULL( CAST (IdBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLogradouroDNE : «' + RTRIM( ISNULL( CAST (IdLogradouroDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Alterado IS NULL THEN ' Alterado : «Nulo» '
                                              WHEN  Alterado = 0 THEN ' Alterado : «Falso» '
                                              WHEN  Alterado = 1 THEN ' Alterado : «Verdadeiro» '
                                    END 
                         + '| UsaLogTipo : «' + RTRIM( ISNULL( CAST (UsaLogTipo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLogradouro : «' + RTRIM( ISNULL( CAST (IdLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroAbrev : «' + RTRIM( ISNULL( CAST (LogradouroAbrev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogComplemento : «' + RTRIM( ISNULL( CAST (LogComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogTipo : «' + RTRIM( ISNULL( CAST (LogTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBairro : «' + RTRIM( ISNULL( CAST (IdBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLogradouroDNE : «' + RTRIM( ISNULL( CAST (IdLogradouroDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Alterado IS NULL THEN ' Alterado : «Nulo» '
                                              WHEN  Alterado = 0 THEN ' Alterado : «Falso» '
                                              WHEN  Alterado = 1 THEN ' Alterado : «Verdadeiro» '
                                    END 
                         + '| UsaLogTipo : «' + RTRIM( ISNULL( CAST (UsaLogTipo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLogradouro : «' + RTRIM( ISNULL( CAST (IdLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroAbrev : «' + RTRIM( ISNULL( CAST (LogradouroAbrev AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogComplemento : «' + RTRIM( ISNULL( CAST (LogComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogTipo : «' + RTRIM( ISNULL( CAST (LogTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBairro : «' + RTRIM( ISNULL( CAST (IdBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLogradouroDNE : «' + RTRIM( ISNULL( CAST (IdLogradouroDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Alterado IS NULL THEN ' Alterado : «Nulo» '
                                              WHEN  Alterado = 0 THEN ' Alterado : «Falso» '
                                              WHEN  Alterado = 1 THEN ' Alterado : «Verdadeiro» '
                                    END 
                         + '| UsaLogTipo : «' + RTRIM( ISNULL( CAST (UsaLogTipo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
