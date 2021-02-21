CREATE TABLE [dbo].[TiposSuspensao] (
    [IdTipoSuspensao] INT          IDENTITY (1, 1) NOT NULL,
    [TipoSuspensao]   VARCHAR (60) NOT NULL,
    [Desativado]      BIT          CONSTRAINT [DF_TiposSuspensao_Desativado] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_TiposSuspensao] PRIMARY KEY CLUSTERED ([IdTipoSuspensao] ASC)
);

