CREATE TABLE [dbo].[Processo_Fases] (
    [IdProcessoFases]       INT          IDENTITY (1, 1) NOT NULL,
    [IdFase]                INT          NOT NULL,
    [IdProfissional]        INT          NULL,
    [IdProcesso]            INT          NULL,
    [DataRef]               DATETIME     NULL,
    [DataFase]              DATETIME     NULL,
    [Nota]                  TEXT         NULL,
    [IdPena]                INT          NULL,
    [DataInicio]            DATETIME     NULL,
    [DataFim]               DATETIME     NULL,
    [Deferido]              INT          NULL,
    [IdUsuarioCriacao]      INT          NULL,
    [IdDepartamentoCriacao] INT          NULL,
    [IdFiscalizacao]        INT          NULL,
    [IdPessoaJuridica]      INT          NULL,
    [IdPessoa]              INT          NULL,
    [NumeroPlenaria]        VARCHAR (15) NULL,
    [IdAutoInfracao]        INT          NULL,
    [MotivoAndamento]       INT          NULL,
    [IdRespCorrespPessoa]   INT          NULL,
    [IdRespCorrespPF]       INT          NULL,
    [IdRespCorrespPJ]       INT          NULL,
    [IdTramitacao]          INT          NULL,
    [Numero_Plenaria]       INT          NULL,
    [DataPlenaria]          DATETIME     NULL,
    [VisualizarWeb]         BIT          NULL,
    [VisualizarNotaWeb]     BIT          NULL,
    [QtdDiasBloqueio]       INT          NULL,
    [IdProfissionalRelator] INT          NULL,
    [IdMotivoAndamento]     INT          NULL,
    [DataInfracao]          DATETIME     NULL,
    [NumeroInfracao]        VARCHAR (15) NULL,
    [Codigo]                VARCHAR (10) NULL,
    [DescricaoInfracao]     VARCHAR (80) NULL,
    [ValorInfracao]         MONEY        NULL,
    [Nota1]                 TEXT         NULL,
    [Nota2]                 TEXT         NULL,
    CONSTRAINT [PK_Processo_Fases] PRIMARY KEY CLUSTERED ([IdProcessoFases] ASC),
    CONSTRAINT [FK_AutosInfracao] FOREIGN KEY ([IdAutoInfracao]) REFERENCES [dbo].[AutosInfracao] ([IdAutoInfracao]),
    CONSTRAINT [FK_Fases_Processo_Fases] FOREIGN KEY ([IdFase]) REFERENCES [dbo].[Fases] ([IdFase]),
    CONSTRAINT [FK_IdRespCorrespPessoa] FOREIGN KEY ([IdRespCorrespPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_IdRespCorrespPF] FOREIGN KEY ([IdRespCorrespPF]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_IdRespCorrespPJ] FOREIGN KEY ([IdRespCorrespPJ]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_IdTramitacao_Processo_Fases_Tramitacoes] FOREIGN KEY ([IdTramitacao]) REFERENCES [dbo].[Tramitacoes] ([IdTramitacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Processo_Fases_Fiscalizacoes] FOREIGN KEY ([IdFiscalizacao]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao]),
    CONSTRAINT [FK_Processo_Fases_Pena] FOREIGN KEY ([IdPena]) REFERENCES [dbo].[Penas] ([IdPena]),
    CONSTRAINT [FK_Processo_Fases_Usuario] FOREIGN KEY ([IdUsuarioCriacao]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Processo_Processo_Fases] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [FK_Profissionais_Processo_Fases] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
ALTER TABLE [dbo].[Processo_Fases] NOCHECK CONSTRAINT [FK_IdTramitacao_Processo_Fases_Tramitacoes];


GO
ALTER TABLE [dbo].[Processo_Fases] NOCHECK CONSTRAINT [FK_Processo_Fases_Usuario];


GO
CREATE NONCLUSTERED INDEX [IndIdProcesso]
    ON [dbo].[Processo_Fases]([IdProcesso] ASC);


GO
/*Ocorr. 57841 - Seila*/

CREATE TRIGGER [dbo].[Trg_Processo_Fases_Usuario] ON [dbo].[Processo_Fases] 
	FOR INSERT,
		UPDATE,
		DELETE
AS
SET NOCOUNT ON
IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
	BEGIN		
		UPDATE
			F	
		SET
			F.DataUltimaAtualizacao = GETDATE(),
			F.UsuarioUltimaAtualizacao = HOST_NAME(),
			F.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			INSERTED I
			JOIN Fiscalizacoes F ON F.IdFiscalizacao = I.IdFiscalizacao			
	END
ELSE IF EXISTS (SELECT TOP 1 1 FROM DELETED)
	BEGIN		
		UPDATE
			F	
		SET
			F.DataUltimaAtualizacao = GETDATE(),
			F.UsuarioUltimaAtualizacao = HOST_NAME(),
			F.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			DELETED D
			JOIN Fiscalizacoes F ON F.IdFiscalizacao = D.IdFiscalizacao			
	END	 
SET NOCOUNT OFF
