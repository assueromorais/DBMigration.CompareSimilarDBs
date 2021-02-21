CREATE TABLE [dbo].[EventosSispad] (
    [IdEvento]                    INT           IDENTITY (1, 1) NOT NULL,
    [NomeEvento]                  VARCHAR (50)  NOT NULL,
    [DataHoraInicioEvento]        DATETIME      NOT NULL,
    [DataHoraFimEvento]           DATETIME      NOT NULL,
    [LocalEvento]                 VARCHAR (250) NOT NULL,
    [SiglaUF]                     VARCHAR (2)   NULL,
    [IdCidadeEvento]              INT           NULL,
    [IdCentroCustoEvento]         INT           NULL,
    [DescricaoEvento]             TEXT          NULL,
    [ConfirmacaoFolhaPresenca]    BIT           CONSTRAINT [DF_EventosSispad_ConfirmacaoFolhaPresensa] DEFAULT ((0)) NULL,
    [URLReferenciaEvento]         VARCHAR (150) NULL,
    [PercentualAdiantamento]      MONEY         NULL,
    [FolhaPresencaConcluido]      BIT           CONSTRAINT [DF_EventosSispad_FolhaPresencaConcluido] DEFAULT ((0)) NULL,
    [PermitePagamentoDiaria]      BIT           CONSTRAINT [DF__EventosSi__Permi__6ECC8D1F] DEFAULT ((1)) NULL,
    [PermitePagamentoIndenizacao] BIT           CONSTRAINT [DF__EventosSi__Permi__6FC0B158] DEFAULT ((1)) NULL,
    [PrevisaoGastoEvento]         MONEY         NULL,
    [AlertaEmpenho]               BIT           DEFAULT ((1)) NULL,
    [IdTipoEvento]                INT           NULL,
    [ViagemInternacional]         BIT           NULL,
    CONSTRAINT [PK_EventosSispad] PRIMARY KEY CLUSTERED ([IdEvento] ASC),
    CONSTRAINT [FK_EventosSispad_CentroCustos] FOREIGN KEY ([IdCentroCustoEvento]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_EventosSispad_Cidades] FOREIGN KEY ([IdCidadeEvento]) REFERENCES [dbo].[Cidades] ([IdCidade]),
    CONSTRAINT [FK_EventosSispad_TipoEvento] FOREIGN KEY ([IdTipoEvento]) REFERENCES [dbo].[TipoEvento] ([IdTipoEvento])
);


GO
CREATE TRIGGER [TrgLog_EventosSispad] ON [Implanta_CRPAM].[dbo].[EventosSispad] 
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
SET @TableName = 'EventosSispad'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEvento : «' + RTRIM( ISNULL( CAST (NomeEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraInicioEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraInicioEvento, 113 ),'Nulo'))+'» '
                         + '| DataHoraFimEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraFimEvento, 113 ),'Nulo'))+'» '
                         + '| LocalEvento : «' + RTRIM( ISNULL( CAST (LocalEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeEvento : «' + RTRIM( ISNULL( CAST (IdCidadeEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoEvento : «' + RTRIM( ISNULL( CAST (IdCentroCustoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfirmacaoFolhaPresenca IS NULL THEN ' ConfirmacaoFolhaPresenca : «Nulo» '
                                              WHEN  ConfirmacaoFolhaPresenca = 0 THEN ' ConfirmacaoFolhaPresenca : «Falso» '
                                              WHEN  ConfirmacaoFolhaPresenca = 1 THEN ' ConfirmacaoFolhaPresenca : «Verdadeiro» '
                                    END 
                         + '| URLReferenciaEvento : «' + RTRIM( ISNULL( CAST (URLReferenciaEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualAdiantamento : «' + RTRIM( ISNULL( CAST (PercentualAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FolhaPresencaConcluido IS NULL THEN ' FolhaPresencaConcluido : «Nulo» '
                                              WHEN  FolhaPresencaConcluido = 0 THEN ' FolhaPresencaConcluido : «Falso» '
                                              WHEN  FolhaPresencaConcluido = 1 THEN ' FolhaPresencaConcluido : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoDiaria IS NULL THEN ' PermitePagamentoDiaria : «Nulo» '
                                              WHEN  PermitePagamentoDiaria = 0 THEN ' PermitePagamentoDiaria : «Falso» '
                                              WHEN  PermitePagamentoDiaria = 1 THEN ' PermitePagamentoDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoIndenizacao IS NULL THEN ' PermitePagamentoIndenizacao : «Nulo» '
                                              WHEN  PermitePagamentoIndenizacao = 0 THEN ' PermitePagamentoIndenizacao : «Falso» '
                                              WHEN  PermitePagamentoIndenizacao = 1 THEN ' PermitePagamentoIndenizacao : «Verdadeiro» '
                                    END 
                         + '| PrevisaoGastoEvento : «' + RTRIM( ISNULL( CAST (PrevisaoGastoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaEmpenho IS NULL THEN ' AlertaEmpenho : «Nulo» '
                                              WHEN  AlertaEmpenho = 0 THEN ' AlertaEmpenho : «Falso» '
                                              WHEN  AlertaEmpenho = 1 THEN ' AlertaEmpenho : «Verdadeiro» '
                                    END 
                         + '| IdTipoEvento : «' + RTRIM( ISNULL( CAST (IdTipoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ViagemInternacional IS NULL THEN ' ViagemInternacional : «Nulo» '
                                              WHEN  ViagemInternacional = 0 THEN ' ViagemInternacional : «Falso» '
                                              WHEN  ViagemInternacional = 1 THEN ' ViagemInternacional : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEvento : «' + RTRIM( ISNULL( CAST (NomeEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraInicioEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraInicioEvento, 113 ),'Nulo'))+'» '
                         + '| DataHoraFimEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraFimEvento, 113 ),'Nulo'))+'» '
                         + '| LocalEvento : «' + RTRIM( ISNULL( CAST (LocalEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeEvento : «' + RTRIM( ISNULL( CAST (IdCidadeEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoEvento : «' + RTRIM( ISNULL( CAST (IdCentroCustoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfirmacaoFolhaPresenca IS NULL THEN ' ConfirmacaoFolhaPresenca : «Nulo» '
                                              WHEN  ConfirmacaoFolhaPresenca = 0 THEN ' ConfirmacaoFolhaPresenca : «Falso» '
                                              WHEN  ConfirmacaoFolhaPresenca = 1 THEN ' ConfirmacaoFolhaPresenca : «Verdadeiro» '
                                    END 
                         + '| URLReferenciaEvento : «' + RTRIM( ISNULL( CAST (URLReferenciaEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualAdiantamento : «' + RTRIM( ISNULL( CAST (PercentualAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FolhaPresencaConcluido IS NULL THEN ' FolhaPresencaConcluido : «Nulo» '
                                              WHEN  FolhaPresencaConcluido = 0 THEN ' FolhaPresencaConcluido : «Falso» '
                                              WHEN  FolhaPresencaConcluido = 1 THEN ' FolhaPresencaConcluido : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoDiaria IS NULL THEN ' PermitePagamentoDiaria : «Nulo» '
                                              WHEN  PermitePagamentoDiaria = 0 THEN ' PermitePagamentoDiaria : «Falso» '
                                              WHEN  PermitePagamentoDiaria = 1 THEN ' PermitePagamentoDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoIndenizacao IS NULL THEN ' PermitePagamentoIndenizacao : «Nulo» '
                                              WHEN  PermitePagamentoIndenizacao = 0 THEN ' PermitePagamentoIndenizacao : «Falso» '
                                              WHEN  PermitePagamentoIndenizacao = 1 THEN ' PermitePagamentoIndenizacao : «Verdadeiro» '
                                    END 
                         + '| PrevisaoGastoEvento : «' + RTRIM( ISNULL( CAST (PrevisaoGastoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaEmpenho IS NULL THEN ' AlertaEmpenho : «Nulo» '
                                              WHEN  AlertaEmpenho = 0 THEN ' AlertaEmpenho : «Falso» '
                                              WHEN  AlertaEmpenho = 1 THEN ' AlertaEmpenho : «Verdadeiro» '
                                    END 
                         + '| IdTipoEvento : «' + RTRIM( ISNULL( CAST (IdTipoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ViagemInternacional IS NULL THEN ' ViagemInternacional : «Nulo» '
                                              WHEN  ViagemInternacional = 0 THEN ' ViagemInternacional : «Falso» '
                                              WHEN  ViagemInternacional = 1 THEN ' ViagemInternacional : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEvento : «' + RTRIM( ISNULL( CAST (NomeEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraInicioEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraInicioEvento, 113 ),'Nulo'))+'» '
                         + '| DataHoraFimEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraFimEvento, 113 ),'Nulo'))+'» '
                         + '| LocalEvento : «' + RTRIM( ISNULL( CAST (LocalEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeEvento : «' + RTRIM( ISNULL( CAST (IdCidadeEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoEvento : «' + RTRIM( ISNULL( CAST (IdCentroCustoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfirmacaoFolhaPresenca IS NULL THEN ' ConfirmacaoFolhaPresenca : «Nulo» '
                                              WHEN  ConfirmacaoFolhaPresenca = 0 THEN ' ConfirmacaoFolhaPresenca : «Falso» '
                                              WHEN  ConfirmacaoFolhaPresenca = 1 THEN ' ConfirmacaoFolhaPresenca : «Verdadeiro» '
                                    END 
                         + '| URLReferenciaEvento : «' + RTRIM( ISNULL( CAST (URLReferenciaEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualAdiantamento : «' + RTRIM( ISNULL( CAST (PercentualAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FolhaPresencaConcluido IS NULL THEN ' FolhaPresencaConcluido : «Nulo» '
                                              WHEN  FolhaPresencaConcluido = 0 THEN ' FolhaPresencaConcluido : «Falso» '
                                              WHEN  FolhaPresencaConcluido = 1 THEN ' FolhaPresencaConcluido : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoDiaria IS NULL THEN ' PermitePagamentoDiaria : «Nulo» '
                                              WHEN  PermitePagamentoDiaria = 0 THEN ' PermitePagamentoDiaria : «Falso» '
                                              WHEN  PermitePagamentoDiaria = 1 THEN ' PermitePagamentoDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoIndenizacao IS NULL THEN ' PermitePagamentoIndenizacao : «Nulo» '
                                              WHEN  PermitePagamentoIndenizacao = 0 THEN ' PermitePagamentoIndenizacao : «Falso» '
                                              WHEN  PermitePagamentoIndenizacao = 1 THEN ' PermitePagamentoIndenizacao : «Verdadeiro» '
                                    END 
                         + '| PrevisaoGastoEvento : «' + RTRIM( ISNULL( CAST (PrevisaoGastoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaEmpenho IS NULL THEN ' AlertaEmpenho : «Nulo» '
                                              WHEN  AlertaEmpenho = 0 THEN ' AlertaEmpenho : «Falso» '
                                              WHEN  AlertaEmpenho = 1 THEN ' AlertaEmpenho : «Verdadeiro» '
                                    END 
                         + '| IdTipoEvento : «' + RTRIM( ISNULL( CAST (IdTipoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ViagemInternacional IS NULL THEN ' ViagemInternacional : «Nulo» '
                                              WHEN  ViagemInternacional = 0 THEN ' ViagemInternacional : «Falso» '
                                              WHEN  ViagemInternacional = 1 THEN ' ViagemInternacional : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEvento : «' + RTRIM( ISNULL( CAST (NomeEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraInicioEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraInicioEvento, 113 ),'Nulo'))+'» '
                         + '| DataHoraFimEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraFimEvento, 113 ),'Nulo'))+'» '
                         + '| LocalEvento : «' + RTRIM( ISNULL( CAST (LocalEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeEvento : «' + RTRIM( ISNULL( CAST (IdCidadeEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoEvento : «' + RTRIM( ISNULL( CAST (IdCentroCustoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfirmacaoFolhaPresenca IS NULL THEN ' ConfirmacaoFolhaPresenca : «Nulo» '
                                              WHEN  ConfirmacaoFolhaPresenca = 0 THEN ' ConfirmacaoFolhaPresenca : «Falso» '
                                              WHEN  ConfirmacaoFolhaPresenca = 1 THEN ' ConfirmacaoFolhaPresenca : «Verdadeiro» '
                                    END 
                         + '| URLReferenciaEvento : «' + RTRIM( ISNULL( CAST (URLReferenciaEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PercentualAdiantamento : «' + RTRIM( ISNULL( CAST (PercentualAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  FolhaPresencaConcluido IS NULL THEN ' FolhaPresencaConcluido : «Nulo» '
                                              WHEN  FolhaPresencaConcluido = 0 THEN ' FolhaPresencaConcluido : «Falso» '
                                              WHEN  FolhaPresencaConcluido = 1 THEN ' FolhaPresencaConcluido : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoDiaria IS NULL THEN ' PermitePagamentoDiaria : «Nulo» '
                                              WHEN  PermitePagamentoDiaria = 0 THEN ' PermitePagamentoDiaria : «Falso» '
                                              WHEN  PermitePagamentoDiaria = 1 THEN ' PermitePagamentoDiaria : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermitePagamentoIndenizacao IS NULL THEN ' PermitePagamentoIndenizacao : «Nulo» '
                                              WHEN  PermitePagamentoIndenizacao = 0 THEN ' PermitePagamentoIndenizacao : «Falso» '
                                              WHEN  PermitePagamentoIndenizacao = 1 THEN ' PermitePagamentoIndenizacao : «Verdadeiro» '
                                    END 
                         + '| PrevisaoGastoEvento : «' + RTRIM( ISNULL( CAST (PrevisaoGastoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AlertaEmpenho IS NULL THEN ' AlertaEmpenho : «Nulo» '
                                              WHEN  AlertaEmpenho = 0 THEN ' AlertaEmpenho : «Falso» '
                                              WHEN  AlertaEmpenho = 1 THEN ' AlertaEmpenho : «Verdadeiro» '
                                    END 
                         + '| IdTipoEvento : «' + RTRIM( ISNULL( CAST (IdTipoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ViagemInternacional IS NULL THEN ' ViagemInternacional : «Nulo» '
                                              WHEN  ViagemInternacional = 0 THEN ' ViagemInternacional : «Falso» '
                                              WHEN  ViagemInternacional = 1 THEN ' ViagemInternacional : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
