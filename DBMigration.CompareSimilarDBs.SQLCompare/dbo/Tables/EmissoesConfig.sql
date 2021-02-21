CREATE TABLE [dbo].[EmissoesConfig] (
    [IdEmissaoConfig]           INT              IDENTITY (1, 1) NOT NULL,
    [Titulo]                    VARCHAR (200)    NULL,
    [DATA]                      DATETIME         CONSTRAINT [DF_EmissoesConfig_Data] DEFAULT (getdate()) NOT NULL,
    [Status]                    TINYINT          CONSTRAINT [DF_EmissoesConfig_Status] DEFAULT ((0)) NULL,
    [Usuario]                   VARCHAR (35)     NULL,
    [TipoPessoa]                TINYINT          NULL,
    [Coletiva]                  BIT              CONSTRAINT [DF_EmissoesConfig_Coletiva] DEFAULT ((0)) NOT NULL,
    [GerarNossoNumero]          BIT              NOT NULL,
    [EmissaoComDesconto]        INT              CONSTRAINT [DF_EmissoesConfigEmissaoComDesconto] DEFAULT ((0)) NULL,
    [EmissaoWeb]                BIT              CONSTRAINT [DF_EmissoesConfig_EmissaoWeb] DEFAULT ((0)) NOT NULL,
    [IdBanco]                   INT              NOT NULL,
    [IdContaCorrente]           INT              NULL,
    [IdConvenio]                INT              NULL,
    [EmissaoComRegistro]        BIT              NULL,
    [TipoEmissao]               INT              NOT NULL,
    [TipoComposicao]            INT              NOT NULL,
    [TipoDivisaoDesp]           INT              NOT NULL,
    [ValorDespBanco]            MONEY            NULL,
    [ValorDespPostal]           MONEY            NULL,
    [ValorDespAdv]              MONEY            NULL,
    [IdentificarDebitoNoBoleto] BIT              NULL,
    [ExibirComposicaoDebito]    BIT              NULL,
    [DataVencimentoBoleto]      DATETIME         NULL,
    [DataAtualizacao]           DATETIME         NULL,
    [NaoReceberAposVencimento]  BIT              NULL,
    [IdProcedimentoAtraso]      INT              NULL,
    [CodProtesto]               TINYINT          NULL,
    [QtdDiasProtesto]           SMALLINT         NULL,
    [CodBaixa]                  TINYINT          NULL,
    [QtdDiasBaixa]              SMALLINT         NULL,
    [Mensagem]                  VARCHAR (4000)   NULL,
    [Instrucao]                 VARCHAR (1000)   NULL,
    [Chave]                     UNIQUEIDENTIFIER CONSTRAINT [DF_EmissoesConfigChave] DEFAULT (newid()) NULL,
    [InserirRTF_File]           BIT              NULL,
    [IdRelatorio]               INT              NULL,
    [ErroMsg]                   VARCHAR (2048)   NULL,
    [AtualizacaoWeb]            VARCHAR (5000)   NULL,
    [IndicarDebitosEmAberto]    BIT              CONSTRAINT [DF_EmissoesConfig_IndicarDebitosEmAberto] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_EmissoesConfig] PRIMARY KEY CLUSTERED ([IdEmissaoConfig] ASC),
    CONSTRAINT [CHK_EmissoesConfigTipoComposicao] CHECK ([TipoComposicao]=(1) OR [TipoComposicao]=(0)),
    CONSTRAINT [CHK_EmissoesConfigTipoDivisaoDesp] CHECK ([TipoDivisaoDesp]=(3) OR [TipoDivisaoDesp]=(2) OR [TipoDivisaoDesp]=(1)),
    CONSTRAINT [CHK_EmissoesConfigTipoPessoa] CHECK ([TipoPessoa]=(2) OR [TipoPessoa]=(1) OR [TipoPessoa]=(0)),
    CONSTRAINT [FK_EmissoesConfig_Relatorios] FOREIGN KEY ([IdRelatorio]) REFERENCES [dbo].[Relatorios] ([IdRelatorio])
);


GO
CREATE TRIGGER [TrgLog_EmissoesConfig] ON [Implanta_CRPAM].[dbo].[EmissoesConfig] 
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
SET @TableName = 'EmissoesConfig'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Titulo : «' + RTRIM( ISNULL( CAST (Titulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Status : «' + RTRIM( ISNULL( CAST (Status AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Coletiva IS NULL THEN ' Coletiva : «Nulo» '
                                              WHEN  Coletiva = 0 THEN ' Coletiva : «Falso» '
                                              WHEN  Coletiva = 1 THEN ' Coletiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GerarNossoNumero IS NULL THEN ' GerarNossoNumero : «Nulo» '
                                              WHEN  GerarNossoNumero = 0 THEN ' GerarNossoNumero : «Falso» '
                                              WHEN  GerarNossoNumero = 1 THEN ' GerarNossoNumero : «Verdadeiro» '
                                    END 
                         + '| EmissaoComDesconto : «' + RTRIM( ISNULL( CAST (EmissaoComDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmissaoWeb IS NULL THEN ' EmissaoWeb : «Nulo» '
                                              WHEN  EmissaoWeb = 0 THEN ' EmissaoWeb : «Falso» '
                                              WHEN  EmissaoWeb = 1 THEN ' EmissaoWeb : «Verdadeiro» '
                                    END 
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmissaoComRegistro IS NULL THEN ' EmissaoComRegistro : «Nulo» '
                                              WHEN  EmissaoComRegistro = 0 THEN ' EmissaoComRegistro : «Falso» '
                                              WHEN  EmissaoComRegistro = 1 THEN ' EmissaoComRegistro : «Verdadeiro» '
                                    END 
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoComposicao : «' + RTRIM( ISNULL( CAST (TipoComposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDivisaoDesp : «' + RTRIM( ISNULL( CAST (TipoDivisaoDesp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBanco : «' + RTRIM( ISNULL( CAST (ValorDespBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostal : «' + RTRIM( ISNULL( CAST (ValorDespPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IdentificarDebitoNoBoleto IS NULL THEN ' IdentificarDebitoNoBoleto : «Nulo» '
                                              WHEN  IdentificarDebitoNoBoleto = 0 THEN ' IdentificarDebitoNoBoleto : «Falso» '
                                              WHEN  IdentificarDebitoNoBoleto = 1 THEN ' IdentificarDebitoNoBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirComposicaoDebito IS NULL THEN ' ExibirComposicaoDebito : «Nulo» '
                                              WHEN  ExibirComposicaoDebito = 0 THEN ' ExibirComposicaoDebito : «Falso» '
                                              WHEN  ExibirComposicaoDebito = 1 THEN ' ExibirComposicaoDebito : «Verdadeiro» '
                                    END 
                         + '| DataVencimentoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoBoleto, 113 ),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoReceberAposVencimento IS NULL THEN ' NaoReceberAposVencimento : «Nulo» '
                                              WHEN  NaoReceberAposVencimento = 0 THEN ' NaoReceberAposVencimento : «Falso» '
                                              WHEN  NaoReceberAposVencimento = 1 THEN ' NaoReceberAposVencimento : «Verdadeiro» '
                                    END 
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasProtesto : «' + RTRIM( ISNULL( CAST (QtdDiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBaixa : «' + RTRIM( ISNULL( CAST (CodBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasBaixa : «' + RTRIM( ISNULL( CAST (QtdDiasBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Mensagem : «' + RTRIM( ISNULL( CAST (Mensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Instrucao : «' + RTRIM( ISNULL( CAST (Instrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InserirRTF_File IS NULL THEN ' InserirRTF_File : «Nulo» '
                                              WHEN  InserirRTF_File = 0 THEN ' InserirRTF_File : «Falso» '
                                              WHEN  InserirRTF_File = 1 THEN ' InserirRTF_File : «Verdadeiro» '
                                    END 
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErroMsg : «' + RTRIM( ISNULL( CAST (ErroMsg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndicarDebitosEmAberto IS NULL THEN ' IndicarDebitosEmAberto : «Nulo» '
                                              WHEN  IndicarDebitosEmAberto = 0 THEN ' IndicarDebitosEmAberto : «Falso» '
                                              WHEN  IndicarDebitosEmAberto = 1 THEN ' IndicarDebitosEmAberto : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Titulo : «' + RTRIM( ISNULL( CAST (Titulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Status : «' + RTRIM( ISNULL( CAST (Status AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Coletiva IS NULL THEN ' Coletiva : «Nulo» '
                                              WHEN  Coletiva = 0 THEN ' Coletiva : «Falso» '
                                              WHEN  Coletiva = 1 THEN ' Coletiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GerarNossoNumero IS NULL THEN ' GerarNossoNumero : «Nulo» '
                                              WHEN  GerarNossoNumero = 0 THEN ' GerarNossoNumero : «Falso» '
                                              WHEN  GerarNossoNumero = 1 THEN ' GerarNossoNumero : «Verdadeiro» '
                                    END 
                         + '| EmissaoComDesconto : «' + RTRIM( ISNULL( CAST (EmissaoComDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmissaoWeb IS NULL THEN ' EmissaoWeb : «Nulo» '
                                              WHEN  EmissaoWeb = 0 THEN ' EmissaoWeb : «Falso» '
                                              WHEN  EmissaoWeb = 1 THEN ' EmissaoWeb : «Verdadeiro» '
                                    END 
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmissaoComRegistro IS NULL THEN ' EmissaoComRegistro : «Nulo» '
                                              WHEN  EmissaoComRegistro = 0 THEN ' EmissaoComRegistro : «Falso» '
                                              WHEN  EmissaoComRegistro = 1 THEN ' EmissaoComRegistro : «Verdadeiro» '
                                    END 
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoComposicao : «' + RTRIM( ISNULL( CAST (TipoComposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDivisaoDesp : «' + RTRIM( ISNULL( CAST (TipoDivisaoDesp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBanco : «' + RTRIM( ISNULL( CAST (ValorDespBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostal : «' + RTRIM( ISNULL( CAST (ValorDespPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IdentificarDebitoNoBoleto IS NULL THEN ' IdentificarDebitoNoBoleto : «Nulo» '
                                              WHEN  IdentificarDebitoNoBoleto = 0 THEN ' IdentificarDebitoNoBoleto : «Falso» '
                                              WHEN  IdentificarDebitoNoBoleto = 1 THEN ' IdentificarDebitoNoBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirComposicaoDebito IS NULL THEN ' ExibirComposicaoDebito : «Nulo» '
                                              WHEN  ExibirComposicaoDebito = 0 THEN ' ExibirComposicaoDebito : «Falso» '
                                              WHEN  ExibirComposicaoDebito = 1 THEN ' ExibirComposicaoDebito : «Verdadeiro» '
                                    END 
                         + '| DataVencimentoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoBoleto, 113 ),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoReceberAposVencimento IS NULL THEN ' NaoReceberAposVencimento : «Nulo» '
                                              WHEN  NaoReceberAposVencimento = 0 THEN ' NaoReceberAposVencimento : «Falso» '
                                              WHEN  NaoReceberAposVencimento = 1 THEN ' NaoReceberAposVencimento : «Verdadeiro» '
                                    END 
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasProtesto : «' + RTRIM( ISNULL( CAST (QtdDiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBaixa : «' + RTRIM( ISNULL( CAST (CodBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasBaixa : «' + RTRIM( ISNULL( CAST (QtdDiasBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Mensagem : «' + RTRIM( ISNULL( CAST (Mensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Instrucao : «' + RTRIM( ISNULL( CAST (Instrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InserirRTF_File IS NULL THEN ' InserirRTF_File : «Nulo» '
                                              WHEN  InserirRTF_File = 0 THEN ' InserirRTF_File : «Falso» '
                                              WHEN  InserirRTF_File = 1 THEN ' InserirRTF_File : «Verdadeiro» '
                                    END 
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErroMsg : «' + RTRIM( ISNULL( CAST (ErroMsg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndicarDebitosEmAberto IS NULL THEN ' IndicarDebitosEmAberto : «Nulo» '
                                              WHEN  IndicarDebitosEmAberto = 0 THEN ' IndicarDebitosEmAberto : «Falso» '
                                              WHEN  IndicarDebitosEmAberto = 1 THEN ' IndicarDebitosEmAberto : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Titulo : «' + RTRIM( ISNULL( CAST (Titulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Status : «' + RTRIM( ISNULL( CAST (Status AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Coletiva IS NULL THEN ' Coletiva : «Nulo» '
                                              WHEN  Coletiva = 0 THEN ' Coletiva : «Falso» '
                                              WHEN  Coletiva = 1 THEN ' Coletiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GerarNossoNumero IS NULL THEN ' GerarNossoNumero : «Nulo» '
                                              WHEN  GerarNossoNumero = 0 THEN ' GerarNossoNumero : «Falso» '
                                              WHEN  GerarNossoNumero = 1 THEN ' GerarNossoNumero : «Verdadeiro» '
                                    END 
                         + '| EmissaoComDesconto : «' + RTRIM( ISNULL( CAST (EmissaoComDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmissaoWeb IS NULL THEN ' EmissaoWeb : «Nulo» '
                                              WHEN  EmissaoWeb = 0 THEN ' EmissaoWeb : «Falso» '
                                              WHEN  EmissaoWeb = 1 THEN ' EmissaoWeb : «Verdadeiro» '
                                    END 
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmissaoComRegistro IS NULL THEN ' EmissaoComRegistro : «Nulo» '
                                              WHEN  EmissaoComRegistro = 0 THEN ' EmissaoComRegistro : «Falso» '
                                              WHEN  EmissaoComRegistro = 1 THEN ' EmissaoComRegistro : «Verdadeiro» '
                                    END 
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoComposicao : «' + RTRIM( ISNULL( CAST (TipoComposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDivisaoDesp : «' + RTRIM( ISNULL( CAST (TipoDivisaoDesp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBanco : «' + RTRIM( ISNULL( CAST (ValorDespBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostal : «' + RTRIM( ISNULL( CAST (ValorDespPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IdentificarDebitoNoBoleto IS NULL THEN ' IdentificarDebitoNoBoleto : «Nulo» '
                                              WHEN  IdentificarDebitoNoBoleto = 0 THEN ' IdentificarDebitoNoBoleto : «Falso» '
                                              WHEN  IdentificarDebitoNoBoleto = 1 THEN ' IdentificarDebitoNoBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirComposicaoDebito IS NULL THEN ' ExibirComposicaoDebito : «Nulo» '
                                              WHEN  ExibirComposicaoDebito = 0 THEN ' ExibirComposicaoDebito : «Falso» '
                                              WHEN  ExibirComposicaoDebito = 1 THEN ' ExibirComposicaoDebito : «Verdadeiro» '
                                    END 
                         + '| DataVencimentoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoBoleto, 113 ),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoReceberAposVencimento IS NULL THEN ' NaoReceberAposVencimento : «Nulo» '
                                              WHEN  NaoReceberAposVencimento = 0 THEN ' NaoReceberAposVencimento : «Falso» '
                                              WHEN  NaoReceberAposVencimento = 1 THEN ' NaoReceberAposVencimento : «Verdadeiro» '
                                    END 
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasProtesto : «' + RTRIM( ISNULL( CAST (QtdDiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBaixa : «' + RTRIM( ISNULL( CAST (CodBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasBaixa : «' + RTRIM( ISNULL( CAST (QtdDiasBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Mensagem : «' + RTRIM( ISNULL( CAST (Mensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Instrucao : «' + RTRIM( ISNULL( CAST (Instrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InserirRTF_File IS NULL THEN ' InserirRTF_File : «Nulo» '
                                              WHEN  InserirRTF_File = 0 THEN ' InserirRTF_File : «Falso» '
                                              WHEN  InserirRTF_File = 1 THEN ' InserirRTF_File : «Verdadeiro» '
                                    END 
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErroMsg : «' + RTRIM( ISNULL( CAST (ErroMsg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndicarDebitosEmAberto IS NULL THEN ' IndicarDebitosEmAberto : «Nulo» '
                                              WHEN  IndicarDebitosEmAberto = 0 THEN ' IndicarDebitosEmAberto : «Falso» '
                                              WHEN  IndicarDebitosEmAberto = 1 THEN ' IndicarDebitosEmAberto : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Titulo : «' + RTRIM( ISNULL( CAST (Titulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Status : «' + RTRIM( ISNULL( CAST (Status AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Coletiva IS NULL THEN ' Coletiva : «Nulo» '
                                              WHEN  Coletiva = 0 THEN ' Coletiva : «Falso» '
                                              WHEN  Coletiva = 1 THEN ' Coletiva : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GerarNossoNumero IS NULL THEN ' GerarNossoNumero : «Nulo» '
                                              WHEN  GerarNossoNumero = 0 THEN ' GerarNossoNumero : «Falso» '
                                              WHEN  GerarNossoNumero = 1 THEN ' GerarNossoNumero : «Verdadeiro» '
                                    END 
                         + '| EmissaoComDesconto : «' + RTRIM( ISNULL( CAST (EmissaoComDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmissaoWeb IS NULL THEN ' EmissaoWeb : «Nulo» '
                                              WHEN  EmissaoWeb = 0 THEN ' EmissaoWeb : «Falso» '
                                              WHEN  EmissaoWeb = 1 THEN ' EmissaoWeb : «Verdadeiro» '
                                    END 
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmissaoComRegistro IS NULL THEN ' EmissaoComRegistro : «Nulo» '
                                              WHEN  EmissaoComRegistro = 0 THEN ' EmissaoComRegistro : «Falso» '
                                              WHEN  EmissaoComRegistro = 1 THEN ' EmissaoComRegistro : «Verdadeiro» '
                                    END 
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoComposicao : «' + RTRIM( ISNULL( CAST (TipoComposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDivisaoDesp : «' + RTRIM( ISNULL( CAST (TipoDivisaoDesp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBanco : «' + RTRIM( ISNULL( CAST (ValorDespBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostal : «' + RTRIM( ISNULL( CAST (ValorDespPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IdentificarDebitoNoBoleto IS NULL THEN ' IdentificarDebitoNoBoleto : «Nulo» '
                                              WHEN  IdentificarDebitoNoBoleto = 0 THEN ' IdentificarDebitoNoBoleto : «Falso» '
                                              WHEN  IdentificarDebitoNoBoleto = 1 THEN ' IdentificarDebitoNoBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirComposicaoDebito IS NULL THEN ' ExibirComposicaoDebito : «Nulo» '
                                              WHEN  ExibirComposicaoDebito = 0 THEN ' ExibirComposicaoDebito : «Falso» '
                                              WHEN  ExibirComposicaoDebito = 1 THEN ' ExibirComposicaoDebito : «Verdadeiro» '
                                    END 
                         + '| DataVencimentoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoBoleto, 113 ),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NaoReceberAposVencimento IS NULL THEN ' NaoReceberAposVencimento : «Nulo» '
                                              WHEN  NaoReceberAposVencimento = 0 THEN ' NaoReceberAposVencimento : «Falso» '
                                              WHEN  NaoReceberAposVencimento = 1 THEN ' NaoReceberAposVencimento : «Verdadeiro» '
                                    END 
                         + '| IdProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasProtesto : «' + RTRIM( ISNULL( CAST (QtdDiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBaixa : «' + RTRIM( ISNULL( CAST (CodBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiasBaixa : «' + RTRIM( ISNULL( CAST (QtdDiasBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Mensagem : «' + RTRIM( ISNULL( CAST (Mensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Instrucao : «' + RTRIM( ISNULL( CAST (Instrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InserirRTF_File IS NULL THEN ' InserirRTF_File : «Nulo» '
                                              WHEN  InserirRTF_File = 0 THEN ' InserirRTF_File : «Falso» '
                                              WHEN  InserirRTF_File = 1 THEN ' InserirRTF_File : «Verdadeiro» '
                                    END 
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErroMsg : «' + RTRIM( ISNULL( CAST (ErroMsg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndicarDebitosEmAberto IS NULL THEN ' IndicarDebitosEmAberto : «Nulo» '
                                              WHEN  IndicarDebitosEmAberto = 0 THEN ' IndicarDebitosEmAberto : «Falso» '
                                              WHEN  IndicarDebitosEmAberto = 1 THEN ' IndicarDebitosEmAberto : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
