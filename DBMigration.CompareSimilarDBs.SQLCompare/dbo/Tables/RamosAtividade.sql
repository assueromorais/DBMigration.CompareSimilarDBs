CREATE TABLE [dbo].[RamosAtividade] (
    [IdRamoAtividade]    INT          IDENTITY (1, 1) NOT NULL,
    [RamoAtividade]      VARCHAR (50) NOT NULL,
    [Desativado]         BIT          CONSTRAINT [DF_RamosAtividadeDesativado] DEFAULT ((0)) NULL,
    [RamoAtividadeAtivo] BIT          CONSTRAINT [DF__RamosAtiv__RamoA__0DBA2B72] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_RamosAtividade] PRIMARY KEY CLUSTERED ([IdRamoAtividade] ASC)
);

