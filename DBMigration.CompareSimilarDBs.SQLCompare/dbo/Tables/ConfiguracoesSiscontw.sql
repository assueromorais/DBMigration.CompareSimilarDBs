CREATE TABLE [dbo].[ConfiguracoesSiscontw] (
    [Usuario]                           VARCHAR (30)  NOT NULL,
    [AutoNumera]                        BIT           NOT NULL,
    [ComparativoSiscont]                BIT           NOT NULL,
    [MostraBotoes]                      BIT           NOT NULL,
    [SomarReceitaDespesa]               BIT           NOT NULL,
    [UltimoDiaUtil]                     BIT           NOT NULL,
    [UsaMesmoHistorico]                 BIT           NOT NULL,
    [EspacoAssinatura]                  FLOAT (53)    NULL,
    [MargemInferior]                    FLOAT (53)    NULL,
    [Novidade]                          DATETIME      NULL,
    [NovidadeSipro]                     DATETIME      NULL,
    [Separador]                         VARCHAR (1)   NULL,
    [Assinatura1]                       VARCHAR (250) NULL,
    [Cargo1]                            VARCHAR (250) NULL,
    [Cpf1]                              VARCHAR (250) NULL,
    [Registro1]                         VARCHAR (250) NULL,
    [Assinatura2]                       VARCHAR (250) NULL,
    [Cargo2]                            VARCHAR (250) NULL,
    [Cpf2]                              VARCHAR (250) NULL,
    [Registro2]                         VARCHAR (250) NULL,
    [Assinatura3]                       VARCHAR (250) NULL,
    [Cargo3]                            VARCHAR (250) NULL,
    [Cpf3]                              VARCHAR (250) NULL,
    [Registro3]                         VARCHAR (250) NULL,
    [Assinatura4]                       VARCHAR (250) NULL,
    [Cargo4]                            VARCHAR (250) NULL,
    [Cpf4]                              VARCHAR (250) NULL,
    [Registro4]                         VARCHAR (250) NULL,
    [Assinatura5]                       VARCHAR (250) NULL,
    [Cargo5]                            VARCHAR (250) NULL,
    [Cpf5]                              VARCHAR (250) NULL,
    [Registro5]                         VARCHAR (250) NULL,
    [Assinatura6]                       VARCHAR (250) NULL,
    [Cargo6]                            VARCHAR (250) NULL,
    [Cpf6]                              VARCHAR (250) NULL,
    [Registro6]                         VARCHAR (250) NULL,
    [Assinatura7]                       VARCHAR (250) NULL,
    [Cargo7]                            VARCHAR (250) NULL,
    [Cpf7]                              VARCHAR (250) NULL,
    [Registro7]                         VARCHAR (250) NULL,
    [AvisaA4]                           BIT           NOT NULL,
    [AnoCorrente]                       INT           NOT NULL,
    [NotaConjunta]                      BIT           NOT NULL,
    [Transferencia]                     VARCHAR (50)  NULL,
    [OrdemTela]                         INT           NULL,
    [AnoCorrenteSipro]                  INT           NULL,
    [UsaControleAnoCorrenteSipro]       BIT           NOT NULL,
    [PermiteDiferencaDC]                BIT           NULL,
    [Assinatura8]                       VARCHAR (250) NULL,
    [Cargo8]                            VARCHAR (250) NULL,
    [Cpf8]                              VARCHAR (250) NULL,
    [Registro8]                         VARCHAR (250) NULL,
    [Assinatura9]                       VARCHAR (250) NULL,
    [Cargo9]                            VARCHAR (250) NULL,
    [Cpf9]                              VARCHAR (250) NULL,
    [Registro9]                         VARCHAR (250) NULL,
    [Assinatura10]                      VARCHAR (250) NULL,
    [Cargo10]                           VARCHAR (250) NULL,
    [Cpf10]                             VARCHAR (250) NULL,
    [Registro10]                        VARCHAR (250) NULL,
    [Assinatura11]                      VARCHAR (250) NULL,
    [Cargo11]                           VARCHAR (250) NULL,
    [Cpf11]                             VARCHAR (250) NULL,
    [Registro11]                        VARCHAR (250) NULL,
    [LarguraAssinatura]                 FLOAT (53)    NULL,
    [EspacoVertAssinatura]              FLOAT (53)    NULL,
    [UsaAnoCorrenteIrParaSiscont]       BIT           NOT NULL,
    [MostraVlBaseImpImpressaoBaixaPag]  BIT           NOT NULL,
    [ImpressaoFrenteVersoSiproSiscontw] BIT           NULL,
    [UsaProcessoSiscontw]               BIT           NULL,
    [AlertaDevolucaoReceitas]           BIT           NULL,
    [IdUsuarioAssinatura4]              INT           NULL,
    [IdUsuarioAssinatura5]              INT           NULL,
    [IdUsuarioAssinatura6]              INT           NULL,
    [AtivaAssinatura4]                  BIT           DEFAULT ((0)) NOT NULL,
    [AtivaAssinatura5]                  BIT           DEFAULT ((0)) NOT NULL,
    [AtivaAssinatura6]                  BIT           DEFAULT ((0)) NOT NULL,
    [Assinatura12]                      VARCHAR (250) NULL,
    [Cargo12]                           VARCHAR (250) NULL,
    [Cpf12]                             VARCHAR (250) NULL,
    [Registro12]                        VARCHAR (250) NULL,
    [Assinatura13]                      VARCHAR (250) NULL,
    [Cargo13]                           VARCHAR (250) NULL,
    [Cpf13]                             VARCHAR (250) NULL,
    [Registro13]                        VARCHAR (250) NULL,
    [Assinatura14]                      VARCHAR (250) NULL,
    [Cargo14]                           VARCHAR (250) NULL,
    [Cpf14]                             VARCHAR (250) NULL,
    [Registro14]                        VARCHAR (250) NULL,
    [Assinatura15]                      VARCHAR (250) NULL,
    [Cargo15]                           VARCHAR (250) NULL,
    [Cpf15]                             VARCHAR (250) NULL,
    [Registro15]                        VARCHAR (250) NULL,
    CONSTRAINT [PK_ConfiguracoesSiscontw] PRIMARY KEY CLUSTERED ([Usuario] ASC),
    CONSTRAINT [FK_ConfiguracoesSiscontw_Usuarios] FOREIGN KEY ([IdUsuarioAssinatura4]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ConfiguracoesSiscontw_Usuarios2] FOREIGN KEY ([IdUsuarioAssinatura5]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ConfiguracoesSiscontw_Usuarios3] FOREIGN KEY ([IdUsuarioAssinatura6]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ConfiguracoesSiscontw] ON [Implanta_CRPAM].[dbo].[ConfiguracoesSiscontw] 
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
SET @TableName = 'ConfiguracoesSiscontw'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutoNumera IS NULL THEN ' AutoNumera : «Nulo» '
                                              WHEN  AutoNumera = 0 THEN ' AutoNumera : «Falso» '
                                              WHEN  AutoNumera = 1 THEN ' AutoNumera : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComparativoSiscont IS NULL THEN ' ComparativoSiscont : «Nulo» '
                                              WHEN  ComparativoSiscont = 0 THEN ' ComparativoSiscont : «Falso» '
                                              WHEN  ComparativoSiscont = 1 THEN ' ComparativoSiscont : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraBotoes IS NULL THEN ' MostraBotoes : «Nulo» '
                                              WHEN  MostraBotoes = 0 THEN ' MostraBotoes : «Falso» '
                                              WHEN  MostraBotoes = 1 THEN ' MostraBotoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SomarReceitaDespesa IS NULL THEN ' SomarReceitaDespesa : «Nulo» '
                                              WHEN  SomarReceitaDespesa = 0 THEN ' SomarReceitaDespesa : «Falso» '
                                              WHEN  SomarReceitaDespesa = 1 THEN ' SomarReceitaDespesa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UltimoDiaUtil IS NULL THEN ' UltimoDiaUtil : «Nulo» '
                                              WHEN  UltimoDiaUtil = 0 THEN ' UltimoDiaUtil : «Falso» '
                                              WHEN  UltimoDiaUtil = 1 THEN ' UltimoDiaUtil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaMesmoHistorico IS NULL THEN ' UsaMesmoHistorico : «Nulo» '
                                              WHEN  UsaMesmoHistorico = 0 THEN ' UsaMesmoHistorico : «Falso» '
                                              WHEN  UsaMesmoHistorico = 1 THEN ' UsaMesmoHistorico : «Verdadeiro» '
                                    END 
                         + '| EspacoAssinatura : «' + RTRIM( ISNULL( CAST (EspacoAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Novidade : «' + RTRIM( ISNULL( CONVERT (CHAR, Novidade, 113 ),'Nulo'))+'» '
                         + '| NovidadeSipro : «' + RTRIM( ISNULL( CONVERT (CHAR, NovidadeSipro, 113 ),'Nulo'))+'» '
                         + '| Separador : «' + RTRIM( ISNULL( CAST (Separador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura1 : «' + RTRIM( ISNULL( CAST (Assinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo1 : «' + RTRIM( ISNULL( CAST (Cargo1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf1 : «' + RTRIM( ISNULL( CAST (Cpf1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro1 : «' + RTRIM( ISNULL( CAST (Registro1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura2 : «' + RTRIM( ISNULL( CAST (Assinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo2 : «' + RTRIM( ISNULL( CAST (Cargo2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf2 : «' + RTRIM( ISNULL( CAST (Cpf2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro2 : «' + RTRIM( ISNULL( CAST (Registro2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura3 : «' + RTRIM( ISNULL( CAST (Assinatura3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo3 : «' + RTRIM( ISNULL( CAST (Cargo3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf3 : «' + RTRIM( ISNULL( CAST (Cpf3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro3 : «' + RTRIM( ISNULL( CAST (Registro3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura4 : «' + RTRIM( ISNULL( CAST (Assinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo4 : «' + RTRIM( ISNULL( CAST (Cargo4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf4 : «' + RTRIM( ISNULL( CAST (Cpf4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro4 : «' + RTRIM( ISNULL( CAST (Registro4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura5 : «' + RTRIM( ISNULL( CAST (Assinatura5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo5 : «' + RTRIM( ISNULL( CAST (Cargo5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf5 : «' + RTRIM( ISNULL( CAST (Cpf5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro5 : «' + RTRIM( ISNULL( CAST (Registro5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura6 : «' + RTRIM( ISNULL( CAST (Assinatura6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo6 : «' + RTRIM( ISNULL( CAST (Cargo6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf6 : «' + RTRIM( ISNULL( CAST (Cpf6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro6 : «' + RTRIM( ISNULL( CAST (Registro6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura7 : «' + RTRIM( ISNULL( CAST (Assinatura7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo7 : «' + RTRIM( ISNULL( CAST (Cargo7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf7 : «' + RTRIM( ISNULL( CAST (Cpf7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro7 : «' + RTRIM( ISNULL( CAST (Registro7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AvisaA4 IS NULL THEN ' AvisaA4 : «Nulo» '
                                              WHEN  AvisaA4 = 0 THEN ' AvisaA4 : «Falso» '
                                              WHEN  AvisaA4 = 1 THEN ' AvisaA4 : «Verdadeiro» '
                                    END 
                         + '| AnoCorrente : «' + RTRIM( ISNULL( CAST (AnoCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NotaConjunta IS NULL THEN ' NotaConjunta : «Nulo» '
                                              WHEN  NotaConjunta = 0 THEN ' NotaConjunta : «Falso» '
                                              WHEN  NotaConjunta = 1 THEN ' NotaConjunta : «Verdadeiro» '
                                    END 
                         + '| Transferencia : «' + RTRIM( ISNULL( CAST (Transferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTela : «' + RTRIM( ISNULL( CAST (OrdemTela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoCorrenteSipro : «' + RTRIM( ISNULL( CAST (AnoCorrenteSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaControleAnoCorrenteSipro IS NULL THEN ' UsaControleAnoCorrenteSipro : «Nulo» '
                                              WHEN  UsaControleAnoCorrenteSipro = 0 THEN ' UsaControleAnoCorrenteSipro : «Falso» '
                                              WHEN  UsaControleAnoCorrenteSipro = 1 THEN ' UsaControleAnoCorrenteSipro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermiteDiferencaDC IS NULL THEN ' PermiteDiferencaDC : «Nulo» '
                                              WHEN  PermiteDiferencaDC = 0 THEN ' PermiteDiferencaDC : «Falso» '
                                              WHEN  PermiteDiferencaDC = 1 THEN ' PermiteDiferencaDC : «Verdadeiro» '
                                    END 
                         + '| Assinatura8 : «' + RTRIM( ISNULL( CAST (Assinatura8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo8 : «' + RTRIM( ISNULL( CAST (Cargo8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf8 : «' + RTRIM( ISNULL( CAST (Cpf8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro8 : «' + RTRIM( ISNULL( CAST (Registro8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura9 : «' + RTRIM( ISNULL( CAST (Assinatura9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo9 : «' + RTRIM( ISNULL( CAST (Cargo9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf9 : «' + RTRIM( ISNULL( CAST (Cpf9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro9 : «' + RTRIM( ISNULL( CAST (Registro9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura10 : «' + RTRIM( ISNULL( CAST (Assinatura10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo10 : «' + RTRIM( ISNULL( CAST (Cargo10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf10 : «' + RTRIM( ISNULL( CAST (Cpf10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro10 : «' + RTRIM( ISNULL( CAST (Registro10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura11 : «' + RTRIM( ISNULL( CAST (Assinatura11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo11 : «' + RTRIM( ISNULL( CAST (Cargo11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf11 : «' + RTRIM( ISNULL( CAST (Cpf11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro11 : «' + RTRIM( ISNULL( CAST (Registro11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraAssinatura : «' + RTRIM( ISNULL( CAST (LarguraAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EspacoVertAssinatura : «' + RTRIM( ISNULL( CAST (EspacoVertAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAnoCorrenteIrParaSiscont IS NULL THEN ' UsaAnoCorrenteIrParaSiscont : «Nulo» '
                                              WHEN  UsaAnoCorrenteIrParaSiscont = 0 THEN ' UsaAnoCorrenteIrParaSiscont : «Falso» '
                                              WHEN  UsaAnoCorrenteIrParaSiscont = 1 THEN ' UsaAnoCorrenteIrParaSiscont : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag IS NULL THEN ' MostraVlBaseImpImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 0 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 1 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw IS NULL THEN ' ImpressaoFrenteVersoSiproSiscontw : «Nulo» '
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw = 0 THEN ' ImpressaoFrenteVersoSiproSiscontw : «Falso» '
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw = 1 THEN ' ImpressaoFrenteVersoSiproSiscontw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaProcessoSiscontw IS NULL THEN ' UsaProcessoSiscontw : «Nulo» '
                                              WHEN  UsaProcessoSiscontw = 0 THEN ' UsaProcessoSiscontw : «Falso» '
                                              WHEN  UsaProcessoSiscontw = 1 THEN ' UsaProcessoSiscontw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlertaDevolucaoReceitas IS NULL THEN ' AlertaDevolucaoReceitas : «Nulo» '
                                              WHEN  AlertaDevolucaoReceitas = 0 THEN ' AlertaDevolucaoReceitas : «Falso» '
                                              WHEN  AlertaDevolucaoReceitas = 1 THEN ' AlertaDevolucaoReceitas : «Verdadeiro» '
                                    END 
                         + '| IdUsuarioAssinatura4 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioAssinatura5 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioAssinatura6 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura4 IS NULL THEN ' AtivaAssinatura4 : «Nulo» '
                                              WHEN  AtivaAssinatura4 = 0 THEN ' AtivaAssinatura4 : «Falso» '
                                              WHEN  AtivaAssinatura4 = 1 THEN ' AtivaAssinatura4 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura5 IS NULL THEN ' AtivaAssinatura5 : «Nulo» '
                                              WHEN  AtivaAssinatura5 = 0 THEN ' AtivaAssinatura5 : «Falso» '
                                              WHEN  AtivaAssinatura5 = 1 THEN ' AtivaAssinatura5 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura6 IS NULL THEN ' AtivaAssinatura6 : «Nulo» '
                                              WHEN  AtivaAssinatura6 = 0 THEN ' AtivaAssinatura6 : «Falso» '
                                              WHEN  AtivaAssinatura6 = 1 THEN ' AtivaAssinatura6 : «Verdadeiro» '
                                    END 
                         + '| Assinatura12 : «' + RTRIM( ISNULL( CAST (Assinatura12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo12 : «' + RTRIM( ISNULL( CAST (Cargo12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf12 : «' + RTRIM( ISNULL( CAST (Cpf12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro12 : «' + RTRIM( ISNULL( CAST (Registro12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura13 : «' + RTRIM( ISNULL( CAST (Assinatura13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo13 : «' + RTRIM( ISNULL( CAST (Cargo13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf13 : «' + RTRIM( ISNULL( CAST (Cpf13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro13 : «' + RTRIM( ISNULL( CAST (Registro13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura14 : «' + RTRIM( ISNULL( CAST (Assinatura14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo14 : «' + RTRIM( ISNULL( CAST (Cargo14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf14 : «' + RTRIM( ISNULL( CAST (Cpf14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro14 : «' + RTRIM( ISNULL( CAST (Registro14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura15 : «' + RTRIM( ISNULL( CAST (Assinatura15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo15 : «' + RTRIM( ISNULL( CAST (Cargo15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf15 : «' + RTRIM( ISNULL( CAST (Cpf15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro15 : «' + RTRIM( ISNULL( CAST (Registro15 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutoNumera IS NULL THEN ' AutoNumera : «Nulo» '
                                              WHEN  AutoNumera = 0 THEN ' AutoNumera : «Falso» '
                                              WHEN  AutoNumera = 1 THEN ' AutoNumera : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComparativoSiscont IS NULL THEN ' ComparativoSiscont : «Nulo» '
                                              WHEN  ComparativoSiscont = 0 THEN ' ComparativoSiscont : «Falso» '
                                              WHEN  ComparativoSiscont = 1 THEN ' ComparativoSiscont : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraBotoes IS NULL THEN ' MostraBotoes : «Nulo» '
                                              WHEN  MostraBotoes = 0 THEN ' MostraBotoes : «Falso» '
                                              WHEN  MostraBotoes = 1 THEN ' MostraBotoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SomarReceitaDespesa IS NULL THEN ' SomarReceitaDespesa : «Nulo» '
                                              WHEN  SomarReceitaDespesa = 0 THEN ' SomarReceitaDespesa : «Falso» '
                                              WHEN  SomarReceitaDespesa = 1 THEN ' SomarReceitaDespesa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UltimoDiaUtil IS NULL THEN ' UltimoDiaUtil : «Nulo» '
                                              WHEN  UltimoDiaUtil = 0 THEN ' UltimoDiaUtil : «Falso» '
                                              WHEN  UltimoDiaUtil = 1 THEN ' UltimoDiaUtil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaMesmoHistorico IS NULL THEN ' UsaMesmoHistorico : «Nulo» '
                                              WHEN  UsaMesmoHistorico = 0 THEN ' UsaMesmoHistorico : «Falso» '
                                              WHEN  UsaMesmoHistorico = 1 THEN ' UsaMesmoHistorico : «Verdadeiro» '
                                    END 
                         + '| EspacoAssinatura : «' + RTRIM( ISNULL( CAST (EspacoAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Novidade : «' + RTRIM( ISNULL( CONVERT (CHAR, Novidade, 113 ),'Nulo'))+'» '
                         + '| NovidadeSipro : «' + RTRIM( ISNULL( CONVERT (CHAR, NovidadeSipro, 113 ),'Nulo'))+'» '
                         + '| Separador : «' + RTRIM( ISNULL( CAST (Separador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura1 : «' + RTRIM( ISNULL( CAST (Assinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo1 : «' + RTRIM( ISNULL( CAST (Cargo1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf1 : «' + RTRIM( ISNULL( CAST (Cpf1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro1 : «' + RTRIM( ISNULL( CAST (Registro1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura2 : «' + RTRIM( ISNULL( CAST (Assinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo2 : «' + RTRIM( ISNULL( CAST (Cargo2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf2 : «' + RTRIM( ISNULL( CAST (Cpf2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro2 : «' + RTRIM( ISNULL( CAST (Registro2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura3 : «' + RTRIM( ISNULL( CAST (Assinatura3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo3 : «' + RTRIM( ISNULL( CAST (Cargo3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf3 : «' + RTRIM( ISNULL( CAST (Cpf3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro3 : «' + RTRIM( ISNULL( CAST (Registro3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura4 : «' + RTRIM( ISNULL( CAST (Assinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo4 : «' + RTRIM( ISNULL( CAST (Cargo4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf4 : «' + RTRIM( ISNULL( CAST (Cpf4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro4 : «' + RTRIM( ISNULL( CAST (Registro4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura5 : «' + RTRIM( ISNULL( CAST (Assinatura5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo5 : «' + RTRIM( ISNULL( CAST (Cargo5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf5 : «' + RTRIM( ISNULL( CAST (Cpf5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro5 : «' + RTRIM( ISNULL( CAST (Registro5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura6 : «' + RTRIM( ISNULL( CAST (Assinatura6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo6 : «' + RTRIM( ISNULL( CAST (Cargo6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf6 : «' + RTRIM( ISNULL( CAST (Cpf6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro6 : «' + RTRIM( ISNULL( CAST (Registro6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura7 : «' + RTRIM( ISNULL( CAST (Assinatura7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo7 : «' + RTRIM( ISNULL( CAST (Cargo7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf7 : «' + RTRIM( ISNULL( CAST (Cpf7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro7 : «' + RTRIM( ISNULL( CAST (Registro7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AvisaA4 IS NULL THEN ' AvisaA4 : «Nulo» '
                                              WHEN  AvisaA4 = 0 THEN ' AvisaA4 : «Falso» '
                                              WHEN  AvisaA4 = 1 THEN ' AvisaA4 : «Verdadeiro» '
                                    END 
                         + '| AnoCorrente : «' + RTRIM( ISNULL( CAST (AnoCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NotaConjunta IS NULL THEN ' NotaConjunta : «Nulo» '
                                              WHEN  NotaConjunta = 0 THEN ' NotaConjunta : «Falso» '
                                              WHEN  NotaConjunta = 1 THEN ' NotaConjunta : «Verdadeiro» '
                                    END 
                         + '| Transferencia : «' + RTRIM( ISNULL( CAST (Transferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTela : «' + RTRIM( ISNULL( CAST (OrdemTela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoCorrenteSipro : «' + RTRIM( ISNULL( CAST (AnoCorrenteSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaControleAnoCorrenteSipro IS NULL THEN ' UsaControleAnoCorrenteSipro : «Nulo» '
                                              WHEN  UsaControleAnoCorrenteSipro = 0 THEN ' UsaControleAnoCorrenteSipro : «Falso» '
                                              WHEN  UsaControleAnoCorrenteSipro = 1 THEN ' UsaControleAnoCorrenteSipro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermiteDiferencaDC IS NULL THEN ' PermiteDiferencaDC : «Nulo» '
                                              WHEN  PermiteDiferencaDC = 0 THEN ' PermiteDiferencaDC : «Falso» '
                                              WHEN  PermiteDiferencaDC = 1 THEN ' PermiteDiferencaDC : «Verdadeiro» '
                                    END 
                         + '| Assinatura8 : «' + RTRIM( ISNULL( CAST (Assinatura8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo8 : «' + RTRIM( ISNULL( CAST (Cargo8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf8 : «' + RTRIM( ISNULL( CAST (Cpf8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro8 : «' + RTRIM( ISNULL( CAST (Registro8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura9 : «' + RTRIM( ISNULL( CAST (Assinatura9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo9 : «' + RTRIM( ISNULL( CAST (Cargo9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf9 : «' + RTRIM( ISNULL( CAST (Cpf9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro9 : «' + RTRIM( ISNULL( CAST (Registro9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura10 : «' + RTRIM( ISNULL( CAST (Assinatura10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo10 : «' + RTRIM( ISNULL( CAST (Cargo10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf10 : «' + RTRIM( ISNULL( CAST (Cpf10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro10 : «' + RTRIM( ISNULL( CAST (Registro10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura11 : «' + RTRIM( ISNULL( CAST (Assinatura11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo11 : «' + RTRIM( ISNULL( CAST (Cargo11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf11 : «' + RTRIM( ISNULL( CAST (Cpf11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro11 : «' + RTRIM( ISNULL( CAST (Registro11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraAssinatura : «' + RTRIM( ISNULL( CAST (LarguraAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EspacoVertAssinatura : «' + RTRIM( ISNULL( CAST (EspacoVertAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAnoCorrenteIrParaSiscont IS NULL THEN ' UsaAnoCorrenteIrParaSiscont : «Nulo» '
                                              WHEN  UsaAnoCorrenteIrParaSiscont = 0 THEN ' UsaAnoCorrenteIrParaSiscont : «Falso» '
                                              WHEN  UsaAnoCorrenteIrParaSiscont = 1 THEN ' UsaAnoCorrenteIrParaSiscont : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag IS NULL THEN ' MostraVlBaseImpImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 0 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 1 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw IS NULL THEN ' ImpressaoFrenteVersoSiproSiscontw : «Nulo» '
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw = 0 THEN ' ImpressaoFrenteVersoSiproSiscontw : «Falso» '
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw = 1 THEN ' ImpressaoFrenteVersoSiproSiscontw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaProcessoSiscontw IS NULL THEN ' UsaProcessoSiscontw : «Nulo» '
                                              WHEN  UsaProcessoSiscontw = 0 THEN ' UsaProcessoSiscontw : «Falso» '
                                              WHEN  UsaProcessoSiscontw = 1 THEN ' UsaProcessoSiscontw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlertaDevolucaoReceitas IS NULL THEN ' AlertaDevolucaoReceitas : «Nulo» '
                                              WHEN  AlertaDevolucaoReceitas = 0 THEN ' AlertaDevolucaoReceitas : «Falso» '
                                              WHEN  AlertaDevolucaoReceitas = 1 THEN ' AlertaDevolucaoReceitas : «Verdadeiro» '
                                    END 
                         + '| IdUsuarioAssinatura4 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioAssinatura5 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioAssinatura6 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura4 IS NULL THEN ' AtivaAssinatura4 : «Nulo» '
                                              WHEN  AtivaAssinatura4 = 0 THEN ' AtivaAssinatura4 : «Falso» '
                                              WHEN  AtivaAssinatura4 = 1 THEN ' AtivaAssinatura4 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura5 IS NULL THEN ' AtivaAssinatura5 : «Nulo» '
                                              WHEN  AtivaAssinatura5 = 0 THEN ' AtivaAssinatura5 : «Falso» '
                                              WHEN  AtivaAssinatura5 = 1 THEN ' AtivaAssinatura5 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura6 IS NULL THEN ' AtivaAssinatura6 : «Nulo» '
                                              WHEN  AtivaAssinatura6 = 0 THEN ' AtivaAssinatura6 : «Falso» '
                                              WHEN  AtivaAssinatura6 = 1 THEN ' AtivaAssinatura6 : «Verdadeiro» '
                                    END 
                         + '| Assinatura12 : «' + RTRIM( ISNULL( CAST (Assinatura12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo12 : «' + RTRIM( ISNULL( CAST (Cargo12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf12 : «' + RTRIM( ISNULL( CAST (Cpf12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro12 : «' + RTRIM( ISNULL( CAST (Registro12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura13 : «' + RTRIM( ISNULL( CAST (Assinatura13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo13 : «' + RTRIM( ISNULL( CAST (Cargo13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf13 : «' + RTRIM( ISNULL( CAST (Cpf13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro13 : «' + RTRIM( ISNULL( CAST (Registro13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura14 : «' + RTRIM( ISNULL( CAST (Assinatura14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo14 : «' + RTRIM( ISNULL( CAST (Cargo14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf14 : «' + RTRIM( ISNULL( CAST (Cpf14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro14 : «' + RTRIM( ISNULL( CAST (Registro14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura15 : «' + RTRIM( ISNULL( CAST (Assinatura15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo15 : «' + RTRIM( ISNULL( CAST (Cargo15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf15 : «' + RTRIM( ISNULL( CAST (Cpf15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro15 : «' + RTRIM( ISNULL( CAST (Registro15 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutoNumera IS NULL THEN ' AutoNumera : «Nulo» '
                                              WHEN  AutoNumera = 0 THEN ' AutoNumera : «Falso» '
                                              WHEN  AutoNumera = 1 THEN ' AutoNumera : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComparativoSiscont IS NULL THEN ' ComparativoSiscont : «Nulo» '
                                              WHEN  ComparativoSiscont = 0 THEN ' ComparativoSiscont : «Falso» '
                                              WHEN  ComparativoSiscont = 1 THEN ' ComparativoSiscont : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraBotoes IS NULL THEN ' MostraBotoes : «Nulo» '
                                              WHEN  MostraBotoes = 0 THEN ' MostraBotoes : «Falso» '
                                              WHEN  MostraBotoes = 1 THEN ' MostraBotoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SomarReceitaDespesa IS NULL THEN ' SomarReceitaDespesa : «Nulo» '
                                              WHEN  SomarReceitaDespesa = 0 THEN ' SomarReceitaDespesa : «Falso» '
                                              WHEN  SomarReceitaDespesa = 1 THEN ' SomarReceitaDespesa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UltimoDiaUtil IS NULL THEN ' UltimoDiaUtil : «Nulo» '
                                              WHEN  UltimoDiaUtil = 0 THEN ' UltimoDiaUtil : «Falso» '
                                              WHEN  UltimoDiaUtil = 1 THEN ' UltimoDiaUtil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaMesmoHistorico IS NULL THEN ' UsaMesmoHistorico : «Nulo» '
                                              WHEN  UsaMesmoHistorico = 0 THEN ' UsaMesmoHistorico : «Falso» '
                                              WHEN  UsaMesmoHistorico = 1 THEN ' UsaMesmoHistorico : «Verdadeiro» '
                                    END 
                         + '| EspacoAssinatura : «' + RTRIM( ISNULL( CAST (EspacoAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Novidade : «' + RTRIM( ISNULL( CONVERT (CHAR, Novidade, 113 ),'Nulo'))+'» '
                         + '| NovidadeSipro : «' + RTRIM( ISNULL( CONVERT (CHAR, NovidadeSipro, 113 ),'Nulo'))+'» '
                         + '| Separador : «' + RTRIM( ISNULL( CAST (Separador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura1 : «' + RTRIM( ISNULL( CAST (Assinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo1 : «' + RTRIM( ISNULL( CAST (Cargo1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf1 : «' + RTRIM( ISNULL( CAST (Cpf1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro1 : «' + RTRIM( ISNULL( CAST (Registro1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura2 : «' + RTRIM( ISNULL( CAST (Assinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo2 : «' + RTRIM( ISNULL( CAST (Cargo2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf2 : «' + RTRIM( ISNULL( CAST (Cpf2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro2 : «' + RTRIM( ISNULL( CAST (Registro2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura3 : «' + RTRIM( ISNULL( CAST (Assinatura3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo3 : «' + RTRIM( ISNULL( CAST (Cargo3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf3 : «' + RTRIM( ISNULL( CAST (Cpf3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro3 : «' + RTRIM( ISNULL( CAST (Registro3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura4 : «' + RTRIM( ISNULL( CAST (Assinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo4 : «' + RTRIM( ISNULL( CAST (Cargo4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf4 : «' + RTRIM( ISNULL( CAST (Cpf4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro4 : «' + RTRIM( ISNULL( CAST (Registro4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura5 : «' + RTRIM( ISNULL( CAST (Assinatura5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo5 : «' + RTRIM( ISNULL( CAST (Cargo5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf5 : «' + RTRIM( ISNULL( CAST (Cpf5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro5 : «' + RTRIM( ISNULL( CAST (Registro5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura6 : «' + RTRIM( ISNULL( CAST (Assinatura6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo6 : «' + RTRIM( ISNULL( CAST (Cargo6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf6 : «' + RTRIM( ISNULL( CAST (Cpf6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro6 : «' + RTRIM( ISNULL( CAST (Registro6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura7 : «' + RTRIM( ISNULL( CAST (Assinatura7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo7 : «' + RTRIM( ISNULL( CAST (Cargo7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf7 : «' + RTRIM( ISNULL( CAST (Cpf7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro7 : «' + RTRIM( ISNULL( CAST (Registro7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AvisaA4 IS NULL THEN ' AvisaA4 : «Nulo» '
                                              WHEN  AvisaA4 = 0 THEN ' AvisaA4 : «Falso» '
                                              WHEN  AvisaA4 = 1 THEN ' AvisaA4 : «Verdadeiro» '
                                    END 
                         + '| AnoCorrente : «' + RTRIM( ISNULL( CAST (AnoCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NotaConjunta IS NULL THEN ' NotaConjunta : «Nulo» '
                                              WHEN  NotaConjunta = 0 THEN ' NotaConjunta : «Falso» '
                                              WHEN  NotaConjunta = 1 THEN ' NotaConjunta : «Verdadeiro» '
                                    END 
                         + '| Transferencia : «' + RTRIM( ISNULL( CAST (Transferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTela : «' + RTRIM( ISNULL( CAST (OrdemTela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoCorrenteSipro : «' + RTRIM( ISNULL( CAST (AnoCorrenteSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaControleAnoCorrenteSipro IS NULL THEN ' UsaControleAnoCorrenteSipro : «Nulo» '
                                              WHEN  UsaControleAnoCorrenteSipro = 0 THEN ' UsaControleAnoCorrenteSipro : «Falso» '
                                              WHEN  UsaControleAnoCorrenteSipro = 1 THEN ' UsaControleAnoCorrenteSipro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermiteDiferencaDC IS NULL THEN ' PermiteDiferencaDC : «Nulo» '
                                              WHEN  PermiteDiferencaDC = 0 THEN ' PermiteDiferencaDC : «Falso» '
                                              WHEN  PermiteDiferencaDC = 1 THEN ' PermiteDiferencaDC : «Verdadeiro» '
                                    END 
                         + '| Assinatura8 : «' + RTRIM( ISNULL( CAST (Assinatura8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo8 : «' + RTRIM( ISNULL( CAST (Cargo8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf8 : «' + RTRIM( ISNULL( CAST (Cpf8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro8 : «' + RTRIM( ISNULL( CAST (Registro8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura9 : «' + RTRIM( ISNULL( CAST (Assinatura9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo9 : «' + RTRIM( ISNULL( CAST (Cargo9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf9 : «' + RTRIM( ISNULL( CAST (Cpf9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro9 : «' + RTRIM( ISNULL( CAST (Registro9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura10 : «' + RTRIM( ISNULL( CAST (Assinatura10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo10 : «' + RTRIM( ISNULL( CAST (Cargo10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf10 : «' + RTRIM( ISNULL( CAST (Cpf10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro10 : «' + RTRIM( ISNULL( CAST (Registro10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura11 : «' + RTRIM( ISNULL( CAST (Assinatura11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo11 : «' + RTRIM( ISNULL( CAST (Cargo11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf11 : «' + RTRIM( ISNULL( CAST (Cpf11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro11 : «' + RTRIM( ISNULL( CAST (Registro11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraAssinatura : «' + RTRIM( ISNULL( CAST (LarguraAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EspacoVertAssinatura : «' + RTRIM( ISNULL( CAST (EspacoVertAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAnoCorrenteIrParaSiscont IS NULL THEN ' UsaAnoCorrenteIrParaSiscont : «Nulo» '
                                              WHEN  UsaAnoCorrenteIrParaSiscont = 0 THEN ' UsaAnoCorrenteIrParaSiscont : «Falso» '
                                              WHEN  UsaAnoCorrenteIrParaSiscont = 1 THEN ' UsaAnoCorrenteIrParaSiscont : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag IS NULL THEN ' MostraVlBaseImpImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 0 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 1 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw IS NULL THEN ' ImpressaoFrenteVersoSiproSiscontw : «Nulo» '
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw = 0 THEN ' ImpressaoFrenteVersoSiproSiscontw : «Falso» '
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw = 1 THEN ' ImpressaoFrenteVersoSiproSiscontw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaProcessoSiscontw IS NULL THEN ' UsaProcessoSiscontw : «Nulo» '
                                              WHEN  UsaProcessoSiscontw = 0 THEN ' UsaProcessoSiscontw : «Falso» '
                                              WHEN  UsaProcessoSiscontw = 1 THEN ' UsaProcessoSiscontw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlertaDevolucaoReceitas IS NULL THEN ' AlertaDevolucaoReceitas : «Nulo» '
                                              WHEN  AlertaDevolucaoReceitas = 0 THEN ' AlertaDevolucaoReceitas : «Falso» '
                                              WHEN  AlertaDevolucaoReceitas = 1 THEN ' AlertaDevolucaoReceitas : «Verdadeiro» '
                                    END 
                         + '| IdUsuarioAssinatura4 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioAssinatura5 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioAssinatura6 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura4 IS NULL THEN ' AtivaAssinatura4 : «Nulo» '
                                              WHEN  AtivaAssinatura4 = 0 THEN ' AtivaAssinatura4 : «Falso» '
                                              WHEN  AtivaAssinatura4 = 1 THEN ' AtivaAssinatura4 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura5 IS NULL THEN ' AtivaAssinatura5 : «Nulo» '
                                              WHEN  AtivaAssinatura5 = 0 THEN ' AtivaAssinatura5 : «Falso» '
                                              WHEN  AtivaAssinatura5 = 1 THEN ' AtivaAssinatura5 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura6 IS NULL THEN ' AtivaAssinatura6 : «Nulo» '
                                              WHEN  AtivaAssinatura6 = 0 THEN ' AtivaAssinatura6 : «Falso» '
                                              WHEN  AtivaAssinatura6 = 1 THEN ' AtivaAssinatura6 : «Verdadeiro» '
                                    END 
                         + '| Assinatura12 : «' + RTRIM( ISNULL( CAST (Assinatura12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo12 : «' + RTRIM( ISNULL( CAST (Cargo12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf12 : «' + RTRIM( ISNULL( CAST (Cpf12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro12 : «' + RTRIM( ISNULL( CAST (Registro12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura13 : «' + RTRIM( ISNULL( CAST (Assinatura13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo13 : «' + RTRIM( ISNULL( CAST (Cargo13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf13 : «' + RTRIM( ISNULL( CAST (Cpf13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro13 : «' + RTRIM( ISNULL( CAST (Registro13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura14 : «' + RTRIM( ISNULL( CAST (Assinatura14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo14 : «' + RTRIM( ISNULL( CAST (Cargo14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf14 : «' + RTRIM( ISNULL( CAST (Cpf14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro14 : «' + RTRIM( ISNULL( CAST (Registro14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura15 : «' + RTRIM( ISNULL( CAST (Assinatura15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo15 : «' + RTRIM( ISNULL( CAST (Cargo15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf15 : «' + RTRIM( ISNULL( CAST (Cpf15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro15 : «' + RTRIM( ISNULL( CAST (Registro15 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutoNumera IS NULL THEN ' AutoNumera : «Nulo» '
                                              WHEN  AutoNumera = 0 THEN ' AutoNumera : «Falso» '
                                              WHEN  AutoNumera = 1 THEN ' AutoNumera : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ComparativoSiscont IS NULL THEN ' ComparativoSiscont : «Nulo» '
                                              WHEN  ComparativoSiscont = 0 THEN ' ComparativoSiscont : «Falso» '
                                              WHEN  ComparativoSiscont = 1 THEN ' ComparativoSiscont : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraBotoes IS NULL THEN ' MostraBotoes : «Nulo» '
                                              WHEN  MostraBotoes = 0 THEN ' MostraBotoes : «Falso» '
                                              WHEN  MostraBotoes = 1 THEN ' MostraBotoes : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SomarReceitaDespesa IS NULL THEN ' SomarReceitaDespesa : «Nulo» '
                                              WHEN  SomarReceitaDespesa = 0 THEN ' SomarReceitaDespesa : «Falso» '
                                              WHEN  SomarReceitaDespesa = 1 THEN ' SomarReceitaDespesa : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UltimoDiaUtil IS NULL THEN ' UltimoDiaUtil : «Nulo» '
                                              WHEN  UltimoDiaUtil = 0 THEN ' UltimoDiaUtil : «Falso» '
                                              WHEN  UltimoDiaUtil = 1 THEN ' UltimoDiaUtil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaMesmoHistorico IS NULL THEN ' UsaMesmoHistorico : «Nulo» '
                                              WHEN  UsaMesmoHistorico = 0 THEN ' UsaMesmoHistorico : «Falso» '
                                              WHEN  UsaMesmoHistorico = 1 THEN ' UsaMesmoHistorico : «Verdadeiro» '
                                    END 
                         + '| EspacoAssinatura : «' + RTRIM( ISNULL( CAST (EspacoAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Novidade : «' + RTRIM( ISNULL( CONVERT (CHAR, Novidade, 113 ),'Nulo'))+'» '
                         + '| NovidadeSipro : «' + RTRIM( ISNULL( CONVERT (CHAR, NovidadeSipro, 113 ),'Nulo'))+'» '
                         + '| Separador : «' + RTRIM( ISNULL( CAST (Separador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura1 : «' + RTRIM( ISNULL( CAST (Assinatura1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo1 : «' + RTRIM( ISNULL( CAST (Cargo1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf1 : «' + RTRIM( ISNULL( CAST (Cpf1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro1 : «' + RTRIM( ISNULL( CAST (Registro1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura2 : «' + RTRIM( ISNULL( CAST (Assinatura2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo2 : «' + RTRIM( ISNULL( CAST (Cargo2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf2 : «' + RTRIM( ISNULL( CAST (Cpf2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro2 : «' + RTRIM( ISNULL( CAST (Registro2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura3 : «' + RTRIM( ISNULL( CAST (Assinatura3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo3 : «' + RTRIM( ISNULL( CAST (Cargo3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf3 : «' + RTRIM( ISNULL( CAST (Cpf3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro3 : «' + RTRIM( ISNULL( CAST (Registro3 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura4 : «' + RTRIM( ISNULL( CAST (Assinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo4 : «' + RTRIM( ISNULL( CAST (Cargo4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf4 : «' + RTRIM( ISNULL( CAST (Cpf4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro4 : «' + RTRIM( ISNULL( CAST (Registro4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura5 : «' + RTRIM( ISNULL( CAST (Assinatura5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo5 : «' + RTRIM( ISNULL( CAST (Cargo5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf5 : «' + RTRIM( ISNULL( CAST (Cpf5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro5 : «' + RTRIM( ISNULL( CAST (Registro5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura6 : «' + RTRIM( ISNULL( CAST (Assinatura6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo6 : «' + RTRIM( ISNULL( CAST (Cargo6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf6 : «' + RTRIM( ISNULL( CAST (Cpf6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro6 : «' + RTRIM( ISNULL( CAST (Registro6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura7 : «' + RTRIM( ISNULL( CAST (Assinatura7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo7 : «' + RTRIM( ISNULL( CAST (Cargo7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf7 : «' + RTRIM( ISNULL( CAST (Cpf7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro7 : «' + RTRIM( ISNULL( CAST (Registro7 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AvisaA4 IS NULL THEN ' AvisaA4 : «Nulo» '
                                              WHEN  AvisaA4 = 0 THEN ' AvisaA4 : «Falso» '
                                              WHEN  AvisaA4 = 1 THEN ' AvisaA4 : «Verdadeiro» '
                                    END 
                         + '| AnoCorrente : «' + RTRIM( ISNULL( CAST (AnoCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  NotaConjunta IS NULL THEN ' NotaConjunta : «Nulo» '
                                              WHEN  NotaConjunta = 0 THEN ' NotaConjunta : «Falso» '
                                              WHEN  NotaConjunta = 1 THEN ' NotaConjunta : «Verdadeiro» '
                                    END 
                         + '| Transferencia : «' + RTRIM( ISNULL( CAST (Transferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemTela : «' + RTRIM( ISNULL( CAST (OrdemTela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoCorrenteSipro : «' + RTRIM( ISNULL( CAST (AnoCorrenteSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaControleAnoCorrenteSipro IS NULL THEN ' UsaControleAnoCorrenteSipro : «Nulo» '
                                              WHEN  UsaControleAnoCorrenteSipro = 0 THEN ' UsaControleAnoCorrenteSipro : «Falso» '
                                              WHEN  UsaControleAnoCorrenteSipro = 1 THEN ' UsaControleAnoCorrenteSipro : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermiteDiferencaDC IS NULL THEN ' PermiteDiferencaDC : «Nulo» '
                                              WHEN  PermiteDiferencaDC = 0 THEN ' PermiteDiferencaDC : «Falso» '
                                              WHEN  PermiteDiferencaDC = 1 THEN ' PermiteDiferencaDC : «Verdadeiro» '
                                    END 
                         + '| Assinatura8 : «' + RTRIM( ISNULL( CAST (Assinatura8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo8 : «' + RTRIM( ISNULL( CAST (Cargo8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf8 : «' + RTRIM( ISNULL( CAST (Cpf8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro8 : «' + RTRIM( ISNULL( CAST (Registro8 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura9 : «' + RTRIM( ISNULL( CAST (Assinatura9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo9 : «' + RTRIM( ISNULL( CAST (Cargo9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf9 : «' + RTRIM( ISNULL( CAST (Cpf9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro9 : «' + RTRIM( ISNULL( CAST (Registro9 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura10 : «' + RTRIM( ISNULL( CAST (Assinatura10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo10 : «' + RTRIM( ISNULL( CAST (Cargo10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf10 : «' + RTRIM( ISNULL( CAST (Cpf10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro10 : «' + RTRIM( ISNULL( CAST (Registro10 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura11 : «' + RTRIM( ISNULL( CAST (Assinatura11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo11 : «' + RTRIM( ISNULL( CAST (Cargo11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf11 : «' + RTRIM( ISNULL( CAST (Cpf11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro11 : «' + RTRIM( ISNULL( CAST (Registro11 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraAssinatura : «' + RTRIM( ISNULL( CAST (LarguraAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EspacoVertAssinatura : «' + RTRIM( ISNULL( CAST (EspacoVertAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaAnoCorrenteIrParaSiscont IS NULL THEN ' UsaAnoCorrenteIrParaSiscont : «Nulo» '
                                              WHEN  UsaAnoCorrenteIrParaSiscont = 0 THEN ' UsaAnoCorrenteIrParaSiscont : «Falso» '
                                              WHEN  UsaAnoCorrenteIrParaSiscont = 1 THEN ' UsaAnoCorrenteIrParaSiscont : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag IS NULL THEN ' MostraVlBaseImpImpressaoBaixaPag : «Nulo» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 0 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Falso» '
                                              WHEN  MostraVlBaseImpImpressaoBaixaPag = 1 THEN ' MostraVlBaseImpImpressaoBaixaPag : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw IS NULL THEN ' ImpressaoFrenteVersoSiproSiscontw : «Nulo» '
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw = 0 THEN ' ImpressaoFrenteVersoSiproSiscontw : «Falso» '
                                              WHEN  ImpressaoFrenteVersoSiproSiscontw = 1 THEN ' ImpressaoFrenteVersoSiproSiscontw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  UsaProcessoSiscontw IS NULL THEN ' UsaProcessoSiscontw : «Nulo» '
                                              WHEN  UsaProcessoSiscontw = 0 THEN ' UsaProcessoSiscontw : «Falso» '
                                              WHEN  UsaProcessoSiscontw = 1 THEN ' UsaProcessoSiscontw : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AlertaDevolucaoReceitas IS NULL THEN ' AlertaDevolucaoReceitas : «Nulo» '
                                              WHEN  AlertaDevolucaoReceitas = 0 THEN ' AlertaDevolucaoReceitas : «Falso» '
                                              WHEN  AlertaDevolucaoReceitas = 1 THEN ' AlertaDevolucaoReceitas : «Verdadeiro» '
                                    END 
                         + '| IdUsuarioAssinatura4 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura4 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioAssinatura5 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura5 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioAssinatura6 : «' + RTRIM( ISNULL( CAST (IdUsuarioAssinatura6 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura4 IS NULL THEN ' AtivaAssinatura4 : «Nulo» '
                                              WHEN  AtivaAssinatura4 = 0 THEN ' AtivaAssinatura4 : «Falso» '
                                              WHEN  AtivaAssinatura4 = 1 THEN ' AtivaAssinatura4 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura5 IS NULL THEN ' AtivaAssinatura5 : «Nulo» '
                                              WHEN  AtivaAssinatura5 = 0 THEN ' AtivaAssinatura5 : «Falso» '
                                              WHEN  AtivaAssinatura5 = 1 THEN ' AtivaAssinatura5 : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AtivaAssinatura6 IS NULL THEN ' AtivaAssinatura6 : «Nulo» '
                                              WHEN  AtivaAssinatura6 = 0 THEN ' AtivaAssinatura6 : «Falso» '
                                              WHEN  AtivaAssinatura6 = 1 THEN ' AtivaAssinatura6 : «Verdadeiro» '
                                    END 
                         + '| Assinatura12 : «' + RTRIM( ISNULL( CAST (Assinatura12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo12 : «' + RTRIM( ISNULL( CAST (Cargo12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf12 : «' + RTRIM( ISNULL( CAST (Cpf12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro12 : «' + RTRIM( ISNULL( CAST (Registro12 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura13 : «' + RTRIM( ISNULL( CAST (Assinatura13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo13 : «' + RTRIM( ISNULL( CAST (Cargo13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf13 : «' + RTRIM( ISNULL( CAST (Cpf13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro13 : «' + RTRIM( ISNULL( CAST (Registro13 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura14 : «' + RTRIM( ISNULL( CAST (Assinatura14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo14 : «' + RTRIM( ISNULL( CAST (Cargo14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf14 : «' + RTRIM( ISNULL( CAST (Cpf14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro14 : «' + RTRIM( ISNULL( CAST (Registro14 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura15 : «' + RTRIM( ISNULL( CAST (Assinatura15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo15 : «' + RTRIM( ISNULL( CAST (Cargo15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cpf15 : «' + RTRIM( ISNULL( CAST (Cpf15 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro15 : «' + RTRIM( ISNULL( CAST (Registro15 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
