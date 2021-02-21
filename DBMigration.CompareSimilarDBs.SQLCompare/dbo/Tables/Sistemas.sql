CREATE TABLE [dbo].[Sistemas] (
    [IdSistema]       INT          IDENTITY (1, 1) NOT NULL,
    [NomeSistema]     VARCHAR (15) NOT NULL,
    [DataLimite]      VARCHAR (20) NULL,
    [DataAcesso]      VARCHAR (20) NULL,
    [Acesso]          VARCHAR (20) NULL,
    [Licencas]        VARCHAR (20) NOT NULL,
    [VersaoAtual]     VARCHAR (20) NULL,
    [IdVersaoSistema] VARCHAR (20) NULL,
    CONSTRAINT [PK_Sistemas] PRIMARY KEY NONCLUSTERED ([IdSistema] ASC)
);

