CREATE TABLE [dbo].[CursosEventosRealizado] (
    [IdCursoEventoRealizado] INT            IDENTITY (1, 1) NOT NULL,
    [IdProfissional]         INT            NOT NULL,
    [IdCursoEvento]          INT            NOT NULL,
    [IdPessoa]               INT            NULL,
    [IdSituacaoCurso]        INT            NULL,
    [IdEspecialidade]        INT            NULL,
    [TipoDocumento]          VARCHAR (1)    NULL,
    [DataExpedicaoDocumento] DATETIME       NULL,
    [Duracao]                FLOAT (53)     NULL,
    [UnidadeDuracao]         VARCHAR (1)    NULL,
    [PeriodoRealizacao]      VARCHAR (20)   NULL,
    [DataConclusao]          DATETIME       NULL,
    [DataColacaoGrau]        DATETIME       NULL,
    [Observacao]             TEXT           NULL,
    [E_CursoRegistro]        BIT            NULL,
    [E_Curso]                BIT            NULL,
    [AtualizacaoWeb]         VARCHAR (8000) NULL,
    [IdPessoaCampus]         INT            NULL,
    [EnsinoDistancia]        BIT            DEFAULT ((0)) NOT NULL,
    [idSiscafWeb]            INT            NULL,
    CONSTRAINT [PK_CursoEventosRealizado] PRIMARY KEY CLUSTERED ([IdCursoEventoRealizado] ASC),
    CONSTRAINT [FK_CursosEventosRealizado_CursoEvento] FOREIGN KEY ([IdCursoEvento]) REFERENCES [dbo].[CursosEventos] ([IdCursoEvento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_CursosEventosRealizado_Especialidades] FOREIGN KEY ([IdEspecialidade]) REFERENCES [dbo].[Especialidades] ([IdEspecialidade]),
    CONSTRAINT [FK_CursosEventosRealizado_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_CursosEventosRealizado_Pessoas_Campus] FOREIGN KEY ([IdPessoaCampus]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_CursosEventosRealizado_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) NOT FOR REPLICATION,
    CONSTRAINT [FK_CursosEventosRealizado_SituacoesCurso] FOREIGN KEY ([IdSituacaoCurso]) REFERENCES [dbo].[SituacoesCurso] ([IdSituacaoCurso]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_CursosEventosRealizado] ON [Implanta_CRPAM].[dbo].[CursosEventosRealizado] 
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
SET @TableName = 'CursosEventosRealizado'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCursoEventoRealizado : «' + RTRIM( ISNULL( CAST (IdCursoEventoRealizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoCurso : «' + RTRIM( ISNULL( CAST (IdSituacaoCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEspecialidade : «' + RTRIM( ISNULL( CAST (IdEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDocumento : «' + RTRIM( ISNULL( CAST (TipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExpedicaoDocumento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExpedicaoDocumento, 113 ),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeriodoRealizacao : «' + RTRIM( ISNULL( CAST (PeriodoRealizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConclusao, 113 ),'Nulo'))+'» '
                         + '| DataColacaoGrau : «' + RTRIM( ISNULL( CONVERT (CHAR, DataColacaoGrau, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_CursoRegistro IS NULL THEN ' E_CursoRegistro : «Nulo» '
                                              WHEN  E_CursoRegistro = 0 THEN ' E_CursoRegistro : «Falso» '
                                              WHEN  E_CursoRegistro = 1 THEN ' E_CursoRegistro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_Curso IS NULL THEN ' E_Curso : «Nulo» '
                                              WHEN  E_Curso = 0 THEN ' E_Curso : «Falso» '
                                              WHEN  E_Curso = 1 THEN ' E_Curso : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaCampus : «' + RTRIM( ISNULL( CAST (IdPessoaCampus AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnsinoDistancia IS NULL THEN ' EnsinoDistancia : «Nulo» '
                                              WHEN  EnsinoDistancia = 0 THEN ' EnsinoDistancia : «Falso» '
                                              WHEN  EnsinoDistancia = 1 THEN ' EnsinoDistancia : «Verdadeiro» '
                                    END 
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCursoEventoRealizado : «' + RTRIM( ISNULL( CAST (IdCursoEventoRealizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoCurso : «' + RTRIM( ISNULL( CAST (IdSituacaoCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEspecialidade : «' + RTRIM( ISNULL( CAST (IdEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDocumento : «' + RTRIM( ISNULL( CAST (TipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExpedicaoDocumento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExpedicaoDocumento, 113 ),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeriodoRealizacao : «' + RTRIM( ISNULL( CAST (PeriodoRealizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConclusao, 113 ),'Nulo'))+'» '
                         + '| DataColacaoGrau : «' + RTRIM( ISNULL( CONVERT (CHAR, DataColacaoGrau, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_CursoRegistro IS NULL THEN ' E_CursoRegistro : «Nulo» '
                                              WHEN  E_CursoRegistro = 0 THEN ' E_CursoRegistro : «Falso» '
                                              WHEN  E_CursoRegistro = 1 THEN ' E_CursoRegistro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_Curso IS NULL THEN ' E_Curso : «Nulo» '
                                              WHEN  E_Curso = 0 THEN ' E_Curso : «Falso» '
                                              WHEN  E_Curso = 1 THEN ' E_Curso : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaCampus : «' + RTRIM( ISNULL( CAST (IdPessoaCampus AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnsinoDistancia IS NULL THEN ' EnsinoDistancia : «Nulo» '
                                              WHEN  EnsinoDistancia = 0 THEN ' EnsinoDistancia : «Falso» '
                                              WHEN  EnsinoDistancia = 1 THEN ' EnsinoDistancia : «Verdadeiro» '
                                    END 
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCursoEventoRealizado : «' + RTRIM( ISNULL( CAST (IdCursoEventoRealizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoCurso : «' + RTRIM( ISNULL( CAST (IdSituacaoCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEspecialidade : «' + RTRIM( ISNULL( CAST (IdEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDocumento : «' + RTRIM( ISNULL( CAST (TipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExpedicaoDocumento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExpedicaoDocumento, 113 ),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeriodoRealizacao : «' + RTRIM( ISNULL( CAST (PeriodoRealizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConclusao, 113 ),'Nulo'))+'» '
                         + '| DataColacaoGrau : «' + RTRIM( ISNULL( CONVERT (CHAR, DataColacaoGrau, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_CursoRegistro IS NULL THEN ' E_CursoRegistro : «Nulo» '
                                              WHEN  E_CursoRegistro = 0 THEN ' E_CursoRegistro : «Falso» '
                                              WHEN  E_CursoRegistro = 1 THEN ' E_CursoRegistro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_Curso IS NULL THEN ' E_Curso : «Nulo» '
                                              WHEN  E_Curso = 0 THEN ' E_Curso : «Falso» '
                                              WHEN  E_Curso = 1 THEN ' E_Curso : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaCampus : «' + RTRIM( ISNULL( CAST (IdPessoaCampus AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnsinoDistancia IS NULL THEN ' EnsinoDistancia : «Nulo» '
                                              WHEN  EnsinoDistancia = 0 THEN ' EnsinoDistancia : «Falso» '
                                              WHEN  EnsinoDistancia = 1 THEN ' EnsinoDistancia : «Verdadeiro» '
                                    END 
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCursoEventoRealizado : «' + RTRIM( ISNULL( CAST (IdCursoEventoRealizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoCurso : «' + RTRIM( ISNULL( CAST (IdSituacaoCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEspecialidade : «' + RTRIM( ISNULL( CAST (IdEspecialidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDocumento : «' + RTRIM( ISNULL( CAST (TipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExpedicaoDocumento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExpedicaoDocumento, 113 ),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PeriodoRealizacao : «' + RTRIM( ISNULL( CAST (PeriodoRealizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataConclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataConclusao, 113 ),'Nulo'))+'» '
                         + '| DataColacaoGrau : «' + RTRIM( ISNULL( CONVERT (CHAR, DataColacaoGrau, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_CursoRegistro IS NULL THEN ' E_CursoRegistro : «Nulo» '
                                              WHEN  E_CursoRegistro = 0 THEN ' E_CursoRegistro : «Falso» '
                                              WHEN  E_CursoRegistro = 1 THEN ' E_CursoRegistro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_Curso IS NULL THEN ' E_Curso : «Nulo» '
                                              WHEN  E_Curso = 0 THEN ' E_Curso : «Falso» '
                                              WHEN  E_Curso = 1 THEN ' E_Curso : «Verdadeiro» '
                                    END 
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaCampus : «' + RTRIM( ISNULL( CAST (IdPessoaCampus AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnsinoDistancia IS NULL THEN ' EnsinoDistancia : «Nulo» '
                                              WHEN  EnsinoDistancia = 0 THEN ' EnsinoDistancia : «Falso» '
                                              WHEN  EnsinoDistancia = 1 THEN ' EnsinoDistancia : «Verdadeiro» '
                                    END 
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
