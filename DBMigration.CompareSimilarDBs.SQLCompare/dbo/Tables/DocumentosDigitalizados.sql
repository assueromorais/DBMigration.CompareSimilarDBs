CREATE TABLE [dbo].[DocumentosDigitalizados] (
    [IdDocumentosDigitalizados] INT           IDENTITY (1, 1) NOT NULL,
    [IdDocumento]               INT           NULL,
    [Extensao]                  VARCHAR (4)   NULL,
    [Data]                      DATETIME      NULL,
    [Imagem]                    IMAGE         NULL,
    [E_Imagem]                  BIT           NULL,
    [Nome]                      VARCHAR (255) NULL,
    [Miniatura]                 IMAGE         NULL,
    [IdContratoSG]              INT           NULL,
    [IdLicitacaoSG]             INT           NULL,
    [IdProcessoSG]              INT           NULL,
    [IdTipoDocumento]           INT           NULL,
    [Observacao]                TEXT          NULL,
    [idprocesso]                INT           NULL,
    [idFiscalizacao]            INT           NULL,
    [IdProfissional]            INT           NULL,
    [Idpessoa]                  INT           NULL,
    [Ordem]                     INT           NULL,
    [IdPessoasjuridica]         INT           NULL,
    [RTF_File]                  IMAGE         NULL,
    CONSTRAINT [PK_DocumentosDigitalizados] PRIMARY KEY CLUSTERED ([IdDocumentosDigitalizados] ASC),
    CONSTRAINT [FK_DocumentosDigitalizados_DocumentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]),
    CONSTRAINT [fk_idFiscalizacaoDocumentosDigitalizados] FOREIGN KEY ([idFiscalizacao]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao]),
    CONSTRAINT [fk_IdpessoaDocumentosDigitalizados] FOREIGN KEY ([Idpessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [fk_IdPessoasjuridicaDocumentosDigitalizados] FOREIGN KEY ([IdPessoasjuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [fk_idprocessoDocumentosDigitalizados] FOREIGN KEY ([idprocesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [fk_IdProfissionalDocumentosDigitalizados] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_DocumentosDigitalizados] ON [Implanta_CRPAM].[dbo].[DocumentosDigitalizados] 
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
SET @TableName = 'DocumentosDigitalizados'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDocumentosDigitalizados : «' + RTRIM( ISNULL( CAST (IdDocumentosDigitalizados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Imagem IS NULL THEN ' E_Imagem : «Nulo» '
                                              WHEN  E_Imagem = 0 THEN ' E_Imagem : «Falso» '
                                              WHEN  E_Imagem = 1 THEN ' E_Imagem : «Verdadeiro» '
                                    END 
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContratoSG : «' + RTRIM( ISNULL( CAST (IdContratoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacaoSG : «' + RTRIM( ISNULL( CAST (IdLicitacaoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSG : «' + RTRIM( ISNULL( CAST (IdProcessoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idprocesso : «' + RTRIM( ISNULL( CAST (idprocesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFiscalizacao : «' + RTRIM( ISNULL( CAST (idFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Idpessoa : «' + RTRIM( ISNULL( CAST (Idpessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoasjuridica : «' + RTRIM( ISNULL( CAST (IdPessoasjuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDocumentosDigitalizados : «' + RTRIM( ISNULL( CAST (IdDocumentosDigitalizados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Imagem IS NULL THEN ' E_Imagem : «Nulo» '
                                              WHEN  E_Imagem = 0 THEN ' E_Imagem : «Falso» '
                                              WHEN  E_Imagem = 1 THEN ' E_Imagem : «Verdadeiro» '
                                    END 
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContratoSG : «' + RTRIM( ISNULL( CAST (IdContratoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacaoSG : «' + RTRIM( ISNULL( CAST (IdLicitacaoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSG : «' + RTRIM( ISNULL( CAST (IdProcessoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idprocesso : «' + RTRIM( ISNULL( CAST (idprocesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFiscalizacao : «' + RTRIM( ISNULL( CAST (idFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Idpessoa : «' + RTRIM( ISNULL( CAST (Idpessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoasjuridica : «' + RTRIM( ISNULL( CAST (IdPessoasjuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDocumentosDigitalizados : «' + RTRIM( ISNULL( CAST (IdDocumentosDigitalizados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Imagem IS NULL THEN ' E_Imagem : «Nulo» '
                                              WHEN  E_Imagem = 0 THEN ' E_Imagem : «Falso» '
                                              WHEN  E_Imagem = 1 THEN ' E_Imagem : «Verdadeiro» '
                                    END 
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContratoSG : «' + RTRIM( ISNULL( CAST (IdContratoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacaoSG : «' + RTRIM( ISNULL( CAST (IdLicitacaoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSG : «' + RTRIM( ISNULL( CAST (IdProcessoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idprocesso : «' + RTRIM( ISNULL( CAST (idprocesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFiscalizacao : «' + RTRIM( ISNULL( CAST (idFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Idpessoa : «' + RTRIM( ISNULL( CAST (Idpessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoasjuridica : «' + RTRIM( ISNULL( CAST (IdPessoasjuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDocumentosDigitalizados : «' + RTRIM( ISNULL( CAST (IdDocumentosDigitalizados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Imagem IS NULL THEN ' E_Imagem : «Nulo» '
                                              WHEN  E_Imagem = 0 THEN ' E_Imagem : «Falso» '
                                              WHEN  E_Imagem = 1 THEN ' E_Imagem : «Verdadeiro» '
                                    END 
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContratoSG : «' + RTRIM( ISNULL( CAST (IdContratoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLicitacaoSG : «' + RTRIM( ISNULL( CAST (IdLicitacaoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSG : «' + RTRIM( ISNULL( CAST (IdProcessoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idprocesso : «' + RTRIM( ISNULL( CAST (idprocesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFiscalizacao : «' + RTRIM( ISNULL( CAST (idFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Idpessoa : «' + RTRIM( ISNULL( CAST (Idpessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoasjuridica : «' + RTRIM( ISNULL( CAST (IdPessoasjuridica AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
