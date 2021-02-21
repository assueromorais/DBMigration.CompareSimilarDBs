CREATE TABLE [dbo].[SequenciaAutorizacao] (
    [IdNivelAutorizacao] INT NOT NULL,
    [IdNivelAutorizou]   INT NOT NULL,
    [Sequencia]          INT NOT NULL,
    CONSTRAINT [PK_SequenciaAutorizacao] PRIMARY KEY CLUSTERED ([IdNivelAutorizacao] ASC, [IdNivelAutorizou] ASC, [Sequencia] ASC),
    CONSTRAINT [FK_SequenciaAutorizacao_NiveisAutorizacao] FOREIGN KEY ([IdNivelAutorizacao]) REFERENCES [dbo].[NiveisAutorizacao] ([IdNivelAutorizacao]),
    CONSTRAINT [FK_SequenciaAutorizacao_NiveisAutorizacao1] FOREIGN KEY ([IdNivelAutorizou]) REFERENCES [dbo].[NiveisAutorizacao] ([IdNivelAutorizacao])
);

