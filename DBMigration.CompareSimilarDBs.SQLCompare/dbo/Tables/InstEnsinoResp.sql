CREATE TABLE [dbo].[InstEnsinoResp] (
    [IdInstEnsinoResp] INT          IDENTITY (1, 1) NOT NULL,
    [IdInstEnsino]     INT          NULL,
    [IdResponsavel]    INT          NULL,
    [IdCargo]          INT          NULL,
    [DataInicio]       DATETIME     NULL,
    [DataFim]          DATETIME     NULL,
    [EhAtual]          BIT          NULL,
    [NomeResponsavel]  VARCHAR (80) NULL,
    PRIMARY KEY CLUSTERED ([IdInstEnsinoResp] ASC),
    CONSTRAINT [FK_InstEnsinoResp_IdCargo] FOREIGN KEY ([IdCargo]) REFERENCES [dbo].[Cargos] ([IdCargo]),
    CONSTRAINT [FK_InstEnsinoResp_IdInstEnsino] FOREIGN KEY ([IdInstEnsino]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_InstEnsinoResp_IdResponsavel] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
CREATE TRIGGER [TrgLog_InstEnsinoResp] ON [Implanta_CRPAM].[dbo].[InstEnsinoResp] 
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
SET @TableName = 'InstEnsinoResp'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdInstEnsinoResp : «' + RTRIM( ISNULL( CAST (IdInstEnsinoResp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInstEnsino : «' + RTRIM( ISNULL( CAST (IdInstEnsino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EhAtual IS NULL THEN ' EhAtual : «Nulo» '
                                              WHEN  EhAtual = 0 THEN ' EhAtual : «Falso» '
                                              WHEN  EhAtual = 1 THEN ' EhAtual : «Verdadeiro» '
                                    END 
                         + '| NomeResponsavel : «' + RTRIM( ISNULL( CAST (NomeResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdInstEnsinoResp : «' + RTRIM( ISNULL( CAST (IdInstEnsinoResp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInstEnsino : «' + RTRIM( ISNULL( CAST (IdInstEnsino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EhAtual IS NULL THEN ' EhAtual : «Nulo» '
                                              WHEN  EhAtual = 0 THEN ' EhAtual : «Falso» '
                                              WHEN  EhAtual = 1 THEN ' EhAtual : «Verdadeiro» '
                                    END 
                         + '| NomeResponsavel : «' + RTRIM( ISNULL( CAST (NomeResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdInstEnsinoResp : «' + RTRIM( ISNULL( CAST (IdInstEnsinoResp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInstEnsino : «' + RTRIM( ISNULL( CAST (IdInstEnsino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EhAtual IS NULL THEN ' EhAtual : «Nulo» '
                                              WHEN  EhAtual = 0 THEN ' EhAtual : «Falso» '
                                              WHEN  EhAtual = 1 THEN ' EhAtual : «Verdadeiro» '
                                    END 
                         + '| NomeResponsavel : «' + RTRIM( ISNULL( CAST (NomeResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdInstEnsinoResp : «' + RTRIM( ISNULL( CAST (IdInstEnsinoResp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInstEnsino : «' + RTRIM( ISNULL( CAST (IdInstEnsino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EhAtual IS NULL THEN ' EhAtual : «Nulo» '
                                              WHEN  EhAtual = 0 THEN ' EhAtual : «Falso» '
                                              WHEN  EhAtual = 1 THEN ' EhAtual : «Verdadeiro» '
                                    END 
                         + '| NomeResponsavel : «' + RTRIM( ISNULL( CAST (NomeResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
