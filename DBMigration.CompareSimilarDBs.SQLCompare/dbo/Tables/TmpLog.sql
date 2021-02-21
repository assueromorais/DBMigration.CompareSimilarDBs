CREATE TABLE [dbo].[TmpLog] (
    [idLog]        INT          IDENTITY (1, 1) NOT NULL,
    [Procedimento] VARCHAR (60) NULL,
    [Inicio]       DATETIME     NULL,
    [Final]        DATETIME     NULL,
    [Usuario]      VARCHAR (60) NULL,
    [Obs]          TEXT         NULL
);

