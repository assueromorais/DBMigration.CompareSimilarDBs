CREATE TABLE [dbo].[Web_Despesas] (
    [IdDespesa]                INT              IDENTITY (1, 1) NOT NULL,
    [IdConta]                  INT              NOT NULL,
    [IdPessoa]                 INT              NOT NULL,
    [IdTipoDocumentoPagamento] INT              NOT NULL,
    [DataDespesa]              DATETIME         NULL,
    [Valor]                    MONEY            NULL,
    [Historico]                VARCHAR (255)    NOT NULL,
    [Documento]                VARCHAR (255)    NOT NULL,
    [IdCentroCusto]            INT              NULL,
    [IdUsuarioSubSecao]        INT              NULL,
    [IdUsuarioSIPRO]           INT              NULL,
    [DataHomologacao]          DATETIME         NULL,
    [IdPagamento]              INT              NULL,
    [Status]                   VARCHAR (20)     CONSTRAINT [DF_DespesasWeb_Status] DEFAULT ('Não enviado') NOT NULL,
    [IdEmpenho]                INT              NULL,
    [JustificativaRecusa]      VARCHAR (500)    NULL,
    [rowid]                    UNIQUEIDENTIFIER NULL,
    [idContaFinanceira]        INT              NULL,
    [DataEfetiva]              DATETIME         NULL,
    [ValorEfetivo]             MONEY            NULL,
    CONSTRAINT [FK_Web_Despesas_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_Web_Despesas_Empenhos] FOREIGN KEY ([IdEmpenho]) REFERENCES [dbo].[Empenhos] ([IdEmpenho]),
    CONSTRAINT [FK_Web_Despesas_Pagamentos1] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_Web_Despesas_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_Web_Despesas_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_Web_Despesas_TiposDocumentosPagamentos] FOREIGN KEY ([IdTipoDocumentoPagamento]) REFERENCES [dbo].[TiposDocumentosPagamentos] ([IdTipoDocumentoPagamento]),
    CONSTRAINT [FK_Web_Despesas_Usuarios] FOREIGN KEY ([IdUsuarioSubSecao]) REFERENCES [dbo].[Usuarios] ([IdUsuario]),
    CONSTRAINT [FK_Web_Despesas_Usuarios1] FOREIGN KEY ([IdUsuarioSIPRO]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
 CREATE TRIGGER [dbo].[Trg_AlimentaDataValorEfetivo] ON [dbo].[Web_Despesas] FOR INSERT, UPDATE AS
DECLARE @ValorEfetivo money
DECLARE @Valor money
DECLARE @DataEfetiva    DateTime
DECLARE @DataDespesa    DateTime
DECLARE @IdDespesa int

SELECT @IdDespesa = IdDespesa FROM INSERTED
SELECT @Valor = Valor FROM INSERTED
SELECT @DataDespesa = DataDespesa FROM inserted
SELECT @ValorEfetivo = ValorEfetivo FROM INSERTED
SELECT @DataEfetiva = DataEfetiva FROM inserted
IF @ValorEfetivo IS NULL 
  UPDATE Web_Despesas SET ValorEfetivo = @Valor WHERE IdDespesa = @IdDespesa
IF @DataEfetiva IS NULL 
  UPDATE Web_Despesas SET DataEfetiva = @DataDespesa WHERE IdDespesa = @IdDespesa