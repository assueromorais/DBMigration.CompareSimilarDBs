CREATE TABLE [dbo].[ConfiguracoesExportacaoJUCEB] (
    [IdConfiguracoesExportacao] INT           IDENTITY (1, 1) NOT NULL,
    [Usuario]                   VARCHAR (100) NOT NULL,
    [Destino]                   VARCHAR (2)   NOT NULL,
    [NIREEmpresa]               BIT           DEFAULT ((0)) NULL,
    [NomeEmpresa]               BIT           DEFAULT ((0)) NULL,
    [LogradouroEmpresa]         BIT           DEFAULT ((0)) NULL,
    [ComplementoEmpresa]        BIT           DEFAULT ((0)) NULL,
    [BairroEmpresa]             BIT           DEFAULT ((0)) NULL,
    [CepEmpresa]                BIT           DEFAULT ((0)) NULL,
    [MunicipioEmpresa]          BIT           DEFAULT ((0)) NULL,
    [UFEmpresa]                 BIT           DEFAULT ((0)) NULL,
    [ValorCapitalEmpresa]       BIT           DEFAULT ((0)) NULL,
    [DataConstituicaoEmpresa]   BIT           DEFAULT ((0)) NULL,
    [CNPJEmpresa]               BIT           DEFAULT ((0)) NULL,
    [CNAEEmpresa]               BIT           DEFAULT ((0)) NULL,
    [AtividadesEmpresa]         BIT           DEFAULT ((0)) NULL,
    [CNPJSocio]                 BIT           DEFAULT ((0)) NULL,
    [LogradouroSocio]           BIT           DEFAULT ((0)) NULL,
    [ComplementoSocio]          BIT           DEFAULT ((0)) NULL,
    [BairroSocio]               BIT           DEFAULT ((0)) NULL,
    [MunicipioSocio]            BIT           DEFAULT ((0)) NULL,
    [ValorCapitalSocio]         BIT           DEFAULT ((0)) NULL,
    [CPFCNPJSocio]              BIT           DEFAULT ((0)) NULL,
    [NomeSocio]                 BIT           DEFAULT ((0)) NULL,
    [VinculoSocio]              BIT           DEFAULT ((0)) NULL,
    [EntradaSocio]              BIT           DEFAULT ((0)) NULL,
    [ParticipacaoSocio]         BIT           DEFAULT ((0)) NULL,
    [UFSocio]                   BIT           DEFAULT ((0)) NULL,
    [CepSocio]                  BIT           DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ConfiguracoesExportacaoJUCEB] PRIMARY KEY CLUSTERED ([IdConfiguracoesExportacao] ASC)
);


GO
CREATE TRIGGER [TrgLog_ConfiguracoesExportacaoJUCEB] ON [Implanta_CRPAM].[dbo].[ConfiguracoesExportacaoJUCEB] 
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
SET @TableName = 'ConfiguracoesExportacaoJUCEB'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfiguracoesExportacao : «' + RTRIM( ISNULL( CAST (IdConfiguracoesExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destino : «' + RTRIM( ISNULL( CAST (Destino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NIREEmpresa IS NULL THEN ' NIREEmpresa : «Nulo» '
                                              WHEN  NIREEmpresa = 0 THEN ' NIREEmpresa : «Falso» '
                                              WHEN  NIREEmpresa = 1 THEN ' NIREEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NomeEmpresa IS NULL THEN ' NomeEmpresa : «Nulo» '
                                              WHEN  NomeEmpresa = 0 THEN ' NomeEmpresa : «Falso» '
                                              WHEN  NomeEmpresa = 1 THEN ' NomeEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LogradouroEmpresa IS NULL THEN ' LogradouroEmpresa : «Nulo» '
                                              WHEN  LogradouroEmpresa = 0 THEN ' LogradouroEmpresa : «Falso» '
                                              WHEN  LogradouroEmpresa = 1 THEN ' LogradouroEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComplementoEmpresa IS NULL THEN ' ComplementoEmpresa : «Nulo» '
                                              WHEN  ComplementoEmpresa = 0 THEN ' ComplementoEmpresa : «Falso» '
                                              WHEN  ComplementoEmpresa = 1 THEN ' ComplementoEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BairroEmpresa IS NULL THEN ' BairroEmpresa : «Nulo» '
                                              WHEN  BairroEmpresa = 0 THEN ' BairroEmpresa : «Falso» '
                                              WHEN  BairroEmpresa = 1 THEN ' BairroEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CepEmpresa IS NULL THEN ' CepEmpresa : «Nulo» '
                                              WHEN  CepEmpresa = 0 THEN ' CepEmpresa : «Falso» '
                                              WHEN  CepEmpresa = 1 THEN ' CepEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MunicipioEmpresa IS NULL THEN ' MunicipioEmpresa : «Nulo» '
                                              WHEN  MunicipioEmpresa = 0 THEN ' MunicipioEmpresa : «Falso» '
                                              WHEN  MunicipioEmpresa = 1 THEN ' MunicipioEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UFEmpresa IS NULL THEN ' UFEmpresa : «Nulo» '
                                              WHEN  UFEmpresa = 0 THEN ' UFEmpresa : «Falso» '
                                              WHEN  UFEmpresa = 1 THEN ' UFEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValorCapitalEmpresa IS NULL THEN ' ValorCapitalEmpresa : «Nulo» '
                                              WHEN  ValorCapitalEmpresa = 0 THEN ' ValorCapitalEmpresa : «Falso» '
                                              WHEN  ValorCapitalEmpresa = 1 THEN ' ValorCapitalEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DataConstituicaoEmpresa IS NULL THEN ' DataConstituicaoEmpresa : «Nulo» '
                                              WHEN  DataConstituicaoEmpresa = 0 THEN ' DataConstituicaoEmpresa : «Falso» '
                                              WHEN  DataConstituicaoEmpresa = 1 THEN ' DataConstituicaoEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJEmpresa IS NULL THEN ' CNPJEmpresa : «Nulo» '
                                              WHEN  CNPJEmpresa = 0 THEN ' CNPJEmpresa : «Falso» '
                                              WHEN  CNPJEmpresa = 1 THEN ' CNPJEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNAEEmpresa IS NULL THEN ' CNAEEmpresa : «Nulo» '
                                              WHEN  CNAEEmpresa = 0 THEN ' CNAEEmpresa : «Falso» '
                                              WHEN  CNAEEmpresa = 1 THEN ' CNAEEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtividadesEmpresa IS NULL THEN ' AtividadesEmpresa : «Nulo» '
                                              WHEN  AtividadesEmpresa = 0 THEN ' AtividadesEmpresa : «Falso» '
                                              WHEN  AtividadesEmpresa = 1 THEN ' AtividadesEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJSocio IS NULL THEN ' CNPJSocio : «Nulo» '
                                              WHEN  CNPJSocio = 0 THEN ' CNPJSocio : «Falso» '
                                              WHEN  CNPJSocio = 1 THEN ' CNPJSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LogradouroSocio IS NULL THEN ' LogradouroSocio : «Nulo» '
                                              WHEN  LogradouroSocio = 0 THEN ' LogradouroSocio : «Falso» '
                                              WHEN  LogradouroSocio = 1 THEN ' LogradouroSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComplementoSocio IS NULL THEN ' ComplementoSocio : «Nulo» '
                                              WHEN  ComplementoSocio = 0 THEN ' ComplementoSocio : «Falso» '
                                              WHEN  ComplementoSocio = 1 THEN ' ComplementoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BairroSocio IS NULL THEN ' BairroSocio : «Nulo» '
                                              WHEN  BairroSocio = 0 THEN ' BairroSocio : «Falso» '
                                              WHEN  BairroSocio = 1 THEN ' BairroSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MunicipioSocio IS NULL THEN ' MunicipioSocio : «Nulo» '
                                              WHEN  MunicipioSocio = 0 THEN ' MunicipioSocio : «Falso» '
                                              WHEN  MunicipioSocio = 1 THEN ' MunicipioSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValorCapitalSocio IS NULL THEN ' ValorCapitalSocio : «Nulo» '
                                              WHEN  ValorCapitalSocio = 0 THEN ' ValorCapitalSocio : «Falso» '
                                              WHEN  ValorCapitalSocio = 1 THEN ' ValorCapitalSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CPFCNPJSocio IS NULL THEN ' CPFCNPJSocio : «Nulo» '
                                              WHEN  CPFCNPJSocio = 0 THEN ' CPFCNPJSocio : «Falso» '
                                              WHEN  CPFCNPJSocio = 1 THEN ' CPFCNPJSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NomeSocio IS NULL THEN ' NomeSocio : «Nulo» '
                                              WHEN  NomeSocio = 0 THEN ' NomeSocio : «Falso» '
                                              WHEN  NomeSocio = 1 THEN ' NomeSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VinculoSocio IS NULL THEN ' VinculoSocio : «Nulo» '
                                              WHEN  VinculoSocio = 0 THEN ' VinculoSocio : «Falso» '
                                              WHEN  VinculoSocio = 1 THEN ' VinculoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EntradaSocio IS NULL THEN ' EntradaSocio : «Nulo» '
                                              WHEN  EntradaSocio = 0 THEN ' EntradaSocio : «Falso» '
                                              WHEN  EntradaSocio = 1 THEN ' EntradaSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ParticipacaoSocio IS NULL THEN ' ParticipacaoSocio : «Nulo» '
                                              WHEN  ParticipacaoSocio = 0 THEN ' ParticipacaoSocio : «Falso» '
                                              WHEN  ParticipacaoSocio = 1 THEN ' ParticipacaoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UFSocio IS NULL THEN ' UFSocio : «Nulo» '
                                              WHEN  UFSocio = 0 THEN ' UFSocio : «Falso» '
                                              WHEN  UFSocio = 1 THEN ' UFSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CepSocio IS NULL THEN ' CepSocio : «Nulo» '
                                              WHEN  CepSocio = 0 THEN ' CepSocio : «Falso» '
                                              WHEN  CepSocio = 1 THEN ' CepSocio : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdConfiguracoesExportacao : «' + RTRIM( ISNULL( CAST (IdConfiguracoesExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destino : «' + RTRIM( ISNULL( CAST (Destino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NIREEmpresa IS NULL THEN ' NIREEmpresa : «Nulo» '
                                              WHEN  NIREEmpresa = 0 THEN ' NIREEmpresa : «Falso» '
                                              WHEN  NIREEmpresa = 1 THEN ' NIREEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NomeEmpresa IS NULL THEN ' NomeEmpresa : «Nulo» '
                                              WHEN  NomeEmpresa = 0 THEN ' NomeEmpresa : «Falso» '
                                              WHEN  NomeEmpresa = 1 THEN ' NomeEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LogradouroEmpresa IS NULL THEN ' LogradouroEmpresa : «Nulo» '
                                              WHEN  LogradouroEmpresa = 0 THEN ' LogradouroEmpresa : «Falso» '
                                              WHEN  LogradouroEmpresa = 1 THEN ' LogradouroEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComplementoEmpresa IS NULL THEN ' ComplementoEmpresa : «Nulo» '
                                              WHEN  ComplementoEmpresa = 0 THEN ' ComplementoEmpresa : «Falso» '
                                              WHEN  ComplementoEmpresa = 1 THEN ' ComplementoEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BairroEmpresa IS NULL THEN ' BairroEmpresa : «Nulo» '
                                              WHEN  BairroEmpresa = 0 THEN ' BairroEmpresa : «Falso» '
                                              WHEN  BairroEmpresa = 1 THEN ' BairroEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CepEmpresa IS NULL THEN ' CepEmpresa : «Nulo» '
                                              WHEN  CepEmpresa = 0 THEN ' CepEmpresa : «Falso» '
                                              WHEN  CepEmpresa = 1 THEN ' CepEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MunicipioEmpresa IS NULL THEN ' MunicipioEmpresa : «Nulo» '
                                              WHEN  MunicipioEmpresa = 0 THEN ' MunicipioEmpresa : «Falso» '
                                              WHEN  MunicipioEmpresa = 1 THEN ' MunicipioEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UFEmpresa IS NULL THEN ' UFEmpresa : «Nulo» '
                                              WHEN  UFEmpresa = 0 THEN ' UFEmpresa : «Falso» '
                                              WHEN  UFEmpresa = 1 THEN ' UFEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValorCapitalEmpresa IS NULL THEN ' ValorCapitalEmpresa : «Nulo» '
                                              WHEN  ValorCapitalEmpresa = 0 THEN ' ValorCapitalEmpresa : «Falso» '
                                              WHEN  ValorCapitalEmpresa = 1 THEN ' ValorCapitalEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DataConstituicaoEmpresa IS NULL THEN ' DataConstituicaoEmpresa : «Nulo» '
                                              WHEN  DataConstituicaoEmpresa = 0 THEN ' DataConstituicaoEmpresa : «Falso» '
                                              WHEN  DataConstituicaoEmpresa = 1 THEN ' DataConstituicaoEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJEmpresa IS NULL THEN ' CNPJEmpresa : «Nulo» '
                                              WHEN  CNPJEmpresa = 0 THEN ' CNPJEmpresa : «Falso» '
                                              WHEN  CNPJEmpresa = 1 THEN ' CNPJEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNAEEmpresa IS NULL THEN ' CNAEEmpresa : «Nulo» '
                                              WHEN  CNAEEmpresa = 0 THEN ' CNAEEmpresa : «Falso» '
                                              WHEN  CNAEEmpresa = 1 THEN ' CNAEEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtividadesEmpresa IS NULL THEN ' AtividadesEmpresa : «Nulo» '
                                              WHEN  AtividadesEmpresa = 0 THEN ' AtividadesEmpresa : «Falso» '
                                              WHEN  AtividadesEmpresa = 1 THEN ' AtividadesEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJSocio IS NULL THEN ' CNPJSocio : «Nulo» '
                                              WHEN  CNPJSocio = 0 THEN ' CNPJSocio : «Falso» '
                                              WHEN  CNPJSocio = 1 THEN ' CNPJSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LogradouroSocio IS NULL THEN ' LogradouroSocio : «Nulo» '
                                              WHEN  LogradouroSocio = 0 THEN ' LogradouroSocio : «Falso» '
                                              WHEN  LogradouroSocio = 1 THEN ' LogradouroSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComplementoSocio IS NULL THEN ' ComplementoSocio : «Nulo» '
                                              WHEN  ComplementoSocio = 0 THEN ' ComplementoSocio : «Falso» '
                                              WHEN  ComplementoSocio = 1 THEN ' ComplementoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BairroSocio IS NULL THEN ' BairroSocio : «Nulo» '
                                              WHEN  BairroSocio = 0 THEN ' BairroSocio : «Falso» '
                                              WHEN  BairroSocio = 1 THEN ' BairroSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MunicipioSocio IS NULL THEN ' MunicipioSocio : «Nulo» '
                                              WHEN  MunicipioSocio = 0 THEN ' MunicipioSocio : «Falso» '
                                              WHEN  MunicipioSocio = 1 THEN ' MunicipioSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValorCapitalSocio IS NULL THEN ' ValorCapitalSocio : «Nulo» '
                                              WHEN  ValorCapitalSocio = 0 THEN ' ValorCapitalSocio : «Falso» '
                                              WHEN  ValorCapitalSocio = 1 THEN ' ValorCapitalSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CPFCNPJSocio IS NULL THEN ' CPFCNPJSocio : «Nulo» '
                                              WHEN  CPFCNPJSocio = 0 THEN ' CPFCNPJSocio : «Falso» '
                                              WHEN  CPFCNPJSocio = 1 THEN ' CPFCNPJSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NomeSocio IS NULL THEN ' NomeSocio : «Nulo» '
                                              WHEN  NomeSocio = 0 THEN ' NomeSocio : «Falso» '
                                              WHEN  NomeSocio = 1 THEN ' NomeSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VinculoSocio IS NULL THEN ' VinculoSocio : «Nulo» '
                                              WHEN  VinculoSocio = 0 THEN ' VinculoSocio : «Falso» '
                                              WHEN  VinculoSocio = 1 THEN ' VinculoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EntradaSocio IS NULL THEN ' EntradaSocio : «Nulo» '
                                              WHEN  EntradaSocio = 0 THEN ' EntradaSocio : «Falso» '
                                              WHEN  EntradaSocio = 1 THEN ' EntradaSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ParticipacaoSocio IS NULL THEN ' ParticipacaoSocio : «Nulo» '
                                              WHEN  ParticipacaoSocio = 0 THEN ' ParticipacaoSocio : «Falso» '
                                              WHEN  ParticipacaoSocio = 1 THEN ' ParticipacaoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UFSocio IS NULL THEN ' UFSocio : «Nulo» '
                                              WHEN  UFSocio = 0 THEN ' UFSocio : «Falso» '
                                              WHEN  UFSocio = 1 THEN ' UFSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CepSocio IS NULL THEN ' CepSocio : «Nulo» '
                                              WHEN  CepSocio = 0 THEN ' CepSocio : «Falso» '
                                              WHEN  CepSocio = 1 THEN ' CepSocio : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdConfiguracoesExportacao : «' + RTRIM( ISNULL( CAST (IdConfiguracoesExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destino : «' + RTRIM( ISNULL( CAST (Destino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NIREEmpresa IS NULL THEN ' NIREEmpresa : «Nulo» '
                                              WHEN  NIREEmpresa = 0 THEN ' NIREEmpresa : «Falso» '
                                              WHEN  NIREEmpresa = 1 THEN ' NIREEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NomeEmpresa IS NULL THEN ' NomeEmpresa : «Nulo» '
                                              WHEN  NomeEmpresa = 0 THEN ' NomeEmpresa : «Falso» '
                                              WHEN  NomeEmpresa = 1 THEN ' NomeEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LogradouroEmpresa IS NULL THEN ' LogradouroEmpresa : «Nulo» '
                                              WHEN  LogradouroEmpresa = 0 THEN ' LogradouroEmpresa : «Falso» '
                                              WHEN  LogradouroEmpresa = 1 THEN ' LogradouroEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComplementoEmpresa IS NULL THEN ' ComplementoEmpresa : «Nulo» '
                                              WHEN  ComplementoEmpresa = 0 THEN ' ComplementoEmpresa : «Falso» '
                                              WHEN  ComplementoEmpresa = 1 THEN ' ComplementoEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BairroEmpresa IS NULL THEN ' BairroEmpresa : «Nulo» '
                                              WHEN  BairroEmpresa = 0 THEN ' BairroEmpresa : «Falso» '
                                              WHEN  BairroEmpresa = 1 THEN ' BairroEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CepEmpresa IS NULL THEN ' CepEmpresa : «Nulo» '
                                              WHEN  CepEmpresa = 0 THEN ' CepEmpresa : «Falso» '
                                              WHEN  CepEmpresa = 1 THEN ' CepEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MunicipioEmpresa IS NULL THEN ' MunicipioEmpresa : «Nulo» '
                                              WHEN  MunicipioEmpresa = 0 THEN ' MunicipioEmpresa : «Falso» '
                                              WHEN  MunicipioEmpresa = 1 THEN ' MunicipioEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UFEmpresa IS NULL THEN ' UFEmpresa : «Nulo» '
                                              WHEN  UFEmpresa = 0 THEN ' UFEmpresa : «Falso» '
                                              WHEN  UFEmpresa = 1 THEN ' UFEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValorCapitalEmpresa IS NULL THEN ' ValorCapitalEmpresa : «Nulo» '
                                              WHEN  ValorCapitalEmpresa = 0 THEN ' ValorCapitalEmpresa : «Falso» '
                                              WHEN  ValorCapitalEmpresa = 1 THEN ' ValorCapitalEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DataConstituicaoEmpresa IS NULL THEN ' DataConstituicaoEmpresa : «Nulo» '
                                              WHEN  DataConstituicaoEmpresa = 0 THEN ' DataConstituicaoEmpresa : «Falso» '
                                              WHEN  DataConstituicaoEmpresa = 1 THEN ' DataConstituicaoEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJEmpresa IS NULL THEN ' CNPJEmpresa : «Nulo» '
                                              WHEN  CNPJEmpresa = 0 THEN ' CNPJEmpresa : «Falso» '
                                              WHEN  CNPJEmpresa = 1 THEN ' CNPJEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNAEEmpresa IS NULL THEN ' CNAEEmpresa : «Nulo» '
                                              WHEN  CNAEEmpresa = 0 THEN ' CNAEEmpresa : «Falso» '
                                              WHEN  CNAEEmpresa = 1 THEN ' CNAEEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtividadesEmpresa IS NULL THEN ' AtividadesEmpresa : «Nulo» '
                                              WHEN  AtividadesEmpresa = 0 THEN ' AtividadesEmpresa : «Falso» '
                                              WHEN  AtividadesEmpresa = 1 THEN ' AtividadesEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJSocio IS NULL THEN ' CNPJSocio : «Nulo» '
                                              WHEN  CNPJSocio = 0 THEN ' CNPJSocio : «Falso» '
                                              WHEN  CNPJSocio = 1 THEN ' CNPJSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LogradouroSocio IS NULL THEN ' LogradouroSocio : «Nulo» '
                                              WHEN  LogradouroSocio = 0 THEN ' LogradouroSocio : «Falso» '
                                              WHEN  LogradouroSocio = 1 THEN ' LogradouroSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComplementoSocio IS NULL THEN ' ComplementoSocio : «Nulo» '
                                              WHEN  ComplementoSocio = 0 THEN ' ComplementoSocio : «Falso» '
                                              WHEN  ComplementoSocio = 1 THEN ' ComplementoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BairroSocio IS NULL THEN ' BairroSocio : «Nulo» '
                                              WHEN  BairroSocio = 0 THEN ' BairroSocio : «Falso» '
                                              WHEN  BairroSocio = 1 THEN ' BairroSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MunicipioSocio IS NULL THEN ' MunicipioSocio : «Nulo» '
                                              WHEN  MunicipioSocio = 0 THEN ' MunicipioSocio : «Falso» '
                                              WHEN  MunicipioSocio = 1 THEN ' MunicipioSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValorCapitalSocio IS NULL THEN ' ValorCapitalSocio : «Nulo» '
                                              WHEN  ValorCapitalSocio = 0 THEN ' ValorCapitalSocio : «Falso» '
                                              WHEN  ValorCapitalSocio = 1 THEN ' ValorCapitalSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CPFCNPJSocio IS NULL THEN ' CPFCNPJSocio : «Nulo» '
                                              WHEN  CPFCNPJSocio = 0 THEN ' CPFCNPJSocio : «Falso» '
                                              WHEN  CPFCNPJSocio = 1 THEN ' CPFCNPJSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NomeSocio IS NULL THEN ' NomeSocio : «Nulo» '
                                              WHEN  NomeSocio = 0 THEN ' NomeSocio : «Falso» '
                                              WHEN  NomeSocio = 1 THEN ' NomeSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VinculoSocio IS NULL THEN ' VinculoSocio : «Nulo» '
                                              WHEN  VinculoSocio = 0 THEN ' VinculoSocio : «Falso» '
                                              WHEN  VinculoSocio = 1 THEN ' VinculoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EntradaSocio IS NULL THEN ' EntradaSocio : «Nulo» '
                                              WHEN  EntradaSocio = 0 THEN ' EntradaSocio : «Falso» '
                                              WHEN  EntradaSocio = 1 THEN ' EntradaSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ParticipacaoSocio IS NULL THEN ' ParticipacaoSocio : «Nulo» '
                                              WHEN  ParticipacaoSocio = 0 THEN ' ParticipacaoSocio : «Falso» '
                                              WHEN  ParticipacaoSocio = 1 THEN ' ParticipacaoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UFSocio IS NULL THEN ' UFSocio : «Nulo» '
                                              WHEN  UFSocio = 0 THEN ' UFSocio : «Falso» '
                                              WHEN  UFSocio = 1 THEN ' UFSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CepSocio IS NULL THEN ' CepSocio : «Nulo» '
                                              WHEN  CepSocio = 0 THEN ' CepSocio : «Falso» '
                                              WHEN  CepSocio = 1 THEN ' CepSocio : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfiguracoesExportacao : «' + RTRIM( ISNULL( CAST (IdConfiguracoesExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destino : «' + RTRIM( ISNULL( CAST (Destino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NIREEmpresa IS NULL THEN ' NIREEmpresa : «Nulo» '
                                              WHEN  NIREEmpresa = 0 THEN ' NIREEmpresa : «Falso» '
                                              WHEN  NIREEmpresa = 1 THEN ' NIREEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NomeEmpresa IS NULL THEN ' NomeEmpresa : «Nulo» '
                                              WHEN  NomeEmpresa = 0 THEN ' NomeEmpresa : «Falso» '
                                              WHEN  NomeEmpresa = 1 THEN ' NomeEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LogradouroEmpresa IS NULL THEN ' LogradouroEmpresa : «Nulo» '
                                              WHEN  LogradouroEmpresa = 0 THEN ' LogradouroEmpresa : «Falso» '
                                              WHEN  LogradouroEmpresa = 1 THEN ' LogradouroEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComplementoEmpresa IS NULL THEN ' ComplementoEmpresa : «Nulo» '
                                              WHEN  ComplementoEmpresa = 0 THEN ' ComplementoEmpresa : «Falso» '
                                              WHEN  ComplementoEmpresa = 1 THEN ' ComplementoEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BairroEmpresa IS NULL THEN ' BairroEmpresa : «Nulo» '
                                              WHEN  BairroEmpresa = 0 THEN ' BairroEmpresa : «Falso» '
                                              WHEN  BairroEmpresa = 1 THEN ' BairroEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CepEmpresa IS NULL THEN ' CepEmpresa : «Nulo» '
                                              WHEN  CepEmpresa = 0 THEN ' CepEmpresa : «Falso» '
                                              WHEN  CepEmpresa = 1 THEN ' CepEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MunicipioEmpresa IS NULL THEN ' MunicipioEmpresa : «Nulo» '
                                              WHEN  MunicipioEmpresa = 0 THEN ' MunicipioEmpresa : «Falso» '
                                              WHEN  MunicipioEmpresa = 1 THEN ' MunicipioEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UFEmpresa IS NULL THEN ' UFEmpresa : «Nulo» '
                                              WHEN  UFEmpresa = 0 THEN ' UFEmpresa : «Falso» '
                                              WHEN  UFEmpresa = 1 THEN ' UFEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValorCapitalEmpresa IS NULL THEN ' ValorCapitalEmpresa : «Nulo» '
                                              WHEN  ValorCapitalEmpresa = 0 THEN ' ValorCapitalEmpresa : «Falso» '
                                              WHEN  ValorCapitalEmpresa = 1 THEN ' ValorCapitalEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DataConstituicaoEmpresa IS NULL THEN ' DataConstituicaoEmpresa : «Nulo» '
                                              WHEN  DataConstituicaoEmpresa = 0 THEN ' DataConstituicaoEmpresa : «Falso» '
                                              WHEN  DataConstituicaoEmpresa = 1 THEN ' DataConstituicaoEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJEmpresa IS NULL THEN ' CNPJEmpresa : «Nulo» '
                                              WHEN  CNPJEmpresa = 0 THEN ' CNPJEmpresa : «Falso» '
                                              WHEN  CNPJEmpresa = 1 THEN ' CNPJEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNAEEmpresa IS NULL THEN ' CNAEEmpresa : «Nulo» '
                                              WHEN  CNAEEmpresa = 0 THEN ' CNAEEmpresa : «Falso» '
                                              WHEN  CNAEEmpresa = 1 THEN ' CNAEEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtividadesEmpresa IS NULL THEN ' AtividadesEmpresa : «Nulo» '
                                              WHEN  AtividadesEmpresa = 0 THEN ' AtividadesEmpresa : «Falso» '
                                              WHEN  AtividadesEmpresa = 1 THEN ' AtividadesEmpresa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJSocio IS NULL THEN ' CNPJSocio : «Nulo» '
                                              WHEN  CNPJSocio = 0 THEN ' CNPJSocio : «Falso» '
                                              WHEN  CNPJSocio = 1 THEN ' CNPJSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  LogradouroSocio IS NULL THEN ' LogradouroSocio : «Nulo» '
                                              WHEN  LogradouroSocio = 0 THEN ' LogradouroSocio : «Falso» '
                                              WHEN  LogradouroSocio = 1 THEN ' LogradouroSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComplementoSocio IS NULL THEN ' ComplementoSocio : «Nulo» '
                                              WHEN  ComplementoSocio = 0 THEN ' ComplementoSocio : «Falso» '
                                              WHEN  ComplementoSocio = 1 THEN ' ComplementoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  BairroSocio IS NULL THEN ' BairroSocio : «Nulo» '
                                              WHEN  BairroSocio = 0 THEN ' BairroSocio : «Falso» '
                                              WHEN  BairroSocio = 1 THEN ' BairroSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MunicipioSocio IS NULL THEN ' MunicipioSocio : «Nulo» '
                                              WHEN  MunicipioSocio = 0 THEN ' MunicipioSocio : «Falso» '
                                              WHEN  MunicipioSocio = 1 THEN ' MunicipioSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ValorCapitalSocio IS NULL THEN ' ValorCapitalSocio : «Nulo» '
                                              WHEN  ValorCapitalSocio = 0 THEN ' ValorCapitalSocio : «Falso» '
                                              WHEN  ValorCapitalSocio = 1 THEN ' ValorCapitalSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CPFCNPJSocio IS NULL THEN ' CPFCNPJSocio : «Nulo» '
                                              WHEN  CPFCNPJSocio = 0 THEN ' CPFCNPJSocio : «Falso» '
                                              WHEN  CPFCNPJSocio = 1 THEN ' CPFCNPJSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NomeSocio IS NULL THEN ' NomeSocio : «Nulo» '
                                              WHEN  NomeSocio = 0 THEN ' NomeSocio : «Falso» '
                                              WHEN  NomeSocio = 1 THEN ' NomeSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VinculoSocio IS NULL THEN ' VinculoSocio : «Nulo» '
                                              WHEN  VinculoSocio = 0 THEN ' VinculoSocio : «Falso» '
                                              WHEN  VinculoSocio = 1 THEN ' VinculoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EntradaSocio IS NULL THEN ' EntradaSocio : «Nulo» '
                                              WHEN  EntradaSocio = 0 THEN ' EntradaSocio : «Falso» '
                                              WHEN  EntradaSocio = 1 THEN ' EntradaSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ParticipacaoSocio IS NULL THEN ' ParticipacaoSocio : «Nulo» '
                                              WHEN  ParticipacaoSocio = 0 THEN ' ParticipacaoSocio : «Falso» '
                                              WHEN  ParticipacaoSocio = 1 THEN ' ParticipacaoSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UFSocio IS NULL THEN ' UFSocio : «Nulo» '
                                              WHEN  UFSocio = 0 THEN ' UFSocio : «Falso» '
                                              WHEN  UFSocio = 1 THEN ' UFSocio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CepSocio IS NULL THEN ' CepSocio : «Nulo» '
                                              WHEN  CepSocio = 0 THEN ' CepSocio : «Falso» '
                                              WHEN  CepSocio = 1 THEN ' CepSocio : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
