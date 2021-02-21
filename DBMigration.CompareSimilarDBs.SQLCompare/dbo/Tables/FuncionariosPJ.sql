CREATE TABLE [dbo].[FuncionariosPJ] (
    [IdFuncionarioPJ]     INT           IDENTITY (1, 1) NOT NULL,
    [IdPessoaJuridica]    INT           NULL,
    [IdProfissional]      INT           NULL,
    [IdPessoa]            INT           NULL,
    [DataAdmissao]        DATETIME      NULL,
    [DataSaida]           DATETIME      NULL,
    [IdCargo]             INT           NULL,
    [EAdministrador]      BIT           CONSTRAINT [DEF_FuncionariosPJ_EAdministrador] DEFAULT ((0)) NOT NULL,
    [IdFuncaoTrabalho]    INT           NULL,
    [IdFormacao]          INT           NULL,
    [AtividadesExercidas] VARCHAR (250) NULL,
    [CargoInformado]      VARCHAR (250) NULL,
    [FormacaoInformado]   VARCHAR (250) NULL,
    CONSTRAINT [PK_FuncionariosPJ_IdFuncionarioPJ] PRIMARY KEY CLUSTERED ([IdFuncionarioPJ] ASC),
    CONSTRAINT [FK_FuncionariosPJ_IdCargo] FOREIGN KEY ([IdCargo]) REFERENCES [dbo].[Cargos] ([IdCargo]),
    CONSTRAINT [FK_FuncionariosPJ_IdFormacao] FOREIGN KEY ([IdFormacao]) REFERENCES [dbo].[Formacoes] ([IdFormacao]),
    CONSTRAINT [FK_FuncionariosPJ_IdFuncaoTrabalho] FOREIGN KEY ([IdFuncaoTrabalho]) REFERENCES [dbo].[FuncoesTrabalho] ([IdFuncaoTrabalho]),
    CONSTRAINT [FK_FuncionariosPJ_IdPessoa] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_FuncionariosPJ_IdPessoaJuridica] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_FuncionariosPJ_IdProfissional] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_FuncionariosPJ] ON [Implanta_CRPAM].[dbo].[FuncionariosPJ] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'FuncionariosPJ'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFuncionarioPJ : «' + RTRIM( ISNULL( CAST (IdFuncionarioPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAdmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAdmissao, 113 ),'Nulo'))+'» '
                         + '| DataSaida : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaida, 113 ),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EAdministrador IS NULL THEN ' EAdministrador : «Nulo» '
                                              WHEN  EAdministrador = 0 THEN ' EAdministrador : «Falso» '
                                              WHEN  EAdministrador = 1 THEN ' EAdministrador : «Verdadeiro» '
                                    END 
                         + '| IdFuncaoTrabalho : «' + RTRIM( ISNULL( CAST (IdFuncaoTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormacao : «' + RTRIM( ISNULL( CAST (IdFormacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtividadesExercidas : «' + RTRIM( ISNULL( CAST (AtividadesExercidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoInformado : «' + RTRIM( ISNULL( CAST (CargoInformado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormacaoInformado : «' + RTRIM( ISNULL( CAST (FormacaoInformado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFuncionarioPJ : «' + RTRIM( ISNULL( CAST (IdFuncionarioPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAdmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAdmissao, 113 ),'Nulo'))+'» '
                         + '| DataSaida : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaida, 113 ),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EAdministrador IS NULL THEN ' EAdministrador : «Nulo» '
                                              WHEN  EAdministrador = 0 THEN ' EAdministrador : «Falso» '
                                              WHEN  EAdministrador = 1 THEN ' EAdministrador : «Verdadeiro» '
                                    END 
                         + '| IdFuncaoTrabalho : «' + RTRIM( ISNULL( CAST (IdFuncaoTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormacao : «' + RTRIM( ISNULL( CAST (IdFormacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtividadesExercidas : «' + RTRIM( ISNULL( CAST (AtividadesExercidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoInformado : «' + RTRIM( ISNULL( CAST (CargoInformado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormacaoInformado : «' + RTRIM( ISNULL( CAST (FormacaoInformado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'IdFuncionarioPJ : «' + RTRIM( ISNULL( CAST (IdFuncionarioPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAdmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAdmissao, 113 ),'Nulo'))+'» '
                         + '| DataSaida : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaida, 113 ),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EAdministrador IS NULL THEN ' EAdministrador : «Nulo» '
                                              WHEN  EAdministrador = 0 THEN ' EAdministrador : «Falso» '
                                              WHEN  EAdministrador = 1 THEN ' EAdministrador : «Verdadeiro» '
                                    END 
                         + '| IdFuncaoTrabalho : «' + RTRIM( ISNULL( CAST (IdFuncaoTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormacao : «' + RTRIM( ISNULL( CAST (IdFormacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtividadesExercidas : «' + RTRIM( ISNULL( CAST (AtividadesExercidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoInformado : «' + RTRIM( ISNULL( CAST (CargoInformado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormacaoInformado : «' + RTRIM( ISNULL( CAST (FormacaoInformado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFuncionarioPJ : «' + RTRIM( ISNULL( CAST (IdFuncionarioPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAdmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAdmissao, 113 ),'Nulo'))+'» '
                         + '| DataSaida : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSaida, 113 ),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EAdministrador IS NULL THEN ' EAdministrador : «Nulo» '
                                              WHEN  EAdministrador = 0 THEN ' EAdministrador : «Falso» '
                                              WHEN  EAdministrador = 1 THEN ' EAdministrador : «Verdadeiro» '
                                    END 
                         + '| IdFuncaoTrabalho : «' + RTRIM( ISNULL( CAST (IdFuncaoTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormacao : «' + RTRIM( ISNULL( CAST (IdFormacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtividadesExercidas : «' + RTRIM( ISNULL( CAST (AtividadesExercidas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargoInformado : «' + RTRIM( ISNULL( CAST (CargoInformado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormacaoInformado : «' + RTRIM( ISNULL( CAST (FormacaoInformado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
