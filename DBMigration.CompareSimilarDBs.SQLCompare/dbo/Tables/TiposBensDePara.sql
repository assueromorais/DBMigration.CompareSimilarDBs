CREATE TABLE [dbo].[TiposBensDePara] (
    [IdTipoBemDepara] INT              IDENTITY (1, 1) NOT NULL,
    [IdTipoBem]       INT              NOT NULL,
    [IdConta]         INT              NOT NULL,
    [IdContaMCASP]    UNIQUEIDENTIFIER NULL,
    [NomeContaMCASP]  VARCHAR (50)     NULL,
    [CodContaMCASP]   VARCHAR (27)     NULL
);

