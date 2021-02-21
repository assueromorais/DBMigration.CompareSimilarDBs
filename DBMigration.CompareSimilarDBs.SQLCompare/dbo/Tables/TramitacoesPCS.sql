CREATE TABLE [dbo].[TramitacoesPCS] (
    [IdTramitacoesPCS]       INT          IDENTITY (1, 1) NOT NULL,
    [IdProcesso]             INT          NOT NULL,
    [IdSetoresTramitacaoPCS] INT          NOT NULL,
    [DataHora]               DATETIME     NOT NULL,
    [Responsavel]            VARCHAR (50) NOT NULL,
    [Observacao]             TEXT         NULL,
    [Providencia]            TEXT         NULL,
    [DataRecebimento]        DATETIME     NULL,
    [UsuarioRecebimento]     VARCHAR (50) NULL,
    [Recebido]               INT          NULL,
    CONSTRAINT [PK_TramitacoesPCS] PRIMARY KEY CLUSTERED ([IdTramitacoesPCS] ASC),
    CONSTRAINT [FK_TramitacoesPCS_Processo] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[ProcessosCompServ] ([IdProcesso]),
    CONSTRAINT [FK_TramitacoesPCS_SetoresTramitacaoPCS] FOREIGN KEY ([IdSetoresTramitacaoPCS]) REFERENCES [dbo].[SetoresTramitacaoPCS] ([IdSetoresTramitacaoPCS])
);

