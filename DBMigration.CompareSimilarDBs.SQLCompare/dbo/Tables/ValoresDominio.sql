CREATE TABLE [dbo].[ValoresDominio] (
    [IdDominio]     INT           IDENTITY (1, 1) NOT NULL,
    [IdCampoTabela] INT           NOT NULL,
    [ValorDominio]  VARCHAR (100) NOT NULL,
    [CodigoDominio] VARCHAR (100) NOT NULL,
    CONSTRAINT [Pk_ValoresDominio] PRIMARY KEY CLUSTERED ([IdDominio] ASC),
    CONSTRAINT [FK_002] FOREIGN KEY ([IdCampoTabela]) REFERENCES [dbo].[CamposTabelaPadronizacao] ([IdCampoTabela]) ON DELETE CASCADE ON UPDATE CASCADE
);

