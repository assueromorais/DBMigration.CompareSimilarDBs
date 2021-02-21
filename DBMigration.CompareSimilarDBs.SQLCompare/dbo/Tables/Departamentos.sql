CREATE TABLE [dbo].[Departamentos] (
    [IdDepto]           INT          IDENTITY (1, 1) NOT NULL,
    [NomeDepto]         VARCHAR (60) NOT NULL,
    [CodigoDepto]       VARCHAR (9)  NULL,
    [SiglaDepto]        VARCHAR (15) NULL,
    [Endereco]          VARCHAR (60) NULL,
    [NomeBairro]        VARCHAR (35) NULL,
    [NomeCidade]        VARCHAR (30) NULL,
    [CEP]               VARCHAR (9)  NULL,
    [NomeContato]       VARCHAR (60) NULL,
    [TelefoneContato]   VARCHAR (30) NULL,
    [IdDeptoSuperior]   INT          NULL,
    [Desativado]        BIT          CONSTRAINT [DF_DepartamentosDesativado] DEFAULT ((0)) NULL,
    [IdUsuarioPadrao]   INT          NULL,
    [SiglaUF]           CHAR (2)     NULL,
    [PermTipoInscricao] BIT          DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Departamentos] PRIMARY KEY CLUSTERED ([IdDepto] ASC),
    CONSTRAINT [FK_Departamentos_Departamentos] FOREIGN KEY ([IdDeptoSuperior]) REFERENCES [dbo].[Departamentos] ([IdDepto])
);


GO
CREATE TRIGGER [TrgLog_Departamentos] ON [Implanta_CRPAM].[dbo].[Departamentos] 
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
SET @TableName = 'Departamentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDepto : «' + RTRIM( ISNULL( CAST (IdDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeDepto : «' + RTRIM( ISNULL( CAST (NomeDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoDepto : «' + RTRIM( ISNULL( CAST (CodigoDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaDepto : «' + RTRIM( ISNULL( CAST (SiglaDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneContato : «' + RTRIM( ISNULL( CAST (TelefoneContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptoSuperior : «' + RTRIM( ISNULL( CAST (IdDeptoSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdUsuarioPadrao : «' + RTRIM( ISNULL( CAST (IdUsuarioPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermTipoInscricao IS NULL THEN ' PermTipoInscricao : «Nulo» '
                                              WHEN  PermTipoInscricao = 0 THEN ' PermTipoInscricao : «Falso» '
                                              WHEN  PermTipoInscricao = 1 THEN ' PermTipoInscricao : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdDepto : «' + RTRIM( ISNULL( CAST (IdDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeDepto : «' + RTRIM( ISNULL( CAST (NomeDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoDepto : «' + RTRIM( ISNULL( CAST (CodigoDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaDepto : «' + RTRIM( ISNULL( CAST (SiglaDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneContato : «' + RTRIM( ISNULL( CAST (TelefoneContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptoSuperior : «' + RTRIM( ISNULL( CAST (IdDeptoSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdUsuarioPadrao : «' + RTRIM( ISNULL( CAST (IdUsuarioPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermTipoInscricao IS NULL THEN ' PermTipoInscricao : «Nulo» '
                                              WHEN  PermTipoInscricao = 0 THEN ' PermTipoInscricao : «Falso» '
                                              WHEN  PermTipoInscricao = 1 THEN ' PermTipoInscricao : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdDepto : «' + RTRIM( ISNULL( CAST (IdDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeDepto : «' + RTRIM( ISNULL( CAST (NomeDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoDepto : «' + RTRIM( ISNULL( CAST (CodigoDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaDepto : «' + RTRIM( ISNULL( CAST (SiglaDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneContato : «' + RTRIM( ISNULL( CAST (TelefoneContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptoSuperior : «' + RTRIM( ISNULL( CAST (IdDeptoSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdUsuarioPadrao : «' + RTRIM( ISNULL( CAST (IdUsuarioPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermTipoInscricao IS NULL THEN ' PermTipoInscricao : «Nulo» '
                                              WHEN  PermTipoInscricao = 0 THEN ' PermTipoInscricao : «Falso» '
                                              WHEN  PermTipoInscricao = 1 THEN ' PermTipoInscricao : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDepto : «' + RTRIM( ISNULL( CAST (IdDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeDepto : «' + RTRIM( ISNULL( CAST (NomeDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoDepto : «' + RTRIM( ISNULL( CAST (CodigoDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaDepto : «' + RTRIM( ISNULL( CAST (SiglaDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneContato : «' + RTRIM( ISNULL( CAST (TelefoneContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptoSuperior : «' + RTRIM( ISNULL( CAST (IdDeptoSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdUsuarioPadrao : «' + RTRIM( ISNULL( CAST (IdUsuarioPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermTipoInscricao IS NULL THEN ' PermTipoInscricao : «Nulo» '
                                              WHEN  PermTipoInscricao = 0 THEN ' PermTipoInscricao : «Falso» '
                                              WHEN  PermTipoInscricao = 1 THEN ' PermTipoInscricao : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
