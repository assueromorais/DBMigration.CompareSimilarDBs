CREATE TABLE [dbo].[Almoxarifados] (
    [IdAlmoxarifado]   INT          IDENTITY (1, 1) NOT NULL,
    [NomeAlmoxarifado] VARCHAR (60) NOT NULL,
    [Endereco]         VARCHAR (60) NULL,
    [NomeBairro]       VARCHAR (35) NULL,
    [NomeCidade]       VARCHAR (30) NULL,
    [SiglaUF]          VARCHAR (2)  NULL,
    [CEP]              VARCHAR (9)  NULL,
    [NomeContato]      VARCHAR (60) NULL,
    [TelefoneContato]  VARCHAR (30) NULL,
    CONSTRAINT [PK_Almoxarifados] PRIMARY KEY NONCLUSTERED ([IdAlmoxarifado] ASC)
);


GO
CREATE TRIGGER [TrgLog_Almoxarifados] ON [Implanta_CRPAM].[dbo].[Almoxarifados] 
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
SET @TableName = 'Almoxarifados'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAlmoxarifado : «' + RTRIM( ISNULL( CAST (NomeAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneContato : «' + RTRIM( ISNULL( CAST (TelefoneContato AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAlmoxarifado : «' + RTRIM( ISNULL( CAST (NomeAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneContato : «' + RTRIM( ISNULL( CAST (TelefoneContato AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAlmoxarifado : «' + RTRIM( ISNULL( CAST (NomeAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneContato : «' + RTRIM( ISNULL( CAST (TelefoneContato AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAlmoxarifado : «' + RTRIM( ISNULL( CAST (NomeAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneContato : «' + RTRIM( ISNULL( CAST (TelefoneContato AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
