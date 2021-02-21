CREATE TABLE [dbo].[ComissaoConselho] (
    [IdComissaoConselho] INT            IDENTITY (1, 1) NOT NULL,
    [IdUnidade]          INT            NULL,
    [DataInicio]         DATETIME       NULL,
    [DataTermino]        DATETIME       NULL,
    [Finalidade]         NVARCHAR (500) NULL,
    [Permanente]         BIT            DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ComissaoConselho] PRIMARY KEY CLUSTERED ([IdComissaoConselho] ASC),
    CONSTRAINT [FK_ComissaoConselho_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);


GO
CREATE TRIGGER [TrgLog_ComissaoConselho] ON [Implanta_CRPAM].[dbo].[ComissaoConselho] 
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
SET @TableName = 'ComissaoConselho'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdComissaoConselho : «' + RTRIM( ISNULL( CAST (IdComissaoConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Permanente IS NULL THEN ' Permanente : «Nulo» '
                                              WHEN  Permanente = 0 THEN ' Permanente : «Falso» '
                                              WHEN  Permanente = 1 THEN ' Permanente : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdComissaoConselho : «' + RTRIM( ISNULL( CAST (IdComissaoConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Permanente IS NULL THEN ' Permanente : «Nulo» '
                                              WHEN  Permanente = 0 THEN ' Permanente : «Falso» '
                                              WHEN  Permanente = 1 THEN ' Permanente : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdComissaoConselho : «' + RTRIM( ISNULL( CAST (IdComissaoConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Permanente IS NULL THEN ' Permanente : «Nulo» '
                                              WHEN  Permanente = 0 THEN ' Permanente : «Falso» '
                                              WHEN  Permanente = 1 THEN ' Permanente : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdComissaoConselho : «' + RTRIM( ISNULL( CAST (IdComissaoConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Permanente IS NULL THEN ' Permanente : «Nulo» '
                                              WHEN  Permanente = 0 THEN ' Permanente : «Falso» '
                                              WHEN  Permanente = 1 THEN ' Permanente : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
