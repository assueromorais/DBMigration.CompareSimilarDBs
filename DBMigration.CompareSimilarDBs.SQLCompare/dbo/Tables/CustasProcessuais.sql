CREATE TABLE [dbo].[CustasProcessuais] (
    [IdCustaProcessual] INT           IDENTITY (1, 1) NOT NULL,
    [IdProcesso]        INT           NOT NULL,
    [IdTipoCusta]       INT           NOT NULL,
    [DataCadastro]      DATETIME      NOT NULL,
    [Descricao]         VARCHAR (100) NOT NULL,
    [Valor]             MONEY         NOT NULL,
    [UsuarioCriacao]    VARCHAR (30)  NOT NULL,
    CONSTRAINT [PK_CustasProcessuais] PRIMARY KEY CLUSTERED ([IdCustaProcessual] ASC),
    CONSTRAINT [FK_CustasProcessuais_TiposCustas] FOREIGN KEY ([IdTipoCusta]) REFERENCES [dbo].[TiposCustas] ([IdTipoCusta]) ON UPDATE CASCADE,
    CONSTRAINT [FK_ZCustasProcessuais_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO
CREATE TRIGGER [TrgLog_CustasProcessuais] ON [Implanta_CRPAM].[dbo].[CustasProcessuais] 
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
SET @TableName = 'CustasProcessuais'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCustaProcessual : «' + RTRIM( ISNULL( CAST (IdCustaProcessual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoCusta : «' + RTRIM( ISNULL( CAST (IdTipoCusta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCadastro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCadastro, 113 ),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCustaProcessual : «' + RTRIM( ISNULL( CAST (IdCustaProcessual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoCusta : «' + RTRIM( ISNULL( CAST (IdTipoCusta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCadastro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCadastro, 113 ),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCustaProcessual : «' + RTRIM( ISNULL( CAST (IdCustaProcessual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoCusta : «' + RTRIM( ISNULL( CAST (IdTipoCusta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCadastro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCadastro, 113 ),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCustaProcessual : «' + RTRIM( ISNULL( CAST (IdCustaProcessual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoCusta : «' + RTRIM( ISNULL( CAST (IdTipoCusta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCadastro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCadastro, 113 ),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
