CREATE TABLE [dbo].[SetoresTramitacaoPCS] (
    [IdSetoresTramitacaoPCS] INT          IDENTITY (1, 1) NOT NULL,
    [SetoresTramitacaoPCS]   VARCHAR (40) NOT NULL,
    [Desativado]             BIT          CONSTRAINT [DF_SetoresTramitacaoPCSDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SetoresTramitacaoPCS] PRIMARY KEY CLUSTERED ([IdSetoresTramitacaoPCS] ASC)
);

