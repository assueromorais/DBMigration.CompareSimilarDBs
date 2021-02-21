CREATE TABLE [dbo].[ConfiguracoesSipro] (
    [ImprimeChequeDataServidor]   BIT      NULL,
    [AvisoRecolhimento]           BIT      NULL,
    [UsaSubArea]                  BIT      NULL,
    [TravamentoSubArea]           BIT      NULL,
    [DigitosSubArea]              INT      NULL,
    [UtilizaIntegracaoSiscontNet] BIT      NULL,
    [IntegraDevolucaoReceita]     BIT      NULL,
    [DataIntegraDevolucaoReceita] DATETIME NULL
);


GO
CREATE TRIGGER [TrgLog_ConfiguracoesSipro] ON [Implanta_CRPAM].[dbo].[ConfiguracoesSipro] 
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
SET @TableName = 'ConfiguracoesSipro'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo =  CASE 
         			            WHEN ImprimeChequeDataServidor IS NULL THEN ' ImprimeChequeDataServidor : «Nulo» '
                                         WHEN ImprimeChequeDataServidor = 0 THEN ' ImprimeChequeDataServidor : «Falso» '
                                         WHEN ImprimeChequeDataServidor = 1 THEN ' ImprimeChequeDataServidor : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  AvisoRecolhimento IS NULL THEN ' AvisoRecolhimento : «Nulo» '
                                              WHEN  AvisoRecolhimento = 0 THEN ' AvisoRecolhimento : «Falso» '
                                              WHEN  AvisoRecolhimento = 1 THEN ' AvisoRecolhimento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaSubArea IS NULL THEN ' UsaSubArea : «Nulo» '
                                              WHEN  UsaSubArea = 0 THEN ' UsaSubArea : «Falso» '
                                              WHEN  UsaSubArea = 1 THEN ' UsaSubArea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoSubArea IS NULL THEN ' TravamentoSubArea : «Nulo» '
                                              WHEN  TravamentoSubArea = 0 THEN ' TravamentoSubArea : «Falso» '
                                              WHEN  TravamentoSubArea = 1 THEN ' TravamentoSubArea : «Verdadeiro» '
                                    END 
                         + '| DigitosSubArea : «' + RTRIM( ISNULL( CAST (DigitosSubArea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaIntegracaoSiscontNet IS NULL THEN ' UtilizaIntegracaoSiscontNet : «Nulo» '
                                              WHEN  UtilizaIntegracaoSiscontNet = 0 THEN ' UtilizaIntegracaoSiscontNet : «Falso» '
                                              WHEN  UtilizaIntegracaoSiscontNet = 1 THEN ' UtilizaIntegracaoSiscontNet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IntegraDevolucaoReceita IS NULL THEN ' IntegraDevolucaoReceita : «Nulo» '
                                              WHEN  IntegraDevolucaoReceita = 0 THEN ' IntegraDevolucaoReceita : «Falso» '
                                              WHEN  IntegraDevolucaoReceita = 1 THEN ' IntegraDevolucaoReceita : «Verdadeiro» '
                                    END 
                         + '| DataIntegraDevolucaoReceita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataIntegraDevolucaoReceita, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 =  CASE 
         			            WHEN ImprimeChequeDataServidor IS NULL THEN ' ImprimeChequeDataServidor : «Nulo» '
                                         WHEN ImprimeChequeDataServidor = 0 THEN ' ImprimeChequeDataServidor : «Falso» '
                                         WHEN ImprimeChequeDataServidor = 1 THEN ' ImprimeChequeDataServidor : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  AvisoRecolhimento IS NULL THEN ' AvisoRecolhimento : «Nulo» '
                                              WHEN  AvisoRecolhimento = 0 THEN ' AvisoRecolhimento : «Falso» '
                                              WHEN  AvisoRecolhimento = 1 THEN ' AvisoRecolhimento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaSubArea IS NULL THEN ' UsaSubArea : «Nulo» '
                                              WHEN  UsaSubArea = 0 THEN ' UsaSubArea : «Falso» '
                                              WHEN  UsaSubArea = 1 THEN ' UsaSubArea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoSubArea IS NULL THEN ' TravamentoSubArea : «Nulo» '
                                              WHEN  TravamentoSubArea = 0 THEN ' TravamentoSubArea : «Falso» '
                                              WHEN  TravamentoSubArea = 1 THEN ' TravamentoSubArea : «Verdadeiro» '
                                    END 
                         + '| DigitosSubArea : «' + RTRIM( ISNULL( CAST (DigitosSubArea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaIntegracaoSiscontNet IS NULL THEN ' UtilizaIntegracaoSiscontNet : «Nulo» '
                                              WHEN  UtilizaIntegracaoSiscontNet = 0 THEN ' UtilizaIntegracaoSiscontNet : «Falso» '
                                              WHEN  UtilizaIntegracaoSiscontNet = 1 THEN ' UtilizaIntegracaoSiscontNet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IntegraDevolucaoReceita IS NULL THEN ' IntegraDevolucaoReceita : «Nulo» '
                                              WHEN  IntegraDevolucaoReceita = 0 THEN ' IntegraDevolucaoReceita : «Falso» '
                                              WHEN  IntegraDevolucaoReceita = 1 THEN ' IntegraDevolucaoReceita : «Verdadeiro» '
                                    END 
                         + '| DataIntegraDevolucaoReceita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataIntegraDevolucaoReceita, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo =  CASE 
         			            WHEN ImprimeChequeDataServidor IS NULL THEN ' ImprimeChequeDataServidor : «Nulo» '
                                         WHEN ImprimeChequeDataServidor = 0 THEN ' ImprimeChequeDataServidor : «Falso» '
                                         WHEN ImprimeChequeDataServidor = 1 THEN ' ImprimeChequeDataServidor : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  AvisoRecolhimento IS NULL THEN ' AvisoRecolhimento : «Nulo» '
                                              WHEN  AvisoRecolhimento = 0 THEN ' AvisoRecolhimento : «Falso» '
                                              WHEN  AvisoRecolhimento = 1 THEN ' AvisoRecolhimento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaSubArea IS NULL THEN ' UsaSubArea : «Nulo» '
                                              WHEN  UsaSubArea = 0 THEN ' UsaSubArea : «Falso» '
                                              WHEN  UsaSubArea = 1 THEN ' UsaSubArea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoSubArea IS NULL THEN ' TravamentoSubArea : «Nulo» '
                                              WHEN  TravamentoSubArea = 0 THEN ' TravamentoSubArea : «Falso» '
                                              WHEN  TravamentoSubArea = 1 THEN ' TravamentoSubArea : «Verdadeiro» '
                                    END 
                         + '| DigitosSubArea : «' + RTRIM( ISNULL( CAST (DigitosSubArea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaIntegracaoSiscontNet IS NULL THEN ' UtilizaIntegracaoSiscontNet : «Nulo» '
                                              WHEN  UtilizaIntegracaoSiscontNet = 0 THEN ' UtilizaIntegracaoSiscontNet : «Falso» '
                                              WHEN  UtilizaIntegracaoSiscontNet = 1 THEN ' UtilizaIntegracaoSiscontNet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IntegraDevolucaoReceita IS NULL THEN ' IntegraDevolucaoReceita : «Nulo» '
                                              WHEN  IntegraDevolucaoReceita = 0 THEN ' IntegraDevolucaoReceita : «Falso» '
                                              WHEN  IntegraDevolucaoReceita = 1 THEN ' IntegraDevolucaoReceita : «Verdadeiro» '
                                    END 
                         + '| DataIntegraDevolucaoReceita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataIntegraDevolucaoReceita, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo =  CASE 
         			            WHEN ImprimeChequeDataServidor IS NULL THEN ' ImprimeChequeDataServidor : «Nulo» '
                                         WHEN ImprimeChequeDataServidor = 0 THEN ' ImprimeChequeDataServidor : «Falso» '
                                         WHEN ImprimeChequeDataServidor = 1 THEN ' ImprimeChequeDataServidor : «Verdadeiro» '
 				  END
                         + '| ' +  CASE 
                                              WHEN  AvisoRecolhimento IS NULL THEN ' AvisoRecolhimento : «Nulo» '
                                              WHEN  AvisoRecolhimento = 0 THEN ' AvisoRecolhimento : «Falso» '
                                              WHEN  AvisoRecolhimento = 1 THEN ' AvisoRecolhimento : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaSubArea IS NULL THEN ' UsaSubArea : «Nulo» '
                                              WHEN  UsaSubArea = 0 THEN ' UsaSubArea : «Falso» '
                                              WHEN  UsaSubArea = 1 THEN ' UsaSubArea : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  TravamentoSubArea IS NULL THEN ' TravamentoSubArea : «Nulo» '
                                              WHEN  TravamentoSubArea = 0 THEN ' TravamentoSubArea : «Falso» '
                                              WHEN  TravamentoSubArea = 1 THEN ' TravamentoSubArea : «Verdadeiro» '
                                    END 
                         + '| DigitosSubArea : «' + RTRIM( ISNULL( CAST (DigitosSubArea AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UtilizaIntegracaoSiscontNet IS NULL THEN ' UtilizaIntegracaoSiscontNet : «Nulo» '
                                              WHEN  UtilizaIntegracaoSiscontNet = 0 THEN ' UtilizaIntegracaoSiscontNet : «Falso» '
                                              WHEN  UtilizaIntegracaoSiscontNet = 1 THEN ' UtilizaIntegracaoSiscontNet : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IntegraDevolucaoReceita IS NULL THEN ' IntegraDevolucaoReceita : «Nulo» '
                                              WHEN  IntegraDevolucaoReceita = 0 THEN ' IntegraDevolucaoReceita : «Falso» '
                                              WHEN  IntegraDevolucaoReceita = 1 THEN ' IntegraDevolucaoReceita : «Verdadeiro» '
                                    END 
                         + '| DataIntegraDevolucaoReceita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataIntegraDevolucaoReceita, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
