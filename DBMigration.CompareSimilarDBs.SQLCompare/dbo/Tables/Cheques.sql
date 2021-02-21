CREATE TABLE [dbo].[Cheques] (
    [IdCheque]       INT          IDENTITY (1, 1) NOT NULL,
    [IdDebito]       INT          NULL,
    [NumeroCheque]   VARCHAR (15) NULL,
    [DataCredito]    DATETIME     NULL,
    [DataVencimento] DATETIME     NULL,
    [DataEstorno]    DATETIME     NULL,
    [ValorCheque]    MONEY        NULL,
    [Custodia]       BIT          NULL,
    [IdBanco]        INT          NULL,
    CONSTRAINT [FK_Cheques_Bancos] FOREIGN KEY ([IdBanco]) REFERENCES [dbo].[BancosSiscafw] ([IdBancoSiscafw]),
    CONSTRAINT [FK_Cheques_Debitos] FOREIGN KEY ([IdDebito]) REFERENCES [dbo].[Debitos] ([IdDebito]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Cheques] NOCHECK CONSTRAINT [FK_Cheques_Debitos];


GO
CREATE TRIGGER [TrgLog_Cheques] ON [Implanta_CRPAM].[dbo].[Cheques] 
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
SET @TableName = 'Cheques'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCheque : «' + RTRIM( ISNULL( CAST (IdCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCheque : «' + RTRIM( ISNULL( CAST (NumeroCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataEstorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEstorno, 113 ),'Nulo'))+'» '
                         + '| ValorCheque : «' + RTRIM( ISNULL( CAST (ValorCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Custodia IS NULL THEN ' Custodia : «Nulo» '
                                              WHEN  Custodia = 0 THEN ' Custodia : «Falso» '
                                              WHEN  Custodia = 1 THEN ' Custodia : «Verdadeiro» '
                                    END 
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCheque : «' + RTRIM( ISNULL( CAST (IdCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCheque : «' + RTRIM( ISNULL( CAST (NumeroCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataEstorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEstorno, 113 ),'Nulo'))+'» '
                         + '| ValorCheque : «' + RTRIM( ISNULL( CAST (ValorCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Custodia IS NULL THEN ' Custodia : «Nulo» '
                                              WHEN  Custodia = 0 THEN ' Custodia : «Falso» '
                                              WHEN  Custodia = 1 THEN ' Custodia : «Verdadeiro» '
                                    END 
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCheque : «' + RTRIM( ISNULL( CAST (IdCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCheque : «' + RTRIM( ISNULL( CAST (NumeroCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataEstorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEstorno, 113 ),'Nulo'))+'» '
                         + '| ValorCheque : «' + RTRIM( ISNULL( CAST (ValorCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Custodia IS NULL THEN ' Custodia : «Nulo» '
                                              WHEN  Custodia = 0 THEN ' Custodia : «Falso» '
                                              WHEN  Custodia = 1 THEN ' Custodia : «Verdadeiro» '
                                    END 
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCheque : «' + RTRIM( ISNULL( CAST (IdCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCheque : «' + RTRIM( ISNULL( CAST (NumeroCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataEstorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEstorno, 113 ),'Nulo'))+'» '
                         + '| ValorCheque : «' + RTRIM( ISNULL( CAST (ValorCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Custodia IS NULL THEN ' Custodia : «Nulo» '
                                              WHEN  Custodia = 0 THEN ' Custodia : «Falso» '
                                              WHEN  Custodia = 1 THEN ' Custodia : «Verdadeiro» '
                                    END 
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
