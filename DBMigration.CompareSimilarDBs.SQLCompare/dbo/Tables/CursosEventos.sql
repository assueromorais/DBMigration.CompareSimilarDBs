CREATE TABLE [dbo].[CursosEventos] (
    [IdCursoEvento]             INT          IDENTITY (1, 1) NOT NULL,
    [NomeCursoEvento]           VARCHAR (60) NOT NULL,
    [IdNivelCurso]              INT          NULL,
    [IdAreaCursoEvento]         INT          NULL,
    [E_Curso]                   BIT          NOT NULL,
    [Observacoes]               TEXT         NULL,
    [IndCricacaoWeb]            BIT          NULL,
    [IdPessoaEntidade]          INT          NULL,
    [IdPessoaMinistrante]       INT          NULL,
    [IdProfissionalMinistrante] INT          NULL,
    [TituloMinistrante]         VARCHAR (30) NULL,
    [Duracao]                   FLOAT (53)   NULL,
    [UnidadeDuracao]            VARCHAR (1)  NULL,
    [DataInicioPeriodo]         DATETIME     NULL,
    [DataFimPeriodo]            DATETIME     NULL,
    [IdPessoaCampus]            INT          NULL,
    [Desativado]                BIT          CONSTRAINT [DF_CursosEventosDesativado] DEFAULT ((0)) NULL,
    [DtCadastro]                DATETIME     NULL,
    [DtAprovacao]               DATETIME     NULL,
    [DtSituacao]                DATETIME     NULL,
    [IdSituacaoCurso]           INT          NULL,
    [IndCriacaoWeb]             BIT          NULL,
    CONSTRAINT [PK_CursosEventos] PRIMARY KEY CLUSTERED ([IdCursoEvento] ASC),
    CONSTRAINT [FK_CursosEventos_AreasAtuacao] FOREIGN KEY ([IdAreaCursoEvento]) REFERENCES [dbo].[AreasAtuacao] ([IdAreaAtuacao]),
    CONSTRAINT [FK_CursosEventos_NiveisCurso] FOREIGN KEY ([IdNivelCurso]) REFERENCES [dbo].[NiveisCurso] ([IdNivelCurso]) NOT FOR REPLICATION,
    CONSTRAINT [FK_CursosEventos_Pessoas_Campus] FOREIGN KEY ([IdPessoaCampus]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_CursosEventos_Pessoas_Entidade] FOREIGN KEY ([IdPessoaEntidade]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_CursosEventos_Pessoas_Ministrante] FOREIGN KEY ([IdPessoaMinistrante]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_CursosEventos_Profissionais_Ministrante] FOREIGN KEY ([IdProfissionalMinistrante]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_CursosEventos] ON [Implanta_CRPAM].[dbo].[CursosEventos] 
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
SET @TableName = 'CursosEventos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCursoEvento : «' + RTRIM( ISNULL( CAST (NomeCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelCurso : «' + RTRIM( ISNULL( CAST (IdNivelCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAreaCursoEvento : «' + RTRIM( ISNULL( CAST (IdAreaCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Curso IS NULL THEN ' E_Curso : «Nulo» '
                                              WHEN  E_Curso = 0 THEN ' E_Curso : «Falso» '
                                              WHEN  E_Curso = 1 THEN ' E_Curso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| IdPessoaEntidade : «' + RTRIM( ISNULL( CAST (IdPessoaEntidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaMinistrante : «' + RTRIM( ISNULL( CAST (IdPessoaMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalMinistrante : «' + RTRIM( ISNULL( CAST (IdProfissionalMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloMinistrante : «' + RTRIM( ISNULL( CAST (TituloMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioPeriodo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioPeriodo, 113 ),'Nulo'))+'» '
                         + '| DataFimPeriodo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimPeriodo, 113 ),'Nulo'))+'» '
                         + '| IdPessoaCampus : «' + RTRIM( ISNULL( CAST (IdPessoaCampus AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| DtCadastro : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCadastro, 113 ),'Nulo'))+'» '
                         + '| DtAprovacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtAprovacao, 113 ),'Nulo'))+'» '
                         + '| DtSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtSituacao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoCurso : «' + RTRIM( ISNULL( CAST (IdSituacaoCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCursoEvento : «' + RTRIM( ISNULL( CAST (NomeCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelCurso : «' + RTRIM( ISNULL( CAST (IdNivelCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAreaCursoEvento : «' + RTRIM( ISNULL( CAST (IdAreaCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Curso IS NULL THEN ' E_Curso : «Nulo» '
                                              WHEN  E_Curso = 0 THEN ' E_Curso : «Falso» '
                                              WHEN  E_Curso = 1 THEN ' E_Curso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| IdPessoaEntidade : «' + RTRIM( ISNULL( CAST (IdPessoaEntidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaMinistrante : «' + RTRIM( ISNULL( CAST (IdPessoaMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalMinistrante : «' + RTRIM( ISNULL( CAST (IdProfissionalMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloMinistrante : «' + RTRIM( ISNULL( CAST (TituloMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioPeriodo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioPeriodo, 113 ),'Nulo'))+'» '
                         + '| DataFimPeriodo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimPeriodo, 113 ),'Nulo'))+'» '
                         + '| IdPessoaCampus : «' + RTRIM( ISNULL( CAST (IdPessoaCampus AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| DtCadastro : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCadastro, 113 ),'Nulo'))+'» '
                         + '| DtAprovacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtAprovacao, 113 ),'Nulo'))+'» '
                         + '| DtSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtSituacao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoCurso : «' + RTRIM( ISNULL( CAST (IdSituacaoCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCursoEvento : «' + RTRIM( ISNULL( CAST (NomeCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelCurso : «' + RTRIM( ISNULL( CAST (IdNivelCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAreaCursoEvento : «' + RTRIM( ISNULL( CAST (IdAreaCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Curso IS NULL THEN ' E_Curso : «Nulo» '
                                              WHEN  E_Curso = 0 THEN ' E_Curso : «Falso» '
                                              WHEN  E_Curso = 1 THEN ' E_Curso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| IdPessoaEntidade : «' + RTRIM( ISNULL( CAST (IdPessoaEntidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaMinistrante : «' + RTRIM( ISNULL( CAST (IdPessoaMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalMinistrante : «' + RTRIM( ISNULL( CAST (IdProfissionalMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloMinistrante : «' + RTRIM( ISNULL( CAST (TituloMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioPeriodo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioPeriodo, 113 ),'Nulo'))+'» '
                         + '| DataFimPeriodo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimPeriodo, 113 ),'Nulo'))+'» '
                         + '| IdPessoaCampus : «' + RTRIM( ISNULL( CAST (IdPessoaCampus AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| DtCadastro : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCadastro, 113 ),'Nulo'))+'» '
                         + '| DtAprovacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtAprovacao, 113 ),'Nulo'))+'» '
                         + '| DtSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtSituacao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoCurso : «' + RTRIM( ISNULL( CAST (IdSituacaoCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCursoEvento : «' + RTRIM( ISNULL( CAST (NomeCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelCurso : «' + RTRIM( ISNULL( CAST (IdNivelCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAreaCursoEvento : «' + RTRIM( ISNULL( CAST (IdAreaCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Curso IS NULL THEN ' E_Curso : «Nulo» '
                                              WHEN  E_Curso = 0 THEN ' E_Curso : «Falso» '
                                              WHEN  E_Curso = 1 THEN ' E_Curso : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| IdPessoaEntidade : «' + RTRIM( ISNULL( CAST (IdPessoaEntidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaMinistrante : «' + RTRIM( ISNULL( CAST (IdPessoaMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalMinistrante : «' + RTRIM( ISNULL( CAST (IdProfissionalMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloMinistrante : «' + RTRIM( ISNULL( CAST (TituloMinistrante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioPeriodo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioPeriodo, 113 ),'Nulo'))+'» '
                         + '| DataFimPeriodo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimPeriodo, 113 ),'Nulo'))+'» '
                         + '| IdPessoaCampus : «' + RTRIM( ISNULL( CAST (IdPessoaCampus AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| DtCadastro : «' + RTRIM( ISNULL( CONVERT (CHAR, DtCadastro, 113 ),'Nulo'))+'» '
                         + '| DtAprovacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtAprovacao, 113 ),'Nulo'))+'» '
                         + '| DtSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtSituacao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoCurso : «' + RTRIM( ISNULL( CAST (IdSituacaoCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
