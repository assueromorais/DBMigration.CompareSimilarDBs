CREATE TABLE [dbo].[CarteiraImpressa] (
    [idprofissional]        INT           NOT NULL,
    [nome]                  VARCHAR (60)  NOT NULL,
    [datanascimento]        DATETIME      NULL,
    [cpf]                   VARCHAR (11)  NULL,
    [RegistroconselhoAtual] VARCHAR (20)  NULL,
    [RegistroConselho]      VARCHAR (20)  NULL,
    [NomePai]               VARCHAR (50)  NULL,
    [NomeMae]               VARCHAR (50)  NULL,
    [RG]                    VARCHAR (15)  NULL,
    [RGDataEmissao]         DATETIME      NULL,
    [RGOrgaoEmissao]        VARCHAR (10)  NULL,
    [doadorOrgaos]          BIT           NULL,
    [siglaufrg]             CHAR (2)      NULL,
    [DataInicio]            DATETIME      NULL,
    [IdCategoriaProf]       INT           NULL,
    [NomeCategoriaProf]     VARCHAR (40)  NULL,
    [idTipoInscricao]       INT           NULL,
    [TipoInscricao]         VARCHAR (20)  NULL,
    [Naturalidade]          VARCHAR (30)  NULL,
    [nacionalidade]         VARCHAR (30)  NULL,
    [siglauf]               VARCHAR (2)   NULL,
    [NomePresidente]        VARCHAR (50)  NULL,
    [Indeterminada]         BIT           NULL,
    [ImprimeHab]            BIT           NULL,
    [Habilitacao]           VARCHAR (40)  NULL,
    [Especialidade]         VARCHAR (30)  NULL,
    [Regiao]                VARCHAR (3)   NULL,
    [NrCarteira]            VARCHAR (30)  NULL,
    [DtaValIdent]           VARCHAR (13)  NULL,
    [DTValidadeCart]        VARCHAR (13)  NULL,
    [DtExpedicao]           DATETIME      NULL,
    [Processo]              VARCHAR (15)  NULL,
    [NaturalidadeUF]        CHAR (2)      NULL,
    [Jurisdicao]            VARCHAR (30)  NULL,
    [Via]                   VARCHAR (5)   NULL,
    [LocalExpedicao]        VARCHAR (30)  NULL,
    [Observacao]            TEXT          NULL,
    [Cargo]                 VARCHAR (50)  NULL,
    [ImprimeCargoAbaixo]    BIT           NULL,
    [RNE]                   VARCHAR (20)  NULL,
    [ImprimeCarteira]       BIT           NULL,
    [Usuario]               VARCHAR (100) NULL,
    [Reimpressao]           BIT           CONSTRAINT [DF__CarteiraI__Reimp__13CC0336] DEFAULT ((0)) NULL,
    [NatCurriculo]          VARCHAR (250) NULL,
    [CarteiraEstudantil]    BIT           NULL,
    [JurisdicaoSecundaria]  VARCHAR (30)  NULL,
    [ConselhoOrigem]        VARCHAR (20)  NULL,
    [OrdemImpressao]        INT           NULL,
    [IdCarteiraImpressa]    INT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_IdProfissionalCarteiraImpressa] PRIMARY KEY CLUSTERED ([idprofissional] ASC)
);


GO
CREATE TRIGGER [TrgLog_CarteiraImpressa] ON [Implanta_CRPAM].[dbo].[CarteiraImpressa] 
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
SET @TableName = 'CarteiraImpressa'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'idprofissional : «' + RTRIM( ISNULL( CAST (idprofissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| nome : «' + RTRIM( ISNULL( CAST (nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| datanascimento : «' + RTRIM( ISNULL( CONVERT (CHAR, datanascimento, 113 ),'Nulo'))+'» '
                         + '| cpf : «' + RTRIM( ISNULL( CAST (cpf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroconselhoAtual : «' + RTRIM( ISNULL( CAST (RegistroconselhoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConselho : «' + RTRIM( ISNULL( CAST (RegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePai : «' + RTRIM( ISNULL( CAST (NomePai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMae : «' + RTRIM( ISNULL( CAST (NomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RGDataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, RGDataEmissao, 113 ),'Nulo'))+'» '
                         + '| RGOrgaoEmissao : «' + RTRIM( ISNULL( CAST (RGOrgaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  doadorOrgaos IS NULL THEN ' doadorOrgaos : «Nulo» '
                                              WHEN  doadorOrgaos = 0 THEN ' doadorOrgaos : «Falso» '
                                              WHEN  doadorOrgaos = 1 THEN ' doadorOrgaos : «Verdadeiro» '
                                    END 
                         + '| siglaufrg : «' + RTRIM( ISNULL( CAST (siglaufrg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaProf : «' + RTRIM( ISNULL( CAST (NomeCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idTipoInscricao : «' + RTRIM( ISNULL( CAST (idTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoInscricao : «' + RTRIM( ISNULL( CAST (TipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Naturalidade : «' + RTRIM( ISNULL( CAST (Naturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| nacionalidade : «' + RTRIM( ISNULL( CAST (nacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglauf : «' + RTRIM( ISNULL( CAST (siglauf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePresidente : «' + RTRIM( ISNULL( CAST (NomePresidente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Indeterminada IS NULL THEN ' Indeterminada : «Nulo» '
                                              WHEN  Indeterminada = 0 THEN ' Indeterminada : «Falso» '
                                              WHEN  Indeterminada = 1 THEN ' Indeterminada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeHab IS NULL THEN ' ImprimeHab : «Nulo» '
                                              WHEN  ImprimeHab = 0 THEN ' ImprimeHab : «Falso» '
                                              WHEN  ImprimeHab = 1 THEN ' ImprimeHab : «Verdadeiro» '
                                    END 
                         + '| Habilitacao : «' + RTRIM( ISNULL( CAST (Habilitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Especialidade : «' + RTRIM( ISNULL( CAST (Especialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Regiao : «' + RTRIM( ISNULL( CAST (Regiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NrCarteira : «' + RTRIM( ISNULL( CAST (NrCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtaValIdent : «' + RTRIM( ISNULL( CAST (DtaValIdent AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DTValidadeCart : «' + RTRIM( ISNULL( CAST (DTValidadeCart AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtExpedicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtExpedicao, 113 ),'Nulo'))+'» '
                         + '| Processo : «' + RTRIM( ISNULL( CAST (Processo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NaturalidadeUF : «' + RTRIM( ISNULL( CAST (NaturalidadeUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Jurisdicao : «' + RTRIM( ISNULL( CAST (Jurisdicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Via : «' + RTRIM( ISNULL( CAST (Via AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalExpedicao : «' + RTRIM( ISNULL( CAST (LocalExpedicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeCargoAbaixo IS NULL THEN ' ImprimeCargoAbaixo : «Nulo» '
                                              WHEN  ImprimeCargoAbaixo = 0 THEN ' ImprimeCargoAbaixo : «Falso» '
                                              WHEN  ImprimeCargoAbaixo = 1 THEN ' ImprimeCargoAbaixo : «Verdadeiro» '
                                    END 
                         + '| RNE : «' + RTRIM( ISNULL( CAST (RNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeCarteira IS NULL THEN ' ImprimeCarteira : «Nulo» '
                                              WHEN  ImprimeCarteira = 0 THEN ' ImprimeCarteira : «Falso» '
                                              WHEN  ImprimeCarteira = 1 THEN ' ImprimeCarteira : «Verdadeiro» '
                                    END 
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Reimpressao IS NULL THEN ' Reimpressao : «Nulo» '
                                              WHEN  Reimpressao = 0 THEN ' Reimpressao : «Falso» '
                                              WHEN  Reimpressao = 1 THEN ' Reimpressao : «Verdadeiro» '
                                    END 
                         + '| NatCurriculo : «' + RTRIM( ISNULL( CAST (NatCurriculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CarteiraEstudantil IS NULL THEN ' CarteiraEstudantil : «Nulo» '
                                              WHEN  CarteiraEstudantil = 0 THEN ' CarteiraEstudantil : «Falso» '
                                              WHEN  CarteiraEstudantil = 1 THEN ' CarteiraEstudantil : «Verdadeiro» '
                                    END 
                         + '| JurisdicaoSecundaria : «' + RTRIM( ISNULL( CAST (JurisdicaoSecundaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConselhoOrigem : «' + RTRIM( ISNULL( CAST (ConselhoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemImpressao : «' + RTRIM( ISNULL( CAST (OrdemImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCarteiraImpressa : «' + RTRIM( ISNULL( CAST (IdCarteiraImpressa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'idprofissional : «' + RTRIM( ISNULL( CAST (idprofissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| nome : «' + RTRIM( ISNULL( CAST (nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| datanascimento : «' + RTRIM( ISNULL( CONVERT (CHAR, datanascimento, 113 ),'Nulo'))+'» '
                         + '| cpf : «' + RTRIM( ISNULL( CAST (cpf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroconselhoAtual : «' + RTRIM( ISNULL( CAST (RegistroconselhoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConselho : «' + RTRIM( ISNULL( CAST (RegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePai : «' + RTRIM( ISNULL( CAST (NomePai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMae : «' + RTRIM( ISNULL( CAST (NomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RGDataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, RGDataEmissao, 113 ),'Nulo'))+'» '
                         + '| RGOrgaoEmissao : «' + RTRIM( ISNULL( CAST (RGOrgaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  doadorOrgaos IS NULL THEN ' doadorOrgaos : «Nulo» '
                                              WHEN  doadorOrgaos = 0 THEN ' doadorOrgaos : «Falso» '
                                              WHEN  doadorOrgaos = 1 THEN ' doadorOrgaos : «Verdadeiro» '
                                    END 
                         + '| siglaufrg : «' + RTRIM( ISNULL( CAST (siglaufrg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaProf : «' + RTRIM( ISNULL( CAST (NomeCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idTipoInscricao : «' + RTRIM( ISNULL( CAST (idTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoInscricao : «' + RTRIM( ISNULL( CAST (TipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Naturalidade : «' + RTRIM( ISNULL( CAST (Naturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| nacionalidade : «' + RTRIM( ISNULL( CAST (nacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglauf : «' + RTRIM( ISNULL( CAST (siglauf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePresidente : «' + RTRIM( ISNULL( CAST (NomePresidente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Indeterminada IS NULL THEN ' Indeterminada : «Nulo» '
                                              WHEN  Indeterminada = 0 THEN ' Indeterminada : «Falso» '
                                              WHEN  Indeterminada = 1 THEN ' Indeterminada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeHab IS NULL THEN ' ImprimeHab : «Nulo» '
                                              WHEN  ImprimeHab = 0 THEN ' ImprimeHab : «Falso» '
                                              WHEN  ImprimeHab = 1 THEN ' ImprimeHab : «Verdadeiro» '
                                    END 
                         + '| Habilitacao : «' + RTRIM( ISNULL( CAST (Habilitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Especialidade : «' + RTRIM( ISNULL( CAST (Especialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Regiao : «' + RTRIM( ISNULL( CAST (Regiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NrCarteira : «' + RTRIM( ISNULL( CAST (NrCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtaValIdent : «' + RTRIM( ISNULL( CAST (DtaValIdent AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DTValidadeCart : «' + RTRIM( ISNULL( CAST (DTValidadeCart AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtExpedicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtExpedicao, 113 ),'Nulo'))+'» '
                         + '| Processo : «' + RTRIM( ISNULL( CAST (Processo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NaturalidadeUF : «' + RTRIM( ISNULL( CAST (NaturalidadeUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Jurisdicao : «' + RTRIM( ISNULL( CAST (Jurisdicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Via : «' + RTRIM( ISNULL( CAST (Via AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalExpedicao : «' + RTRIM( ISNULL( CAST (LocalExpedicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeCargoAbaixo IS NULL THEN ' ImprimeCargoAbaixo : «Nulo» '
                                              WHEN  ImprimeCargoAbaixo = 0 THEN ' ImprimeCargoAbaixo : «Falso» '
                                              WHEN  ImprimeCargoAbaixo = 1 THEN ' ImprimeCargoAbaixo : «Verdadeiro» '
                                    END 
                         + '| RNE : «' + RTRIM( ISNULL( CAST (RNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeCarteira IS NULL THEN ' ImprimeCarteira : «Nulo» '
                                              WHEN  ImprimeCarteira = 0 THEN ' ImprimeCarteira : «Falso» '
                                              WHEN  ImprimeCarteira = 1 THEN ' ImprimeCarteira : «Verdadeiro» '
                                    END 
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Reimpressao IS NULL THEN ' Reimpressao : «Nulo» '
                                              WHEN  Reimpressao = 0 THEN ' Reimpressao : «Falso» '
                                              WHEN  Reimpressao = 1 THEN ' Reimpressao : «Verdadeiro» '
                                    END 
                         + '| NatCurriculo : «' + RTRIM( ISNULL( CAST (NatCurriculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CarteiraEstudantil IS NULL THEN ' CarteiraEstudantil : «Nulo» '
                                              WHEN  CarteiraEstudantil = 0 THEN ' CarteiraEstudantil : «Falso» '
                                              WHEN  CarteiraEstudantil = 1 THEN ' CarteiraEstudantil : «Verdadeiro» '
                                    END 
                         + '| JurisdicaoSecundaria : «' + RTRIM( ISNULL( CAST (JurisdicaoSecundaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConselhoOrigem : «' + RTRIM( ISNULL( CAST (ConselhoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemImpressao : «' + RTRIM( ISNULL( CAST (OrdemImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCarteiraImpressa : «' + RTRIM( ISNULL( CAST (IdCarteiraImpressa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'idprofissional : «' + RTRIM( ISNULL( CAST (idprofissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| nome : «' + RTRIM( ISNULL( CAST (nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| datanascimento : «' + RTRIM( ISNULL( CONVERT (CHAR, datanascimento, 113 ),'Nulo'))+'» '
                         + '| cpf : «' + RTRIM( ISNULL( CAST (cpf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroconselhoAtual : «' + RTRIM( ISNULL( CAST (RegistroconselhoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConselho : «' + RTRIM( ISNULL( CAST (RegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePai : «' + RTRIM( ISNULL( CAST (NomePai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMae : «' + RTRIM( ISNULL( CAST (NomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RGDataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, RGDataEmissao, 113 ),'Nulo'))+'» '
                         + '| RGOrgaoEmissao : «' + RTRIM( ISNULL( CAST (RGOrgaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  doadorOrgaos IS NULL THEN ' doadorOrgaos : «Nulo» '
                                              WHEN  doadorOrgaos = 0 THEN ' doadorOrgaos : «Falso» '
                                              WHEN  doadorOrgaos = 1 THEN ' doadorOrgaos : «Verdadeiro» '
                                    END 
                         + '| siglaufrg : «' + RTRIM( ISNULL( CAST (siglaufrg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaProf : «' + RTRIM( ISNULL( CAST (NomeCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idTipoInscricao : «' + RTRIM( ISNULL( CAST (idTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoInscricao : «' + RTRIM( ISNULL( CAST (TipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Naturalidade : «' + RTRIM( ISNULL( CAST (Naturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| nacionalidade : «' + RTRIM( ISNULL( CAST (nacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglauf : «' + RTRIM( ISNULL( CAST (siglauf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePresidente : «' + RTRIM( ISNULL( CAST (NomePresidente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Indeterminada IS NULL THEN ' Indeterminada : «Nulo» '
                                              WHEN  Indeterminada = 0 THEN ' Indeterminada : «Falso» '
                                              WHEN  Indeterminada = 1 THEN ' Indeterminada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeHab IS NULL THEN ' ImprimeHab : «Nulo» '
                                              WHEN  ImprimeHab = 0 THEN ' ImprimeHab : «Falso» '
                                              WHEN  ImprimeHab = 1 THEN ' ImprimeHab : «Verdadeiro» '
                                    END 
                         + '| Habilitacao : «' + RTRIM( ISNULL( CAST (Habilitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Especialidade : «' + RTRIM( ISNULL( CAST (Especialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Regiao : «' + RTRIM( ISNULL( CAST (Regiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NrCarteira : «' + RTRIM( ISNULL( CAST (NrCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtaValIdent : «' + RTRIM( ISNULL( CAST (DtaValIdent AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DTValidadeCart : «' + RTRIM( ISNULL( CAST (DTValidadeCart AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtExpedicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtExpedicao, 113 ),'Nulo'))+'» '
                         + '| Processo : «' + RTRIM( ISNULL( CAST (Processo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NaturalidadeUF : «' + RTRIM( ISNULL( CAST (NaturalidadeUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Jurisdicao : «' + RTRIM( ISNULL( CAST (Jurisdicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Via : «' + RTRIM( ISNULL( CAST (Via AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalExpedicao : «' + RTRIM( ISNULL( CAST (LocalExpedicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeCargoAbaixo IS NULL THEN ' ImprimeCargoAbaixo : «Nulo» '
                                              WHEN  ImprimeCargoAbaixo = 0 THEN ' ImprimeCargoAbaixo : «Falso» '
                                              WHEN  ImprimeCargoAbaixo = 1 THEN ' ImprimeCargoAbaixo : «Verdadeiro» '
                                    END 
                         + '| RNE : «' + RTRIM( ISNULL( CAST (RNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeCarteira IS NULL THEN ' ImprimeCarteira : «Nulo» '
                                              WHEN  ImprimeCarteira = 0 THEN ' ImprimeCarteira : «Falso» '
                                              WHEN  ImprimeCarteira = 1 THEN ' ImprimeCarteira : «Verdadeiro» '
                                    END 
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Reimpressao IS NULL THEN ' Reimpressao : «Nulo» '
                                              WHEN  Reimpressao = 0 THEN ' Reimpressao : «Falso» '
                                              WHEN  Reimpressao = 1 THEN ' Reimpressao : «Verdadeiro» '
                                    END 
                         + '| NatCurriculo : «' + RTRIM( ISNULL( CAST (NatCurriculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CarteiraEstudantil IS NULL THEN ' CarteiraEstudantil : «Nulo» '
                                              WHEN  CarteiraEstudantil = 0 THEN ' CarteiraEstudantil : «Falso» '
                                              WHEN  CarteiraEstudantil = 1 THEN ' CarteiraEstudantil : «Verdadeiro» '
                                    END 
                         + '| JurisdicaoSecundaria : «' + RTRIM( ISNULL( CAST (JurisdicaoSecundaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConselhoOrigem : «' + RTRIM( ISNULL( CAST (ConselhoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemImpressao : «' + RTRIM( ISNULL( CAST (OrdemImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCarteiraImpressa : «' + RTRIM( ISNULL( CAST (IdCarteiraImpressa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'idprofissional : «' + RTRIM( ISNULL( CAST (idprofissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| nome : «' + RTRIM( ISNULL( CAST (nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| datanascimento : «' + RTRIM( ISNULL( CONVERT (CHAR, datanascimento, 113 ),'Nulo'))+'» '
                         + '| cpf : «' + RTRIM( ISNULL( CAST (cpf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroconselhoAtual : «' + RTRIM( ISNULL( CAST (RegistroconselhoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConselho : «' + RTRIM( ISNULL( CAST (RegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePai : «' + RTRIM( ISNULL( CAST (NomePai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMae : «' + RTRIM( ISNULL( CAST (NomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RGDataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, RGDataEmissao, 113 ),'Nulo'))+'» '
                         + '| RGOrgaoEmissao : «' + RTRIM( ISNULL( CAST (RGOrgaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  doadorOrgaos IS NULL THEN ' doadorOrgaos : «Nulo» '
                                              WHEN  doadorOrgaos = 0 THEN ' doadorOrgaos : «Falso» '
                                              WHEN  doadorOrgaos = 1 THEN ' doadorOrgaos : «Verdadeiro» '
                                    END 
                         + '| siglaufrg : «' + RTRIM( ISNULL( CAST (siglaufrg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCategoriaProf : «' + RTRIM( ISNULL( CAST (NomeCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idTipoInscricao : «' + RTRIM( ISNULL( CAST (idTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoInscricao : «' + RTRIM( ISNULL( CAST (TipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Naturalidade : «' + RTRIM( ISNULL( CAST (Naturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| nacionalidade : «' + RTRIM( ISNULL( CAST (nacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglauf : «' + RTRIM( ISNULL( CAST (siglauf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePresidente : «' + RTRIM( ISNULL( CAST (NomePresidente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Indeterminada IS NULL THEN ' Indeterminada : «Nulo» '
                                              WHEN  Indeterminada = 0 THEN ' Indeterminada : «Falso» '
                                              WHEN  Indeterminada = 1 THEN ' Indeterminada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImprimeHab IS NULL THEN ' ImprimeHab : «Nulo» '
                                              WHEN  ImprimeHab = 0 THEN ' ImprimeHab : «Falso» '
                                              WHEN  ImprimeHab = 1 THEN ' ImprimeHab : «Verdadeiro» '
                                    END 
                         + '| Habilitacao : «' + RTRIM( ISNULL( CAST (Habilitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Especialidade : «' + RTRIM( ISNULL( CAST (Especialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Regiao : «' + RTRIM( ISNULL( CAST (Regiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NrCarteira : «' + RTRIM( ISNULL( CAST (NrCarteira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtaValIdent : «' + RTRIM( ISNULL( CAST (DtaValIdent AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DTValidadeCart : «' + RTRIM( ISNULL( CAST (DTValidadeCart AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtExpedicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtExpedicao, 113 ),'Nulo'))+'» '
                         + '| Processo : «' + RTRIM( ISNULL( CAST (Processo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NaturalidadeUF : «' + RTRIM( ISNULL( CAST (NaturalidadeUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Jurisdicao : «' + RTRIM( ISNULL( CAST (Jurisdicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Via : «' + RTRIM( ISNULL( CAST (Via AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalExpedicao : «' + RTRIM( ISNULL( CAST (LocalExpedicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeCargoAbaixo IS NULL THEN ' ImprimeCargoAbaixo : «Nulo» '
                                              WHEN  ImprimeCargoAbaixo = 0 THEN ' ImprimeCargoAbaixo : «Falso» '
                                              WHEN  ImprimeCargoAbaixo = 1 THEN ' ImprimeCargoAbaixo : «Verdadeiro» '
                                    END 
                         + '| RNE : «' + RTRIM( ISNULL( CAST (RNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImprimeCarteira IS NULL THEN ' ImprimeCarteira : «Nulo» '
                                              WHEN  ImprimeCarteira = 0 THEN ' ImprimeCarteira : «Falso» '
                                              WHEN  ImprimeCarteira = 1 THEN ' ImprimeCarteira : «Verdadeiro» '
                                    END 
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Reimpressao IS NULL THEN ' Reimpressao : «Nulo» '
                                              WHEN  Reimpressao = 0 THEN ' Reimpressao : «Falso» '
                                              WHEN  Reimpressao = 1 THEN ' Reimpressao : «Verdadeiro» '
                                    END 
                         + '| NatCurriculo : «' + RTRIM( ISNULL( CAST (NatCurriculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CarteiraEstudantil IS NULL THEN ' CarteiraEstudantil : «Nulo» '
                                              WHEN  CarteiraEstudantil = 0 THEN ' CarteiraEstudantil : «Falso» '
                                              WHEN  CarteiraEstudantil = 1 THEN ' CarteiraEstudantil : «Verdadeiro» '
                                    END 
                         + '| JurisdicaoSecundaria : «' + RTRIM( ISNULL( CAST (JurisdicaoSecundaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConselhoOrigem : «' + RTRIM( ISNULL( CAST (ConselhoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemImpressao : «' + RTRIM( ISNULL( CAST (OrdemImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCarteiraImpressa : «' + RTRIM( ISNULL( CAST (IdCarteiraImpressa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
