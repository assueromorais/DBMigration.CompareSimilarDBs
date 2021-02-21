CREATE TABLE [dbo].[ConfigSituacoes] (
    [IdSituacaoPFPJANT]    INT          NOT NULL,
    [IdSituacaoPFPJPOS]    INT          NOT NULL,
    [Qtd]                  INT          NULL,
    [Criterio]             VARCHAR (5)  NULL,
    [NomeCampo]            VARCHAR (30) NULL,
    [CriterioSelecao]      VARCHAR (30) NULL,
    [IdTipoInscricaoANT]   INT          NULL,
    [IdDetalheSituacaoANT] INT          NULL,
    [IdDetalheSituacaoPOS] INT          NULL,
    [IdCategoriaProfANT]   INT          NULL,
    CONSTRAINT [FK_ConfigSituacoes_CategoriasProf] FOREIGN KEY ([IdCategoriaProfANT]) REFERENCES [dbo].[CategoriasProf] ([IdCategoriaProf]),
    CONSTRAINT [FK_ConfigSituacoes_DetalhesSituacao] FOREIGN KEY ([IdDetalheSituacaoANT]) REFERENCES [dbo].[DetalhesSituacao] ([IdDetalheSituacao]),
    CONSTRAINT [FK_ConfigSituacoes_DetalhesSituacao_2] FOREIGN KEY ([IdDetalheSituacaoPOS]) REFERENCES [dbo].[DetalhesSituacao] ([IdDetalheSituacao]),
    CONSTRAINT [FK_ConfigSituacoes_SituacoesPFPJ] FOREIGN KEY ([IdSituacaoPFPJANT]) REFERENCES [dbo].[SituacoesPFPJ] ([IdSituacaoPFPJ]),
    CONSTRAINT [FK_ConfigSituacoes_SituacoesPFPJ1] FOREIGN KEY ([IdSituacaoPFPJPOS]) REFERENCES [dbo].[SituacoesPFPJ] ([IdSituacaoPFPJ]),
    CONSTRAINT [FK_ConfigSituacoes_TiposInscricao] FOREIGN KEY ([IdTipoInscricaoANT]) REFERENCES [dbo].[TiposInscricao] ([IdTipoInscricao])
);


GO
ALTER TABLE [dbo].[ConfigSituacoes] NOCHECK CONSTRAINT [FK_ConfigSituacoes_DetalhesSituacao];


GO
ALTER TABLE [dbo].[ConfigSituacoes] NOCHECK CONSTRAINT [FK_ConfigSituacoes_DetalhesSituacao_2];


GO
CREATE TRIGGER [TrgLog_ConfigSituacoes] ON [Implanta_CRPAM].[dbo].[ConfigSituacoes] 
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
SET @TableName = 'ConfigSituacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdSituacaoPFPJANT : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJPOS : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJPOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Criterio : «' + RTRIM( ISNULL( CAST (Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CriterioSelecao : «' + RTRIM( ISNULL( CAST (CriterioSelecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricaoANT : «' + RTRIM( ISNULL( CAST (IdTipoInscricaoANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacaoANT : «' + RTRIM( ISNULL( CAST (IdDetalheSituacaoANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacaoPOS : «' + RTRIM( ISNULL( CAST (IdDetalheSituacaoPOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProfANT : «' + RTRIM( ISNULL( CAST (IdCategoriaProfANT AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdSituacaoPFPJANT : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJPOS : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJPOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Criterio : «' + RTRIM( ISNULL( CAST (Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CriterioSelecao : «' + RTRIM( ISNULL( CAST (CriterioSelecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricaoANT : «' + RTRIM( ISNULL( CAST (IdTipoInscricaoANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacaoANT : «' + RTRIM( ISNULL( CAST (IdDetalheSituacaoANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacaoPOS : «' + RTRIM( ISNULL( CAST (IdDetalheSituacaoPOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProfANT : «' + RTRIM( ISNULL( CAST (IdCategoriaProfANT AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdSituacaoPFPJANT : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJPOS : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJPOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Criterio : «' + RTRIM( ISNULL( CAST (Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CriterioSelecao : «' + RTRIM( ISNULL( CAST (CriterioSelecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricaoANT : «' + RTRIM( ISNULL( CAST (IdTipoInscricaoANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacaoANT : «' + RTRIM( ISNULL( CAST (IdDetalheSituacaoANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacaoPOS : «' + RTRIM( ISNULL( CAST (IdDetalheSituacaoPOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProfANT : «' + RTRIM( ISNULL( CAST (IdCategoriaProfANT AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdSituacaoPFPJANT : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoPFPJPOS : «' + RTRIM( ISNULL( CAST (IdSituacaoPFPJPOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Criterio : «' + RTRIM( ISNULL( CAST (Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CriterioSelecao : «' + RTRIM( ISNULL( CAST (CriterioSelecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInscricaoANT : «' + RTRIM( ISNULL( CAST (IdTipoInscricaoANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacaoANT : «' + RTRIM( ISNULL( CAST (IdDetalheSituacaoANT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheSituacaoPOS : «' + RTRIM( ISNULL( CAST (IdDetalheSituacaoPOS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCategoriaProfANT : «' + RTRIM( ISNULL( CAST (IdCategoriaProfANT AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
