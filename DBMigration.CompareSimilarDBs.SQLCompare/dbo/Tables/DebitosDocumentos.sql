CREATE TABLE [dbo].[DebitosDocumentos] (
    [IdDocumento]     INT          NOT NULL,
    [IdDebito]        INT          NOT NULL,
    [IdTipoDebito]    INT          NULL,
    [IdSituacaoAtual] INT          NULL,
    [DataReferencia]  DATETIME     NULL,
    [NumeroParcela]   INT          NULL,
    [ValorDevido]     MONEY        NULL,
    [DataVencimento]  DATETIME     NULL,
    [NossoNumero]     VARCHAR (20) NULL,
    CONSTRAINT [FK_DebitosDocumentos_Debitos] FOREIGN KEY ([IdDebito]) REFERENCES [dbo].[Debitos] ([IdDebito]),
    CONSTRAINT [FK_DebitosDocumentos_DocumentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]),
    CONSTRAINT [FK_DebitosDocumentos_SituacoesDebito] FOREIGN KEY ([IdSituacaoAtual]) REFERENCES [dbo].[SituacoesDebito] ([IdSituacaoDebito]),
    CONSTRAINT [FK_DebitosDocumentos_TiposDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito])
);


GO
ALTER TABLE [dbo].[DebitosDocumentos] NOCHECK CONSTRAINT [FK_DebitosDocumentos_Debitos];


GO
ALTER TABLE [dbo].[DebitosDocumentos] NOCHECK CONSTRAINT [FK_DebitosDocumentos_DocumentosSisdoc];


GO
CREATE TRIGGER [TrgLog_DebitosDocumentos] ON [Implanta_CRPAM].[dbo].[DebitosDocumentos] 
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
SET @TableName = 'DebitosDocumentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAtual : «' + RTRIM( ISNULL( CAST (IdSituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAtual : «' + RTRIM( ISNULL( CAST (IdSituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAtual : «' + RTRIM( ISNULL( CAST (IdSituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAtual : «' + RTRIM( ISNULL( CAST (IdSituacaoAtual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferencia, 113 ),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
