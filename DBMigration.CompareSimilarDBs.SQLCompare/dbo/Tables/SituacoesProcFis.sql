CREATE TABLE [dbo].[SituacoesProcFis] (
    [IdSituacaoProcFis]     INT          IDENTITY (1, 1) NOT NULL,
    [SituacaoProcFis]       VARCHAR (40) NOT NULL,
    [Ind_Mostrar_Tela_Cad]  BIT          NULL,
    [IndApresentacaoTela]   BIT          NULL,
    [EncerraProcesso]       BIT          NULL,
    [Desativado]            BIT          CONSTRAINT [DF_SituacoesProcFisDesativado] DEFAULT ((0)) NULL,
    [Arquiva]               BIT          DEFAULT ((0)) NOT NULL,
    [IndicaProcessoExtinto] BIT          NULL,
    CONSTRAINT [PK_situacaooProcesso] PRIMARY KEY CLUSTERED ([IdSituacaoProcFis] ASC)
);

