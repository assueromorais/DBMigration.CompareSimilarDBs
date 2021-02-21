CREATE TABLE [dbo].[ComposicoesDebito] (
    [IdComposicaoDebito]            INT          IDENTITY (1, 1) NOT NULL,
    [IdDebito]                      INT          NOT NULL,
    [IdProcedimentoAtraso]          INT          NULL,
    [ValorEsperadoPrincipal]        MONEY        NULL,
    [IdMoedaValorEsperado]          INT          NULL,
    [ValorEsperadoAtualizacao]      MONEY        NULL,
    [ValorEsperadoMulta]            MONEY        NULL,
    [ValorEsperadoJuros]            MONEY        NULL,
    [ValorEsperadoDespBco]          MONEY        NULL,
    [ValorEsperadoDespAdv]          MONEY        NULL,
    [ValorEsperadoDespPostais]      MONEY        NULL,
    [ValorPagoPrincipal]            MONEY        NULL,
    [ValorPagoAtualizacao]          MONEY        NULL,
    [ValorPagoMulta]                MONEY        NULL,
    [ValorPagoJuros]                MONEY        NULL,
    [ValorPagoDespBco]              MONEY        NULL,
    [ValorPagoDespAdv]              MONEY        NULL,
    [ValorPagoDespPostais]          MONEY        NULL,
    [IdDebitoOrigemRen]             INT          NULL,
    [NaoExisteDebPai]               BIT          NULL,
    [RegistraLog]                   BIT          CONSTRAINT [DF__Composico__Regis__043B7C66] DEFAULT ((1)) NULL,
    [ValorEsperadoDAPrincipal]      MONEY        NULL,
    [ValorEsperadoDAAtualizacao]    MONEY        NULL,
    [ValorEsperadoDAMulta]          MONEY        NULL,
    [ValorEsperadoDAJuros]          MONEY        NULL,
    [ValorEsperadoDADespBco]        MONEY        NULL,
    [ValorEsperadoDADespAdv]        MONEY        NULL,
    [ValorEsperadoDADespPostais]    MONEY        NULL,
    [ValorPagoDAPrincipal]          MONEY        NULL,
    [ValorPagoDAAtualizacao]        MONEY        NULL,
    [ValorPagoDAMulta]              MONEY        NULL,
    [ValorPagoDAJuros]              MONEY        NULL,
    [ValorPagoDADespBco]            MONEY        NULL,
    [ValorPagoDADespAdv]            MONEY        NULL,
    [ValorPagoDADespPostais]        MONEY        NULL,
    [DataUltimaAtualizacao]         DATETIME     NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60) NULL,
    [IdDebitoRenRec]                INT          NULL,
    [IndReceita]                    INT          NULL,
    [ValorMenosRepasse]             MONEY        NULL,
    [TaxaBanco]                     MONEY        NULL,
    [ValorCreditado]                MONEY        NULL,
    [ValorDescontoPrincipal]        MONEY        NULL,
    CONSTRAINT [PK_ComposicoesDebito] PRIMARY KEY CLUSTERED ([IdComposicaoDebito] ASC),
    CONSTRAINT [FK_ComposicoesDebito_Debitos] FOREIGN KEY ([IdDebito]) REFERENCES [dbo].[Debitos] ([IdDebito]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ComposicoesDebito_Moedas] FOREIGN KEY ([IdMoedaValorEsperado]) REFERENCES [dbo].[Moedas] ([IdMoeda]),
    CONSTRAINT [FK_ComposicoesDebito_ProcedimentosAtraso] FOREIGN KEY ([IdProcedimentoAtraso]) REFERENCES [dbo].[ProcedimentosAtraso] ([IdProcedimentoAtraso])
);


GO
CREATE TRIGGER [TrgLog_ComposicoesDebito] ON [Implanta_CRPAM].[dbo].[ComposicoesDebito] 
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
SET @TableName = 'ComposicoesDebito'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdComposicaoDebito : «' + RTRIM( ISNULL( CAST (IdComposicaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoPrincipal : «' + RTRIM( ISNULL( CAST (ValorEsperadoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaValorEsperado : «' + RTRIM( ISNULL( CAST (IdMoedaValorEsperado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoAtualizacao : «' + RTRIM( ISNULL( CAST (ValorEsperadoAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoMulta : «' + RTRIM( ISNULL( CAST (ValorEsperadoMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoJuros : «' + RTRIM( ISNULL( CAST (ValorEsperadoJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespBco : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespAdv : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespPostais : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoPrincipal : «' + RTRIM( ISNULL( CAST (ValorPagoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoAtualizacao : «' + RTRIM( ISNULL( CAST (ValorPagoAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoMulta : «' + RTRIM( ISNULL( CAST (ValorPagoMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoJuros : «' + RTRIM( ISNULL( CAST (ValorPagoJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespBco : «' + RTRIM( ISNULL( CAST (ValorPagoDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespAdv : «' + RTRIM( ISNULL( CAST (ValorPagoDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespPostais : «' + RTRIM( ISNULL( CAST (ValorPagoDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoOrigemRen : «' + RTRIM( ISNULL( CAST (IdDebitoOrigemRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoExisteDebPai IS NULL THEN ' NaoExisteDebPai : «Nulo» '
                                              WHEN  NaoExisteDebPai = 0 THEN ' NaoExisteDebPai : «Falso» '
                                              WHEN  NaoExisteDebPai = 1 THEN ' NaoExisteDebPai : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ValorEsperadoDAPrincipal : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAAtualizacao : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAMulta : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAJuros : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespBco : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespAdv : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespPostais : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAPrincipal : «' + RTRIM( ISNULL( CAST (ValorPagoDAPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAAtualizacao : «' + RTRIM( ISNULL( CAST (ValorPagoDAAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAMulta : «' + RTRIM( ISNULL( CAST (ValorPagoDAMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAJuros : «' + RTRIM( ISNULL( CAST (ValorPagoDAJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespBco : «' + RTRIM( ISNULL( CAST (ValorPagoDADespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespAdv : «' + RTRIM( ISNULL( CAST (ValorPagoDADespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespPostais : «' + RTRIM( ISNULL( CAST (ValorPagoDADespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoRenRec : «' + RTRIM( ISNULL( CAST (IdDebitoRenRec AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndReceita : «' + RTRIM( ISNULL( CAST (IndReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMenosRepasse : «' + RTRIM( ISNULL( CAST (ValorMenosRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaBanco : «' + RTRIM( ISNULL( CAST (TaxaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCreditado : «' + RTRIM( ISNULL( CAST (ValorCreditado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDescontoPrincipal : «' + RTRIM( ISNULL( CAST (ValorDescontoPrincipal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdComposicaoDebito : «' + RTRIM( ISNULL( CAST (IdComposicaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoPrincipal : «' + RTRIM( ISNULL( CAST (ValorEsperadoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaValorEsperado : «' + RTRIM( ISNULL( CAST (IdMoedaValorEsperado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoAtualizacao : «' + RTRIM( ISNULL( CAST (ValorEsperadoAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoMulta : «' + RTRIM( ISNULL( CAST (ValorEsperadoMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoJuros : «' + RTRIM( ISNULL( CAST (ValorEsperadoJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespBco : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespAdv : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespPostais : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoPrincipal : «' + RTRIM( ISNULL( CAST (ValorPagoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoAtualizacao : «' + RTRIM( ISNULL( CAST (ValorPagoAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoMulta : «' + RTRIM( ISNULL( CAST (ValorPagoMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoJuros : «' + RTRIM( ISNULL( CAST (ValorPagoJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespBco : «' + RTRIM( ISNULL( CAST (ValorPagoDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespAdv : «' + RTRIM( ISNULL( CAST (ValorPagoDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespPostais : «' + RTRIM( ISNULL( CAST (ValorPagoDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoOrigemRen : «' + RTRIM( ISNULL( CAST (IdDebitoOrigemRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoExisteDebPai IS NULL THEN ' NaoExisteDebPai : «Nulo» '
                                              WHEN  NaoExisteDebPai = 0 THEN ' NaoExisteDebPai : «Falso» '
                                              WHEN  NaoExisteDebPai = 1 THEN ' NaoExisteDebPai : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ValorEsperadoDAPrincipal : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAAtualizacao : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAMulta : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAJuros : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespBco : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespAdv : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespPostais : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAPrincipal : «' + RTRIM( ISNULL( CAST (ValorPagoDAPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAAtualizacao : «' + RTRIM( ISNULL( CAST (ValorPagoDAAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAMulta : «' + RTRIM( ISNULL( CAST (ValorPagoDAMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAJuros : «' + RTRIM( ISNULL( CAST (ValorPagoDAJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespBco : «' + RTRIM( ISNULL( CAST (ValorPagoDADespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespAdv : «' + RTRIM( ISNULL( CAST (ValorPagoDADespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespPostais : «' + RTRIM( ISNULL( CAST (ValorPagoDADespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoRenRec : «' + RTRIM( ISNULL( CAST (IdDebitoRenRec AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndReceita : «' + RTRIM( ISNULL( CAST (IndReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMenosRepasse : «' + RTRIM( ISNULL( CAST (ValorMenosRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaBanco : «' + RTRIM( ISNULL( CAST (TaxaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCreditado : «' + RTRIM( ISNULL( CAST (ValorCreditado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDescontoPrincipal : «' + RTRIM( ISNULL( CAST (ValorDescontoPrincipal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdComposicaoDebito : «' + RTRIM( ISNULL( CAST (IdComposicaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoPrincipal : «' + RTRIM( ISNULL( CAST (ValorEsperadoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaValorEsperado : «' + RTRIM( ISNULL( CAST (IdMoedaValorEsperado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoAtualizacao : «' + RTRIM( ISNULL( CAST (ValorEsperadoAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoMulta : «' + RTRIM( ISNULL( CAST (ValorEsperadoMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoJuros : «' + RTRIM( ISNULL( CAST (ValorEsperadoJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespBco : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespAdv : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespPostais : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoPrincipal : «' + RTRIM( ISNULL( CAST (ValorPagoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoAtualizacao : «' + RTRIM( ISNULL( CAST (ValorPagoAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoMulta : «' + RTRIM( ISNULL( CAST (ValorPagoMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoJuros : «' + RTRIM( ISNULL( CAST (ValorPagoJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespBco : «' + RTRIM( ISNULL( CAST (ValorPagoDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespAdv : «' + RTRIM( ISNULL( CAST (ValorPagoDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespPostais : «' + RTRIM( ISNULL( CAST (ValorPagoDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoOrigemRen : «' + RTRIM( ISNULL( CAST (IdDebitoOrigemRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoExisteDebPai IS NULL THEN ' NaoExisteDebPai : «Nulo» '
                                              WHEN  NaoExisteDebPai = 0 THEN ' NaoExisteDebPai : «Falso» '
                                              WHEN  NaoExisteDebPai = 1 THEN ' NaoExisteDebPai : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ValorEsperadoDAPrincipal : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAAtualizacao : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAMulta : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAJuros : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespBco : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespAdv : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespPostais : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAPrincipal : «' + RTRIM( ISNULL( CAST (ValorPagoDAPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAAtualizacao : «' + RTRIM( ISNULL( CAST (ValorPagoDAAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAMulta : «' + RTRIM( ISNULL( CAST (ValorPagoDAMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAJuros : «' + RTRIM( ISNULL( CAST (ValorPagoDAJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespBco : «' + RTRIM( ISNULL( CAST (ValorPagoDADespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespAdv : «' + RTRIM( ISNULL( CAST (ValorPagoDADespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespPostais : «' + RTRIM( ISNULL( CAST (ValorPagoDADespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoRenRec : «' + RTRIM( ISNULL( CAST (IdDebitoRenRec AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndReceita : «' + RTRIM( ISNULL( CAST (IndReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMenosRepasse : «' + RTRIM( ISNULL( CAST (ValorMenosRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaBanco : «' + RTRIM( ISNULL( CAST (TaxaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCreditado : «' + RTRIM( ISNULL( CAST (ValorCreditado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDescontoPrincipal : «' + RTRIM( ISNULL( CAST (ValorDescontoPrincipal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdComposicaoDebito : «' + RTRIM( ISNULL( CAST (IdComposicaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoPrincipal : «' + RTRIM( ISNULL( CAST (ValorEsperadoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaValorEsperado : «' + RTRIM( ISNULL( CAST (IdMoedaValorEsperado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoAtualizacao : «' + RTRIM( ISNULL( CAST (ValorEsperadoAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoMulta : «' + RTRIM( ISNULL( CAST (ValorEsperadoMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoJuros : «' + RTRIM( ISNULL( CAST (ValorEsperadoJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespBco : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespAdv : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDespPostais : «' + RTRIM( ISNULL( CAST (ValorEsperadoDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoPrincipal : «' + RTRIM( ISNULL( CAST (ValorPagoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoAtualizacao : «' + RTRIM( ISNULL( CAST (ValorPagoAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoMulta : «' + RTRIM( ISNULL( CAST (ValorPagoMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoJuros : «' + RTRIM( ISNULL( CAST (ValorPagoJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespBco : «' + RTRIM( ISNULL( CAST (ValorPagoDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespAdv : «' + RTRIM( ISNULL( CAST (ValorPagoDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDespPostais : «' + RTRIM( ISNULL( CAST (ValorPagoDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoOrigemRen : «' + RTRIM( ISNULL( CAST (IdDebitoOrigemRen AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoExisteDebPai IS NULL THEN ' NaoExisteDebPai : «Nulo» '
                                              WHEN  NaoExisteDebPai = 0 THEN ' NaoExisteDebPai : «Falso» '
                                              WHEN  NaoExisteDebPai = 1 THEN ' NaoExisteDebPai : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ValorEsperadoDAPrincipal : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAAtualizacao : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAMulta : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDAJuros : «' + RTRIM( ISNULL( CAST (ValorEsperadoDAJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespBco : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespAdv : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEsperadoDADespPostais : «' + RTRIM( ISNULL( CAST (ValorEsperadoDADespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAPrincipal : «' + RTRIM( ISNULL( CAST (ValorPagoDAPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAAtualizacao : «' + RTRIM( ISNULL( CAST (ValorPagoDAAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAMulta : «' + RTRIM( ISNULL( CAST (ValorPagoDAMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDAJuros : «' + RTRIM( ISNULL( CAST (ValorPagoDAJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespBco : «' + RTRIM( ISNULL( CAST (ValorPagoDADespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespAdv : «' + RTRIM( ISNULL( CAST (ValorPagoDADespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagoDADespPostais : «' + RTRIM( ISNULL( CAST (ValorPagoDADespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoRenRec : «' + RTRIM( ISNULL( CAST (IdDebitoRenRec AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndReceita : «' + RTRIM( ISNULL( CAST (IndReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMenosRepasse : «' + RTRIM( ISNULL( CAST (ValorMenosRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaBanco : «' + RTRIM( ISNULL( CAST (TaxaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCreditado : «' + RTRIM( ISNULL( CAST (ValorCreditado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDescontoPrincipal : «' + RTRIM( ISNULL( CAST (ValorDescontoPrincipal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
