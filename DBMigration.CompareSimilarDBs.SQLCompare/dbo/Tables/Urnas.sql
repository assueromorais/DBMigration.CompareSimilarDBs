CREATE TABLE [dbo].[Urnas] (
    [IdEleicao]          INT          NOT NULL,
    [NumeroUrna]         VARCHAR (10) NOT NULL,
    [QuantVotosPrevista] INT          NULL,
    [ModoVotacao]        CHAR (1)     NULL,
    [Localizacao]        TEXT         NULL,
    [Observacoes]        TEXT         NULL,
    CONSTRAINT [PK_Urnas] PRIMARY KEY CLUSTERED ([IdEleicao] ASC, [NumeroUrna] ASC)
);

