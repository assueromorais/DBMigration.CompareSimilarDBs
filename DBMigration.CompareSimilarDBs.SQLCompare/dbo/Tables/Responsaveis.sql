CREATE TABLE [dbo].[Responsaveis] (
    [IdResponsavel]      INT          IDENTITY (1, 1) NOT NULL,
    [NomeResponsavel]    VARCHAR (60) NOT NULL,
    [IdUnidade]          INT          NOT NULL,
    [Telefone]           VARCHAR (30) NULL,
    [Email]              VARCHAR (50) NULL,
    [IdCargo]            INT          NULL,
    [Desativado]         BIT          CONSTRAINT [DF__Responsav__Desat__3DDED96D] DEFAULT ((0)) NULL,
    [IdNivelAutorizacao] INT          NULL,
    CONSTRAINT [PK_Responsaveis] PRIMARY KEY NONCLUSTERED ([IdResponsavel] ASC),
    CONSTRAINT [FK_Responsaveis_NiveisAutorizacao] FOREIGN KEY ([IdNivelAutorizacao]) REFERENCES [dbo].[NiveisAutorizacao] ([IdNivelAutorizacao]),
    CONSTRAINT [FK_Responsaveis_Unidades1] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);

