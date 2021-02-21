CREATE TABLE [dbo].[UsuariosSiscafWeb] (
    [IdProfissional]   INT              NULL,
    [IdPessoaJuridica] INT              NULL,
    [Senha]            VARCHAR (10)     NULL,
    [Usuario]          VARCHAR (30)     NULL,
    [Identificador]    UNIQUEIDENTIFIER NULL,
    [IdNovidadeAtual]  UNIQUEIDENTIFIER NULL
);

