CREATE TABLE [dbo].[MsgBoletosBancarios] (
    [IdMsgBoletoBancario]         INT            IDENTITY (1, 1) NOT NULL,
    [TipoMensagem]                VARCHAR (1)    NULL,
    [Mensagem]                    TEXT           NULL,
    [FinalidadeInstrucao]         VARCHAR (1)    NULL,
    [IdBancoSiscafW]              INT            NULL,
    [E_MensagemWEB]               BIT            NULL,
    [E_InstrucaoWEB]              BIT            NULL,
    [MensagemHTML]                VARCHAR (3000) NULL,
    [E_Terceirizado]              BIT            CONSTRAINT [DEF_ETerceirizado] DEFAULT ((0)) NOT NULL,
    [Ativo]                       BIT            DEFAULT ((1)) NULL,
    [CodJuros]                    VARCHAR (40)   NULL,
    [ValorJuros]                  MONEY          NULL,
    [CodMulta]                    VARCHAR (40)   NULL,
    [ValorMulta]                  MONEY          NULL,
    [CodProtesto]                 VARCHAR (40)   NULL,
    [DiasProtesto]                INT            NULL,
    [IdConfigGeracaoDebito]       INT            NULL,
    [PermiteDuplicidadeDescontos] BIT            CONSTRAINT [DF_MsgBoletosBancarios_PermiteDuplicidadeDescontos] DEFAULT ((0)) NOT NULL,
    [NomeMensagem]                VARCHAR (100)  NULL,
    CONSTRAINT [PK_MsgBoletosBancarios] PRIMARY KEY CLUSTERED ([IdMsgBoletoBancario] ASC),
    CONSTRAINT [FK_MsgBoletosBancarios_BancosSiscafw] FOREIGN KEY ([IdBancoSiscafW]) REFERENCES [dbo].[BancosSiscafw] ([IdBancoSiscafw]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_MsgBoletosBancarios] ON [Implanta_CRPAM].[dbo].[MsgBoletosBancarios] 
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
SET @TableName = 'MsgBoletosBancarios'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMsgBoletoBancario : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMensagem : «' + RTRIM( ISNULL( CAST (TipoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FinalidadeInstrucao : «' + RTRIM( ISNULL( CAST (FinalidadeInstrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafW : «' + RTRIM( ISNULL( CAST (IdBancoSiscafW AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_MensagemWEB IS NULL THEN ' E_MensagemWEB : «Nulo» '
                                              WHEN  E_MensagemWEB = 0 THEN ' E_MensagemWEB : «Falso» '
                                              WHEN  E_MensagemWEB = 1 THEN ' E_MensagemWEB : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_InstrucaoWEB IS NULL THEN ' E_InstrucaoWEB : «Nulo» '
                                              WHEN  E_InstrucaoWEB = 0 THEN ' E_InstrucaoWEB : «Falso» '
                                              WHEN  E_InstrucaoWEB = 1 THEN ' E_InstrucaoWEB : «Verdadeiro» '
                                    END 
                         + '| MensagemHTML : «' + RTRIM( ISNULL( CAST (MensagemHTML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Terceirizado IS NULL THEN ' E_Terceirizado : «Nulo» '
                                              WHEN  E_Terceirizado = 0 THEN ' E_Terceirizado : «Falso» '
                                              WHEN  E_Terceirizado = 1 THEN ' E_Terceirizado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiasProtesto : «' + RTRIM( ISNULL( CAST (DiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermiteDuplicidadeDescontos IS NULL THEN ' PermiteDuplicidadeDescontos : «Nulo» '
                                              WHEN  PermiteDuplicidadeDescontos = 0 THEN ' PermiteDuplicidadeDescontos : «Falso» '
                                              WHEN  PermiteDuplicidadeDescontos = 1 THEN ' PermiteDuplicidadeDescontos : «Verdadeiro» '
                                    END 
                         + '| NomeMensagem : «' + RTRIM( ISNULL( CAST (NomeMensagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMsgBoletoBancario : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMensagem : «' + RTRIM( ISNULL( CAST (TipoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FinalidadeInstrucao : «' + RTRIM( ISNULL( CAST (FinalidadeInstrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafW : «' + RTRIM( ISNULL( CAST (IdBancoSiscafW AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_MensagemWEB IS NULL THEN ' E_MensagemWEB : «Nulo» '
                                              WHEN  E_MensagemWEB = 0 THEN ' E_MensagemWEB : «Falso» '
                                              WHEN  E_MensagemWEB = 1 THEN ' E_MensagemWEB : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_InstrucaoWEB IS NULL THEN ' E_InstrucaoWEB : «Nulo» '
                                              WHEN  E_InstrucaoWEB = 0 THEN ' E_InstrucaoWEB : «Falso» '
                                              WHEN  E_InstrucaoWEB = 1 THEN ' E_InstrucaoWEB : «Verdadeiro» '
                                    END 
                         + '| MensagemHTML : «' + RTRIM( ISNULL( CAST (MensagemHTML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Terceirizado IS NULL THEN ' E_Terceirizado : «Nulo» '
                                              WHEN  E_Terceirizado = 0 THEN ' E_Terceirizado : «Falso» '
                                              WHEN  E_Terceirizado = 1 THEN ' E_Terceirizado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiasProtesto : «' + RTRIM( ISNULL( CAST (DiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermiteDuplicidadeDescontos IS NULL THEN ' PermiteDuplicidadeDescontos : «Nulo» '
                                              WHEN  PermiteDuplicidadeDescontos = 0 THEN ' PermiteDuplicidadeDescontos : «Falso» '
                                              WHEN  PermiteDuplicidadeDescontos = 1 THEN ' PermiteDuplicidadeDescontos : «Verdadeiro» '
                                    END 
                         + '| NomeMensagem : «' + RTRIM( ISNULL( CAST (NomeMensagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMsgBoletoBancario : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMensagem : «' + RTRIM( ISNULL( CAST (TipoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FinalidadeInstrucao : «' + RTRIM( ISNULL( CAST (FinalidadeInstrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafW : «' + RTRIM( ISNULL( CAST (IdBancoSiscafW AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_MensagemWEB IS NULL THEN ' E_MensagemWEB : «Nulo» '
                                              WHEN  E_MensagemWEB = 0 THEN ' E_MensagemWEB : «Falso» '
                                              WHEN  E_MensagemWEB = 1 THEN ' E_MensagemWEB : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_InstrucaoWEB IS NULL THEN ' E_InstrucaoWEB : «Nulo» '
                                              WHEN  E_InstrucaoWEB = 0 THEN ' E_InstrucaoWEB : «Falso» '
                                              WHEN  E_InstrucaoWEB = 1 THEN ' E_InstrucaoWEB : «Verdadeiro» '
                                    END 
                         + '| MensagemHTML : «' + RTRIM( ISNULL( CAST (MensagemHTML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Terceirizado IS NULL THEN ' E_Terceirizado : «Nulo» '
                                              WHEN  E_Terceirizado = 0 THEN ' E_Terceirizado : «Falso» '
                                              WHEN  E_Terceirizado = 1 THEN ' E_Terceirizado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiasProtesto : «' + RTRIM( ISNULL( CAST (DiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermiteDuplicidadeDescontos IS NULL THEN ' PermiteDuplicidadeDescontos : «Nulo» '
                                              WHEN  PermiteDuplicidadeDescontos = 0 THEN ' PermiteDuplicidadeDescontos : «Falso» '
                                              WHEN  PermiteDuplicidadeDescontos = 1 THEN ' PermiteDuplicidadeDescontos : «Verdadeiro» '
                                    END 
                         + '| NomeMensagem : «' + RTRIM( ISNULL( CAST (NomeMensagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMsgBoletoBancario : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMensagem : «' + RTRIM( ISNULL( CAST (TipoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FinalidadeInstrucao : «' + RTRIM( ISNULL( CAST (FinalidadeInstrucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoSiscafW : «' + RTRIM( ISNULL( CAST (IdBancoSiscafW AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_MensagemWEB IS NULL THEN ' E_MensagemWEB : «Nulo» '
                                              WHEN  E_MensagemWEB = 0 THEN ' E_MensagemWEB : «Falso» '
                                              WHEN  E_MensagemWEB = 1 THEN ' E_MensagemWEB : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_InstrucaoWEB IS NULL THEN ' E_InstrucaoWEB : «Nulo» '
                                              WHEN  E_InstrucaoWEB = 0 THEN ' E_InstrucaoWEB : «Falso» '
                                              WHEN  E_InstrucaoWEB = 1 THEN ' E_InstrucaoWEB : «Verdadeiro» '
                                    END 
                         + '| MensagemHTML : «' + RTRIM( ISNULL( CAST (MensagemHTML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Terceirizado IS NULL THEN ' E_Terceirizado : «Nulo» '
                                              WHEN  E_Terceirizado = 0 THEN ' E_Terceirizado : «Falso» '
                                              WHEN  E_Terceirizado = 1 THEN ' E_Terceirizado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodProtesto : «' + RTRIM( ISNULL( CAST (CodProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiasProtesto : «' + RTRIM( ISNULL( CAST (DiasProtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PermiteDuplicidadeDescontos IS NULL THEN ' PermiteDuplicidadeDescontos : «Nulo» '
                                              WHEN  PermiteDuplicidadeDescontos = 0 THEN ' PermiteDuplicidadeDescontos : «Falso» '
                                              WHEN  PermiteDuplicidadeDescontos = 1 THEN ' PermiteDuplicidadeDescontos : «Verdadeiro» '
                                    END 
                         + '| NomeMensagem : «' + RTRIM( ISNULL( CAST (NomeMensagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
