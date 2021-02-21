CREATE TABLE [dbo].[CamposArquivoExportacao] (
    [IdCampoExportacao]   INT          IDENTITY (1, 1) NOT NULL,
    [IdArquivoExportacao] INT          NOT NULL,
    [TipoRegistro]        INT          NOT NULL,
    [Obrigatoriedade]     BIT          NOT NULL,
    [NomeCampo]           VARCHAR (40) NOT NULL,
    [TamanhoCampo]        INT          NOT NULL,
    [TipoCampo]           VARCHAR (20) NOT NULL,
    [Sequencia]           INT          NOT NULL,
    [NomeTabela]          VARCHAR (35) NULL,
    [Dominio]             VARCHAR (20) NULL,
    [TipoTratamentoCampo] INT          NULL,
    [DominioTXT]          TEXT         NULL,
    [PossuiEquivalencia]  BIT          CONSTRAINT [DF__CamposArq__Possu__7529B0C0] DEFAULT ((0)) NOT NULL,
    [RetornaNoArqErro]    BIT          CONSTRAINT [DF__CamposArq__Retor__761DD4F9] DEFAULT ((0)) NOT NULL,
    [RetornaNumAlfaEquiv] BIT          NULL,
    CONSTRAINT [PK_CamposArquivoExportacao] PRIMARY KEY CLUSTERED ([IdCampoExportacao] ASC),
    CONSTRAINT [FK_CamposArquivoExportacao_ArquivosExportacao] FOREIGN KEY ([IdArquivoExportacao]) REFERENCES [dbo].[ArquivosExportacao] ([IdArquivoExportacao])
);


GO
CREATE TRIGGER [TrgLog_CamposArquivoExportacao] ON [Implanta_CRPAM].[dbo].[CamposArquivoExportacao] 
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
SET @TableName = 'CamposArquivoExportacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCampoExportacao : «' + RTRIM( ISNULL( CAST (IdCampoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatoriedade IS NULL THEN ' Obrigatoriedade : «Nulo» '
                                              WHEN  Obrigatoriedade = 0 THEN ' Obrigatoriedade : «Falso» '
                                              WHEN  Obrigatoriedade = 1 THEN ' Obrigatoriedade : «Verdadeiro» '
                                    END 
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoCampo : «' + RTRIM( ISNULL( CAST (TamanhoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCampo : «' + RTRIM( ISNULL( CAST (TipoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Dominio : «' + RTRIM( ISNULL( CAST (Dominio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoTratamentoCampo : «' + RTRIM( ISNULL( CAST (TipoTratamentoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PossuiEquivalencia IS NULL THEN ' PossuiEquivalencia : «Nulo» '
                                              WHEN  PossuiEquivalencia = 0 THEN ' PossuiEquivalencia : «Falso» '
                                              WHEN  PossuiEquivalencia = 1 THEN ' PossuiEquivalencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RetornaNoArqErro IS NULL THEN ' RetornaNoArqErro : «Nulo» '
                                              WHEN  RetornaNoArqErro = 0 THEN ' RetornaNoArqErro : «Falso» '
                                              WHEN  RetornaNoArqErro = 1 THEN ' RetornaNoArqErro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RetornaNumAlfaEquiv IS NULL THEN ' RetornaNumAlfaEquiv : «Nulo» '
                                              WHEN  RetornaNumAlfaEquiv = 0 THEN ' RetornaNumAlfaEquiv : «Falso» '
                                              WHEN  RetornaNumAlfaEquiv = 1 THEN ' RetornaNumAlfaEquiv : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdCampoExportacao : «' + RTRIM( ISNULL( CAST (IdCampoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatoriedade IS NULL THEN ' Obrigatoriedade : «Nulo» '
                                              WHEN  Obrigatoriedade = 0 THEN ' Obrigatoriedade : «Falso» '
                                              WHEN  Obrigatoriedade = 1 THEN ' Obrigatoriedade : «Verdadeiro» '
                                    END 
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoCampo : «' + RTRIM( ISNULL( CAST (TamanhoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCampo : «' + RTRIM( ISNULL( CAST (TipoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Dominio : «' + RTRIM( ISNULL( CAST (Dominio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoTratamentoCampo : «' + RTRIM( ISNULL( CAST (TipoTratamentoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PossuiEquivalencia IS NULL THEN ' PossuiEquivalencia : «Nulo» '
                                              WHEN  PossuiEquivalencia = 0 THEN ' PossuiEquivalencia : «Falso» '
                                              WHEN  PossuiEquivalencia = 1 THEN ' PossuiEquivalencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RetornaNoArqErro IS NULL THEN ' RetornaNoArqErro : «Nulo» '
                                              WHEN  RetornaNoArqErro = 0 THEN ' RetornaNoArqErro : «Falso» '
                                              WHEN  RetornaNoArqErro = 1 THEN ' RetornaNoArqErro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RetornaNumAlfaEquiv IS NULL THEN ' RetornaNumAlfaEquiv : «Nulo» '
                                              WHEN  RetornaNumAlfaEquiv = 0 THEN ' RetornaNumAlfaEquiv : «Falso» '
                                              WHEN  RetornaNumAlfaEquiv = 1 THEN ' RetornaNumAlfaEquiv : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdCampoExportacao : «' + RTRIM( ISNULL( CAST (IdCampoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatoriedade IS NULL THEN ' Obrigatoriedade : «Nulo» '
                                              WHEN  Obrigatoriedade = 0 THEN ' Obrigatoriedade : «Falso» '
                                              WHEN  Obrigatoriedade = 1 THEN ' Obrigatoriedade : «Verdadeiro» '
                                    END 
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoCampo : «' + RTRIM( ISNULL( CAST (TamanhoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCampo : «' + RTRIM( ISNULL( CAST (TipoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Dominio : «' + RTRIM( ISNULL( CAST (Dominio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoTratamentoCampo : «' + RTRIM( ISNULL( CAST (TipoTratamentoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PossuiEquivalencia IS NULL THEN ' PossuiEquivalencia : «Nulo» '
                                              WHEN  PossuiEquivalencia = 0 THEN ' PossuiEquivalencia : «Falso» '
                                              WHEN  PossuiEquivalencia = 1 THEN ' PossuiEquivalencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RetornaNoArqErro IS NULL THEN ' RetornaNoArqErro : «Nulo» '
                                              WHEN  RetornaNoArqErro = 0 THEN ' RetornaNoArqErro : «Falso» '
                                              WHEN  RetornaNoArqErro = 1 THEN ' RetornaNoArqErro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RetornaNumAlfaEquiv IS NULL THEN ' RetornaNumAlfaEquiv : «Nulo» '
                                              WHEN  RetornaNumAlfaEquiv = 0 THEN ' RetornaNumAlfaEquiv : «Falso» '
                                              WHEN  RetornaNumAlfaEquiv = 1 THEN ' RetornaNumAlfaEquiv : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCampoExportacao : «' + RTRIM( ISNULL( CAST (IdCampoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatoriedade IS NULL THEN ' Obrigatoriedade : «Nulo» '
                                              WHEN  Obrigatoriedade = 0 THEN ' Obrigatoriedade : «Falso» '
                                              WHEN  Obrigatoriedade = 1 THEN ' Obrigatoriedade : «Verdadeiro» '
                                    END 
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoCampo : «' + RTRIM( ISNULL( CAST (TamanhoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCampo : «' + RTRIM( ISNULL( CAST (TipoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Dominio : «' + RTRIM( ISNULL( CAST (Dominio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoTratamentoCampo : «' + RTRIM( ISNULL( CAST (TipoTratamentoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PossuiEquivalencia IS NULL THEN ' PossuiEquivalencia : «Nulo» '
                                              WHEN  PossuiEquivalencia = 0 THEN ' PossuiEquivalencia : «Falso» '
                                              WHEN  PossuiEquivalencia = 1 THEN ' PossuiEquivalencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RetornaNoArqErro IS NULL THEN ' RetornaNoArqErro : «Nulo» '
                                              WHEN  RetornaNoArqErro = 0 THEN ' RetornaNoArqErro : «Falso» '
                                              WHEN  RetornaNoArqErro = 1 THEN ' RetornaNoArqErro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RetornaNumAlfaEquiv IS NULL THEN ' RetornaNumAlfaEquiv : «Nulo» '
                                              WHEN  RetornaNumAlfaEquiv = 0 THEN ' RetornaNumAlfaEquiv : «Falso» '
                                              WHEN  RetornaNumAlfaEquiv = 1 THEN ' RetornaNumAlfaEquiv : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
