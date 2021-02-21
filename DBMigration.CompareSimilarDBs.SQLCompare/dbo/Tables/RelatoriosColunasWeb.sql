CREATE TABLE [dbo].[RelatoriosColunasWeb] (
    [IdColuna]      INT            IDENTITY (1, 1) NOT NULL,
    [IdSistema]     INT            NOT NULL,
    [Nome]          NVARCHAR (25)  NULL,
    [Tabela]        NVARCHAR (25)  NULL,
    [Titulo]        NVARCHAR (30)  NULL,
    [Descricao]     NVARCHAR (100) NULL,
    [Largura]       INT            NULL,
    [Tipo]          NVARCHAR (3)   NULL,
    [Consultar]     BIT            NULL,
    [Agrupar]       BIT            NULL,
    [Totalizar]     BIT            NULL,
    [Ordenar]       BIT            NULL,
    [DadosConsulta] NVARCHAR (255) NULL,
    [Codigo]        NVARCHAR (5)   NULL,
    [NomeRelatorio] NVARCHAR (60)  NULL,
    [ColunaJoin]    NVARCHAR (5)   NULL,
    CONSTRAINT [PK_RelatoriosColunasWeb] PRIMARY KEY CLUSTERED ([IdColuna] ASC)
);

