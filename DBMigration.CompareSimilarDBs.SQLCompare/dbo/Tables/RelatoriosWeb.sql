CREATE TABLE [dbo].[RelatoriosWeb] (
    [IdRelatorio]      INT            IDENTITY (1, 1) NOT NULL,
    [IdSistema]        INT            NOT NULL,
    [IdUsuario]        INT            NULL,
    [Titulo]           NVARCHAR (80)  NULL,
    [TituloResumido]   NVARCHAR (80)  NULL,
    [Numerar]          BIT            NULL,
    [Zebrado]          BIT            NULL,
    [Retrato]          BIT            NULL,
    [OrdemDecrescente] BIT            NULL,
    [Colunas]          NVARCHAR (255) NULL,
    [Criterios]        NTEXT          NULL,
    [OrdemColunas]     NVARCHAR (100) NULL,
    [Agrupar]          NVARCHAR (100) NULL,
    [DataGeracao]      DATETIME       NULL,
    CONSTRAINT [PK_RelatoriosWeb] PRIMARY KEY CLUSTERED ([IdRelatorio] ASC)
);

