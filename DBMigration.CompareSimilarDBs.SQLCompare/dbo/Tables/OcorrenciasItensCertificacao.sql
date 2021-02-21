﻿CREATE TABLE [dbo].[OcorrenciasItensCertificacao] (
    [IdItemCertificacaoCertificacao] INT NOT NULL,
    [IdOcorrencia]                   INT NOT NULL,
    CONSTRAINT [FK_OcorrenciasItensCertificacao_ItensCertificacaoCertificacao] FOREIGN KEY ([IdItemCertificacaoCertificacao]) REFERENCES [dbo].[ItensCertificacaoCertificacao] ([IdItemCertificacaoCertificacao]),
    CONSTRAINT [FK_OcorrenciasItensCertificacao_OcorrenciasPessoa1] FOREIGN KEY ([IdOcorrencia]) REFERENCES [dbo].[OcorrenciasPessoa] ([IdOcorrencia])
);


GO
CREATE TRIGGER [TrgLog_OcorrenciasItensCertificacao] ON [Implanta_CRPAM].[dbo].[OcorrenciasItensCertificacao] 
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
SET @TableName = 'OcorrenciasItensCertificacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItemCertificacaoCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacaoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItemCertificacaoCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacaoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItemCertificacaoCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacaoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItemCertificacaoCertificacao : «' + RTRIM( ISNULL( CAST (IdItemCertificacaoCertificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
