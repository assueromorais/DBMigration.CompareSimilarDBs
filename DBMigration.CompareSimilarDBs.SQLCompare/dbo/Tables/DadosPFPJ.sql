CREATE TABLE [dbo].[DadosPFPJ] (
    [IdDadosPFPJ]               INT      IDENTITY (1, 1) NOT NULL,
    [IdProcedimentoOperacional] INT      NOT NULL,
    [IdTipoInscricao]           INT      NULL,
    [IdSituacaoPFPJ]            INT      NULL,
    [IdCategoriaProf]           INT      NULL,
    [IdCategoriaPJ]             INT      NULL,
    [Classe]                    CHAR (1) NULL,
    CONSTRAINT [PK_DadosPFPJ] PRIMARY KEY CLUSTERED ([IdDadosPFPJ] ASC),
    CONSTRAINT [FK_DadosPFPJ_CategoriasPJ] FOREIGN KEY ([IdCategoriaPJ]) REFERENCES [dbo].[CategoriasPJ] ([IdCategoriaPJ]),
    CONSTRAINT [FK_DadosPFPJ_CategoriasProf] FOREIGN KEY ([IdCategoriaProf]) REFERENCES [dbo].[CategoriasProf] ([IdCategoriaProf]),
    CONSTRAINT [FK_DadosPFPJ_ProcedimentosOperacionais] FOREIGN KEY ([IdProcedimentoOperacional]) REFERENCES [dbo].[ProcedimentosOperacionais] ([IdProcedimentoOperacional]),
    CONSTRAINT [FK_DadosPFPJ_SituacoesPFPJ] FOREIGN KEY ([IdSituacaoPFPJ]) REFERENCES [dbo].[SituacoesPFPJ] ([IdSituacaoPFPJ]),
    CONSTRAINT [FK_DadosPFPJ_TiposInscricao] FOREIGN KEY ([IdTipoInscricao]) REFERENCES [dbo].[TiposInscricao] ([IdTipoInscricao])
);


GO
CREATE TRIGGER [TrgLog_DadosPFPJ] ON [Implanta_CRPAM].[dbo].[DadosPFPJ] 
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
SET @TableName = 'DadosPFPJ'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDadosPFPJ : «' + RTRIM( ISNULL( CAST (IdDadosPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoOperacional : «' + RTRIM( ISNULL( CAST (IdProcedimentoOperacional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaPJ : «' + RTRIM( ISNULL( CAST (IdCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Classe : «' + RTRIM( ISNULL( CAST (Classe AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDadosPFPJ : «' + RTRIM( ISNULL( CAST (IdDadosPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoOperacional : «' + RTRIM( ISNULL( CAST (IdProcedimentoOperacional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaPJ : «' + RTRIM( ISNULL( CAST (IdCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Classe : «' + RTRIM( ISNULL( CAST (Classe AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDadosPFPJ : «' + RTRIM( ISNULL( CAST (IdDadosPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoOperacional : «' + RTRIM( ISNULL( CAST (IdProcedimentoOperacional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaPJ : «' + RTRIM( ISNULL( CAST (IdCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Classe : «' + RTRIM( ISNULL( CAST (Classe AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDadosPFPJ : «' + RTRIM( ISNULL( CAST (IdDadosPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoOperacional : «' + RTRIM( ISNULL( CAST (IdProcedimentoOperacional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJ : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProf : «' + RTRIM( ISNULL( CAST (IdCategoriaProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaPJ : «' + RTRIM( ISNULL( CAST (IdCategoriaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Classe : «' + RTRIM( ISNULL( CAST (Classe AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
