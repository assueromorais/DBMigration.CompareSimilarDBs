CREATE TABLE [dbo].[Empenhos] (
    [IdEmpenho]          INT          IDENTITY (1, 1) NOT NULL,
    [IdConta]            INT          NOT NULL,
    [IdPessoa]           INT          NOT NULL,
    [NumeroEmpenho]      INT          NOT NULL,
    [Origem]             VARCHAR (60) NULL,
    [AnoExercicio]       SMALLINT     NOT NULL,
    [DataEmpenho]        DATETIME     NOT NULL,
    [DataModificacao]    DATETIME     NOT NULL,
    [SaldoConta]         MONEY        NOT NULL,
    [SaldoEmpenho]       MONEY        NOT NULL,
    [ValorEmpenho]       MONEY        NOT NULL,
    [TipoEmpenho]        VARCHAR (1)  NOT NULL,
    [NumeroProcesso]     VARCHAR (20) NULL,
    [Historico]          TEXT         NULL,
    [TipoMov]            INT          NOT NULL,
    [UsuarioResponsavel] VARCHAR (30) NULL,
    [EmpenhoEncerrado]   BIT          NULL,
    CONSTRAINT [PK_Empenhos] PRIMARY KEY NONCLUSTERED ([IdEmpenho] ASC),
    CONSTRAINT [FK_Empenhos_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_Empenhos_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE NONCLUSTERED INDEX [IX_Empenhos_IdConta]
    ON [dbo].[Empenhos]([IdConta] ASC);


GO
CREATE STATISTICS [STAT_Empenhos_TipoEmpenho_IdConta]
    ON [dbo].[Empenhos]([TipoEmpenho], [IdConta]);


GO
CREATE TRIGGER [TrgLog_Empenhos] ON [Implanta_CRPAM].[dbo].[Empenhos] 
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
SET @TableName = 'Empenhos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmpenho : «' + RTRIM( ISNULL( CAST (NumeroEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmpenho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmpenho, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| SaldoConta : «' + RTRIM( ISNULL( CAST (SaldoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoEmpenho : «' + RTRIM( ISNULL( CAST (SaldoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEmpenho : «' + RTRIM( ISNULL( CAST (ValorEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEmpenho : «' + RTRIM( ISNULL( CAST (TipoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmpenhoEncerrado IS NULL THEN ' EmpenhoEncerrado : «Nulo» '
                                              WHEN  EmpenhoEncerrado = 0 THEN ' EmpenhoEncerrado : «Falso» '
                                              WHEN  EmpenhoEncerrado = 1 THEN ' EmpenhoEncerrado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmpenho : «' + RTRIM( ISNULL( CAST (NumeroEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmpenho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmpenho, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| SaldoConta : «' + RTRIM( ISNULL( CAST (SaldoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoEmpenho : «' + RTRIM( ISNULL( CAST (SaldoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEmpenho : «' + RTRIM( ISNULL( CAST (ValorEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEmpenho : «' + RTRIM( ISNULL( CAST (TipoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmpenhoEncerrado IS NULL THEN ' EmpenhoEncerrado : «Nulo» '
                                              WHEN  EmpenhoEncerrado = 0 THEN ' EmpenhoEncerrado : «Falso» '
                                              WHEN  EmpenhoEncerrado = 1 THEN ' EmpenhoEncerrado : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmpenho : «' + RTRIM( ISNULL( CAST (NumeroEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmpenho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmpenho, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| SaldoConta : «' + RTRIM( ISNULL( CAST (SaldoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoEmpenho : «' + RTRIM( ISNULL( CAST (SaldoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEmpenho : «' + RTRIM( ISNULL( CAST (ValorEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEmpenho : «' + RTRIM( ISNULL( CAST (TipoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmpenhoEncerrado IS NULL THEN ' EmpenhoEncerrado : «Nulo» '
                                              WHEN  EmpenhoEncerrado = 0 THEN ' EmpenhoEncerrado : «Falso» '
                                              WHEN  EmpenhoEncerrado = 1 THEN ' EmpenhoEncerrado : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmpenho : «' + RTRIM( ISNULL( CAST (NumeroEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmpenho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmpenho, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| SaldoConta : «' + RTRIM( ISNULL( CAST (SaldoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoEmpenho : «' + RTRIM( ISNULL( CAST (SaldoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEmpenho : «' + RTRIM( ISNULL( CAST (ValorEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEmpenho : «' + RTRIM( ISNULL( CAST (TipoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmpenhoEncerrado IS NULL THEN ' EmpenhoEncerrado : «Nulo» '
                                              WHEN  EmpenhoEncerrado = 0 THEN ' EmpenhoEncerrado : «Falso» '
                                              WHEN  EmpenhoEncerrado = 1 THEN ' EmpenhoEncerrado : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
