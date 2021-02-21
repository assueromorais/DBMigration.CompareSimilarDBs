﻿


























CREATE Procedure dbo.Sp_CarregaConfigSiscafWEB 
AS
SET NOCOUNT ON

  SELECT TOP 1 [IdConselhoProprietario], [PathLogo], [FundoCor], [FundoImg], [LinkVoltar], [TamLetra], [TipoLetra], [CorLetra], [EstiloCSS], Pessoas.Nome, Pessoas.Sigla, [TpControleAcessoProfWeb], [CompararCPF_CNPJ], [CompararNomeMae], [CompararRegistro], [CompararDataNac], [CompararCampo5], [CompararCampo6], [FuncoesDisponiveisrPF], [FuncoesDisponiveisPJ], [IndMostraProf], [CompletaZero], [FormaTrocaSenha] FROM [ParametrosSiscafWeb]
  INNER JOIN Pessoas ON Pessoas.IdPessoa = ParametrosSiscafWeb.IdConselhoProprietario
/*  WHERE IdConselhoProprietario = 100*/
SET NOCOUNT OFF





















































