CREATE TABLE [dbo].[Profissionais_SituacoesPF] (
    [IdProfissionalSituacaoPF]      INT          IDENTITY (1, 1) NOT NULL,
    [IdProfissional]                INT          NOT NULL,
    [IdSituacaoPFPJ]                INT          NOT NULL,
    [DataInicioSituacao]            DATETIME     NULL,
    [DataFimSituacao]               DATETIME     NULL,
    [DataValidade]                  DATETIME     NULL,
    [IdDetalheSituacao]             INT          NULL,
    [DataUltimaAtualizacao]         DATETIME     NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60) NULL,
    [NumeroPlenaria]                VARCHAR (15) NULL,
    [InseriuPorAndamento]           BIT          NULL,
    [InseriuAutomaticamente]        BIT          NULL,
    [Numero_Plenaria]               INT          NULL,
    CONSTRAINT [PK_ProfissionaisSituacoesPF] PRIMARY KEY CLUSTERED ([IdProfissionalSituacaoPF] ASC),
    CONSTRAINT [FK_Profissionais_SituacoesPF_DetalhesSituacao] FOREIGN KEY ([IdDetalheSituacao]) REFERENCES [dbo].[DetalhesSituacao] ([IdDetalheSituacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Profissionais_SituacoesPF_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_ProfissionaisSituacaoPF_SituacoesPFPJ] FOREIGN KEY ([IdSituacaoPFPJ]) REFERENCES [dbo].[SituacoesPFPJ] ([IdSituacaoPFPJ]) NOT FOR REPLICATION
);


GO



CREATE TRIGGER [dbo].[Trg_Profissionais_SituacoesPF_Usuario] ON [dbo].[Profissionais_SituacoesPF]
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
				JOIN Profissionais_SituacoesPF PS ON PS.IdProfissionalSituacaoPF = I.IdProfissionalSituacaoPF
		END
		
	SET NOCOUNT OFF
