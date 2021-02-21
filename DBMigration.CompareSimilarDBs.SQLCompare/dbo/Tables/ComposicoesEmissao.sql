CREATE TABLE [dbo].[ComposicoesEmissao] (
    [IdComposicaoEmissao]  INT            IDENTITY (1, 1) NOT NULL,
    [IdDetalheEmissao]     INT            NOT NULL,
    [IdDebito]             INT            NOT NULL,
    [IdMoedaDevida]        INT            NULL,
    [Sigladebito]          VARCHAR (10)   NULL,
    [NumeroParcela]        INT            NULL,
    [DataReferenciaDebito] VARCHAR (8)    NULL,
    [DataVencimentoDebito] DATETIME       NULL,
    [ValorDevido]          MONEY          NULL,
    [ValorPrincipal]       MONEY          NULL,
    [ValorAtualizacao]     MONEY          NULL,
    [ValorMulta]           MONEY          NULL,
    [ValorJuros]           MONEY          NULL,
    [ValorDespBco]         MONEY          NULL,
    [ValorDespAdv]         MONEY          NULL,
    [ValorDespPostais]     MONEY          NULL,
    [IdProcedimento]       INT            NULL,
    [RegistraLog]          BIT            CONSTRAINT [DF__Composico__Regis__0717E911] DEFAULT ((1)) NULL,
    [AtualizacaoWeb]       VARCHAR (8000) NULL,
    [ValorDesconto]        MONEY          NULL,
    CONSTRAINT [PK_ComposicoesEmissao] PRIMARY KEY CLUSTERED ([IdComposicaoEmissao] ASC),
    CONSTRAINT [FK_DetEmissao_Debitos] FOREIGN KEY ([IdDebito]) REFERENCES [dbo].[Debitos] ([IdDebito]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DetEmissao_Debitos_DetalhesEmissao] FOREIGN KEY ([IdDetalheEmissao]) REFERENCES [dbo].[DetalhesEmissao] ([IdDetalheEmissao]),
    CONSTRAINT [FK_DetEmissao_Debitos_Moedas] FOREIGN KEY ([IdMoedaDevida]) REFERENCES [dbo].[Moedas] ([IdMoeda])
);


GO
ALTER TABLE [dbo].[ComposicoesEmissao] NOCHECK CONSTRAINT [FK_DetEmissao_Debitos];


GO
CREATE NONCLUSTERED INDEX [_ix_ComposicoesEmissao_IdDebito]
    ON [dbo].[ComposicoesEmissao]([IdDebito] ASC);


GO
CREATE NONCLUSTERED INDEX [_ix_ComposicoesEmissao_IdDetalheEmissao]
    ON [dbo].[ComposicoesEmissao]([IdDetalheEmissao] ASC);


GO
CREATE TRIGGER [TrgLog_ComposicoesEmissao] ON [Implanta_CRPAM].[dbo].[ComposicoesEmissao] 
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
SET @TableName = 'ComposicoesEmissao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdComposicaoEmissao : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDevida : «' + RTRIM( ISNULL( CAST (IdMoedaDevida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sigladebito : «' + RTRIM( ISNULL( CAST (Sigladebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaDebito : «' + RTRIM( ISNULL( CAST (DataReferenciaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimentoDebito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoDebito, 113 ),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBco : «' + RTRIM( ISNULL( CAST (ValorDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostais : «' + RTRIM( ISNULL( CAST (ValorDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimento : «' + RTRIM( ISNULL( CAST (IdProcedimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDesconto : «' + RTRIM( ISNULL( CAST (ValorDesconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdComposicaoEmissao : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDevida : «' + RTRIM( ISNULL( CAST (IdMoedaDevida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sigladebito : «' + RTRIM( ISNULL( CAST (Sigladebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaDebito : «' + RTRIM( ISNULL( CAST (DataReferenciaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimentoDebito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoDebito, 113 ),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBco : «' + RTRIM( ISNULL( CAST (ValorDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostais : «' + RTRIM( ISNULL( CAST (ValorDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimento : «' + RTRIM( ISNULL( CAST (IdProcedimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDesconto : «' + RTRIM( ISNULL( CAST (ValorDesconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdComposicaoEmissao : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDevida : «' + RTRIM( ISNULL( CAST (IdMoedaDevida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sigladebito : «' + RTRIM( ISNULL( CAST (Sigladebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaDebito : «' + RTRIM( ISNULL( CAST (DataReferenciaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimentoDebito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoDebito, 113 ),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBco : «' + RTRIM( ISNULL( CAST (ValorDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostais : «' + RTRIM( ISNULL( CAST (ValorDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimento : «' + RTRIM( ISNULL( CAST (IdProcedimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDesconto : «' + RTRIM( ISNULL( CAST (ValorDesconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdComposicaoEmissao : «' + RTRIM( ISNULL( CAST (IdComposicaoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDevida : «' + RTRIM( ISNULL( CAST (IdMoedaDevida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sigladebito : «' + RTRIM( ISNULL( CAST (Sigladebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaDebito : «' + RTRIM( ISNULL( CAST (DataReferenciaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimentoDebito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoDebito, 113 ),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBco : «' + RTRIM( ISNULL( CAST (ValorDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostais : «' + RTRIM( ISNULL( CAST (ValorDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimento : «' + RTRIM( ISNULL( CAST (IdProcedimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDesconto : «' + RTRIM( ISNULL( CAST (ValorDesconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
