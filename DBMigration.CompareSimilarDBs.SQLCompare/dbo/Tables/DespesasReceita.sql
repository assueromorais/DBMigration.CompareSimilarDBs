CREATE TABLE [dbo].[DespesasReceita] (
    [IdDespesaReceita]      INT      IDENTITY (1, 1) NOT NULL,
    [IdReceita]             INT      NOT NULL,
    [IdPagamento]           INT      NULL,
    [IdContaDespesa]        INT      NOT NULL,
    [ValorDespesa]          MONEY    NOT NULL,
    [HistoricoDespesa]      TEXT     NULL,
    [IdPessoa]              INT      NULL,
    [DataDespesa]           DATETIME NULL,
    [RegistraLog]           BIT      CONSTRAINT [DF__DespesasR__Regis__3B393F64] DEFAULT ('1') NULL,
    [CadastradoManualmente] BIT      CONSTRAINT [DF_DespesasReceita_CadastradoManualmente] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_DespesasReceita] PRIMARY KEY CLUSTERED ([IdDespesaReceita] ASC),
    CONSTRAINT [FK_DespesasReceita_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_DespesasReceita_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_DespesasReceita_PlanoContas] FOREIGN KEY ([IdContaDespesa]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_DespesasReceita_Receitas] FOREIGN KEY ([IdReceita]) REFERENCES [dbo].[Receitas] ([IdReceita])
);


GO
ALTER TABLE [dbo].[DespesasReceita] NOCHECK CONSTRAINT [FK_DespesasReceita_Pagamentos];


GO
CREATE TRIGGER [TrgLog_DespesasReceita] ON [Implanta_CRPAM].[dbo].[DespesasReceita] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
DECLARE 	@RegistraLogI	BIT 
DECLARE 	@RegistraLogD	BIT 
SELECT @RegistraLogI = RegistraLog FROM INSERTED 
SELECT @RegistraLogD = RegistraLog FROM DELETED 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'DespesasReceita'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDespesaReceita : «' + RTRIM( ISNULL( CAST (IdDespesaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDespesa : «' + RTRIM( ISNULL( CAST (IdContaDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDespesa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDespesa, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CadastradoManualmente IS NULL THEN ' CadastradoManualmente : «Nulo» '
                                              WHEN  CadastradoManualmente = 0 THEN ' CadastradoManualmente : «Falso» '
                                              WHEN  CadastradoManualmente = 1 THEN ' CadastradoManualmente : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdDespesaReceita : «' + RTRIM( ISNULL( CAST (IdDespesaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDespesa : «' + RTRIM( ISNULL( CAST (IdContaDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDespesa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDespesa, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CadastradoManualmente IS NULL THEN ' CadastradoManualmente : «Nulo» '
                                              WHEN  CadastradoManualmente = 0 THEN ' CadastradoManualmente : «Falso» '
                                              WHEN  CadastradoManualmente = 1 THEN ' CadastradoManualmente : «Verdadeiro» '
                                    END  FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
 END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
AND @RegistraLogI = 1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'IdDespesaReceita : «' + RTRIM( ISNULL( CAST (IdDespesaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDespesa : «' + RTRIM( ISNULL( CAST (IdContaDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDespesa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDespesa, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CadastradoManualmente IS NULL THEN ' CadastradoManualmente : «Nulo» '
                                              WHEN  CadastradoManualmente = 0 THEN ' CadastradoManualmente : «Falso» '
                                              WHEN  CadastradoManualmente = 1 THEN ' CadastradoManualmente : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDespesaReceita : «' + RTRIM( ISNULL( CAST (IdDespesaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDespesa : «' + RTRIM( ISNULL( CAST (IdContaDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDespesa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDespesa, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CadastradoManualmente IS NULL THEN ' CadastradoManualmente : «Nulo» '
                                              WHEN  CadastradoManualmente = 0 THEN ' CadastradoManualmente : «Falso» '
                                              WHEN  CadastradoManualmente = 1 THEN ' CadastradoManualmente : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
