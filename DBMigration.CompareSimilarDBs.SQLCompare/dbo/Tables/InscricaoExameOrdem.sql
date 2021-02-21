CREATE TABLE [dbo].[InscricaoExameOrdem] (
    [IdInscricao]           INT            IDENTITY (1, 1) NOT NULL,
    [IdExame]               INT            NULL,
    [IdPessoa]              INT            NULL,
    [IdProfissional]        INT            NULL,
    [NotaExame]             FLOAT (53)     NULL,
    [DataInscricao]         DATETIME       NULL,
    [Aprovado]              BIT            NULL,
    [CompareceuTeorica]     BIT            NULL,
    [IdAreaOpcao]           INT            NULL,
    [NumInscricao]          VARCHAR (8)    NULL,
    [NumAcertos]            INT            NULL,
    [Resultado]             CHAR (1)       NULL,
    [GradeCandidato]        VARCHAR (100)  NULL,
    [Liminar]               BIT            NULL,
    [QuestoesRecorridas]    VARCHAR (100)  NULL,
    [NotaQuestao1Pratica]   NUMERIC (3, 2) NULL,
    [NotaQuestao2Pratica]   NUMERIC (3, 2) NULL,
    [NotaQuestao3Pratica]   NUMERIC (3, 2) NULL,
    [NotaQuestao4Pratica]   NUMERIC (3, 2) NULL,
    [NotaQuestao5Pratica]   NUMERIC (3, 2) NULL,
    [NotaPeca]              NUMERIC (4, 2) NULL,
    [ResultadoProvaPratica] CHAR (1)       NULL,
    [IdCidade]              INT            NULL,
    [CompareceuPratica]     BIT            NULL,
    CONSTRAINT [PK_InscricaoExameOrdem] PRIMARY KEY CLUSTERED ([IdInscricao] ASC),
    CONSTRAINT [FK_InscricaoExameOrdem_AreaOpcaoExameOrdem] FOREIGN KEY ([IdAreaOpcao]) REFERENCES [dbo].[AreaOpcaoExameOrdem] ([IdAreaOpcao]),
    CONSTRAINT [FK_InscricaoExameOrdem_Cidades] FOREIGN KEY ([IdCidade]) REFERENCES [dbo].[Cidades] ([IdCidade]),
    CONSTRAINT [FK_InscricaoExameOrdem_ExameOrdem] FOREIGN KEY ([IdExame]) REFERENCES [dbo].[ExameOrdem] ([IdExame]),
    CONSTRAINT [FK_InscricaoExameOrdem_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_InscricaoExameOrdem_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_InscricaoExameOrdem] ON [Implanta_CRPAM].[dbo].[InscricaoExameOrdem] 
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
SET @TableName = 'InscricaoExameOrdem'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdInscricao : «' + RTRIM( ISNULL( CAST (IdInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaExame : «' + RTRIM( ISNULL( CAST (NotaExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInscricao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Aprovado IS NULL THEN ' Aprovado : «Nulo» '
                                              WHEN  Aprovado = 0 THEN ' Aprovado : «Falso» '
                                              WHEN  Aprovado = 1 THEN ' Aprovado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CompareceuTeorica IS NULL THEN ' CompareceuTeorica : «Nulo» '
                                              WHEN  CompareceuTeorica = 0 THEN ' CompareceuTeorica : «Falso» '
                                              WHEN  CompareceuTeorica = 1 THEN ' CompareceuTeorica : «Verdadeiro» '
                                    END 
                         + '| IdAreaOpcao : «' + RTRIM( ISNULL( CAST (IdAreaOpcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumInscricao : «' + RTRIM( ISNULL( CAST (NumInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumAcertos : «' + RTRIM( ISNULL( CAST (NumAcertos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Resultado : «' + RTRIM( ISNULL( CAST (Resultado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| GradeCandidato : «' + RTRIM( ISNULL( CAST (GradeCandidato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Liminar IS NULL THEN ' Liminar : «Nulo» '
                                              WHEN  Liminar = 0 THEN ' Liminar : «Falso» '
                                              WHEN  Liminar = 1 THEN ' Liminar : «Verdadeiro» '
                                    END 
                         + '| QuestoesRecorridas : «' + RTRIM( ISNULL( CAST (QuestoesRecorridas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao1Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao1Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao2Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao2Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao3Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao3Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao4Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao4Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao5Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao5Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaPeca : «' + RTRIM( ISNULL( CAST (NotaPeca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoProvaPratica : «' + RTRIM( ISNULL( CAST (ResultadoProvaPratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CompareceuPratica IS NULL THEN ' CompareceuPratica : «Nulo» '
                                              WHEN  CompareceuPratica = 0 THEN ' CompareceuPratica : «Falso» '
                                              WHEN  CompareceuPratica = 1 THEN ' CompareceuPratica : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdInscricao : «' + RTRIM( ISNULL( CAST (IdInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaExame : «' + RTRIM( ISNULL( CAST (NotaExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInscricao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Aprovado IS NULL THEN ' Aprovado : «Nulo» '
                                              WHEN  Aprovado = 0 THEN ' Aprovado : «Falso» '
                                              WHEN  Aprovado = 1 THEN ' Aprovado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CompareceuTeorica IS NULL THEN ' CompareceuTeorica : «Nulo» '
                                              WHEN  CompareceuTeorica = 0 THEN ' CompareceuTeorica : «Falso» '
                                              WHEN  CompareceuTeorica = 1 THEN ' CompareceuTeorica : «Verdadeiro» '
                                    END 
                         + '| IdAreaOpcao : «' + RTRIM( ISNULL( CAST (IdAreaOpcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumInscricao : «' + RTRIM( ISNULL( CAST (NumInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumAcertos : «' + RTRIM( ISNULL( CAST (NumAcertos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Resultado : «' + RTRIM( ISNULL( CAST (Resultado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| GradeCandidato : «' + RTRIM( ISNULL( CAST (GradeCandidato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Liminar IS NULL THEN ' Liminar : «Nulo» '
                                              WHEN  Liminar = 0 THEN ' Liminar : «Falso» '
                                              WHEN  Liminar = 1 THEN ' Liminar : «Verdadeiro» '
                                    END 
                         + '| QuestoesRecorridas : «' + RTRIM( ISNULL( CAST (QuestoesRecorridas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao1Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao1Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao2Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao2Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao3Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao3Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao4Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao4Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao5Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao5Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaPeca : «' + RTRIM( ISNULL( CAST (NotaPeca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoProvaPratica : «' + RTRIM( ISNULL( CAST (ResultadoProvaPratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CompareceuPratica IS NULL THEN ' CompareceuPratica : «Nulo» '
                                              WHEN  CompareceuPratica = 0 THEN ' CompareceuPratica : «Falso» '
                                              WHEN  CompareceuPratica = 1 THEN ' CompareceuPratica : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdInscricao : «' + RTRIM( ISNULL( CAST (IdInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaExame : «' + RTRIM( ISNULL( CAST (NotaExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInscricao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Aprovado IS NULL THEN ' Aprovado : «Nulo» '
                                              WHEN  Aprovado = 0 THEN ' Aprovado : «Falso» '
                                              WHEN  Aprovado = 1 THEN ' Aprovado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CompareceuTeorica IS NULL THEN ' CompareceuTeorica : «Nulo» '
                                              WHEN  CompareceuTeorica = 0 THEN ' CompareceuTeorica : «Falso» '
                                              WHEN  CompareceuTeorica = 1 THEN ' CompareceuTeorica : «Verdadeiro» '
                                    END 
                         + '| IdAreaOpcao : «' + RTRIM( ISNULL( CAST (IdAreaOpcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumInscricao : «' + RTRIM( ISNULL( CAST (NumInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumAcertos : «' + RTRIM( ISNULL( CAST (NumAcertos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Resultado : «' + RTRIM( ISNULL( CAST (Resultado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| GradeCandidato : «' + RTRIM( ISNULL( CAST (GradeCandidato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Liminar IS NULL THEN ' Liminar : «Nulo» '
                                              WHEN  Liminar = 0 THEN ' Liminar : «Falso» '
                                              WHEN  Liminar = 1 THEN ' Liminar : «Verdadeiro» '
                                    END 
                         + '| QuestoesRecorridas : «' + RTRIM( ISNULL( CAST (QuestoesRecorridas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao1Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao1Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao2Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao2Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao3Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao3Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao4Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao4Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao5Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao5Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaPeca : «' + RTRIM( ISNULL( CAST (NotaPeca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoProvaPratica : «' + RTRIM( ISNULL( CAST (ResultadoProvaPratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CompareceuPratica IS NULL THEN ' CompareceuPratica : «Nulo» '
                                              WHEN  CompareceuPratica = 0 THEN ' CompareceuPratica : «Falso» '
                                              WHEN  CompareceuPratica = 1 THEN ' CompareceuPratica : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdInscricao : «' + RTRIM( ISNULL( CAST (IdInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaExame : «' + RTRIM( ISNULL( CAST (NotaExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInscricao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Aprovado IS NULL THEN ' Aprovado : «Nulo» '
                                              WHEN  Aprovado = 0 THEN ' Aprovado : «Falso» '
                                              WHEN  Aprovado = 1 THEN ' Aprovado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  CompareceuTeorica IS NULL THEN ' CompareceuTeorica : «Nulo» '
                                              WHEN  CompareceuTeorica = 0 THEN ' CompareceuTeorica : «Falso» '
                                              WHEN  CompareceuTeorica = 1 THEN ' CompareceuTeorica : «Verdadeiro» '
                                    END 
                         + '| IdAreaOpcao : «' + RTRIM( ISNULL( CAST (IdAreaOpcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumInscricao : «' + RTRIM( ISNULL( CAST (NumInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumAcertos : «' + RTRIM( ISNULL( CAST (NumAcertos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Resultado : «' + RTRIM( ISNULL( CAST (Resultado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| GradeCandidato : «' + RTRIM( ISNULL( CAST (GradeCandidato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Liminar IS NULL THEN ' Liminar : «Nulo» '
                                              WHEN  Liminar = 0 THEN ' Liminar : «Falso» '
                                              WHEN  Liminar = 1 THEN ' Liminar : «Verdadeiro» '
                                    END 
                         + '| QuestoesRecorridas : «' + RTRIM( ISNULL( CAST (QuestoesRecorridas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao1Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao1Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao2Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao2Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao3Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao3Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao4Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao4Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaQuestao5Pratica : «' + RTRIM( ISNULL( CAST (NotaQuestao5Pratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaPeca : «' + RTRIM( ISNULL( CAST (NotaPeca AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ResultadoProvaPratica : «' + RTRIM( ISNULL( CAST (ResultadoProvaPratica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CompareceuPratica IS NULL THEN ' CompareceuPratica : «Nulo» '
                                              WHEN  CompareceuPratica = 0 THEN ' CompareceuPratica : «Falso» '
                                              WHEN  CompareceuPratica = 1 THEN ' CompareceuPratica : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
