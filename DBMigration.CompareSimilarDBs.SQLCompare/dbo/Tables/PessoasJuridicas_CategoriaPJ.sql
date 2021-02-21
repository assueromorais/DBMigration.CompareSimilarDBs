CREATE TABLE [dbo].[PessoasJuridicas_CategoriaPJ] (
    [IdPessoaJuridicaCategoriaPJ]   INT          IDENTITY (1, 1) NOT NULL,
    [IdCategoriaPJ]                 INT          NULL,
    [IdTipoInscricao]               INT          NULL,
    [IdPessoaJuridica]              INT          NOT NULL,
    [RegistroConselho]              VARCHAR (20) NULL,
    [DataInicio]                    DATETIME     NULL,
    [DataFim]                       DATETIME     NULL,
    [IdMotivoInscricao]             INT          NULL,
    [DataUltimaAtualizacao]         DATETIME     NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60) NULL,
    [DataDeferimento]               DATETIME     NULL,
    [IdProcesso]                    INT          NULL,
    [Livro]                         VARCHAR (10) NULL,
    [Folha]                         VARCHAR (10) NULL,
    CONSTRAINT [PK_PessoasJuridicas_CategoriaPJ] PRIMARY KEY CLUSTERED ([IdPessoaJuridicaCategoriaPJ] ASC),
    CONSTRAINT [FK_PessoasJuridicas_CategoriaPJ_CategoriaPJ] FOREIGN KEY ([IdCategoriaPJ]) REFERENCES [dbo].[CategoriasPJ] ([IdCategoriaPJ]) NOT FOR REPLICATION,
    CONSTRAINT [FK_PessoasJuridicas_CategoriaPJ_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_PessoasJuridicas_CategoriaPJ_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [FK_PessoasJuridicas_CategoriaPJ_TiposInscricao] FOREIGN KEY ([IdTipoInscricao]) REFERENCES [dbo].[TiposInscricao] ([IdTipoInscricao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_PessoasJuridicasCategoria_MotivoInscricao] FOREIGN KEY ([IdMotivoInscricao]) REFERENCES [dbo].[MotivoInscricao] ([IdMotivoInscricao])
);


GO
/*
 * Oc 186066
 * Criado por Wesley
 * Adicionado por Leandro
 */
CREATE TRIGGER [dbo].[Trg_PessoasJuridicas_CategoriaPJ_Usuario] on [dbo].[PessoasJuridicas_CategoriaPJ] FOR INSERT, UPDATE
AS

DECLARE @IdPessoaJuridicaCategoriaPJ integer
DECLARE @Depto    varchar(60)

SELECT @IdPessoaJuridicaCategoriaPJ = IdPessoaJuridicaCategoriaPJ FROM INSERTED

if @IdPessoaJuridicaCategoriaPJ > 0
BEGIN
	SELECT @Depto = NomeDepto FROM Departamentos 
	                          INNER JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento 
	WHERE NomeUsuario = host_name()
	UPDATE PessoasJuridicas_CategoriaPJ SET DataUltimaAtualizacao = getdate(), 
	                                        UsuarioUltimaAtualizacao = host_name(), 
											DepartamentoUltimaAtualizacao = @Depto
	WHERE IdPessoaJuridicaCategoriaPJ = @IdPessoaJuridicaCategoriaPJ
END 
