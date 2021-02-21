CREATE TABLE [dbo].[PessoasJuridicas_SituacoesPFPJ] (
    [IdPessoaJuridica_SituacaoPFPJ] INT          IDENTITY (1, 1) NOT NULL,
    [IdSituacaoPFPJ]                INT          NOT NULL,
    [IdPessoaJuridica]              INT          NOT NULL,
    [DataInicioSituacao]            DATETIME     NULL,
    [DataFimSituacao]               DATETIME     NULL,
    [DataValidade]                  DATETIME     NULL,
    [IdDetalheSituacao]             INT          NULL,
    [DataUltimaAtualizacao]         DATETIME     NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60) NULL,
    [NumeroPlenaria]                VARCHAR (15) NULL,
    [Numero_Plenaria]               INT          NULL,
    CONSTRAINT [PK_PessoasJuridicas_SituacoesPFPJ] PRIMARY KEY CLUSTERED ([IdPessoaJuridica_SituacaoPFPJ] ASC),
    CONSTRAINT [FK_PessoasJuridicas_SituacoesPFPJ_DetalhesSituacao] FOREIGN KEY ([IdDetalheSituacao]) REFERENCES [dbo].[DetalhesSituacao] ([IdDetalheSituacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_PessoasJuridicas_SituacoesPFPJ_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_SituacoesPFPJ_PessoasJuridicas_SituacoesPFPJ] FOREIGN KEY ([IdSituacaoPFPJ]) REFERENCES [dbo].[SituacoesPFPJ] ([IdSituacaoPFPJ]) NOT FOR REPLICATION
);


GO
/*
 * Oc 186066
 * Criado por Wesley
 * Adicionado por Leandro
 */
 CREATE TRIGGER [dbo].[Trg_PessoasJuridicas_SituacoesPFPJ_Usuario] ON [dbo].[PessoasJuridicas_SituacoesPFPJ]
	FOR
		INSERT,
		UPDATE  
AS

	SET NOCOUNT ON
  
	IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
		BEGIN
			UPDATE
				PS
			SET
				PS.DataUltimaAtualizacao = GETDATE(),
				PS.UsuarioUltimaAtualizacao = ISNULL(I.UsuarioUltimaAtualizacao,HOST_NAME()),
				PS.DepartamentoUltimaAtualizacao = (SELECT TOP 1 DP.NomeDepto FROM Departamentos DP JOIN Usuarios US ON US.IdDepartamento = DP.IdDepto WHERE US.NomeUsuario = ISNULL(I.UsuarioUltimaAtualizacao,HOST_NAME()))
			FROM
				INSERTED I
				JOIN PessoasJuridicas_SituacoesPFPJ PS ON PS.IdPessoaJuridica_SituacaoPFPJ = I.IdPessoaJuridica_SituacaoPFPJ
		END
		
	SET NOCOUNT OFF
