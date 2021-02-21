CREATE TABLE [dbo].[ContasCorrentesSispad] (
    [IdContaCorrente]         INT           IDENTITY (1, 1) NOT NULL,
    [IdBancoSispad]           INT           NOT NULL,
    [IdMsgInstrCobrPadrao]    INT           NULL,
    [IdMsgObsPadrao]          INT           NULL,
    [CodigoAgencia]           INT           NULL,
    [DVAgencia]               NVARCHAR (5)  NULL,
    [NomeAgencia]             NVARCHAR (30) NULL,
    [ContaCorrente]           NVARCHAR (13) NULL,
    [DVContaCorrente]         NVARCHAR (5)  NULL,
    [Operacao]                NVARCHAR (3)  NULL,
    [Variacao]                NVARCHAR (3)  NULL,
    [CodigoConvenio]          VARCHAR (20)  NULL,
    [CodigoCedente]           NVARCHAR (16) NULL,
    [DVCodigoCedente]         INT           NULL,
    [Carteira]                NVARCHAR (5)  NULL,
    [CodigoEmpresa]           NVARCHAR (20) NULL,
    [PrefixoNossoNumero]      NVARCHAR (5)  NULL,
    [InicioNossoNumero]       BIGINT        NULL,
    [FimNossoNumero]          BIGINT        NULL,
    [SequencialNossoNumero]   BIGINT        NULL,
    [SequencialRemessa]       INT           NULL,
    [PercentualRepasse]       FLOAT (53)    NULL,
    [ValorTarifa]             MONEY         NULL,
    [QtdeDiasVencimento]      INT           NULL,
    [ValorMulta]              MONEY         NULL,
    [ValorJurosMora]          MONEY         NULL,
    [IdContaCreditoEstorno]   INT           NULL,
    [IdFormaPgtoEstorno]      INT           NULL,
    [IdFavorecidoEstorno]     INT           NULL,
    [IdTipoDocumentoEstorno]  INT           NULL,
    [IdContaReceitaPosterior] INT           NULL,
    CONSTRAINT [PK_ContasCorrentesSispad] PRIMARY KEY CLUSTERED ([IdContaCorrente] ASC),
    CONSTRAINT [FK_ContasCorrentesSispad_BancosSispad] FOREIGN KEY ([IdBancoSispad]) REFERENCES [dbo].[BancosSispad] ([IdBancoSispad]),
    CONSTRAINT [FK_ContasCorrentesSispad_MsgBoletosSispadInstr] FOREIGN KEY ([IdMsgInstrCobrPadrao]) REFERENCES [dbo].[MsgBoletosSispad] ([IdMsgBoleto]),
    CONSTRAINT [FK_ContasCorrentesSispad_MsgBoletosSispadObs] FOREIGN KEY ([IdMsgObsPadrao]) REFERENCES [dbo].[MsgBoletosSispad] ([IdMsgBoleto])
);


GO
CREATE TRIGGER [TrgLog_ContasCorrentesSispad] ON [Implanta_CRPAM].[dbo].[ContasCorrentesSispad] 
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
SET @TableName = 'ContasCorrentesSispad'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSispad : «' + RTRIM( ISNULL( CAST (IdBancoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoConvenio : «' + RTRIM( ISNULL( CAST (CodigoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNumero : «' + RTRIM( ISNULL( CAST (InicioNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNumero : «' + RTRIM( ISNULL( CAST (FimNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDiasVencimento : «' + RTRIM( ISNULL( CAST (QtdeDiasVencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJurosMora : «' + RTRIM( ISNULL( CAST (ValorJurosMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoEstorno : «' + RTRIM( ISNULL( CAST (IdContaCreditoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPgtoEstorno : «' + RTRIM( ISNULL( CAST (IdFormaPgtoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFavorecidoEstorno : «' + RTRIM( ISNULL( CAST (IdFavorecidoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoEstorno : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceitaPosterior : «' + RTRIM( ISNULL( CAST (IdContaReceitaPosterior AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSispad : «' + RTRIM( ISNULL( CAST (IdBancoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoConvenio : «' + RTRIM( ISNULL( CAST (CodigoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNumero : «' + RTRIM( ISNULL( CAST (InicioNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNumero : «' + RTRIM( ISNULL( CAST (FimNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDiasVencimento : «' + RTRIM( ISNULL( CAST (QtdeDiasVencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJurosMora : «' + RTRIM( ISNULL( CAST (ValorJurosMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoEstorno : «' + RTRIM( ISNULL( CAST (IdContaCreditoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPgtoEstorno : «' + RTRIM( ISNULL( CAST (IdFormaPgtoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFavorecidoEstorno : «' + RTRIM( ISNULL( CAST (IdFavorecidoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoEstorno : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceitaPosterior : «' + RTRIM( ISNULL( CAST (IdContaReceitaPosterior AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSispad : «' + RTRIM( ISNULL( CAST (IdBancoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoConvenio : «' + RTRIM( ISNULL( CAST (CodigoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNumero : «' + RTRIM( ISNULL( CAST (InicioNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNumero : «' + RTRIM( ISNULL( CAST (FimNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDiasVencimento : «' + RTRIM( ISNULL( CAST (QtdeDiasVencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJurosMora : «' + RTRIM( ISNULL( CAST (ValorJurosMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoEstorno : «' + RTRIM( ISNULL( CAST (IdContaCreditoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPgtoEstorno : «' + RTRIM( ISNULL( CAST (IdFormaPgtoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFavorecidoEstorno : «' + RTRIM( ISNULL( CAST (IdFavorecidoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoEstorno : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceitaPosterior : «' + RTRIM( ISNULL( CAST (IdContaReceitaPosterior AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSispad : «' + RTRIM( ISNULL( CAST (IdBancoSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgInstrCobrPadrao : «' + RTRIM( ISNULL( CAST (IdMsgInstrCobrPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgObsPadrao : «' + RTRIM( ISNULL( CAST (IdMsgObsPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoConvenio : «' + RTRIM( ISNULL( CAST (CodigoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioNossoNumero : «' + RTRIM( ISNULL( CAST (InicioNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FimNossoNumero : «' + RTRIM( ISNULL( CAST (FimNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialNossoNumero : «' + RTRIM( ISNULL( CAST (SequencialNossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualRepasse : «' + RTRIM( ISNULL( CAST (PercentualRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTarifa : «' + RTRIM( ISNULL( CAST (ValorTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDiasVencimento : «' + RTRIM( ISNULL( CAST (QtdeDiasVencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJurosMora : «' + RTRIM( ISNULL( CAST (ValorJurosMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCreditoEstorno : «' + RTRIM( ISNULL( CAST (IdContaCreditoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPgtoEstorno : «' + RTRIM( ISNULL( CAST (IdFormaPgtoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFavorecidoEstorno : «' + RTRIM( ISNULL( CAST (IdFavorecidoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoEstorno : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaReceitaPosterior : «' + RTRIM( ISNULL( CAST (IdContaReceitaPosterior AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
