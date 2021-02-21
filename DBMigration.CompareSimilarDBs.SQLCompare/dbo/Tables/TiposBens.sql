CREATE TABLE [dbo].[TiposBens] (
    [IdTipo]                          INT              IDENTITY (1, 1) NOT NULL,
    [Tipo]                            VARCHAR (30)     NOT NULL,
    [ItemMovel]                       BIT              NOT NULL,
    [PrefixoBem]                      VARCHAR (20)     NULL,
    [SufixoBem]                       VARCHAR (20)     NULL,
    [IncrementoBem]                   INT              NULL,
    [CampoObrigatorio]                TEXT             NULL,
    [SofreDepreciacao]                BIT              NULL,
    [PercentValResidual]              FLOAT (53)       NULL,
    [VidaUtil]                        INT              NULL,
    [HistoricoDepreciacao]            TEXT             NULL,
    [IdPlanoContaMCASP]               UNIQUEIDENTIFIER NULL,
    [IdPlanoContaMCASPDepreciacaoAcu] UNIQUEIDENTIFIER NULL,
    [IdPlanoContaMCASPDepreciacao]    UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_TiposBens] PRIMARY KEY NONCLUSTERED ([IdTipo] ASC)
);

