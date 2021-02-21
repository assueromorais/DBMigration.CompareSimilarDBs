CREATE TABLE [dbo].[CEP_Complementar] (
    [IdCEP]          INT          IDENTITY (1, 1) NOT NULL,
    [NomeLogradouro] VARCHAR (60) NULL,
    [CEP]            INT          NOT NULL,
    [IdBairro]       INT          NULL,
    [IdCidade]       INT          NULL,
    [IdEstado]       INT          NULL,
    [Desativado]     BIT          CONSTRAINT [DF_CEP_ComplementarDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_CEP_Complementar] PRIMARY KEY CLUSTERED ([CEP] ASC)
);


GO
CREATE TRIGGER [TrgLog_CEP_Complementar] ON [Implanta_CRPAM].[dbo].[CEP_Complementar] 
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
SET @TableName = 'CEP_Complementar'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCEP : «' + RTRIM( ISNULL( CAST (IdCEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeLogradouro : «' + RTRIM( ISNULL( CAST (NomeLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBairro : «' + RTRIM( ISNULL( CAST (IdBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdCEP : «' + RTRIM( ISNULL( CAST (IdCEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeLogradouro : «' + RTRIM( ISNULL( CAST (NomeLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBairro : «' + RTRIM( ISNULL( CAST (IdBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdCEP : «' + RTRIM( ISNULL( CAST (IdCEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeLogradouro : «' + RTRIM( ISNULL( CAST (NomeLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBairro : «' + RTRIM( ISNULL( CAST (IdBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCEP : «' + RTRIM( ISNULL( CAST (IdCEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeLogradouro : «' + RTRIM( ISNULL( CAST (NomeLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBairro : «' + RTRIM( ISNULL( CAST (IdBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
