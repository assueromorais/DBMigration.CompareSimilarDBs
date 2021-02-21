CREATE TABLE [dbo].[Vouchers] (
    [IdVoucher]                 INT            IDENTITY (1, 1) NOT NULL,
    [IdPessoaSolicitacaoViagem] INT            NULL,
    [IdRadioTaxi]               INT            NULL,
    [NumVoucher]                INT            NULL,
    [DataEntrega]               DATETIME       CONSTRAINT [DF_Vouchers_DataEntrega] DEFAULT (getdate()) NULL,
    [DataDevolucao]             DATETIME       NULL,
    [Embarque]                  NVARCHAR (150) NULL,
    [HoraSaida]                 DATETIME       NULL,
    [Desembarque]               NVARCHAR (150) NULL,
    [HoraChegada]               DATETIME       NULL,
    [Prefixo]                   NVARCHAR (10)  NULL,
    [Placa]                     NVARCHAR (10)  NULL,
    [Valor]                     MONEY          NULL,
    [NaoUtilizado]              BIT            CONSTRAINT [DF_Vouchers_NaoUtilizado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Vouchers] PRIMARY KEY CLUSTERED ([IdVoucher] ASC),
    CONSTRAINT [FK_Vouchers_PessoasSolicitacoesViagem] FOREIGN KEY ([IdPessoaSolicitacaoViagem]) REFERENCES [dbo].[PessoasSolicitacoesViagem] ([IdPessoaSolicitacaoViagem]),
    CONSTRAINT [FK_Vouchers_RadioTaxi] FOREIGN KEY ([IdRadioTaxi]) REFERENCES [dbo].[RadioTaxi] ([IdRadioTaxi])
);

