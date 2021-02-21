CREATE TABLE [dbo].[ConfiguracoesSispad] (
    [UtilizaMotivoViagem]                  BIT            NULL,
    [CNPJCPFPFObrigatorio]                 BIT            NULL,
    [CNPJCPFAeroportosObrigatorio]         BIT            NULL,
    [CNPJCPFCompanhiasObrigatorio]         BIT            NULL,
    [CNPJCPFHoteisObrigatorio]             BIT            NULL,
    [CNPJCPFLocadorasObrigatorio]          BIT            NULL,
    [EmailOrigem]                          VARCHAR (50)   NULL,
    [UtilizarEmailUsuario]                 BIT            NULL,
    [EmailHost]                            VARCHAR (150)  NULL,
    [EmailPorta]                           INT            NULL,
    [EmailUsuario]                         VARCHAR (50)   NULL,
    [EmailSenha]                           VARCHAR (50)   NULL,
    [URLSolicitacao]                       VARCHAR (255)  NULL,
    [IdContaCorrenteBoleto]                INT            NULL,
    [URLAutorizacao]                       VARCHAR (255)  NULL,
    [URLPrestacaoConta]                    VARCHAR (255)  NULL,
    [PercentualSalarioSobreDiaria]         BIT            CONSTRAINT [DF_ConfiguracoesSispad_PercentualSalarioSobreDiaria] DEFAULT ((0)) NULL,
    [ReservaDeHospedagem]                  BIT            NULL,
    [Diarias]                              BIT            CONSTRAINT [DF_ConfiguracoesSispad_Diarias] DEFAULT ((0)) NULL,
    [DiariaDescricaosg]                    VARCHAR (50)   NULL,
    [DiariaDescricaopl]                    VARCHAR (50)   NULL,
    [UsaMeiaDiaria]                        BIT            NULL,
    [Indenizacoes]                         BIT            CONSTRAINT [DF_ConfiguracoesSispad_Indenizacoes] DEFAULT ((0)) NULL,
    [IndenizacaoDescricaosg]               VARCHAR (50)   NULL,
    [IndenizacaoDescricaopl]               VARCHAR (50)   NULL,
    [AlteraQtdDiariaAPagar]                BIT            CONSTRAINT [DF_ConfiguracoesSispad_AlteraQtdDiariaPagas] DEFAULT ((0)) NULL,
    [AlteraTipoPessoa]                     BIT            CONSTRAINT [DF_ConfiguracoesSispad_AlteraTipoPessoa] DEFAULT ((0)) NULL,
    [DeducaoVRA]                           BIT            CONSTRAINT [DF_ConfiguracoesSispad_DeducaoVRA] DEFAULT ((0)) NULL,
    [ValorVRA]                             MONEY          NULL,
    [VoucherTaxi]                          BIT            NULL,
    [AdiantamentoDespesas]                 BIT            CONSTRAINT [DF_ConfiguracoesSispad_AdiantamentoDespesas] DEFAULT ((0)) NULL,
    [EmailUnidadePassagemAerea]            VARCHAR (150)  NULL,
    [EmailUnidadeLocacaoVeiculo]           VARCHAR (150)  NULL,
    [NivelAnteriorAutorizacaoRecusada]     BIT            CONSTRAINT [DF_ConfiguracoesSispad_RetornarNivelAnteriorAutorizacaoRecusada] DEFAULT ((0)) NULL,
    [PrefixoSolicitacao]                   VARCHAR (6)    NULL,
    [SufixoSolicitacao]                    VARCHAR (6)    NULL,
    [IncrementoSolicitacao]                INT            NULL,
    [AlertaSolicitacaoMesmaDataTrecho]     BIT            CONSTRAINT [DF_ConfiguracoesSispad_AlertaSolicitacaoMesmaDataTrecho] DEFAULT ((0)) NULL,
    [CabecalhoRecibo]                      TEXT           NULL,
    [LimiteDiasPrestacaoConta]             INT            NOT NULL,
    [CabecalhoReserva]                     TEXT           NULL,
    [RodapeReserva]                        TEXT           NULL,
    [TextoDisponibilidadeOrcamentaria]     TEXT           NULL,
    [IdPessoaAdiantamento]                 INT            NULL,
    [EmailUsaAutenticacao]                 BIT            NULL,
    [NomeSistema]                          NVARCHAR (250) NULL,
    [SiglaSistema]                         NVARCHAR (20)  NULL,
    [EmailAgenciaViagem]                   NVARCHAR (150) NULL,
    [PedagioCarroAlugado]                  BIT            NULL,
    [PedagioCarroProprio]                  BIT            NULL,
    [ExibirDadosBancarios]                 BIT            NULL,
    [LinksCompanhiasAereas]                TEXT           NULL,
    [AlertaPrestacaoConta]                 BIT            NULL,
    [URLConfirmacaoPassageiro]             NVARCHAR (255) NULL,
    [IdContaTipoDespesa]                   INT            NULL,
    [IdContaAdiantamento]                  INT            NULL,
    [VoucherTaxiVinculadoReservaHotel]     BIT            NULL,
    [ReservaHotelVinculadoDiaria]          BIT            NULL,
    [ControlaDiasPrestacaoConta]           BIT            NULL,
    [KmMinimoDiaria]                       INT            CONSTRAINT [DF__Configura__KmMin__1E7BA041] DEFAULT ((0)) NULL,
    [URLSistema]                           NVARCHAR (255) NULL,
    [URLAlteracaoCancelamento]             NVARCHAR (255) NULL,
    [DisponibilidadeOrcamentaria]          BIT            CONSTRAINT [DF__Configura__Dispo__52BA5E56] DEFAULT ((0)) NULL,
    [EmitirBoleto]                         BIT            NULL,
    [ExibeValorPassagemAerea]              BIT            NULL,
    [RodapeListaPresenca]                  TEXT           NULL,
    [ControlaQtdDiasBloqueio]              BIT            NULL,
    [QtdDiasBloqueio]                      INT            NULL,
    [SolicitarAutomaticamenteEmpenhoSipro] BIT            NULL,
    [PermitirDiariaPropriaCidade]          BIT            NULL,
    [EmailTextoAgenciaViagem]              TEXT           NULL,
    [EmailTextoUnidadePassageiro]          TEXT           NULL,
    [EmailTLS]                             BIT            NULL,
    [PrefixoProcesso]                      VARCHAR (6)    NULL,
    [SufixoProcesso]                       VARCHAR (6)    NULL,
    [IncrementoProcesso]                   INT            NULL,
    [IdMoedaPadrao]                        INT            NULL,
    [DescontoPassagemAerea]                MONEY          NULL,
    [ImpostoRetido]                        NUMERIC (8, 2) NULL,
    [IdTarifaControlePassagem]             INT            NULL,
    [IdTaxaEmbarqueControlePassagem]       INT            NULL,
    [NumeroProjetoObrigatorio]             BIT            NULL,
    [EmailTesouraria]                      VARCHAR (300)  NULL,
    [CalcularDiariasPor]                   CHAR (1)       NULL,
    [EmailTextoTesouraria]                 TEXT           NULL,
    [EmailTextoDiarias]                    TEXT           NULL,
    [DescontoPassagemAereaInt]             MONEY          NULL,
    [DescontoPassagemAereaIntTipo]         CHAR (1)       NULL,
    [DescontoPassagemAereaTipo]            CHAR (1)       NULL,
    [IdPessoaDiretor]                      INT            NULL,
    [IntegracaoSISCONTNET]                 BIT            DEFAULT ((0)) NULL,
    [UrlSISCONTNET]                        VARCHAR (300)  NULL,
    [AnoPlanoContas]                       INT            NULL,
    [CentroCustoObrigatorio]               BIT            DEFAULT ((0)) NULL,
    [IdTaxaDUControlePassagem]             INT            NULL,
    [SalvarDocumentos]                     BIT            NULL,
    [ExibirEventosRetroativos]             BIT            DEFAULT ((0)) NOT NULL,
    [ListarSolicitantes]                   BIT            NULL,
    [EmailSSL]                             BIT            NULL,
    [IdPessoaTesoureiro]                   INT            NULL,
    [E_ConselhoFederal]                    BIT            NULL,
    [TipoDocumentoArquivo]                 VARCHAR (60)   NULL,
    CONSTRAINT [FK_ConfiguracoesSispad_IdMoedaPadrao] FOREIGN KEY ([IdMoedaPadrao]) REFERENCES [dbo].[Moedas] ([IdMoeda]),
    CONSTRAINT [FK_ConfiguracoesSispad_IdTarifaControlePassagem] FOREIGN KEY ([IdTarifaControlePassagem]) REFERENCES [dbo].[TarifasTaxas] ([IdTarifaTaxa]),
    CONSTRAINT [FK_ConfiguracoesSispad_IdTaxaDUControlePassagem] FOREIGN KEY ([IdTaxaDUControlePassagem]) REFERENCES [dbo].[TarifasTaxas] ([IdTarifaTaxa]),
    CONSTRAINT [FK_ConfiguracoesSispad_IdTaxaEmbarqueControlePassagem] FOREIGN KEY ([IdTaxaEmbarqueControlePassagem]) REFERENCES [dbo].[TarifasTaxas] ([IdTarifaTaxa]),
    CONSTRAINT [FK_CONFIGURACOESSISPAD_PessoaDiretor] FOREIGN KEY ([IdPessoaDiretor]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad]),
    CONSTRAINT [FK_ConfiguracoesSispad_Pessoas] FOREIGN KEY ([IdPessoaAdiantamento]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_ConfiguracoesSispad_PessoasSispad_IdPessoaTesoureiro] FOREIGN KEY ([IdPessoaTesoureiro]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad]),
    CONSTRAINT [FK_ConfiguracoesSispad_PlanoContas] FOREIGN KEY ([IdContaAdiantamento]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_ConfiguracoesSispad_PlanoContas_IdContaTipoDespesa] FOREIGN KEY ([IdContaTipoDespesa]) REFERENCES [dbo].[PlanoContas] ([IdConta]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ConfiguracoesSispad] ON [Implanta_CRPAM].[dbo].[ConfiguracoesSispad] 
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
SET @TableName = 'ConfiguracoesSispad'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo =  CASE 
         			            WHEN UtilizaMotivoViagem IS NULL THEN ' UtilizaMotivoViagem : «Nulo» '
                                         WHEN UtilizaMotivoViagem = 0 THEN ' UtilizaMotivoViagem : «Falso» '
                                         WHEN UtilizaMotivoViagem = 1 THEN ' UtilizaMotivoViagem : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFPFObrigatorio IS NULL THEN ' CNPJCPFPFObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFPFObrigatorio = 0 THEN ' CNPJCPFPFObrigatorio : «Falso» '
                                              WHEN  CNPJCPFPFObrigatorio = 1 THEN ' CNPJCPFPFObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFAeroportosObrigatorio IS NULL THEN ' CNPJCPFAeroportosObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFAeroportosObrigatorio = 0 THEN ' CNPJCPFAeroportosObrigatorio : «Falso» '
                                              WHEN  CNPJCPFAeroportosObrigatorio = 1 THEN ' CNPJCPFAeroportosObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFCompanhiasObrigatorio IS NULL THEN ' CNPJCPFCompanhiasObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFCompanhiasObrigatorio = 0 THEN ' CNPJCPFCompanhiasObrigatorio : «Falso» '
                                              WHEN  CNPJCPFCompanhiasObrigatorio = 1 THEN ' CNPJCPFCompanhiasObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFHoteisObrigatorio IS NULL THEN ' CNPJCPFHoteisObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFHoteisObrigatorio = 0 THEN ' CNPJCPFHoteisObrigatorio : «Falso» '
                                              WHEN  CNPJCPFHoteisObrigatorio = 1 THEN ' CNPJCPFHoteisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFLocadorasObrigatorio IS NULL THEN ' CNPJCPFLocadorasObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFLocadorasObrigatorio = 0 THEN ' CNPJCPFLocadorasObrigatorio : «Falso» '
                                              WHEN  CNPJCPFLocadorasObrigatorio = 1 THEN ' CNPJCPFLocadorasObrigatorio : «Verdadeiro» '
                                    END 
                         + '| EmailOrigem : «' + RTRIM( ISNULL( CAST (EmailOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarEmailUsuario IS NULL THEN ' UtilizarEmailUsuario : «Nulo» '
                                              WHEN  UtilizarEmailUsuario = 0 THEN ' UtilizarEmailUsuario : «Falso» '
                                              WHEN  UtilizarEmailUsuario = 1 THEN ' UtilizarEmailUsuario : «Verdadeiro» '
                                    END 
                         + '| EmailHost : «' + RTRIM( ISNULL( CAST (EmailHost AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailPorta : «' + RTRIM( ISNULL( CAST (EmailPorta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailUsuario : «' + RTRIM( ISNULL( CAST (EmailUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailSenha : «' + RTRIM( ISNULL( CAST (EmailSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLSolicitacao : «' + RTRIM( ISNULL( CAST (URLSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrenteBoleto : «' + RTRIM( ISNULL( CAST (IdContaCorrenteBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLAutorizacao : «' + RTRIM( ISNULL( CAST (URLAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLPrestacaoConta : «' + RTRIM( ISNULL( CAST (URLPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PercentualSalarioSobreDiaria IS NULL THEN ' PercentualSalarioSobreDiaria : «Nulo» '
                                              WHEN  PercentualSalarioSobreDiaria = 0 THEN ' PercentualSalarioSobreDiaria : «Falso» '
                                              WHEN  PercentualSalarioSobreDiaria = 1 THEN ' PercentualSalarioSobreDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReservaDeHospedagem IS NULL THEN ' ReservaDeHospedagem : «Nulo» '
                                              WHEN  ReservaDeHospedagem = 0 THEN ' ReservaDeHospedagem : «Falso» '
                                              WHEN  ReservaDeHospedagem = 1 THEN ' ReservaDeHospedagem : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Diarias IS NULL THEN ' Diarias : «Nulo» '
                                              WHEN  Diarias = 0 THEN ' Diarias : «Falso» '
                                              WHEN  Diarias = 1 THEN ' Diarias : «Verdadeiro» '
                                    END 
                         + '| DiariaDescricaosg : «' + RTRIM( ISNULL( CAST (DiariaDescricaosg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiariaDescricaopl : «' + RTRIM( ISNULL( CAST (DiariaDescricaopl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaMeiaDiaria IS NULL THEN ' UsaMeiaDiaria : «Nulo» '
                                              WHEN  UsaMeiaDiaria = 0 THEN ' UsaMeiaDiaria : «Falso» '
                                              WHEN  UsaMeiaDiaria = 1 THEN ' UsaMeiaDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Indenizacoes IS NULL THEN ' Indenizacoes : «Nulo» '
                                              WHEN  Indenizacoes = 0 THEN ' Indenizacoes : «Falso» '
                                              WHEN  Indenizacoes = 1 THEN ' Indenizacoes : «Verdadeiro» '
                                    END 
                         + '| IndenizacaoDescricaosg : «' + RTRIM( ISNULL( CAST (IndenizacaoDescricaosg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndenizacaoDescricaopl : «' + RTRIM( ISNULL( CAST (IndenizacaoDescricaopl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraQtdDiariaAPagar IS NULL THEN ' AlteraQtdDiariaAPagar : «Nulo» '
                                              WHEN  AlteraQtdDiariaAPagar = 0 THEN ' AlteraQtdDiariaAPagar : «Falso» '
                                              WHEN  AlteraQtdDiariaAPagar = 1 THEN ' AlteraQtdDiariaAPagar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlteraTipoPessoa IS NULL THEN ' AlteraTipoPessoa : «Nulo» '
                                              WHEN  AlteraTipoPessoa = 0 THEN ' AlteraTipoPessoa : «Falso» '
                                              WHEN  AlteraTipoPessoa = 1 THEN ' AlteraTipoPessoa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DeducaoVRA IS NULL THEN ' DeducaoVRA : «Nulo» '
                                              WHEN  DeducaoVRA = 0 THEN ' DeducaoVRA : «Falso» '
                                              WHEN  DeducaoVRA = 1 THEN ' DeducaoVRA : «Verdadeiro» '
                                    END 
                         + '| ValorVRA : «' + RTRIM( ISNULL( CAST (ValorVRA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VoucherTaxi IS NULL THEN ' VoucherTaxi : «Nulo» '
                                              WHEN  VoucherTaxi = 0 THEN ' VoucherTaxi : «Falso» '
                                              WHEN  VoucherTaxi = 1 THEN ' VoucherTaxi : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AdiantamentoDespesas IS NULL THEN ' AdiantamentoDespesas : «Nulo» '
                                              WHEN  AdiantamentoDespesas = 0 THEN ' AdiantamentoDespesas : «Falso» '
                                              WHEN  AdiantamentoDespesas = 1 THEN ' AdiantamentoDespesas : «Verdadeiro» '
                                    END 
                         + '| EmailUnidadePassagemAerea : «' + RTRIM( ISNULL( CAST (EmailUnidadePassagemAerea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailUnidadeLocacaoVeiculo : «' + RTRIM( ISNULL( CAST (EmailUnidadeLocacaoVeiculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NivelAnteriorAutorizacaoRecusada IS NULL THEN ' NivelAnteriorAutorizacaoRecusada : «Nulo» '
                                              WHEN  NivelAnteriorAutorizacaoRecusada = 0 THEN ' NivelAnteriorAutorizacaoRecusada : «Falso» '
                                              WHEN  NivelAnteriorAutorizacaoRecusada = 1 THEN ' NivelAnteriorAutorizacaoRecusada : «Verdadeiro» '
                                    END 
                         + '| PrefixoSolicitacao : «' + RTRIM( ISNULL( CAST (PrefixoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoSolicitacao : «' + RTRIM( ISNULL( CAST (SufixoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoSolicitacao : «' + RTRIM( ISNULL( CAST (IncrementoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho IS NULL THEN ' AlertaSolicitacaoMesmaDataTrecho : «Nulo» '
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho = 0 THEN ' AlertaSolicitacaoMesmaDataTrecho : «Falso» '
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho = 1 THEN ' AlertaSolicitacaoMesmaDataTrecho : «Verdadeiro» '
                                    END 
                         + '| LimiteDiasPrestacaoConta : «' + RTRIM( ISNULL( CAST (LimiteDiasPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaAdiantamento : «' + RTRIM( ISNULL( CAST (IdPessoaAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailUsaAutenticacao IS NULL THEN ' EmailUsaAutenticacao : «Nulo» '
                                              WHEN  EmailUsaAutenticacao = 0 THEN ' EmailUsaAutenticacao : «Falso» '
                                              WHEN  EmailUsaAutenticacao = 1 THEN ' EmailUsaAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedagioCarroAlugado IS NULL THEN ' PedagioCarroAlugado : «Nulo» '
                                              WHEN  PedagioCarroAlugado = 0 THEN ' PedagioCarroAlugado : «Falso» '
                                              WHEN  PedagioCarroAlugado = 1 THEN ' PedagioCarroAlugado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedagioCarroProprio IS NULL THEN ' PedagioCarroProprio : «Nulo» '
                                              WHEN  PedagioCarroProprio = 0 THEN ' PedagioCarroProprio : «Falso» '
                                              WHEN  PedagioCarroProprio = 1 THEN ' PedagioCarroProprio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirDadosBancarios IS NULL THEN ' ExibirDadosBancarios : «Nulo» '
                                              WHEN  ExibirDadosBancarios = 0 THEN ' ExibirDadosBancarios : «Falso» '
                                              WHEN  ExibirDadosBancarios = 1 THEN ' ExibirDadosBancarios : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlertaPrestacaoConta IS NULL THEN ' AlertaPrestacaoConta : «Nulo» '
                                              WHEN  AlertaPrestacaoConta = 0 THEN ' AlertaPrestacaoConta : «Falso» '
                                              WHEN  AlertaPrestacaoConta = 1 THEN ' AlertaPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| IdContaTipoDespesa : «' + RTRIM( ISNULL( CAST (IdContaTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAdiantamento : «' + RTRIM( ISNULL( CAST (IdContaAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VoucherTaxiVinculadoReservaHotel IS NULL THEN ' VoucherTaxiVinculadoReservaHotel : «Nulo» '
                                              WHEN  VoucherTaxiVinculadoReservaHotel = 0 THEN ' VoucherTaxiVinculadoReservaHotel : «Falso» '
                                              WHEN  VoucherTaxiVinculadoReservaHotel = 1 THEN ' VoucherTaxiVinculadoReservaHotel : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReservaHotelVinculadoDiaria IS NULL THEN ' ReservaHotelVinculadoDiaria : «Nulo» '
                                              WHEN  ReservaHotelVinculadoDiaria = 0 THEN ' ReservaHotelVinculadoDiaria : «Falso» '
                                              WHEN  ReservaHotelVinculadoDiaria = 1 THEN ' ReservaHotelVinculadoDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaDiasPrestacaoConta IS NULL THEN ' ControlaDiasPrestacaoConta : «Nulo» '
                                              WHEN  ControlaDiasPrestacaoConta = 0 THEN ' ControlaDiasPrestacaoConta : «Falso» '
                                              WHEN  ControlaDiasPrestacaoConta = 1 THEN ' ControlaDiasPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| KmMinimoDiaria : «' + RTRIM( ISNULL( CAST (KmMinimoDiaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DisponibilidadeOrcamentaria IS NULL THEN ' DisponibilidadeOrcamentaria : «Nulo» '
                                              WHEN  DisponibilidadeOrcamentaria = 0 THEN ' DisponibilidadeOrcamentaria : «Falso» '
                                              WHEN  DisponibilidadeOrcamentaria = 1 THEN ' DisponibilidadeOrcamentaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmitirBoleto IS NULL THEN ' EmitirBoleto : «Nulo» '
                                              WHEN  EmitirBoleto = 0 THEN ' EmitirBoleto : «Falso» '
                                              WHEN  EmitirBoleto = 1 THEN ' EmitirBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeValorPassagemAerea IS NULL THEN ' ExibeValorPassagemAerea : «Nulo» '
                                              WHEN  ExibeValorPassagemAerea = 0 THEN ' ExibeValorPassagemAerea : «Falso» '
                                              WHEN  ExibeValorPassagemAerea = 1 THEN ' ExibeValorPassagemAerea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaQtdDiasBloqueio IS NULL THEN ' ControlaQtdDiasBloqueio : «Nulo» '
                                              WHEN  ControlaQtdDiasBloqueio = 0 THEN ' ControlaQtdDiasBloqueio : «Falso» '
                                              WHEN  ControlaQtdDiasBloqueio = 1 THEN ' ControlaQtdDiasBloqueio : «Verdadeiro» '
                                    END 
                         + '| QtdDiasBloqueio : «' + RTRIM( ISNULL( CAST (QtdDiasBloqueio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro IS NULL THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Nulo» '
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro = 0 THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Falso» '
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro = 1 THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirDiariaPropriaCidade IS NULL THEN ' PermitirDiariaPropriaCidade : «Nulo» '
                                              WHEN  PermitirDiariaPropriaCidade = 0 THEN ' PermitirDiariaPropriaCidade : «Falso» '
                                              WHEN  PermitirDiariaPropriaCidade = 1 THEN ' PermitirDiariaPropriaCidade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailTLS IS NULL THEN ' EmailTLS : «Nulo» '
                                              WHEN  EmailTLS = 0 THEN ' EmailTLS : «Falso» '
                                              WHEN  EmailTLS = 1 THEN ' EmailTLS : «Verdadeiro» '
                                    END 
                         + '| PrefixoProcesso : «' + RTRIM( ISNULL( CAST (PrefixoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoProcesso : «' + RTRIM( ISNULL( CAST (SufixoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoProcesso : «' + RTRIM( ISNULL( CAST (IncrementoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaPadrao : «' + RTRIM( ISNULL( CAST (IdMoedaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAerea : «' + RTRIM( ISNULL( CAST (DescontoPassagemAerea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ImpostoRetido : «' + RTRIM( ISNULL( CAST (ImpostoRetido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTarifaControlePassagem : «' + RTRIM( ISNULL( CAST (IdTarifaControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTaxaEmbarqueControlePassagem : «' + RTRIM( ISNULL( CAST (IdTaxaEmbarqueControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumeroProjetoObrigatorio IS NULL THEN ' NumeroProjetoObrigatorio : «Nulo» '
                                              WHEN  NumeroProjetoObrigatorio = 0 THEN ' NumeroProjetoObrigatorio : «Falso» '
                                              WHEN  NumeroProjetoObrigatorio = 1 THEN ' NumeroProjetoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| EmailTesouraria : «' + RTRIM( ISNULL( CAST (EmailTesouraria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CalcularDiariasPor : «' + RTRIM( ISNULL( CAST (CalcularDiariasPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaInt : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaInt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaIntTipo : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaIntTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaTipo : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaDiretor : «' + RTRIM( ISNULL( CAST (IdPessoaDiretor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IntegracaoSISCONTNET IS NULL THEN ' IntegracaoSISCONTNET : «Nulo» '
                                              WHEN  IntegracaoSISCONTNET = 0 THEN ' IntegracaoSISCONTNET : «Falso» '
                                              WHEN  IntegracaoSISCONTNET = 1 THEN ' IntegracaoSISCONTNET : «Verdadeiro» '
                                    END 
                         + '| UrlSISCONTNET : «' + RTRIM( ISNULL( CAST (UrlSISCONTNET AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoPlanoContas : «' + RTRIM( ISNULL( CAST (AnoPlanoContas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CentroCustoObrigatorio IS NULL THEN ' CentroCustoObrigatorio : «Nulo» '
                                              WHEN  CentroCustoObrigatorio = 0 THEN ' CentroCustoObrigatorio : «Falso» '
                                              WHEN  CentroCustoObrigatorio = 1 THEN ' CentroCustoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| IdTaxaDUControlePassagem : «' + RTRIM( ISNULL( CAST (IdTaxaDUControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SalvarDocumentos IS NULL THEN ' SalvarDocumentos : «Nulo» '
                                              WHEN  SalvarDocumentos = 0 THEN ' SalvarDocumentos : «Falso» '
                                              WHEN  SalvarDocumentos = 1 THEN ' SalvarDocumentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirEventosRetroativos IS NULL THEN ' ExibirEventosRetroativos : «Nulo» '
                                              WHEN  ExibirEventosRetroativos = 0 THEN ' ExibirEventosRetroativos : «Falso» '
                                              WHEN  ExibirEventosRetroativos = 1 THEN ' ExibirEventosRetroativos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ListarSolicitantes IS NULL THEN ' ListarSolicitantes : «Nulo» '
                                              WHEN  ListarSolicitantes = 0 THEN ' ListarSolicitantes : «Falso» '
                                              WHEN  ListarSolicitantes = 1 THEN ' ListarSolicitantes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailSSL IS NULL THEN ' EmailSSL : «Nulo» '
                                              WHEN  EmailSSL = 0 THEN ' EmailSSL : «Falso» '
                                              WHEN  EmailSSL = 1 THEN ' EmailSSL : «Verdadeiro» '
                                    END 
                         + '| IdPessoaTesoureiro : «' + RTRIM( ISNULL( CAST (IdPessoaTesoureiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ConselhoFederal IS NULL THEN ' E_ConselhoFederal : «Nulo» '
                                              WHEN  E_ConselhoFederal = 0 THEN ' E_ConselhoFederal : «Falso» '
                                              WHEN  E_ConselhoFederal = 1 THEN ' E_ConselhoFederal : «Verdadeiro» '
                                    END 
                         + '| TipoDocumentoArquivo : «' + RTRIM( ISNULL( CAST (TipoDocumentoArquivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 =  CASE 
         			            WHEN UtilizaMotivoViagem IS NULL THEN ' UtilizaMotivoViagem : «Nulo» '
                                         WHEN UtilizaMotivoViagem = 0 THEN ' UtilizaMotivoViagem : «Falso» '
                                         WHEN UtilizaMotivoViagem = 1 THEN ' UtilizaMotivoViagem : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFPFObrigatorio IS NULL THEN ' CNPJCPFPFObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFPFObrigatorio = 0 THEN ' CNPJCPFPFObrigatorio : «Falso» '
                                              WHEN  CNPJCPFPFObrigatorio = 1 THEN ' CNPJCPFPFObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFAeroportosObrigatorio IS NULL THEN ' CNPJCPFAeroportosObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFAeroportosObrigatorio = 0 THEN ' CNPJCPFAeroportosObrigatorio : «Falso» '
                                              WHEN  CNPJCPFAeroportosObrigatorio = 1 THEN ' CNPJCPFAeroportosObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFCompanhiasObrigatorio IS NULL THEN ' CNPJCPFCompanhiasObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFCompanhiasObrigatorio = 0 THEN ' CNPJCPFCompanhiasObrigatorio : «Falso» '
                                              WHEN  CNPJCPFCompanhiasObrigatorio = 1 THEN ' CNPJCPFCompanhiasObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFHoteisObrigatorio IS NULL THEN ' CNPJCPFHoteisObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFHoteisObrigatorio = 0 THEN ' CNPJCPFHoteisObrigatorio : «Falso» '
                                              WHEN  CNPJCPFHoteisObrigatorio = 1 THEN ' CNPJCPFHoteisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFLocadorasObrigatorio IS NULL THEN ' CNPJCPFLocadorasObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFLocadorasObrigatorio = 0 THEN ' CNPJCPFLocadorasObrigatorio : «Falso» '
                                              WHEN  CNPJCPFLocadorasObrigatorio = 1 THEN ' CNPJCPFLocadorasObrigatorio : «Verdadeiro» '
                                    END 
                         + '| EmailOrigem : «' + RTRIM( ISNULL( CAST (EmailOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarEmailUsuario IS NULL THEN ' UtilizarEmailUsuario : «Nulo» '
                                              WHEN  UtilizarEmailUsuario = 0 THEN ' UtilizarEmailUsuario : «Falso» '
                                              WHEN  UtilizarEmailUsuario = 1 THEN ' UtilizarEmailUsuario : «Verdadeiro» '
                                    END 
                         + '| EmailHost : «' + RTRIM( ISNULL( CAST (EmailHost AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailPorta : «' + RTRIM( ISNULL( CAST (EmailPorta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailUsuario : «' + RTRIM( ISNULL( CAST (EmailUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailSenha : «' + RTRIM( ISNULL( CAST (EmailSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLSolicitacao : «' + RTRIM( ISNULL( CAST (URLSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrenteBoleto : «' + RTRIM( ISNULL( CAST (IdContaCorrenteBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLAutorizacao : «' + RTRIM( ISNULL( CAST (URLAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLPrestacaoConta : «' + RTRIM( ISNULL( CAST (URLPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PercentualSalarioSobreDiaria IS NULL THEN ' PercentualSalarioSobreDiaria : «Nulo» '
                                              WHEN  PercentualSalarioSobreDiaria = 0 THEN ' PercentualSalarioSobreDiaria : «Falso» '
                                              WHEN  PercentualSalarioSobreDiaria = 1 THEN ' PercentualSalarioSobreDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReservaDeHospedagem IS NULL THEN ' ReservaDeHospedagem : «Nulo» '
                                              WHEN  ReservaDeHospedagem = 0 THEN ' ReservaDeHospedagem : «Falso» '
                                              WHEN  ReservaDeHospedagem = 1 THEN ' ReservaDeHospedagem : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Diarias IS NULL THEN ' Diarias : «Nulo» '
                                              WHEN  Diarias = 0 THEN ' Diarias : «Falso» '
                                              WHEN  Diarias = 1 THEN ' Diarias : «Verdadeiro» '
                                    END 
                         + '| DiariaDescricaosg : «' + RTRIM( ISNULL( CAST (DiariaDescricaosg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiariaDescricaopl : «' + RTRIM( ISNULL( CAST (DiariaDescricaopl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaMeiaDiaria IS NULL THEN ' UsaMeiaDiaria : «Nulo» '
                                              WHEN  UsaMeiaDiaria = 0 THEN ' UsaMeiaDiaria : «Falso» '
                                              WHEN  UsaMeiaDiaria = 1 THEN ' UsaMeiaDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Indenizacoes IS NULL THEN ' Indenizacoes : «Nulo» '
                                              WHEN  Indenizacoes = 0 THEN ' Indenizacoes : «Falso» '
                                              WHEN  Indenizacoes = 1 THEN ' Indenizacoes : «Verdadeiro» '
                                    END 
                         + '| IndenizacaoDescricaosg : «' + RTRIM( ISNULL( CAST (IndenizacaoDescricaosg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndenizacaoDescricaopl : «' + RTRIM( ISNULL( CAST (IndenizacaoDescricaopl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraQtdDiariaAPagar IS NULL THEN ' AlteraQtdDiariaAPagar : «Nulo» '
                                              WHEN  AlteraQtdDiariaAPagar = 0 THEN ' AlteraQtdDiariaAPagar : «Falso» '
                                              WHEN  AlteraQtdDiariaAPagar = 1 THEN ' AlteraQtdDiariaAPagar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlteraTipoPessoa IS NULL THEN ' AlteraTipoPessoa : «Nulo» '
                                              WHEN  AlteraTipoPessoa = 0 THEN ' AlteraTipoPessoa : «Falso» '
                                              WHEN  AlteraTipoPessoa = 1 THEN ' AlteraTipoPessoa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DeducaoVRA IS NULL THEN ' DeducaoVRA : «Nulo» '
                                              WHEN  DeducaoVRA = 0 THEN ' DeducaoVRA : «Falso» '
                                              WHEN  DeducaoVRA = 1 THEN ' DeducaoVRA : «Verdadeiro» '
                                    END 
                         + '| ValorVRA : «' + RTRIM( ISNULL( CAST (ValorVRA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VoucherTaxi IS NULL THEN ' VoucherTaxi : «Nulo» '
                                              WHEN  VoucherTaxi = 0 THEN ' VoucherTaxi : «Falso» '
                                              WHEN  VoucherTaxi = 1 THEN ' VoucherTaxi : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AdiantamentoDespesas IS NULL THEN ' AdiantamentoDespesas : «Nulo» '
                                              WHEN  AdiantamentoDespesas = 0 THEN ' AdiantamentoDespesas : «Falso» '
                                              WHEN  AdiantamentoDespesas = 1 THEN ' AdiantamentoDespesas : «Verdadeiro» '
                                    END 
                         + '| EmailUnidadePassagemAerea : «' + RTRIM( ISNULL( CAST (EmailUnidadePassagemAerea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailUnidadeLocacaoVeiculo : «' + RTRIM( ISNULL( CAST (EmailUnidadeLocacaoVeiculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NivelAnteriorAutorizacaoRecusada IS NULL THEN ' NivelAnteriorAutorizacaoRecusada : «Nulo» '
                                              WHEN  NivelAnteriorAutorizacaoRecusada = 0 THEN ' NivelAnteriorAutorizacaoRecusada : «Falso» '
                                              WHEN  NivelAnteriorAutorizacaoRecusada = 1 THEN ' NivelAnteriorAutorizacaoRecusada : «Verdadeiro» '
                                    END 
                         + '| PrefixoSolicitacao : «' + RTRIM( ISNULL( CAST (PrefixoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoSolicitacao : «' + RTRIM( ISNULL( CAST (SufixoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoSolicitacao : «' + RTRIM( ISNULL( CAST (IncrementoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho IS NULL THEN ' AlertaSolicitacaoMesmaDataTrecho : «Nulo» '
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho = 0 THEN ' AlertaSolicitacaoMesmaDataTrecho : «Falso» '
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho = 1 THEN ' AlertaSolicitacaoMesmaDataTrecho : «Verdadeiro» '
                                    END 
                         + '| LimiteDiasPrestacaoConta : «' + RTRIM( ISNULL( CAST (LimiteDiasPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaAdiantamento : «' + RTRIM( ISNULL( CAST (IdPessoaAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailUsaAutenticacao IS NULL THEN ' EmailUsaAutenticacao : «Nulo» '
                                              WHEN  EmailUsaAutenticacao = 0 THEN ' EmailUsaAutenticacao : «Falso» '
                                              WHEN  EmailUsaAutenticacao = 1 THEN ' EmailUsaAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedagioCarroAlugado IS NULL THEN ' PedagioCarroAlugado : «Nulo» '
                                              WHEN  PedagioCarroAlugado = 0 THEN ' PedagioCarroAlugado : «Falso» '
                                              WHEN  PedagioCarroAlugado = 1 THEN ' PedagioCarroAlugado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedagioCarroProprio IS NULL THEN ' PedagioCarroProprio : «Nulo» '
                                              WHEN  PedagioCarroProprio = 0 THEN ' PedagioCarroProprio : «Falso» '
                                              WHEN  PedagioCarroProprio = 1 THEN ' PedagioCarroProprio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirDadosBancarios IS NULL THEN ' ExibirDadosBancarios : «Nulo» '
                                              WHEN  ExibirDadosBancarios = 0 THEN ' ExibirDadosBancarios : «Falso» '
                                              WHEN  ExibirDadosBancarios = 1 THEN ' ExibirDadosBancarios : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlertaPrestacaoConta IS NULL THEN ' AlertaPrestacaoConta : «Nulo» '
                                              WHEN  AlertaPrestacaoConta = 0 THEN ' AlertaPrestacaoConta : «Falso» '
                                              WHEN  AlertaPrestacaoConta = 1 THEN ' AlertaPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| IdContaTipoDespesa : «' + RTRIM( ISNULL( CAST (IdContaTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAdiantamento : «' + RTRIM( ISNULL( CAST (IdContaAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VoucherTaxiVinculadoReservaHotel IS NULL THEN ' VoucherTaxiVinculadoReservaHotel : «Nulo» '
                                              WHEN  VoucherTaxiVinculadoReservaHotel = 0 THEN ' VoucherTaxiVinculadoReservaHotel : «Falso» '
                                              WHEN  VoucherTaxiVinculadoReservaHotel = 1 THEN ' VoucherTaxiVinculadoReservaHotel : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReservaHotelVinculadoDiaria IS NULL THEN ' ReservaHotelVinculadoDiaria : «Nulo» '
                                              WHEN  ReservaHotelVinculadoDiaria = 0 THEN ' ReservaHotelVinculadoDiaria : «Falso» '
                                              WHEN  ReservaHotelVinculadoDiaria = 1 THEN ' ReservaHotelVinculadoDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaDiasPrestacaoConta IS NULL THEN ' ControlaDiasPrestacaoConta : «Nulo» '
                                              WHEN  ControlaDiasPrestacaoConta = 0 THEN ' ControlaDiasPrestacaoConta : «Falso» '
                                              WHEN  ControlaDiasPrestacaoConta = 1 THEN ' ControlaDiasPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| KmMinimoDiaria : «' + RTRIM( ISNULL( CAST (KmMinimoDiaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DisponibilidadeOrcamentaria IS NULL THEN ' DisponibilidadeOrcamentaria : «Nulo» '
                                              WHEN  DisponibilidadeOrcamentaria = 0 THEN ' DisponibilidadeOrcamentaria : «Falso» '
                                              WHEN  DisponibilidadeOrcamentaria = 1 THEN ' DisponibilidadeOrcamentaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmitirBoleto IS NULL THEN ' EmitirBoleto : «Nulo» '
                                              WHEN  EmitirBoleto = 0 THEN ' EmitirBoleto : «Falso» '
                                              WHEN  EmitirBoleto = 1 THEN ' EmitirBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeValorPassagemAerea IS NULL THEN ' ExibeValorPassagemAerea : «Nulo» '
                                              WHEN  ExibeValorPassagemAerea = 0 THEN ' ExibeValorPassagemAerea : «Falso» '
                                              WHEN  ExibeValorPassagemAerea = 1 THEN ' ExibeValorPassagemAerea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaQtdDiasBloqueio IS NULL THEN ' ControlaQtdDiasBloqueio : «Nulo» '
                                              WHEN  ControlaQtdDiasBloqueio = 0 THEN ' ControlaQtdDiasBloqueio : «Falso» '
                                              WHEN  ControlaQtdDiasBloqueio = 1 THEN ' ControlaQtdDiasBloqueio : «Verdadeiro» '
                                    END 
                         + '| QtdDiasBloqueio : «' + RTRIM( ISNULL( CAST (QtdDiasBloqueio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro IS NULL THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Nulo» '
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro = 0 THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Falso» '
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro = 1 THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirDiariaPropriaCidade IS NULL THEN ' PermitirDiariaPropriaCidade : «Nulo» '
                                              WHEN  PermitirDiariaPropriaCidade = 0 THEN ' PermitirDiariaPropriaCidade : «Falso» '
                                              WHEN  PermitirDiariaPropriaCidade = 1 THEN ' PermitirDiariaPropriaCidade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailTLS IS NULL THEN ' EmailTLS : «Nulo» '
                                              WHEN  EmailTLS = 0 THEN ' EmailTLS : «Falso» '
                                              WHEN  EmailTLS = 1 THEN ' EmailTLS : «Verdadeiro» '
                                    END 
                         + '| PrefixoProcesso : «' + RTRIM( ISNULL( CAST (PrefixoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoProcesso : «' + RTRIM( ISNULL( CAST (SufixoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoProcesso : «' + RTRIM( ISNULL( CAST (IncrementoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaPadrao : «' + RTRIM( ISNULL( CAST (IdMoedaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAerea : «' + RTRIM( ISNULL( CAST (DescontoPassagemAerea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ImpostoRetido : «' + RTRIM( ISNULL( CAST (ImpostoRetido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTarifaControlePassagem : «' + RTRIM( ISNULL( CAST (IdTarifaControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTaxaEmbarqueControlePassagem : «' + RTRIM( ISNULL( CAST (IdTaxaEmbarqueControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumeroProjetoObrigatorio IS NULL THEN ' NumeroProjetoObrigatorio : «Nulo» '
                                              WHEN  NumeroProjetoObrigatorio = 0 THEN ' NumeroProjetoObrigatorio : «Falso» '
                                              WHEN  NumeroProjetoObrigatorio = 1 THEN ' NumeroProjetoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| EmailTesouraria : «' + RTRIM( ISNULL( CAST (EmailTesouraria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CalcularDiariasPor : «' + RTRIM( ISNULL( CAST (CalcularDiariasPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaInt : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaInt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaIntTipo : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaIntTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaTipo : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaDiretor : «' + RTRIM( ISNULL( CAST (IdPessoaDiretor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IntegracaoSISCONTNET IS NULL THEN ' IntegracaoSISCONTNET : «Nulo» '
                                              WHEN  IntegracaoSISCONTNET = 0 THEN ' IntegracaoSISCONTNET : «Falso» '
                                              WHEN  IntegracaoSISCONTNET = 1 THEN ' IntegracaoSISCONTNET : «Verdadeiro» '
                                    END 
                         + '| UrlSISCONTNET : «' + RTRIM( ISNULL( CAST (UrlSISCONTNET AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoPlanoContas : «' + RTRIM( ISNULL( CAST (AnoPlanoContas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CentroCustoObrigatorio IS NULL THEN ' CentroCustoObrigatorio : «Nulo» '
                                              WHEN  CentroCustoObrigatorio = 0 THEN ' CentroCustoObrigatorio : «Falso» '
                                              WHEN  CentroCustoObrigatorio = 1 THEN ' CentroCustoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| IdTaxaDUControlePassagem : «' + RTRIM( ISNULL( CAST (IdTaxaDUControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SalvarDocumentos IS NULL THEN ' SalvarDocumentos : «Nulo» '
                                              WHEN  SalvarDocumentos = 0 THEN ' SalvarDocumentos : «Falso» '
                                              WHEN  SalvarDocumentos = 1 THEN ' SalvarDocumentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirEventosRetroativos IS NULL THEN ' ExibirEventosRetroativos : «Nulo» '
                                              WHEN  ExibirEventosRetroativos = 0 THEN ' ExibirEventosRetroativos : «Falso» '
                                              WHEN  ExibirEventosRetroativos = 1 THEN ' ExibirEventosRetroativos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ListarSolicitantes IS NULL THEN ' ListarSolicitantes : «Nulo» '
                                              WHEN  ListarSolicitantes = 0 THEN ' ListarSolicitantes : «Falso» '
                                              WHEN  ListarSolicitantes = 1 THEN ' ListarSolicitantes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailSSL IS NULL THEN ' EmailSSL : «Nulo» '
                                              WHEN  EmailSSL = 0 THEN ' EmailSSL : «Falso» '
                                              WHEN  EmailSSL = 1 THEN ' EmailSSL : «Verdadeiro» '
                                    END 
                         + '| IdPessoaTesoureiro : «' + RTRIM( ISNULL( CAST (IdPessoaTesoureiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ConselhoFederal IS NULL THEN ' E_ConselhoFederal : «Nulo» '
                                              WHEN  E_ConselhoFederal = 0 THEN ' E_ConselhoFederal : «Falso» '
                                              WHEN  E_ConselhoFederal = 1 THEN ' E_ConselhoFederal : «Verdadeiro» '
                                    END 
                         + '| TipoDocumentoArquivo : «' + RTRIM( ISNULL( CAST (TipoDocumentoArquivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo =  CASE 
         			            WHEN UtilizaMotivoViagem IS NULL THEN ' UtilizaMotivoViagem : «Nulo» '
                                         WHEN UtilizaMotivoViagem = 0 THEN ' UtilizaMotivoViagem : «Falso» '
                                         WHEN UtilizaMotivoViagem = 1 THEN ' UtilizaMotivoViagem : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFPFObrigatorio IS NULL THEN ' CNPJCPFPFObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFPFObrigatorio = 0 THEN ' CNPJCPFPFObrigatorio : «Falso» '
                                              WHEN  CNPJCPFPFObrigatorio = 1 THEN ' CNPJCPFPFObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFAeroportosObrigatorio IS NULL THEN ' CNPJCPFAeroportosObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFAeroportosObrigatorio = 0 THEN ' CNPJCPFAeroportosObrigatorio : «Falso» '
                                              WHEN  CNPJCPFAeroportosObrigatorio = 1 THEN ' CNPJCPFAeroportosObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFCompanhiasObrigatorio IS NULL THEN ' CNPJCPFCompanhiasObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFCompanhiasObrigatorio = 0 THEN ' CNPJCPFCompanhiasObrigatorio : «Falso» '
                                              WHEN  CNPJCPFCompanhiasObrigatorio = 1 THEN ' CNPJCPFCompanhiasObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFHoteisObrigatorio IS NULL THEN ' CNPJCPFHoteisObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFHoteisObrigatorio = 0 THEN ' CNPJCPFHoteisObrigatorio : «Falso» '
                                              WHEN  CNPJCPFHoteisObrigatorio = 1 THEN ' CNPJCPFHoteisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFLocadorasObrigatorio IS NULL THEN ' CNPJCPFLocadorasObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFLocadorasObrigatorio = 0 THEN ' CNPJCPFLocadorasObrigatorio : «Falso» '
                                              WHEN  CNPJCPFLocadorasObrigatorio = 1 THEN ' CNPJCPFLocadorasObrigatorio : «Verdadeiro» '
                                    END 
                         + '| EmailOrigem : «' + RTRIM( ISNULL( CAST (EmailOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarEmailUsuario IS NULL THEN ' UtilizarEmailUsuario : «Nulo» '
                                              WHEN  UtilizarEmailUsuario = 0 THEN ' UtilizarEmailUsuario : «Falso» '
                                              WHEN  UtilizarEmailUsuario = 1 THEN ' UtilizarEmailUsuario : «Verdadeiro» '
                                    END 
                         + '| EmailHost : «' + RTRIM( ISNULL( CAST (EmailHost AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailPorta : «' + RTRIM( ISNULL( CAST (EmailPorta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailUsuario : «' + RTRIM( ISNULL( CAST (EmailUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailSenha : «' + RTRIM( ISNULL( CAST (EmailSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLSolicitacao : «' + RTRIM( ISNULL( CAST (URLSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrenteBoleto : «' + RTRIM( ISNULL( CAST (IdContaCorrenteBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLAutorizacao : «' + RTRIM( ISNULL( CAST (URLAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLPrestacaoConta : «' + RTRIM( ISNULL( CAST (URLPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PercentualSalarioSobreDiaria IS NULL THEN ' PercentualSalarioSobreDiaria : «Nulo» '
                                              WHEN  PercentualSalarioSobreDiaria = 0 THEN ' PercentualSalarioSobreDiaria : «Falso» '
                                              WHEN  PercentualSalarioSobreDiaria = 1 THEN ' PercentualSalarioSobreDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReservaDeHospedagem IS NULL THEN ' ReservaDeHospedagem : «Nulo» '
                                              WHEN  ReservaDeHospedagem = 0 THEN ' ReservaDeHospedagem : «Falso» '
                                              WHEN  ReservaDeHospedagem = 1 THEN ' ReservaDeHospedagem : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Diarias IS NULL THEN ' Diarias : «Nulo» '
                                              WHEN  Diarias = 0 THEN ' Diarias : «Falso» '
                                              WHEN  Diarias = 1 THEN ' Diarias : «Verdadeiro» '
                                    END 
                         + '| DiariaDescricaosg : «' + RTRIM( ISNULL( CAST (DiariaDescricaosg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiariaDescricaopl : «' + RTRIM( ISNULL( CAST (DiariaDescricaopl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaMeiaDiaria IS NULL THEN ' UsaMeiaDiaria : «Nulo» '
                                              WHEN  UsaMeiaDiaria = 0 THEN ' UsaMeiaDiaria : «Falso» '
                                              WHEN  UsaMeiaDiaria = 1 THEN ' UsaMeiaDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Indenizacoes IS NULL THEN ' Indenizacoes : «Nulo» '
                                              WHEN  Indenizacoes = 0 THEN ' Indenizacoes : «Falso» '
                                              WHEN  Indenizacoes = 1 THEN ' Indenizacoes : «Verdadeiro» '
                                    END 
                         + '| IndenizacaoDescricaosg : «' + RTRIM( ISNULL( CAST (IndenizacaoDescricaosg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndenizacaoDescricaopl : «' + RTRIM( ISNULL( CAST (IndenizacaoDescricaopl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraQtdDiariaAPagar IS NULL THEN ' AlteraQtdDiariaAPagar : «Nulo» '
                                              WHEN  AlteraQtdDiariaAPagar = 0 THEN ' AlteraQtdDiariaAPagar : «Falso» '
                                              WHEN  AlteraQtdDiariaAPagar = 1 THEN ' AlteraQtdDiariaAPagar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlteraTipoPessoa IS NULL THEN ' AlteraTipoPessoa : «Nulo» '
                                              WHEN  AlteraTipoPessoa = 0 THEN ' AlteraTipoPessoa : «Falso» '
                                              WHEN  AlteraTipoPessoa = 1 THEN ' AlteraTipoPessoa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DeducaoVRA IS NULL THEN ' DeducaoVRA : «Nulo» '
                                              WHEN  DeducaoVRA = 0 THEN ' DeducaoVRA : «Falso» '
                                              WHEN  DeducaoVRA = 1 THEN ' DeducaoVRA : «Verdadeiro» '
                                    END 
                         + '| ValorVRA : «' + RTRIM( ISNULL( CAST (ValorVRA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VoucherTaxi IS NULL THEN ' VoucherTaxi : «Nulo» '
                                              WHEN  VoucherTaxi = 0 THEN ' VoucherTaxi : «Falso» '
                                              WHEN  VoucherTaxi = 1 THEN ' VoucherTaxi : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AdiantamentoDespesas IS NULL THEN ' AdiantamentoDespesas : «Nulo» '
                                              WHEN  AdiantamentoDespesas = 0 THEN ' AdiantamentoDespesas : «Falso» '
                                              WHEN  AdiantamentoDespesas = 1 THEN ' AdiantamentoDespesas : «Verdadeiro» '
                                    END 
                         + '| EmailUnidadePassagemAerea : «' + RTRIM( ISNULL( CAST (EmailUnidadePassagemAerea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailUnidadeLocacaoVeiculo : «' + RTRIM( ISNULL( CAST (EmailUnidadeLocacaoVeiculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NivelAnteriorAutorizacaoRecusada IS NULL THEN ' NivelAnteriorAutorizacaoRecusada : «Nulo» '
                                              WHEN  NivelAnteriorAutorizacaoRecusada = 0 THEN ' NivelAnteriorAutorizacaoRecusada : «Falso» '
                                              WHEN  NivelAnteriorAutorizacaoRecusada = 1 THEN ' NivelAnteriorAutorizacaoRecusada : «Verdadeiro» '
                                    END 
                         + '| PrefixoSolicitacao : «' + RTRIM( ISNULL( CAST (PrefixoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoSolicitacao : «' + RTRIM( ISNULL( CAST (SufixoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoSolicitacao : «' + RTRIM( ISNULL( CAST (IncrementoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho IS NULL THEN ' AlertaSolicitacaoMesmaDataTrecho : «Nulo» '
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho = 0 THEN ' AlertaSolicitacaoMesmaDataTrecho : «Falso» '
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho = 1 THEN ' AlertaSolicitacaoMesmaDataTrecho : «Verdadeiro» '
                                    END 
                         + '| LimiteDiasPrestacaoConta : «' + RTRIM( ISNULL( CAST (LimiteDiasPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaAdiantamento : «' + RTRIM( ISNULL( CAST (IdPessoaAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailUsaAutenticacao IS NULL THEN ' EmailUsaAutenticacao : «Nulo» '
                                              WHEN  EmailUsaAutenticacao = 0 THEN ' EmailUsaAutenticacao : «Falso» '
                                              WHEN  EmailUsaAutenticacao = 1 THEN ' EmailUsaAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedagioCarroAlugado IS NULL THEN ' PedagioCarroAlugado : «Nulo» '
                                              WHEN  PedagioCarroAlugado = 0 THEN ' PedagioCarroAlugado : «Falso» '
                                              WHEN  PedagioCarroAlugado = 1 THEN ' PedagioCarroAlugado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedagioCarroProprio IS NULL THEN ' PedagioCarroProprio : «Nulo» '
                                              WHEN  PedagioCarroProprio = 0 THEN ' PedagioCarroProprio : «Falso» '
                                              WHEN  PedagioCarroProprio = 1 THEN ' PedagioCarroProprio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirDadosBancarios IS NULL THEN ' ExibirDadosBancarios : «Nulo» '
                                              WHEN  ExibirDadosBancarios = 0 THEN ' ExibirDadosBancarios : «Falso» '
                                              WHEN  ExibirDadosBancarios = 1 THEN ' ExibirDadosBancarios : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlertaPrestacaoConta IS NULL THEN ' AlertaPrestacaoConta : «Nulo» '
                                              WHEN  AlertaPrestacaoConta = 0 THEN ' AlertaPrestacaoConta : «Falso» '
                                              WHEN  AlertaPrestacaoConta = 1 THEN ' AlertaPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| IdContaTipoDespesa : «' + RTRIM( ISNULL( CAST (IdContaTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAdiantamento : «' + RTRIM( ISNULL( CAST (IdContaAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VoucherTaxiVinculadoReservaHotel IS NULL THEN ' VoucherTaxiVinculadoReservaHotel : «Nulo» '
                                              WHEN  VoucherTaxiVinculadoReservaHotel = 0 THEN ' VoucherTaxiVinculadoReservaHotel : «Falso» '
                                              WHEN  VoucherTaxiVinculadoReservaHotel = 1 THEN ' VoucherTaxiVinculadoReservaHotel : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReservaHotelVinculadoDiaria IS NULL THEN ' ReservaHotelVinculadoDiaria : «Nulo» '
                                              WHEN  ReservaHotelVinculadoDiaria = 0 THEN ' ReservaHotelVinculadoDiaria : «Falso» '
                                              WHEN  ReservaHotelVinculadoDiaria = 1 THEN ' ReservaHotelVinculadoDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaDiasPrestacaoConta IS NULL THEN ' ControlaDiasPrestacaoConta : «Nulo» '
                                              WHEN  ControlaDiasPrestacaoConta = 0 THEN ' ControlaDiasPrestacaoConta : «Falso» '
                                              WHEN  ControlaDiasPrestacaoConta = 1 THEN ' ControlaDiasPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| KmMinimoDiaria : «' + RTRIM( ISNULL( CAST (KmMinimoDiaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DisponibilidadeOrcamentaria IS NULL THEN ' DisponibilidadeOrcamentaria : «Nulo» '
                                              WHEN  DisponibilidadeOrcamentaria = 0 THEN ' DisponibilidadeOrcamentaria : «Falso» '
                                              WHEN  DisponibilidadeOrcamentaria = 1 THEN ' DisponibilidadeOrcamentaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmitirBoleto IS NULL THEN ' EmitirBoleto : «Nulo» '
                                              WHEN  EmitirBoleto = 0 THEN ' EmitirBoleto : «Falso» '
                                              WHEN  EmitirBoleto = 1 THEN ' EmitirBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeValorPassagemAerea IS NULL THEN ' ExibeValorPassagemAerea : «Nulo» '
                                              WHEN  ExibeValorPassagemAerea = 0 THEN ' ExibeValorPassagemAerea : «Falso» '
                                              WHEN  ExibeValorPassagemAerea = 1 THEN ' ExibeValorPassagemAerea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaQtdDiasBloqueio IS NULL THEN ' ControlaQtdDiasBloqueio : «Nulo» '
                                              WHEN  ControlaQtdDiasBloqueio = 0 THEN ' ControlaQtdDiasBloqueio : «Falso» '
                                              WHEN  ControlaQtdDiasBloqueio = 1 THEN ' ControlaQtdDiasBloqueio : «Verdadeiro» '
                                    END 
                         + '| QtdDiasBloqueio : «' + RTRIM( ISNULL( CAST (QtdDiasBloqueio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro IS NULL THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Nulo» '
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro = 0 THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Falso» '
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro = 1 THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirDiariaPropriaCidade IS NULL THEN ' PermitirDiariaPropriaCidade : «Nulo» '
                                              WHEN  PermitirDiariaPropriaCidade = 0 THEN ' PermitirDiariaPropriaCidade : «Falso» '
                                              WHEN  PermitirDiariaPropriaCidade = 1 THEN ' PermitirDiariaPropriaCidade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailTLS IS NULL THEN ' EmailTLS : «Nulo» '
                                              WHEN  EmailTLS = 0 THEN ' EmailTLS : «Falso» '
                                              WHEN  EmailTLS = 1 THEN ' EmailTLS : «Verdadeiro» '
                                    END 
                         + '| PrefixoProcesso : «' + RTRIM( ISNULL( CAST (PrefixoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoProcesso : «' + RTRIM( ISNULL( CAST (SufixoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoProcesso : «' + RTRIM( ISNULL( CAST (IncrementoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaPadrao : «' + RTRIM( ISNULL( CAST (IdMoedaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAerea : «' + RTRIM( ISNULL( CAST (DescontoPassagemAerea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ImpostoRetido : «' + RTRIM( ISNULL( CAST (ImpostoRetido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTarifaControlePassagem : «' + RTRIM( ISNULL( CAST (IdTarifaControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTaxaEmbarqueControlePassagem : «' + RTRIM( ISNULL( CAST (IdTaxaEmbarqueControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumeroProjetoObrigatorio IS NULL THEN ' NumeroProjetoObrigatorio : «Nulo» '
                                              WHEN  NumeroProjetoObrigatorio = 0 THEN ' NumeroProjetoObrigatorio : «Falso» '
                                              WHEN  NumeroProjetoObrigatorio = 1 THEN ' NumeroProjetoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| EmailTesouraria : «' + RTRIM( ISNULL( CAST (EmailTesouraria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CalcularDiariasPor : «' + RTRIM( ISNULL( CAST (CalcularDiariasPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaInt : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaInt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaIntTipo : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaIntTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaTipo : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaDiretor : «' + RTRIM( ISNULL( CAST (IdPessoaDiretor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IntegracaoSISCONTNET IS NULL THEN ' IntegracaoSISCONTNET : «Nulo» '
                                              WHEN  IntegracaoSISCONTNET = 0 THEN ' IntegracaoSISCONTNET : «Falso» '
                                              WHEN  IntegracaoSISCONTNET = 1 THEN ' IntegracaoSISCONTNET : «Verdadeiro» '
                                    END 
                         + '| UrlSISCONTNET : «' + RTRIM( ISNULL( CAST (UrlSISCONTNET AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoPlanoContas : «' + RTRIM( ISNULL( CAST (AnoPlanoContas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CentroCustoObrigatorio IS NULL THEN ' CentroCustoObrigatorio : «Nulo» '
                                              WHEN  CentroCustoObrigatorio = 0 THEN ' CentroCustoObrigatorio : «Falso» '
                                              WHEN  CentroCustoObrigatorio = 1 THEN ' CentroCustoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| IdTaxaDUControlePassagem : «' + RTRIM( ISNULL( CAST (IdTaxaDUControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SalvarDocumentos IS NULL THEN ' SalvarDocumentos : «Nulo» '
                                              WHEN  SalvarDocumentos = 0 THEN ' SalvarDocumentos : «Falso» '
                                              WHEN  SalvarDocumentos = 1 THEN ' SalvarDocumentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirEventosRetroativos IS NULL THEN ' ExibirEventosRetroativos : «Nulo» '
                                              WHEN  ExibirEventosRetroativos = 0 THEN ' ExibirEventosRetroativos : «Falso» '
                                              WHEN  ExibirEventosRetroativos = 1 THEN ' ExibirEventosRetroativos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ListarSolicitantes IS NULL THEN ' ListarSolicitantes : «Nulo» '
                                              WHEN  ListarSolicitantes = 0 THEN ' ListarSolicitantes : «Falso» '
                                              WHEN  ListarSolicitantes = 1 THEN ' ListarSolicitantes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailSSL IS NULL THEN ' EmailSSL : «Nulo» '
                                              WHEN  EmailSSL = 0 THEN ' EmailSSL : «Falso» '
                                              WHEN  EmailSSL = 1 THEN ' EmailSSL : «Verdadeiro» '
                                    END 
                         + '| IdPessoaTesoureiro : «' + RTRIM( ISNULL( CAST (IdPessoaTesoureiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ConselhoFederal IS NULL THEN ' E_ConselhoFederal : «Nulo» '
                                              WHEN  E_ConselhoFederal = 0 THEN ' E_ConselhoFederal : «Falso» '
                                              WHEN  E_ConselhoFederal = 1 THEN ' E_ConselhoFederal : «Verdadeiro» '
                                    END 
                         + '| TipoDocumentoArquivo : «' + RTRIM( ISNULL( CAST (TipoDocumentoArquivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo =  CASE 
         			            WHEN UtilizaMotivoViagem IS NULL THEN ' UtilizaMotivoViagem : «Nulo» '
                                         WHEN UtilizaMotivoViagem = 0 THEN ' UtilizaMotivoViagem : «Falso» '
                                         WHEN UtilizaMotivoViagem = 1 THEN ' UtilizaMotivoViagem : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFPFObrigatorio IS NULL THEN ' CNPJCPFPFObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFPFObrigatorio = 0 THEN ' CNPJCPFPFObrigatorio : «Falso» '
                                              WHEN  CNPJCPFPFObrigatorio = 1 THEN ' CNPJCPFPFObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFAeroportosObrigatorio IS NULL THEN ' CNPJCPFAeroportosObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFAeroportosObrigatorio = 0 THEN ' CNPJCPFAeroportosObrigatorio : «Falso» '
                                              WHEN  CNPJCPFAeroportosObrigatorio = 1 THEN ' CNPJCPFAeroportosObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFCompanhiasObrigatorio IS NULL THEN ' CNPJCPFCompanhiasObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFCompanhiasObrigatorio = 0 THEN ' CNPJCPFCompanhiasObrigatorio : «Falso» '
                                              WHEN  CNPJCPFCompanhiasObrigatorio = 1 THEN ' CNPJCPFCompanhiasObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFHoteisObrigatorio IS NULL THEN ' CNPJCPFHoteisObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFHoteisObrigatorio = 0 THEN ' CNPJCPFHoteisObrigatorio : «Falso» '
                                              WHEN  CNPJCPFHoteisObrigatorio = 1 THEN ' CNPJCPFHoteisObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CNPJCPFLocadorasObrigatorio IS NULL THEN ' CNPJCPFLocadorasObrigatorio : «Nulo» '
                                              WHEN  CNPJCPFLocadorasObrigatorio = 0 THEN ' CNPJCPFLocadorasObrigatorio : «Falso» '
                                              WHEN  CNPJCPFLocadorasObrigatorio = 1 THEN ' CNPJCPFLocadorasObrigatorio : «Verdadeiro» '
                                    END 
                         + '| EmailOrigem : «' + RTRIM( ISNULL( CAST (EmailOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizarEmailUsuario IS NULL THEN ' UtilizarEmailUsuario : «Nulo» '
                                              WHEN  UtilizarEmailUsuario = 0 THEN ' UtilizarEmailUsuario : «Falso» '
                                              WHEN  UtilizarEmailUsuario = 1 THEN ' UtilizarEmailUsuario : «Verdadeiro» '
                                    END 
                         + '| EmailHost : «' + RTRIM( ISNULL( CAST (EmailHost AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailPorta : «' + RTRIM( ISNULL( CAST (EmailPorta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailUsuario : «' + RTRIM( ISNULL( CAST (EmailUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailSenha : «' + RTRIM( ISNULL( CAST (EmailSenha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLSolicitacao : «' + RTRIM( ISNULL( CAST (URLSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrenteBoleto : «' + RTRIM( ISNULL( CAST (IdContaCorrenteBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLAutorizacao : «' + RTRIM( ISNULL( CAST (URLAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| URLPrestacaoConta : «' + RTRIM( ISNULL( CAST (URLPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PercentualSalarioSobreDiaria IS NULL THEN ' PercentualSalarioSobreDiaria : «Nulo» '
                                              WHEN  PercentualSalarioSobreDiaria = 0 THEN ' PercentualSalarioSobreDiaria : «Falso» '
                                              WHEN  PercentualSalarioSobreDiaria = 1 THEN ' PercentualSalarioSobreDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReservaDeHospedagem IS NULL THEN ' ReservaDeHospedagem : «Nulo» '
                                              WHEN  ReservaDeHospedagem = 0 THEN ' ReservaDeHospedagem : «Falso» '
                                              WHEN  ReservaDeHospedagem = 1 THEN ' ReservaDeHospedagem : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Diarias IS NULL THEN ' Diarias : «Nulo» '
                                              WHEN  Diarias = 0 THEN ' Diarias : «Falso» '
                                              WHEN  Diarias = 1 THEN ' Diarias : «Verdadeiro» '
                                    END 
                         + '| DiariaDescricaosg : «' + RTRIM( ISNULL( CAST (DiariaDescricaosg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiariaDescricaopl : «' + RTRIM( ISNULL( CAST (DiariaDescricaopl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaMeiaDiaria IS NULL THEN ' UsaMeiaDiaria : «Nulo» '
                                              WHEN  UsaMeiaDiaria = 0 THEN ' UsaMeiaDiaria : «Falso» '
                                              WHEN  UsaMeiaDiaria = 1 THEN ' UsaMeiaDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Indenizacoes IS NULL THEN ' Indenizacoes : «Nulo» '
                                              WHEN  Indenizacoes = 0 THEN ' Indenizacoes : «Falso» '
                                              WHEN  Indenizacoes = 1 THEN ' Indenizacoes : «Verdadeiro» '
                                    END 
                         + '| IndenizacaoDescricaosg : «' + RTRIM( ISNULL( CAST (IndenizacaoDescricaosg AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndenizacaoDescricaopl : «' + RTRIM( ISNULL( CAST (IndenizacaoDescricaopl AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlteraQtdDiariaAPagar IS NULL THEN ' AlteraQtdDiariaAPagar : «Nulo» '
                                              WHEN  AlteraQtdDiariaAPagar = 0 THEN ' AlteraQtdDiariaAPagar : «Falso» '
                                              WHEN  AlteraQtdDiariaAPagar = 1 THEN ' AlteraQtdDiariaAPagar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlteraTipoPessoa IS NULL THEN ' AlteraTipoPessoa : «Nulo» '
                                              WHEN  AlteraTipoPessoa = 0 THEN ' AlteraTipoPessoa : «Falso» '
                                              WHEN  AlteraTipoPessoa = 1 THEN ' AlteraTipoPessoa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DeducaoVRA IS NULL THEN ' DeducaoVRA : «Nulo» '
                                              WHEN  DeducaoVRA = 0 THEN ' DeducaoVRA : «Falso» '
                                              WHEN  DeducaoVRA = 1 THEN ' DeducaoVRA : «Verdadeiro» '
                                    END 
                         + '| ValorVRA : «' + RTRIM( ISNULL( CAST (ValorVRA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VoucherTaxi IS NULL THEN ' VoucherTaxi : «Nulo» '
                                              WHEN  VoucherTaxi = 0 THEN ' VoucherTaxi : «Falso» '
                                              WHEN  VoucherTaxi = 1 THEN ' VoucherTaxi : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AdiantamentoDespesas IS NULL THEN ' AdiantamentoDespesas : «Nulo» '
                                              WHEN  AdiantamentoDespesas = 0 THEN ' AdiantamentoDespesas : «Falso» '
                                              WHEN  AdiantamentoDespesas = 1 THEN ' AdiantamentoDespesas : «Verdadeiro» '
                                    END 
                         + '| EmailUnidadePassagemAerea : «' + RTRIM( ISNULL( CAST (EmailUnidadePassagemAerea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailUnidadeLocacaoVeiculo : «' + RTRIM( ISNULL( CAST (EmailUnidadeLocacaoVeiculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NivelAnteriorAutorizacaoRecusada IS NULL THEN ' NivelAnteriorAutorizacaoRecusada : «Nulo» '
                                              WHEN  NivelAnteriorAutorizacaoRecusada = 0 THEN ' NivelAnteriorAutorizacaoRecusada : «Falso» '
                                              WHEN  NivelAnteriorAutorizacaoRecusada = 1 THEN ' NivelAnteriorAutorizacaoRecusada : «Verdadeiro» '
                                    END 
                         + '| PrefixoSolicitacao : «' + RTRIM( ISNULL( CAST (PrefixoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoSolicitacao : «' + RTRIM( ISNULL( CAST (SufixoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoSolicitacao : «' + RTRIM( ISNULL( CAST (IncrementoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho IS NULL THEN ' AlertaSolicitacaoMesmaDataTrecho : «Nulo» '
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho = 0 THEN ' AlertaSolicitacaoMesmaDataTrecho : «Falso» '
                                              WHEN  AlertaSolicitacaoMesmaDataTrecho = 1 THEN ' AlertaSolicitacaoMesmaDataTrecho : «Verdadeiro» '
                                    END 
                         + '| LimiteDiasPrestacaoConta : «' + RTRIM( ISNULL( CAST (LimiteDiasPrestacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaAdiantamento : «' + RTRIM( ISNULL( CAST (IdPessoaAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EmailUsaAutenticacao IS NULL THEN ' EmailUsaAutenticacao : «Nulo» '
                                              WHEN  EmailUsaAutenticacao = 0 THEN ' EmailUsaAutenticacao : «Falso» '
                                              WHEN  EmailUsaAutenticacao = 1 THEN ' EmailUsaAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedagioCarroAlugado IS NULL THEN ' PedagioCarroAlugado : «Nulo» '
                                              WHEN  PedagioCarroAlugado = 0 THEN ' PedagioCarroAlugado : «Falso» '
                                              WHEN  PedagioCarroAlugado = 1 THEN ' PedagioCarroAlugado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PedagioCarroProprio IS NULL THEN ' PedagioCarroProprio : «Nulo» '
                                              WHEN  PedagioCarroProprio = 0 THEN ' PedagioCarroProprio : «Falso» '
                                              WHEN  PedagioCarroProprio = 1 THEN ' PedagioCarroProprio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirDadosBancarios IS NULL THEN ' ExibirDadosBancarios : «Nulo» '
                                              WHEN  ExibirDadosBancarios = 0 THEN ' ExibirDadosBancarios : «Falso» '
                                              WHEN  ExibirDadosBancarios = 1 THEN ' ExibirDadosBancarios : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlertaPrestacaoConta IS NULL THEN ' AlertaPrestacaoConta : «Nulo» '
                                              WHEN  AlertaPrestacaoConta = 0 THEN ' AlertaPrestacaoConta : «Falso» '
                                              WHEN  AlertaPrestacaoConta = 1 THEN ' AlertaPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| IdContaTipoDespesa : «' + RTRIM( ISNULL( CAST (IdContaTipoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaAdiantamento : «' + RTRIM( ISNULL( CAST (IdContaAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  VoucherTaxiVinculadoReservaHotel IS NULL THEN ' VoucherTaxiVinculadoReservaHotel : «Nulo» '
                                              WHEN  VoucherTaxiVinculadoReservaHotel = 0 THEN ' VoucherTaxiVinculadoReservaHotel : «Falso» '
                                              WHEN  VoucherTaxiVinculadoReservaHotel = 1 THEN ' VoucherTaxiVinculadoReservaHotel : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReservaHotelVinculadoDiaria IS NULL THEN ' ReservaHotelVinculadoDiaria : «Nulo» '
                                              WHEN  ReservaHotelVinculadoDiaria = 0 THEN ' ReservaHotelVinculadoDiaria : «Falso» '
                                              WHEN  ReservaHotelVinculadoDiaria = 1 THEN ' ReservaHotelVinculadoDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaDiasPrestacaoConta IS NULL THEN ' ControlaDiasPrestacaoConta : «Nulo» '
                                              WHEN  ControlaDiasPrestacaoConta = 0 THEN ' ControlaDiasPrestacaoConta : «Falso» '
                                              WHEN  ControlaDiasPrestacaoConta = 1 THEN ' ControlaDiasPrestacaoConta : «Verdadeiro» '
                                    END 
                         + '| KmMinimoDiaria : «' + RTRIM( ISNULL( CAST (KmMinimoDiaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DisponibilidadeOrcamentaria IS NULL THEN ' DisponibilidadeOrcamentaria : «Nulo» '
                                              WHEN  DisponibilidadeOrcamentaria = 0 THEN ' DisponibilidadeOrcamentaria : «Falso» '
                                              WHEN  DisponibilidadeOrcamentaria = 1 THEN ' DisponibilidadeOrcamentaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmitirBoleto IS NULL THEN ' EmitirBoleto : «Nulo» '
                                              WHEN  EmitirBoleto = 0 THEN ' EmitirBoleto : «Falso» '
                                              WHEN  EmitirBoleto = 1 THEN ' EmitirBoleto : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeValorPassagemAerea IS NULL THEN ' ExibeValorPassagemAerea : «Nulo» '
                                              WHEN  ExibeValorPassagemAerea = 0 THEN ' ExibeValorPassagemAerea : «Falso» '
                                              WHEN  ExibeValorPassagemAerea = 1 THEN ' ExibeValorPassagemAerea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ControlaQtdDiasBloqueio IS NULL THEN ' ControlaQtdDiasBloqueio : «Nulo» '
                                              WHEN  ControlaQtdDiasBloqueio = 0 THEN ' ControlaQtdDiasBloqueio : «Falso» '
                                              WHEN  ControlaQtdDiasBloqueio = 1 THEN ' ControlaQtdDiasBloqueio : «Verdadeiro» '
                                    END 
                         + '| QtdDiasBloqueio : «' + RTRIM( ISNULL( CAST (QtdDiasBloqueio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro IS NULL THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Nulo» '
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro = 0 THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Falso» '
                                              WHEN  SolicitarAutomaticamenteEmpenhoSipro = 1 THEN ' SolicitarAutomaticamenteEmpenhoSipro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitirDiariaPropriaCidade IS NULL THEN ' PermitirDiariaPropriaCidade : «Nulo» '
                                              WHEN  PermitirDiariaPropriaCidade = 0 THEN ' PermitirDiariaPropriaCidade : «Falso» '
                                              WHEN  PermitirDiariaPropriaCidade = 1 THEN ' PermitirDiariaPropriaCidade : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailTLS IS NULL THEN ' EmailTLS : «Nulo» '
                                              WHEN  EmailTLS = 0 THEN ' EmailTLS : «Falso» '
                                              WHEN  EmailTLS = 1 THEN ' EmailTLS : «Verdadeiro» '
                                    END 
                         + '| PrefixoProcesso : «' + RTRIM( ISNULL( CAST (PrefixoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoProcesso : «' + RTRIM( ISNULL( CAST (SufixoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoProcesso : «' + RTRIM( ISNULL( CAST (IncrementoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaPadrao : «' + RTRIM( ISNULL( CAST (IdMoedaPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAerea : «' + RTRIM( ISNULL( CAST (DescontoPassagemAerea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ImpostoRetido : «' + RTRIM( ISNULL( CAST (ImpostoRetido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTarifaControlePassagem : «' + RTRIM( ISNULL( CAST (IdTarifaControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTaxaEmbarqueControlePassagem : «' + RTRIM( ISNULL( CAST (IdTaxaEmbarqueControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NumeroProjetoObrigatorio IS NULL THEN ' NumeroProjetoObrigatorio : «Nulo» '
                                              WHEN  NumeroProjetoObrigatorio = 0 THEN ' NumeroProjetoObrigatorio : «Falso» '
                                              WHEN  NumeroProjetoObrigatorio = 1 THEN ' NumeroProjetoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| EmailTesouraria : «' + RTRIM( ISNULL( CAST (EmailTesouraria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CalcularDiariasPor : «' + RTRIM( ISNULL( CAST (CalcularDiariasPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaInt : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaInt AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaIntTipo : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaIntTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoPassagemAereaTipo : «' + RTRIM( ISNULL( CAST (DescontoPassagemAereaTipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaDiretor : «' + RTRIM( ISNULL( CAST (IdPessoaDiretor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IntegracaoSISCONTNET IS NULL THEN ' IntegracaoSISCONTNET : «Nulo» '
                                              WHEN  IntegracaoSISCONTNET = 0 THEN ' IntegracaoSISCONTNET : «Falso» '
                                              WHEN  IntegracaoSISCONTNET = 1 THEN ' IntegracaoSISCONTNET : «Verdadeiro» '
                                    END 
                         + '| UrlSISCONTNET : «' + RTRIM( ISNULL( CAST (UrlSISCONTNET AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoPlanoContas : «' + RTRIM( ISNULL( CAST (AnoPlanoContas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CentroCustoObrigatorio IS NULL THEN ' CentroCustoObrigatorio : «Nulo» '
                                              WHEN  CentroCustoObrigatorio = 0 THEN ' CentroCustoObrigatorio : «Falso» '
                                              WHEN  CentroCustoObrigatorio = 1 THEN ' CentroCustoObrigatorio : «Verdadeiro» '
                                    END 
                         + '| IdTaxaDUControlePassagem : «' + RTRIM( ISNULL( CAST (IdTaxaDUControlePassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  SalvarDocumentos IS NULL THEN ' SalvarDocumentos : «Nulo» '
                                              WHEN  SalvarDocumentos = 0 THEN ' SalvarDocumentos : «Falso» '
                                              WHEN  SalvarDocumentos = 1 THEN ' SalvarDocumentos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirEventosRetroativos IS NULL THEN ' ExibirEventosRetroativos : «Nulo» '
                                              WHEN  ExibirEventosRetroativos = 0 THEN ' ExibirEventosRetroativos : «Falso» '
                                              WHEN  ExibirEventosRetroativos = 1 THEN ' ExibirEventosRetroativos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ListarSolicitantes IS NULL THEN ' ListarSolicitantes : «Nulo» '
                                              WHEN  ListarSolicitantes = 0 THEN ' ListarSolicitantes : «Falso» '
                                              WHEN  ListarSolicitantes = 1 THEN ' ListarSolicitantes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailSSL IS NULL THEN ' EmailSSL : «Nulo» '
                                              WHEN  EmailSSL = 0 THEN ' EmailSSL : «Falso» '
                                              WHEN  EmailSSL = 1 THEN ' EmailSSL : «Verdadeiro» '
                                    END 
                         + '| IdPessoaTesoureiro : «' + RTRIM( ISNULL( CAST (IdPessoaTesoureiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ConselhoFederal IS NULL THEN ' E_ConselhoFederal : «Nulo» '
                                              WHEN  E_ConselhoFederal = 0 THEN ' E_ConselhoFederal : «Falso» '
                                              WHEN  E_ConselhoFederal = 1 THEN ' E_ConselhoFederal : «Verdadeiro» '
                                    END 
                         + '| TipoDocumentoArquivo : «' + RTRIM( ISNULL( CAST (TipoDocumentoArquivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
