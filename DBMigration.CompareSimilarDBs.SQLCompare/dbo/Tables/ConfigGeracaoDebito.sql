CREATE TABLE [dbo].[ConfigGeracaoDebito] (
    [IdConfigGeracaoDebito]         INT          IDENTITY (1, 1) NOT NULL,
    [IdTipoDebito]                  INT          NULL,
    [IdMoedaConfigGeracaoDebito]    INT          NULL,
    [IdConfigProcedimentoAtraso]    INT          NULL,
    [NomeConfiguracao]              VARCHAR (50) NOT NULL,
    [DataReferenciaDebito]          DATETIME     NOT NULL,
    [DataGeracao]                   DATETIME     NULL,
    [DataReajuste]                  DATETIME     NULL,
    [Valor]                         FLOAT (53)   NULL,
    [QtdeParcelas]                  INT          NULL,
    [GerarCotaUnica]                BIT          NULL,
    [Observacoes]                   TEXT         NULL,
    [TipoPessoa]                    INT          NULL,
    [AutorizaDebitoConta_CotaUnica] BIT          CONSTRAINT [DF__ConfigGer__Autor__0FDDA6FC] DEFAULT ((0)) NOT NULL,
    [AutorizaDebitoConta_Parcelas]  BIT          CONSTRAINT [DF__ConfigGer__Autor__10D1CB35] DEFAULT ((0)) NOT NULL,
    [Desativado]                    BIT          DEFAULT ((0)) NOT NULL,
    [IdProcedRenegociacao]          INT          NULL,
    CONSTRAINT [PK_ConfigGeracaoDebitos] PRIMARY KEY CLUSTERED ([IdConfigGeracaoDebito] ASC),
    CONSTRAINT [FK_ConfigGeracaoDebito_Moedas] FOREIGN KEY ([IdMoedaConfigGeracaoDebito]) REFERENCES [dbo].[Moedas] ([IdMoeda]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ConfigGeracaoDebito_TiposDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito]) NOT FOR REPLICATION,
    CONSTRAINT [FKConfigGeracaoDebito_ProcedimentosRenegociacao] FOREIGN KEY ([IdProcedRenegociacao]) REFERENCES [dbo].[ProcedimentosRenegociacao] ([IdProcedRenegociacao])
);


GO
CREATE TRIGGER [TrgLog_ConfigGeracaoDebito] ON [Implanta_CRPAM].[dbo].[ConfigGeracaoDebito] 
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
SET @TableName = 'ConfigGeracaoDebito'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdMoedaConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdConfigProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaDebito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaDebito, 113 ),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataReajuste : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReajuste, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeParcelas : «' + RTRIM( ISNULL( CAST (QtdeParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GerarCotaUnica IS NULL THEN ' GerarCotaUnica : «Nulo» '
                                              WHEN  GerarCotaUnica = 0 THEN ' GerarCotaUnica : «Falso» '
                                              WHEN  GerarCotaUnica = 1 THEN ' GerarCotaUnica : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta_CotaUnica IS NULL THEN ' AutorizaDebitoConta_CotaUnica : «Nulo» '
                                              WHEN  AutorizaDebitoConta_CotaUnica = 0 THEN ' AutorizaDebitoConta_CotaUnica : «Falso» '
                                              WHEN  AutorizaDebitoConta_CotaUnica = 1 THEN ' AutorizaDebitoConta_CotaUnica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta_Parcelas IS NULL THEN ' AutorizaDebitoConta_Parcelas : «Nulo» '
                                              WHEN  AutorizaDebitoConta_Parcelas = 0 THEN ' AutorizaDebitoConta_Parcelas : «Falso» '
                                              WHEN  AutorizaDebitoConta_Parcelas = 1 THEN ' AutorizaDebitoConta_Parcelas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdProcedRenegociacao : «' + RTRIM( ISNULL( CAST (IdProcedRenegociacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdMoedaConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdConfigProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaDebito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaDebito, 113 ),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataReajuste : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReajuste, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeParcelas : «' + RTRIM( ISNULL( CAST (QtdeParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GerarCotaUnica IS NULL THEN ' GerarCotaUnica : «Nulo» '
                                              WHEN  GerarCotaUnica = 0 THEN ' GerarCotaUnica : «Falso» '
                                              WHEN  GerarCotaUnica = 1 THEN ' GerarCotaUnica : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta_CotaUnica IS NULL THEN ' AutorizaDebitoConta_CotaUnica : «Nulo» '
                                              WHEN  AutorizaDebitoConta_CotaUnica = 0 THEN ' AutorizaDebitoConta_CotaUnica : «Falso» '
                                              WHEN  AutorizaDebitoConta_CotaUnica = 1 THEN ' AutorizaDebitoConta_CotaUnica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta_Parcelas IS NULL THEN ' AutorizaDebitoConta_Parcelas : «Nulo» '
                                              WHEN  AutorizaDebitoConta_Parcelas = 0 THEN ' AutorizaDebitoConta_Parcelas : «Falso» '
                                              WHEN  AutorizaDebitoConta_Parcelas = 1 THEN ' AutorizaDebitoConta_Parcelas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdProcedRenegociacao : «' + RTRIM( ISNULL( CAST (IdProcedRenegociacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdMoedaConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdConfigProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaDebito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaDebito, 113 ),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataReajuste : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReajuste, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeParcelas : «' + RTRIM( ISNULL( CAST (QtdeParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GerarCotaUnica IS NULL THEN ' GerarCotaUnica : «Nulo» '
                                              WHEN  GerarCotaUnica = 0 THEN ' GerarCotaUnica : «Falso» '
                                              WHEN  GerarCotaUnica = 1 THEN ' GerarCotaUnica : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta_CotaUnica IS NULL THEN ' AutorizaDebitoConta_CotaUnica : «Nulo» '
                                              WHEN  AutorizaDebitoConta_CotaUnica = 0 THEN ' AutorizaDebitoConta_CotaUnica : «Falso» '
                                              WHEN  AutorizaDebitoConta_CotaUnica = 1 THEN ' AutorizaDebitoConta_CotaUnica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta_Parcelas IS NULL THEN ' AutorizaDebitoConta_Parcelas : «Nulo» '
                                              WHEN  AutorizaDebitoConta_Parcelas = 0 THEN ' AutorizaDebitoConta_Parcelas : «Falso» '
                                              WHEN  AutorizaDebitoConta_Parcelas = 1 THEN ' AutorizaDebitoConta_Parcelas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdProcedRenegociacao : «' + RTRIM( ISNULL( CAST (IdProcedRenegociacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMoedaConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdMoedaConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigProcedimentoAtraso : «' + RTRIM( ISNULL( CAST (IdConfigProcedimentoAtraso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataReferenciaDebito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReferenciaDebito, 113 ),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataReajuste : «' + RTRIM( ISNULL( CONVERT (CHAR, DataReajuste, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeParcelas : «' + RTRIM( ISNULL( CAST (QtdeParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GerarCotaUnica IS NULL THEN ' GerarCotaUnica : «Nulo» '
                                              WHEN  GerarCotaUnica = 0 THEN ' GerarCotaUnica : «Falso» '
                                              WHEN  GerarCotaUnica = 1 THEN ' GerarCotaUnica : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta_CotaUnica IS NULL THEN ' AutorizaDebitoConta_CotaUnica : «Nulo» '
                                              WHEN  AutorizaDebitoConta_CotaUnica = 0 THEN ' AutorizaDebitoConta_CotaUnica : «Falso» '
                                              WHEN  AutorizaDebitoConta_CotaUnica = 1 THEN ' AutorizaDebitoConta_CotaUnica : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AutorizaDebitoConta_Parcelas IS NULL THEN ' AutorizaDebitoConta_Parcelas : «Nulo» '
                                              WHEN  AutorizaDebitoConta_Parcelas = 0 THEN ' AutorizaDebitoConta_Parcelas : «Falso» '
                                              WHEN  AutorizaDebitoConta_Parcelas = 1 THEN ' AutorizaDebitoConta_Parcelas : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| IdProcedRenegociacao : «' + RTRIM( ISNULL( CAST (IdProcedRenegociacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
