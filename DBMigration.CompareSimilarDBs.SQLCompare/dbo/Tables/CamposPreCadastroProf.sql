CREATE TABLE [dbo].[CamposPreCadastroProf] (
    [IdPreCadastroProf]      INT           IDENTITY (1, 1) NOT NULL,
    [NomeExibicao]           VARCHAR (100) NULL,
    [OrdemExibicao]          INT           NULL,
    [NomeCampo]              VARCHAR (100) NULL,
    [NomeTabela]             VARCHAR (100) NULL,
    [ConteudoAutomatico]     VARCHAR (100) NULL,
    [TipoApresentacaoCampo]  CHAR (1)      NULL,
    [Obrigatorio]            BIT           NULL,
    [IndExibeWeb]            BIT           DEFAULT ((0)) NULL,
    [IndPresencaObrigatoria] BIT           NULL,
    [IndGrupo]               INT           NULL,
    CONSTRAINT [PK_CAMPOS_PRE_CADASTRO] PRIMARY KEY CLUSTERED ([IdPreCadastroProf] ASC)
);


GO
CREATE TRIGGER [TrgLog_CamposPreCadastroProf] ON [Implanta_CRPAM].[dbo].[CamposPreCadastroProf] 
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
SET @TableName = 'CamposPreCadastroProf'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdPreCadastroProf : «' + RTRIM( ISNULL( CAST (IdPreCadastroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeExibicao : «' + RTRIM( ISNULL( CAST (NomeExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemExibicao : «' + RTRIM( ISNULL( CAST (OrdemExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConteudoAutomatico : «' + RTRIM( ISNULL( CAST (ConteudoAutomatico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoApresentacaoCampo : «' + RTRIM( ISNULL( CAST (TipoApresentacaoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatorio IS NULL THEN ' Obrigatorio : «Nulo» '
                                              WHEN  Obrigatorio = 0 THEN ' Obrigatorio : «Falso» '
                                              WHEN  Obrigatorio = 1 THEN ' Obrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndExibeWeb IS NULL THEN ' IndExibeWeb : «Nulo» '
                                              WHEN  IndExibeWeb = 0 THEN ' IndExibeWeb : «Falso» '
                                              WHEN  IndExibeWeb = 1 THEN ' IndExibeWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndPresencaObrigatoria IS NULL THEN ' IndPresencaObrigatoria : «Nulo» '
                                              WHEN  IndPresencaObrigatoria = 0 THEN ' IndPresencaObrigatoria : «Falso» '
                                              WHEN  IndPresencaObrigatoria = 1 THEN ' IndPresencaObrigatoria : «Verdadeiro» '
                                    END 
                         + '| IndGrupo : «' + RTRIM( ISNULL( CAST (IndGrupo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdPreCadastroProf : «' + RTRIM( ISNULL( CAST (IdPreCadastroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeExibicao : «' + RTRIM( ISNULL( CAST (NomeExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemExibicao : «' + RTRIM( ISNULL( CAST (OrdemExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConteudoAutomatico : «' + RTRIM( ISNULL( CAST (ConteudoAutomatico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoApresentacaoCampo : «' + RTRIM( ISNULL( CAST (TipoApresentacaoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatorio IS NULL THEN ' Obrigatorio : «Nulo» '
                                              WHEN  Obrigatorio = 0 THEN ' Obrigatorio : «Falso» '
                                              WHEN  Obrigatorio = 1 THEN ' Obrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndExibeWeb IS NULL THEN ' IndExibeWeb : «Nulo» '
                                              WHEN  IndExibeWeb = 0 THEN ' IndExibeWeb : «Falso» '
                                              WHEN  IndExibeWeb = 1 THEN ' IndExibeWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndPresencaObrigatoria IS NULL THEN ' IndPresencaObrigatoria : «Nulo» '
                                              WHEN  IndPresencaObrigatoria = 0 THEN ' IndPresencaObrigatoria : «Falso» '
                                              WHEN  IndPresencaObrigatoria = 1 THEN ' IndPresencaObrigatoria : «Verdadeiro» '
                                    END 
                         + '| IndGrupo : «' + RTRIM( ISNULL( CAST (IndGrupo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdPreCadastroProf : «' + RTRIM( ISNULL( CAST (IdPreCadastroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeExibicao : «' + RTRIM( ISNULL( CAST (NomeExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemExibicao : «' + RTRIM( ISNULL( CAST (OrdemExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConteudoAutomatico : «' + RTRIM( ISNULL( CAST (ConteudoAutomatico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoApresentacaoCampo : «' + RTRIM( ISNULL( CAST (TipoApresentacaoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatorio IS NULL THEN ' Obrigatorio : «Nulo» '
                                              WHEN  Obrigatorio = 0 THEN ' Obrigatorio : «Falso» '
                                              WHEN  Obrigatorio = 1 THEN ' Obrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndExibeWeb IS NULL THEN ' IndExibeWeb : «Nulo» '
                                              WHEN  IndExibeWeb = 0 THEN ' IndExibeWeb : «Falso» '
                                              WHEN  IndExibeWeb = 1 THEN ' IndExibeWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndPresencaObrigatoria IS NULL THEN ' IndPresencaObrigatoria : «Nulo» '
                                              WHEN  IndPresencaObrigatoria = 0 THEN ' IndPresencaObrigatoria : «Falso» '
                                              WHEN  IndPresencaObrigatoria = 1 THEN ' IndPresencaObrigatoria : «Verdadeiro» '
                                    END 
                         + '| IndGrupo : «' + RTRIM( ISNULL( CAST (IndGrupo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdPreCadastroProf : «' + RTRIM( ISNULL( CAST (IdPreCadastroProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeExibicao : «' + RTRIM( ISNULL( CAST (NomeExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemExibicao : «' + RTRIM( ISNULL( CAST (OrdemExibicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConteudoAutomatico : «' + RTRIM( ISNULL( CAST (ConteudoAutomatico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoApresentacaoCampo : «' + RTRIM( ISNULL( CAST (TipoApresentacaoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Obrigatorio IS NULL THEN ' Obrigatorio : «Nulo» '
                                              WHEN  Obrigatorio = 0 THEN ' Obrigatorio : «Falso» '
                                              WHEN  Obrigatorio = 1 THEN ' Obrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndExibeWeb IS NULL THEN ' IndExibeWeb : «Nulo» '
                                              WHEN  IndExibeWeb = 0 THEN ' IndExibeWeb : «Falso» '
                                              WHEN  IndExibeWeb = 1 THEN ' IndExibeWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndPresencaObrigatoria IS NULL THEN ' IndPresencaObrigatoria : «Nulo» '
                                              WHEN  IndPresencaObrigatoria = 0 THEN ' IndPresencaObrigatoria : «Falso» '
                                              WHEN  IndPresencaObrigatoria = 1 THEN ' IndPresencaObrigatoria : «Verdadeiro» '
                                    END 
                         + '| IndGrupo : «' + RTRIM( ISNULL( CAST (IndGrupo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
