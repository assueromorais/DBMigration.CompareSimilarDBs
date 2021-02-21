CREATE TABLE [dbo].[TelasParametros] (
    [CodigoTela]          INT       NOT NULL,
    [NomeTabela]          CHAR (25) NOT NULL,
    [NomeCampo]           CHAR (20) NOT NULL,
    [TipoCampo]           CHAR (1)  NOT NULL,
    [EmUso]               BIT       NULL,
    [DisposicaoConsultas] INT       NULL,
    [IdTipoProcesso]      INT       CONSTRAINT [DF_TelasParametros_IdTipoProcesso] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_TelasParametros] PRIMARY KEY CLUSTERED ([CodigoTela] ASC, [NomeTabela] ASC, [NomeCampo] ASC, [IdTipoProcesso] ASC)
);

