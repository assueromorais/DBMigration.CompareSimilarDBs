CREATE TABLE [dbo].[AutorizacaoImpressao] (
    [IdAutorizacaoImpressao] INT            IDENTITY (1, 1) NOT NULL,
    [Funcao]                 INT            NOT NULL,
    [IdFuncao]               INT            NOT NULL,
    [IdUsuario]              INT            NOT NULL,
    [Autorizada]             BIT            CONSTRAINT [DF_AutorizacaoImpressao_Autorizada] DEFAULT ((0)) NULL,
    [Data]                   DATETIME       NULL,
    [Justificativa]          NVARCHAR (250) NULL,
    [Alerta]                 BIT            CONSTRAINT [DF_AutorizacaoImpressao_Alerta] DEFAULT ((1)) NULL,
    [Cancelada]              BIT            NULL,
    [DataSolicitacao]        DATETIME       DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AutorizacaoImpressao] PRIMARY KEY CLUSTERED ([IdAutorizacaoImpressao] ASC),
    CONSTRAINT [FK_AutorizacaoImpressao_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_AutorizacaoImpressao] ON [Implanta_CRPAM].[dbo].[AutorizacaoImpressao] 
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
SET @TableName = 'AutorizacaoImpressao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAutorizacaoImpressao : «' + RTRIM( ISNULL( CAST (IdAutorizacaoImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Funcao : «' + RTRIM( ISNULL( CAST (Funcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Autorizada IS NULL THEN ' Autorizada : «Nulo» '
                                              WHEN  Autorizada = 0 THEN ' Autorizada : «Falso» '
                                              WHEN  Autorizada = 1 THEN ' Autorizada : «Verdadeiro» '
                                    END 
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Alerta IS NULL THEN ' Alerta : «Nulo» '
                                              WHEN  Alerta = 0 THEN ' Alerta : «Falso» '
                                              WHEN  Alerta = 1 THEN ' Alerta : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Cancelada IS NULL THEN ' Cancelada : «Nulo» '
                                              WHEN  Cancelada = 0 THEN ' Cancelada : «Falso» '
                                              WHEN  Cancelada = 1 THEN ' Cancelada : «Verdadeiro» '
                                    END 
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAutorizacaoImpressao : «' + RTRIM( ISNULL( CAST (IdAutorizacaoImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Funcao : «' + RTRIM( ISNULL( CAST (Funcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Autorizada IS NULL THEN ' Autorizada : «Nulo» '
                                              WHEN  Autorizada = 0 THEN ' Autorizada : «Falso» '
                                              WHEN  Autorizada = 1 THEN ' Autorizada : «Verdadeiro» '
                                    END 
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Alerta IS NULL THEN ' Alerta : «Nulo» '
                                              WHEN  Alerta = 0 THEN ' Alerta : «Falso» '
                                              WHEN  Alerta = 1 THEN ' Alerta : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Cancelada IS NULL THEN ' Cancelada : «Nulo» '
                                              WHEN  Cancelada = 0 THEN ' Cancelada : «Falso» '
                                              WHEN  Cancelada = 1 THEN ' Cancelada : «Verdadeiro» '
                                    END 
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAutorizacaoImpressao : «' + RTRIM( ISNULL( CAST (IdAutorizacaoImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Funcao : «' + RTRIM( ISNULL( CAST (Funcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Autorizada IS NULL THEN ' Autorizada : «Nulo» '
                                              WHEN  Autorizada = 0 THEN ' Autorizada : «Falso» '
                                              WHEN  Autorizada = 1 THEN ' Autorizada : «Verdadeiro» '
                                    END 
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Alerta IS NULL THEN ' Alerta : «Nulo» '
                                              WHEN  Alerta = 0 THEN ' Alerta : «Falso» '
                                              WHEN  Alerta = 1 THEN ' Alerta : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Cancelada IS NULL THEN ' Cancelada : «Nulo» '
                                              WHEN  Cancelada = 0 THEN ' Cancelada : «Falso» '
                                              WHEN  Cancelada = 1 THEN ' Cancelada : «Verdadeiro» '
                                    END 
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAutorizacaoImpressao : «' + RTRIM( ISNULL( CAST (IdAutorizacaoImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Funcao : «' + RTRIM( ISNULL( CAST (Funcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Autorizada IS NULL THEN ' Autorizada : «Nulo» '
                                              WHEN  Autorizada = 0 THEN ' Autorizada : «Falso» '
                                              WHEN  Autorizada = 1 THEN ' Autorizada : «Verdadeiro» '
                                    END 
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Alerta IS NULL THEN ' Alerta : «Nulo» '
                                              WHEN  Alerta = 0 THEN ' Alerta : «Falso» '
                                              WHEN  Alerta = 1 THEN ' Alerta : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Cancelada IS NULL THEN ' Cancelada : «Nulo» '
                                              WHEN  Cancelada = 0 THEN ' Cancelada : «Falso» '
                                              WHEN  Cancelada = 1 THEN ' Cancelada : «Verdadeiro» '
                                    END 
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
