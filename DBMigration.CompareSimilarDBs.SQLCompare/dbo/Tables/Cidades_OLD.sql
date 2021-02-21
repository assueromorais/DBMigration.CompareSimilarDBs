﻿CREATE TABLE [dbo].[Cidades_OLD] (
    [IdCidade]                       INT          NULL,
    [NomeCidade]                     VARCHAR (50) NULL,
    [IndCricacaoWeb]                 BIT          NULL,
    [IndCriacaoWeb]                  BIT          NULL,
    [CodCidade]                      INT          NULL,
    [IdSubregiao]                    INT          NULL,
    [Desativado]                     BIT          NULL,
    [NomeCidadeAbreviadoCarteiraEst] VARCHAR (30) NULL,
    [E_Capital]                      BIT          NULL,
    [IdRegiao]                       INT          NULL,
    [E_Comarca]                      BIT          NULL,
    [idComarca]                      INT          NULL,
    [IdEstado]                       INT          NULL
);


GO
CREATE TRIGGER [TrgLog_Cidades_OLD] ON [Implanta_CRPAM].[dbo].[Cidades_OLD] 
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
SET @TableName = 'Cidades_OLD'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END 
                         + '| CodCidade : «' + RTRIM( ISNULL( CAST (CodCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubregiao : «' + RTRIM( ISNULL( CAST (IdSubregiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| NomeCidadeAbreviadoCarteiraEst : «' + RTRIM( ISNULL( CAST (NomeCidadeAbreviadoCarteiraEst AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Capital IS NULL THEN ' E_Capital : «Nulo» '
                                              WHEN  E_Capital = 0 THEN ' E_Capital : «Falso» '
                                              WHEN  E_Capital = 1 THEN ' E_Capital : «Verdadeiro» '
                                    END 
                         + '| IdRegiao : «' + RTRIM( ISNULL( CAST (IdRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Comarca IS NULL THEN ' E_Comarca : «Nulo» '
                                              WHEN  E_Comarca = 0 THEN ' E_Comarca : «Falso» '
                                              WHEN  E_Comarca = 1 THEN ' E_Comarca : «Verdadeiro» '
                                    END 
                         + '| idComarca : «' + RTRIM( ISNULL( CAST (idComarca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END 
                         + '| CodCidade : «' + RTRIM( ISNULL( CAST (CodCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubregiao : «' + RTRIM( ISNULL( CAST (IdSubregiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| NomeCidadeAbreviadoCarteiraEst : «' + RTRIM( ISNULL( CAST (NomeCidadeAbreviadoCarteiraEst AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Capital IS NULL THEN ' E_Capital : «Nulo» '
                                              WHEN  E_Capital = 0 THEN ' E_Capital : «Falso» '
                                              WHEN  E_Capital = 1 THEN ' E_Capital : «Verdadeiro» '
                                    END 
                         + '| IdRegiao : «' + RTRIM( ISNULL( CAST (IdRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Comarca IS NULL THEN ' E_Comarca : «Nulo» '
                                              WHEN  E_Comarca = 0 THEN ' E_Comarca : «Falso» '
                                              WHEN  E_Comarca = 1 THEN ' E_Comarca : «Verdadeiro» '
                                    END 
                         + '| idComarca : «' + RTRIM( ISNULL( CAST (idComarca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END 
                         + '| CodCidade : «' + RTRIM( ISNULL( CAST (CodCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubregiao : «' + RTRIM( ISNULL( CAST (IdSubregiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| NomeCidadeAbreviadoCarteiraEst : «' + RTRIM( ISNULL( CAST (NomeCidadeAbreviadoCarteiraEst AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Capital IS NULL THEN ' E_Capital : «Nulo» '
                                              WHEN  E_Capital = 0 THEN ' E_Capital : «Falso» '
                                              WHEN  E_Capital = 1 THEN ' E_Capital : «Verdadeiro» '
                                    END 
                         + '| IdRegiao : «' + RTRIM( ISNULL( CAST (IdRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Comarca IS NULL THEN ' E_Comarca : «Nulo» '
                                              WHEN  E_Comarca = 0 THEN ' E_Comarca : «Falso» '
                                              WHEN  E_Comarca = 1 THEN ' E_Comarca : «Verdadeiro» '
                                    END 
                         + '| idComarca : «' + RTRIM( ISNULL( CAST (idComarca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndCricacaoWeb IS NULL THEN ' IndCricacaoWeb : «Nulo» '
                                              WHEN  IndCricacaoWeb = 0 THEN ' IndCricacaoWeb : «Falso» '
                                              WHEN  IndCricacaoWeb = 1 THEN ' IndCricacaoWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END 
                         + '| CodCidade : «' + RTRIM( ISNULL( CAST (CodCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubregiao : «' + RTRIM( ISNULL( CAST (IdSubregiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| NomeCidadeAbreviadoCarteiraEst : «' + RTRIM( ISNULL( CAST (NomeCidadeAbreviadoCarteiraEst AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Capital IS NULL THEN ' E_Capital : «Nulo» '
                                              WHEN  E_Capital = 0 THEN ' E_Capital : «Falso» '
                                              WHEN  E_Capital = 1 THEN ' E_Capital : «Verdadeiro» '
                                    END 
                         + '| IdRegiao : «' + RTRIM( ISNULL( CAST (IdRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Comarca IS NULL THEN ' E_Comarca : «Nulo» '
                                              WHEN  E_Comarca = 0 THEN ' E_Comarca : «Falso» '
                                              WHEN  E_Comarca = 1 THEN ' E_Comarca : «Verdadeiro» '
                                    END 
                         + '| idComarca : «' + RTRIM( ISNULL( CAST (idComarca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
