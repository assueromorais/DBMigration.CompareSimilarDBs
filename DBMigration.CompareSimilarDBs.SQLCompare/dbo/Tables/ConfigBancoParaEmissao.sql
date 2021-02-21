CREATE TABLE [dbo].[ConfigBancoParaEmissao] (
    [IdConfigBancoParaEmissao]         UNIQUEIDENTIFIER NOT NULL,
    [CodJuros]                         TINYINT          NULL,
    [ValorJuros]                       MONEY            NULL,
    [CodMulta]                         TINYINT          NULL,
    [ValorMulta]                       MONEY            NULL,
    [CodProtesto]                      TINYINT          NULL,
    [QtdDiasProtesto]                  SMALLINT         NULL,
    [CodBaixa]                         TINYINT          NULL,
    [QtdDiasBaixa]                     SMALLINT         NULL,
    [QtdDiasMinimoAteVencimento]       INT              NULL,
    [IdMensagemParaBoleto]             INT              NULL,
    [IdMensagemParaArquivo]            INT              NULL,
    [IdInstrucaoParaArquivo]           INT              NULL,
    [ExibirComposicaoDebito]           BIT              CONSTRAINT [DF_ConfigBancoParaEmissao_ExibirComposicaoDebito] DEFAULT ((0)) NOT NULL,
    [HabilitaRegistroOnline]           BIT              CONSTRAINT [def_HabilitaRegistroOnline] DEFAULT ((0)) NOT NULL,
    [UrlRegistroOnline]                VARCHAR (120)    NULL,
    [RegistroOnLineImplanta]           BIT              NULL,
    [ClientRegistroOnLineImplanta]     VARCHAR (10)     NULL,
    [SecretRegistroOnLineImplanta]     VARCHAR (50)     NULL,
    [ConverterTaxaMensalEmValorDiario] BIT              NULL,
    CONSTRAINT [FK_ConfigBancoParaEmissao_InstrucaoParaArquivo] FOREIGN KEY ([IdInstrucaoParaArquivo]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]),
    CONSTRAINT [FK_ConfigBancoParaEmissao_MensagemParaArquivo] FOREIGN KEY ([IdMensagemParaArquivo]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]),
    CONSTRAINT [FK_ConfigBancoParaEmissao_MensagemParaBoleto] FOREIGN KEY ([IdMensagemParaBoleto]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario])
);


GO
CREATE TRIGGER [TrgLog_ConfigBancoParaEmissao] ON [Implanta_CRPAM].[dbo].[ConfigBancoParaEmissao] 
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
SET @TableName = 'ConfigBancoParaEmissao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasProtesto : «' + RTRIM( ISNULL( CAST (QtdDiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBaixa : «' + RTRIM( ISNULL( CAST (CodBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasBaixa : «' + RTRIM( ISNULL( CAST (QtdDiasBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasMinimoAteVencimento : «' + RTRIM( ISNULL( CAST (QtdDiasMinimoAteVencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagemParaBoleto : «' + RTRIM( ISNULL( CAST (IdMensagemParaBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagemParaArquivo : «' + RTRIM( ISNULL( CAST (IdMensagemParaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInstrucaoParaArquivo : «' + RTRIM( ISNULL( CAST (IdInstrucaoParaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirComposicaoDebito IS NULL THEN ' ExibirComposicaoDebito : «Nulo» '
                                              WHEN  ExibirComposicaoDebito = 0 THEN ' ExibirComposicaoDebito : «Falso» '
                                              WHEN  ExibirComposicaoDebito = 1 THEN ' ExibirComposicaoDebito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  HabilitaRegistroOnline IS NULL THEN ' HabilitaRegistroOnline : «Nulo» '
                                              WHEN  HabilitaRegistroOnline = 0 THEN ' HabilitaRegistroOnline : «Falso» '
                                              WHEN  HabilitaRegistroOnline = 1 THEN ' HabilitaRegistroOnline : «Verdadeiro» '
                                    END 
                         + '| UrlRegistroOnline : «' + RTRIM( ISNULL( CAST (UrlRegistroOnline AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistroOnLineImplanta IS NULL THEN ' RegistroOnLineImplanta : «Nulo» '
                                              WHEN  RegistroOnLineImplanta = 0 THEN ' RegistroOnLineImplanta : «Falso» '
                                              WHEN  RegistroOnLineImplanta = 1 THEN ' RegistroOnLineImplanta : «Verdadeiro» '
                                    END 
                         + '| ClientRegistroOnLineImplanta : «' + RTRIM( ISNULL( CAST (ClientRegistroOnLineImplanta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SecretRegistroOnLineImplanta : «' + RTRIM( ISNULL( CAST (SecretRegistroOnLineImplanta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConverterTaxaMensalEmValorDiario IS NULL THEN ' ConverterTaxaMensalEmValorDiario : «Nulo» '
                                              WHEN  ConverterTaxaMensalEmValorDiario = 0 THEN ' ConverterTaxaMensalEmValorDiario : «Falso» '
                                              WHEN  ConverterTaxaMensalEmValorDiario = 1 THEN ' ConverterTaxaMensalEmValorDiario : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasProtesto : «' + RTRIM( ISNULL( CAST (QtdDiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBaixa : «' + RTRIM( ISNULL( CAST (CodBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasBaixa : «' + RTRIM( ISNULL( CAST (QtdDiasBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasMinimoAteVencimento : «' + RTRIM( ISNULL( CAST (QtdDiasMinimoAteVencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagemParaBoleto : «' + RTRIM( ISNULL( CAST (IdMensagemParaBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagemParaArquivo : «' + RTRIM( ISNULL( CAST (IdMensagemParaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInstrucaoParaArquivo : «' + RTRIM( ISNULL( CAST (IdInstrucaoParaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirComposicaoDebito IS NULL THEN ' ExibirComposicaoDebito : «Nulo» '
                                              WHEN  ExibirComposicaoDebito = 0 THEN ' ExibirComposicaoDebito : «Falso» '
                                              WHEN  ExibirComposicaoDebito = 1 THEN ' ExibirComposicaoDebito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  HabilitaRegistroOnline IS NULL THEN ' HabilitaRegistroOnline : «Nulo» '
                                              WHEN  HabilitaRegistroOnline = 0 THEN ' HabilitaRegistroOnline : «Falso» '
                                              WHEN  HabilitaRegistroOnline = 1 THEN ' HabilitaRegistroOnline : «Verdadeiro» '
                                    END 
                         + '| UrlRegistroOnline : «' + RTRIM( ISNULL( CAST (UrlRegistroOnline AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistroOnLineImplanta IS NULL THEN ' RegistroOnLineImplanta : «Nulo» '
                                              WHEN  RegistroOnLineImplanta = 0 THEN ' RegistroOnLineImplanta : «Falso» '
                                              WHEN  RegistroOnLineImplanta = 1 THEN ' RegistroOnLineImplanta : «Verdadeiro» '
                                    END 
                         + '| ClientRegistroOnLineImplanta : «' + RTRIM( ISNULL( CAST (ClientRegistroOnLineImplanta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SecretRegistroOnLineImplanta : «' + RTRIM( ISNULL( CAST (SecretRegistroOnLineImplanta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConverterTaxaMensalEmValorDiario IS NULL THEN ' ConverterTaxaMensalEmValorDiario : «Nulo» '
                                              WHEN  ConverterTaxaMensalEmValorDiario = 0 THEN ' ConverterTaxaMensalEmValorDiario : «Falso» '
                                              WHEN  ConverterTaxaMensalEmValorDiario = 1 THEN ' ConverterTaxaMensalEmValorDiario : «Verdadeiro» '
                                    END  FROM INSERTED 
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
		SELECT @Conteudo = 'CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasProtesto : «' + RTRIM( ISNULL( CAST (QtdDiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBaixa : «' + RTRIM( ISNULL( CAST (CodBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasBaixa : «' + RTRIM( ISNULL( CAST (QtdDiasBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasMinimoAteVencimento : «' + RTRIM( ISNULL( CAST (QtdDiasMinimoAteVencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagemParaBoleto : «' + RTRIM( ISNULL( CAST (IdMensagemParaBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagemParaArquivo : «' + RTRIM( ISNULL( CAST (IdMensagemParaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInstrucaoParaArquivo : «' + RTRIM( ISNULL( CAST (IdInstrucaoParaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirComposicaoDebito IS NULL THEN ' ExibirComposicaoDebito : «Nulo» '
                                              WHEN  ExibirComposicaoDebito = 0 THEN ' ExibirComposicaoDebito : «Falso» '
                                              WHEN  ExibirComposicaoDebito = 1 THEN ' ExibirComposicaoDebito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  HabilitaRegistroOnline IS NULL THEN ' HabilitaRegistroOnline : «Nulo» '
                                              WHEN  HabilitaRegistroOnline = 0 THEN ' HabilitaRegistroOnline : «Falso» '
                                              WHEN  HabilitaRegistroOnline = 1 THEN ' HabilitaRegistroOnline : «Verdadeiro» '
                                    END 
                         + '| UrlRegistroOnline : «' + RTRIM( ISNULL( CAST (UrlRegistroOnline AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistroOnLineImplanta IS NULL THEN ' RegistroOnLineImplanta : «Nulo» '
                                              WHEN  RegistroOnLineImplanta = 0 THEN ' RegistroOnLineImplanta : «Falso» '
                                              WHEN  RegistroOnLineImplanta = 1 THEN ' RegistroOnLineImplanta : «Verdadeiro» '
                                    END 
                         + '| ClientRegistroOnLineImplanta : «' + RTRIM( ISNULL( CAST (ClientRegistroOnLineImplanta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SecretRegistroOnLineImplanta : «' + RTRIM( ISNULL( CAST (SecretRegistroOnLineImplanta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConverterTaxaMensalEmValorDiario IS NULL THEN ' ConverterTaxaMensalEmValorDiario : «Nulo» '
                                              WHEN  ConverterTaxaMensalEmValorDiario = 0 THEN ' ConverterTaxaMensalEmValorDiario : «Falso» '
                                              WHEN  ConverterTaxaMensalEmValorDiario = 1 THEN ' ConverterTaxaMensalEmValorDiario : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasProtesto : «' + RTRIM( ISNULL( CAST (QtdDiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBaixa : «' + RTRIM( ISNULL( CAST (CodBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasBaixa : «' + RTRIM( ISNULL( CAST (QtdDiasBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasMinimoAteVencimento : «' + RTRIM( ISNULL( CAST (QtdDiasMinimoAteVencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagemParaBoleto : «' + RTRIM( ISNULL( CAST (IdMensagemParaBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagemParaArquivo : «' + RTRIM( ISNULL( CAST (IdMensagemParaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInstrucaoParaArquivo : «' + RTRIM( ISNULL( CAST (IdInstrucaoParaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirComposicaoDebito IS NULL THEN ' ExibirComposicaoDebito : «Nulo» '
                                              WHEN  ExibirComposicaoDebito = 0 THEN ' ExibirComposicaoDebito : «Falso» '
                                              WHEN  ExibirComposicaoDebito = 1 THEN ' ExibirComposicaoDebito : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  HabilitaRegistroOnline IS NULL THEN ' HabilitaRegistroOnline : «Nulo» '
                                              WHEN  HabilitaRegistroOnline = 0 THEN ' HabilitaRegistroOnline : «Falso» '
                                              WHEN  HabilitaRegistroOnline = 1 THEN ' HabilitaRegistroOnline : «Verdadeiro» '
                                    END 
                         + '| UrlRegistroOnline : «' + RTRIM( ISNULL( CAST (UrlRegistroOnline AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistroOnLineImplanta IS NULL THEN ' RegistroOnLineImplanta : «Nulo» '
                                              WHEN  RegistroOnLineImplanta = 0 THEN ' RegistroOnLineImplanta : «Falso» '
                                              WHEN  RegistroOnLineImplanta = 1 THEN ' RegistroOnLineImplanta : «Verdadeiro» '
                                    END 
                         + '| ClientRegistroOnLineImplanta : «' + RTRIM( ISNULL( CAST (ClientRegistroOnLineImplanta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SecretRegistroOnLineImplanta : «' + RTRIM( ISNULL( CAST (SecretRegistroOnLineImplanta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConverterTaxaMensalEmValorDiario IS NULL THEN ' ConverterTaxaMensalEmValorDiario : «Nulo» '
                                              WHEN  ConverterTaxaMensalEmValorDiario = 0 THEN ' ConverterTaxaMensalEmValorDiario : «Falso» '
                                              WHEN  ConverterTaxaMensalEmValorDiario = 1 THEN ' ConverterTaxaMensalEmValorDiario : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
