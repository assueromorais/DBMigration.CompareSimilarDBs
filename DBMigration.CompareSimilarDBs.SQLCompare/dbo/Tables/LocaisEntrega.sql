CREATE TABLE [dbo].[LocaisEntrega] (
    [IdLocalEntrega]     INT           IDENTITY (1, 1) NOT NULL,
    [IdUnidade]          INT           NOT NULL,
    [TituloLocal]        VARCHAR (60)  NOT NULL,
    [DescricaoLocal]     VARCHAR (120) NOT NULL,
    [SiglaLocal]         VARCHAR (15)  NULL,
    [Ativo]              BIT           NULL,
    [Padrao]             BIT           NULL,
    [Eh_LocalPatrimonio] BIT           CONSTRAINT [DF_LocaisEntrega_Eh_LocalPatrimonio] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_LocaisEntrega] PRIMARY KEY CLUSTERED ([IdLocalEntrega] ASC),
    CONSTRAINT [FK_LocaisEntrega_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_LocaisEntrega] ON [Implanta_CRPAM].[dbo].[LocaisEntrega] 
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
SET @TableName = 'LocaisEntrega'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloLocal : «' + RTRIM( ISNULL( CAST (TituloLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoLocal : «' + RTRIM( ISNULL( CAST (DescricaoLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaLocal : «' + RTRIM( ISNULL( CAST (SiglaLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Padrao IS NULL THEN ' Padrao : «Nulo» '
                                              WHEN  Padrao = 0 THEN ' Padrao : «Falso» '
                                              WHEN  Padrao = 1 THEN ' Padrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Eh_LocalPatrimonio IS NULL THEN ' Eh_LocalPatrimonio : «Nulo» '
                                              WHEN  Eh_LocalPatrimonio = 0 THEN ' Eh_LocalPatrimonio : «Falso» '
                                              WHEN  Eh_LocalPatrimonio = 1 THEN ' Eh_LocalPatrimonio : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloLocal : «' + RTRIM( ISNULL( CAST (TituloLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoLocal : «' + RTRIM( ISNULL( CAST (DescricaoLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaLocal : «' + RTRIM( ISNULL( CAST (SiglaLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Padrao IS NULL THEN ' Padrao : «Nulo» '
                                              WHEN  Padrao = 0 THEN ' Padrao : «Falso» '
                                              WHEN  Padrao = 1 THEN ' Padrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Eh_LocalPatrimonio IS NULL THEN ' Eh_LocalPatrimonio : «Nulo» '
                                              WHEN  Eh_LocalPatrimonio = 0 THEN ' Eh_LocalPatrimonio : «Falso» '
                                              WHEN  Eh_LocalPatrimonio = 1 THEN ' Eh_LocalPatrimonio : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloLocal : «' + RTRIM( ISNULL( CAST (TituloLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoLocal : «' + RTRIM( ISNULL( CAST (DescricaoLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaLocal : «' + RTRIM( ISNULL( CAST (SiglaLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Padrao IS NULL THEN ' Padrao : «Nulo» '
                                              WHEN  Padrao = 0 THEN ' Padrao : «Falso» '
                                              WHEN  Padrao = 1 THEN ' Padrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Eh_LocalPatrimonio IS NULL THEN ' Eh_LocalPatrimonio : «Nulo» '
                                              WHEN  Eh_LocalPatrimonio = 0 THEN ' Eh_LocalPatrimonio : «Falso» '
                                              WHEN  Eh_LocalPatrimonio = 1 THEN ' Eh_LocalPatrimonio : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLocalEntrega : «' + RTRIM( ISNULL( CAST (IdLocalEntrega AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloLocal : «' + RTRIM( ISNULL( CAST (TituloLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoLocal : «' + RTRIM( ISNULL( CAST (DescricaoLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaLocal : «' + RTRIM( ISNULL( CAST (SiglaLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Padrao IS NULL THEN ' Padrao : «Nulo» '
                                              WHEN  Padrao = 0 THEN ' Padrao : «Falso» '
                                              WHEN  Padrao = 1 THEN ' Padrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Eh_LocalPatrimonio IS NULL THEN ' Eh_LocalPatrimonio : «Nulo» '
                                              WHEN  Eh_LocalPatrimonio = 0 THEN ' Eh_LocalPatrimonio : «Falso» '
                                              WHEN  Eh_LocalPatrimonio = 1 THEN ' Eh_LocalPatrimonio : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
