CREATE TABLE [dbo].[Processos_Prof_PJ_Pessoas1] (
    [IdProcessos_Prof_PJ_Pessoa1] INT IDENTITY (1, 1) NOT NULL,
    [IdProfissional]              INT NULL,
    [IdPessoaJuridica]            INT NULL,
    [IdProcesso]                  INT NOT NULL,
    [IdPessoa]                    INT NULL,
    CONSTRAINT [PK_EntidProfiss_Processos1] PRIMARY KEY CLUSTERED ([IdProcessos_Prof_PJ_Pessoa1] ASC),
    CONSTRAINT [FK_EntidProfiss_Processos_PessoasJuridicas1] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_EntidProfiss_Processos_Processos1] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [FK_EntidProfiss_Processos_Profissionais1] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_Processos_Prof_Pj_Pessoas1] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
-- Criado pelo Orlando em 04/03/2011

CREATE TRIGGER BLOQUEIA_DELETE_LOTE_CAMPO_GRID_DINAMICO ON  Processos_Prof_PJ_Pessoas1
FOR DELETE
AS 
BEGIN
   IF (SELECT COUNT(*) FROM DELETED)> 1
      BEGIN
        RAISERROR ('Ocorreu erro ao deletar os registro em lote na tabela Processos_Prof_PJ_Pessoas1. Informe a Implanta Informática',10, 1)
        ROLLBACK
      END
      
END
