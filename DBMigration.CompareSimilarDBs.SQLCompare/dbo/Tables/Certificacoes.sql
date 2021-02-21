CREATE TABLE [dbo].[Certificacoes] (
    [IdCertificacao]     INT          IDENTITY (1, 1) NOT NULL,
    [IdPessoa]           INT          NOT NULL,
    [NumeroCertificacao] VARCHAR (15) NOT NULL,
    [IdLicitacao]        INT          NULL,
    [DataValidade]       DATETIME     NULL,
    [Observacoes]        TEXT         NULL,
    [Ativo]              BIT          NULL,
    CONSTRAINT [PK_Certificacoes] PRIMARY KEY NONCLUSTERED ([IdCertificacao] ASC),
    CONSTRAINT [FK_Certificacoes_Licitacoes] FOREIGN KEY ([IdLicitacao]) REFERENCES [dbo].[Licitacoes] ([IdLicitacao]),
    CONSTRAINT [IX_CertificacoesNumeroCertificacaoNumeroLicitacao] UNIQUE NONCLUSTERED ([NumeroCertificacao] ASC, [IdLicitacao] ASC)
);


GO
CREATE TRIGGER [TrgLog_Certificacoes] ON [Implanta_CRPAM].[dbo].[Certificacoes] 
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
SET @TableName = 'Certificacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCertificacao : «' + RTRIM( ISNULL( CAST (IdCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCertificacao : «' + RTRIM( ISNULL( CAST (NumeroCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdCertificacao : «' + RTRIM( ISNULL( CAST (IdCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCertificacao : «' + RTRIM( ISNULL( CAST (NumeroCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdCertificacao : «' + RTRIM( ISNULL( CAST (IdCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCertificacao : «' + RTRIM( ISNULL( CAST (NumeroCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCertificacao : «' + RTRIM( ISNULL( CAST (IdCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCertificacao : «' + RTRIM( ISNULL( CAST (NumeroCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValidade : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidade, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
