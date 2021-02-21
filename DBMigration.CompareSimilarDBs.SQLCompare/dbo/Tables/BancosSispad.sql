CREATE TABLE [dbo].[BancosSispad] (
    [IdBancoSispad]   INT          IDENTITY (1, 1) NOT NULL,
    [CodigoBanco]     CHAR (3)     NOT NULL,
    [NomeBanco]       VARCHAR (30) NULL,
    [TamanhoEndereco] INT          NULL,
    [Em_Uso]          BIT          NULL,
    CONSTRAINT [PK_BancosSispad] PRIMARY KEY CLUSTERED ([IdBancoSispad] ASC)
);


GO
CREATE TRIGGER [TrgLog_BancosSispad] ON [Implanta_CRPAM].[dbo].[BancosSispad] 
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
SET @TableName = 'BancosSispad'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdBancoSispad : «' + RTRIM( ISNULL( CAST (IdBancoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoEndereco : «' + RTRIM( ISNULL( CAST (TamanhoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Em_Uso IS NULL THEN ' Em_Uso : «Nulo» '
                                              WHEN  Em_Uso = 0 THEN ' Em_Uso : «Falso» '
                                              WHEN  Em_Uso = 1 THEN ' Em_Uso : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdBancoSispad : «' + RTRIM( ISNULL( CAST (IdBancoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoEndereco : «' + RTRIM( ISNULL( CAST (TamanhoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Em_Uso IS NULL THEN ' Em_Uso : «Nulo» '
                                              WHEN  Em_Uso = 0 THEN ' Em_Uso : «Falso» '
                                              WHEN  Em_Uso = 1 THEN ' Em_Uso : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdBancoSispad : «' + RTRIM( ISNULL( CAST (IdBancoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoEndereco : «' + RTRIM( ISNULL( CAST (TamanhoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Em_Uso IS NULL THEN ' Em_Uso : «Nulo» '
                                              WHEN  Em_Uso = 0 THEN ' Em_Uso : «Falso» '
                                              WHEN  Em_Uso = 1 THEN ' Em_Uso : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdBancoSispad : «' + RTRIM( ISNULL( CAST (IdBancoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoEndereco : «' + RTRIM( ISNULL( CAST (TamanhoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Em_Uso IS NULL THEN ' Em_Uso : «Nulo» '
                                              WHEN  Em_Uso = 0 THEN ' Em_Uso : «Falso» '
                                              WHEN  Em_Uso = 1 THEN ' Em_Uso : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
