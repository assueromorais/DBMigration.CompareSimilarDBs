CREATE TABLE [dbo].[Bancos] (
    [IdBanco]                   INT          IDENTITY (1, 1) NOT NULL,
    [CodBanco]                  VARCHAR (3)  NOT NULL,
    [CodContaBanco]             VARCHAR (11) NULL,
    [NomeBanco]                 VARCHAR (60) NOT NULL,
    [Operacao]                  VARCHAR (3)  NULL,
    [IdConta]                   INT          NOT NULL,
    [ProximoNumeroCheque]       INT          NULL,
    [E_Padrao]                  BIT          NOT NULL,
    [Convenio]                  VARCHAR (20) NULL,
    [Agencia]                   VARCHAR (6)  NULL,
    [CodigoCompromissoConvenio] VARCHAR (4)  NULL,
    [CodigoParamTransConvenio]  VARCHAR (2)  NULL,
    [AmbienteArquivoCNAB]       BIT          CONSTRAINT [DF__Bancos__Ambiente__120A78D0] DEFAULT ((1)) NULL,
    [LimiteTED]                 MONEY        NULL,
    [IdPessoa]                  INT          NULL,
    [ConciliarFavorecido]       BIT          DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Bancos] PRIMARY KEY NONCLUSTERED ([IdBanco] ASC),
    CONSTRAINT [FK_Bancos_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE TRIGGER [TrgLog_Bancos] ON [Implanta_CRPAM].[dbo].[Bancos] 
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
SET @TableName = 'Bancos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaBanco : «' + RTRIM( ISNULL( CAST (CodContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Operacao : «' + RTRIM( ISNULL( CAST (Operacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximoNumeroCheque : «' + RTRIM( ISNULL( CAST (ProximoNumeroCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Padrao IS NULL THEN ' E_Padrao : «Nulo» '
                                              WHEN  E_Padrao = 0 THEN ' E_Padrao : «Falso» '
                                              WHEN  E_Padrao = 1 THEN ' E_Padrao : «Verdadeiro» '
                                    END 
                         + '| Convenio : «' + RTRIM( ISNULL( CAST (Convenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCompromissoConvenio : «' + RTRIM( ISNULL( CAST (CodigoCompromissoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoParamTransConvenio : «' + RTRIM( ISNULL( CAST (CodigoParamTransConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AmbienteArquivoCNAB IS NULL THEN ' AmbienteArquivoCNAB : «Nulo» '
                                              WHEN  AmbienteArquivoCNAB = 0 THEN ' AmbienteArquivoCNAB : «Falso» '
                                              WHEN  AmbienteArquivoCNAB = 1 THEN ' AmbienteArquivoCNAB : «Verdadeiro» '
                                    END 
                         + '| LimiteTED : «' + RTRIM( ISNULL( CAST (LimiteTED AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConciliarFavorecido IS NULL THEN ' ConciliarFavorecido : «Nulo» '
                                              WHEN  ConciliarFavorecido = 0 THEN ' ConciliarFavorecido : «Falso» '
                                              WHEN  ConciliarFavorecido = 1 THEN ' ConciliarFavorecido : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaBanco : «' + RTRIM( ISNULL( CAST (CodContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Operacao : «' + RTRIM( ISNULL( CAST (Operacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximoNumeroCheque : «' + RTRIM( ISNULL( CAST (ProximoNumeroCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Padrao IS NULL THEN ' E_Padrao : «Nulo» '
                                              WHEN  E_Padrao = 0 THEN ' E_Padrao : «Falso» '
                                              WHEN  E_Padrao = 1 THEN ' E_Padrao : «Verdadeiro» '
                                    END 
                         + '| Convenio : «' + RTRIM( ISNULL( CAST (Convenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCompromissoConvenio : «' + RTRIM( ISNULL( CAST (CodigoCompromissoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoParamTransConvenio : «' + RTRIM( ISNULL( CAST (CodigoParamTransConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AmbienteArquivoCNAB IS NULL THEN ' AmbienteArquivoCNAB : «Nulo» '
                                              WHEN  AmbienteArquivoCNAB = 0 THEN ' AmbienteArquivoCNAB : «Falso» '
                                              WHEN  AmbienteArquivoCNAB = 1 THEN ' AmbienteArquivoCNAB : «Verdadeiro» '
                                    END 
                         + '| LimiteTED : «' + RTRIM( ISNULL( CAST (LimiteTED AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConciliarFavorecido IS NULL THEN ' ConciliarFavorecido : «Nulo» '
                                              WHEN  ConciliarFavorecido = 0 THEN ' ConciliarFavorecido : «Falso» '
                                              WHEN  ConciliarFavorecido = 1 THEN ' ConciliarFavorecido : «Verdadeiro» '
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
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaBanco : «' + RTRIM( ISNULL( CAST (CodContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Operacao : «' + RTRIM( ISNULL( CAST (Operacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximoNumeroCheque : «' + RTRIM( ISNULL( CAST (ProximoNumeroCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Padrao IS NULL THEN ' E_Padrao : «Nulo» '
                                              WHEN  E_Padrao = 0 THEN ' E_Padrao : «Falso» '
                                              WHEN  E_Padrao = 1 THEN ' E_Padrao : «Verdadeiro» '
                                    END 
                         + '| Convenio : «' + RTRIM( ISNULL( CAST (Convenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCompromissoConvenio : «' + RTRIM( ISNULL( CAST (CodigoCompromissoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoParamTransConvenio : «' + RTRIM( ISNULL( CAST (CodigoParamTransConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AmbienteArquivoCNAB IS NULL THEN ' AmbienteArquivoCNAB : «Nulo» '
                                              WHEN  AmbienteArquivoCNAB = 0 THEN ' AmbienteArquivoCNAB : «Falso» '
                                              WHEN  AmbienteArquivoCNAB = 1 THEN ' AmbienteArquivoCNAB : «Verdadeiro» '
                                    END 
                         + '| LimiteTED : «' + RTRIM( ISNULL( CAST (LimiteTED AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConciliarFavorecido IS NULL THEN ' ConciliarFavorecido : «Nulo» '
                                              WHEN  ConciliarFavorecido = 0 THEN ' ConciliarFavorecido : «Falso» '
                                              WHEN  ConciliarFavorecido = 1 THEN ' ConciliarFavorecido : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaBanco : «' + RTRIM( ISNULL( CAST (CodContaBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBanco : «' + RTRIM( ISNULL( CAST (NomeBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Operacao : «' + RTRIM( ISNULL( CAST (Operacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ProximoNumeroCheque : «' + RTRIM( ISNULL( CAST (ProximoNumeroCheque AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Padrao IS NULL THEN ' E_Padrao : «Nulo» '
                                              WHEN  E_Padrao = 0 THEN ' E_Padrao : «Falso» '
                                              WHEN  E_Padrao = 1 THEN ' E_Padrao : «Verdadeiro» '
                                    END 
                         + '| Convenio : «' + RTRIM( ISNULL( CAST (Convenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCompromissoConvenio : «' + RTRIM( ISNULL( CAST (CodigoCompromissoConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoParamTransConvenio : «' + RTRIM( ISNULL( CAST (CodigoParamTransConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AmbienteArquivoCNAB IS NULL THEN ' AmbienteArquivoCNAB : «Nulo» '
                                              WHEN  AmbienteArquivoCNAB = 0 THEN ' AmbienteArquivoCNAB : «Falso» '
                                              WHEN  AmbienteArquivoCNAB = 1 THEN ' AmbienteArquivoCNAB : «Verdadeiro» '
                                    END 
                         + '| LimiteTED : «' + RTRIM( ISNULL( CAST (LimiteTED AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConciliarFavorecido IS NULL THEN ' ConciliarFavorecido : «Nulo» '
                                              WHEN  ConciliarFavorecido = 0 THEN ' ConciliarFavorecido : «Falso» '
                                              WHEN  ConciliarFavorecido = 1 THEN ' ConciliarFavorecido : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
