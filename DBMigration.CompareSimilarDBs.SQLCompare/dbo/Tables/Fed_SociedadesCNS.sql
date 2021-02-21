CREATE TABLE [dbo].[Fed_SociedadesCNS] (
    [IdCNS]        INT           NULL,
    [CodiSituProc] INT           NULL,
    [DscSituProc]  VARCHAR (250) NULL,
    [NumrProt]     VARCHAR (250) NULL,
    [DataAbert]    DATETIME      NULL,
    [DataConc]     DATETIME      NULL,
    [IdSoci]       INT           NULL,
    [IdSociPai]    INT           NULL,
    [NumSegu]      INT           NULL,
    [CodSituSoci]  INT           NULL,
    [DescSoci]     VARCHAR (250) NULL,
    [NomeSoci]     VARCHAR (250) NULL,
    [Cnpj]         VARCHAR (250) NULL,
    [Email]        VARCHAR (250) NULL,
    [Website]      VARCHAR (250) NULL,
    [Capi]         MONEY         NULL,
    [Quot]         INT           NULL,
    [NumrCep]      VARCHAR (250) NULL,
    [Logr]         VARCHAR (250) NULL,
    [Bairr]        VARCHAR (250) NULL,
    [NumrEnde]     VARCHAR (250) NULL,
    [Compl]        VARCHAR (250) NULL,
    [Cidade]       VARCHAR (250) NULL,
    [FiliSoci]     INT           NULL,
    [DissCotr]     INT           NULL,
    [Socio]        VARCHAR (250) NULL,
    [CPF]          VARCHAR (11)  NULL,
    [DscTipoSoc]   VARCHAR (250) NULL,
    [dSCsITUsOC]   VARCHAR (250) NULL,
    [DataEntr]     DATETIME      NULL,
    [DataSaid]     DATETIME      NULL
);


GO
CREATE TRIGGER [TrgLog_Fed_SociedadesCNS] ON [Implanta_CRPAM].[dbo].[Fed_SociedadesCNS] 
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
SET @TableName = 'Fed_SociedadesCNS'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCNS : «' + RTRIM( ISNULL( CAST (IdCNS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiSituProc : «' + RTRIM( ISNULL( CAST (CodiSituProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscSituProc : «' + RTRIM( ISNULL( CAST (DscSituProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrProt : «' + RTRIM( ISNULL( CAST (NumrProt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAbert : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAbert, 113 ),'Nulo'))+'» '
                         + '| DataConc : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConc, 113 ),'Nulo'))+'» '
                         + '| IdSoci : «' + RTRIM( ISNULL( CAST (IdSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSociPai : «' + RTRIM( ISNULL( CAST (IdSociPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumSegu : «' + RTRIM( ISNULL( CAST (NumSegu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSituSoci : «' + RTRIM( ISNULL( CAST (CodSituSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescSoci : «' + RTRIM( ISNULL( CAST (DescSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSoci : «' + RTRIM( ISNULL( CAST (NomeSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cnpj : «' + RTRIM( ISNULL( CAST (Cnpj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Email : «' + RTRIM( ISNULL( CAST (Email AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Website : «' + RTRIM( ISNULL( CAST (Website AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Capi : «' + RTRIM( ISNULL( CAST (Capi AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quot : «' + RTRIM( ISNULL( CAST (Quot AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrCep : «' + RTRIM( ISNULL( CAST (NumrCep AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logr : «' + RTRIM( ISNULL( CAST (Logr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairr : «' + RTRIM( ISNULL( CAST (Bairr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrEnde : «' + RTRIM( ISNULL( CAST (NumrEnde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Compl : «' + RTRIM( ISNULL( CAST (Compl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiliSoci : «' + RTRIM( ISNULL( CAST (FiliSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DissCotr : «' + RTRIM( ISNULL( CAST (DissCotr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Socio : «' + RTRIM( ISNULL( CAST (Socio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscTipoSoc : «' + RTRIM( ISNULL( CAST (DscTipoSoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| dSCsITUsOC : «' + RTRIM( ISNULL( CAST (dSCsITUsOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntr : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntr, 113 ),'Nulo'))+'» '
                         + '| DataSaid : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaid, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCNS : «' + RTRIM( ISNULL( CAST (IdCNS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiSituProc : «' + RTRIM( ISNULL( CAST (CodiSituProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscSituProc : «' + RTRIM( ISNULL( CAST (DscSituProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrProt : «' + RTRIM( ISNULL( CAST (NumrProt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAbert : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAbert, 113 ),'Nulo'))+'» '
                         + '| DataConc : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConc, 113 ),'Nulo'))+'» '
                         + '| IdSoci : «' + RTRIM( ISNULL( CAST (IdSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSociPai : «' + RTRIM( ISNULL( CAST (IdSociPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumSegu : «' + RTRIM( ISNULL( CAST (NumSegu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSituSoci : «' + RTRIM( ISNULL( CAST (CodSituSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescSoci : «' + RTRIM( ISNULL( CAST (DescSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSoci : «' + RTRIM( ISNULL( CAST (NomeSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cnpj : «' + RTRIM( ISNULL( CAST (Cnpj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Email : «' + RTRIM( ISNULL( CAST (Email AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Website : «' + RTRIM( ISNULL( CAST (Website AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Capi : «' + RTRIM( ISNULL( CAST (Capi AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quot : «' + RTRIM( ISNULL( CAST (Quot AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrCep : «' + RTRIM( ISNULL( CAST (NumrCep AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logr : «' + RTRIM( ISNULL( CAST (Logr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairr : «' + RTRIM( ISNULL( CAST (Bairr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrEnde : «' + RTRIM( ISNULL( CAST (NumrEnde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Compl : «' + RTRIM( ISNULL( CAST (Compl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiliSoci : «' + RTRIM( ISNULL( CAST (FiliSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DissCotr : «' + RTRIM( ISNULL( CAST (DissCotr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Socio : «' + RTRIM( ISNULL( CAST (Socio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscTipoSoc : «' + RTRIM( ISNULL( CAST (DscTipoSoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| dSCsITUsOC : «' + RTRIM( ISNULL( CAST (dSCsITUsOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntr : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntr, 113 ),'Nulo'))+'» '
                         + '| DataSaid : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaid, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCNS : «' + RTRIM( ISNULL( CAST (IdCNS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiSituProc : «' + RTRIM( ISNULL( CAST (CodiSituProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscSituProc : «' + RTRIM( ISNULL( CAST (DscSituProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrProt : «' + RTRIM( ISNULL( CAST (NumrProt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAbert : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAbert, 113 ),'Nulo'))+'» '
                         + '| DataConc : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConc, 113 ),'Nulo'))+'» '
                         + '| IdSoci : «' + RTRIM( ISNULL( CAST (IdSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSociPai : «' + RTRIM( ISNULL( CAST (IdSociPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumSegu : «' + RTRIM( ISNULL( CAST (NumSegu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSituSoci : «' + RTRIM( ISNULL( CAST (CodSituSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescSoci : «' + RTRIM( ISNULL( CAST (DescSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSoci : «' + RTRIM( ISNULL( CAST (NomeSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cnpj : «' + RTRIM( ISNULL( CAST (Cnpj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Email : «' + RTRIM( ISNULL( CAST (Email AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Website : «' + RTRIM( ISNULL( CAST (Website AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Capi : «' + RTRIM( ISNULL( CAST (Capi AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quot : «' + RTRIM( ISNULL( CAST (Quot AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrCep : «' + RTRIM( ISNULL( CAST (NumrCep AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logr : «' + RTRIM( ISNULL( CAST (Logr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairr : «' + RTRIM( ISNULL( CAST (Bairr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrEnde : «' + RTRIM( ISNULL( CAST (NumrEnde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Compl : «' + RTRIM( ISNULL( CAST (Compl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiliSoci : «' + RTRIM( ISNULL( CAST (FiliSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DissCotr : «' + RTRIM( ISNULL( CAST (DissCotr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Socio : «' + RTRIM( ISNULL( CAST (Socio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscTipoSoc : «' + RTRIM( ISNULL( CAST (DscTipoSoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| dSCsITUsOC : «' + RTRIM( ISNULL( CAST (dSCsITUsOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntr : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntr, 113 ),'Nulo'))+'» '
                         + '| DataSaid : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaid, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCNS : «' + RTRIM( ISNULL( CAST (IdCNS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiSituProc : «' + RTRIM( ISNULL( CAST (CodiSituProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscSituProc : «' + RTRIM( ISNULL( CAST (DscSituProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrProt : «' + RTRIM( ISNULL( CAST (NumrProt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAbert : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAbert, 113 ),'Nulo'))+'» '
                         + '| DataConc : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConc, 113 ),'Nulo'))+'» '
                         + '| IdSoci : «' + RTRIM( ISNULL( CAST (IdSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSociPai : «' + RTRIM( ISNULL( CAST (IdSociPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumSegu : «' + RTRIM( ISNULL( CAST (NumSegu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSituSoci : «' + RTRIM( ISNULL( CAST (CodSituSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescSoci : «' + RTRIM( ISNULL( CAST (DescSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSoci : «' + RTRIM( ISNULL( CAST (NomeSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cnpj : «' + RTRIM( ISNULL( CAST (Cnpj AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Email : «' + RTRIM( ISNULL( CAST (Email AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Website : «' + RTRIM( ISNULL( CAST (Website AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Capi : «' + RTRIM( ISNULL( CAST (Capi AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quot : «' + RTRIM( ISNULL( CAST (Quot AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrCep : «' + RTRIM( ISNULL( CAST (NumrCep AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logr : «' + RTRIM( ISNULL( CAST (Logr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairr : «' + RTRIM( ISNULL( CAST (Bairr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumrEnde : «' + RTRIM( ISNULL( CAST (NumrEnde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Compl : «' + RTRIM( ISNULL( CAST (Compl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FiliSoci : «' + RTRIM( ISNULL( CAST (FiliSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DissCotr : «' + RTRIM( ISNULL( CAST (DissCotr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Socio : «' + RTRIM( ISNULL( CAST (Socio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscTipoSoc : «' + RTRIM( ISNULL( CAST (DscTipoSoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| dSCsITUsOC : «' + RTRIM( ISNULL( CAST (dSCsITUsOC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntr : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntr, 113 ),'Nulo'))+'» '
                         + '| DataSaid : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaid, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
