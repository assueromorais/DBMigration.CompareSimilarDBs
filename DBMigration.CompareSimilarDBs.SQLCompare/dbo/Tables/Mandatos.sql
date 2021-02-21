CREATE TABLE [dbo].[Mandatos] (
    [IdMandato]          INT      IDENTITY (1, 1) NOT NULL,
    [IdTitular]          INT      NULL,
    [IdSuplente]         INT      NULL,
    [IdUnidade]          INT      NULL,
    [IdCamara]           INT      NULL,
    [IdRepresentacao]    INT      NULL,
    [DataPosseTitular]   DATETIME NULL,
    [DataPosseSuplente]  DATETIME NULL,
    [DataInicioMandato]  DATETIME NULL,
    [DataTerminoMandato] DATETIME NULL,
    [ComposicaoPlenario] BIT      NULL,
    [ValidoContagem]     BIT      NULL,
    [ObservacaoTitular]  NTEXT    NULL,
    [ObservacaoSuplente] NTEXT    NULL,
    [Correspondencia]    INT      NULL,
    CONSTRAINT [PK_Mandatos] PRIMARY KEY CLUSTERED ([IdMandato] ASC),
    CONSTRAINT [FK_Mandatos_PessoasSispad_Suplente] FOREIGN KEY ([IdSuplente]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad]),
    CONSTRAINT [FK_Mandatos_PessoasSispad_Titular] FOREIGN KEY ([IdTitular]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad]),
    CONSTRAINT [FK_Mandatos_Representacao] FOREIGN KEY ([IdRepresentacao]) REFERENCES [dbo].[Representacao] ([IdRepresentacao]),
    CONSTRAINT [FK_Mandatos_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade]),
    CONSTRAINT [FK_Mandatos_UnidadesCamara] FOREIGN KEY ([IdCamara]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);


GO
CREATE TRIGGER [TrgLog_Mandatos] ON [Implanta_CRPAM].[dbo].[Mandatos] 
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
SET @TableName = 'Mandatos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMandato : «' + RTRIM( ISNULL( CAST (IdMandato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTitular : «' + RTRIM( ISNULL( CAST (IdTitular AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSuplente : «' + RTRIM( ISNULL( CAST (IdSuplente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCamara : «' + RTRIM( ISNULL( CAST (IdCamara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRepresentacao : «' + RTRIM( ISNULL( CAST (IdRepresentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPosseTitular : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPosseTitular, 113 ),'Nulo'))+'» '
                         + '| DataPosseSuplente : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPosseSuplente, 113 ),'Nulo'))+'» '
                         + '| DataInicioMandato : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioMandato, 113 ),'Nulo'))+'» '
                         + '| DataTerminoMandato : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoMandato, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ComposicaoPlenario IS NULL THEN ' ComposicaoPlenario : «Nulo» '
                                              WHEN  ComposicaoPlenario = 0 THEN ' ComposicaoPlenario : «Falso» '
                                              WHEN  ComposicaoPlenario = 1 THEN ' ComposicaoPlenario : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValidoContagem IS NULL THEN ' ValidoContagem : «Nulo» '
                                              WHEN  ValidoContagem = 0 THEN ' ValidoContagem : «Falso» '
                                              WHEN  ValidoContagem = 1 THEN ' ValidoContagem : «Verdadeiro» '
                                    END 
                         + '| Correspondencia : «' + RTRIM( ISNULL( CAST (Correspondencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMandato : «' + RTRIM( ISNULL( CAST (IdMandato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTitular : «' + RTRIM( ISNULL( CAST (IdTitular AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSuplente : «' + RTRIM( ISNULL( CAST (IdSuplente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCamara : «' + RTRIM( ISNULL( CAST (IdCamara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRepresentacao : «' + RTRIM( ISNULL( CAST (IdRepresentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPosseTitular : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPosseTitular, 113 ),'Nulo'))+'» '
                         + '| DataPosseSuplente : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPosseSuplente, 113 ),'Nulo'))+'» '
                         + '| DataInicioMandato : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioMandato, 113 ),'Nulo'))+'» '
                         + '| DataTerminoMandato : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoMandato, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ComposicaoPlenario IS NULL THEN ' ComposicaoPlenario : «Nulo» '
                                              WHEN  ComposicaoPlenario = 0 THEN ' ComposicaoPlenario : «Falso» '
                                              WHEN  ComposicaoPlenario = 1 THEN ' ComposicaoPlenario : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValidoContagem IS NULL THEN ' ValidoContagem : «Nulo» '
                                              WHEN  ValidoContagem = 0 THEN ' ValidoContagem : «Falso» '
                                              WHEN  ValidoContagem = 1 THEN ' ValidoContagem : «Verdadeiro» '
                                    END 
                         + '| Correspondencia : «' + RTRIM( ISNULL( CAST (Correspondencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMandato : «' + RTRIM( ISNULL( CAST (IdMandato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTitular : «' + RTRIM( ISNULL( CAST (IdTitular AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSuplente : «' + RTRIM( ISNULL( CAST (IdSuplente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCamara : «' + RTRIM( ISNULL( CAST (IdCamara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRepresentacao : «' + RTRIM( ISNULL( CAST (IdRepresentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPosseTitular : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPosseTitular, 113 ),'Nulo'))+'» '
                         + '| DataPosseSuplente : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPosseSuplente, 113 ),'Nulo'))+'» '
                         + '| DataInicioMandato : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioMandato, 113 ),'Nulo'))+'» '
                         + '| DataTerminoMandato : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoMandato, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ComposicaoPlenario IS NULL THEN ' ComposicaoPlenario : «Nulo» '
                                              WHEN  ComposicaoPlenario = 0 THEN ' ComposicaoPlenario : «Falso» '
                                              WHEN  ComposicaoPlenario = 1 THEN ' ComposicaoPlenario : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValidoContagem IS NULL THEN ' ValidoContagem : «Nulo» '
                                              WHEN  ValidoContagem = 0 THEN ' ValidoContagem : «Falso» '
                                              WHEN  ValidoContagem = 1 THEN ' ValidoContagem : «Verdadeiro» '
                                    END 
                         + '| Correspondencia : «' + RTRIM( ISNULL( CAST (Correspondencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMandato : «' + RTRIM( ISNULL( CAST (IdMandato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTitular : «' + RTRIM( ISNULL( CAST (IdTitular AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSuplente : «' + RTRIM( ISNULL( CAST (IdSuplente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCamara : «' + RTRIM( ISNULL( CAST (IdCamara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRepresentacao : «' + RTRIM( ISNULL( CAST (IdRepresentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPosseTitular : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPosseTitular, 113 ),'Nulo'))+'» '
                         + '| DataPosseSuplente : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPosseSuplente, 113 ),'Nulo'))+'» '
                         + '| DataInicioMandato : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioMandato, 113 ),'Nulo'))+'» '
                         + '| DataTerminoMandato : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoMandato, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ComposicaoPlenario IS NULL THEN ' ComposicaoPlenario : «Nulo» '
                                              WHEN  ComposicaoPlenario = 0 THEN ' ComposicaoPlenario : «Falso» '
                                              WHEN  ComposicaoPlenario = 1 THEN ' ComposicaoPlenario : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValidoContagem IS NULL THEN ' ValidoContagem : «Nulo» '
                                              WHEN  ValidoContagem = 0 THEN ' ValidoContagem : «Falso» '
                                              WHEN  ValidoContagem = 1 THEN ' ValidoContagem : «Verdadeiro» '
                                    END 
                         + '| Correspondencia : «' + RTRIM( ISNULL( CAST (Correspondencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
