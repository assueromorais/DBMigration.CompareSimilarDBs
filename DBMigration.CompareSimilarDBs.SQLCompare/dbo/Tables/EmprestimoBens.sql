CREATE TABLE [dbo].[EmprestimoBens] (
    [IdEmprestimoBem]     INT         IDENTITY (1, 1) NOT NULL,
    [IdItem]              INT         NOT NULL,
    [IdPessoa]            INT         NULL,
    [IdMovimentacaoBem]   INT         NULL,
    [DataSaida]           DATETIME    NOT NULL,
    [DataRetorno]         DATETIME    NULL,
    [DataDevolucao]       DATETIME    NULL,
    [IdUnidade]           INT         NULL,
    [NumeroEmprestimoBem] VARCHAR (5) NULL,
    CONSTRAINT [PK_EmprestimoBens] PRIMARY KEY CLUSTERED ([IdEmprestimoBem] ASC),
    CONSTRAINT [FK_EmprestimoBens_ItensMoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensMoveis] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_EmprestimoBens_MovimentacoesBens] FOREIGN KEY ([IdMovimentacaoBem]) REFERENCES [dbo].[MovimentacoesBens] ([IdMovimentacaoBem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_EmprestimoBens_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_EmprestimoBens_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);


GO
ALTER TABLE [dbo].[EmprestimoBens] NOCHECK CONSTRAINT [FK_EmprestimoBens_MovimentacoesBens];


GO
CREATE TRIGGER [TrgLog_EmprestimoBens] ON [Implanta_CRPAM].[dbo].[EmprestimoBens] 
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
SET @TableName = 'EmprestimoBens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEmprestimoBem : «' + RTRIM( ISNULL( CAST (IdEmprestimoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSaida : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaida, 113 ),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmprestimoBem : «' + RTRIM( ISNULL( CAST (NumeroEmprestimoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEmprestimoBem : «' + RTRIM( ISNULL( CAST (IdEmprestimoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSaida : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaida, 113 ),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmprestimoBem : «' + RTRIM( ISNULL( CAST (NumeroEmprestimoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEmprestimoBem : «' + RTRIM( ISNULL( CAST (IdEmprestimoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSaida : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaida, 113 ),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmprestimoBem : «' + RTRIM( ISNULL( CAST (NumeroEmprestimoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEmprestimoBem : «' + RTRIM( ISNULL( CAST (IdEmprestimoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSaida : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaida, 113 ),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmprestimoBem : «' + RTRIM( ISNULL( CAST (NumeroEmprestimoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
