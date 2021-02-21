CREATE TABLE [dbo].[OcorrenciasSiscafw] (
    [IdOcorrencia]  INT          IDENTITY (1, 1) NOT NULL,
    [Ocorrencia]    VARCHAR (60) NOT NULL,
    [ExibirTela]    BIT          NULL,
    [TextoExibicao] VARCHAR (20) NULL,
    [IndVisitacao]  BIT          DEFAULT ((0)) NOT NULL,
    [IdFederal]     INT          NULL,
    CONSTRAINT [PK_OcorrenciasSiscafw] PRIMARY KEY CLUSTERED ([IdOcorrencia] ASC)
);


GO
CREATE TRIGGER [TrgLog_OcorrenciasSiscafw] ON [Implanta_CRPAM].[dbo].[OcorrenciasSiscafw] 
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
SET @TableName = 'OcorrenciasSiscafw'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ocorrencia : «' + RTRIM( ISNULL( CAST (Ocorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirTela IS NULL THEN ' ExibirTela : «Nulo» '
                                              WHEN  ExibirTela = 0 THEN ' ExibirTela : «Falso» '
                                              WHEN  ExibirTela = 1 THEN ' ExibirTela : «Verdadeiro» '
                                    END 
                         + '| TextoExibicao : «' + RTRIM( ISNULL( CAST (TextoExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndVisitacao IS NULL THEN ' IndVisitacao : «Nulo» '
                                              WHEN  IndVisitacao = 0 THEN ' IndVisitacao : «Falso» '
                                              WHEN  IndVisitacao = 1 THEN ' IndVisitacao : «Verdadeiro» '
                                    END 
                         + '| IdFederal : «' + RTRIM( ISNULL( CAST (IdFederal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ocorrencia : «' + RTRIM( ISNULL( CAST (Ocorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirTela IS NULL THEN ' ExibirTela : «Nulo» '
                                              WHEN  ExibirTela = 0 THEN ' ExibirTela : «Falso» '
                                              WHEN  ExibirTela = 1 THEN ' ExibirTela : «Verdadeiro» '
                                    END 
                         + '| TextoExibicao : «' + RTRIM( ISNULL( CAST (TextoExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndVisitacao IS NULL THEN ' IndVisitacao : «Nulo» '
                                              WHEN  IndVisitacao = 0 THEN ' IndVisitacao : «Falso» '
                                              WHEN  IndVisitacao = 1 THEN ' IndVisitacao : «Verdadeiro» '
                                    END 
                         + '| IdFederal : «' + RTRIM( ISNULL( CAST (IdFederal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ocorrencia : «' + RTRIM( ISNULL( CAST (Ocorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirTela IS NULL THEN ' ExibirTela : «Nulo» '
                                              WHEN  ExibirTela = 0 THEN ' ExibirTela : «Falso» '
                                              WHEN  ExibirTela = 1 THEN ' ExibirTela : «Verdadeiro» '
                                    END 
                         + '| TextoExibicao : «' + RTRIM( ISNULL( CAST (TextoExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndVisitacao IS NULL THEN ' IndVisitacao : «Nulo» '
                                              WHEN  IndVisitacao = 0 THEN ' IndVisitacao : «Falso» '
                                              WHEN  IndVisitacao = 1 THEN ' IndVisitacao : «Verdadeiro» '
                                    END 
                         + '| IdFederal : «' + RTRIM( ISNULL( CAST (IdFederal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ocorrencia : «' + RTRIM( ISNULL( CAST (Ocorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirTela IS NULL THEN ' ExibirTela : «Nulo» '
                                              WHEN  ExibirTela = 0 THEN ' ExibirTela : «Falso» '
                                              WHEN  ExibirTela = 1 THEN ' ExibirTela : «Verdadeiro» '
                                    END 
                         + '| TextoExibicao : «' + RTRIM( ISNULL( CAST (TextoExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndVisitacao IS NULL THEN ' IndVisitacao : «Nulo» '
                                              WHEN  IndVisitacao = 0 THEN ' IndVisitacao : «Falso» '
                                              WHEN  IndVisitacao = 1 THEN ' IndVisitacao : «Verdadeiro» '
                                    END 
                         + '| IdFederal : «' + RTRIM( ISNULL( CAST (IdFederal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
