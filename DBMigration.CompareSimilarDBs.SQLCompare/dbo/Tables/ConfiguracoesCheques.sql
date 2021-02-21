CREATE TABLE [dbo].[ConfiguracoesCheques] (
    [IdBanco]                 INT          NOT NULL,
    [InicioTopo]              VARCHAR (4)  NOT NULL,
    [DistanciaLinhas]         VARCHAR (4)  NOT NULL,
    [InicioValor]             VARCHAR (4)  NOT NULL,
    [InicioExtenso]           VARCHAR (4)  NOT NULL,
    [Largura]                 VARCHAR (4)  NOT NULL,
    [Margem]                  VARCHAR (4)  NOT NULL,
    [DistLocal]               VARCHAR (4)  NOT NULL,
    [DistDia]                 VARCHAR (4)  NOT NULL,
    [DistMes]                 VARCHAR (4)  NOT NULL,
    [DistAno]                 VARCHAR (4)  NOT NULL,
    [Impressora]              VARCHAR (80) NOT NULL,
    [TipoImpressora]          INT          NOT NULL,
    [DigitosAno]              VARCHAR (1)  NOT NULL,
    [IdConfiguracaoCheque]    INT          IDENTITY (1, 1) NOT NULL,
    [DistNomeData]            VARCHAR (4)  CONSTRAINT [DF__Configura__DistN__3FC721DF] DEFAULT ('0') NOT NULL,
    [Altura]                  VARCHAR (4)  NULL,
    [CanhDataAltura]          VARCHAR (4)  NULL,
    [CanhDescAltura]          VARCHAR (4)  NULL,
    [CanhDistNomeFavorecido]  VARCHAR (4)  NULL,
    [CanhMargemData]          VARCHAR (4)  NULL,
    [CanhMargemDescricao]     VARCHAR (4)  NULL,
    [CanhMargemNomeFavorecio] VARCHAR (4)  NULL,
    [CanhMargemValor]         VARCHAR (4)  NULL,
    [CanhotoLargura]          VARCHAR (4)  NULL,
    [CanhValorAltura]         VARCHAR (4)  NULL,
    [UtilizaCanhoto]          BIT          DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ConfiguracoesCheques] PRIMARY KEY CLUSTERED ([IdConfiguracaoCheque] ASC),
    CONSTRAINT [FK_ConfiguracoesCheques_Bancos] FOREIGN KEY ([IdBanco]) REFERENCES [dbo].[Bancos] ([IdBanco])
);


GO
CREATE TRIGGER [TrgLog_ConfiguracoesCheques] ON [Implanta_CRPAM].[dbo].[ConfiguracoesCheques] 
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
SET @TableName = 'ConfiguracoesCheques'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioTopo : «' + RTRIM( ISNULL( CAST (InicioTopo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaLinhas : «' + RTRIM( ISNULL( CAST (DistanciaLinhas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioValor : «' + RTRIM( ISNULL( CAST (InicioValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioExtenso : «' + RTRIM( ISNULL( CAST (InicioExtenso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura : «' + RTRIM( ISNULL( CAST (Largura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Margem : «' + RTRIM( ISNULL( CAST (Margem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistLocal : «' + RTRIM( ISNULL( CAST (DistLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistDia : «' + RTRIM( ISNULL( CAST (DistDia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistMes : «' + RTRIM( ISNULL( CAST (DistMes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistAno : «' + RTRIM( ISNULL( CAST (DistAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Impressora : «' + RTRIM( ISNULL( CAST (Impressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DigitosAno : «' + RTRIM( ISNULL( CAST (DigitosAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfiguracaoCheque : «' + RTRIM( ISNULL( CAST (IdConfiguracaoCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistNomeData : «' + RTRIM( ISNULL( CAST (DistNomeData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura : «' + RTRIM( ISNULL( CAST (Altura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDataAltura : «' + RTRIM( ISNULL( CAST (CanhDataAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDescAltura : «' + RTRIM( ISNULL( CAST (CanhDescAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDistNomeFavorecido : «' + RTRIM( ISNULL( CAST (CanhDistNomeFavorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemData : «' + RTRIM( ISNULL( CAST (CanhMargemData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemDescricao : «' + RTRIM( ISNULL( CAST (CanhMargemDescricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemNomeFavorecio : «' + RTRIM( ISNULL( CAST (CanhMargemNomeFavorecio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemValor : «' + RTRIM( ISNULL( CAST (CanhMargemValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhotoLargura : «' + RTRIM( ISNULL( CAST (CanhotoLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhValorAltura : «' + RTRIM( ISNULL( CAST (CanhValorAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaCanhoto IS NULL THEN ' UtilizaCanhoto : «Nulo» '
                                              WHEN  UtilizaCanhoto = 0 THEN ' UtilizaCanhoto : «Falso» '
                                              WHEN  UtilizaCanhoto = 1 THEN ' UtilizaCanhoto : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioTopo : «' + RTRIM( ISNULL( CAST (InicioTopo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaLinhas : «' + RTRIM( ISNULL( CAST (DistanciaLinhas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioValor : «' + RTRIM( ISNULL( CAST (InicioValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioExtenso : «' + RTRIM( ISNULL( CAST (InicioExtenso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura : «' + RTRIM( ISNULL( CAST (Largura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Margem : «' + RTRIM( ISNULL( CAST (Margem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistLocal : «' + RTRIM( ISNULL( CAST (DistLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistDia : «' + RTRIM( ISNULL( CAST (DistDia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistMes : «' + RTRIM( ISNULL( CAST (DistMes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistAno : «' + RTRIM( ISNULL( CAST (DistAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Impressora : «' + RTRIM( ISNULL( CAST (Impressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DigitosAno : «' + RTRIM( ISNULL( CAST (DigitosAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfiguracaoCheque : «' + RTRIM( ISNULL( CAST (IdConfiguracaoCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistNomeData : «' + RTRIM( ISNULL( CAST (DistNomeData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura : «' + RTRIM( ISNULL( CAST (Altura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDataAltura : «' + RTRIM( ISNULL( CAST (CanhDataAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDescAltura : «' + RTRIM( ISNULL( CAST (CanhDescAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDistNomeFavorecido : «' + RTRIM( ISNULL( CAST (CanhDistNomeFavorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemData : «' + RTRIM( ISNULL( CAST (CanhMargemData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemDescricao : «' + RTRIM( ISNULL( CAST (CanhMargemDescricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemNomeFavorecio : «' + RTRIM( ISNULL( CAST (CanhMargemNomeFavorecio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemValor : «' + RTRIM( ISNULL( CAST (CanhMargemValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhotoLargura : «' + RTRIM( ISNULL( CAST (CanhotoLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhValorAltura : «' + RTRIM( ISNULL( CAST (CanhValorAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaCanhoto IS NULL THEN ' UtilizaCanhoto : «Nulo» '
                                              WHEN  UtilizaCanhoto = 0 THEN ' UtilizaCanhoto : «Falso» '
                                              WHEN  UtilizaCanhoto = 1 THEN ' UtilizaCanhoto : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioTopo : «' + RTRIM( ISNULL( CAST (InicioTopo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaLinhas : «' + RTRIM( ISNULL( CAST (DistanciaLinhas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioValor : «' + RTRIM( ISNULL( CAST (InicioValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioExtenso : «' + RTRIM( ISNULL( CAST (InicioExtenso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura : «' + RTRIM( ISNULL( CAST (Largura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Margem : «' + RTRIM( ISNULL( CAST (Margem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistLocal : «' + RTRIM( ISNULL( CAST (DistLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistDia : «' + RTRIM( ISNULL( CAST (DistDia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistMes : «' + RTRIM( ISNULL( CAST (DistMes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistAno : «' + RTRIM( ISNULL( CAST (DistAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Impressora : «' + RTRIM( ISNULL( CAST (Impressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DigitosAno : «' + RTRIM( ISNULL( CAST (DigitosAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfiguracaoCheque : «' + RTRIM( ISNULL( CAST (IdConfiguracaoCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistNomeData : «' + RTRIM( ISNULL( CAST (DistNomeData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura : «' + RTRIM( ISNULL( CAST (Altura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDataAltura : «' + RTRIM( ISNULL( CAST (CanhDataAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDescAltura : «' + RTRIM( ISNULL( CAST (CanhDescAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDistNomeFavorecido : «' + RTRIM( ISNULL( CAST (CanhDistNomeFavorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemData : «' + RTRIM( ISNULL( CAST (CanhMargemData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemDescricao : «' + RTRIM( ISNULL( CAST (CanhMargemDescricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemNomeFavorecio : «' + RTRIM( ISNULL( CAST (CanhMargemNomeFavorecio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemValor : «' + RTRIM( ISNULL( CAST (CanhMargemValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhotoLargura : «' + RTRIM( ISNULL( CAST (CanhotoLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhValorAltura : «' + RTRIM( ISNULL( CAST (CanhValorAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaCanhoto IS NULL THEN ' UtilizaCanhoto : «Nulo» '
                                              WHEN  UtilizaCanhoto = 0 THEN ' UtilizaCanhoto : «Falso» '
                                              WHEN  UtilizaCanhoto = 1 THEN ' UtilizaCanhoto : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioTopo : «' + RTRIM( ISNULL( CAST (InicioTopo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaLinhas : «' + RTRIM( ISNULL( CAST (DistanciaLinhas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioValor : «' + RTRIM( ISNULL( CAST (InicioValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioExtenso : «' + RTRIM( ISNULL( CAST (InicioExtenso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura : «' + RTRIM( ISNULL( CAST (Largura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Margem : «' + RTRIM( ISNULL( CAST (Margem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistLocal : «' + RTRIM( ISNULL( CAST (DistLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistDia : «' + RTRIM( ISNULL( CAST (DistDia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistMes : «' + RTRIM( ISNULL( CAST (DistMes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistAno : «' + RTRIM( ISNULL( CAST (DistAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Impressora : «' + RTRIM( ISNULL( CAST (Impressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DigitosAno : «' + RTRIM( ISNULL( CAST (DigitosAno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfiguracaoCheque : «' + RTRIM( ISNULL( CAST (IdConfiguracaoCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistNomeData : «' + RTRIM( ISNULL( CAST (DistNomeData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura : «' + RTRIM( ISNULL( CAST (Altura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDataAltura : «' + RTRIM( ISNULL( CAST (CanhDataAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDescAltura : «' + RTRIM( ISNULL( CAST (CanhDescAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhDistNomeFavorecido : «' + RTRIM( ISNULL( CAST (CanhDistNomeFavorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemData : «' + RTRIM( ISNULL( CAST (CanhMargemData AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemDescricao : «' + RTRIM( ISNULL( CAST (CanhMargemDescricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemNomeFavorecio : «' + RTRIM( ISNULL( CAST (CanhMargemNomeFavorecio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhMargemValor : «' + RTRIM( ISNULL( CAST (CanhMargemValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhotoLargura : «' + RTRIM( ISNULL( CAST (CanhotoLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanhValorAltura : «' + RTRIM( ISNULL( CAST (CanhValorAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaCanhoto IS NULL THEN ' UtilizaCanhoto : «Nulo» '
                                              WHEN  UtilizaCanhoto = 0 THEN ' UtilizaCanhoto : «Falso» '
                                              WHEN  UtilizaCanhoto = 1 THEN ' UtilizaCanhoto : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
