CREATE TABLE [dbo].[FatNotasDebitoLancamentos] (
    [IdNotaDebito_Lancamentos]  INT IDENTITY (1, 1) NOT NULL,
    [IdNotaDebito]              INT NOT NULL,
    [IdContaPatrimonialUnidade] INT NOT NULL,
    [IdContaPatrimonial]        INT NOT NULL,
    [IdContaReceita]            INT NULL,
    [IdContaBanco]              INT NULL,
    [IdLancamentoPatrimonial]   INT NULL,
    [IdLancamentoRecebimento]   INT NULL,
    CONSTRAINT [PK_FatNotasDebitoLancamentos] PRIMARY KEY CLUSTERED ([IdNotaDebito_Lancamentos] ASC),
    CONSTRAINT [FK_FatNotasDebitoLancamentos_FatNotasDebito] FOREIGN KEY ([IdNotaDebito]) REFERENCES [dbo].[FatNotasDebito] ([IdNotaDebito]),
    CONSTRAINT [FK_FatNotasDebitoLancamentos_Lancamentos_Pat] FOREIGN KEY ([IdLancamentoPatrimonial]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_FatNotasDebitoLancamentos_Lancamentos_Rec] FOREIGN KEY ([IdLancamentoRecebimento]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_FatNotasDebitoLancamentos_PlanoContas_Banco] FOREIGN KEY ([IdContaBanco]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_FatNotasDebitoLancamentos_PlanoContas_Pat] FOREIGN KEY ([IdContaPatrimonial]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_FatNotasDebitoLancamentos_PlanoContas_PatUni] FOREIGN KEY ([IdContaPatrimonialUnidade]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_FatNotasDebitoLancamentos_PlanoContas_Rec] FOREIGN KEY ([IdContaReceita]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE TRIGGER [TrgLog_FatNotasDebitoLancamentos] ON [Implanta_CRPAM].[dbo].[FatNotasDebitoLancamentos] 
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
SET @TableName = 'FatNotasDebitoLancamentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdNotaDebito_Lancamentos : «' + RTRIM( ISNULL( CAST (IdNotaDebito_Lancamentos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialUnidade : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonial : «' + RTRIM( ISNULL( CAST (IdContaPatrimonial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceita : «' + RTRIM( ISNULL( CAST (IdContaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBanco : «' + RTRIM( ISNULL( CAST (IdContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoPatrimonial : «' + RTRIM( ISNULL( CAST (IdLancamentoPatrimonial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoRecebimento : «' + RTRIM( ISNULL( CAST (IdLancamentoRecebimento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdNotaDebito_Lancamentos : «' + RTRIM( ISNULL( CAST (IdNotaDebito_Lancamentos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialUnidade : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonial : «' + RTRIM( ISNULL( CAST (IdContaPatrimonial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceita : «' + RTRIM( ISNULL( CAST (IdContaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBanco : «' + RTRIM( ISNULL( CAST (IdContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoPatrimonial : «' + RTRIM( ISNULL( CAST (IdLancamentoPatrimonial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoRecebimento : «' + RTRIM( ISNULL( CAST (IdLancamentoRecebimento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdNotaDebito_Lancamentos : «' + RTRIM( ISNULL( CAST (IdNotaDebito_Lancamentos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialUnidade : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonial : «' + RTRIM( ISNULL( CAST (IdContaPatrimonial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceita : «' + RTRIM( ISNULL( CAST (IdContaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBanco : «' + RTRIM( ISNULL( CAST (IdContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoPatrimonial : «' + RTRIM( ISNULL( CAST (IdLancamentoPatrimonial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoRecebimento : «' + RTRIM( ISNULL( CAST (IdLancamentoRecebimento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdNotaDebito_Lancamentos : «' + RTRIM( ISNULL( CAST (IdNotaDebito_Lancamentos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonialUnidade : «' + RTRIM( ISNULL( CAST (IdContaPatrimonialUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaPatrimonial : «' + RTRIM( ISNULL( CAST (IdContaPatrimonial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceita : «' + RTRIM( ISNULL( CAST (IdContaReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaBanco : «' + RTRIM( ISNULL( CAST (IdContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoPatrimonial : «' + RTRIM( ISNULL( CAST (IdLancamentoPatrimonial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoRecebimento : «' + RTRIM( ISNULL( CAST (IdLancamentoRecebimento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
