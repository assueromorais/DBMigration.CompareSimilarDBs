CREATE TABLE [dbo].[ProcessosSolicitacaoViagem] (
    [IdProcessoSolicitacaoViagem]  INT          IDENTITY (1, 1) NOT NULL,
    [Numero]                       VARCHAR (40) NOT NULL,
    [Data]                         DATETIME     NULL,
    [IdPessoaPassageiro]           INT          NULL,
    [DataPrestacaoConta]           DATETIME     NULL,
    [Observacoes]                  TEXT         NULL,
    [NumeroRecibo]                 VARCHAR (30) NULL,
    [DataPagamento]                DATETIME     NULL,
    [MesReferencia]                INT          NULL,
    [AnoReferencia]                INT          NULL,
    [IdPessoaResponsavelPgto]      INT          NULL,
    [NumeroReciboDetalhado]        VARCHAR (30) NULL,
    [NumeroReciboReembolsoDespesa] VARCHAR (30) NULL,
    CONSTRAINT [PK_ProcessosSolicitacaoViagem] PRIMARY KEY CLUSTERED ([IdProcessoSolicitacaoViagem] ASC),
    CONSTRAINT [FK_ProcessosSolicitacaoViagem_IdPessoaPassageiro] FOREIGN KEY ([IdPessoaPassageiro]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad]),
    CONSTRAINT [FK_ProcessosSolicitacaoViagem_PessoaResponsavelPgto] FOREIGN KEY ([IdPessoaResponsavelPgto]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad])
);

