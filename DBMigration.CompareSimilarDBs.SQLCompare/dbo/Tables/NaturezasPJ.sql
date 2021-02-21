CREATE TABLE [dbo].[NaturezasPJ] (
    [IdNaturezaPJ]   INT           IDENTITY (1, 1) NOT NULL,
    [NaturezaPJ]     VARCHAR (100) NULL,
    [IndCricacaoWeb] BIT           NULL,
    [Desativado]     BIT           CONSTRAINT [DF_NaturezasPJDesativado] DEFAULT ((0)) NULL,
    [IndCriacaoWeb]  BIT           NULL,
    CONSTRAINT [PK_NaturezasPJ] PRIMARY KEY CLUSTERED ([IdNaturezaPJ] ASC)
);


GO
CREATE TRIGGER [TrgLog_NaturezasPJ] ON [Implanta_CRPAM].[dbo].[NaturezasPJ] 
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
SET @TableName = 'NaturezasPJ'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdNaturezaPJ : «' + RTRIM( ISNULL( CAST (IdNaturezaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NaturezaPJ : «' + RTRIM( ISNULL( CAST (NaturezaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdNaturezaPJ : «' + RTRIM( ISNULL( CAST (IdNaturezaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NaturezaPJ : «' + RTRIM( ISNULL( CAST (NaturezaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdNaturezaPJ : «' + RTRIM( ISNULL( CAST (IdNaturezaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NaturezaPJ : «' + RTRIM( ISNULL( CAST (NaturezaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdNaturezaPJ : «' + RTRIM( ISNULL( CAST (IdNaturezaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NaturezaPJ : «' + RTRIM( ISNULL( CAST (NaturezaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
