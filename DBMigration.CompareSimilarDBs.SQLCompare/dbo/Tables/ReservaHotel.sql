CREATE TABLE [dbo].[ReservaHotel] (
    [IdReservaHotel]      INT           IDENTITY (1, 1) NOT NULL,
    [IdPessoaSolicitacao] INT           NOT NULL,
    [IdPessoa]            INT           NULL,
    [DataHoraCheckIn]     DATETIME      NULL,
    [DataHoraCheckOut]    DATETIME      NULL,
    [IdAcomodacao]        INT           NULL,
    [ObservacoesReserva]  TEXT          NULL,
    [SituacaoReserva]     VARCHAR (100) NULL,
    CONSTRAINT [PK_HospedagemSolicitacoesViagem] PRIMARY KEY CLUSTERED ([IdReservaHotel] ASC),
    CONSTRAINT [FK_HospedagemSolicitacoesViagem_HospedagemSolicitacoesViagem] FOREIGN KEY ([IdReservaHotel]) REFERENCES [dbo].[ReservaHotel] ([IdReservaHotel]),
    CONSTRAINT [FK_HospedagemSolicitacoesViagem_PessoasSolicitacoesViagem] FOREIGN KEY ([IdPessoaSolicitacao]) REFERENCES [dbo].[PessoasSolicitacoesViagem] ([IdPessoaSolicitacaoViagem])
);

