CREATE TABLE [dbo].[Anulacoes] (
    [IdAnulacao]         INT          IDENTITY (1, 1) NOT NULL,
    [IdEmpenho]          INT          NOT NULL,
    [NumeroAnulacao]     INT          NOT NULL,
    [AnoExercicio]       INT          NOT NULL,
    [DataAnulacao]       DATETIME     NOT NULL,
    [ValorAnulacao]      MONEY        NOT NULL,
    [TipoMov]            INT          NOT NULL,
    [Historico]          TEXT         NULL,
    [SaldoConta]         MONEY        NOT NULL,
    [UsuarioResponsavel] VARCHAR (30) NULL,
    CONSTRAINT [PK_Anulacoes] PRIMARY KEY NONCLUSTERED ([IdAnulacao] ASC),
    CONSTRAINT [FK_Anulacoes_Empenhos] FOREIGN KEY ([IdEmpenho]) REFERENCES [dbo].[Empenhos] ([IdEmpenho])
);


GO
CREATE TRIGGER [TrgLog_Anulacoes] ON [Implanta_CRPAM].[dbo].[Anulacoes] 
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
SET @TableName = 'Anulacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAnulacao : «' + RTRIM( ISNULL( CAST (IdAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroAnulacao : «' + RTRIM( ISNULL( CAST (NumeroAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAnulacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnulacao, 113 ),'Nulo'))+'» '
                         + '| ValorAnulacao : «' + RTRIM( ISNULL( CAST (ValorAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoConta : «' + RTRIM( ISNULL( CAST (SaldoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAnulacao : «' + RTRIM( ISNULL( CAST (IdAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroAnulacao : «' + RTRIM( ISNULL( CAST (NumeroAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAnulacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnulacao, 113 ),'Nulo'))+'» '
                         + '| ValorAnulacao : «' + RTRIM( ISNULL( CAST (ValorAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoConta : «' + RTRIM( ISNULL( CAST (SaldoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAnulacao : «' + RTRIM( ISNULL( CAST (IdAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroAnulacao : «' + RTRIM( ISNULL( CAST (NumeroAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAnulacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnulacao, 113 ),'Nulo'))+'» '
                         + '| ValorAnulacao : «' + RTRIM( ISNULL( CAST (ValorAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoConta : «' + RTRIM( ISNULL( CAST (SaldoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAnulacao : «' + RTRIM( ISNULL( CAST (IdAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroAnulacao : «' + RTRIM( ISNULL( CAST (NumeroAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAnulacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnulacao, 113 ),'Nulo'))+'» '
                         + '| ValorAnulacao : «' + RTRIM( ISNULL( CAST (ValorAnulacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoConta : «' + RTRIM( ISNULL( CAST (SaldoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
