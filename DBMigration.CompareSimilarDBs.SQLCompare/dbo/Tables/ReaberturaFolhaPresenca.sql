CREATE TABLE [dbo].[ReaberturaFolhaPresenca] (
    [IdReabertura]   INT      IDENTITY (1, 1) NOT NULL,
    [IdEvento]       INT      NULL,
    [IdUsuario]      INT      NULL,
    [DataReabertura] DATETIME NULL,
    [Justificativa]  TEXT     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_ReaberturaFolhaPresenca] PRIMARY KEY CLUSTERED ([IdReabertura] ASC),
    CONSTRAINT [FK_ReaberturaFolhaPresenca_EventosSispad] FOREIGN KEY ([IdEvento]) REFERENCES [dbo].[EventosSispad] ([IdEvento])
);

