CREATE TABLE [dbo].[MalaDiretaEnvio] (
    [IdMalaDiretaEnvio]  INT            IDENTITY (1, 1) NOT NULL,
    [IdMalaDiretaConfig] INT            NULL,
    [IdProfissional]     INT            NULL,
    [IdPessoaJuridica]   INT            NULL,
    [IdPessoa]           INT            NULL,
    [DataEnviar]         DATETIME       NULL,
    [Enviar]             BIT            CONSTRAINT [DEF_MalaDiretaEnvioEnviar] DEFAULT ((1)) NOT NULL,
    [Enviado]            BIT            CONSTRAINT [DEF_MalaDiretaEnvioEnviado] DEFAULT ((0)) NOT NULL,
    [DataEnviou]         DATETIME       NULL,
    [RetornoEnvio]       VARCHAR (8000) NULL,
    [IdDetalheEmissao]   INT            NULL,
    CONSTRAINT [PK_MalaDiretaEnvio] PRIMARY KEY CLUSTERED ([IdMalaDiretaEnvio] ASC),
    CONSTRAINT [FK_MalaDiretaEnvio_MalaDiretaConfig] FOREIGN KEY ([IdMalaDiretaConfig]) REFERENCES [dbo].[MalaDiretaConfig] ([IdMalaDiretaConfig]),
    CONSTRAINT [FK_MalaDiretaEnvio_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_MalaDiretaEnvio_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_MalaDiretaEnvio_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_MalaDiretaEnvio] ON [Implanta_CRPAM].[dbo].[MalaDiretaEnvio] 
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
SET @TableName = 'MalaDiretaEnvio'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMalaDiretaEnvio : «' + RTRIM( ISNULL( CAST (IdMalaDiretaEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMalaDiretaConfig : «' + RTRIM( ISNULL( CAST (IdMalaDiretaConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnviar : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnviar, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviar IS NULL THEN ' Enviar : «Nulo» '
                                              WHEN  Enviar = 0 THEN ' Enviar : «Falso» '
                                              WHEN  Enviar = 1 THEN ' Enviar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END 
                         + '| DataEnviou : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnviou, 113 ),'Nulo'))+'» '
                         + '| RetornoEnvio : «' + RTRIM( ISNULL( CAST (RetornoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMalaDiretaEnvio : «' + RTRIM( ISNULL( CAST (IdMalaDiretaEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMalaDiretaConfig : «' + RTRIM( ISNULL( CAST (IdMalaDiretaConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnviar : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnviar, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviar IS NULL THEN ' Enviar : «Nulo» '
                                              WHEN  Enviar = 0 THEN ' Enviar : «Falso» '
                                              WHEN  Enviar = 1 THEN ' Enviar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END 
                         + '| DataEnviou : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnviou, 113 ),'Nulo'))+'» '
                         + '| RetornoEnvio : «' + RTRIM( ISNULL( CAST (RetornoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMalaDiretaEnvio : «' + RTRIM( ISNULL( CAST (IdMalaDiretaEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMalaDiretaConfig : «' + RTRIM( ISNULL( CAST (IdMalaDiretaConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnviar : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnviar, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviar IS NULL THEN ' Enviar : «Nulo» '
                                              WHEN  Enviar = 0 THEN ' Enviar : «Falso» '
                                              WHEN  Enviar = 1 THEN ' Enviar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END 
                         + '| DataEnviou : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnviou, 113 ),'Nulo'))+'» '
                         + '| RetornoEnvio : «' + RTRIM( ISNULL( CAST (RetornoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMalaDiretaEnvio : «' + RTRIM( ISNULL( CAST (IdMalaDiretaEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMalaDiretaConfig : «' + RTRIM( ISNULL( CAST (IdMalaDiretaConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnviar : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnviar, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviar IS NULL THEN ' Enviar : «Nulo» '
                                              WHEN  Enviar = 0 THEN ' Enviar : «Falso» '
                                              WHEN  Enviar = 1 THEN ' Enviar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END 
                         + '| DataEnviou : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnviou, 113 ),'Nulo'))+'» '
                         + '| RetornoEnvio : «' + RTRIM( ISNULL( CAST (RetornoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
