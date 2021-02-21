CREATE TABLE [dbo].[ComplementosProfissional] (
    [IdComplementoProfissional] INT          IDENTITY (1, 1) NOT NULL,
    [IdProfissional]            INT          NOT NULL,
    [IdUnidadeConselho]         INT          NOT NULL,
    [IdCategoriaProfissional]   INT          NULL,
    [IdTipoInscricao]           INT          NOT NULL,
    [IdSituacaoComplemento]     INT          NULL,
    [RegistroConselho]          VARCHAR (20) NULL,
    [DataInscricaoConselho]     DATETIME     NULL,
    CONSTRAINT [PK_ComplementosProfissional] PRIMARY KEY CLUSTERED ([IdComplementoProfissional] ASC),
    CONSTRAINT [FK_ComplementosProfissinal_CatgoriaProfissional] FOREIGN KEY ([IdCategoriaProfissional]) REFERENCES [dbo].[CategoriasProf] ([IdCategoriaProf]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ComplementosProfissional_Pessoas] FOREIGN KEY ([IdUnidadeConselho]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ComplementosProfissional_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_ComplementosProfissional_SituacoesPFPJ] FOREIGN KEY ([IdSituacaoComplemento]) REFERENCES [dbo].[SituacoesPFPJ] ([IdSituacaoPFPJ]),
    CONSTRAINT [FK_ComplementosProfissional_TiposInscricao] FOREIGN KEY ([IdTipoInscricao]) REFERENCES [dbo].[TiposInscricao] ([IdTipoInscricao]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ComplementosProfissional] ON [Implanta_CRPAM].[dbo].[ComplementosProfissional] 
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
SET @TableName = 'ComplementosProfissional'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdComplementoProfissional : «' + RTRIM( ISNULL( CAST (IdComplementoProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeConselho : «' + RTRIM( ISNULL( CAST (IdUnidadeConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProfissional : «' + RTRIM( ISNULL( CAST (IdCategoriaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoComplemento : «' + RTRIM( ISNULL( CAST (IdSituacaoComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConselho : «' + RTRIM( ISNULL( CAST (RegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInscricaoConselho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInscricaoConselho, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdComplementoProfissional : «' + RTRIM( ISNULL( CAST (IdComplementoProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeConselho : «' + RTRIM( ISNULL( CAST (IdUnidadeConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProfissional : «' + RTRIM( ISNULL( CAST (IdCategoriaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoComplemento : «' + RTRIM( ISNULL( CAST (IdSituacaoComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConselho : «' + RTRIM( ISNULL( CAST (RegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInscricaoConselho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInscricaoConselho, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdComplementoProfissional : «' + RTRIM( ISNULL( CAST (IdComplementoProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeConselho : «' + RTRIM( ISNULL( CAST (IdUnidadeConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProfissional : «' + RTRIM( ISNULL( CAST (IdCategoriaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoComplemento : «' + RTRIM( ISNULL( CAST (IdSituacaoComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConselho : «' + RTRIM( ISNULL( CAST (RegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInscricaoConselho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInscricaoConselho, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdComplementoProfissional : «' + RTRIM( ISNULL( CAST (IdComplementoProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeConselho : «' + RTRIM( ISNULL( CAST (IdUnidadeConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProfissional : «' + RTRIM( ISNULL( CAST (IdCategoriaProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricao : «' + RTRIM( ISNULL( CAST (IdTipoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoComplemento : «' + RTRIM( ISNULL( CAST (IdSituacaoComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroConselho : «' + RTRIM( ISNULL( CAST (RegistroConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInscricaoConselho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInscricaoConselho, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
