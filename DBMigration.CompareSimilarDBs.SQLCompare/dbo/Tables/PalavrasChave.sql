﻿CREATE TABLE [dbo].[PalavrasChave] (
    [IdPalavrasChave] INT          IDENTITY (1, 1) NOT NULL,
    [IdDocumento]     INT          NOT NULL,
    [PalavraChave]    VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_PalavrasChave] PRIMARY KEY CLUSTERED ([IdPalavrasChave] ASC),
    CONSTRAINT [FK_PalavrasChave_documentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento])
);


GO
CREATE TRIGGER [TrgLog_PalavrasChave] ON [Implanta_CRPAM].[dbo].[PalavrasChave] 
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
SET @TableName = 'PalavrasChave'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdPalavrasChave : «' + RTRIM( ISNULL( CAST (IdPalavrasChave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PalavraChave : «' + RTRIM( ISNULL( CAST (PalavraChave AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdPalavrasChave : «' + RTRIM( ISNULL( CAST (IdPalavrasChave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PalavraChave : «' + RTRIM( ISNULL( CAST (PalavraChave AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdPalavrasChave : «' + RTRIM( ISNULL( CAST (IdPalavrasChave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PalavraChave : «' + RTRIM( ISNULL( CAST (PalavraChave AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdPalavrasChave : «' + RTRIM( ISNULL( CAST (IdPalavrasChave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PalavraChave : «' + RTRIM( ISNULL( CAST (PalavraChave AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
