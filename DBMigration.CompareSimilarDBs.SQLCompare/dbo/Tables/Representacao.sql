CREATE TABLE [dbo].[Representacao] (
    [IdRepresentacao]     INT            IDENTITY (1, 1) NOT NULL,
    [IdTipoRepresentacao] INT            NULL,
    [IdUnidade]           INT            NULL,
    [Nome]                NVARCHAR (150) NULL,
    [CNPJ]                NVARCHAR (14)  NULL,
    [NumDecisao]          NVARCHAR (15)  NULL,
    [CEP]                 NVARCHAR (9)   NULL,
    [Endereco]            NVARCHAR (60)  NULL,
    [NomeBairro]          NVARCHAR (40)  NULL,
    [NomeCidade]          NVARCHAR (40)  NULL,
    [SiglaUF]             NVARCHAR (2)   NULL,
    [Contato]             NVARCHAR (120) NULL,
    [Site]                NVARCHAR (250) NULL,
    [Email]               NVARCHAR (60)  NULL,
    [Telefone1]           NVARCHAR (20)  NULL,
    [Telefone2]           NVARCHAR (20)  NULL,
    [Responsavel]         VARCHAR (60)   NULL,
    [Cargo]               INT            NULL,
    CONSTRAINT [PK_Representacao] PRIMARY KEY CLUSTERED ([IdRepresentacao] ASC),
    CONSTRAINT [FK_Representacao_TipoRepresentacao] FOREIGN KEY ([IdTipoRepresentacao]) REFERENCES [dbo].[TipoRepresentacao] ([IdTipoRepresentacao]),
    CONSTRAINT [FK_Representacao_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);

