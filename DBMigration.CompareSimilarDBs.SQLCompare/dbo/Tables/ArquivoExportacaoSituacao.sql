CREATE TABLE [dbo].[ArquivoExportacaoSituacao] (
    [IdArquivoExportacaoSituacao] INT         IDENTITY (1, 1) NOT NULL,
    [IdArquivoExportacao]         INT         NOT NULL,
    [Ativo]                       BIT         CONSTRAINT [DF_ArquivoExportacaoSituacao_Ativo] DEFAULT ((0)) NOT NULL,
    [IdSituacaoPFPJ]              INT         NULL,
    [Adimplencia]                 VARCHAR (1) NULL,
    CONSTRAINT [PK_ArquivoExportacaoSituacao] PRIMARY KEY CLUSTERED ([IdArquivoExportacaoSituacao] ASC),
    CONSTRAINT [FK_ArquivoExportacaoSituacao_ParArqExp] FOREIGN KEY ([IdArquivoExportacao]) REFERENCES [dbo].[ParametrosArquivoExportacao] ([IdArquivoExportacao]),
    CONSTRAINT [FK_ArquivoExportacaoSituacao_SituacaoPFPJ] FOREIGN KEY ([IdSituacaoPFPJ]) REFERENCES [dbo].[SituacoesPFPJ] ([IdSituacaoPFPJ])
);


GO
CREATE TRIGGER [TrgLog_ArquivoExportacaoSituacao] ON [Implanta_CRPAM].[dbo].[ArquivoExportacaoSituacao] 
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
SET @TableName = 'ArquivoExportacaoSituacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoExportacaoSituacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacaoSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Adimplencia : «' + RTRIM( ISNULL( CAST (Adimplencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoExportacaoSituacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacaoSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Adimplencia : «' + RTRIM( ISNULL( CAST (Adimplencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArquivoExportacaoSituacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacaoSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Adimplencia : «' + RTRIM( ISNULL( CAST (Adimplencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoExportacaoSituacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacaoSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Adimplencia : «' + RTRIM( ISNULL( CAST (Adimplencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
