CREATE TABLE [dbo].[DadosArqRetornoBanco] (
    [IdDadoArqRetornoBanco]      INT            IDENTITY (1, 1) NOT NULL,
    [IdArquivoRetorno]           INT            NOT NULL,
    [IdMsgErroRetornoBco]        INT            NULL,
    [NumeroLinha]                INT            NULL,
    [NossoNumero]                VARCHAR (17)   NULL,
    [DataPagamento]              DATETIME       NULL,
    [ValorPago]                  MONEY          NULL,
    [codigoSacado]               VARCHAR (20)   NULL,
    [NomeSacado]                 VARCHAR (40)   NULL,
    [RegistraLog]                BIT            CONSTRAINT [DF__ErrosArqR__Regis__09003183] DEFAULT ((1)) NULL,
    [DataCredito]                DATETIME       NULL,
    [Situacao]                   BIT            NULL,
    [SeuNumero]                  CHAR (11)      NULL,
    [CodMovRetorno]              CHAR (2)       NULL,
    [DataUltimaAtualizacao]      DATETIME       NULL,
    [DataProcessamento]          DATETIME       NULL,
    [Desconto]                   MONEY          NULL,
    [Encargos]                   MONEY          NULL,
    [SaldoContaPrincipal]        MONEY          NULL,
    [Rateio01]                   MONEY          NULL,
    [Rateio02]                   MONEY          NULL,
    [Rateio03]                   MONEY          NULL,
    [Rateio04]                   MONEY          NULL,
    [Rateio05]                   MONEY          NULL,
    [BaixaRegRecusado_Descricao] VARCHAR (8000) NULL,
    [BaixaRegRecusado_Usuario]   VARCHAR (30)   NULL,
    [BaixaRegRecusado_Resolvido] BIT            CONSTRAINT [DF_DadosArqRetornoBanco_BaixaRegRecusado_Resolvido] DEFAULT ((0)) NULL,
    [InstrucaoBRB]               VARCHAR (50)   NULL,
    [TotalRateio]                MONEY          NULL,
    [ValorMenosRepasse]          MONEY          NULL,
    [TaxaBanco]                  MONEY          NULL,
    [ValorCreditado]             MONEY          NULL,
    [CodOcrRetorno]              VARCHAR (10)   NULL,
    [VlrTarifa]                  MONEY          NULL,
    [ValorDevido]                MONEY          NULL,
    [VlrAcrescimos]              MONEY          NULL,
    [VlrDesconto]                MONEY          NULL,
    CONSTRAINT [PK_ErrosArqRetornoBanco] PRIMARY KEY CLUSTERED ([IdDadoArqRetornoBanco] ASC),
    CONSTRAINT [FK_ErrosArqRetornoBanco_ArquivosRetornoBanco] FOREIGN KEY ([IdArquivoRetorno]) REFERENCES [dbo].[ArquivosRetornoBanco] ([IdArquivoRetorno]),
    CONSTRAINT [FK_ErrosArqRetornoBanco_MsgErroRetornoBco] FOREIGN KEY ([IdMsgErroRetornoBco]) REFERENCES [dbo].[MsgErroRetornoBco] ([IdMsgErroRetornoBco])
);


GO
CREATE TRIGGER [TrgLog_DadosArqRetornoBanco] ON [Implanta_CRPAM].[dbo].[DadosArqRetornoBanco] 
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
SET @TableName = 'DadosArqRetornoBanco'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDadoArqRetornoBanco : «' + RTRIM( ISNULL( CAST (IdDadoArqRetornoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoRetorno : «' + RTRIM( ISNULL( CAST (IdArquivoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgErroRetornoBco : «' + RTRIM( ISNULL( CAST (IdMsgErroRetornoBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLinha : «' + RTRIM( ISNULL( CAST (NumeroLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| codigoSacado : «' + RTRIM( ISNULL( CAST (codigoSacado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSacado : «' + RTRIM( ISNULL( CAST (NomeSacado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Situacao IS NULL THEN ' Situacao : «Nulo» '
                                              WHEN  Situacao = 0 THEN ' Situacao : «Falso» '
                                              WHEN  Situacao = 1 THEN ' Situacao : «Verdadeiro» '
                                    END 
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMovRetorno : «' + RTRIM( ISNULL( CAST (CodMovRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| DataProcessamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProcessamento, 113 ),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Encargos : «' + RTRIM( ISNULL( CAST (Encargos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoContaPrincipal : «' + RTRIM( ISNULL( CAST (SaldoContaPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio01 : «' + RTRIM( ISNULL( CAST (Rateio01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio02 : «' + RTRIM( ISNULL( CAST (Rateio02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio03 : «' + RTRIM( ISNULL( CAST (Rateio03 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio04 : «' + RTRIM( ISNULL( CAST (Rateio04 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio05 : «' + RTRIM( ISNULL( CAST (Rateio05 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaixaRegRecusado_Descricao : «' + RTRIM( ISNULL( CAST (BaixaRegRecusado_Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaixaRegRecusado_Usuario : «' + RTRIM( ISNULL( CAST (BaixaRegRecusado_Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaixaRegRecusado_Resolvido IS NULL THEN ' BaixaRegRecusado_Resolvido : «Nulo» '
                                              WHEN  BaixaRegRecusado_Resolvido = 0 THEN ' BaixaRegRecusado_Resolvido : «Falso» '
                                              WHEN  BaixaRegRecusado_Resolvido = 1 THEN ' BaixaRegRecusado_Resolvido : «Verdadeiro» '
                                    END 
                         + '| InstrucaoBRB : «' + RTRIM( ISNULL( CAST (InstrucaoBRB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalRateio : «' + RTRIM( ISNULL( CAST (TotalRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMenosRepasse : «' + RTRIM( ISNULL( CAST (ValorMenosRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaBanco : «' + RTRIM( ISNULL( CAST (TaxaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCreditado : «' + RTRIM( ISNULL( CAST (ValorCreditado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOcrRetorno : «' + RTRIM( ISNULL( CAST (CodOcrRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrTarifa : «' + RTRIM( ISNULL( CAST (VlrTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrAcrescimos : «' + RTRIM( ISNULL( CAST (VlrAcrescimos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrDesconto : «' + RTRIM( ISNULL( CAST (VlrDesconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDadoArqRetornoBanco : «' + RTRIM( ISNULL( CAST (IdDadoArqRetornoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoRetorno : «' + RTRIM( ISNULL( CAST (IdArquivoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgErroRetornoBco : «' + RTRIM( ISNULL( CAST (IdMsgErroRetornoBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLinha : «' + RTRIM( ISNULL( CAST (NumeroLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| codigoSacado : «' + RTRIM( ISNULL( CAST (codigoSacado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSacado : «' + RTRIM( ISNULL( CAST (NomeSacado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Situacao IS NULL THEN ' Situacao : «Nulo» '
                                              WHEN  Situacao = 0 THEN ' Situacao : «Falso» '
                                              WHEN  Situacao = 1 THEN ' Situacao : «Verdadeiro» '
                                    END 
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMovRetorno : «' + RTRIM( ISNULL( CAST (CodMovRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| DataProcessamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProcessamento, 113 ),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Encargos : «' + RTRIM( ISNULL( CAST (Encargos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoContaPrincipal : «' + RTRIM( ISNULL( CAST (SaldoContaPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio01 : «' + RTRIM( ISNULL( CAST (Rateio01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio02 : «' + RTRIM( ISNULL( CAST (Rateio02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio03 : «' + RTRIM( ISNULL( CAST (Rateio03 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio04 : «' + RTRIM( ISNULL( CAST (Rateio04 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio05 : «' + RTRIM( ISNULL( CAST (Rateio05 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaixaRegRecusado_Descricao : «' + RTRIM( ISNULL( CAST (BaixaRegRecusado_Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaixaRegRecusado_Usuario : «' + RTRIM( ISNULL( CAST (BaixaRegRecusado_Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaixaRegRecusado_Resolvido IS NULL THEN ' BaixaRegRecusado_Resolvido : «Nulo» '
                                              WHEN  BaixaRegRecusado_Resolvido = 0 THEN ' BaixaRegRecusado_Resolvido : «Falso» '
                                              WHEN  BaixaRegRecusado_Resolvido = 1 THEN ' BaixaRegRecusado_Resolvido : «Verdadeiro» '
                                    END 
                         + '| InstrucaoBRB : «' + RTRIM( ISNULL( CAST (InstrucaoBRB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalRateio : «' + RTRIM( ISNULL( CAST (TotalRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMenosRepasse : «' + RTRIM( ISNULL( CAST (ValorMenosRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaBanco : «' + RTRIM( ISNULL( CAST (TaxaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCreditado : «' + RTRIM( ISNULL( CAST (ValorCreditado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOcrRetorno : «' + RTRIM( ISNULL( CAST (CodOcrRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrTarifa : «' + RTRIM( ISNULL( CAST (VlrTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrAcrescimos : «' + RTRIM( ISNULL( CAST (VlrAcrescimos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrDesconto : «' + RTRIM( ISNULL( CAST (VlrDesconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDadoArqRetornoBanco : «' + RTRIM( ISNULL( CAST (IdDadoArqRetornoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoRetorno : «' + RTRIM( ISNULL( CAST (IdArquivoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgErroRetornoBco : «' + RTRIM( ISNULL( CAST (IdMsgErroRetornoBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLinha : «' + RTRIM( ISNULL( CAST (NumeroLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| codigoSacado : «' + RTRIM( ISNULL( CAST (codigoSacado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSacado : «' + RTRIM( ISNULL( CAST (NomeSacado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Situacao IS NULL THEN ' Situacao : «Nulo» '
                                              WHEN  Situacao = 0 THEN ' Situacao : «Falso» '
                                              WHEN  Situacao = 1 THEN ' Situacao : «Verdadeiro» '
                                    END 
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMovRetorno : «' + RTRIM( ISNULL( CAST (CodMovRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| DataProcessamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProcessamento, 113 ),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Encargos : «' + RTRIM( ISNULL( CAST (Encargos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoContaPrincipal : «' + RTRIM( ISNULL( CAST (SaldoContaPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio01 : «' + RTRIM( ISNULL( CAST (Rateio01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio02 : «' + RTRIM( ISNULL( CAST (Rateio02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio03 : «' + RTRIM( ISNULL( CAST (Rateio03 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio04 : «' + RTRIM( ISNULL( CAST (Rateio04 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio05 : «' + RTRIM( ISNULL( CAST (Rateio05 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaixaRegRecusado_Descricao : «' + RTRIM( ISNULL( CAST (BaixaRegRecusado_Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaixaRegRecusado_Usuario : «' + RTRIM( ISNULL( CAST (BaixaRegRecusado_Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaixaRegRecusado_Resolvido IS NULL THEN ' BaixaRegRecusado_Resolvido : «Nulo» '
                                              WHEN  BaixaRegRecusado_Resolvido = 0 THEN ' BaixaRegRecusado_Resolvido : «Falso» '
                                              WHEN  BaixaRegRecusado_Resolvido = 1 THEN ' BaixaRegRecusado_Resolvido : «Verdadeiro» '
                                    END 
                         + '| InstrucaoBRB : «' + RTRIM( ISNULL( CAST (InstrucaoBRB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalRateio : «' + RTRIM( ISNULL( CAST (TotalRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMenosRepasse : «' + RTRIM( ISNULL( CAST (ValorMenosRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaBanco : «' + RTRIM( ISNULL( CAST (TaxaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCreditado : «' + RTRIM( ISNULL( CAST (ValorCreditado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOcrRetorno : «' + RTRIM( ISNULL( CAST (CodOcrRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrTarifa : «' + RTRIM( ISNULL( CAST (VlrTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrAcrescimos : «' + RTRIM( ISNULL( CAST (VlrAcrescimos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrDesconto : «' + RTRIM( ISNULL( CAST (VlrDesconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDadoArqRetornoBanco : «' + RTRIM( ISNULL( CAST (IdDadoArqRetornoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoRetorno : «' + RTRIM( ISNULL( CAST (IdArquivoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgErroRetornoBco : «' + RTRIM( ISNULL( CAST (IdMsgErroRetornoBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroLinha : «' + RTRIM( ISNULL( CAST (NumeroLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| codigoSacado : «' + RTRIM( ISNULL( CAST (codigoSacado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSacado : «' + RTRIM( ISNULL( CAST (NomeSacado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Situacao IS NULL THEN ' Situacao : «Nulo» '
                                              WHEN  Situacao = 0 THEN ' Situacao : «Falso» '
                                              WHEN  Situacao = 1 THEN ' Situacao : «Verdadeiro» '
                                    END 
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMovRetorno : «' + RTRIM( ISNULL( CAST (CodMovRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| DataProcessamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProcessamento, 113 ),'Nulo'))+'» '
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Encargos : «' + RTRIM( ISNULL( CAST (Encargos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoContaPrincipal : «' + RTRIM( ISNULL( CAST (SaldoContaPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio01 : «' + RTRIM( ISNULL( CAST (Rateio01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio02 : «' + RTRIM( ISNULL( CAST (Rateio02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio03 : «' + RTRIM( ISNULL( CAST (Rateio03 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio04 : «' + RTRIM( ISNULL( CAST (Rateio04 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Rateio05 : «' + RTRIM( ISNULL( CAST (Rateio05 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaixaRegRecusado_Descricao : «' + RTRIM( ISNULL( CAST (BaixaRegRecusado_Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BaixaRegRecusado_Usuario : «' + RTRIM( ISNULL( CAST (BaixaRegRecusado_Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  BaixaRegRecusado_Resolvido IS NULL THEN ' BaixaRegRecusado_Resolvido : «Nulo» '
                                              WHEN  BaixaRegRecusado_Resolvido = 0 THEN ' BaixaRegRecusado_Resolvido : «Falso» '
                                              WHEN  BaixaRegRecusado_Resolvido = 1 THEN ' BaixaRegRecusado_Resolvido : «Verdadeiro» '
                                    END 
                         + '| InstrucaoBRB : «' + RTRIM( ISNULL( CAST (InstrucaoBRB AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalRateio : «' + RTRIM( ISNULL( CAST (TotalRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMenosRepasse : «' + RTRIM( ISNULL( CAST (ValorMenosRepasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TaxaBanco : «' + RTRIM( ISNULL( CAST (TaxaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCreditado : «' + RTRIM( ISNULL( CAST (ValorCreditado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOcrRetorno : «' + RTRIM( ISNULL( CAST (CodOcrRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrTarifa : «' + RTRIM( ISNULL( CAST (VlrTarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrAcrescimos : «' + RTRIM( ISNULL( CAST (VlrAcrescimos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VlrDesconto : «' + RTRIM( ISNULL( CAST (VlrDesconto AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 

GO
CREATE TRIGGER Trg_DadosArqRetornoBanco_DataAlteracao ON 
				  DadosArqRetornoBanco FOR INSERT,UPDATE AS
   DECLARE @IdDadoArqRetornoBanco INTEGER
   DECLARE @Count INTEGER
   SELECT @Count = COUNT(*) FROM DELETED,INSERTED
   IF @Count > 0
   BEGIN 
     SELECT  @IdDadoArqRetornoBanco = IdDadoArqRetornoBanco FROM INSERTED
     IF (@IdDadoArqRetornoBanco > 0)  
	 UPDATE DadosArqRetornoBanco 
	 SET DataUltimaAtualizacao = GetDate()
	 WHERE IdDadoArqRetornoBanco = @IdDadoArqRetornoBanco
	END 





