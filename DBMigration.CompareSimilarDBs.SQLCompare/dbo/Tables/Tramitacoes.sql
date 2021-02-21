CREATE TABLE [dbo].[Tramitacoes] (
    [IdTramitacao]                  INT          IDENTITY (1, 1) NOT NULL,
    [IdProcesso]                    INT          NULL,
    [IdFiscalizacao]                INT          NULL,
    [IdDocumento]                   INT          NULL,
    [IdSituacaoTramitacao]          INT          NULL,
    [IdLocalTramitacao]             INT          NULL,
    [NumeProcExterno]               VARCHAR (15) NULL,
    [DataPrevisao]                  DATETIME     NULL,
    [DataEntrada]                   DATETIME     NULL,
    [DataSaida]                     DATETIME     NULL,
    [Andamento]                     TEXT         NULL,
    [Pendencias]                    TEXT         NULL,
    [ProtocoloDoc]                  VARCHAR (20) NULL,
    [IdUsuario]                     INT          NULL,
    [PessoaTramitacao]              VARCHAR (60) NULL,
    [Recebido]                      BIT          NULL,
    [IndLocal]                      CHAR (1)     NULL,
    [IdUsuarioCriacao]              INT          NULL,
    [DataEnvio]                     DATETIME     NULL,
    [Prioridade]                    INT          NULL,
    [IdUsuarioRecebeu]              INT          NULL,
    [IdDepartamento]                INT          NULL,
    [IdDepartamentoRecebeu]         INT          NULL,
    [IdDepartamentoCriacao]         INT          NULL,
    [IdUnidade]                     INT          NULL,
    [IdLoteTramitacao]              INT          NULL,
    [TramitacaoLote]                BIT          NULL,
    [IdLocalizador]                 INT          NULL,
    [MensagemLida]                  BIT          NULL,
    [DataLeitura]                   DATETIME     NULL,
    [DataUltimaAtualizacao]         DATETIME     NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60) NULL,
    [DtLeituraMsgUsrCriacao]        DATETIME     NULL,
    [DtLeituraMsgUsrResponsavel]    DATETIME     NULL,
    CONSTRAINT [PK_AcomProcesso] PRIMARY KEY NONCLUSTERED ([IdTramitacao] ASC),
    CONSTRAINT [FK_TRAMITACOES_Departamentos] FOREIGN KEY ([IdDepartamento]) REFERENCES [dbo].[Departamentos] ([IdDepto]),
    CONSTRAINT [FK_TRAMITACOES_DepartamentosCriacao] FOREIGN KEY ([IdDepartamentoCriacao]) REFERENCES [dbo].[Departamentos] ([IdDepto]),
    CONSTRAINT [FK_TRAMITACOES_DepartamentosRecebeu] FOREIGN KEY ([IdDepartamentoRecebeu]) REFERENCES [dbo].[Departamentos] ([IdDepto]),
    CONSTRAINT [FK_Tramitacoes_DocumentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Tramitacoes_Fiscalizacoes] FOREIGN KEY ([IdFiscalizacao]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Tramitacoes_LocaisTramitacao] FOREIGN KEY ([IdLocalTramitacao]) REFERENCES [dbo].[LocaisTramitacao] ([IdLocalTramitacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Tramitacoes_LocalizadorTramitacao] FOREIGN KEY ([IdLocalizador]) REFERENCES [dbo].[LocalizadorTramitacao] ([IdLocalizador]),
    CONSTRAINT [FK_Tramitacoes_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Tramitacoes_SituacoesTramitacao] FOREIGN KEY ([IdSituacaoTramitacao]) REFERENCES [dbo].[SituacoesTramitacao] ([IdSituacaoTramitacao]),
    CONSTRAINT [FK_Tramitacoes_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario]),
    CONSTRAINT [FK_Tramitacoes_Usuarios_IdUsuarioRecebeu] FOREIGN KEY ([IdUsuarioRecebeu]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Tramitacoes_UsuariosCriacao] FOREIGN KEY ([IdUsuarioCriacao]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
CREATE CLUSTERED INDEX [IX_Tramitacoes]
    ON [dbo].[Tramitacoes]([IdTramitacao] ASC);


GO
CREATE NONCLUSTERED INDEX [Ix_IdLoteTramitacao]
    ON [dbo].[Tramitacoes]([IdLoteTramitacao] ASC);


GO
/*Ocorr. 57841 - Seila*/

CREATE TRIGGER [dbo].[Trg_Tramitacoes_Usuario] ON [dbo].[Tramitacoes] 
	FOR INSERT,
		UPDATE
AS
SET NOCOUNT ON
IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
	BEGIN		
		UPDATE
			T	
		SET
			T.DataUltimaAtualizacao = GETDATE(),
			T.UsuarioUltimaAtualizacao = HOST_NAME(),
			T.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			INSERTED I
			JOIN Tramitacoes T ON T.IdTramitacao = I.IdTramitacao
	END
SET NOCOUNT OFF
