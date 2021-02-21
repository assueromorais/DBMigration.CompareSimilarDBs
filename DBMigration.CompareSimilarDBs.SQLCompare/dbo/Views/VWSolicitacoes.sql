﻿/*
Criação das views do Sispad
André - 17/09/2009
*/

CREATE VIEW [dbo].[VWSolicitacoes]
AS
SELECT
SV.IDEVENTO
, SV.NUMSOLICITACAOVIAGEM
, P.NOME
, 0 QTDREGISTROS
, (SELECT SUM(ISNULL(VALORDESPESA, 0))
   FROM DESPESASREEMBOLSOSPESSOASSOLICITACOESVIAGEM DRPSV
   WHERE DRPSV.IDPESSOASOLICITACAOVIAGEM = PSV.IDPESSOASOLICITACAOVIAGEM) VALORDESPESA
, (SELECT SUM(ISNULL(VALORPAGO, 0)) + SUM(ISNULL(VALORAPAGAR, 0))
   FROM DESPESASREEMBOLSOSPESSOASSOLICITACOESVIAGEM DRPSV
   WHERE DRPSV.IDPESSOASOLICITACAOVIAGEM = PSV.IDPESSOASOLICITACAOVIAGEM) VALORPAGO
, SS.SITUACAOSOLICITACAO
, ISNULL((SELECT SUM(ISNULL(VALORDESPESA, 0))
   FROM DESPESASREEMBOLSOSPESSOASSOLICITACOESVIAGEM DRPSV
   INNER JOIN PESSOASSOLICITACOESVIAGEM PSV2 ON PSV2.IDPESSOASOLICITACAOVIAGEM = DRPSV.IDPESSOASOLICITACAOVIAGEM
   INNER JOIN SOLICITACOESVIAGEM SV2 ON SV2.IDSOLICITACAOVIAGEM = PSV2.IDSOLICITACAOVIAGEM
   WHERE SV2.IDEVENTO = SV.IDEVENTO), 0) TOTALDESPESA
FROM SOLICITACOESVIAGEM SV
INNER JOIN PESSOASSOLICITACOESVIAGEM PSV ON PSV.IDSOLICITACAOVIAGEM = SV.IDSOLICITACAOVIAGEM
INNER JOIN PESSOASSISPAD PS ON PS.IDPESSOASISPAD = PSV.IDPESSOAPASSAGEIRO
INNER JOIN PESSOAS P ON P.IDPESSOA = PS.IDPESSOA
LEFT JOIN SITUACOESSOLICITACAO SS ON SS.IDSITUACAOSOLICITACAO = SV.IDSITUACAOSOLICITACAOATUAL