CREATE TABLE [dbo].[AnB_ItemAnalisado] (
    [IdItemAnalisado] SMALLINT       NOT NULL,
    [Descricao]       VARCHAR (100)  NULL,
    [OrdemExecucao]   SMALLINT       NULL,
    [Ativo]           BIT            NULL,
    [ComandoSQL]      VARCHAR (255)  NULL,
    [IdAssunto]       SMALLINT       NULL,
    [GeraRelatorio]   BIT            NULL,
    [IdTipoCorrecao]  TINYINT        NULL,
    [MostraCliente]   BIT            NULL,
    [NotaExplicativa] VARCHAR (1000) NULL,
    [IdCorrecao]      INT            NULL,
    CONSTRAINT [PK_AnB_ItemAnalisado] PRIMARY KEY CLUSTERED ([IdItemAnalisado] ASC),
    CONSTRAINT [FK_AnB_ItemAnalisado_Anb_Assunto] FOREIGN KEY ([IdAssunto]) REFERENCES [dbo].[Anb_Assunto] ([IdAssunto]),
    CONSTRAINT [FK_AnB_ItemAnalisado_Anb_Correcao] FOREIGN KEY ([IdCorrecao]) REFERENCES [dbo].[Anb_Correcao] ([IdCorrecao]),
    CONSTRAINT [FK_AnB_ItemAnalisado_AnB_TipoCorrecao] FOREIGN KEY ([IdTipoCorrecao]) REFERENCES [dbo].[AnB_TipoCorrecao] ([IdTipoCorrecao])
);


GO
CREATE TRIGGER [TrgLog_AnB_ItemAnalisado] ON [Implanta_CRPAM].[dbo].[AnB_ItemAnalisado] 
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
SET @TableName = 'AnB_ItemAnalisado'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemExecucao : «' + RTRIM( ISNULL( CAST (OrdemExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| ComandoSQL : «' + RTRIM( ISNULL( CAST (ComandoSQL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssunto : «' + RTRIM( ISNULL( CAST (IdAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraRelatorio IS NULL THEN ' GeraRelatorio : «Nulo» '
                                              WHEN  GeraRelatorio = 0 THEN ' GeraRelatorio : «Falso» '
                                              WHEN  GeraRelatorio = 1 THEN ' GeraRelatorio : «Verdadeiro» '
                                    END 
                         + '| IdTipoCorrecao : «' + RTRIM( ISNULL( CAST (IdTipoCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraCliente IS NULL THEN ' MostraCliente : «Nulo» '
                                              WHEN  MostraCliente = 0 THEN ' MostraCliente : «Falso» '
                                              WHEN  MostraCliente = 1 THEN ' MostraCliente : «Verdadeiro» '
                                    END 
                         + '| NotaExplicativa : «' + RTRIM( ISNULL( CAST (NotaExplicativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemExecucao : «' + RTRIM( ISNULL( CAST (OrdemExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| ComandoSQL : «' + RTRIM( ISNULL( CAST (ComandoSQL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssunto : «' + RTRIM( ISNULL( CAST (IdAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraRelatorio IS NULL THEN ' GeraRelatorio : «Nulo» '
                                              WHEN  GeraRelatorio = 0 THEN ' GeraRelatorio : «Falso» '
                                              WHEN  GeraRelatorio = 1 THEN ' GeraRelatorio : «Verdadeiro» '
                                    END 
                         + '| IdTipoCorrecao : «' + RTRIM( ISNULL( CAST (IdTipoCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraCliente IS NULL THEN ' MostraCliente : «Nulo» '
                                              WHEN  MostraCliente = 0 THEN ' MostraCliente : «Falso» '
                                              WHEN  MostraCliente = 1 THEN ' MostraCliente : «Verdadeiro» '
                                    END 
                         + '| NotaExplicativa : «' + RTRIM( ISNULL( CAST (NotaExplicativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemExecucao : «' + RTRIM( ISNULL( CAST (OrdemExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| ComandoSQL : «' + RTRIM( ISNULL( CAST (ComandoSQL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssunto : «' + RTRIM( ISNULL( CAST (IdAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraRelatorio IS NULL THEN ' GeraRelatorio : «Nulo» '
                                              WHEN  GeraRelatorio = 0 THEN ' GeraRelatorio : «Falso» '
                                              WHEN  GeraRelatorio = 1 THEN ' GeraRelatorio : «Verdadeiro» '
                                    END 
                         + '| IdTipoCorrecao : «' + RTRIM( ISNULL( CAST (IdTipoCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraCliente IS NULL THEN ' MostraCliente : «Nulo» '
                                              WHEN  MostraCliente = 0 THEN ' MostraCliente : «Falso» '
                                              WHEN  MostraCliente = 1 THEN ' MostraCliente : «Verdadeiro» '
                                    END 
                         + '| NotaExplicativa : «' + RTRIM( ISNULL( CAST (NotaExplicativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItemAnalisado : «' + RTRIM( ISNULL( CAST (IdItemAnalisado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemExecucao : «' + RTRIM( ISNULL( CAST (OrdemExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| ComandoSQL : «' + RTRIM( ISNULL( CAST (ComandoSQL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssunto : «' + RTRIM( ISNULL( CAST (IdAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeraRelatorio IS NULL THEN ' GeraRelatorio : «Nulo» '
                                              WHEN  GeraRelatorio = 0 THEN ' GeraRelatorio : «Falso» '
                                              WHEN  GeraRelatorio = 1 THEN ' GeraRelatorio : «Verdadeiro» '
                                    END 
                         + '| IdTipoCorrecao : «' + RTRIM( ISNULL( CAST (IdTipoCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MostraCliente IS NULL THEN ' MostraCliente : «Nulo» '
                                              WHEN  MostraCliente = 0 THEN ' MostraCliente : «Falso» '
                                              WHEN  MostraCliente = 1 THEN ' MostraCliente : «Verdadeiro» '
                                    END 
                         + '| NotaExplicativa : «' + RTRIM( ISNULL( CAST (NotaExplicativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
