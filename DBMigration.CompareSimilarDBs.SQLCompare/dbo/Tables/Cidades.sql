CREATE TABLE [dbo].[Cidades] (
    [IdCidade]                       INT          IDENTITY (1, 1) NOT NULL,
    [NomeCidade]                     VARCHAR (50) NULL,
    [IndCricacaoWeb]                 BIT          CONSTRAINT [DF_CidadesIndCricacaoWeb] DEFAULT ((0)) NULL,
    [IndCriacaoWeb]                  BIT          CONSTRAINT [DF_CidadesIndCriacaoWeb] DEFAULT ((0)) NULL,
    [CodCidade]                      INT          NULL,
    [IdSubregiao]                    INT          NULL,
    [Desativado]                     BIT          CONSTRAINT [DF_CidadesDesativado] DEFAULT ((0)) NULL,
    [NomeCidadeAbreviadoCarteiraEst] VARCHAR (30) NULL,
    [E_Capital]                      BIT          NULL,
    [IdRegiao]                       INT          NULL,
    [E_Comarca]                      BIT          CONSTRAINT [DFCidadesEComarca] DEFAULT ((0)) NOT NULL,
    [idComarca]                      INT          NULL,
    [IdEstado]                       INT          NULL,
    [IdRegiaoAdministrativa]         INT          NULL,
    [IdCidadeDNE]                    INT          NULL,
    [CEP]                            VARCHAR (8)  NULL,
    CONSTRAINT [PK_Cidades] PRIMARY KEY CLUSTERED ([IdCidade] ASC),
    CONSTRAINT [FK_Cidades_Comarca] FOREIGN KEY ([idComarca]) REFERENCES [dbo].[Cidades] ([IdCidade]),
    CONSTRAINT [FK_Cidades_Estado] FOREIGN KEY ([IdEstado]) REFERENCES [dbo].[Estados] ([IdEstado]),
    CONSTRAINT [FK_Cidades_Pessoas] FOREIGN KEY ([IdSubregiao]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_Cidades_RegioesAdministrativas] FOREIGN KEY ([IdRegiaoAdministrativa]) REFERENCES [dbo].[RegioesAdministrativas] ([IdRegiaoAdministrativa]),
    CONSTRAINT [FK_CidadesRegioes] FOREIGN KEY ([IdRegiao]) REFERENCES [dbo].[Regioes] ([IdRegiao])
);


GO
CREATE TRIGGER [TrgLog_Cidades] ON [Implanta_CRPAM].[dbo].[Cidades] 
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
SET @TableName = 'Cidades'
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
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegiaoAdministrativa : «' + RTRIM( ISNULL( CAST (IdRegiaoAdministrativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeDNE : «' + RTRIM( ISNULL( CAST (IdCidadeDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
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
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegiaoAdministrativa : «' + RTRIM( ISNULL( CAST (IdRegiaoAdministrativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeDNE : «' + RTRIM( ISNULL( CAST (IdCidadeDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegiaoAdministrativa : «' + RTRIM( ISNULL( CAST (IdRegiaoAdministrativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeDNE : «' + RTRIM( ISNULL( CAST (IdCidadeDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
                         + '| IdEstado : «' + RTRIM( ISNULL( CAST (IdEstado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegiaoAdministrativa : «' + RTRIM( ISNULL( CAST (IdRegiaoAdministrativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidadeDNE : «' + RTRIM( ISNULL( CAST (IdCidadeDNE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
