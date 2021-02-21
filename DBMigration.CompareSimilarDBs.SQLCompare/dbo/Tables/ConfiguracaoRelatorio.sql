CREATE TABLE [dbo].[ConfiguracaoRelatorio] (
    [IdConfigRelatorio]    INT           IDENTITY (1, 1) NOT NULL,
    [IdUsuario]            INT           NULL,
    [TituloRelatorio]      VARCHAR (250) NULL,
    [NomeConfiguracao]     VARCHAR (250) NULL,
    [MargemSuperior]       FLOAT (53)    NULL,
    [MargemInferior]       FLOAT (53)    NULL,
    [MargemEsquerda]       FLOAT (53)    NULL,
    [MargemDireita]        FLOAT (53)    NULL,
    [LabelTotalizador]     VARCHAR (50)  NULL,
    [Impressora]           VARCHAR (100) NULL,
    [Orientacao]           BIT           NULL,
    [NumCopias]            INT           NULL,
    [ExibeNumeroFolhas]    BIT           NULL,
    [ExibeData]            BIT           NULL,
    [Zebrado]              BIT           NULL,
    [ExibirCliente]        BIT           NULL,
    [ExibirVersao]         BIT           NULL,
    [ForcaPaginaAposGrupo] BIT           NULL,
    [TipoFicha]            BIT           NULL,
    [Separador]            BIT           NULL,
    [TituloPersonalizado]  BIT           NULL,
    [PaginaInicial]        INT           NULL,
    [EspacoEntreLinhas]    FLOAT (53)    NULL,
    [Bandeja]              VARCHAR (25)  NULL,
    CONSTRAINT [PK_ConfiguracaoRelatorio] PRIMARY KEY CLUSTERED ([IdConfigRelatorio] ASC)
);


GO
CREATE TRIGGER [TrgLog_ConfiguracaoRelatorio] ON [Implanta_CRPAM].[dbo].[ConfiguracaoRelatorio] 
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
SET @TableName = 'ConfiguracaoRelatorio'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigRelatorio : «' + RTRIM( ISNULL( CAST (IdConfigRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelatorio : «' + RTRIM( ISNULL( CAST (TituloRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LabelTotalizador : «' + RTRIM( ISNULL( CAST (LabelTotalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Impressora : «' + RTRIM( ISNULL( CAST (Impressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Orientacao IS NULL THEN ' Orientacao : «Nulo» '
                                              WHEN  Orientacao = 0 THEN ' Orientacao : «Falso» '
                                              WHEN  Orientacao = 1 THEN ' Orientacao : «Verdadeiro» '
                                    END 
                         + '| NumCopias : «' + RTRIM( ISNULL( CAST (NumCopias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeNumeroFolhas IS NULL THEN ' ExibeNumeroFolhas : «Nulo» '
                                              WHEN  ExibeNumeroFolhas = 0 THEN ' ExibeNumeroFolhas : «Falso» '
                                              WHEN  ExibeNumeroFolhas = 1 THEN ' ExibeNumeroFolhas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeData IS NULL THEN ' ExibeData : «Nulo» '
                                              WHEN  ExibeData = 0 THEN ' ExibeData : «Falso» '
                                              WHEN  ExibeData = 1 THEN ' ExibeData : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Zebrado IS NULL THEN ' Zebrado : «Nulo» '
                                              WHEN  Zebrado = 0 THEN ' Zebrado : «Falso» '
                                              WHEN  Zebrado = 1 THEN ' Zebrado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirCliente IS NULL THEN ' ExibirCliente : «Nulo» '
                                              WHEN  ExibirCliente = 0 THEN ' ExibirCliente : «Falso» '
                                              WHEN  ExibirCliente = 1 THEN ' ExibirCliente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirVersao IS NULL THEN ' ExibirVersao : «Nulo» '
                                              WHEN  ExibirVersao = 0 THEN ' ExibirVersao : «Falso» '
                                              WHEN  ExibirVersao = 1 THEN ' ExibirVersao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ForcaPaginaAposGrupo IS NULL THEN ' ForcaPaginaAposGrupo : «Nulo» '
                                              WHEN  ForcaPaginaAposGrupo = 0 THEN ' ForcaPaginaAposGrupo : «Falso» '
                                              WHEN  ForcaPaginaAposGrupo = 1 THEN ' ForcaPaginaAposGrupo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TipoFicha IS NULL THEN ' TipoFicha : «Nulo» '
                                              WHEN  TipoFicha = 0 THEN ' TipoFicha : «Falso» '
                                              WHEN  TipoFicha = 1 THEN ' TipoFicha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Separador IS NULL THEN ' Separador : «Nulo» '
                                              WHEN  Separador = 0 THEN ' Separador : «Falso» '
                                              WHEN  Separador = 1 THEN ' Separador : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TituloPersonalizado IS NULL THEN ' TituloPersonalizado : «Nulo» '
                                              WHEN  TituloPersonalizado = 0 THEN ' TituloPersonalizado : «Falso» '
                                              WHEN  TituloPersonalizado = 1 THEN ' TituloPersonalizado : «Verdadeiro» '
                                    END 
                         + '| PaginaInicial : «' + RTRIM( ISNULL( CAST (PaginaInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EspacoEntreLinhas : «' + RTRIM( ISNULL( CAST (EspacoEntreLinhas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bandeja : «' + RTRIM( ISNULL( CAST (Bandeja AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigRelatorio : «' + RTRIM( ISNULL( CAST (IdConfigRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelatorio : «' + RTRIM( ISNULL( CAST (TituloRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LabelTotalizador : «' + RTRIM( ISNULL( CAST (LabelTotalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Impressora : «' + RTRIM( ISNULL( CAST (Impressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Orientacao IS NULL THEN ' Orientacao : «Nulo» '
                                              WHEN  Orientacao = 0 THEN ' Orientacao : «Falso» '
                                              WHEN  Orientacao = 1 THEN ' Orientacao : «Verdadeiro» '
                                    END 
                         + '| NumCopias : «' + RTRIM( ISNULL( CAST (NumCopias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeNumeroFolhas IS NULL THEN ' ExibeNumeroFolhas : «Nulo» '
                                              WHEN  ExibeNumeroFolhas = 0 THEN ' ExibeNumeroFolhas : «Falso» '
                                              WHEN  ExibeNumeroFolhas = 1 THEN ' ExibeNumeroFolhas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeData IS NULL THEN ' ExibeData : «Nulo» '
                                              WHEN  ExibeData = 0 THEN ' ExibeData : «Falso» '
                                              WHEN  ExibeData = 1 THEN ' ExibeData : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Zebrado IS NULL THEN ' Zebrado : «Nulo» '
                                              WHEN  Zebrado = 0 THEN ' Zebrado : «Falso» '
                                              WHEN  Zebrado = 1 THEN ' Zebrado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirCliente IS NULL THEN ' ExibirCliente : «Nulo» '
                                              WHEN  ExibirCliente = 0 THEN ' ExibirCliente : «Falso» '
                                              WHEN  ExibirCliente = 1 THEN ' ExibirCliente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirVersao IS NULL THEN ' ExibirVersao : «Nulo» '
                                              WHEN  ExibirVersao = 0 THEN ' ExibirVersao : «Falso» '
                                              WHEN  ExibirVersao = 1 THEN ' ExibirVersao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ForcaPaginaAposGrupo IS NULL THEN ' ForcaPaginaAposGrupo : «Nulo» '
                                              WHEN  ForcaPaginaAposGrupo = 0 THEN ' ForcaPaginaAposGrupo : «Falso» '
                                              WHEN  ForcaPaginaAposGrupo = 1 THEN ' ForcaPaginaAposGrupo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TipoFicha IS NULL THEN ' TipoFicha : «Nulo» '
                                              WHEN  TipoFicha = 0 THEN ' TipoFicha : «Falso» '
                                              WHEN  TipoFicha = 1 THEN ' TipoFicha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Separador IS NULL THEN ' Separador : «Nulo» '
                                              WHEN  Separador = 0 THEN ' Separador : «Falso» '
                                              WHEN  Separador = 1 THEN ' Separador : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TituloPersonalizado IS NULL THEN ' TituloPersonalizado : «Nulo» '
                                              WHEN  TituloPersonalizado = 0 THEN ' TituloPersonalizado : «Falso» '
                                              WHEN  TituloPersonalizado = 1 THEN ' TituloPersonalizado : «Verdadeiro» '
                                    END 
                         + '| PaginaInicial : «' + RTRIM( ISNULL( CAST (PaginaInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EspacoEntreLinhas : «' + RTRIM( ISNULL( CAST (EspacoEntreLinhas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bandeja : «' + RTRIM( ISNULL( CAST (Bandeja AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigRelatorio : «' + RTRIM( ISNULL( CAST (IdConfigRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelatorio : «' + RTRIM( ISNULL( CAST (TituloRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LabelTotalizador : «' + RTRIM( ISNULL( CAST (LabelTotalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Impressora : «' + RTRIM( ISNULL( CAST (Impressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Orientacao IS NULL THEN ' Orientacao : «Nulo» '
                                              WHEN  Orientacao = 0 THEN ' Orientacao : «Falso» '
                                              WHEN  Orientacao = 1 THEN ' Orientacao : «Verdadeiro» '
                                    END 
                         + '| NumCopias : «' + RTRIM( ISNULL( CAST (NumCopias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeNumeroFolhas IS NULL THEN ' ExibeNumeroFolhas : «Nulo» '
                                              WHEN  ExibeNumeroFolhas = 0 THEN ' ExibeNumeroFolhas : «Falso» '
                                              WHEN  ExibeNumeroFolhas = 1 THEN ' ExibeNumeroFolhas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeData IS NULL THEN ' ExibeData : «Nulo» '
                                              WHEN  ExibeData = 0 THEN ' ExibeData : «Falso» '
                                              WHEN  ExibeData = 1 THEN ' ExibeData : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Zebrado IS NULL THEN ' Zebrado : «Nulo» '
                                              WHEN  Zebrado = 0 THEN ' Zebrado : «Falso» '
                                              WHEN  Zebrado = 1 THEN ' Zebrado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirCliente IS NULL THEN ' ExibirCliente : «Nulo» '
                                              WHEN  ExibirCliente = 0 THEN ' ExibirCliente : «Falso» '
                                              WHEN  ExibirCliente = 1 THEN ' ExibirCliente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirVersao IS NULL THEN ' ExibirVersao : «Nulo» '
                                              WHEN  ExibirVersao = 0 THEN ' ExibirVersao : «Falso» '
                                              WHEN  ExibirVersao = 1 THEN ' ExibirVersao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ForcaPaginaAposGrupo IS NULL THEN ' ForcaPaginaAposGrupo : «Nulo» '
                                              WHEN  ForcaPaginaAposGrupo = 0 THEN ' ForcaPaginaAposGrupo : «Falso» '
                                              WHEN  ForcaPaginaAposGrupo = 1 THEN ' ForcaPaginaAposGrupo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TipoFicha IS NULL THEN ' TipoFicha : «Nulo» '
                                              WHEN  TipoFicha = 0 THEN ' TipoFicha : «Falso» '
                                              WHEN  TipoFicha = 1 THEN ' TipoFicha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Separador IS NULL THEN ' Separador : «Nulo» '
                                              WHEN  Separador = 0 THEN ' Separador : «Falso» '
                                              WHEN  Separador = 1 THEN ' Separador : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TituloPersonalizado IS NULL THEN ' TituloPersonalizado : «Nulo» '
                                              WHEN  TituloPersonalizado = 0 THEN ' TituloPersonalizado : «Falso» '
                                              WHEN  TituloPersonalizado = 1 THEN ' TituloPersonalizado : «Verdadeiro» '
                                    END 
                         + '| PaginaInicial : «' + RTRIM( ISNULL( CAST (PaginaInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EspacoEntreLinhas : «' + RTRIM( ISNULL( CAST (EspacoEntreLinhas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bandeja : «' + RTRIM( ISNULL( CAST (Bandeja AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigRelatorio : «' + RTRIM( ISNULL( CAST (IdConfigRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloRelatorio : «' + RTRIM( ISNULL( CAST (TituloRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LabelTotalizador : «' + RTRIM( ISNULL( CAST (LabelTotalizador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Impressora : «' + RTRIM( ISNULL( CAST (Impressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Orientacao IS NULL THEN ' Orientacao : «Nulo» '
                                              WHEN  Orientacao = 0 THEN ' Orientacao : «Falso» '
                                              WHEN  Orientacao = 1 THEN ' Orientacao : «Verdadeiro» '
                                    END 
                         + '| NumCopias : «' + RTRIM( ISNULL( CAST (NumCopias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibeNumeroFolhas IS NULL THEN ' ExibeNumeroFolhas : «Nulo» '
                                              WHEN  ExibeNumeroFolhas = 0 THEN ' ExibeNumeroFolhas : «Falso» '
                                              WHEN  ExibeNumeroFolhas = 1 THEN ' ExibeNumeroFolhas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibeData IS NULL THEN ' ExibeData : «Nulo» '
                                              WHEN  ExibeData = 0 THEN ' ExibeData : «Falso» '
                                              WHEN  ExibeData = 1 THEN ' ExibeData : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Zebrado IS NULL THEN ' Zebrado : «Nulo» '
                                              WHEN  Zebrado = 0 THEN ' Zebrado : «Falso» '
                                              WHEN  Zebrado = 1 THEN ' Zebrado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirCliente IS NULL THEN ' ExibirCliente : «Nulo» '
                                              WHEN  ExibirCliente = 0 THEN ' ExibirCliente : «Falso» '
                                              WHEN  ExibirCliente = 1 THEN ' ExibirCliente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirVersao IS NULL THEN ' ExibirVersao : «Nulo» '
                                              WHEN  ExibirVersao = 0 THEN ' ExibirVersao : «Falso» '
                                              WHEN  ExibirVersao = 1 THEN ' ExibirVersao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ForcaPaginaAposGrupo IS NULL THEN ' ForcaPaginaAposGrupo : «Nulo» '
                                              WHEN  ForcaPaginaAposGrupo = 0 THEN ' ForcaPaginaAposGrupo : «Falso» '
                                              WHEN  ForcaPaginaAposGrupo = 1 THEN ' ForcaPaginaAposGrupo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TipoFicha IS NULL THEN ' TipoFicha : «Nulo» '
                                              WHEN  TipoFicha = 0 THEN ' TipoFicha : «Falso» '
                                              WHEN  TipoFicha = 1 THEN ' TipoFicha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Separador IS NULL THEN ' Separador : «Nulo» '
                                              WHEN  Separador = 0 THEN ' Separador : «Falso» '
                                              WHEN  Separador = 1 THEN ' Separador : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TituloPersonalizado IS NULL THEN ' TituloPersonalizado : «Nulo» '
                                              WHEN  TituloPersonalizado = 0 THEN ' TituloPersonalizado : «Falso» '
                                              WHEN  TituloPersonalizado = 1 THEN ' TituloPersonalizado : «Verdadeiro» '
                                    END 
                         + '| PaginaInicial : «' + RTRIM( ISNULL( CAST (PaginaInicial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EspacoEntreLinhas : «' + RTRIM( ISNULL( CAST (EspacoEntreLinhas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bandeja : «' + RTRIM( ISNULL( CAST (Bandeja AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
