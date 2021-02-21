CREATE TABLE [dbo].[TelefonesPessoaFisicaOutro] (
    [IdTelefonePFOutras]   INT         IDENTITY (1, 1) NOT NULL,
    [IdPessoaFisicaOutras] INT         NULL,
    [DDD]                  VARCHAR (4) NULL,
    [NumeroTelefone]       VARCHAR (9) NULL,
    [TipoTelefone]         VARCHAR (1) NULL,
    [NomeRecado]           TEXT        NULL,
    [HorarioLigacao]       TEXT        NULL,
    [LocalTelefone]        VARCHAR (1) NULL,
    [Ramal]                VARCHAR (5) NULL,
    CONSTRAINT [PK_TelefonesPessoaFisicaOutro] PRIMARY KEY CLUSTERED ([IdTelefonePFOutras] ASC)
);

