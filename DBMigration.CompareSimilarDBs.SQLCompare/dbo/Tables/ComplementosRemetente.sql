CREATE TABLE [dbo].[ComplementosRemetente] (
    [IdComplementoRemetente] INT          IDENTITY (1, 1) NOT NULL,
    [IdProfissional]         INT          NULL,
    [IdPessoaJuridica]       INT          NULL,
    [IdPessoa]               INT          NULL,
    [ComplementoRemetente]   VARCHAR (50) NULL,
    [ComplementoPadrao]      BIT          NULL,
    PRIMARY KEY CLUSTERED ([IdComplementoRemetente] ASC),
    CONSTRAINT [FK_ComplementosRemetente_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_ComplementosRemetente_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_ComplementosRemetente_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_ComplementosRemetente] ON [Implanta_CRPAM].[dbo].[ComplementosRemetente] 
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
SET @TableName = 'ComplementosRemetente'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdComplementoRemetente : «' + RTRIM( ISNULL( CAST (IdComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoRemetente : «' + RTRIM( ISNULL( CAST (ComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ComplementoPadrao IS NULL THEN ' ComplementoPadrao : «Nulo» '
                                              WHEN  ComplementoPadrao = 0 THEN ' ComplementoPadrao : «Falso» '
                                              WHEN  ComplementoPadrao = 1 THEN ' ComplementoPadrao : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdComplementoRemetente : «' + RTRIM( ISNULL( CAST (IdComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoRemetente : «' + RTRIM( ISNULL( CAST (ComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ComplementoPadrao IS NULL THEN ' ComplementoPadrao : «Nulo» '
                                              WHEN  ComplementoPadrao = 0 THEN ' ComplementoPadrao : «Falso» '
                                              WHEN  ComplementoPadrao = 1 THEN ' ComplementoPadrao : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdComplementoRemetente : «' + RTRIM( ISNULL( CAST (IdComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoRemetente : «' + RTRIM( ISNULL( CAST (ComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ComplementoPadrao IS NULL THEN ' ComplementoPadrao : «Nulo» '
                                              WHEN  ComplementoPadrao = 0 THEN ' ComplementoPadrao : «Falso» '
                                              WHEN  ComplementoPadrao = 1 THEN ' ComplementoPadrao : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdComplementoRemetente : «' + RTRIM( ISNULL( CAST (IdComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoRemetente : «' + RTRIM( ISNULL( CAST (ComplementoRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ComplementoPadrao IS NULL THEN ' ComplementoPadrao : «Nulo» '
                                              WHEN  ComplementoPadrao = 0 THEN ' ComplementoPadrao : «Falso» '
                                              WHEN  ComplementoPadrao = 1 THEN ' ComplementoPadrao : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
