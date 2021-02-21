CREATE TABLE [dbo].[CentroCustos] (
    [IdCentroCusto]     INT          IDENTITY (1, 1) NOT NULL,
    [CodigoCentroCusto] VARCHAR (15) NOT NULL,
    [NomeCentroCusto]   VARCHAR (60) NULL,
    [Lock]              DATETIME     NULL,
    [Evento]            BIT          CONSTRAINT [DF__CentroCus__Event__2A212E2C] DEFAULT ((0)) NOT NULL,
    [EventoAtivo]       BIT          CONSTRAINT [DF__CentroCus__Event__0EAE4FAB] DEFAULT ((1)) NULL,
    [Exercicio]         VARCHAR (4)  NULL,
    CONSTRAINT [PK_CentroCustos] PRIMARY KEY NONCLUSTERED ([IdCentroCusto] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CentroCustosNomeCentroCusto]
    ON [dbo].[CentroCustos]([NomeCentroCusto] ASC, [Exercicio] ASC);


GO
CREATE TRIGGER [TrgLog_CentroCustos] ON [Implanta_CRPAM].[dbo].[CentroCustos] 
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
SET @TableName = 'CentroCustos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCentroCusto : «' + RTRIM( ISNULL( CAST (CodigoCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCentroCusto : «' + RTRIM( ISNULL( CAST (NomeCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Lock : «' + RTRIM( ISNULL( CONVERT (CHAR, Lock, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Evento IS NULL THEN ' Evento : «Nulo» '
                                              WHEN  Evento = 0 THEN ' Evento : «Falso» '
                                              WHEN  Evento = 1 THEN ' Evento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EventoAtivo IS NULL THEN ' EventoAtivo : «Nulo» '
                                              WHEN  EventoAtivo = 0 THEN ' EventoAtivo : «Falso» '
                                              WHEN  EventoAtivo = 1 THEN ' EventoAtivo : «Verdadeiro» '
                                    END 
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCentroCusto : «' + RTRIM( ISNULL( CAST (CodigoCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCentroCusto : «' + RTRIM( ISNULL( CAST (NomeCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Lock : «' + RTRIM( ISNULL( CONVERT (CHAR, Lock, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Evento IS NULL THEN ' Evento : «Nulo» '
                                              WHEN  Evento = 0 THEN ' Evento : «Falso» '
                                              WHEN  Evento = 1 THEN ' Evento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EventoAtivo IS NULL THEN ' EventoAtivo : «Nulo» '
                                              WHEN  EventoAtivo = 0 THEN ' EventoAtivo : «Falso» '
                                              WHEN  EventoAtivo = 1 THEN ' EventoAtivo : «Verdadeiro» '
                                    END 
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCentroCusto : «' + RTRIM( ISNULL( CAST (CodigoCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCentroCusto : «' + RTRIM( ISNULL( CAST (NomeCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Lock : «' + RTRIM( ISNULL( CONVERT (CHAR, Lock, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Evento IS NULL THEN ' Evento : «Nulo» '
                                              WHEN  Evento = 0 THEN ' Evento : «Falso» '
                                              WHEN  Evento = 1 THEN ' Evento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EventoAtivo IS NULL THEN ' EventoAtivo : «Nulo» '
                                              WHEN  EventoAtivo = 0 THEN ' EventoAtivo : «Falso» '
                                              WHEN  EventoAtivo = 1 THEN ' EventoAtivo : «Verdadeiro» '
                                    END 
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCentroCusto : «' + RTRIM( ISNULL( CAST (CodigoCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCentroCusto : «' + RTRIM( ISNULL( CAST (NomeCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Lock : «' + RTRIM( ISNULL( CONVERT (CHAR, Lock, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Evento IS NULL THEN ' Evento : «Nulo» '
                                              WHEN  Evento = 0 THEN ' Evento : «Falso» '
                                              WHEN  Evento = 1 THEN ' Evento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EventoAtivo IS NULL THEN ' EventoAtivo : «Nulo» '
                                              WHEN  EventoAtivo = 0 THEN ' EventoAtivo : «Falso» '
                                              WHEN  EventoAtivo = 1 THEN ' EventoAtivo : «Verdadeiro» '
                                    END 
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
