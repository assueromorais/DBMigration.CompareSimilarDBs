CREATE TABLE [dbo].[Etapas] (
    [IdEtapa]                      INT          IDENTITY (1, 1) NOT NULL,
    [NomeEtapa]                    VARCHAR (50) NULL,
    [CodEtapa]                     CHAR (3)     NULL,
    [IdTipoProcesso]               INT          NULL,
    [Desativado]                   BIT          CONSTRAINT [DF_EtapasDesativado] DEFAULT ((0)) NULL,
    [EtapaPadrao]                  BIT          CONSTRAINT [DF__Etapas__EtapaPad__64D6AC8C] DEFAULT ((0)) NULL,
    [BloquearUsuarioNaoCadastrado] BIT          DEFAULT ((0)) NOT NULL,
    [OmitirResultadoCA]            BIT          DEFAULT ((0)) NOT NULL,
    [BaixaProcesso]                BIT          CONSTRAINT [DEF_Etapas_BaixaProcesso] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Etapas] PRIMARY KEY CLUSTERED ([IdEtapa] ASC),
    CONSTRAINT [FK_Etapas_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso])
);


GO
CREATE TRIGGER [TrgLog_Etapas] ON [Implanta_CRPAM].[dbo].[Etapas] 
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
SET @TableName = 'Etapas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEtapa : «' + RTRIM( ISNULL( CAST (NomeEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodEtapa : «' + RTRIM( ISNULL( CAST (CodEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EtapaPadrao IS NULL THEN ' EtapaPadrao : «Nulo» '
                                              WHEN  EtapaPadrao = 0 THEN ' EtapaPadrao : «Falso» '
                                              WHEN  EtapaPadrao = 1 THEN ' EtapaPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearUsuarioNaoCadastrado IS NULL THEN ' BloquearUsuarioNaoCadastrado : «Nulo» '
                                              WHEN  BloquearUsuarioNaoCadastrado = 0 THEN ' BloquearUsuarioNaoCadastrado : «Falso» '
                                              WHEN  BloquearUsuarioNaoCadastrado = 1 THEN ' BloquearUsuarioNaoCadastrado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OmitirResultadoCA IS NULL THEN ' OmitirResultadoCA : «Nulo» '
                                              WHEN  OmitirResultadoCA = 0 THEN ' OmitirResultadoCA : «Falso» '
                                              WHEN  OmitirResultadoCA = 1 THEN ' OmitirResultadoCA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BaixaProcesso IS NULL THEN ' BaixaProcesso : «Nulo» '
                                              WHEN  BaixaProcesso = 0 THEN ' BaixaProcesso : «Falso» '
                                              WHEN  BaixaProcesso = 1 THEN ' BaixaProcesso : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEtapa : «' + RTRIM( ISNULL( CAST (NomeEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodEtapa : «' + RTRIM( ISNULL( CAST (CodEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EtapaPadrao IS NULL THEN ' EtapaPadrao : «Nulo» '
                                              WHEN  EtapaPadrao = 0 THEN ' EtapaPadrao : «Falso» '
                                              WHEN  EtapaPadrao = 1 THEN ' EtapaPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearUsuarioNaoCadastrado IS NULL THEN ' BloquearUsuarioNaoCadastrado : «Nulo» '
                                              WHEN  BloquearUsuarioNaoCadastrado = 0 THEN ' BloquearUsuarioNaoCadastrado : «Falso» '
                                              WHEN  BloquearUsuarioNaoCadastrado = 1 THEN ' BloquearUsuarioNaoCadastrado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OmitirResultadoCA IS NULL THEN ' OmitirResultadoCA : «Nulo» '
                                              WHEN  OmitirResultadoCA = 0 THEN ' OmitirResultadoCA : «Falso» '
                                              WHEN  OmitirResultadoCA = 1 THEN ' OmitirResultadoCA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BaixaProcesso IS NULL THEN ' BaixaProcesso : «Nulo» '
                                              WHEN  BaixaProcesso = 0 THEN ' BaixaProcesso : «Falso» '
                                              WHEN  BaixaProcesso = 1 THEN ' BaixaProcesso : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEtapa : «' + RTRIM( ISNULL( CAST (NomeEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodEtapa : «' + RTRIM( ISNULL( CAST (CodEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EtapaPadrao IS NULL THEN ' EtapaPadrao : «Nulo» '
                                              WHEN  EtapaPadrao = 0 THEN ' EtapaPadrao : «Falso» '
                                              WHEN  EtapaPadrao = 1 THEN ' EtapaPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearUsuarioNaoCadastrado IS NULL THEN ' BloquearUsuarioNaoCadastrado : «Nulo» '
                                              WHEN  BloquearUsuarioNaoCadastrado = 0 THEN ' BloquearUsuarioNaoCadastrado : «Falso» '
                                              WHEN  BloquearUsuarioNaoCadastrado = 1 THEN ' BloquearUsuarioNaoCadastrado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OmitirResultadoCA IS NULL THEN ' OmitirResultadoCA : «Nulo» '
                                              WHEN  OmitirResultadoCA = 0 THEN ' OmitirResultadoCA : «Falso» '
                                              WHEN  OmitirResultadoCA = 1 THEN ' OmitirResultadoCA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BaixaProcesso IS NULL THEN ' BaixaProcesso : «Nulo» '
                                              WHEN  BaixaProcesso = 0 THEN ' BaixaProcesso : «Falso» '
                                              WHEN  BaixaProcesso = 1 THEN ' BaixaProcesso : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEtapa : «' + RTRIM( ISNULL( CAST (NomeEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodEtapa : «' + RTRIM( ISNULL( CAST (CodEtapa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EtapaPadrao IS NULL THEN ' EtapaPadrao : «Nulo» '
                                              WHEN  EtapaPadrao = 0 THEN ' EtapaPadrao : «Falso» '
                                              WHEN  EtapaPadrao = 1 THEN ' EtapaPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BloquearUsuarioNaoCadastrado IS NULL THEN ' BloquearUsuarioNaoCadastrado : «Nulo» '
                                              WHEN  BloquearUsuarioNaoCadastrado = 0 THEN ' BloquearUsuarioNaoCadastrado : «Falso» '
                                              WHEN  BloquearUsuarioNaoCadastrado = 1 THEN ' BloquearUsuarioNaoCadastrado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  OmitirResultadoCA IS NULL THEN ' OmitirResultadoCA : «Nulo» '
                                              WHEN  OmitirResultadoCA = 0 THEN ' OmitirResultadoCA : «Falso» '
                                              WHEN  OmitirResultadoCA = 1 THEN ' OmitirResultadoCA : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BaixaProcesso IS NULL THEN ' BaixaProcesso : «Nulo» '
                                              WHEN  BaixaProcesso = 0 THEN ' BaixaProcesso : «Falso» '
                                              WHEN  BaixaProcesso = 1 THEN ' BaixaProcesso : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
