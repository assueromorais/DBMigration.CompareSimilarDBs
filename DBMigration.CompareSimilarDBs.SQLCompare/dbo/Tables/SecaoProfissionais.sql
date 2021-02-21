CREATE TABLE [dbo].[SecaoProfissionais] (
    [IdSecao]        INT NOT NULL,
    [IdProfissional] INT NOT NULL,
    CONSTRAINT [PK_SecaoProfissionais] PRIMARY KEY CLUSTERED ([IdSecao] ASC, [IdProfissional] ASC),
    CONSTRAINT [FK_SecaoProfissionais_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
ALTER TABLE [dbo].[SecaoProfissionais] NOCHECK CONSTRAINT [FK_SecaoProfissionais_Profissionais];

