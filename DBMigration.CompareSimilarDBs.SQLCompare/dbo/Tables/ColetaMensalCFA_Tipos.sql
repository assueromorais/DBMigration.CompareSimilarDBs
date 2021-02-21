CREATE TABLE [dbo].[ColetaMensalCFA_Tipos] (
    [IdColetaMensalCFA_Tipo]     INT          IDENTITY (1, 1) NOT NULL,
    [IdColetaMensalCFA_Criterio] INT          NOT NULL,
    [IdentificadorTipo]          VARCHAR (50) NOT NULL,
    [IdReferencia]               INT          NOT NULL,
    CONSTRAINT [PK_ColetaMensalCFA_Tipos] PRIMARY KEY CLUSTERED ([IdColetaMensalCFA_Tipo] ASC),
    CONSTRAINT [FK_ColetaMensalCFA_Tipos_ColetaMensalCFA_Criterios] FOREIGN KEY ([IdColetaMensalCFA_Criterio]) REFERENCES [dbo].[ColetaMensalCFA_Criterios] ([IdColetaMensalCFA_Criterio])
);


GO
CREATE TRIGGER [TrgLog_ColetaMensalCFA_Tipos] ON [Implanta_CRPAM].[dbo].[ColetaMensalCFA_Tipos] 
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
SET @TableName = 'ColetaMensalCFA_Tipos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdColetaMensalCFA_Tipo : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdColetaMensalCFA_Criterio : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorTipo : «' + RTRIM( ISNULL( CAST (IdentificadorTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReferencia : «' + RTRIM( ISNULL( CAST (IdReferencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdColetaMensalCFA_Tipo : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdColetaMensalCFA_Criterio : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorTipo : «' + RTRIM( ISNULL( CAST (IdentificadorTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReferencia : «' + RTRIM( ISNULL( CAST (IdReferencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdColetaMensalCFA_Tipo : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdColetaMensalCFA_Criterio : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorTipo : «' + RTRIM( ISNULL( CAST (IdentificadorTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReferencia : «' + RTRIM( ISNULL( CAST (IdReferencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdColetaMensalCFA_Tipo : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdColetaMensalCFA_Criterio : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdentificadorTipo : «' + RTRIM( ISNULL( CAST (IdentificadorTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReferencia : «' + RTRIM( ISNULL( CAST (IdReferencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
