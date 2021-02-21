CREATE TABLE [dbo].[ConveniosSipro] (
    [IdConvenioSipro]          INT          IDENTITY (1, 1) NOT NULL,
    [CodConvenioSipro]         VARCHAR (20) NOT NULL,
    [IdCentroCustoReceita]     INT          NOT NULL,
    [IdConta]                  INT          NULL,
    [Situacao]                 BIT          NOT NULL,
    [Observacao]               TEXT         NULL,
    [SiglaUF]                  VARCHAR (2)  NULL,
    [CodSIC]                   VARCHAR (2)  NULL,
    [ImportacaoCONFEACREA]     BIT          CONSTRAINT [DF__Convenios__Impor__2C0B0D4C] DEFAULT ((0)) NULL,
    [Percentual]               MONEY        CONSTRAINT [DF__Convenios__Perce__6A372101] DEFAULT ((0)) NULL,
    [IdBanco]                  INT          NULL,
    [CodConvenioSiproRegional] VARCHAR (20) NULL,
    [CustoEPercentual]         BIT          NULL,
    [CustoValor]               MONEY        NULL,
    [FormaCalcFederal]         VARCHAR (1)  NULL,
    CONSTRAINT [PK_ConveniosSipro] PRIMARY KEY CLUSTERED ([IdConvenioSipro] ASC),
    CONSTRAINT [FK_ConveniosSipro_Bancos] FOREIGN KEY ([IdBanco]) REFERENCES [dbo].[Bancos] ([IdBanco]),
    CONSTRAINT [FK_ConveniosSipro_CentroCustosReceita] FOREIGN KEY ([IdCentroCustoReceita]) REFERENCES [dbo].[CentroCustosReceita] ([IdCentroCustoReceita]),
    CONSTRAINT [FK_ConveniosSipro_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE TRIGGER [TrgLog_ConveniosSipro] ON [Implanta_CRPAM].[dbo].[ConveniosSipro] 
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
SET @TableName = 'ConveniosSipro'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConvenioSipro : «' + RTRIM( ISNULL( CAST (IdConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenioSipro : «' + RTRIM( ISNULL( CAST (CodConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Situacao IS NULL THEN ' Situacao : «Nulo» '
                                              WHEN  Situacao = 0 THEN ' Situacao : «Falso» '
                                              WHEN  Situacao = 1 THEN ' Situacao : «Verdadeiro» '
                                    END 
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSIC : «' + RTRIM( ISNULL( CAST (CodSIC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImportacaoCONFEACREA IS NULL THEN ' ImportacaoCONFEACREA : «Nulo» '
                                              WHEN  ImportacaoCONFEACREA = 0 THEN ' ImportacaoCONFEACREA : «Falso» '
                                              WHEN  ImportacaoCONFEACREA = 1 THEN ' ImportacaoCONFEACREA : «Verdadeiro» '
                                    END 
                         + '| Percentual : «' + RTRIM( ISNULL( CAST (Percentual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenioSiproRegional : «' + RTRIM( ISNULL( CAST (CodConvenioSiproRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CustoEPercentual IS NULL THEN ' CustoEPercentual : «Nulo» '
                                              WHEN  CustoEPercentual = 0 THEN ' CustoEPercentual : «Falso» '
                                              WHEN  CustoEPercentual = 1 THEN ' CustoEPercentual : «Verdadeiro» '
                                    END 
                         + '| CustoValor : «' + RTRIM( ISNULL( CAST (CustoValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaCalcFederal : «' + RTRIM( ISNULL( CAST (FormaCalcFederal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConvenioSipro : «' + RTRIM( ISNULL( CAST (IdConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenioSipro : «' + RTRIM( ISNULL( CAST (CodConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Situacao IS NULL THEN ' Situacao : «Nulo» '
                                              WHEN  Situacao = 0 THEN ' Situacao : «Falso» '
                                              WHEN  Situacao = 1 THEN ' Situacao : «Verdadeiro» '
                                    END 
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSIC : «' + RTRIM( ISNULL( CAST (CodSIC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImportacaoCONFEACREA IS NULL THEN ' ImportacaoCONFEACREA : «Nulo» '
                                              WHEN  ImportacaoCONFEACREA = 0 THEN ' ImportacaoCONFEACREA : «Falso» '
                                              WHEN  ImportacaoCONFEACREA = 1 THEN ' ImportacaoCONFEACREA : «Verdadeiro» '
                                    END 
                         + '| Percentual : «' + RTRIM( ISNULL( CAST (Percentual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenioSiproRegional : «' + RTRIM( ISNULL( CAST (CodConvenioSiproRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CustoEPercentual IS NULL THEN ' CustoEPercentual : «Nulo» '
                                              WHEN  CustoEPercentual = 0 THEN ' CustoEPercentual : «Falso» '
                                              WHEN  CustoEPercentual = 1 THEN ' CustoEPercentual : «Verdadeiro» '
                                    END 
                         + '| CustoValor : «' + RTRIM( ISNULL( CAST (CustoValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaCalcFederal : «' + RTRIM( ISNULL( CAST (FormaCalcFederal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConvenioSipro : «' + RTRIM( ISNULL( CAST (IdConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenioSipro : «' + RTRIM( ISNULL( CAST (CodConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Situacao IS NULL THEN ' Situacao : «Nulo» '
                                              WHEN  Situacao = 0 THEN ' Situacao : «Falso» '
                                              WHEN  Situacao = 1 THEN ' Situacao : «Verdadeiro» '
                                    END 
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSIC : «' + RTRIM( ISNULL( CAST (CodSIC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImportacaoCONFEACREA IS NULL THEN ' ImportacaoCONFEACREA : «Nulo» '
                                              WHEN  ImportacaoCONFEACREA = 0 THEN ' ImportacaoCONFEACREA : «Falso» '
                                              WHEN  ImportacaoCONFEACREA = 1 THEN ' ImportacaoCONFEACREA : «Verdadeiro» '
                                    END 
                         + '| Percentual : «' + RTRIM( ISNULL( CAST (Percentual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenioSiproRegional : «' + RTRIM( ISNULL( CAST (CodConvenioSiproRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CustoEPercentual IS NULL THEN ' CustoEPercentual : «Nulo» '
                                              WHEN  CustoEPercentual = 0 THEN ' CustoEPercentual : «Falso» '
                                              WHEN  CustoEPercentual = 1 THEN ' CustoEPercentual : «Verdadeiro» '
                                    END 
                         + '| CustoValor : «' + RTRIM( ISNULL( CAST (CustoValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaCalcFederal : «' + RTRIM( ISNULL( CAST (FormaCalcFederal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConvenioSipro : «' + RTRIM( ISNULL( CAST (IdConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenioSipro : «' + RTRIM( ISNULL( CAST (CodConvenioSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Situacao IS NULL THEN ' Situacao : «Nulo» '
                                              WHEN  Situacao = 0 THEN ' Situacao : «Falso» '
                                              WHEN  Situacao = 1 THEN ' Situacao : «Verdadeiro» '
                                    END 
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodSIC : «' + RTRIM( ISNULL( CAST (CodSIC AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ImportacaoCONFEACREA IS NULL THEN ' ImportacaoCONFEACREA : «Nulo» '
                                              WHEN  ImportacaoCONFEACREA = 0 THEN ' ImportacaoCONFEACREA : «Falso» '
                                              WHEN  ImportacaoCONFEACREA = 1 THEN ' ImportacaoCONFEACREA : «Verdadeiro» '
                                    END 
                         + '| Percentual : «' + RTRIM( ISNULL( CAST (Percentual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConvenioSiproRegional : «' + RTRIM( ISNULL( CAST (CodConvenioSiproRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CustoEPercentual IS NULL THEN ' CustoEPercentual : «Nulo» '
                                              WHEN  CustoEPercentual = 0 THEN ' CustoEPercentual : «Falso» '
                                              WHEN  CustoEPercentual = 1 THEN ' CustoEPercentual : «Verdadeiro» '
                                    END 
                         + '| CustoValor : «' + RTRIM( ISNULL( CAST (CustoValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaCalcFederal : «' + RTRIM( ISNULL( CAST (FormaCalcFederal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
