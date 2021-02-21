CREATE TABLE [dbo].[Cliente] (
    [NomeCliente]             VARCHAR (120) NOT NULL,
    [SiglaCliente]            VARCHAR (60)  NOT NULL,
    [Localidade]              VARCHAR (60)  NOT NULL,
    [CGC]                     VARCHAR (60)  NULL,
    [CREA]                    BIT           NOT NULL,
    [IdConselho]              INT           NULL,
    [InscricaoMunicipal]      VARCHAR (8)   NULL,
    [Telefone]                VARCHAR (20)  NULL,
    [Logradouro]              VARCHAR (100) NULL,
    [NumeroEndereco]          VARCHAR (10)  NULL,
    [ComplementoEndereco]     VARCHAR (100) NULL,
    [Bairro]                  VARCHAR (50)  NULL,
    [CEP]                     VARCHAR (8)   NULL,
    [NomeCidade]              VARCHAR (40)  NULL,
    [SiglaUF]                 VARCHAR (2)   NULL,
    [CEI]                     VARCHAR (20)  NULL,
    [NIT]                     VARCHAR (20)  NULL,
    [InscricaoEstadual]       VARCHAR (20)  NULL,
    [CodMunicipioIbge]        VARCHAR (20)  NULL,
    [Suframa]                 VARCHAR (20)  NULL,
    [CodSIC]                  VARCHAR (2)   NULL,
    [LogomarcaPrincipal]      IMAGE         NULL,
    [LogomarcaMenor]          IMAGE         NULL,
    [UtilizaLogoTelaSistemas] BIT           NULL,
    [NumeroRegiao]            TINYINT       NULL,
    [QtdLicencaLogon]         VARCHAR (50)  NULL
);


GO
CREATE TRIGGER [TrgLog_Cliente] ON [Implanta_CRPAM].[dbo].[Cliente] 
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
SET @TableName = 'Cliente'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'NomeCliente : «' + RTRIM( ISNULL( CAST (NomeCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCliente : «' + RTRIM( ISNULL( CAST (SiglaCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Localidade : «' + RTRIM( ISNULL( CAST (Localidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CGC : «' + RTRIM( ISNULL( CAST (CGC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CREA IS NULL THEN ' CREA : «Nulo» '
                                              WHEN  CREA = 0 THEN ' CREA : «Falso» '
                                              WHEN  CREA = 1 THEN ' CREA : «Verdadeiro» '
                                    END 
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoMunicipal : «' + RTRIM( ISNULL( CAST (InscricaoMunicipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Telefone : «' + RTRIM( ISNULL( CAST (Telefone AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEndereco : «' + RTRIM( ISNULL( CAST (NumeroEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEndereco : «' + RTRIM( ISNULL( CAST (ComplementoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEI : «' + RTRIM( ISNULL( CAST (CEI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIT : «' + RTRIM( ISNULL( CAST (NIT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoEstadual : «' + RTRIM( ISNULL( CAST (InscricaoEstadual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMunicipioIbge : «' + RTRIM( ISNULL( CAST (CodMunicipioIbge AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Suframa : «' + RTRIM( ISNULL( CAST (Suframa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSIC : «' + RTRIM( ISNULL( CAST (CodSIC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaLogoTelaSistemas IS NULL THEN ' UtilizaLogoTelaSistemas : «Nulo» '
                                              WHEN  UtilizaLogoTelaSistemas = 0 THEN ' UtilizaLogoTelaSistemas : «Falso» '
                                              WHEN  UtilizaLogoTelaSistemas = 1 THEN ' UtilizaLogoTelaSistemas : «Verdadeiro» '
                                    END 
                         + '| NumeroRegiao : «' + RTRIM( ISNULL( CAST (NumeroRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdLicencaLogon : «' + RTRIM( ISNULL( CAST (QtdLicencaLogon AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'NomeCliente : «' + RTRIM( ISNULL( CAST (NomeCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCliente : «' + RTRIM( ISNULL( CAST (SiglaCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Localidade : «' + RTRIM( ISNULL( CAST (Localidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CGC : «' + RTRIM( ISNULL( CAST (CGC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CREA IS NULL THEN ' CREA : «Nulo» '
                                              WHEN  CREA = 0 THEN ' CREA : «Falso» '
                                              WHEN  CREA = 1 THEN ' CREA : «Verdadeiro» '
                                    END 
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoMunicipal : «' + RTRIM( ISNULL( CAST (InscricaoMunicipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Telefone : «' + RTRIM( ISNULL( CAST (Telefone AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEndereco : «' + RTRIM( ISNULL( CAST (NumeroEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEndereco : «' + RTRIM( ISNULL( CAST (ComplementoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEI : «' + RTRIM( ISNULL( CAST (CEI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIT : «' + RTRIM( ISNULL( CAST (NIT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoEstadual : «' + RTRIM( ISNULL( CAST (InscricaoEstadual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMunicipioIbge : «' + RTRIM( ISNULL( CAST (CodMunicipioIbge AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Suframa : «' + RTRIM( ISNULL( CAST (Suframa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSIC : «' + RTRIM( ISNULL( CAST (CodSIC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaLogoTelaSistemas IS NULL THEN ' UtilizaLogoTelaSistemas : «Nulo» '
                                              WHEN  UtilizaLogoTelaSistemas = 0 THEN ' UtilizaLogoTelaSistemas : «Falso» '
                                              WHEN  UtilizaLogoTelaSistemas = 1 THEN ' UtilizaLogoTelaSistemas : «Verdadeiro» '
                                    END 
                         + '| NumeroRegiao : «' + RTRIM( ISNULL( CAST (NumeroRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdLicencaLogon : «' + RTRIM( ISNULL( CAST (QtdLicencaLogon AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'NomeCliente : «' + RTRIM( ISNULL( CAST (NomeCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCliente : «' + RTRIM( ISNULL( CAST (SiglaCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Localidade : «' + RTRIM( ISNULL( CAST (Localidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CGC : «' + RTRIM( ISNULL( CAST (CGC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CREA IS NULL THEN ' CREA : «Nulo» '
                                              WHEN  CREA = 0 THEN ' CREA : «Falso» '
                                              WHEN  CREA = 1 THEN ' CREA : «Verdadeiro» '
                                    END 
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoMunicipal : «' + RTRIM( ISNULL( CAST (InscricaoMunicipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Telefone : «' + RTRIM( ISNULL( CAST (Telefone AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEndereco : «' + RTRIM( ISNULL( CAST (NumeroEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEndereco : «' + RTRIM( ISNULL( CAST (ComplementoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEI : «' + RTRIM( ISNULL( CAST (CEI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIT : «' + RTRIM( ISNULL( CAST (NIT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoEstadual : «' + RTRIM( ISNULL( CAST (InscricaoEstadual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMunicipioIbge : «' + RTRIM( ISNULL( CAST (CodMunicipioIbge AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Suframa : «' + RTRIM( ISNULL( CAST (Suframa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSIC : «' + RTRIM( ISNULL( CAST (CodSIC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaLogoTelaSistemas IS NULL THEN ' UtilizaLogoTelaSistemas : «Nulo» '
                                              WHEN  UtilizaLogoTelaSistemas = 0 THEN ' UtilizaLogoTelaSistemas : «Falso» '
                                              WHEN  UtilizaLogoTelaSistemas = 1 THEN ' UtilizaLogoTelaSistemas : «Verdadeiro» '
                                    END 
                         + '| NumeroRegiao : «' + RTRIM( ISNULL( CAST (NumeroRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdLicencaLogon : «' + RTRIM( ISNULL( CAST (QtdLicencaLogon AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'NomeCliente : «' + RTRIM( ISNULL( CAST (NomeCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCliente : «' + RTRIM( ISNULL( CAST (SiglaCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Localidade : «' + RTRIM( ISNULL( CAST (Localidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CGC : «' + RTRIM( ISNULL( CAST (CGC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CREA IS NULL THEN ' CREA : «Nulo» '
                                              WHEN  CREA = 0 THEN ' CREA : «Falso» '
                                              WHEN  CREA = 1 THEN ' CREA : «Verdadeiro» '
                                    END 
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoMunicipal : «' + RTRIM( ISNULL( CAST (InscricaoMunicipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Telefone : «' + RTRIM( ISNULL( CAST (Telefone AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEndereco : «' + RTRIM( ISNULL( CAST (NumeroEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEndereco : «' + RTRIM( ISNULL( CAST (ComplementoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEI : «' + RTRIM( ISNULL( CAST (CEI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIT : «' + RTRIM( ISNULL( CAST (NIT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InscricaoEstadual : «' + RTRIM( ISNULL( CAST (InscricaoEstadual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMunicipioIbge : «' + RTRIM( ISNULL( CAST (CodMunicipioIbge AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Suframa : «' + RTRIM( ISNULL( CAST (Suframa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSIC : «' + RTRIM( ISNULL( CAST (CodSIC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaLogoTelaSistemas IS NULL THEN ' UtilizaLogoTelaSistemas : «Nulo» '
                                              WHEN  UtilizaLogoTelaSistemas = 0 THEN ' UtilizaLogoTelaSistemas : «Falso» '
                                              WHEN  UtilizaLogoTelaSistemas = 1 THEN ' UtilizaLogoTelaSistemas : «Verdadeiro» '
                                    END 
                         + '| NumeroRegiao : «' + RTRIM( ISNULL( CAST (NumeroRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdLicencaLogon : «' + RTRIM( ISNULL( CAST (QtdLicencaLogon AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
