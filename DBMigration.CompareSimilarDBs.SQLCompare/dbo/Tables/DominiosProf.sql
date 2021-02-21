CREATE TABLE [dbo].[DominiosProf] (
    [IdSistema]        INT           NULL,
    [NomeTabela]       VARCHAR (50)  NULL,
    [TabelaJoin]       VARCHAR (50)  NULL,
    [NomeCampo]        VARCHAR (50)  NULL,
    [Alias_Campo]      VARCHAR (50)  NULL,
    [TipoCampo]        VARCHAR (60)  NULL,
    [TamanhoCampo]     INT           NULL,
    [Grupo]            VARCHAR (250) NULL,
    [Conjunto]         VARCHAR (50)  NULL,
    [Dominio]          VARCHAR (250) NULL,
    [Observacoes]      TEXT          NULL,
    [Alinhamento]      CHAR (1)      NULL,
    [CasasDecimais]    INT           NULL,
    [PadraoRepeticao]  BIT           NULL,
    [Criterio_Selecao] CHAR (10)     NULL,
    [Ordem]            VARCHAR (50)  NULL,
    [Acesso]           INT           NULL,
    [DataAlteracao]    DATETIME      NULL,
    [NumOcorrencia]    INT           NULL,
    CONSTRAINT [IX_DominiosProf] UNIQUE NONCLUSTERED ([Alias_Campo] ASC)
);

