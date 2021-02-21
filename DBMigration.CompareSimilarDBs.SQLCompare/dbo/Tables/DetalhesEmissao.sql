CREATE TABLE [dbo].[DetalhesEmissao] (
    [IdDetalheEmissao]        INT            IDENTITY (1, 1) NOT NULL,
    [IdEmissao]               INT            NULL,
    [IdMoedaDevida]           INT            NULL,
    [NossoNumero]             VARCHAR (20)   NULL,
    [DataEmissao]             DATETIME       NOT NULL,
    [DataVencimento]          DATETIME       NULL,
    [DataAtualizacaoEncargos] DATETIME       NULL,
    [ValorEmissao]            MONEY          NULL,
    [ValorDespBco]            MONEY          NULL,
    [ValorDespAdv]            MONEY          NULL,
    [ValorDespPostais]        MONEY          NULL,
    [TipoEmissao]             INT            NULL,
    [TipoComposicao]          INT            NULL,
    [CodBanco]                VARCHAR (3)    NULL,
    [CodAgencia]              VARCHAR (4)    NULL,
    [CodOperacao]             VARCHAR (3)    NULL,
    [CodCC_Conv_Ced]          VARCHAR (16)   NULL,
    [RegistraLog]             BIT            CONSTRAINT [DF__DetalhesE__Regis__0623C4D8] DEFAULT ((1)) NULL,
    [bValorComDesconto]       BIT            NULL,
    [SeuNumero]               CHAR (11)      NULL,
    [AtualizacaoWeb]          VARCHAR (8000) NULL,
    [DescontoAplicado]        BIT            CONSTRAINT [DF_DetalhesEmissao_DescontoAplicado] DEFAULT ((0)) NOT NULL,
    [SituacaoRegistro]        INT            CONSTRAINT [DF_DetalhesEmissao_SituacaoRegistro] DEFAULT ((1)) NOT NULL,
    [IdConfigRegistro]        INT            NULL,
    [IdMsgBoletoBancarioI]    INT            NULL,
    [IdMsgBoletoBancarioM]    INT            NULL,
    [InstrIdentifSim]         BIT            CONSTRAINT [DF_DetalhesEmissao_InstrIdentifSim] DEFAULT ((0)) NOT NULL,
    [IdEmissaoConfig]         INT            NULL,
    [RTF_File]                IMAGE          NULL,
    [CodMotivoOcorrencia]     VARCHAR (2)    NULL,
    [UsuarioEmissao]          VARCHAR (35)   NULL,
    [DepartamentoEmissao]     VARCHAR (60)   NULL,
    [UsoImplanta]             BIT            NULL,
    CONSTRAINT [PK_DetalhesEmissao] PRIMARY KEY CLUSTERED ([IdDetalheEmissao] ASC),
    CONSTRAINT [chkNossoNumero] CHECK ([dbo].[ufnCheckNossoNumero]([IdEmissao],[NossoNumero])=(0)),
    CONSTRAINT [CK_DetalhesEmissao_SituacaoRegistro] CHECK ([SituacaoRegistro]=(9) OR [SituacaoRegistro]=(8) OR [SituacaoRegistro]=(6) OR [SituacaoRegistro]=(5) OR [SituacaoRegistro]=(4) OR [SituacaoRegistro]=(3) OR [SituacaoRegistro]=(2) OR [SituacaoRegistro]=(1) OR [SituacaoRegistro]=(0)),
    CONSTRAINT [FK_DetalhesEmissao_EmissoesConfig] FOREIGN KEY ([IdEmissaoConfig]) REFERENCES [dbo].[EmissoesConfig] ([IdEmissaoConfig]),
    CONSTRAINT [FK_DetalhesEmissao_Moedas] FOREIGN KEY ([IdMoedaDevida]) REFERENCES [dbo].[Moedas] ([IdMoeda]),
    CONSTRAINT [FK_DetalhesEmissao_MsgBoletosBancariosIdMsgBoletoBancarioI] FOREIGN KEY ([IdMsgBoletoBancarioI]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]),
    CONSTRAINT [FK_DetalhesEmissao_MsgBoletosBancariosIdMsgBoletoBancarioM] FOREIGN KEY ([IdMsgBoletoBancarioM]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]),
    CONSTRAINT [FK_DetEmis_Emissao] FOREIGN KEY ([IdEmissao]) REFERENCES [dbo].[Emissoes] ([IdEmissao])
);


GO
CREATE NONCLUSTERED INDEX [IX_DetalhesEmissaoNossoNumero]
    ON [dbo].[DetalhesEmissao]([NossoNumero] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DetalhesEmissao_SituacaoRegistro]
    ON [dbo].[DetalhesEmissao]([SituacaoRegistro] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DetalhesEmissao_DataEmissao]
    ON [dbo].[DetalhesEmissao]([DataEmissao] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DetalhesEmissao_IdConfigRegistro]
    ON [dbo].[DetalhesEmissao]([IdConfigRegistro] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DetalhesEmissao_IdMsgBoletoBancarioI]
    ON [dbo].[DetalhesEmissao]([IdMsgBoletoBancarioI] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DetalhesEmissao_IdMsgBoletoBancarioM]
    ON [dbo].[DetalhesEmissao]([IdMsgBoletoBancarioM] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DetalhesEmissao_IdEmissaoConfig]
    ON [dbo].[DetalhesEmissao]([IdEmissaoConfig] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DetalhesEmissaoSeuNumero]
    ON [dbo].[DetalhesEmissao]([SeuNumero] ASC);


GO
CREATE TRIGGER [TrgLog_DetalhesEmissao] ON [Implanta_CRPAM].[dbo].[DetalhesEmissao] 
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
SET @TableName = 'DetalhesEmissao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissao : «' + RTRIM( ISNULL( CAST (IdEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDevida : «' + RTRIM( ISNULL( CAST (IdMoedaDevida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataAtualizacaoEncargos : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacaoEncargos, 113 ),'Nulo'))+'» '
                         + '| ValorEmissao : «' + RTRIM( ISNULL( CAST (ValorEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBco : «' + RTRIM( ISNULL( CAST (ValorDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostais : «' + RTRIM( ISNULL( CAST (ValorDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoComposicao : «' + RTRIM( ISNULL( CAST (TipoComposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  bValorComDesconto IS NULL THEN ' bValorComDesconto : «Nulo» '
                                              WHEN  bValorComDesconto = 0 THEN ' bValorComDesconto : «Falso» '
                                              WHEN  bValorComDesconto = 1 THEN ' bValorComDesconto : «Verdadeiro» '
                                    END 
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DescontoAplicado IS NULL THEN ' DescontoAplicado : «Nulo» '
                                              WHEN  DescontoAplicado = 0 THEN ' DescontoAplicado : «Falso» '
                                              WHEN  DescontoAplicado = 1 THEN ' DescontoAplicado : «Verdadeiro» '
                                    END 
                         + '| SituacaoRegistro : «' + RTRIM( ISNULL( CAST (SituacaoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigRegistro : «' + RTRIM( ISNULL( CAST (IdConfigRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgBoletoBancarioI : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancarioI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgBoletoBancarioM : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancarioM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InstrIdentifSim IS NULL THEN ' InstrIdentifSim : «Nulo» '
                                              WHEN  InstrIdentifSim = 0 THEN ' InstrIdentifSim : «Falso» '
                                              WHEN  InstrIdentifSim = 1 THEN ' InstrIdentifSim : «Verdadeiro» '
                                    END 
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMotivoOcorrencia : «' + RTRIM( ISNULL( CAST (CodMotivoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmissao : «' + RTRIM( ISNULL( CAST (UsuarioEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoEmissao : «' + RTRIM( ISNULL( CAST (DepartamentoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsoImplanta IS NULL THEN ' UsoImplanta : «Nulo» '
                                              WHEN  UsoImplanta = 0 THEN ' UsoImplanta : «Falso» '
                                              WHEN  UsoImplanta = 1 THEN ' UsoImplanta : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissao : «' + RTRIM( ISNULL( CAST (IdEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDevida : «' + RTRIM( ISNULL( CAST (IdMoedaDevida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataAtualizacaoEncargos : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacaoEncargos, 113 ),'Nulo'))+'» '
                         + '| ValorEmissao : «' + RTRIM( ISNULL( CAST (ValorEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBco : «' + RTRIM( ISNULL( CAST (ValorDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostais : «' + RTRIM( ISNULL( CAST (ValorDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoComposicao : «' + RTRIM( ISNULL( CAST (TipoComposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  bValorComDesconto IS NULL THEN ' bValorComDesconto : «Nulo» '
                                              WHEN  bValorComDesconto = 0 THEN ' bValorComDesconto : «Falso» '
                                              WHEN  bValorComDesconto = 1 THEN ' bValorComDesconto : «Verdadeiro» '
                                    END 
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DescontoAplicado IS NULL THEN ' DescontoAplicado : «Nulo» '
                                              WHEN  DescontoAplicado = 0 THEN ' DescontoAplicado : «Falso» '
                                              WHEN  DescontoAplicado = 1 THEN ' DescontoAplicado : «Verdadeiro» '
                                    END 
                         + '| SituacaoRegistro : «' + RTRIM( ISNULL( CAST (SituacaoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigRegistro : «' + RTRIM( ISNULL( CAST (IdConfigRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgBoletoBancarioI : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancarioI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgBoletoBancarioM : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancarioM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InstrIdentifSim IS NULL THEN ' InstrIdentifSim : «Nulo» '
                                              WHEN  InstrIdentifSim = 0 THEN ' InstrIdentifSim : «Falso» '
                                              WHEN  InstrIdentifSim = 1 THEN ' InstrIdentifSim : «Verdadeiro» '
                                    END 
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMotivoOcorrencia : «' + RTRIM( ISNULL( CAST (CodMotivoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmissao : «' + RTRIM( ISNULL( CAST (UsuarioEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoEmissao : «' + RTRIM( ISNULL( CAST (DepartamentoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsoImplanta IS NULL THEN ' UsoImplanta : «Nulo» '
                                              WHEN  UsoImplanta = 0 THEN ' UsoImplanta : «Falso» '
                                              WHEN  UsoImplanta = 1 THEN ' UsoImplanta : «Verdadeiro» '
                                    END  FROM INSERTED 
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
		SELECT @Conteudo = 'IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissao : «' + RTRIM( ISNULL( CAST (IdEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDevida : «' + RTRIM( ISNULL( CAST (IdMoedaDevida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataAtualizacaoEncargos : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacaoEncargos, 113 ),'Nulo'))+'» '
                         + '| ValorEmissao : «' + RTRIM( ISNULL( CAST (ValorEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBco : «' + RTRIM( ISNULL( CAST (ValorDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostais : «' + RTRIM( ISNULL( CAST (ValorDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoComposicao : «' + RTRIM( ISNULL( CAST (TipoComposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  bValorComDesconto IS NULL THEN ' bValorComDesconto : «Nulo» '
                                              WHEN  bValorComDesconto = 0 THEN ' bValorComDesconto : «Falso» '
                                              WHEN  bValorComDesconto = 1 THEN ' bValorComDesconto : «Verdadeiro» '
                                    END 
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DescontoAplicado IS NULL THEN ' DescontoAplicado : «Nulo» '
                                              WHEN  DescontoAplicado = 0 THEN ' DescontoAplicado : «Falso» '
                                              WHEN  DescontoAplicado = 1 THEN ' DescontoAplicado : «Verdadeiro» '
                                    END 
                         + '| SituacaoRegistro : «' + RTRIM( ISNULL( CAST (SituacaoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigRegistro : «' + RTRIM( ISNULL( CAST (IdConfigRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgBoletoBancarioI : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancarioI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgBoletoBancarioM : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancarioM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InstrIdentifSim IS NULL THEN ' InstrIdentifSim : «Nulo» '
                                              WHEN  InstrIdentifSim = 0 THEN ' InstrIdentifSim : «Falso» '
                                              WHEN  InstrIdentifSim = 1 THEN ' InstrIdentifSim : «Verdadeiro» '
                                    END 
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMotivoOcorrencia : «' + RTRIM( ISNULL( CAST (CodMotivoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmissao : «' + RTRIM( ISNULL( CAST (UsuarioEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoEmissao : «' + RTRIM( ISNULL( CAST (DepartamentoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsoImplanta IS NULL THEN ' UsoImplanta : «Nulo» '
                                              WHEN  UsoImplanta = 0 THEN ' UsoImplanta : «Falso» '
                                              WHEN  UsoImplanta = 1 THEN ' UsoImplanta : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissao : «' + RTRIM( ISNULL( CAST (IdEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaDevida : «' + RTRIM( ISNULL( CAST (IdMoedaDevida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumero : «' + RTRIM( ISNULL( CAST (NossoNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissao, 113 ),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| DataAtualizacaoEncargos : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacaoEncargos, 113 ),'Nulo'))+'» '
                         + '| ValorEmissao : «' + RTRIM( ISNULL( CAST (ValorEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespBco : «' + RTRIM( ISNULL( CAST (ValorDespBco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespAdv : «' + RTRIM( ISNULL( CAST (ValorDespAdv AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespPostais : «' + RTRIM( ISNULL( CAST (ValorDespPostais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEmissao : «' + RTRIM( ISNULL( CAST (TipoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoComposicao : «' + RTRIM( ISNULL( CAST (TipoComposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAgencia : «' + RTRIM( ISNULL( CAST (CodAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodOperacao : «' + RTRIM( ISNULL( CAST (CodOperacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodCC_Conv_Ced : «' + RTRIM( ISNULL( CAST (CodCC_Conv_Ced AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  bValorComDesconto IS NULL THEN ' bValorComDesconto : «Nulo» '
                                              WHEN  bValorComDesconto = 0 THEN ' bValorComDesconto : «Falso» '
                                              WHEN  bValorComDesconto = 1 THEN ' bValorComDesconto : «Verdadeiro» '
                                    END 
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DescontoAplicado IS NULL THEN ' DescontoAplicado : «Nulo» '
                                              WHEN  DescontoAplicado = 0 THEN ' DescontoAplicado : «Falso» '
                                              WHEN  DescontoAplicado = 1 THEN ' DescontoAplicado : «Verdadeiro» '
                                    END 
                         + '| SituacaoRegistro : «' + RTRIM( ISNULL( CAST (SituacaoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigRegistro : «' + RTRIM( ISNULL( CAST (IdConfigRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgBoletoBancarioI : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancarioI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMsgBoletoBancarioM : «' + RTRIM( ISNULL( CAST (IdMsgBoletoBancarioM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  InstrIdentifSim IS NULL THEN ' InstrIdentifSim : «Nulo» '
                                              WHEN  InstrIdentifSim = 0 THEN ' InstrIdentifSim : «Falso» '
                                              WHEN  InstrIdentifSim = 1 THEN ' InstrIdentifSim : «Verdadeiro» '
                                    END 
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMotivoOcorrencia : «' + RTRIM( ISNULL( CAST (CodMotivoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmissao : «' + RTRIM( ISNULL( CAST (UsuarioEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoEmissao : «' + RTRIM( ISNULL( CAST (DepartamentoEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsoImplanta IS NULL THEN ' UsoImplanta : «Nulo» '
                                              WHEN  UsoImplanta = 0 THEN ' UsoImplanta : «Falso» '
                                              WHEN  UsoImplanta = 1 THEN ' UsoImplanta : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
