CREATE TABLE [dbo].[OpcoesPgtoDesconto] (
    [IdOpcaoPgtoDesconto]   INT        IDENTITY (1, 1) NOT NULL,
    [IdConfigParcelaDebito] INT        NOT NULL,
    [IdMoedaDesconto]       INT        NULL,
    [DataPgtoDesconto]      DATETIME   NULL,
    [ValorPgtoDesconto]     FLOAT (53) NOT NULL,
    [E_Percentual]          BIT        NULL,
    [DiaAntecipacao]        INT        NULL,
    CONSTRAINT [PK_OpcoesPgtoDesconto] PRIMARY KEY CLUSTERED ([IdOpcaoPgtoDesconto] ASC),
    CONSTRAINT [FK_OpcoesPgtoDesconto_ConfigParcelasDebito] FOREIGN KEY ([IdConfigParcelaDebito]) REFERENCES [dbo].[ConfigParcelasDebito] ([IdConfigParcelaDebito]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OpcoesPgtoDesconto_Moedas] FOREIGN KEY ([IdMoedaDesconto]) REFERENCES [dbo].[Moedas] ([IdMoeda])
);


GO
CREATE TRIGGER [TrgLog_OpcoesPgtoDesconto] ON [Implanta_CRPAM].[dbo].[OpcoesPgtoDesconto] 
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
SET @TableName = 'OpcoesPgtoDesconto'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOpcaoPgtoDesconto : «' + RTRIM( ISNULL( CAST (IdOpcaoPgtoDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigParcelaDebito : «' + RTRIM( ISNULL( CAST (IdConfigParcelaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDesconto : «' + RTRIM( ISNULL( CAST (IdMoedaDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPgtoDesconto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgtoDesconto, 113 ),'Nulo'))+'» '
                         + '| ValorPgtoDesconto : «' + RTRIM( ISNULL( CAST (ValorPgtoDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Percentual IS NULL THEN ' E_Percentual : «Nulo» '
                                              WHEN  E_Percentual = 0 THEN ' E_Percentual : «Falso» '
                                              WHEN  E_Percentual = 1 THEN ' E_Percentual : «Verdadeiro» '
                                    END 
                         + '| DiaAntecipacao : «' + RTRIM( ISNULL( CAST (DiaAntecipacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdOpcaoPgtoDesconto : «' + RTRIM( ISNULL( CAST (IdOpcaoPgtoDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigParcelaDebito : «' + RTRIM( ISNULL( CAST (IdConfigParcelaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDesconto : «' + RTRIM( ISNULL( CAST (IdMoedaDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPgtoDesconto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgtoDesconto, 113 ),'Nulo'))+'» '
                         + '| ValorPgtoDesconto : «' + RTRIM( ISNULL( CAST (ValorPgtoDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Percentual IS NULL THEN ' E_Percentual : «Nulo» '
                                              WHEN  E_Percentual = 0 THEN ' E_Percentual : «Falso» '
                                              WHEN  E_Percentual = 1 THEN ' E_Percentual : «Verdadeiro» '
                                    END 
                         + '| DiaAntecipacao : «' + RTRIM( ISNULL( CAST (DiaAntecipacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdOpcaoPgtoDesconto : «' + RTRIM( ISNULL( CAST (IdOpcaoPgtoDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigParcelaDebito : «' + RTRIM( ISNULL( CAST (IdConfigParcelaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDesconto : «' + RTRIM( ISNULL( CAST (IdMoedaDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPgtoDesconto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgtoDesconto, 113 ),'Nulo'))+'» '
                         + '| ValorPgtoDesconto : «' + RTRIM( ISNULL( CAST (ValorPgtoDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Percentual IS NULL THEN ' E_Percentual : «Nulo» '
                                              WHEN  E_Percentual = 0 THEN ' E_Percentual : «Falso» '
                                              WHEN  E_Percentual = 1 THEN ' E_Percentual : «Verdadeiro» '
                                    END 
                         + '| DiaAntecipacao : «' + RTRIM( ISNULL( CAST (DiaAntecipacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOpcaoPgtoDesconto : «' + RTRIM( ISNULL( CAST (IdOpcaoPgtoDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigParcelaDebito : «' + RTRIM( ISNULL( CAST (IdConfigParcelaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDesconto : «' + RTRIM( ISNULL( CAST (IdMoedaDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPgtoDesconto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgtoDesconto, 113 ),'Nulo'))+'» '
                         + '| ValorPgtoDesconto : «' + RTRIM( ISNULL( CAST (ValorPgtoDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Percentual IS NULL THEN ' E_Percentual : «Nulo» '
                                              WHEN  E_Percentual = 0 THEN ' E_Percentual : «Falso» '
                                              WHEN  E_Percentual = 1 THEN ' E_Percentual : «Verdadeiro» '
                                    END 
                         + '| DiaAntecipacao : «' + RTRIM( ISNULL( CAST (DiaAntecipacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
