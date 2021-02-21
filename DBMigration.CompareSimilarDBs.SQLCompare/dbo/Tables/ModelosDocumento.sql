CREATE TABLE [dbo].[ModelosDocumento] (
    [IdModeloDocumento]           INT           IDENTITY (1, 1) NOT NULL,
    [IdTipoDocumento]             INT           NOT NULL,
    [DescricaoModelo]             VARCHAR (40)  NOT NULL,
    [SiglaModelo]                 VARCHAR (15)  NULL,
    [UsaMascaraNumeracao]         BIT           NULL,
    [IdFuncao]                    INT           NULL,
    [TextoModeloDoc]              TEXT          NULL,
    [PrefixoModelo]               VARCHAR (20)  NULL,
    [SufixoModelo]                VARCHAR (20)  NULL,
    [TipoNumeracaoAutomatica]     INT           NULL,
    [Pagina]                      VARCHAR (20)  NULL,
    [PaginaAltura]                FLOAT (53)    NULL,
    [PaginaLargura]               FLOAT (53)    NULL,
    [PaginaOrientacao]            FLOAT (53)    NULL,
    [MargemSuperior]              FLOAT (53)    NULL,
    [MargemInferior]              FLOAT (53)    NULL,
    [MargemEsquerda]              FLOAT (53)    NULL,
    [MargemDireita]               FLOAT (53)    NULL,
    [IdSituacaoDocumentoPadrao]   INT           NULL,
    [IdNivelDocumentoPadrao]      INT           NULL,
    [AssuntoPadrao]               VARCHAR (120) NULL,
    [RegistrarNoSisDoc]           BIT           NULL,
    [TipoPessoa]                  INT           NULL,
    [TamanhoNumeroAuto]           INT           NULL,
    [ConfiguracaoModelo]          TEXT          NULL,
    [NumeroDocumento]             INT           NULL,
    [ExibirMenuModelo]            BIT           NULL,
    [ReiniciaNumeracaoAnual]      BIT           NULL,
    [AceitaNumeracaoDuplicada]    BIT           NULL,
    [Carteirinha]                 BIT           NULL,
    [NumeroCarteiraObrigatorio]   BIT           NOT NULL,
    [PermiteAlteracaoPreview]     BIT           CONSTRAINT [DF__ModelosDo__Permi__76D75FA7] DEFAULT ((1)) NOT NULL,
    [MarcaDAgua]                  IMAGE         NULL,
    [ClarearMarcaDAgua]           BIT           CONSTRAINT [DF__ModelosDo__Clare__78C9C9BA] DEFAULT ((0)) NOT NULL,
    [ExibirMarcaDAgua]            BIT           CONSTRAINT [DF__ModelosDo__Exibi__79BDEDF3] DEFAULT ((0)) NOT NULL,
    [IdDeptoPadrao]               INT           NULL,
    [QtdDiaPrevisto]              INT           NULL,
    [UsaDeptoPadrao]              BIT           CONSTRAINT [DF__ModelosDo__UsaDe__4FCAE183] DEFAULT ((0)) NULL,
    [DiaUtil]                     BIT           CONSTRAINT [DF__ModelosDo__DiaUt__50BF05BC] DEFAULT ((0)) NULL,
    [IdTipoProcesso]              INT           NULL,
    [CalcDiaUtil]                 BIT           CONSTRAINT [DF_ModelosDocumentoCalcDiaUtil] DEFAULT ((0)) NULL,
    [VerificarDuplicidadeAoCriar] BIT           CONSTRAINT [DF_ModelosDocumentoVerifDuplicCriar] DEFAULT ((0)) NULL,
    [AcordoRenpadrao]             BIT           NULL,
    [IndVinculoManualSisDoc]      INT           CONSTRAINT [DF__ModelosDo__IndVi__662DBF0A] DEFAULT ((0)) NULL,
    [IdTipoDocumentoNumeracao]    INT           NULL,
    [IndVinculaImgSisdoc]         BIT           CONSTRAINT [DEF_IndVinculaImgSisdoc] DEFAULT ((0)) NOT NULL,
    [NivelAcesso]                 INT           CONSTRAINT [DEF_ModelosDocumentoNivelAcesso] DEFAULT ((0)) NOT NULL,
    [IndWeb]                      BIT           CONSTRAINT [DEF_ModelosDocumentoIndWeb] DEFAULT ((0)) NOT NULL,
    [SqlPrincipal]                TEXT          NULL,
    [ModeloGravaNrInf]            BIT           CONSTRAINT [DF_ModelosDocumento_ModeloGravaNrInf] DEFAULT ((0)) NULL,
    [SalvarCopiaSisdoc]           BIT           CONSTRAINT [DEF_ModelosDocumento_SalvarCopiaSisdoc] DEFAULT ((0)) NOT NULL,
    [SalvarCopiaProcessos]        BIT           NULL,
    [SqlTabela1]                  TEXT          NULL,
    [SqlTabela2]                  TEXT          NULL,
    [InstrucaoImpressao]          VARCHAR (250) NULL,
    CONSTRAINT [PK_ModelosDocumento] PRIMARY KEY CLUSTERED ([IdModeloDocumento] ASC),
    CONSTRAINT [FK_ModelosDocumento_FuncoesSiscafw] FOREIGN KEY ([IdFuncao]) REFERENCES [dbo].[FuncoesSiscafw] ([IdFuncao]),
    CONSTRAINT [FK_ModelosDocumento_TiposDocumento] FOREIGN KEY ([IdTipoDocumento]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ModelosDocumentos_NiveisAcessoDocumento] FOREIGN KEY ([IdNivelDocumentoPadrao]) REFERENCES [dbo].[NiveisAcessoDocumento] ([IdNivelAcessoDocumento]),
    CONSTRAINT [FK_ModelosDocumentos_SituacoesDocumentos] FOREIGN KEY ([IdSituacaoDocumentoPadrao]) REFERENCES [dbo].[SituacoesDocumento] ([IdSituacaoDocumento])
);


GO

CREATE TRIGGER dbo.Trg_ModeloGravaNrInf ON dbo.ModelosDocumento 
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @COUNT  INT
	DECLARE @ID     INT
	
	SELECT @COUNT = COUNT(*)
	FROM   INSERTED
	WHERE  ModeloGravaNrInf = 1
	
	/* Se apenas um registro recebeu a marcação True para o campo ModeloGravaNrInf
	*  então o que faço é garantir que os demais ficarão com este campo com a atribuição False */
	IF @COUNT = 1
	BEGIN
	    SELECT @ID = IdModeloDocumento
	    FROM   INSERTED
	    
	    UPDATE ModelosDocumento
	    SET    ModeloGravaNrInf = 0
	    WHERE  IdModeloDocumento <> @ID
	END
	
	/* Se mais de um registro foi alterado e recebeu a marcação de True para o campo ModeloGravaNrInf
	*  então o que eu faço é ignorar deixar somente marcado com True o registro que já estiver com 
	*  esta marcação no banco. */
	IF @COUNT > 1
	BEGIN
	    UPDATE ModelosDocumento
	    SET    ModeloGravaNrInf = 0
	    WHERE  IdModeloDocumento IN (SELECT IdModeloDocumento
	                                 FROM   INSERTED
	                                 WHERE  ModeloGravaNrInf = 1)
	           AND IdModeloDocumento  IN (SELECT IdModeloDocumento
	                                      FROM   DELETED
	                                      WHERE  ModeloGravaNrInf = 0)
	END
END
GO
CREATE TRIGGER [TrgLog_ModelosDocumento] ON [Implanta_CRPAM].[dbo].[ModelosDocumento] 
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
SET @TableName = 'ModelosDocumento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoModelo : «' + RTRIM( ISNULL( CAST (DescricaoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaModelo : «' + RTRIM( ISNULL( CAST (SiglaModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaMascaraNumeracao IS NULL THEN ' UsaMascaraNumeracao : «Nulo» '
                                              WHEN  UsaMascaraNumeracao = 0 THEN ' UsaMascaraNumeracao : «Falso» '
                                              WHEN  UsaMascaraNumeracao = 1 THEN ' UsaMascaraNumeracao : «Verdadeiro» '
                                    END 
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoModelo : «' + RTRIM( ISNULL( CAST (PrefixoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoModelo : «' + RTRIM( ISNULL( CAST (SufixoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoNumeracaoAutomatica : «' + RTRIM( ISNULL( CAST (TipoNumeracaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaAltura : «' + RTRIM( ISNULL( CAST (PaginaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaLargura : «' + RTRIM( ISNULL( CAST (PaginaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaOrientacao : «' + RTRIM( ISNULL( CAST (PaginaOrientacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDocumentoPadrao : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelDocumentoPadrao : «' + RTRIM( ISNULL( CAST (IdNivelDocumentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoPadrao : «' + RTRIM( ISNULL( CAST (AssuntoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistrarNoSisDoc IS NULL THEN ' RegistrarNoSisDoc : «Nulo» '
                                              WHEN  RegistrarNoSisDoc = 0 THEN ' RegistrarNoSisDoc : «Falso» '
                                              WHEN  RegistrarNoSisDoc = 1 THEN ' RegistrarNoSisDoc : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumeroAuto : «' + RTRIM( ISNULL( CAST (TamanhoNumeroAuto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirMenuModelo IS NULL THEN ' ExibirMenuModelo : «Nulo» '
                                              WHEN  ExibirMenuModelo = 0 THEN ' ExibirMenuModelo : «Falso» '
                                              WHEN  ExibirMenuModelo = 1 THEN ' ExibirMenuModelo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReiniciaNumeracaoAnual IS NULL THEN ' ReiniciaNumeracaoAnual : «Nulo» '
                                              WHEN  ReiniciaNumeracaoAnual = 0 THEN ' ReiniciaNumeracaoAnual : «Falso» '
                                              WHEN  ReiniciaNumeracaoAnual = 1 THEN ' ReiniciaNumeracaoAnual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitaNumeracaoDuplicada IS NULL THEN ' AceitaNumeracaoDuplicada : «Nulo» '
                                              WHEN  AceitaNumeracaoDuplicada = 0 THEN ' AceitaNumeracaoDuplicada : «Falso» '
                                              WHEN  AceitaNumeracaoDuplicada = 1 THEN ' AceitaNumeracaoDuplicada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Carteirinha IS NULL THEN ' Carteirinha : «Nulo» '
                                              WHEN  Carteirinha = 0 THEN ' Carteirinha : «Falso» '
                                              WHEN  Carteirinha = 1 THEN ' Carteirinha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NumeroCarteiraObrigatorio IS NULL THEN ' NumeroCarteiraObrigatorio : «Nulo» '
                                              WHEN  NumeroCarteiraObrigatorio = 0 THEN ' NumeroCarteiraObrigatorio : «Falso» '
                                              WHEN  NumeroCarteiraObrigatorio = 1 THEN ' NumeroCarteiraObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermiteAlteracaoPreview IS NULL THEN ' PermiteAlteracaoPreview : «Nulo» '
                                              WHEN  PermiteAlteracaoPreview = 0 THEN ' PermiteAlteracaoPreview : «Falso» '
                                              WHEN  PermiteAlteracaoPreview = 1 THEN ' PermiteAlteracaoPreview : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ClarearMarcaDAgua IS NULL THEN ' ClarearMarcaDAgua : «Nulo» '
                                              WHEN  ClarearMarcaDAgua = 0 THEN ' ClarearMarcaDAgua : «Falso» '
                                              WHEN  ClarearMarcaDAgua = 1 THEN ' ClarearMarcaDAgua : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirMarcaDAgua IS NULL THEN ' ExibirMarcaDAgua : «Nulo» '
                                              WHEN  ExibirMarcaDAgua = 0 THEN ' ExibirMarcaDAgua : «Falso» '
                                              WHEN  ExibirMarcaDAgua = 1 THEN ' ExibirMarcaDAgua : «Verdadeiro» '
                                    END 
                         + '| IdDeptoPadrao : «' + RTRIM( ISNULL( CAST (IdDeptoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiaPrevisto : «' + RTRIM( ISNULL( CAST (QtdDiaPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaDeptoPadrao IS NULL THEN ' UsaDeptoPadrao : «Nulo» '
                                              WHEN  UsaDeptoPadrao = 0 THEN ' UsaDeptoPadrao : «Falso» '
                                              WHEN  UsaDeptoPadrao = 1 THEN ' UsaDeptoPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DiaUtil IS NULL THEN ' DiaUtil : «Nulo» '
                                              WHEN  DiaUtil = 0 THEN ' DiaUtil : «Falso» '
                                              WHEN  DiaUtil = 1 THEN ' DiaUtil : «Verdadeiro» '
                                    END 
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CalcDiaUtil IS NULL THEN ' CalcDiaUtil : «Nulo» '
                                              WHEN  CalcDiaUtil = 0 THEN ' CalcDiaUtil : «Falso» '
                                              WHEN  CalcDiaUtil = 1 THEN ' CalcDiaUtil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VerificarDuplicidadeAoCriar IS NULL THEN ' VerificarDuplicidadeAoCriar : «Nulo» '
                                              WHEN  VerificarDuplicidadeAoCriar = 0 THEN ' VerificarDuplicidadeAoCriar : «Falso» '
                                              WHEN  VerificarDuplicidadeAoCriar = 1 THEN ' VerificarDuplicidadeAoCriar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AcordoRenpadrao IS NULL THEN ' AcordoRenpadrao : «Nulo» '
                                              WHEN  AcordoRenpadrao = 0 THEN ' AcordoRenpadrao : «Falso» '
                                              WHEN  AcordoRenpadrao = 1 THEN ' AcordoRenpadrao : «Verdadeiro» '
                                    END 
                         + '| IndVinculoManualSisDoc : «' + RTRIM( ISNULL( CAST (IndVinculoManualSisDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoNumeracao : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoNumeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndVinculaImgSisdoc IS NULL THEN ' IndVinculaImgSisdoc : «Nulo» '
                                              WHEN  IndVinculaImgSisdoc = 0 THEN ' IndVinculaImgSisdoc : «Falso» '
                                              WHEN  IndVinculaImgSisdoc = 1 THEN ' IndVinculaImgSisdoc : «Verdadeiro» '
                                    END 
                         + '| NivelAcesso : «' + RTRIM( ISNULL( CAST (NivelAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndWeb IS NULL THEN ' IndWeb : «Nulo» '
                                              WHEN  IndWeb = 0 THEN ' IndWeb : «Falso» '
                                              WHEN  IndWeb = 1 THEN ' IndWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ModeloGravaNrInf IS NULL THEN ' ModeloGravaNrInf : «Nulo» '
                                              WHEN  ModeloGravaNrInf = 0 THEN ' ModeloGravaNrInf : «Falso» '
                                              WHEN  ModeloGravaNrInf = 1 THEN ' ModeloGravaNrInf : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SalvarCopiaSisdoc IS NULL THEN ' SalvarCopiaSisdoc : «Nulo» '
                                              WHEN  SalvarCopiaSisdoc = 0 THEN ' SalvarCopiaSisdoc : «Falso» '
                                              WHEN  SalvarCopiaSisdoc = 1 THEN ' SalvarCopiaSisdoc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SalvarCopiaProcessos IS NULL THEN ' SalvarCopiaProcessos : «Nulo» '
                                              WHEN  SalvarCopiaProcessos = 0 THEN ' SalvarCopiaProcessos : «Falso» '
                                              WHEN  SalvarCopiaProcessos = 1 THEN ' SalvarCopiaProcessos : «Verdadeiro» '
                                    END 
                         + '| InstrucaoImpressao : «' + RTRIM( ISNULL( CAST (InstrucaoImpressao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoModelo : «' + RTRIM( ISNULL( CAST (DescricaoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaModelo : «' + RTRIM( ISNULL( CAST (SiglaModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaMascaraNumeracao IS NULL THEN ' UsaMascaraNumeracao : «Nulo» '
                                              WHEN  UsaMascaraNumeracao = 0 THEN ' UsaMascaraNumeracao : «Falso» '
                                              WHEN  UsaMascaraNumeracao = 1 THEN ' UsaMascaraNumeracao : «Verdadeiro» '
                                    END 
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoModelo : «' + RTRIM( ISNULL( CAST (PrefixoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoModelo : «' + RTRIM( ISNULL( CAST (SufixoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoNumeracaoAutomatica : «' + RTRIM( ISNULL( CAST (TipoNumeracaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaAltura : «' + RTRIM( ISNULL( CAST (PaginaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaLargura : «' + RTRIM( ISNULL( CAST (PaginaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaOrientacao : «' + RTRIM( ISNULL( CAST (PaginaOrientacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDocumentoPadrao : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelDocumentoPadrao : «' + RTRIM( ISNULL( CAST (IdNivelDocumentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoPadrao : «' + RTRIM( ISNULL( CAST (AssuntoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistrarNoSisDoc IS NULL THEN ' RegistrarNoSisDoc : «Nulo» '
                                              WHEN  RegistrarNoSisDoc = 0 THEN ' RegistrarNoSisDoc : «Falso» '
                                              WHEN  RegistrarNoSisDoc = 1 THEN ' RegistrarNoSisDoc : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumeroAuto : «' + RTRIM( ISNULL( CAST (TamanhoNumeroAuto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirMenuModelo IS NULL THEN ' ExibirMenuModelo : «Nulo» '
                                              WHEN  ExibirMenuModelo = 0 THEN ' ExibirMenuModelo : «Falso» '
                                              WHEN  ExibirMenuModelo = 1 THEN ' ExibirMenuModelo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReiniciaNumeracaoAnual IS NULL THEN ' ReiniciaNumeracaoAnual : «Nulo» '
                                              WHEN  ReiniciaNumeracaoAnual = 0 THEN ' ReiniciaNumeracaoAnual : «Falso» '
                                              WHEN  ReiniciaNumeracaoAnual = 1 THEN ' ReiniciaNumeracaoAnual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitaNumeracaoDuplicada IS NULL THEN ' AceitaNumeracaoDuplicada : «Nulo» '
                                              WHEN  AceitaNumeracaoDuplicada = 0 THEN ' AceitaNumeracaoDuplicada : «Falso» '
                                              WHEN  AceitaNumeracaoDuplicada = 1 THEN ' AceitaNumeracaoDuplicada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Carteirinha IS NULL THEN ' Carteirinha : «Nulo» '
                                              WHEN  Carteirinha = 0 THEN ' Carteirinha : «Falso» '
                                              WHEN  Carteirinha = 1 THEN ' Carteirinha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NumeroCarteiraObrigatorio IS NULL THEN ' NumeroCarteiraObrigatorio : «Nulo» '
                                              WHEN  NumeroCarteiraObrigatorio = 0 THEN ' NumeroCarteiraObrigatorio : «Falso» '
                                              WHEN  NumeroCarteiraObrigatorio = 1 THEN ' NumeroCarteiraObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermiteAlteracaoPreview IS NULL THEN ' PermiteAlteracaoPreview : «Nulo» '
                                              WHEN  PermiteAlteracaoPreview = 0 THEN ' PermiteAlteracaoPreview : «Falso» '
                                              WHEN  PermiteAlteracaoPreview = 1 THEN ' PermiteAlteracaoPreview : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ClarearMarcaDAgua IS NULL THEN ' ClarearMarcaDAgua : «Nulo» '
                                              WHEN  ClarearMarcaDAgua = 0 THEN ' ClarearMarcaDAgua : «Falso» '
                                              WHEN  ClarearMarcaDAgua = 1 THEN ' ClarearMarcaDAgua : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirMarcaDAgua IS NULL THEN ' ExibirMarcaDAgua : «Nulo» '
                                              WHEN  ExibirMarcaDAgua = 0 THEN ' ExibirMarcaDAgua : «Falso» '
                                              WHEN  ExibirMarcaDAgua = 1 THEN ' ExibirMarcaDAgua : «Verdadeiro» '
                                    END 
                         + '| IdDeptoPadrao : «' + RTRIM( ISNULL( CAST (IdDeptoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiaPrevisto : «' + RTRIM( ISNULL( CAST (QtdDiaPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaDeptoPadrao IS NULL THEN ' UsaDeptoPadrao : «Nulo» '
                                              WHEN  UsaDeptoPadrao = 0 THEN ' UsaDeptoPadrao : «Falso» '
                                              WHEN  UsaDeptoPadrao = 1 THEN ' UsaDeptoPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DiaUtil IS NULL THEN ' DiaUtil : «Nulo» '
                                              WHEN  DiaUtil = 0 THEN ' DiaUtil : «Falso» '
                                              WHEN  DiaUtil = 1 THEN ' DiaUtil : «Verdadeiro» '
                                    END 
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CalcDiaUtil IS NULL THEN ' CalcDiaUtil : «Nulo» '
                                              WHEN  CalcDiaUtil = 0 THEN ' CalcDiaUtil : «Falso» '
                                              WHEN  CalcDiaUtil = 1 THEN ' CalcDiaUtil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VerificarDuplicidadeAoCriar IS NULL THEN ' VerificarDuplicidadeAoCriar : «Nulo» '
                                              WHEN  VerificarDuplicidadeAoCriar = 0 THEN ' VerificarDuplicidadeAoCriar : «Falso» '
                                              WHEN  VerificarDuplicidadeAoCriar = 1 THEN ' VerificarDuplicidadeAoCriar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AcordoRenpadrao IS NULL THEN ' AcordoRenpadrao : «Nulo» '
                                              WHEN  AcordoRenpadrao = 0 THEN ' AcordoRenpadrao : «Falso» '
                                              WHEN  AcordoRenpadrao = 1 THEN ' AcordoRenpadrao : «Verdadeiro» '
                                    END 
                         + '| IndVinculoManualSisDoc : «' + RTRIM( ISNULL( CAST (IndVinculoManualSisDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoNumeracao : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoNumeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndVinculaImgSisdoc IS NULL THEN ' IndVinculaImgSisdoc : «Nulo» '
                                              WHEN  IndVinculaImgSisdoc = 0 THEN ' IndVinculaImgSisdoc : «Falso» '
                                              WHEN  IndVinculaImgSisdoc = 1 THEN ' IndVinculaImgSisdoc : «Verdadeiro» '
                                    END 
                         + '| NivelAcesso : «' + RTRIM( ISNULL( CAST (NivelAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndWeb IS NULL THEN ' IndWeb : «Nulo» '
                                              WHEN  IndWeb = 0 THEN ' IndWeb : «Falso» '
                                              WHEN  IndWeb = 1 THEN ' IndWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ModeloGravaNrInf IS NULL THEN ' ModeloGravaNrInf : «Nulo» '
                                              WHEN  ModeloGravaNrInf = 0 THEN ' ModeloGravaNrInf : «Falso» '
                                              WHEN  ModeloGravaNrInf = 1 THEN ' ModeloGravaNrInf : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SalvarCopiaSisdoc IS NULL THEN ' SalvarCopiaSisdoc : «Nulo» '
                                              WHEN  SalvarCopiaSisdoc = 0 THEN ' SalvarCopiaSisdoc : «Falso» '
                                              WHEN  SalvarCopiaSisdoc = 1 THEN ' SalvarCopiaSisdoc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SalvarCopiaProcessos IS NULL THEN ' SalvarCopiaProcessos : «Nulo» '
                                              WHEN  SalvarCopiaProcessos = 0 THEN ' SalvarCopiaProcessos : «Falso» '
                                              WHEN  SalvarCopiaProcessos = 1 THEN ' SalvarCopiaProcessos : «Verdadeiro» '
                                    END 
                         + '| InstrucaoImpressao : «' + RTRIM( ISNULL( CAST (InstrucaoImpressao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoModelo : «' + RTRIM( ISNULL( CAST (DescricaoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaModelo : «' + RTRIM( ISNULL( CAST (SiglaModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaMascaraNumeracao IS NULL THEN ' UsaMascaraNumeracao : «Nulo» '
                                              WHEN  UsaMascaraNumeracao = 0 THEN ' UsaMascaraNumeracao : «Falso» '
                                              WHEN  UsaMascaraNumeracao = 1 THEN ' UsaMascaraNumeracao : «Verdadeiro» '
                                    END 
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoModelo : «' + RTRIM( ISNULL( CAST (PrefixoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoModelo : «' + RTRIM( ISNULL( CAST (SufixoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoNumeracaoAutomatica : «' + RTRIM( ISNULL( CAST (TipoNumeracaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaAltura : «' + RTRIM( ISNULL( CAST (PaginaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaLargura : «' + RTRIM( ISNULL( CAST (PaginaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaOrientacao : «' + RTRIM( ISNULL( CAST (PaginaOrientacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDocumentoPadrao : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelDocumentoPadrao : «' + RTRIM( ISNULL( CAST (IdNivelDocumentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoPadrao : «' + RTRIM( ISNULL( CAST (AssuntoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistrarNoSisDoc IS NULL THEN ' RegistrarNoSisDoc : «Nulo» '
                                              WHEN  RegistrarNoSisDoc = 0 THEN ' RegistrarNoSisDoc : «Falso» '
                                              WHEN  RegistrarNoSisDoc = 1 THEN ' RegistrarNoSisDoc : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumeroAuto : «' + RTRIM( ISNULL( CAST (TamanhoNumeroAuto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirMenuModelo IS NULL THEN ' ExibirMenuModelo : «Nulo» '
                                              WHEN  ExibirMenuModelo = 0 THEN ' ExibirMenuModelo : «Falso» '
                                              WHEN  ExibirMenuModelo = 1 THEN ' ExibirMenuModelo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReiniciaNumeracaoAnual IS NULL THEN ' ReiniciaNumeracaoAnual : «Nulo» '
                                              WHEN  ReiniciaNumeracaoAnual = 0 THEN ' ReiniciaNumeracaoAnual : «Falso» '
                                              WHEN  ReiniciaNumeracaoAnual = 1 THEN ' ReiniciaNumeracaoAnual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitaNumeracaoDuplicada IS NULL THEN ' AceitaNumeracaoDuplicada : «Nulo» '
                                              WHEN  AceitaNumeracaoDuplicada = 0 THEN ' AceitaNumeracaoDuplicada : «Falso» '
                                              WHEN  AceitaNumeracaoDuplicada = 1 THEN ' AceitaNumeracaoDuplicada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Carteirinha IS NULL THEN ' Carteirinha : «Nulo» '
                                              WHEN  Carteirinha = 0 THEN ' Carteirinha : «Falso» '
                                              WHEN  Carteirinha = 1 THEN ' Carteirinha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NumeroCarteiraObrigatorio IS NULL THEN ' NumeroCarteiraObrigatorio : «Nulo» '
                                              WHEN  NumeroCarteiraObrigatorio = 0 THEN ' NumeroCarteiraObrigatorio : «Falso» '
                                              WHEN  NumeroCarteiraObrigatorio = 1 THEN ' NumeroCarteiraObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermiteAlteracaoPreview IS NULL THEN ' PermiteAlteracaoPreview : «Nulo» '
                                              WHEN  PermiteAlteracaoPreview = 0 THEN ' PermiteAlteracaoPreview : «Falso» '
                                              WHEN  PermiteAlteracaoPreview = 1 THEN ' PermiteAlteracaoPreview : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ClarearMarcaDAgua IS NULL THEN ' ClarearMarcaDAgua : «Nulo» '
                                              WHEN  ClarearMarcaDAgua = 0 THEN ' ClarearMarcaDAgua : «Falso» '
                                              WHEN  ClarearMarcaDAgua = 1 THEN ' ClarearMarcaDAgua : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirMarcaDAgua IS NULL THEN ' ExibirMarcaDAgua : «Nulo» '
                                              WHEN  ExibirMarcaDAgua = 0 THEN ' ExibirMarcaDAgua : «Falso» '
                                              WHEN  ExibirMarcaDAgua = 1 THEN ' ExibirMarcaDAgua : «Verdadeiro» '
                                    END 
                         + '| IdDeptoPadrao : «' + RTRIM( ISNULL( CAST (IdDeptoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiaPrevisto : «' + RTRIM( ISNULL( CAST (QtdDiaPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaDeptoPadrao IS NULL THEN ' UsaDeptoPadrao : «Nulo» '
                                              WHEN  UsaDeptoPadrao = 0 THEN ' UsaDeptoPadrao : «Falso» '
                                              WHEN  UsaDeptoPadrao = 1 THEN ' UsaDeptoPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DiaUtil IS NULL THEN ' DiaUtil : «Nulo» '
                                              WHEN  DiaUtil = 0 THEN ' DiaUtil : «Falso» '
                                              WHEN  DiaUtil = 1 THEN ' DiaUtil : «Verdadeiro» '
                                    END 
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CalcDiaUtil IS NULL THEN ' CalcDiaUtil : «Nulo» '
                                              WHEN  CalcDiaUtil = 0 THEN ' CalcDiaUtil : «Falso» '
                                              WHEN  CalcDiaUtil = 1 THEN ' CalcDiaUtil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VerificarDuplicidadeAoCriar IS NULL THEN ' VerificarDuplicidadeAoCriar : «Nulo» '
                                              WHEN  VerificarDuplicidadeAoCriar = 0 THEN ' VerificarDuplicidadeAoCriar : «Falso» '
                                              WHEN  VerificarDuplicidadeAoCriar = 1 THEN ' VerificarDuplicidadeAoCriar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AcordoRenpadrao IS NULL THEN ' AcordoRenpadrao : «Nulo» '
                                              WHEN  AcordoRenpadrao = 0 THEN ' AcordoRenpadrao : «Falso» '
                                              WHEN  AcordoRenpadrao = 1 THEN ' AcordoRenpadrao : «Verdadeiro» '
                                    END 
                         + '| IndVinculoManualSisDoc : «' + RTRIM( ISNULL( CAST (IndVinculoManualSisDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoNumeracao : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoNumeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndVinculaImgSisdoc IS NULL THEN ' IndVinculaImgSisdoc : «Nulo» '
                                              WHEN  IndVinculaImgSisdoc = 0 THEN ' IndVinculaImgSisdoc : «Falso» '
                                              WHEN  IndVinculaImgSisdoc = 1 THEN ' IndVinculaImgSisdoc : «Verdadeiro» '
                                    END 
                         + '| NivelAcesso : «' + RTRIM( ISNULL( CAST (NivelAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndWeb IS NULL THEN ' IndWeb : «Nulo» '
                                              WHEN  IndWeb = 0 THEN ' IndWeb : «Falso» '
                                              WHEN  IndWeb = 1 THEN ' IndWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ModeloGravaNrInf IS NULL THEN ' ModeloGravaNrInf : «Nulo» '
                                              WHEN  ModeloGravaNrInf = 0 THEN ' ModeloGravaNrInf : «Falso» '
                                              WHEN  ModeloGravaNrInf = 1 THEN ' ModeloGravaNrInf : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SalvarCopiaSisdoc IS NULL THEN ' SalvarCopiaSisdoc : «Nulo» '
                                              WHEN  SalvarCopiaSisdoc = 0 THEN ' SalvarCopiaSisdoc : «Falso» '
                                              WHEN  SalvarCopiaSisdoc = 1 THEN ' SalvarCopiaSisdoc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SalvarCopiaProcessos IS NULL THEN ' SalvarCopiaProcessos : «Nulo» '
                                              WHEN  SalvarCopiaProcessos = 0 THEN ' SalvarCopiaProcessos : «Falso» '
                                              WHEN  SalvarCopiaProcessos = 1 THEN ' SalvarCopiaProcessos : «Verdadeiro» '
                                    END 
                         + '| InstrucaoImpressao : «' + RTRIM( ISNULL( CAST (InstrucaoImpressao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdModeloDocumento : «' + RTRIM( ISNULL( CAST (IdModeloDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoModelo : «' + RTRIM( ISNULL( CAST (DescricaoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaModelo : «' + RTRIM( ISNULL( CAST (SiglaModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaMascaraNumeracao IS NULL THEN ' UsaMascaraNumeracao : «Nulo» '
                                              WHEN  UsaMascaraNumeracao = 0 THEN ' UsaMascaraNumeracao : «Falso» '
                                              WHEN  UsaMascaraNumeracao = 1 THEN ' UsaMascaraNumeracao : «Verdadeiro» '
                                    END 
                         + '| IdFuncao : «' + RTRIM( ISNULL( CAST (IdFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoModelo : «' + RTRIM( ISNULL( CAST (PrefixoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoModelo : «' + RTRIM( ISNULL( CAST (SufixoModelo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoNumeracaoAutomatica : «' + RTRIM( ISNULL( CAST (TipoNumeracaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaAltura : «' + RTRIM( ISNULL( CAST (PaginaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaLargura : «' + RTRIM( ISNULL( CAST (PaginaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PaginaOrientacao : «' + RTRIM( ISNULL( CAST (PaginaOrientacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemInferior : «' + RTRIM( ISNULL( CAST (MargemInferior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemEsquerda : «' + RTRIM( ISNULL( CAST (MargemEsquerda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemDireita : «' + RTRIM( ISNULL( CAST (MargemDireita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDocumentoPadrao : «' + RTRIM( ISNULL( CAST (IdSituacaoDocumentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNivelDocumentoPadrao : «' + RTRIM( ISNULL( CAST (IdNivelDocumentoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AssuntoPadrao : «' + RTRIM( ISNULL( CAST (AssuntoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistrarNoSisDoc IS NULL THEN ' RegistrarNoSisDoc : «Nulo» '
                                              WHEN  RegistrarNoSisDoc = 0 THEN ' RegistrarNoSisDoc : «Falso» '
                                              WHEN  RegistrarNoSisDoc = 1 THEN ' RegistrarNoSisDoc : «Verdadeiro» '
                                    END 
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoNumeroAuto : «' + RTRIM( ISNULL( CAST (TamanhoNumeroAuto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirMenuModelo IS NULL THEN ' ExibirMenuModelo : «Nulo» '
                                              WHEN  ExibirMenuModelo = 0 THEN ' ExibirMenuModelo : «Falso» '
                                              WHEN  ExibirMenuModelo = 1 THEN ' ExibirMenuModelo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ReiniciaNumeracaoAnual IS NULL THEN ' ReiniciaNumeracaoAnual : «Nulo» '
                                              WHEN  ReiniciaNumeracaoAnual = 0 THEN ' ReiniciaNumeracaoAnual : «Falso» '
                                              WHEN  ReiniciaNumeracaoAnual = 1 THEN ' ReiniciaNumeracaoAnual : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AceitaNumeracaoDuplicada IS NULL THEN ' AceitaNumeracaoDuplicada : «Nulo» '
                                              WHEN  AceitaNumeracaoDuplicada = 0 THEN ' AceitaNumeracaoDuplicada : «Falso» '
                                              WHEN  AceitaNumeracaoDuplicada = 1 THEN ' AceitaNumeracaoDuplicada : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Carteirinha IS NULL THEN ' Carteirinha : «Nulo» '
                                              WHEN  Carteirinha = 0 THEN ' Carteirinha : «Falso» '
                                              WHEN  Carteirinha = 1 THEN ' Carteirinha : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  NumeroCarteiraObrigatorio IS NULL THEN ' NumeroCarteiraObrigatorio : «Nulo» '
                                              WHEN  NumeroCarteiraObrigatorio = 0 THEN ' NumeroCarteiraObrigatorio : «Falso» '
                                              WHEN  NumeroCarteiraObrigatorio = 1 THEN ' NumeroCarteiraObrigatorio : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  PermiteAlteracaoPreview IS NULL THEN ' PermiteAlteracaoPreview : «Nulo» '
                                              WHEN  PermiteAlteracaoPreview = 0 THEN ' PermiteAlteracaoPreview : «Falso» '
                                              WHEN  PermiteAlteracaoPreview = 1 THEN ' PermiteAlteracaoPreview : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ClarearMarcaDAgua IS NULL THEN ' ClarearMarcaDAgua : «Nulo» '
                                              WHEN  ClarearMarcaDAgua = 0 THEN ' ClarearMarcaDAgua : «Falso» '
                                              WHEN  ClarearMarcaDAgua = 1 THEN ' ClarearMarcaDAgua : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ExibirMarcaDAgua IS NULL THEN ' ExibirMarcaDAgua : «Nulo» '
                                              WHEN  ExibirMarcaDAgua = 0 THEN ' ExibirMarcaDAgua : «Falso» '
                                              WHEN  ExibirMarcaDAgua = 1 THEN ' ExibirMarcaDAgua : «Verdadeiro» '
                                    END 
                         + '| IdDeptoPadrao : «' + RTRIM( ISNULL( CAST (IdDeptoPadrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDiaPrevisto : «' + RTRIM( ISNULL( CAST (QtdDiaPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  UsaDeptoPadrao IS NULL THEN ' UsaDeptoPadrao : «Nulo» '
                                              WHEN  UsaDeptoPadrao = 0 THEN ' UsaDeptoPadrao : «Falso» '
                                              WHEN  UsaDeptoPadrao = 1 THEN ' UsaDeptoPadrao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  DiaUtil IS NULL THEN ' DiaUtil : «Nulo» '
                                              WHEN  DiaUtil = 0 THEN ' DiaUtil : «Falso» '
                                              WHEN  DiaUtil = 1 THEN ' DiaUtil : «Verdadeiro» '
                                    END 
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CalcDiaUtil IS NULL THEN ' CalcDiaUtil : «Nulo» '
                                              WHEN  CalcDiaUtil = 0 THEN ' CalcDiaUtil : «Falso» '
                                              WHEN  CalcDiaUtil = 1 THEN ' CalcDiaUtil : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  VerificarDuplicidadeAoCriar IS NULL THEN ' VerificarDuplicidadeAoCriar : «Nulo» '
                                              WHEN  VerificarDuplicidadeAoCriar = 0 THEN ' VerificarDuplicidadeAoCriar : «Falso» '
                                              WHEN  VerificarDuplicidadeAoCriar = 1 THEN ' VerificarDuplicidadeAoCriar : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AcordoRenpadrao IS NULL THEN ' AcordoRenpadrao : «Nulo» '
                                              WHEN  AcordoRenpadrao = 0 THEN ' AcordoRenpadrao : «Falso» '
                                              WHEN  AcordoRenpadrao = 1 THEN ' AcordoRenpadrao : «Verdadeiro» '
                                    END 
                         + '| IndVinculoManualSisDoc : «' + RTRIM( ISNULL( CAST (IndVinculoManualSisDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoNumeracao : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoNumeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndVinculaImgSisdoc IS NULL THEN ' IndVinculaImgSisdoc : «Nulo» '
                                              WHEN  IndVinculaImgSisdoc = 0 THEN ' IndVinculaImgSisdoc : «Falso» '
                                              WHEN  IndVinculaImgSisdoc = 1 THEN ' IndVinculaImgSisdoc : «Verdadeiro» '
                                    END 
                         + '| NivelAcesso : «' + RTRIM( ISNULL( CAST (NivelAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  IndWeb IS NULL THEN ' IndWeb : «Nulo» '
                                              WHEN  IndWeb = 0 THEN ' IndWeb : «Falso» '
                                              WHEN  IndWeb = 1 THEN ' IndWeb : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ModeloGravaNrInf IS NULL THEN ' ModeloGravaNrInf : «Nulo» '
                                              WHEN  ModeloGravaNrInf = 0 THEN ' ModeloGravaNrInf : «Falso» '
                                              WHEN  ModeloGravaNrInf = 1 THEN ' ModeloGravaNrInf : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SalvarCopiaSisdoc IS NULL THEN ' SalvarCopiaSisdoc : «Nulo» '
                                              WHEN  SalvarCopiaSisdoc = 0 THEN ' SalvarCopiaSisdoc : «Falso» '
                                              WHEN  SalvarCopiaSisdoc = 1 THEN ' SalvarCopiaSisdoc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  SalvarCopiaProcessos IS NULL THEN ' SalvarCopiaProcessos : «Nulo» '
                                              WHEN  SalvarCopiaProcessos = 0 THEN ' SalvarCopiaProcessos : «Falso» '
                                              WHEN  SalvarCopiaProcessos = 1 THEN ' SalvarCopiaProcessos : «Verdadeiro» '
                                    END 
                         + '| InstrucaoImpressao : «' + RTRIM( ISNULL( CAST (InstrucaoImpressao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
