CREATE TABLE [dbo].[MapeamentoArquivosJUCEB] (
    [IdMapeamentoArquivosJUCEB] INT           NOT NULL,
    [PlaniliaEmpresas]          VARCHAR (100) NOT NULL,
    [ChaveEmpresa]              VARCHAR (100) NOT NULL,
    [NIREEmpresa]               VARCHAR (100) NOT NULL,
    [NomeEmpresa]               VARCHAR (100) NOT NULL,
    [LogradouroEmpresa]         VARCHAR (100) NOT NULL,
    [LogradouroNrEmpresa]       VARCHAR (100) NOT NULL,
    [ComplementoEmpresa]        VARCHAR (100) NOT NULL,
    [BairroEmpresa]             VARCHAR (100) NOT NULL,
    [CepEmpresa]                VARCHAR (100) NOT NULL,
    [MunicipioEmpresa]          VARCHAR (100) NOT NULL,
    [UFEmpresa]                 VARCHAR (100) NOT NULL,
    [ValorCapitalEmpresa]       VARCHAR (100) NOT NULL,
    [DataConstituicaoEmpresa]   VARCHAR (100) NOT NULL,
    [CNPJEmpresa]               VARCHAR (100) NOT NULL,
    [CNAEEmpresa]               VARCHAR (100) NOT NULL,
    [AtividadesEmpresa]         VARCHAR (100) NOT NULL,
    [PlaniliaSocios]            VARCHAR (100) NOT NULL,
    [ChaveSocio]                VARCHAR (100) NOT NULL,
    [CNPJSocio]                 VARCHAR (100) NOT NULL,
    [EmpresaSocio]              VARCHAR (100) NOT NULL,
    [LogradouroSocio]           VARCHAR (100) NOT NULL,
    [LogradouroNrSocio]         VARCHAR (100) NOT NULL,
    [ComplementoSocio]          VARCHAR (100) NOT NULL,
    [BairroSocio]               VARCHAR (100) NOT NULL,
    [MunicipioSocio]            VARCHAR (100) NOT NULL,
    [ValorCapitalSocio]         VARCHAR (100) NOT NULL,
    [CPFCNPJSocio]              VARCHAR (100) NOT NULL,
    [NomeSocio]                 VARCHAR (100) NOT NULL,
    [VinculoSocio]              VARCHAR (100) NOT NULL,
    [EntradaSocio]              VARCHAR (100) NOT NULL,
    [ParticipacaoSocio]         VARCHAR (100) NOT NULL,
    [UFSocio]                   VARCHAR (100) NULL,
    [CepSocio]                  VARCHAR (100) NULL,
    CONSTRAINT [PK_MapeamentoArquivosJUCEB] PRIMARY KEY CLUSTERED ([IdMapeamentoArquivosJUCEB] ASC)
);


GO
CREATE TRIGGER [TrgLog_MapeamentoArquivosJUCEB] ON [Implanta_CRPAM].[dbo].[MapeamentoArquivosJUCEB] 
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
SET @TableName = 'MapeamentoArquivosJUCEB'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMapeamentoArquivosJUCEB : «' + RTRIM( ISNULL( CAST (IdMapeamentoArquivosJUCEB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PlaniliaEmpresas : «' + RTRIM( ISNULL( CAST (PlaniliaEmpresas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveEmpresa : «' + RTRIM( ISNULL( CAST (ChaveEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIREEmpresa : «' + RTRIM( ISNULL( CAST (NIREEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroEmpresa : «' + RTRIM( ISNULL( CAST (LogradouroEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroNrEmpresa : «' + RTRIM( ISNULL( CAST (LogradouroNrEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEmpresa : «' + RTRIM( ISNULL( CAST (ComplementoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BairroEmpresa : «' + RTRIM( ISNULL( CAST (BairroEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CepEmpresa : «' + RTRIM( ISNULL( CAST (CepEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MunicipioEmpresa : «' + RTRIM( ISNULL( CAST (MunicipioEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFEmpresa : «' + RTRIM( ISNULL( CAST (UFEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapitalEmpresa : «' + RTRIM( ISNULL( CAST (ValorCapitalEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConstituicaoEmpresa : «' + RTRIM( ISNULL( CAST (DataConstituicaoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJEmpresa : «' + RTRIM( ISNULL( CAST (CNPJEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNAEEmpresa : «' + RTRIM( ISNULL( CAST (CNAEEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtividadesEmpresa : «' + RTRIM( ISNULL( CAST (AtividadesEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PlaniliaSocios : «' + RTRIM( ISNULL( CAST (PlaniliaSocios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveSocio : «' + RTRIM( ISNULL( CAST (ChaveSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJSocio : «' + RTRIM( ISNULL( CAST (CNPJSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmpresaSocio : «' + RTRIM( ISNULL( CAST (EmpresaSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroSocio : «' + RTRIM( ISNULL( CAST (LogradouroSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroNrSocio : «' + RTRIM( ISNULL( CAST (LogradouroNrSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoSocio : «' + RTRIM( ISNULL( CAST (ComplementoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BairroSocio : «' + RTRIM( ISNULL( CAST (BairroSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MunicipioSocio : «' + RTRIM( ISNULL( CAST (MunicipioSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapitalSocio : «' + RTRIM( ISNULL( CAST (ValorCapitalSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJSocio : «' + RTRIM( ISNULL( CAST (CPFCNPJSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSocio : «' + RTRIM( ISNULL( CAST (NomeSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VinculoSocio : «' + RTRIM( ISNULL( CAST (VinculoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EntradaSocio : «' + RTRIM( ISNULL( CAST (EntradaSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ParticipacaoSocio : «' + RTRIM( ISNULL( CAST (ParticipacaoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFSocio : «' + RTRIM( ISNULL( CAST (UFSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CepSocio : «' + RTRIM( ISNULL( CAST (CepSocio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMapeamentoArquivosJUCEB : «' + RTRIM( ISNULL( CAST (IdMapeamentoArquivosJUCEB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PlaniliaEmpresas : «' + RTRIM( ISNULL( CAST (PlaniliaEmpresas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveEmpresa : «' + RTRIM( ISNULL( CAST (ChaveEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIREEmpresa : «' + RTRIM( ISNULL( CAST (NIREEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroEmpresa : «' + RTRIM( ISNULL( CAST (LogradouroEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroNrEmpresa : «' + RTRIM( ISNULL( CAST (LogradouroNrEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEmpresa : «' + RTRIM( ISNULL( CAST (ComplementoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BairroEmpresa : «' + RTRIM( ISNULL( CAST (BairroEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CepEmpresa : «' + RTRIM( ISNULL( CAST (CepEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MunicipioEmpresa : «' + RTRIM( ISNULL( CAST (MunicipioEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFEmpresa : «' + RTRIM( ISNULL( CAST (UFEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapitalEmpresa : «' + RTRIM( ISNULL( CAST (ValorCapitalEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConstituicaoEmpresa : «' + RTRIM( ISNULL( CAST (DataConstituicaoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJEmpresa : «' + RTRIM( ISNULL( CAST (CNPJEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNAEEmpresa : «' + RTRIM( ISNULL( CAST (CNAEEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtividadesEmpresa : «' + RTRIM( ISNULL( CAST (AtividadesEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PlaniliaSocios : «' + RTRIM( ISNULL( CAST (PlaniliaSocios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveSocio : «' + RTRIM( ISNULL( CAST (ChaveSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJSocio : «' + RTRIM( ISNULL( CAST (CNPJSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmpresaSocio : «' + RTRIM( ISNULL( CAST (EmpresaSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroSocio : «' + RTRIM( ISNULL( CAST (LogradouroSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroNrSocio : «' + RTRIM( ISNULL( CAST (LogradouroNrSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoSocio : «' + RTRIM( ISNULL( CAST (ComplementoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BairroSocio : «' + RTRIM( ISNULL( CAST (BairroSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MunicipioSocio : «' + RTRIM( ISNULL( CAST (MunicipioSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapitalSocio : «' + RTRIM( ISNULL( CAST (ValorCapitalSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJSocio : «' + RTRIM( ISNULL( CAST (CPFCNPJSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSocio : «' + RTRIM( ISNULL( CAST (NomeSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VinculoSocio : «' + RTRIM( ISNULL( CAST (VinculoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EntradaSocio : «' + RTRIM( ISNULL( CAST (EntradaSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ParticipacaoSocio : «' + RTRIM( ISNULL( CAST (ParticipacaoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFSocio : «' + RTRIM( ISNULL( CAST (UFSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CepSocio : «' + RTRIM( ISNULL( CAST (CepSocio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMapeamentoArquivosJUCEB : «' + RTRIM( ISNULL( CAST (IdMapeamentoArquivosJUCEB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PlaniliaEmpresas : «' + RTRIM( ISNULL( CAST (PlaniliaEmpresas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveEmpresa : «' + RTRIM( ISNULL( CAST (ChaveEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIREEmpresa : «' + RTRIM( ISNULL( CAST (NIREEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroEmpresa : «' + RTRIM( ISNULL( CAST (LogradouroEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroNrEmpresa : «' + RTRIM( ISNULL( CAST (LogradouroNrEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEmpresa : «' + RTRIM( ISNULL( CAST (ComplementoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BairroEmpresa : «' + RTRIM( ISNULL( CAST (BairroEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CepEmpresa : «' + RTRIM( ISNULL( CAST (CepEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MunicipioEmpresa : «' + RTRIM( ISNULL( CAST (MunicipioEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFEmpresa : «' + RTRIM( ISNULL( CAST (UFEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapitalEmpresa : «' + RTRIM( ISNULL( CAST (ValorCapitalEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConstituicaoEmpresa : «' + RTRIM( ISNULL( CAST (DataConstituicaoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJEmpresa : «' + RTRIM( ISNULL( CAST (CNPJEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNAEEmpresa : «' + RTRIM( ISNULL( CAST (CNAEEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtividadesEmpresa : «' + RTRIM( ISNULL( CAST (AtividadesEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PlaniliaSocios : «' + RTRIM( ISNULL( CAST (PlaniliaSocios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveSocio : «' + RTRIM( ISNULL( CAST (ChaveSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJSocio : «' + RTRIM( ISNULL( CAST (CNPJSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmpresaSocio : «' + RTRIM( ISNULL( CAST (EmpresaSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroSocio : «' + RTRIM( ISNULL( CAST (LogradouroSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroNrSocio : «' + RTRIM( ISNULL( CAST (LogradouroNrSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoSocio : «' + RTRIM( ISNULL( CAST (ComplementoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BairroSocio : «' + RTRIM( ISNULL( CAST (BairroSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MunicipioSocio : «' + RTRIM( ISNULL( CAST (MunicipioSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapitalSocio : «' + RTRIM( ISNULL( CAST (ValorCapitalSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJSocio : «' + RTRIM( ISNULL( CAST (CPFCNPJSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSocio : «' + RTRIM( ISNULL( CAST (NomeSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VinculoSocio : «' + RTRIM( ISNULL( CAST (VinculoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EntradaSocio : «' + RTRIM( ISNULL( CAST (EntradaSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ParticipacaoSocio : «' + RTRIM( ISNULL( CAST (ParticipacaoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFSocio : «' + RTRIM( ISNULL( CAST (UFSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CepSocio : «' + RTRIM( ISNULL( CAST (CepSocio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMapeamentoArquivosJUCEB : «' + RTRIM( ISNULL( CAST (IdMapeamentoArquivosJUCEB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PlaniliaEmpresas : «' + RTRIM( ISNULL( CAST (PlaniliaEmpresas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveEmpresa : «' + RTRIM( ISNULL( CAST (ChaveEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIREEmpresa : «' + RTRIM( ISNULL( CAST (NIREEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroEmpresa : «' + RTRIM( ISNULL( CAST (LogradouroEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroNrEmpresa : «' + RTRIM( ISNULL( CAST (LogradouroNrEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEmpresa : «' + RTRIM( ISNULL( CAST (ComplementoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BairroEmpresa : «' + RTRIM( ISNULL( CAST (BairroEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CepEmpresa : «' + RTRIM( ISNULL( CAST (CepEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MunicipioEmpresa : «' + RTRIM( ISNULL( CAST (MunicipioEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFEmpresa : «' + RTRIM( ISNULL( CAST (UFEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapitalEmpresa : «' + RTRIM( ISNULL( CAST (ValorCapitalEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConstituicaoEmpresa : «' + RTRIM( ISNULL( CAST (DataConstituicaoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJEmpresa : «' + RTRIM( ISNULL( CAST (CNPJEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNAEEmpresa : «' + RTRIM( ISNULL( CAST (CNAEEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtividadesEmpresa : «' + RTRIM( ISNULL( CAST (AtividadesEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PlaniliaSocios : «' + RTRIM( ISNULL( CAST (PlaniliaSocios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ChaveSocio : «' + RTRIM( ISNULL( CAST (ChaveSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJSocio : «' + RTRIM( ISNULL( CAST (CNPJSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmpresaSocio : «' + RTRIM( ISNULL( CAST (EmpresaSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroSocio : «' + RTRIM( ISNULL( CAST (LogradouroSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LogradouroNrSocio : «' + RTRIM( ISNULL( CAST (LogradouroNrSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoSocio : «' + RTRIM( ISNULL( CAST (ComplementoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BairroSocio : «' + RTRIM( ISNULL( CAST (BairroSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MunicipioSocio : «' + RTRIM( ISNULL( CAST (MunicipioSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapitalSocio : «' + RTRIM( ISNULL( CAST (ValorCapitalSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJSocio : «' + RTRIM( ISNULL( CAST (CPFCNPJSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSocio : «' + RTRIM( ISNULL( CAST (NomeSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VinculoSocio : «' + RTRIM( ISNULL( CAST (VinculoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EntradaSocio : «' + RTRIM( ISNULL( CAST (EntradaSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ParticipacaoSocio : «' + RTRIM( ISNULL( CAST (ParticipacaoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFSocio : «' + RTRIM( ISNULL( CAST (UFSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CepSocio : «' + RTRIM( ISNULL( CAST (CepSocio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
