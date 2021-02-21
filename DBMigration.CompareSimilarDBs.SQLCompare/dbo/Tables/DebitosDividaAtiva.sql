CREATE TABLE [dbo].[DebitosDividaAtiva] (
    [IdDebitoDividaAtiva]  INT          IDENTITY (1, 1) NOT NULL,
    [IdDividaAtiva]        INT          NOT NULL,
    [IdDebito]             INT          NULL,
    [ValorPrincipal]       MONEY        NULL,
    [ValorAtualizacao]     MONEY        NULL,
    [ValorMulta]           MONEY        NULL,
    [ValorJuros]           MONEY        NULL,
    [IdProcedimentoAtraso] INT          NULL,
    [NumOrdem]             INT          NULL,
    [IdTipoDebito]         INT          NULL,
    [DataVencimento]       DATETIME     NULL,
    [DataReferencia]       DATETIME     NULL,
    [NumeroParcela]        INT          NULL,
    [IdMoeda]              INT          NULL,
    [NossoNumero]          VARCHAR (17) NULL,
    [SituacaoDebito]       INT          CONSTRAINT [DF_DebitosDividaAtivaSituacaoDebito] DEFAULT ((1)) NULL,
    [MotivoCancelamento]   TEXT         NULL,
    [DtCancelIndividual]   DATETIME     NULL,
    [Observacoes]          TEXT         NULL,
    CONSTRAINT [PK_DebitosDividaAtiva] PRIMARY KEY CLUSTERED ([IdDebitoDividaAtiva] ASC),
    CONSTRAINT [FK_DebitosDividaAtiva_Debito] FOREIGN KEY ([IdDebito]) REFERENCES [dbo].[Debitos] ([IdDebito]),
    CONSTRAINT [FK_DebitosDividaAtiva_DividaAtiva] FOREIGN KEY ([IdDividaAtiva]) REFERENCES [dbo].[DividaAtiva] ([IdDividaAtiva]),
    CONSTRAINT [FK_DebitosDividaAtiva_Moedas] FOREIGN KEY ([IdMoeda]) REFERENCES [dbo].[Moedas] ([IdMoeda]),
    CONSTRAINT [FK_DebitosDividaAtiva_ProcedimentosAtraso] FOREIGN KEY ([IdProcedimentoAtraso]) REFERENCES [dbo].[ProcedimentosAtraso] ([IdProcedimentoAtraso]),
    CONSTRAINT [FK_DebitosDividaAtiva_TiposDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito])
);


GO
ALTER TABLE [dbo].[DebitosDividaAtiva] NOCHECK CONSTRAINT [FK_DebitosDividaAtiva_Debito];


GO
CREATE TRIGGER [TrgLog_DebitosDividaAtiva] ON [Implanta_CRPAM].[dbo].[DebitosDividaAtiva] 
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
SET @TableName = 'DebitosDividaAtiva'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDebitoDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDebitoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumOrdem : «' + RTRIM( ISNULL( CAST (NumOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoDebito : «' + RTRIM( ISNULL( CAST (SituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtCancelIndividual : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCancelIndividual, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDebitoDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDebitoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumOrdem : «' + RTRIM( ISNULL( CAST (NumOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoDebito : «' + RTRIM( ISNULL( CAST (SituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtCancelIndividual : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCancelIndividual, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDebitoDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDebitoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumOrdem : «' + RTRIM( ISNULL( CAST (NumOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoDebito : «' + RTRIM( ISNULL( CAST (SituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtCancelIndividual : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCancelIndividual, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDebitoDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDebitoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumOrdem : «' + RTRIM( ISNULL( CAST (NumOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoeda : «' + RTRIM( ISNULL( CAST (IdMoeda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoDebito : «' + RTRIM( ISNULL( CAST (SituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtCancelIndividual : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCancelIndividual, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
