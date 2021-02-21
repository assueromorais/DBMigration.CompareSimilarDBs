CREATE TABLE [dbo].[Profissionais] (
    [IdProfissional]              INT            IDENTITY (1, 1) NOT NULL,
    [IdUnidadeConselho]           INT            NULL,
    [IdSubRegiao]                 INT            NULL,
    [IdTipoInscricao]             INT            NULL,
    [IdReligiao]                  INT            NULL,
    [IdCidadeNaturalidade]        INT            NULL,
    [IdNacionalidade]             INT            NULL,
    [CategoriaAtual]              VARCHAR (40)   NULL,
    [SituacaoAtual]               VARCHAR (50)   NULL,
    [Nome]                        VARCHAR (100)  NULL,
    [RegistroConselhoAtual]       VARCHAR (20)   NULL,
    [NomeBairro]                  VARCHAR (50)   NULL,
    [NomeCidade]                  VARCHAR (30)   NULL,
    [SiglaUF]                     VARCHAR (2)    NULL,
    [SiglaUFNaturalidade]         CHAR (2)       NULL,
    [Endereco]                    VARCHAR (60)   NULL,
    [CEP]                         VARCHAR (8)    NULL,
    [E_Exterior]                  BIT            NULL,
    [E_Residencial]               INT            NULL,
    [Atualizado]                  BIT            NULL,
    [DataInscricaoConselho]       DATETIME       NULL,
    [DataUltimaAtualizacao]       DATETIME       NULL,
    [Sexo]                        VARCHAR (1)    NULL,
    [DataNascimento]              DATETIME       NULL,
    [TipoSanguineo]               VARCHAR (3)    NULL,
    [CPF]                         VARCHAR (11)   NULL,
    [CTPS]                        VARCHAR (10)   NULL,
    [SerieCTPS]                   VARCHAR (5)    NULL,
    [RG]                          VARCHAR (15)   NULL,
    [RGDataEmissao]               DATETIME       NULL,
    [RGOrgaoEmissao]              VARCHAR (20)   NULL,
    [SiglaUFRG]                   CHAR (2)       NULL,
    [TipoCarteiraIdentidade]      VARCHAR (1)    NULL,
    [CertificadoReserv]           VARCHAR (15)   NULL,
    [CertificadoReservCSM]        VARCHAR (11)   NULL,
    [CertificadoReservData]       DATETIME       NULL,
    [Civil_Militar]               VARCHAR (1)    NULL,
    [TituloEleitorInscricao]      VARCHAR (13)   NULL,
    [TituloEleitorZona]           VARCHAR (3)    NULL,
    [TituloEleitorSecao]          VARCHAR (4)    NULL,
    [TituloEleitorDataEmissao]    DATETIME       NULL,
    [NomeCidadeTitEleitor]        VARCHAR (30)   NULL,
    [SiglaUFTituloEleitor]        CHAR (2)       NULL,
    [NomePai]                     VARCHAR (50)   NULL,
    [NomeMae]                     VARCHAR (50)   NULL,
    [Fotografia]                  BIT            NULL,
    [Raca]                        VARCHAR (1)    NULL,
    [EstadoCivil]                 VARCHAR (1)    NULL,
    [EnderecoEMail]               VARCHAR (90)   NULL,
    [TelefoneResid]               VARCHAR (100)  NULL,
    [TelefoneTrab]                VARCHAR (100)  NULL,
    [Processo]                    VARCHAR (15)   NULL,
    [E_Fiscal]                    BIT            NULL,
    [ExibirDadosWeb]              BIT            NULL,
    [Observacoes]                 TEXT           NULL,
    [EnderecoEMail2]              VARCHAR (90)   NULL,
    [Site]                        VARCHAR (300)  NULL,
    [Site2]                       VARCHAR (300)  NULL,
    [RNE]                         VARCHAR (20)   NULL,
    [NomeConjuge]                 VARCHAR (50)   NULL,
    [CaixaPostal]                 VARCHAR (15)   NULL,
    [IndicativoProf1]             BIT            NULL,
    [IndicativoProf2]             BIT            NULL,
    [IndicativoProf3]             BIT            NULL,
    [AtualizacaoWeb]              VARCHAR (8000) NULL,
    [DoadorOrgaos]                BIT            NULL,
    [IdProfissionalOld]           INT            NULL,
    [DataInclusaoEmail]           DATETIME       NULL,
    [Livro]                       VARCHAR (10)   NULL,
    [Folha]                       VARCHAR (10)   NULL,
    [AlfaOutros1]                 VARCHAR (80)   NULL,
    [TelefoneCelular]             VARCHAR (100)  NULL,
    [TelefoneOutros]              VARCHAR (100)  NULL,
    [CodigoBarras]                VARCHAR (16)   NULL,
    [IdTabela1Prof]               INT            NULL,
    [idTabela1Profission]         INT            NULL,
    [IndicativoProf4]             BIT            NULL,
    [IndicativoProf5]             BIT            NULL,
    [IndicativoProf6]             BIT            NULL,
    [Data1prof]                   DATETIME       NULL,
    [Data2Prof]                   DATETIME       NULL,
    [IdDetalhePessoa1]            INT            NULL,
    [IdDetalhePessoa2]            INT            NULL,
    [IdDetalhePessoa3]            INT            NULL,
    [IdDetalhePessoa4]            INT            NULL,
    [IdDetalhePessoa5]            INT            NULL,
    [SiteDivulgacao]              BIT            NULL,
    [Site2Divulgacao]             BIT            NULL,
    [EmailDivulgacao]             BIT            NULL,
    [Email2Divulgacao]            BIT            NULL,
    [TelResidDivulgacao]          BIT            NULL,
    [TelCelDivulgacao]            BIT            NULL,
    [TelTrabDivulgacao]           BIT            NULL,
    [TelRecadoFaxDivulgacao]      BIT            NULL,
    [data3Prof]                   DATETIME       NULL,
    [data4Prof]                   DATETIME       NULL,
    [Deficiente]                  BIT            NULL,
    [IdDeficiencia]               INT            NULL,
    [AlfaOutros2]                 VARCHAR (80)   NULL,
    [AlfaOutros3]                 VARCHAR (80)   NULL,
    [AlfaOutros4]                 VARCHAR (80)   NULL,
    [Deficiencia]                 VARCHAR (100)  NULL,
    [data5Prof]                   DATETIME       NULL,
    [data6Prof]                   DATETIME       NULL,
    [Alfa1Prof]                   VARCHAR (80)   NULL,
    [AgenciaDebitoConta]          VARCHAR (5)    NULL,
    [ContaDebitoConta]            VARCHAR (15)   NULL,
    [E_Relator]                   BIT            NULL,
    [E_Instrutor]                 BIT            NULL,
    [DataUltExportacao]           DATETIME       NULL,
    [DataCompromisso]             DATETIME       NULL,
    [NumeroSeguranca]             INT            NULL,
    [IdBancoDebitoConta]          INT            NULL,
    [Codigo]                      VARCHAR (10)   NULL,
    [Classe]                      VARCHAR (1)    NULL,
    [NomeUsuario]                 VARCHAR (30)   NULL,
    [DepartamentoUsuario]         VARCHAR (60)   NULL,
    [DtUltimaAtualizacaoContato]  DATETIME       NULL,
    [UsuUltimaAtualizacaoContato] VARCHAR (150)  NULL,
    [DepUltimaAtualizacaoContato] VARCHAR (60)   NULL,
    [AssinaDocumentos]            BIT            NULL,
    [NomeAbreviadoCarteiraEst]    VARCHAR (100)  NULL,
    [NomeMaeAbreviadoCarteiraEst] VARCHAR (50)   NULL,
    [NomePaiAbreviadoCarteiraEst] VARCHAR (50)   NULL,
    [IdPaisEndereco]              INT            NULL,
    [ComplementoEndereco]         TEXT           NULL,
    [DataAlteracaoArqTJ]          DATETIME       NULL,
    [IdRegiaoAdministrativa]      INT            NULL,
    [IdOrigemInscricao]           INT            NULL,
    [IdUsuarioCriacao]            INT            NULL,
    [IdDepartamentoCriacao]       INT            NULL,
    [IdDelegaciaCriacao]          INT            NULL,
    [NomeSocial]                  VARCHAR (50)   NULL,
    [CertificadoReservOrgao]      VARCHAR (30)   NULL,
    [AnuidadeDiferenciada]        BIT            DEFAULT ((0)) NOT NULL,
    [TelefoneTrabCelular]         VARCHAR (100)  NULL,
    [CNABloquearEnvio]            BIT            CONSTRAINT [DEF_Profissionais_CNABloquearEnvio] DEFAULT ((0)) NOT NULL,
    [CorrespondenciaEmail]        BIT            CONSTRAINT [DEF_Profissionais_CorrespondenciaEmail] DEFAULT ((0)) NOT NULL,
    [TelCelTrabDivulgacao]        BIT            NULL,
    [TelTrabOutrosDivulgacao]     BIT            NULL,
    [RedesSociais]                VARCHAR (1000) NULL,
    [DataPedidoInscricao]         DATETIME       NULL,
    [idSiscafWeb]                 INT            NULL,
    [suspenso]                    BIT            CONSTRAINT [DF__Profissio__suspe__5B36CED5] DEFAULT ((0)) NOT NULL,
    [E_Divulgacao]                BIT            NULL,
    [NaoPossuiMaeRG]              BIT            CONSTRAINT [DF_Profissionais_NaoPossuiMaeRG] DEFAULT ((0)) NOT NULL,
    [NaoPossuiPaiRG]              BIT            CONSTRAINT [DF_Profissionais_NaoPossuiPaiRG] DEFAULT ((0)) NOT NULL,
    [ExportacaoArquivoXMLCONFEN]  BIT            CONSTRAINT [DEF_ProfissionaisExportacaoArquivoXMLCONFEN] DEFAULT ((0)) NOT NULL,
    [DtUltimaAtualizacaoWeb]      DATETIME       NULL,
    [UsrUltimaAtualizacaoWeb]     VARCHAR (150)  NULL,
    [IdentGenero]                 INT            NULL,
    [DescIdentGenero]             VARCHAR (30)   NULL,
    CONSTRAINT [PK_Profissionais] PRIMARY KEY NONCLUSTERED ([IdProfissional] ASC),
    CONSTRAINT [FK_Profissionais_BancosSiscafw] FOREIGN KEY ([IdBancoDebitoConta]) REFERENCES [dbo].[BancosSiscafw] ([IdBancoSiscafw]),
    CONSTRAINT [FK_Profissionais_Cidades] FOREIGN KEY ([IdCidadeNaturalidade]) REFERENCES [dbo].[Cidades] ([IdCidade]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Profissionais_Deficiencia] FOREIGN KEY ([IdDeficiencia]) REFERENCES [dbo].[Deficiencia] ([IdDeficiencia]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Profissionais_Departamentos] FOREIGN KEY ([IdDepartamentoCriacao]) REFERENCES [dbo].[Departamentos] ([IdDepto]),
    CONSTRAINT [FK_Profissionais_DetalhesPessoas1] FOREIGN KEY ([IdDetalhePessoa1]) REFERENCES [dbo].[DetalhesPessoas1] ([IdDetalhePessoa1]),
    CONSTRAINT [FK_Profissionais_DetalhesPessoas2] FOREIGN KEY ([IdDetalhePessoa2]) REFERENCES [dbo].[DetalhesPessoas2] ([IdDetalhePessoa2]),
    CONSTRAINT [FK_Profissionais_DetalhesPessoas3] FOREIGN KEY ([IdDetalhePessoa3]) REFERENCES [dbo].[DetalhesPessoas3] ([IdDetalhePessoa3]),
    CONSTRAINT [FK_Profissionais_DetalhesPessoas4] FOREIGN KEY ([IdDetalhePessoa4]) REFERENCES [dbo].[DetalhesPessoas4] ([IdDetalhePessoa4]),
    CONSTRAINT [FK_Profissionais_DetalhesPessoas5] FOREIGN KEY ([IdDetalhePessoa5]) REFERENCES [dbo].[DetalhesPessoas5] ([IdDetalhePessoa5]),
    CONSTRAINT [FK_Profissionais_Nacionalidades] FOREIGN KEY ([IdNacionalidade]) REFERENCES [dbo].[Nacionalidades] ([IdNacionalidade]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Profissionais_OrigensInscricao] FOREIGN KEY ([IdOrigemInscricao]) REFERENCES [dbo].[OrigensInscricao] ([IdOrigemInscricao]),
    CONSTRAINT [FK_Profissionais_Pessoas_SubRegiao] FOREIGN KEY ([IdSubRegiao]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Profissionais_Pessoas_UnidadeConselho] FOREIGN KEY ([IdUnidadeConselho]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Profissionais_PessoasDelegacia] FOREIGN KEY ([IdDelegaciaCriacao]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_Profissionais_ProfissionaisTabela1] FOREIGN KEY ([idTabela1Profission]) REFERENCES [dbo].[ProfissionaisTabela1] ([idTabela1Profission]),
    CONSTRAINT [FK_Profissionais_RegioesAdministrativas] FOREIGN KEY ([IdRegiaoAdministrativa]) REFERENCES [dbo].[RegioesAdministrativas] ([IdRegiaoAdministrativa]),
    CONSTRAINT [FK_Profissionais_Religioes] FOREIGN KEY ([IdReligiao]) REFERENCES [dbo].[Religioes] ([idReligiao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Profissionais_TiposInscricao] FOREIGN KEY ([IdTipoInscricao]) REFERENCES [dbo].[TiposInscricao] ([IdTipoInscricao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Profissionais_Usuarios] FOREIGN KEY ([IdUsuarioCriacao]) REFERENCES [dbo].[Usuarios] ([IdUsuario]),
    CONSTRAINT [FK_ProfissionaisPais_Nacionalidades] FOREIGN KEY ([IdPaisEndereco]) REFERENCES [dbo].[Nacionalidades] ([IdNacionalidade])
);


GO
CREATE NONCLUSTERED INDEX [IX_ProfissiCPF]
    ON [dbo].[Profissionais]([CPF] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ProfissionaisNome]
    ON [dbo].[Profissionais]([Nome] ASC);


GO
/*Ocorr. 54381 - Diego*/ 

CREATE TRIGGER [dbo].[Trg_Profissionais_ArqTJ] ON [dbo].[Profissionais]
FOR INSERT, UPDATE, DELETE
AS
	BEGIN
		SET NOCOUNT ON

		IF	EXISTS (SELECT TOP 1 1 FROM INSERTED) OR
			EXISTS (SELECT TOP 1 1 FROM DELETED)
			BEGIN
				SET CONCAT_NULL_YIELDS_NULL ON
				
				UPDATE
					P
				SET
					DataAlteracaoArqTJ = GETDATE()
				FROM
					Profissionais P
				WHERE
					P.IdProfissional IN (
						SELECT
							I.IdProfissional
						FROM
							INSERTED I
							LEFT JOIN DELETED D ON I.IdProfissional = D.IdProfissional
						WHERE
							ISNULL(I.RegistroConselhoAtual, '')		<> ISNULL(D.RegistroConselhoAtual, '') OR
							ISNULL(I.Nome, '')						<> ISNULL(D.Nome, '') OR
							ISNULL(I.SituacaoAtual, '')				<> ISNULL(D.SituacaoAtual, '') OR
							ISNULL(I.CPF, '')						<> ISNULL(D.CPF, '') OR
							ISNULL(I.RG, '')						<> ISNULL(D.RG, '') OR
							ISNULL(I.Sexo, '')						<> ISNULL(D.Sexo, '') OR
							ISNULL(I.DataNascimento, '')			<> ISNULL(D.DataNascimento, '') OR
							ISNULL(I.Endereco, '')					<> ISNULL(D.Endereco, '') OR
							ISNULL(I.NomeBairro, '')				<> ISNULL(D.NomeBairro, '') OR
							ISNULL(I.NomeCidade, '')				<> ISNULL(D.NomeCidade, '') OR
							ISNULL(I.CEP, '')						<> ISNULL(D.CEP, '') OR
							ISNULL(I.TelefoneTrab, '')				<> ISNULL(D.TelefoneTrab, '') OR
							ISNULL(I.TelefoneCelular, '')			<> ISNULL(D.TelefoneCelular, '') OR
							ISNULL(I.EnderecoEMail, '')				<> ISNULL(D.EnderecoEMail, '')
					)
					
				SET CONCAT_NULL_YIELDS_NULL OFF
			END
	
		SET NOCOUNT OFF
		
	END

GO
CREATE TRIGGER [dbo].[Trg_Profissionais_CadNacional] ON [dbo].[Profissionais] FOR UPDATE
	AS
	
	DECLARE @IdProfissional INTEGER
	DECLARE @Count          INTEGER

	SELECT	@Count = COUNT(*) 
	FROM	DELETED D, 
			INSERTED I 
	WHERE	D.IDPROFISSIONAL = I.IDPROFISSIONAL
  
	IF @Count = 1
	BEGIN 
		SELECT  @IdProfissional = IdProfissional FROM INSERTED
			IF (@IdProfissional > 0) AND NOT UPDATE(DataUltExportacao)  
				UPDATE Profissionais 
				SET    DataUltExportacao = NULL
				WHERE  IdProfissional = @IdProfissional
	END






