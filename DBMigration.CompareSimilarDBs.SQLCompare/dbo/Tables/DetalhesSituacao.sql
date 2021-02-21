CREATE TABLE [dbo].[DetalhesSituacao] (
    [IdDetalheSituacao] INT           IDENTITY (1, 1) NOT NULL,
    [Detalhe]           VARCHAR (100) NULL,
    [Isento]            BIT           NULL,
    [Desativado]        BIT           CONSTRAINT [DF_DetalhesSituacaoDesativado] DEFAULT ((0)) NULL,
    [IsentoPorIdade]    BIT           DEFAULT ((0)) NOT NULL,
    [DetalhePF]         BIT           DEFAULT ((1)) NOT NULL,
    [IdSituacaoPFPJ]    INT           NULL,
    CONSTRAINT [PK_DetalhesSituacao] PRIMARY KEY CLUSTERED ([IdDetalheSituacao] ASC)
);


GO
CREATE TRIGGER [TrgLog_DetalhesSituacao] ON [Implanta_CRPAM].[dbo].[DetalhesSituacao] 
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
SET @TableName = 'DetalhesSituacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDetalheSituacao : «' + RTRIM( ISNULL( CAST (IdDetalheSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Detalhe : «' + RTRIM( ISNULL( CAST (Detalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Isento IS NULL THEN ' Isento : «Nulo» '
                                              WHEN  Isento = 0 THEN ' Isento : «Falso» '
                                              WHEN  Isento = 1 THEN ' Isento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IsentoPorIdade IS NULL THEN ' IsentoPorIdade : «Nulo» '
                                              WHEN  IsentoPorIdade = 0 THEN ' IsentoPorIdade : «Falso» '
                                              WHEN  IsentoPorIdade = 1 THEN ' IsentoPorIdade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DetalhePF IS NULL THEN ' DetalhePF : «Nulo» '
                                              WHEN  DetalhePF = 0 THEN ' DetalhePF : «Falso» '
                                              WHEN  DetalhePF = 1 THEN ' DetalhePF : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDetalheSituacao : «' + RTRIM( ISNULL( CAST (IdDetalheSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Detalhe : «' + RTRIM( ISNULL( CAST (Detalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Isento IS NULL THEN ' Isento : «Nulo» '
                                              WHEN  Isento = 0 THEN ' Isento : «Falso» '
                                              WHEN  Isento = 1 THEN ' Isento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IsentoPorIdade IS NULL THEN ' IsentoPorIdade : «Nulo» '
                                              WHEN  IsentoPorIdade = 0 THEN ' IsentoPorIdade : «Falso» '
                                              WHEN  IsentoPorIdade = 1 THEN ' IsentoPorIdade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DetalhePF IS NULL THEN ' DetalhePF : «Nulo» '
                                              WHEN  DetalhePF = 0 THEN ' DetalhePF : «Falso» '
                                              WHEN  DetalhePF = 1 THEN ' DetalhePF : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDetalheSituacao : «' + RTRIM( ISNULL( CAST (IdDetalheSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Detalhe : «' + RTRIM( ISNULL( CAST (Detalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Isento IS NULL THEN ' Isento : «Nulo» '
                                              WHEN  Isento = 0 THEN ' Isento : «Falso» '
                                              WHEN  Isento = 1 THEN ' Isento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IsentoPorIdade IS NULL THEN ' IsentoPorIdade : «Nulo» '
                                              WHEN  IsentoPorIdade = 0 THEN ' IsentoPorIdade : «Falso» '
                                              WHEN  IsentoPorIdade = 1 THEN ' IsentoPorIdade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DetalhePF IS NULL THEN ' DetalhePF : «Nulo» '
                                              WHEN  DetalhePF = 0 THEN ' DetalhePF : «Falso» '
                                              WHEN  DetalhePF = 1 THEN ' DetalhePF : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDetalheSituacao : «' + RTRIM( ISNULL( CAST (IdDetalheSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Detalhe : «' + RTRIM( ISNULL( CAST (Detalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Isento IS NULL THEN ' Isento : «Nulo» '
                                              WHEN  Isento = 0 THEN ' Isento : «Falso» '
                                              WHEN  Isento = 1 THEN ' Isento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IsentoPorIdade IS NULL THEN ' IsentoPorIdade : «Nulo» '
                                              WHEN  IsentoPorIdade = 0 THEN ' IsentoPorIdade : «Falso» '
                                              WHEN  IsentoPorIdade = 1 THEN ' IsentoPorIdade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DetalhePF IS NULL THEN ' DetalhePF : «Nulo» '
                                              WHEN  DetalhePF = 0 THEN ' DetalhePF : «Falso» '
                                              WHEN  DetalhePF = 1 THEN ' DetalhePF : «Verdadeiro» '
                                    END 
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
