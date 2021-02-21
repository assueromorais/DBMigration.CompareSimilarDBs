﻿CREATE TABLE [dbo].[RelatorioDevedores] (
    [IdRelatorio]           INT           NOT NULL,
    [IdProfissional]        INT           NOT NULL,
    [SubRegiao]             VARCHAR (120) NULL,
    [RegistroConselhoAtual] VARCHAR (20)  NULL,
    [Nome]                  VARCHAR (100) NULL,
    [Classe]                VARCHAR (1)   NULL,
    [SituacaoAtual]         VARCHAR (100) NULL,
    [1981]                  MONEY         NULL,
    [1990]                  MONEY         NULL,
    [1991]                  MONEY         NULL,
    [1992]                  MONEY         NULL,
    [1993]                  MONEY         NULL,
    [1994]                  MONEY         NULL,
    [1995]                  MONEY         NULL,
    [1996]                  MONEY         NULL,
    [1997]                  MONEY         NULL,
    [1998]                  MONEY         NULL,
    [1999]                  MONEY         NULL,
    [2000]                  MONEY         NULL,
    [2001]                  MONEY         NULL,
    [2002]                  MONEY         NULL,
    [2003]                  MONEY         NULL,
    [2004]                  MONEY         NULL,
    [2005]                  MONEY         NULL,
    [2006]                  MONEY         NULL,
    [2007]                  MONEY         NULL,
    [2008]                  MONEY         NULL,
    [2009]                  MONEY         NULL,
    [2010]                  MONEY         NULL,
    [2011]                  MONEY         NULL,
    [2012]                  MONEY         NULL,
    [2013]                  MONEY         NULL,
    [2014]                  MONEY         NULL,
    [2015]                  MONEY         NULL,
    [2016]                  MONEY         NULL,
    [2017]                  MONEY         NULL,
    [2018]                  MONEY         NULL,
    [2019]                  MONEY         NULL,
    [2020]                  MONEY         NULL,
    CONSTRAINT [FK_RelatorioDevedores_RelatorioDevedoresGeracao] FOREIGN KEY ([IdRelatorio]) REFERENCES [dbo].[RelatorioDevedoresGeracao] ([IdRelatorio])
);
