CREATE TABLE [dbo].[LocaisTramitacao] (
    [IdLocalTramitacao] INT          IDENTITY (1, 1) NOT NULL,
    [LocalTramitacao]   VARCHAR (40) NOT NULL,
    [Endereco]          VARCHAR (60) NULL,
    [Bairro]            VARCHAR (40) NULL,
    [IdCidade]          INT          NULL,
    [CEP]               VARCHAR (8)  NULL,
    [PessoaContato]     VARCHAR (60) NULL,
    [Telefone]          VARCHAR (50) NULL,
    [IdEstado]          INT          NULL,
    [Desativado]        BIT          CONSTRAINT [DF_LocaisTramitacaoDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_LocalAcomp] PRIMARY KEY CLUSTERED ([IdLocalTramitacao] ASC),
    CONSTRAINT [FK_LocaisTramitacao_Cidades] FOREIGN KEY ([IdCidade]) REFERENCES [dbo].[Cidades] ([IdCidade]),
    CONSTRAINT [FK_LocaisTramitacao_Estados] FOREIGN KEY ([IdEstado]) REFERENCES [dbo].[Estados] ([IdEstado])
);


GO
CREATE TRIGGER [TrgLog_LocaisTramitacao] ON [Implanta_CRPAM].[dbo].[LocaisTramitacao] 
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
SET @TableName = 'LocaisTramitacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalTramitacao : «' + RTRIM( ISNULL( CAST (LocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PessoaContato : «' + RTRIM( ISNULL( CAST (PessoaContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Telefone : «' + RTRIM( ISNULL( CAST (Telefone AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalTramitacao : «' + RTRIM( ISNULL( CAST (LocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PessoaContato : «' + RTRIM( ISNULL( CAST (PessoaContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Telefone : «' + RTRIM( ISNULL( CAST (Telefone AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalTramitacao : «' + RTRIM( ISNULL( CAST (LocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PessoaContato : «' + RTRIM( ISNULL( CAST (PessoaContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Telefone : «' + RTRIM( ISNULL( CAST (Telefone AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLocalTramitacao : «' + RTRIM( ISNULL( CAST (IdLocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LocalTramitacao : «' + RTRIM( ISNULL( CAST (LocalTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PessoaContato : «' + RTRIM( ISNULL( CAST (PessoaContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Telefone : «' + RTRIM( ISNULL( CAST (Telefone AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
