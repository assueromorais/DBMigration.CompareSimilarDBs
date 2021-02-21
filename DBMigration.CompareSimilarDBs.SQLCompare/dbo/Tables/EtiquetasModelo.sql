CREATE TABLE [dbo].[EtiquetasModelo] (
    [IdEtiquetasModelo]        INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]                VARCHAR (50)  NOT NULL,
    [IdEtiquetasConfiguracoes] INT           NOT NULL,
    [Modelo]                   IMAGE         NOT NULL,
    [Modulo]                   VARCHAR (50)  NOT NULL,
    [Desabilitado]             BIT           NOT NULL,
    [CodigoBarras]             VARCHAR (400) NULL,
    CONSTRAINT [PK_EtiquetasModelo] PRIMARY KEY CLUSTERED ([IdEtiquetasModelo] ASC),
    CONSTRAINT [FK_EtiquetasConfiguracoes] FOREIGN KEY ([IdEtiquetasConfiguracoes]) REFERENCES [dbo].[EtiquetasConfiguracoes] ([IdEtiquetasConfiguracoes])
);


GO
CREATE TRIGGER [TrgLog_EtiquetasModelo] ON [Implanta_CRPAM].[dbo].[EtiquetasModelo] 
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
SET @TableName = 'EtiquetasModelo'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEtiquetasModelo : «' + RTRIM( ISNULL( CAST (IdEtiquetasModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtiquetasConfiguracoes : «' + RTRIM( ISNULL( CAST (IdEtiquetasConfiguracoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desabilitado IS NULL THEN ' Desabilitado : «Nulo» '
                                              WHEN  Desabilitado = 0 THEN ' Desabilitado : «Falso» '
                                              WHEN  Desabilitado = 1 THEN ' Desabilitado : «Verdadeiro» '
                                    END 
                         + '| CodigoBarras : «' + RTRIM( ISNULL( CAST (CodigoBarras AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEtiquetasModelo : «' + RTRIM( ISNULL( CAST (IdEtiquetasModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtiquetasConfiguracoes : «' + RTRIM( ISNULL( CAST (IdEtiquetasConfiguracoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desabilitado IS NULL THEN ' Desabilitado : «Nulo» '
                                              WHEN  Desabilitado = 0 THEN ' Desabilitado : «Falso» '
                                              WHEN  Desabilitado = 1 THEN ' Desabilitado : «Verdadeiro» '
                                    END 
                         + '| CodigoBarras : «' + RTRIM( ISNULL( CAST (CodigoBarras AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEtiquetasModelo : «' + RTRIM( ISNULL( CAST (IdEtiquetasModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtiquetasConfiguracoes : «' + RTRIM( ISNULL( CAST (IdEtiquetasConfiguracoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desabilitado IS NULL THEN ' Desabilitado : «Nulo» '
                                              WHEN  Desabilitado = 0 THEN ' Desabilitado : «Falso» '
                                              WHEN  Desabilitado = 1 THEN ' Desabilitado : «Verdadeiro» '
                                    END 
                         + '| CodigoBarras : «' + RTRIM( ISNULL( CAST (CodigoBarras AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEtiquetasModelo : «' + RTRIM( ISNULL( CAST (IdEtiquetasModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtiquetasConfiguracoes : «' + RTRIM( ISNULL( CAST (IdEtiquetasConfiguracoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desabilitado IS NULL THEN ' Desabilitado : «Nulo» '
                                              WHEN  Desabilitado = 0 THEN ' Desabilitado : «Falso» '
                                              WHEN  Desabilitado = 1 THEN ' Desabilitado : «Verdadeiro» '
                                    END 
                         + '| CodigoBarras : «' + RTRIM( ISNULL( CAST (CodigoBarras AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
