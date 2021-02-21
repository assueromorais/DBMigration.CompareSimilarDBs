﻿CREATE TABLE [dbo].[InfoCadastralProcessosTabela2] (
    [IdInfoCadastralProcessosTabela2] INT IDENTITY (1, 1) NOT NULL,
    [IdTabela2Proc]                   INT NOT NULL,
    CONSTRAINT [PK_InfoCadastralProcessosTabela2] PRIMARY KEY CLUSTERED ([IdInfoCadastralProcessosTabela2] ASC),
    CONSTRAINT [FK_InfoCadastralProcessosTabela2] FOREIGN KEY ([IdTabela2Proc]) REFERENCES [dbo].[ProcessosTabela2] ([IdTabela2Proc]) ON DELETE CASCADE
);


GO
CREATE TRIGGER [TrgLog_InfoCadastralProcessosTabela2] ON [Implanta_CRPAM].[dbo].[InfoCadastralProcessosTabela2] 
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
SET @TableName = 'InfoCadastralProcessosTabela2'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdInfoCadastralProcessosTabela2 : «' + RTRIM( ISNULL( CAST (IdInfoCadastralProcessosTabela2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela2Proc : «' + RTRIM( ISNULL( CAST (IdTabela2Proc AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdInfoCadastralProcessosTabela2 : «' + RTRIM( ISNULL( CAST (IdInfoCadastralProcessosTabela2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela2Proc : «' + RTRIM( ISNULL( CAST (IdTabela2Proc AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdInfoCadastralProcessosTabela2 : «' + RTRIM( ISNULL( CAST (IdInfoCadastralProcessosTabela2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela2Proc : «' + RTRIM( ISNULL( CAST (IdTabela2Proc AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdInfoCadastralProcessosTabela2 : «' + RTRIM( ISNULL( CAST (IdInfoCadastralProcessosTabela2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela2Proc : «' + RTRIM( ISNULL( CAST (IdTabela2Proc AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
