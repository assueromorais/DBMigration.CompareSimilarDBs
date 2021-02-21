CREATE TABLE [dbo].[AnB_ResultadoItensAnalisados] (
    [IdResultadoAnalise] INT          NOT NULL,
    [IdItemAnalisado]    SMALLINT     NOT NULL,
    [IdSituacaoAnalise]  TINYINT      NOT NULL,
    [IdTipoCorrecao]     TINYINT      NOT NULL,
    [DataInicio]         DATETIME     NOT NULL,
    [DataTermino]        DATETIME     NULL,
    [QtdeOcorrencias]    INT          NULL,
    [GeraRelatorio]      BIT          NULL,
    [OrdemExecucao]      SMALLINT     NULL,
    [VersaoAtualSistema] VARCHAR (10) NULL,
    [CorrecaoCompleta]   CHAR (1)     NULL,
    [QtdeCorrigidos]     INT          NULL,
    CONSTRAINT [PK_AnB_ResultadoItensAnalisados] PRIMARY KEY CLUSTERED ([IdResultadoAnalise] ASC, [IdItemAnalisado] ASC),
    CONSTRAINT [FK_AnB_ResultadoItensAnalisados_AnB_ItemAnalisado] FOREIGN KEY ([IdItemAnalisado]) REFERENCES [dbo].[AnB_ItemAnalisado] ([IdItemAnalisado]),
    CONSTRAINT [FK_AnB_ResultadoItensAnalisados_AnB_Resultado] FOREIGN KEY ([IdResultadoAnalise]) REFERENCES [dbo].[AnB_Resultado] ([IdResultadoAnalise]),
    CONSTRAINT [FK_AnB_ResultadoItensAnalisados_Anb_SituacaoAnalise] FOREIGN KEY ([IdSituacaoAnalise]) REFERENCES [dbo].[AnB_SituacaoAnalise] ([IdSituacaoAnalise]),
    CONSTRAINT [FK_AnB_ResultadoItensAnalisados_AnB_TipoCorrecao] FOREIGN KEY ([IdTipoCorrecao]) REFERENCES [dbo].[AnB_TipoCorrecao] ([IdTipoCorrecao])
);


GO
CREATE TRIGGER [TrgLog_AnB_ResultadoItensAnalisados] ON [Implanta_CRPAM].[dbo].[AnB_ResultadoItensAnalisados] 
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
SET @TableName = 'AnB_ResultadoItensAnalisados'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAnalise : «' + RTRIM( ISNULL( CAST (IdSituacaoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoCorrecao : «' + RTRIM( ISNULL( CAST (IdTipoCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| QtdeOcorrencias : «' + RTRIM( ISNULL( CAST (QtdeOcorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraRelatorio IS NULL THEN ' GeraRelatorio : «Nulo» '
                                              WHEN  GeraRelatorio = 0 THEN ' GeraRelatorio : «Falso» '
                                              WHEN  GeraRelatorio = 1 THEN ' GeraRelatorio : «Verdadeiro» '
                                    END 
                         + '| OrdemExecucao : «' + RTRIM( ISNULL( CAST (OrdemExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoAtualSistema : «' + RTRIM( ISNULL( CAST (VersaoAtualSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorrecaoCompleta : «' + RTRIM( ISNULL( CAST (CorrecaoCompleta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCorrigidos : «' + RTRIM( ISNULL( CAST (QtdeCorrigidos AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAnalise : «' + RTRIM( ISNULL( CAST (IdSituacaoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoCorrecao : «' + RTRIM( ISNULL( CAST (IdTipoCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| QtdeOcorrencias : «' + RTRIM( ISNULL( CAST (QtdeOcorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraRelatorio IS NULL THEN ' GeraRelatorio : «Nulo» '
                                              WHEN  GeraRelatorio = 0 THEN ' GeraRelatorio : «Falso» '
                                              WHEN  GeraRelatorio = 1 THEN ' GeraRelatorio : «Verdadeiro» '
                                    END 
                         + '| OrdemExecucao : «' + RTRIM( ISNULL( CAST (OrdemExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoAtualSistema : «' + RTRIM( ISNULL( CAST (VersaoAtualSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorrecaoCompleta : «' + RTRIM( ISNULL( CAST (CorrecaoCompleta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCorrigidos : «' + RTRIM( ISNULL( CAST (QtdeCorrigidos AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAnalise : «' + RTRIM( ISNULL( CAST (IdSituacaoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoCorrecao : «' + RTRIM( ISNULL( CAST (IdTipoCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| QtdeOcorrencias : «' + RTRIM( ISNULL( CAST (QtdeOcorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraRelatorio IS NULL THEN ' GeraRelatorio : «Nulo» '
                                              WHEN  GeraRelatorio = 0 THEN ' GeraRelatorio : «Falso» '
                                              WHEN  GeraRelatorio = 1 THEN ' GeraRelatorio : «Verdadeiro» '
                                    END 
                         + '| OrdemExecucao : «' + RTRIM( ISNULL( CAST (OrdemExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoAtualSistema : «' + RTRIM( ISNULL( CAST (VersaoAtualSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorrecaoCompleta : «' + RTRIM( ISNULL( CAST (CorrecaoCompleta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCorrigidos : «' + RTRIM( ISNULL( CAST (QtdeCorrigidos AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAnalise : «' + RTRIM( ISNULL( CAST (IdSituacaoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoCorrecao : «' + RTRIM( ISNULL( CAST (IdTipoCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| QtdeOcorrencias : «' + RTRIM( ISNULL( CAST (QtdeOcorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraRelatorio IS NULL THEN ' GeraRelatorio : «Nulo» '
                                              WHEN  GeraRelatorio = 0 THEN ' GeraRelatorio : «Falso» '
                                              WHEN  GeraRelatorio = 1 THEN ' GeraRelatorio : «Verdadeiro» '
                                    END 
                         + '| OrdemExecucao : «' + RTRIM( ISNULL( CAST (OrdemExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoAtualSistema : «' + RTRIM( ISNULL( CAST (VersaoAtualSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CorrecaoCompleta : «' + RTRIM( ISNULL( CAST (CorrecaoCompleta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeCorrigidos : «' + RTRIM( ISNULL( CAST (QtdeCorrigidos AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
