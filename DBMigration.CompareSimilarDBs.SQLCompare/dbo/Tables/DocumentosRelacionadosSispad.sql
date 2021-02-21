CREATE TABLE [dbo].[DocumentosRelacionadosSispad] (
    [IdDocumentoRelacionadoSispad] INT IDENTITY (1, 1) NOT NULL,
    [IdDocumento]                  INT NOT NULL,
    [IdProcessoSolicitacaoViagem]  INT NULL,
    [IdSolicitacaoViagem]          INT NULL,
    CONSTRAINT [PK_DocumentosRelacionadosSispad] PRIMARY KEY CLUSTERED ([IdDocumentoRelacionadoSispad] ASC),
    CONSTRAINT [FK_DocumentosRelacionadosSispad_ProcessosSolicitacaoViagem] FOREIGN KEY ([IdProcessoSolicitacaoViagem]) REFERENCES [dbo].[ProcessosSolicitacaoViagem] ([IdProcessoSolicitacaoViagem]),
    CONSTRAINT [FK_DocumentosRelacionadosSispad_Sisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]),
    CONSTRAINT [FK_DocumentosRelacionadosSispad_SolicitacoesViagem] FOREIGN KEY ([IdSolicitacaoViagem]) REFERENCES [dbo].[SolicitacoesViagem] ([IdSolicitacaoViagem])
);


GO
CREATE TRIGGER [TrgLog_DocumentosRelacionadosSispad] ON [Implanta_CRPAM].[dbo].[DocumentosRelacionadosSispad] 
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
SET @TableName = 'DocumentosRelacionadosSispad'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDocumentoRelacionadoSispad : «' + RTRIM( ISNULL( CAST (IdDocumentoRelacionadoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDocumentoRelacionadoSispad : «' + RTRIM( ISNULL( CAST (IdDocumentoRelacionadoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDocumentoRelacionadoSispad : «' + RTRIM( ISNULL( CAST (IdDocumentoRelacionadoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDocumentoRelacionadoSispad : «' + RTRIM( ISNULL( CAST (IdDocumentoRelacionadoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdProcessoSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
