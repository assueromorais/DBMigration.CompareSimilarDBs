CREATE TABLE [dbo].[DocumentosRecebimentos] (
    [IdDocumentoRecebimento] INT          IDENTITY (1, 1) NOT NULL,
    [IdDocumento]            INT          NOT NULL,
    [DataComprovante]        DATETIME     NOT NULL,
    [NumeroComprovante]      VARCHAR (50) NOT NULL,
    [ValorComprovante]       MONEY        NOT NULL,
    CONSTRAINT [PK_DocumentosRecebimentos] PRIMARY KEY CLUSTERED ([IdDocumentoRecebimento] ASC),
    CONSTRAINT [FK_DocumentosRecebimentos_DocumentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento])
);


GO
CREATE TRIGGER [TrgLog_DocumentosRecebimentos] ON [Implanta_CRPAM].[dbo].[DocumentosRecebimentos] 
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
SET @TableName = 'DocumentosRecebimentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDocumentoRecebimento : «' + RTRIM( ISNULL( CAST (IdDocumentoRecebimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataComprovante : «' + RTRIM( ISNULL( CONVERT (CHAR, DataComprovante, 113 ),'Nulo'))+'» '
                         + '| NumeroComprovante : «' + RTRIM( ISNULL( CAST (NumeroComprovante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorComprovante : «' + RTRIM( ISNULL( CAST (ValorComprovante AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDocumentoRecebimento : «' + RTRIM( ISNULL( CAST (IdDocumentoRecebimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataComprovante : «' + RTRIM( ISNULL( CONVERT (CHAR, DataComprovante, 113 ),'Nulo'))+'» '
                         + '| NumeroComprovante : «' + RTRIM( ISNULL( CAST (NumeroComprovante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorComprovante : «' + RTRIM( ISNULL( CAST (ValorComprovante AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDocumentoRecebimento : «' + RTRIM( ISNULL( CAST (IdDocumentoRecebimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataComprovante : «' + RTRIM( ISNULL( CONVERT (CHAR, DataComprovante, 113 ),'Nulo'))+'» '
                         + '| NumeroComprovante : «' + RTRIM( ISNULL( CAST (NumeroComprovante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorComprovante : «' + RTRIM( ISNULL( CAST (ValorComprovante AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDocumentoRecebimento : «' + RTRIM( ISNULL( CAST (IdDocumentoRecebimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataComprovante : «' + RTRIM( ISNULL( CONVERT (CHAR, DataComprovante, 113 ),'Nulo'))+'» '
                         + '| NumeroComprovante : «' + RTRIM( ISNULL( CAST (NumeroComprovante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorComprovante : «' + RTRIM( ISNULL( CAST (ValorComprovante AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
