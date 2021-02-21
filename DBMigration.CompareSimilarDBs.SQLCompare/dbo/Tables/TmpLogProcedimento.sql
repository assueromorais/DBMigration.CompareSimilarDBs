CREATE TABLE [dbo].[TmpLogProcedimento] (
    [id]           INT          IDENTITY (1, 1) NOT NULL,
    [IdLog]        INT          NULL,
    [Procedimento] VARCHAR (60) NULL,
    [Inicio]       DATETIME     NULL,
    [Final]        DATETIME     NULL,
    [Obs]          TEXT         NULL,
    [TEXTO]        TEXT         NULL
);

