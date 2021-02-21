CREATE TABLE [dbo].[ExperienciasProfissionais] (
    [IdExperienciaProfissional] INT            IDENTITY (1, 1) NOT NULL,
    [IdProfissional]            INT            NOT NULL,
    [IdPessoaJuridica]          INT            NULL,
    [IdPessoa]                  INT            NULL,
    [IdVinculo]                 INT            NULL,
    [IdEntidadeClasse]          INT            NULL,
    [IdAtividade]               INT            NULL,
    [IdAreaAtuacao]             INT            NULL,
    [IdSetorAtuacao]            INT            NULL,
    [IdNatureza]                INT            NULL,
    [IdTipoPessoa]              INT            NULL,
    [IdCidadeAtuacao]           INT            NULL,
    [Funcao]                    TEXT           NULL,
    [CargaHorariaSemanal]       FLOAT (53)     NULL,
    [Remuneracao]               MONEY          NULL,
    [DataAdmissao]              DATETIME       NULL,
    [DataDemissao]              DATETIME       NULL,
    [HorarioTrabalho]           VARCHAR (15)   NULL,
    [ExerceAtividade]           BIT            NULL,
    [Periodo]                   VARCHAR (30)   NULL,
    [E_ResponsavelTecnico]      BIT            NULL,
    [AtualizacaoWeb]            VARCHAR (8000) NULL,
    [DataAtualizacao]           DATETIME       NULL,
    [IdEntidadeClassePJ]        INT            NULL,
    [idSiscafWeb]               INT            NULL,
    [UFAreaAtuacao]             VARCHAR (2)    NULL,
    [AreaAtuacaoDivulgacao]     BIT            CONSTRAINT [DF__Experienc__AreaA__6DEDDB13] DEFAULT ((0)) NOT NULL,
    [SetorAtuacaoDivulgacao]    BIT            CONSTRAINT [DF__Experienc__Setor__6EE1FF4C] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ExperienciasProfissional] PRIMARY KEY NONCLUSTERED ([IdExperienciaProfissional] ASC),
    CONSTRAINT [FK_ExperienciasProfissionais_AreasAtuacao] FOREIGN KEY ([IdAreaAtuacao]) REFERENCES [dbo].[AreasAtuacao] ([IdAreaAtuacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExperienciasProfissionais_Atividades] FOREIGN KEY ([IdAtividade]) REFERENCES [dbo].[Atividades] ([IdAtividade]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExperienciasProfissionais_Cidades] FOREIGN KEY ([IdCidadeAtuacao]) REFERENCES [dbo].[Cidades] ([IdCidade]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExperienciasProfissionais_EntidadeClassePJ] FOREIGN KEY ([IdEntidadeClassePJ]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExperienciasProfissionais_NaturezasPJ] FOREIGN KEY ([IdNatureza]) REFERENCES [dbo].[NaturezasPJ] ([IdNaturezaPJ]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExperienciasProfissionais_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExperienciasProfissionais_Pessoas1] FOREIGN KEY ([IdEntidadeClasse]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExperienciasProfissionais_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExperienciasProfissionais_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExperienciasProfissionais_SetoresAtuacao] FOREIGN KEY ([IdSetorAtuacao]) REFERENCES [dbo].[SetoresAtuacao] ([IdSetorAtuacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ExperienciasProfissionais_TiposPessoa] FOREIGN KEY ([IdTipoPessoa]) REFERENCES [dbo].[TiposPessoa] ([IdTipoPessoa]),
    CONSTRAINT [FK_ExperienciasProfissionais_VinculosEmpregaticio] FOREIGN KEY ([IdVinculo]) REFERENCES [dbo].[VinculosEmpregaticio] ([IdVinculoEmpregaticio]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ExperienciasProfissionais] ON [Implanta_CRPAM].[dbo].[ExperienciasProfissionais] 
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
SET @TableName = 'ExperienciasProfissionais'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdExperienciaProfissional : «' + RTRIM( ISNULL( CAST (IdExperienciaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdVinculo : «' + RTRIM( ISNULL( CAST (IdVinculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEntidadeClasse : «' + RTRIM( ISNULL( CAST (IdEntidadeClasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAtividade : «' + RTRIM( ISNULL( CAST (IdAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAreaAtuacao : «' + RTRIM( ISNULL( CAST (IdAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSetorAtuacao : «' + RTRIM( ISNULL( CAST (IdSetorAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNatureza : «' + RTRIM( ISNULL( CAST (IdNatureza AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPessoa : «' + RTRIM( ISNULL( CAST (IdTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeAtuacao : «' + RTRIM( ISNULL( CAST (IdCidadeAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargaHorariaSemanal : «' + RTRIM( ISNULL( CAST (CargaHorariaSemanal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remuneracao : «' + RTRIM( ISNULL( CAST (Remuneracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAdmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAdmissao, 113 ),'Nulo'))+'» '
                         + '| DataDemissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDemissao, 113 ),'Nulo'))+'» '
                         + '| HorarioTrabalho : «' + RTRIM( ISNULL( CAST (HorarioTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExerceAtividade IS NULL THEN ' ExerceAtividade : «Nulo» '
                                              WHEN  ExerceAtividade = 0 THEN ' ExerceAtividade : «Falso» '
                                              WHEN  ExerceAtividade = 1 THEN ' ExerceAtividade : «Verdadeiro» '
                                    END 
                         + '| Periodo : «' + RTRIM( ISNULL( CAST (Periodo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ResponsavelTecnico IS NULL THEN ' E_ResponsavelTecnico : «Nulo» '
                                              WHEN  E_ResponsavelTecnico = 0 THEN ' E_ResponsavelTecnico : «Falso» '
                                              WHEN  E_ResponsavelTecnico = 1 THEN ' E_ResponsavelTecnico : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| IdEntidadeClassePJ : «' + RTRIM( ISNULL( CAST (IdEntidadeClassePJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFAreaAtuacao : «' + RTRIM( ISNULL( CAST (UFAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AreaAtuacaoDivulgacao IS NULL THEN ' AreaAtuacaoDivulgacao : «Nulo» '
                                              WHEN  AreaAtuacaoDivulgacao = 0 THEN ' AreaAtuacaoDivulgacao : «Falso» '
                                              WHEN  AreaAtuacaoDivulgacao = 1 THEN ' AreaAtuacaoDivulgacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SetorAtuacaoDivulgacao IS NULL THEN ' SetorAtuacaoDivulgacao : «Nulo» '
                                              WHEN  SetorAtuacaoDivulgacao = 0 THEN ' SetorAtuacaoDivulgacao : «Falso» '
                                              WHEN  SetorAtuacaoDivulgacao = 1 THEN ' SetorAtuacaoDivulgacao : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdExperienciaProfissional : «' + RTRIM( ISNULL( CAST (IdExperienciaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdVinculo : «' + RTRIM( ISNULL( CAST (IdVinculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEntidadeClasse : «' + RTRIM( ISNULL( CAST (IdEntidadeClasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAtividade : «' + RTRIM( ISNULL( CAST (IdAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAreaAtuacao : «' + RTRIM( ISNULL( CAST (IdAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSetorAtuacao : «' + RTRIM( ISNULL( CAST (IdSetorAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNatureza : «' + RTRIM( ISNULL( CAST (IdNatureza AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPessoa : «' + RTRIM( ISNULL( CAST (IdTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeAtuacao : «' + RTRIM( ISNULL( CAST (IdCidadeAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargaHorariaSemanal : «' + RTRIM( ISNULL( CAST (CargaHorariaSemanal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remuneracao : «' + RTRIM( ISNULL( CAST (Remuneracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAdmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAdmissao, 113 ),'Nulo'))+'» '
                         + '| DataDemissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDemissao, 113 ),'Nulo'))+'» '
                         + '| HorarioTrabalho : «' + RTRIM( ISNULL( CAST (HorarioTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExerceAtividade IS NULL THEN ' ExerceAtividade : «Nulo» '
                                              WHEN  ExerceAtividade = 0 THEN ' ExerceAtividade : «Falso» '
                                              WHEN  ExerceAtividade = 1 THEN ' ExerceAtividade : «Verdadeiro» '
                                    END 
                         + '| Periodo : «' + RTRIM( ISNULL( CAST (Periodo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ResponsavelTecnico IS NULL THEN ' E_ResponsavelTecnico : «Nulo» '
                                              WHEN  E_ResponsavelTecnico = 0 THEN ' E_ResponsavelTecnico : «Falso» '
                                              WHEN  E_ResponsavelTecnico = 1 THEN ' E_ResponsavelTecnico : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| IdEntidadeClassePJ : «' + RTRIM( ISNULL( CAST (IdEntidadeClassePJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFAreaAtuacao : «' + RTRIM( ISNULL( CAST (UFAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AreaAtuacaoDivulgacao IS NULL THEN ' AreaAtuacaoDivulgacao : «Nulo» '
                                              WHEN  AreaAtuacaoDivulgacao = 0 THEN ' AreaAtuacaoDivulgacao : «Falso» '
                                              WHEN  AreaAtuacaoDivulgacao = 1 THEN ' AreaAtuacaoDivulgacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SetorAtuacaoDivulgacao IS NULL THEN ' SetorAtuacaoDivulgacao : «Nulo» '
                                              WHEN  SetorAtuacaoDivulgacao = 0 THEN ' SetorAtuacaoDivulgacao : «Falso» '
                                              WHEN  SetorAtuacaoDivulgacao = 1 THEN ' SetorAtuacaoDivulgacao : «Verdadeiro» '
                                    END  FROM INSERTED 
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
		SELECT @Conteudo = 'IdExperienciaProfissional : «' + RTRIM( ISNULL( CAST (IdExperienciaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdVinculo : «' + RTRIM( ISNULL( CAST (IdVinculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEntidadeClasse : «' + RTRIM( ISNULL( CAST (IdEntidadeClasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAtividade : «' + RTRIM( ISNULL( CAST (IdAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAreaAtuacao : «' + RTRIM( ISNULL( CAST (IdAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSetorAtuacao : «' + RTRIM( ISNULL( CAST (IdSetorAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNatureza : «' + RTRIM( ISNULL( CAST (IdNatureza AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPessoa : «' + RTRIM( ISNULL( CAST (IdTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeAtuacao : «' + RTRIM( ISNULL( CAST (IdCidadeAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargaHorariaSemanal : «' + RTRIM( ISNULL( CAST (CargaHorariaSemanal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remuneracao : «' + RTRIM( ISNULL( CAST (Remuneracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAdmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAdmissao, 113 ),'Nulo'))+'» '
                         + '| DataDemissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDemissao, 113 ),'Nulo'))+'» '
                         + '| HorarioTrabalho : «' + RTRIM( ISNULL( CAST (HorarioTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExerceAtividade IS NULL THEN ' ExerceAtividade : «Nulo» '
                                              WHEN  ExerceAtividade = 0 THEN ' ExerceAtividade : «Falso» '
                                              WHEN  ExerceAtividade = 1 THEN ' ExerceAtividade : «Verdadeiro» '
                                    END 
                         + '| Periodo : «' + RTRIM( ISNULL( CAST (Periodo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ResponsavelTecnico IS NULL THEN ' E_ResponsavelTecnico : «Nulo» '
                                              WHEN  E_ResponsavelTecnico = 0 THEN ' E_ResponsavelTecnico : «Falso» '
                                              WHEN  E_ResponsavelTecnico = 1 THEN ' E_ResponsavelTecnico : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| IdEntidadeClassePJ : «' + RTRIM( ISNULL( CAST (IdEntidadeClassePJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFAreaAtuacao : «' + RTRIM( ISNULL( CAST (UFAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AreaAtuacaoDivulgacao IS NULL THEN ' AreaAtuacaoDivulgacao : «Nulo» '
                                              WHEN  AreaAtuacaoDivulgacao = 0 THEN ' AreaAtuacaoDivulgacao : «Falso» '
                                              WHEN  AreaAtuacaoDivulgacao = 1 THEN ' AreaAtuacaoDivulgacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SetorAtuacaoDivulgacao IS NULL THEN ' SetorAtuacaoDivulgacao : «Nulo» '
                                              WHEN  SetorAtuacaoDivulgacao = 0 THEN ' SetorAtuacaoDivulgacao : «Falso» '
                                              WHEN  SetorAtuacaoDivulgacao = 1 THEN ' SetorAtuacaoDivulgacao : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdExperienciaProfissional : «' + RTRIM( ISNULL( CAST (IdExperienciaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdVinculo : «' + RTRIM( ISNULL( CAST (IdVinculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEntidadeClasse : «' + RTRIM( ISNULL( CAST (IdEntidadeClasse AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAtividade : «' + RTRIM( ISNULL( CAST (IdAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAreaAtuacao : «' + RTRIM( ISNULL( CAST (IdAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSetorAtuacao : «' + RTRIM( ISNULL( CAST (IdSetorAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNatureza : «' + RTRIM( ISNULL( CAST (IdNatureza AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPessoa : «' + RTRIM( ISNULL( CAST (IdTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeAtuacao : «' + RTRIM( ISNULL( CAST (IdCidadeAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CargaHorariaSemanal : «' + RTRIM( ISNULL( CAST (CargaHorariaSemanal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remuneracao : «' + RTRIM( ISNULL( CAST (Remuneracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAdmissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAdmissao, 113 ),'Nulo'))+'» '
                         + '| DataDemissao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDemissao, 113 ),'Nulo'))+'» '
                         + '| HorarioTrabalho : «' + RTRIM( ISNULL( CAST (HorarioTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExerceAtividade IS NULL THEN ' ExerceAtividade : «Nulo» '
                                              WHEN  ExerceAtividade = 0 THEN ' ExerceAtividade : «Falso» '
                                              WHEN  ExerceAtividade = 1 THEN ' ExerceAtividade : «Verdadeiro» '
                                    END 
                         + '| Periodo : «' + RTRIM( ISNULL( CAST (Periodo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ResponsavelTecnico IS NULL THEN ' E_ResponsavelTecnico : «Nulo» '
                                              WHEN  E_ResponsavelTecnico = 0 THEN ' E_ResponsavelTecnico : «Falso» '
                                              WHEN  E_ResponsavelTecnico = 1 THEN ' E_ResponsavelTecnico : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» '
                         + '| IdEntidadeClassePJ : «' + RTRIM( ISNULL( CAST (IdEntidadeClassePJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFAreaAtuacao : «' + RTRIM( ISNULL( CAST (UFAreaAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AreaAtuacaoDivulgacao IS NULL THEN ' AreaAtuacaoDivulgacao : «Nulo» '
                                              WHEN  AreaAtuacaoDivulgacao = 0 THEN ' AreaAtuacaoDivulgacao : «Falso» '
                                              WHEN  AreaAtuacaoDivulgacao = 1 THEN ' AreaAtuacaoDivulgacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SetorAtuacaoDivulgacao IS NULL THEN ' SetorAtuacaoDivulgacao : «Nulo» '
                                              WHEN  SetorAtuacaoDivulgacao = 0 THEN ' SetorAtuacaoDivulgacao : «Falso» '
                                              WHEN  SetorAtuacaoDivulgacao = 1 THEN ' SetorAtuacaoDivulgacao : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
