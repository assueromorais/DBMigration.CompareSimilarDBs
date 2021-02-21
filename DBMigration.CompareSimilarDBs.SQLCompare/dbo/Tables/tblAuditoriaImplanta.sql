CREATE TABLE [dbo].[tblAuditoriaImplanta] (
    [IdAudit]       INT            IDENTITY (1, 1) NOT NULL,
    [TpEventoSQL]   NVARCHAR (100) NULL,
    [DataAlteracao] DATETIME       NULL,
    [NmServidor]    NVARCHAR (100) NULL,
    [NmLogin]       NVARCHAR (100) NULL,
    [NmDatabase]    NVARCHAR (100) NULL,
    [NmObjeto]      NVARCHAR (200) NULL,
    [TSQLCommand]   NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_tblAuditoriaImplanta] PRIMARY KEY CLUSTERED ([IdAudit] ASC)
);

