CREATE TABLE [dbo].[ChequesCustodia] (
    [IdChequeCustodia]     INT          IDENTITY (1, 1) NOT NULL,
    [DataBoa]              DATETIME     NULL,
    [NumCheque]            VARCHAR (20) NULL,
    [ValorCheque]          MONEY        NULL,
    [CPFCNPJ]              VARCHAR (14) NULL,
    [Origem]               VARCHAR (50) NULL,
    [Banco]                VARCHAR (5)  NULL,
    [Agencia]              VARCHAR (20) NULL,
    [Conta]                VARCHAR (20) NULL,
    [Situacao]             CHAR (2)     NULL,
    [IdReceitaARealizar]   INT          NULL,
    [IdControleArquivoCob] INT          NULL,
    CONSTRAINT [PK_ChequesCustodia] PRIMARY KEY CLUSTERED ([IdChequeCustodia] ASC),
    CONSTRAINT [FK_ChequesCustodia_ControleArquivosCobranca] FOREIGN KEY ([IdControleArquivoCob]) REFERENCES [dbo].[ControleArquivosCobranca] ([IdControleArquivoCob]),
    CONSTRAINT [FK_ChequesCustodia_ReceitasARealizar] FOREIGN KEY ([IdReceitaARealizar]) REFERENCES [dbo].[ReceitasARealizar] ([IdReceitaARealizar])
);


GO
CREATE TRIGGER [TrgLog_ChequesCustodia] ON [Implanta_CRPAM].[dbo].[ChequesCustodia] 
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
SET @TableName = 'ChequesCustodia'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdChequeCustodia : «' + RTRIM( ISNULL( CAST (IdChequeCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataBoa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBoa, 113 ),'Nulo'))+'» '
                         + '| NumCheque : «' + RTRIM( ISNULL( CAST (NumCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCheque : «' + RTRIM( ISNULL( CAST (ValorCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceitaARealizar : «' + RTRIM( ISNULL( CAST (IdReceitaARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdChequeCustodia : «' + RTRIM( ISNULL( CAST (IdChequeCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataBoa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBoa, 113 ),'Nulo'))+'» '
                         + '| NumCheque : «' + RTRIM( ISNULL( CAST (NumCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCheque : «' + RTRIM( ISNULL( CAST (ValorCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceitaARealizar : «' + RTRIM( ISNULL( CAST (IdReceitaARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdChequeCustodia : «' + RTRIM( ISNULL( CAST (IdChequeCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataBoa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBoa, 113 ),'Nulo'))+'» '
                         + '| NumCheque : «' + RTRIM( ISNULL( CAST (NumCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCheque : «' + RTRIM( ISNULL( CAST (ValorCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceitaARealizar : «' + RTRIM( ISNULL( CAST (IdReceitaARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdChequeCustodia : «' + RTRIM( ISNULL( CAST (IdChequeCustodia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataBoa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataBoa, 113 ),'Nulo'))+'» '
                         + '| NumCheque : «' + RTRIM( ISNULL( CAST (NumCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCheque : «' + RTRIM( ISNULL( CAST (ValorCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceitaARealizar : «' + RTRIM( ISNULL( CAST (IdReceitaARealizar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
