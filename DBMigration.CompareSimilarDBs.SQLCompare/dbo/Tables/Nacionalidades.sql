CREATE TABLE [dbo].[Nacionalidades] (
    [IdNacionalidade] INT          IDENTITY (1, 1) NOT NULL,
    [Nacionalidade]   VARCHAR (30) NOT NULL,
    [IndCricacaoWeb]  BIT          CONSTRAINT [DF_NacionalidadesIndCricacaoWeb] DEFAULT ((0)) NULL,
    [IndCriacaoWeb]   BIT          CONSTRAINT [DF_NacionalidadesIndCriacaoWeb] DEFAULT ((0)) NULL,
    [Desativado]      BIT          CONSTRAINT [DF_NacionalidadesDesativado] DEFAULT ((0)) NULL,
    [Pais]            VARCHAR (50) NULL,
    CONSTRAINT [PK_Nacionalidades] PRIMARY KEY NONCLUSTERED ([IdNacionalidade] ASC)
);


GO
CREATE TRIGGER [TrgLog_Nacionalidades] ON [Implanta_CRPAM].[dbo].[Nacionalidades] 
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
SET @TableName = 'Nacionalidades'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdNacionalidade : «' + RTRIM( ISNULL( CAST (IdNacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nacionalidade : «' + RTRIM( ISNULL( CAST (Nacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| Pais : «' + RTRIM( ISNULL( CAST (Pais AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdNacionalidade : «' + RTRIM( ISNULL( CAST (IdNacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nacionalidade : «' + RTRIM( ISNULL( CAST (Nacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| Pais : «' + RTRIM( ISNULL( CAST (Pais AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdNacionalidade : «' + RTRIM( ISNULL( CAST (IdNacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nacionalidade : «' + RTRIM( ISNULL( CAST (Nacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| Pais : «' + RTRIM( ISNULL( CAST (Pais AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdNacionalidade : «' + RTRIM( ISNULL( CAST (IdNacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nacionalidade : «' + RTRIM( ISNULL( CAST (Nacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| Pais : «' + RTRIM( ISNULL( CAST (Pais AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
