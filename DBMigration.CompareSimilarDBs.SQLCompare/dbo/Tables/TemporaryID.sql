CREATE TABLE [dbo].[TemporaryID] (
    [Chave]     UNIQUEIDENTIFIER NOT NULL,
    [ID]        INT              NOT NULL,
    [IDPessoa]  INT              NULL,
    [Status]    TINYINT          CONSTRAINT [DF_TemporaryID_Status] DEFAULT ((0)) NULL,
    [Validacao] CHAR (5)         CONSTRAINT [DF_TemporaryID_Validacao] DEFAULT ('00000') NULL,
    [Error]     INT              NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_TemporaryID_Chave]
    ON [dbo].[TemporaryID]([Chave] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TemporaryID_ID]
    ON [dbo].[TemporaryID]([ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TemporaryID_CHAVE_ID]
    ON [dbo].[TemporaryID]([Chave] ASC)
    INCLUDE([ID]);

