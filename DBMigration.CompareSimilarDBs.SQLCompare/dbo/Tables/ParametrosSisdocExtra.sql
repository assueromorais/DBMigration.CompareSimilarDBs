CREATE TABLE [dbo].[ParametrosSisdocExtra] (
    [IdParametro] VARCHAR (50)  NOT NULL,
    [Valor]       VARCHAR (100) NULL,
    CONSTRAINT [PK_ParametrosSisdocExtra] PRIMARY KEY CLUSTERED ([IdParametro] ASC)
);

