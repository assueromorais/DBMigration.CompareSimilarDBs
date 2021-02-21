CREATE TABLE [dbo].[ConfigHeader] (
    [IdConfigHeader]    INT          IDENTITY (1, 1) NOT NULL,
    [CodigoBanco]       CHAR (3)     NOT NULL,
    [Posicoes]          INT          NOT NULL,
    [ValidaHeader]      BIT          CONSTRAINT [DF_ConfigHea_Valid] DEFAULT ((0)) NULL,
    [BancoInicio]       INT          NOT NULL,
    [BancoTamanho]      INT          NOT NULL,
    [BancoTexo]         VARCHAR (20) NOT NULL,
    [Valida1]           BIT          CONSTRAINT [DF_ConfigHea_Valida1] DEFAULT ((0)) NULL,
    [Valida1Inicio]     INT          NULL,
    [Valida1Tamanho]    INT          NULL,
    [Valida1Texto]      VARCHAR (20) NULL,
    [Valida2]           BIT          CONSTRAINT [DF_ConfigHea_Valida2] DEFAULT ((0)) NULL,
    [Valida2Inicio]     INT          NULL,
    [Valida2Tamanho]    INT          NULL,
    [Valida2Texto]      VARCHAR (20) NULL,
    [Valida3]           BIT          CONSTRAINT [DF_ConfigHea_Valida3] DEFAULT ((0)) NULL,
    [Valida3Inicio]     INT          NULL,
    [Valida3Tamanho]    INT          NULL,
    [Valida3Texto]      VARCHAR (20) NULL,
    [Valida4]           BIT          CONSTRAINT [DF_ConfigHea_Valida4] DEFAULT ((0)) NULL,
    [Valida4Inicio]     INT          NULL,
    [Valida4Tamanho]    INT          NULL,
    [Valida4Texto]      VARCHAR (20) NULL,
    [AgenciaValida]     BIT          NOT NULL,
    [AgenciaInicio]     INT          NOT NULL,
    [AgenciaTamanho]    INT          NOT NULL,
    [DVAgenciaValida]   BIT          NOT NULL,
    [DVAgenciaInicio]   INT          NOT NULL,
    [DVAgenciaTamanho]  INT          NOT NULL,
    [CedenteValida]     BIT          NOT NULL,
    [CedenteInicio]     INT          NOT NULL,
    [CedenteTamanho]    INT          NOT NULL,
    [ConvenioInicio]    INT          NULL,
    [ConvenioTamanho]   INT          NULL,
    [DataInicio]        INT          NOT NULL,
    [DataTamanho]       INT          NOT NULL,
    [SequenciaInicio]   INT          NOT NULL,
    [SequenciaTamanho]  INT          NOT NULL,
    [ContaLinhaInicio]  INT          NULL,
    [ContaLinhaTamanho] INT          NULL,
    [DebitoEmConta]     BIT          CONSTRAINT [DF_ConfigHeader_DebitoEmConta] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ConfigHeader] PRIMARY KEY CLUSTERED ([IdConfigHeader] ASC)
);


GO
CREATE TRIGGER [TrgLog_ConfigHeader] ON [Implanta_CRPAM].[dbo].[ConfigHeader] 
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
SET @TableName = 'ConfigHeader'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigHeader : «' + RTRIM( ISNULL( CAST (IdConfigHeader AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Posicoes : «' + RTRIM( ISNULL( CAST (Posicoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ValidaHeader IS NULL THEN ' ValidaHeader : «Nulo» '
                                              WHEN  ValidaHeader = 0 THEN ' ValidaHeader : «Falso» '
                                              WHEN  ValidaHeader = 1 THEN ' ValidaHeader : «Verdadeiro» '
                                    END 
                         + '| BancoInicio : «' + RTRIM( ISNULL( CAST (BancoInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BancoTamanho : «' + RTRIM( ISNULL( CAST (BancoTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BancoTexo : «' + RTRIM( ISNULL( CAST (BancoTexo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida1 IS NULL THEN ' Valida1 : «Nulo» '
                                              WHEN  Valida1 = 0 THEN ' Valida1 : «Falso» '
                                              WHEN  Valida1 = 1 THEN ' Valida1 : «Verdadeiro» '
                                    END 
                         + '| Valida1Inicio : «' + RTRIM( ISNULL( CAST (Valida1Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida1Tamanho : «' + RTRIM( ISNULL( CAST (Valida1Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida1Texto : «' + RTRIM( ISNULL( CAST (Valida1Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida2 IS NULL THEN ' Valida2 : «Nulo» '
                                              WHEN  Valida2 = 0 THEN ' Valida2 : «Falso» '
                                              WHEN  Valida2 = 1 THEN ' Valida2 : «Verdadeiro» '
                                    END 
                         + '| Valida2Inicio : «' + RTRIM( ISNULL( CAST (Valida2Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida2Tamanho : «' + RTRIM( ISNULL( CAST (Valida2Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida2Texto : «' + RTRIM( ISNULL( CAST (Valida2Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida3 IS NULL THEN ' Valida3 : «Nulo» '
                                              WHEN  Valida3 = 0 THEN ' Valida3 : «Falso» '
                                              WHEN  Valida3 = 1 THEN ' Valida3 : «Verdadeiro» '
                                    END 
                         + '| Valida3Inicio : «' + RTRIM( ISNULL( CAST (Valida3Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida3Tamanho : «' + RTRIM( ISNULL( CAST (Valida3Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida3Texto : «' + RTRIM( ISNULL( CAST (Valida3Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida4 IS NULL THEN ' Valida4 : «Nulo» '
                                              WHEN  Valida4 = 0 THEN ' Valida4 : «Falso» '
                                              WHEN  Valida4 = 1 THEN ' Valida4 : «Verdadeiro» '
                                    END 
                         + '| Valida4Inicio : «' + RTRIM( ISNULL( CAST (Valida4Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida4Tamanho : «' + RTRIM( ISNULL( CAST (Valida4Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida4Texto : «' + RTRIM( ISNULL( CAST (Valida4Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgenciaValida IS NULL THEN ' AgenciaValida : «Nulo» '
                                              WHEN  AgenciaValida = 0 THEN ' AgenciaValida : «Falso» '
                                              WHEN  AgenciaValida = 1 THEN ' AgenciaValida : «Verdadeiro» '
                                    END 
                         + '| AgenciaInicio : «' + RTRIM( ISNULL( CAST (AgenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgenciaTamanho : «' + RTRIM( ISNULL( CAST (AgenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DVAgenciaValida IS NULL THEN ' DVAgenciaValida : «Nulo» '
                                              WHEN  DVAgenciaValida = 0 THEN ' DVAgenciaValida : «Falso» '
                                              WHEN  DVAgenciaValida = 1 THEN ' DVAgenciaValida : «Verdadeiro» '
                                    END 
                         + '| DVAgenciaInicio : «' + RTRIM( ISNULL( CAST (DVAgenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgenciaTamanho : «' + RTRIM( ISNULL( CAST (DVAgenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CedenteValida IS NULL THEN ' CedenteValida : «Nulo» '
                                              WHEN  CedenteValida = 0 THEN ' CedenteValida : «Falso» '
                                              WHEN  CedenteValida = 1 THEN ' CedenteValida : «Verdadeiro» '
                                    END 
                         + '| CedenteInicio : «' + RTRIM( ISNULL( CAST (CedenteInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CedenteTamanho : «' + RTRIM( ISNULL( CAST (CedenteTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioInicio : «' + RTRIM( ISNULL( CAST (ConvenioInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioTamanho : «' + RTRIM( ISNULL( CAST (ConvenioTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CAST (DataInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTamanho : «' + RTRIM( ISNULL( CAST (DataTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaInicio : «' + RTRIM( ISNULL( CAST (SequenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaTamanho : «' + RTRIM( ISNULL( CAST (SequenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaLinhaInicio : «' + RTRIM( ISNULL( CAST (ContaLinhaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaLinhaTamanho : «' + RTRIM( ISNULL( CAST (ContaLinhaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DebitoEmConta IS NULL THEN ' DebitoEmConta : «Nulo» '
                                              WHEN  DebitoEmConta = 0 THEN ' DebitoEmConta : «Falso» '
                                              WHEN  DebitoEmConta = 1 THEN ' DebitoEmConta : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigHeader : «' + RTRIM( ISNULL( CAST (IdConfigHeader AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Posicoes : «' + RTRIM( ISNULL( CAST (Posicoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ValidaHeader IS NULL THEN ' ValidaHeader : «Nulo» '
                                              WHEN  ValidaHeader = 0 THEN ' ValidaHeader : «Falso» '
                                              WHEN  ValidaHeader = 1 THEN ' ValidaHeader : «Verdadeiro» '
                                    END 
                         + '| BancoInicio : «' + RTRIM( ISNULL( CAST (BancoInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BancoTamanho : «' + RTRIM( ISNULL( CAST (BancoTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BancoTexo : «' + RTRIM( ISNULL( CAST (BancoTexo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida1 IS NULL THEN ' Valida1 : «Nulo» '
                                              WHEN  Valida1 = 0 THEN ' Valida1 : «Falso» '
                                              WHEN  Valida1 = 1 THEN ' Valida1 : «Verdadeiro» '
                                    END 
                         + '| Valida1Inicio : «' + RTRIM( ISNULL( CAST (Valida1Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida1Tamanho : «' + RTRIM( ISNULL( CAST (Valida1Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida1Texto : «' + RTRIM( ISNULL( CAST (Valida1Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida2 IS NULL THEN ' Valida2 : «Nulo» '
                                              WHEN  Valida2 = 0 THEN ' Valida2 : «Falso» '
                                              WHEN  Valida2 = 1 THEN ' Valida2 : «Verdadeiro» '
                                    END 
                         + '| Valida2Inicio : «' + RTRIM( ISNULL( CAST (Valida2Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida2Tamanho : «' + RTRIM( ISNULL( CAST (Valida2Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida2Texto : «' + RTRIM( ISNULL( CAST (Valida2Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida3 IS NULL THEN ' Valida3 : «Nulo» '
                                              WHEN  Valida3 = 0 THEN ' Valida3 : «Falso» '
                                              WHEN  Valida3 = 1 THEN ' Valida3 : «Verdadeiro» '
                                    END 
                         + '| Valida3Inicio : «' + RTRIM( ISNULL( CAST (Valida3Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida3Tamanho : «' + RTRIM( ISNULL( CAST (Valida3Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida3Texto : «' + RTRIM( ISNULL( CAST (Valida3Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida4 IS NULL THEN ' Valida4 : «Nulo» '
                                              WHEN  Valida4 = 0 THEN ' Valida4 : «Falso» '
                                              WHEN  Valida4 = 1 THEN ' Valida4 : «Verdadeiro» '
                                    END 
                         + '| Valida4Inicio : «' + RTRIM( ISNULL( CAST (Valida4Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida4Tamanho : «' + RTRIM( ISNULL( CAST (Valida4Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida4Texto : «' + RTRIM( ISNULL( CAST (Valida4Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgenciaValida IS NULL THEN ' AgenciaValida : «Nulo» '
                                              WHEN  AgenciaValida = 0 THEN ' AgenciaValida : «Falso» '
                                              WHEN  AgenciaValida = 1 THEN ' AgenciaValida : «Verdadeiro» '
                                    END 
                         + '| AgenciaInicio : «' + RTRIM( ISNULL( CAST (AgenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgenciaTamanho : «' + RTRIM( ISNULL( CAST (AgenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DVAgenciaValida IS NULL THEN ' DVAgenciaValida : «Nulo» '
                                              WHEN  DVAgenciaValida = 0 THEN ' DVAgenciaValida : «Falso» '
                                              WHEN  DVAgenciaValida = 1 THEN ' DVAgenciaValida : «Verdadeiro» '
                                    END 
                         + '| DVAgenciaInicio : «' + RTRIM( ISNULL( CAST (DVAgenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgenciaTamanho : «' + RTRIM( ISNULL( CAST (DVAgenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CedenteValida IS NULL THEN ' CedenteValida : «Nulo» '
                                              WHEN  CedenteValida = 0 THEN ' CedenteValida : «Falso» '
                                              WHEN  CedenteValida = 1 THEN ' CedenteValida : «Verdadeiro» '
                                    END 
                         + '| CedenteInicio : «' + RTRIM( ISNULL( CAST (CedenteInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CedenteTamanho : «' + RTRIM( ISNULL( CAST (CedenteTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioInicio : «' + RTRIM( ISNULL( CAST (ConvenioInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioTamanho : «' + RTRIM( ISNULL( CAST (ConvenioTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CAST (DataInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTamanho : «' + RTRIM( ISNULL( CAST (DataTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaInicio : «' + RTRIM( ISNULL( CAST (SequenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaTamanho : «' + RTRIM( ISNULL( CAST (SequenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaLinhaInicio : «' + RTRIM( ISNULL( CAST (ContaLinhaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaLinhaTamanho : «' + RTRIM( ISNULL( CAST (ContaLinhaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DebitoEmConta IS NULL THEN ' DebitoEmConta : «Nulo» '
                                              WHEN  DebitoEmConta = 0 THEN ' DebitoEmConta : «Falso» '
                                              WHEN  DebitoEmConta = 1 THEN ' DebitoEmConta : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdConfigHeader : «' + RTRIM( ISNULL( CAST (IdConfigHeader AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Posicoes : «' + RTRIM( ISNULL( CAST (Posicoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ValidaHeader IS NULL THEN ' ValidaHeader : «Nulo» '
                                              WHEN  ValidaHeader = 0 THEN ' ValidaHeader : «Falso» '
                                              WHEN  ValidaHeader = 1 THEN ' ValidaHeader : «Verdadeiro» '
                                    END 
                         + '| BancoInicio : «' + RTRIM( ISNULL( CAST (BancoInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BancoTamanho : «' + RTRIM( ISNULL( CAST (BancoTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BancoTexo : «' + RTRIM( ISNULL( CAST (BancoTexo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida1 IS NULL THEN ' Valida1 : «Nulo» '
                                              WHEN  Valida1 = 0 THEN ' Valida1 : «Falso» '
                                              WHEN  Valida1 = 1 THEN ' Valida1 : «Verdadeiro» '
                                    END 
                         + '| Valida1Inicio : «' + RTRIM( ISNULL( CAST (Valida1Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida1Tamanho : «' + RTRIM( ISNULL( CAST (Valida1Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida1Texto : «' + RTRIM( ISNULL( CAST (Valida1Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida2 IS NULL THEN ' Valida2 : «Nulo» '
                                              WHEN  Valida2 = 0 THEN ' Valida2 : «Falso» '
                                              WHEN  Valida2 = 1 THEN ' Valida2 : «Verdadeiro» '
                                    END 
                         + '| Valida2Inicio : «' + RTRIM( ISNULL( CAST (Valida2Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida2Tamanho : «' + RTRIM( ISNULL( CAST (Valida2Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida2Texto : «' + RTRIM( ISNULL( CAST (Valida2Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida3 IS NULL THEN ' Valida3 : «Nulo» '
                                              WHEN  Valida3 = 0 THEN ' Valida3 : «Falso» '
                                              WHEN  Valida3 = 1 THEN ' Valida3 : «Verdadeiro» '
                                    END 
                         + '| Valida3Inicio : «' + RTRIM( ISNULL( CAST (Valida3Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida3Tamanho : «' + RTRIM( ISNULL( CAST (Valida3Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida3Texto : «' + RTRIM( ISNULL( CAST (Valida3Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida4 IS NULL THEN ' Valida4 : «Nulo» '
                                              WHEN  Valida4 = 0 THEN ' Valida4 : «Falso» '
                                              WHEN  Valida4 = 1 THEN ' Valida4 : «Verdadeiro» '
                                    END 
                         + '| Valida4Inicio : «' + RTRIM( ISNULL( CAST (Valida4Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida4Tamanho : «' + RTRIM( ISNULL( CAST (Valida4Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida4Texto : «' + RTRIM( ISNULL( CAST (Valida4Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgenciaValida IS NULL THEN ' AgenciaValida : «Nulo» '
                                              WHEN  AgenciaValida = 0 THEN ' AgenciaValida : «Falso» '
                                              WHEN  AgenciaValida = 1 THEN ' AgenciaValida : «Verdadeiro» '
                                    END 
                         + '| AgenciaInicio : «' + RTRIM( ISNULL( CAST (AgenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgenciaTamanho : «' + RTRIM( ISNULL( CAST (AgenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DVAgenciaValida IS NULL THEN ' DVAgenciaValida : «Nulo» '
                                              WHEN  DVAgenciaValida = 0 THEN ' DVAgenciaValida : «Falso» '
                                              WHEN  DVAgenciaValida = 1 THEN ' DVAgenciaValida : «Verdadeiro» '
                                    END 
                         + '| DVAgenciaInicio : «' + RTRIM( ISNULL( CAST (DVAgenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgenciaTamanho : «' + RTRIM( ISNULL( CAST (DVAgenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CedenteValida IS NULL THEN ' CedenteValida : «Nulo» '
                                              WHEN  CedenteValida = 0 THEN ' CedenteValida : «Falso» '
                                              WHEN  CedenteValida = 1 THEN ' CedenteValida : «Verdadeiro» '
                                    END 
                         + '| CedenteInicio : «' + RTRIM( ISNULL( CAST (CedenteInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CedenteTamanho : «' + RTRIM( ISNULL( CAST (CedenteTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioInicio : «' + RTRIM( ISNULL( CAST (ConvenioInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioTamanho : «' + RTRIM( ISNULL( CAST (ConvenioTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CAST (DataInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTamanho : «' + RTRIM( ISNULL( CAST (DataTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaInicio : «' + RTRIM( ISNULL( CAST (SequenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaTamanho : «' + RTRIM( ISNULL( CAST (SequenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaLinhaInicio : «' + RTRIM( ISNULL( CAST (ContaLinhaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaLinhaTamanho : «' + RTRIM( ISNULL( CAST (ContaLinhaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DebitoEmConta IS NULL THEN ' DebitoEmConta : «Nulo» '
                                              WHEN  DebitoEmConta = 0 THEN ' DebitoEmConta : «Falso» '
                                              WHEN  DebitoEmConta = 1 THEN ' DebitoEmConta : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigHeader : «' + RTRIM( ISNULL( CAST (IdConfigHeader AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Posicoes : «' + RTRIM( ISNULL( CAST (Posicoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ValidaHeader IS NULL THEN ' ValidaHeader : «Nulo» '
                                              WHEN  ValidaHeader = 0 THEN ' ValidaHeader : «Falso» '
                                              WHEN  ValidaHeader = 1 THEN ' ValidaHeader : «Verdadeiro» '
                                    END 
                         + '| BancoInicio : «' + RTRIM( ISNULL( CAST (BancoInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BancoTamanho : «' + RTRIM( ISNULL( CAST (BancoTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BancoTexo : «' + RTRIM( ISNULL( CAST (BancoTexo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida1 IS NULL THEN ' Valida1 : «Nulo» '
                                              WHEN  Valida1 = 0 THEN ' Valida1 : «Falso» '
                                              WHEN  Valida1 = 1 THEN ' Valida1 : «Verdadeiro» '
                                    END 
                         + '| Valida1Inicio : «' + RTRIM( ISNULL( CAST (Valida1Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida1Tamanho : «' + RTRIM( ISNULL( CAST (Valida1Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida1Texto : «' + RTRIM( ISNULL( CAST (Valida1Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida2 IS NULL THEN ' Valida2 : «Nulo» '
                                              WHEN  Valida2 = 0 THEN ' Valida2 : «Falso» '
                                              WHEN  Valida2 = 1 THEN ' Valida2 : «Verdadeiro» '
                                    END 
                         + '| Valida2Inicio : «' + RTRIM( ISNULL( CAST (Valida2Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida2Tamanho : «' + RTRIM( ISNULL( CAST (Valida2Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida2Texto : «' + RTRIM( ISNULL( CAST (Valida2Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida3 IS NULL THEN ' Valida3 : «Nulo» '
                                              WHEN  Valida3 = 0 THEN ' Valida3 : «Falso» '
                                              WHEN  Valida3 = 1 THEN ' Valida3 : «Verdadeiro» '
                                    END 
                         + '| Valida3Inicio : «' + RTRIM( ISNULL( CAST (Valida3Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida3Tamanho : «' + RTRIM( ISNULL( CAST (Valida3Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida3Texto : «' + RTRIM( ISNULL( CAST (Valida3Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Valida4 IS NULL THEN ' Valida4 : «Nulo» '
                                              WHEN  Valida4 = 0 THEN ' Valida4 : «Falso» '
                                              WHEN  Valida4 = 1 THEN ' Valida4 : «Verdadeiro» '
                                    END 
                         + '| Valida4Inicio : «' + RTRIM( ISNULL( CAST (Valida4Inicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida4Tamanho : «' + RTRIM( ISNULL( CAST (Valida4Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valida4Texto : «' + RTRIM( ISNULL( CAST (Valida4Texto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AgenciaValida IS NULL THEN ' AgenciaValida : «Nulo» '
                                              WHEN  AgenciaValida = 0 THEN ' AgenciaValida : «Falso» '
                                              WHEN  AgenciaValida = 1 THEN ' AgenciaValida : «Verdadeiro» '
                                    END 
                         + '| AgenciaInicio : «' + RTRIM( ISNULL( CAST (AgenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AgenciaTamanho : «' + RTRIM( ISNULL( CAST (AgenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DVAgenciaValida IS NULL THEN ' DVAgenciaValida : «Nulo» '
                                              WHEN  DVAgenciaValida = 0 THEN ' DVAgenciaValida : «Falso» '
                                              WHEN  DVAgenciaValida = 1 THEN ' DVAgenciaValida : «Verdadeiro» '
                                    END 
                         + '| DVAgenciaInicio : «' + RTRIM( ISNULL( CAST (DVAgenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgenciaTamanho : «' + RTRIM( ISNULL( CAST (DVAgenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CedenteValida IS NULL THEN ' CedenteValida : «Nulo» '
                                              WHEN  CedenteValida = 0 THEN ' CedenteValida : «Falso» '
                                              WHEN  CedenteValida = 1 THEN ' CedenteValida : «Verdadeiro» '
                                    END 
                         + '| CedenteInicio : «' + RTRIM( ISNULL( CAST (CedenteInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CedenteTamanho : «' + RTRIM( ISNULL( CAST (CedenteTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioInicio : «' + RTRIM( ISNULL( CAST (ConvenioInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioTamanho : «' + RTRIM( ISNULL( CAST (ConvenioTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CAST (DataInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTamanho : «' + RTRIM( ISNULL( CAST (DataTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaInicio : «' + RTRIM( ISNULL( CAST (SequenciaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequenciaTamanho : «' + RTRIM( ISNULL( CAST (SequenciaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaLinhaInicio : «' + RTRIM( ISNULL( CAST (ContaLinhaInicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaLinhaTamanho : «' + RTRIM( ISNULL( CAST (ContaLinhaTamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DebitoEmConta IS NULL THEN ' DebitoEmConta : «Nulo» '
                                              WHEN  DebitoEmConta = 0 THEN ' DebitoEmConta : «Falso» '
                                              WHEN  DebitoEmConta = 1 THEN ' DebitoEmConta : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
