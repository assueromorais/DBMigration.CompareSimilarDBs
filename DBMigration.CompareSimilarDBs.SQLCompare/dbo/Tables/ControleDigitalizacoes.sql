CREATE TABLE [dbo].[ControleDigitalizacoes] (
    [IdControleDigitalizacoes] INT            IDENTITY (1, 1) NOT NULL,
    [IdTipoDigitalizacao]      INT            NOT NULL,
    [DataDigitalizacao]        DATETIME       NULL,
    [DataEntrega]              DATETIME       NULL,
    [Entregue]                 BIT            CONSTRAINT [DF_ControleDigitalizacoes_Entregue] DEFAULT ((0)) NOT NULL,
    [Observacoes]              VARCHAR (1000) NULL,
    CONSTRAINT [PK_ControleDigitalizacoes] PRIMARY KEY CLUSTERED ([IdControleDigitalizacoes] ASC),
    CONSTRAINT [FK_ControleDigitalizacoes_TipoDigitalizacoes] FOREIGN KEY ([IdTipoDigitalizacao]) REFERENCES [dbo].[TiposDigitalizacao] ([IdTipoDigitalizao])
);


GO
CREATE TRIGGER [TrgLog_ControleDigitalizacoes] ON [Implanta_CRPAM].[dbo].[ControleDigitalizacoes] 
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
SET @TableName = 'ControleDigitalizacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDigitalizacao : «' + RTRIM( ISNULL( CAST (IdTipoDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDigitalizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDigitalizacao, 113 ),'Nulo'))+'» '
                         + '| DataEntrega : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntrega, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Entregue IS NULL THEN ' Entregue : «Nulo» '
                                              WHEN  Entregue = 0 THEN ' Entregue : «Falso» '
                                              WHEN  Entregue = 1 THEN ' Entregue : «Verdadeiro» '
                                    END 
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDigitalizacao : «' + RTRIM( ISNULL( CAST (IdTipoDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDigitalizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDigitalizacao, 113 ),'Nulo'))+'» '
                         + '| DataEntrega : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntrega, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Entregue IS NULL THEN ' Entregue : «Nulo» '
                                              WHEN  Entregue = 0 THEN ' Entregue : «Falso» '
                                              WHEN  Entregue = 1 THEN ' Entregue : «Verdadeiro» '
                                    END 
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDigitalizacao : «' + RTRIM( ISNULL( CAST (IdTipoDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDigitalizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDigitalizacao, 113 ),'Nulo'))+'» '
                         + '| DataEntrega : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntrega, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Entregue IS NULL THEN ' Entregue : «Nulo» '
                                              WHEN  Entregue = 0 THEN ' Entregue : «Falso» '
                                              WHEN  Entregue = 1 THEN ' Entregue : «Verdadeiro» '
                                    END 
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDigitalizacao : «' + RTRIM( ISNULL( CAST (IdTipoDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDigitalizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDigitalizacao, 113 ),'Nulo'))+'» '
                         + '| DataEntrega : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntrega, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Entregue IS NULL THEN ' Entregue : «Nulo» '
                                              WHEN  Entregue = 0 THEN ' Entregue : «Falso» '
                                              WHEN  Entregue = 1 THEN ' Entregue : «Verdadeiro» '
                                    END 
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
