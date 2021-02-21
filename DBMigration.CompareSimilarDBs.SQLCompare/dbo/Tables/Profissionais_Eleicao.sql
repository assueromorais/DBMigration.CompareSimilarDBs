CREATE TABLE [dbo].[Profissionais_Eleicao] (
    [IdProfissionalEleicao] INT          IDENTITY (1, 1) NOT NULL,
    [IdProfissional]        INT          NOT NULL,
    [IdEleicao]             INT          NOT NULL,
    [IdConselho]            INT          NOT NULL,
    [NumeroUrna]            VARCHAR (10) NULL,
    [NumeroLote]            VARCHAR (10) NULL,
    [DataRegistro]          DATETIME     NULL,
    [DataVotacao]           DATETIME     NULL,
    [ModoVotacao]           CHAR (1)     NULL,
    [Situacao]              CHAR (1)     NULL,
    [SequenciaLote]         INT          NULL,
    [CodigoBarras]          VARCHAR (16) NULL,
    [Justificativa]         TEXT         NULL,
    [Emitiu]                BIT          NULL,
    [DataEmissao]           DATETIME     NULL,
    [JustificativaAceita]   BIT          CONSTRAINT [DEF_JustificativaAceita] DEFAULT ((0)) NOT NULL,
    [IdDocumento]           INT          NULL,
    CONSTRAINT [PK_Profissionais_Eleicao] PRIMARY KEY CLUSTERED ([IdProfissionalEleicao] ASC),
    CONSTRAINT [FK_Profissionais_Eleicao_Eleicoes] FOREIGN KEY ([IdEleicao], [IdConselho]) REFERENCES [dbo].[Eleicoes] ([IdEleicao], [IdConselho]),
    CONSTRAINT [FK_Profissionais_Eleicao_IdDocumento] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]),
    CONSTRAINT [FK_Profissionais_Eleicao_Lotes] FOREIGN KEY ([IdEleicao], [NumeroLote]) REFERENCES [dbo].[Lotes] ([IdEleicao], [NumeroLote]),
    CONSTRAINT [FK_Profissionais_Eleicao_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_Profissionais_Eleicao_Urnas] FOREIGN KEY ([IdEleicao], [NumeroUrna]) REFERENCES [dbo].[Urnas] ([IdEleicao], [NumeroUrna])
);


GO
ALTER TABLE [dbo].[Profissionais_Eleicao] NOCHECK CONSTRAINT [FK_Profissionais_Eleicao_Profissionais];

