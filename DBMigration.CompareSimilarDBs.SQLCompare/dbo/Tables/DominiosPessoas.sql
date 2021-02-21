CREATE TABLE [dbo].[DominiosPessoas] (
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
    [strComplemento]   VARCHAR (40)  NULL,
    [DominioElemento]  BIT           NULL
);


GO
CREATE TRIGGER [TrgLog_DominiosPessoas] ON [Implanta_CRPAM].[dbo].[DominiosPessoas] 
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
SET @TableName = 'DominiosPessoas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TabelaJoin : «' + RTRIM( ISNULL( CAST (TabelaJoin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alias_Campo : «' + RTRIM( ISNULL( CAST (Alias_Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCampo : «' + RTRIM( ISNULL( CAST (TipoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoCampo : «' + RTRIM( ISNULL( CAST (TamanhoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Grupo : «' + RTRIM( ISNULL( CAST (Grupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conjunto : «' + RTRIM( ISNULL( CAST (Conjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Dominio : «' + RTRIM( ISNULL( CAST (Dominio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alinhamento : «' + RTRIM( ISNULL( CAST (Alinhamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CasasDecimais : «' + RTRIM( ISNULL( CAST (CasasDecimais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PadraoRepeticao IS NULL THEN ' PadraoRepeticao : «Nulo» '
                                              WHEN  PadraoRepeticao = 0 THEN ' PadraoRepeticao : «Falso» '
                                              WHEN  PadraoRepeticao = 1 THEN ' PadraoRepeticao : «Verdadeiro» '
                                    END 
                         + '| Criterio_Selecao : «' + RTRIM( ISNULL( CAST (Criterio_Selecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Acesso : «' + RTRIM( ISNULL( CAST (Acesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| strComplemento : «' + RTRIM( ISNULL( CAST (strComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DominioElemento IS NULL THEN ' DominioElemento : «Nulo» '
                                              WHEN  DominioElemento = 0 THEN ' DominioElemento : «Falso» '
                                              WHEN  DominioElemento = 1 THEN ' DominioElemento : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TabelaJoin : «' + RTRIM( ISNULL( CAST (TabelaJoin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alias_Campo : «' + RTRIM( ISNULL( CAST (Alias_Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCampo : «' + RTRIM( ISNULL( CAST (TipoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoCampo : «' + RTRIM( ISNULL( CAST (TamanhoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Grupo : «' + RTRIM( ISNULL( CAST (Grupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conjunto : «' + RTRIM( ISNULL( CAST (Conjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Dominio : «' + RTRIM( ISNULL( CAST (Dominio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alinhamento : «' + RTRIM( ISNULL( CAST (Alinhamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CasasDecimais : «' + RTRIM( ISNULL( CAST (CasasDecimais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PadraoRepeticao IS NULL THEN ' PadraoRepeticao : «Nulo» '
                                              WHEN  PadraoRepeticao = 0 THEN ' PadraoRepeticao : «Falso» '
                                              WHEN  PadraoRepeticao = 1 THEN ' PadraoRepeticao : «Verdadeiro» '
                                    END 
                         + '| Criterio_Selecao : «' + RTRIM( ISNULL( CAST (Criterio_Selecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Acesso : «' + RTRIM( ISNULL( CAST (Acesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| strComplemento : «' + RTRIM( ISNULL( CAST (strComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DominioElemento IS NULL THEN ' DominioElemento : «Nulo» '
                                              WHEN  DominioElemento = 0 THEN ' DominioElemento : «Falso» '
                                              WHEN  DominioElemento = 1 THEN ' DominioElemento : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TabelaJoin : «' + RTRIM( ISNULL( CAST (TabelaJoin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alias_Campo : «' + RTRIM( ISNULL( CAST (Alias_Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCampo : «' + RTRIM( ISNULL( CAST (TipoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoCampo : «' + RTRIM( ISNULL( CAST (TamanhoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Grupo : «' + RTRIM( ISNULL( CAST (Grupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conjunto : «' + RTRIM( ISNULL( CAST (Conjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Dominio : «' + RTRIM( ISNULL( CAST (Dominio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alinhamento : «' + RTRIM( ISNULL( CAST (Alinhamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CasasDecimais : «' + RTRIM( ISNULL( CAST (CasasDecimais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PadraoRepeticao IS NULL THEN ' PadraoRepeticao : «Nulo» '
                                              WHEN  PadraoRepeticao = 0 THEN ' PadraoRepeticao : «Falso» '
                                              WHEN  PadraoRepeticao = 1 THEN ' PadraoRepeticao : «Verdadeiro» '
                                    END 
                         + '| Criterio_Selecao : «' + RTRIM( ISNULL( CAST (Criterio_Selecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Acesso : «' + RTRIM( ISNULL( CAST (Acesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| strComplemento : «' + RTRIM( ISNULL( CAST (strComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DominioElemento IS NULL THEN ' DominioElemento : «Nulo» '
                                              WHEN  DominioElemento = 0 THEN ' DominioElemento : «Falso» '
                                              WHEN  DominioElemento = 1 THEN ' DominioElemento : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TabelaJoin : «' + RTRIM( ISNULL( CAST (TabelaJoin AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alias_Campo : «' + RTRIM( ISNULL( CAST (Alias_Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCampo : «' + RTRIM( ISNULL( CAST (TipoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoCampo : «' + RTRIM( ISNULL( CAST (TamanhoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Grupo : «' + RTRIM( ISNULL( CAST (Grupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conjunto : «' + RTRIM( ISNULL( CAST (Conjunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Dominio : «' + RTRIM( ISNULL( CAST (Dominio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alinhamento : «' + RTRIM( ISNULL( CAST (Alinhamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CasasDecimais : «' + RTRIM( ISNULL( CAST (CasasDecimais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PadraoRepeticao IS NULL THEN ' PadraoRepeticao : «Nulo» '
                                              WHEN  PadraoRepeticao = 0 THEN ' PadraoRepeticao : «Falso» '
                                              WHEN  PadraoRepeticao = 1 THEN ' PadraoRepeticao : «Verdadeiro» '
                                    END 
                         + '| Criterio_Selecao : «' + RTRIM( ISNULL( CAST (Criterio_Selecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Acesso : «' + RTRIM( ISNULL( CAST (Acesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| strComplemento : «' + RTRIM( ISNULL( CAST (strComplemento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DominioElemento IS NULL THEN ' DominioElemento : «Nulo» '
                                              WHEN  DominioElemento = 0 THEN ' DominioElemento : «Falso» '
                                              WHEN  DominioElemento = 1 THEN ' DominioElemento : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
