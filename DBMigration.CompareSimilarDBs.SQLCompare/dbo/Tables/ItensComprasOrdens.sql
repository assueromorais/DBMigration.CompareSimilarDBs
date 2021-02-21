CREATE TABLE [dbo].[ItensComprasOrdens] (
    [IdItemCompraOrdem]       INT        IDENTITY (1, 1) NOT NULL,
    [IdItemCompra]            INT        NOT NULL,
    [IdOrdem]                 INT        NOT NULL,
    [Qtd]                     FLOAT (53) NULL,
    [ValorUnitario]           MONEY      NOT NULL,
    [Desconto]                MONEY      NULL,
    [Detalhes]                TEXT       NULL,
    [IncorporadoAoPatrimonio] BIT        NULL,
    [QtdIncorporadaPat]       FLOAT (53) NULL,
    CONSTRAINT [PK_ItensComprasOrdens] PRIMARY KEY CLUSTERED ([IdItemCompraOrdem] ASC),
    CONSTRAINT [FK_ItensComprasOrdens_ItensCompras] FOREIGN KEY ([IdItemCompra]) REFERENCES [dbo].[ItensCompras] ([IdItemCompra]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensComprasOrdens_Ordens] FOREIGN KEY ([IdOrdem]) REFERENCES [dbo].[Ordens] ([IdOrdem]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [trg_InicializaIncorporacaoPatrimonio] ON [dbo].[ItensComprasOrdens] 
FOR INSERT
AS
DECLARE @IdItemCompraOrdem INT
SET @IdItemCompraOrdem = NULL

SELECT @IdItemCompraOrdem = IdItemCompraOrdem
FROM INSERTED 

UPDATE ItensComprasOrdens SET IncorporadoAoPatrimonio = 0, QtdIncorporadaPat = 0
 WHERE IdItemCompraOrdem = @IdItemCompraOrdem 






GO
CREATE TRIGGER [TrgLog_ItensComprasOrdens] ON [Implanta_CRPAM].[dbo].[ItensComprasOrdens] 
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
SET @TableName = 'ItensComprasOrdens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItemCompraOrdem : «' + RTRIM( ISNULL( CAST (IdItemCompraOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncorporadoAoPatrimonio IS NULL THEN ' IncorporadoAoPatrimonio : «Nulo» '
                                              WHEN  IncorporadoAoPatrimonio = 0 THEN ' IncorporadoAoPatrimonio : «Falso» '
                                              WHEN  IncorporadoAoPatrimonio = 1 THEN ' IncorporadoAoPatrimonio : «Verdadeiro» '
                                    END 
                         + '| QtdIncorporadaPat : «' + RTRIM( ISNULL( CAST (QtdIncorporadaPat AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItemCompraOrdem : «' + RTRIM( ISNULL( CAST (IdItemCompraOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncorporadoAoPatrimonio IS NULL THEN ' IncorporadoAoPatrimonio : «Nulo» '
                                              WHEN  IncorporadoAoPatrimonio = 0 THEN ' IncorporadoAoPatrimonio : «Falso» '
                                              WHEN  IncorporadoAoPatrimonio = 1 THEN ' IncorporadoAoPatrimonio : «Verdadeiro» '
                                    END 
                         + '| QtdIncorporadaPat : «' + RTRIM( ISNULL( CAST (QtdIncorporadaPat AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItemCompraOrdem : «' + RTRIM( ISNULL( CAST (IdItemCompraOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncorporadoAoPatrimonio IS NULL THEN ' IncorporadoAoPatrimonio : «Nulo» '
                                              WHEN  IncorporadoAoPatrimonio = 0 THEN ' IncorporadoAoPatrimonio : «Falso» '
                                              WHEN  IncorporadoAoPatrimonio = 1 THEN ' IncorporadoAoPatrimonio : «Verdadeiro» '
                                    END 
                         + '| QtdIncorporadaPat : «' + RTRIM( ISNULL( CAST (QtdIncorporadaPat AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItemCompraOrdem : «' + RTRIM( ISNULL( CAST (IdItemCompraOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemCompra : «' + RTRIM( ISNULL( CAST (IdItemCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IncorporadoAoPatrimonio IS NULL THEN ' IncorporadoAoPatrimonio : «Nulo» '
                                              WHEN  IncorporadoAoPatrimonio = 0 THEN ' IncorporadoAoPatrimonio : «Falso» '
                                              WHEN  IncorporadoAoPatrimonio = 1 THEN ' IncorporadoAoPatrimonio : «Verdadeiro» '
                                    END 
                         + '| QtdIncorporadaPat : «' + RTRIM( ISNULL( CAST (QtdIncorporadaPat AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
