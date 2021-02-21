/* OC 107595
* [vw_SispadConsultaSolicitacaoCFM] - IdPessoaAutorizador, Incluído. 
*/
CREATE VIEW [dbo].[vw_SispadConsultaSolicitacaoCFM]
AS
SELECT     PSV.IdPessoaSolicitacaoViagem, S.IdSolicitacaoViagem, S.NumSolicitacaoViagem, S.DataSolicitacaoViagem, S.IdPessoaSolicitante,
						  (SELECT     P1.Nome
							FROM          dbo.Pessoas AS P1 INNER JOIN
												   dbo.PessoasSispad AS PS1 ON PS1.IdPessoa = P1.IdPessoa
							WHERE      (PS1.IdPessoaSispad = S.IdPessoaSolicitante)) AS NomeSolicitante, PSV.IdPessoaPassageiro,
						  (SELECT     Nome
							FROM          dbo.Pessoas AS P2
							WHERE      (IdPessoa = PS.IdPessoa)) AS NomePassageiro, S.IdEvento, S.NomeEvento, PSV.IdSituacaoSolicitacao, SS.SituacaoSolicitacao, PSV.IdCentroCusto, 
					  C.NomeCentroCusto, PSV.IdTipoPessoa, TP.TipoPessoa, CA.Cargo, S.DescricaoEvento, S.DataHoraInicioEvento, S.DataHoraFimEvento, S.UFEvento, 
					  CD.NomeCidade AS CidadeEvento
FROM         dbo.PessoasSolicitacoesViagem AS PSV INNER JOIN
					  dbo.SolicitacoesViagem AS S ON S.IdSolicitacaoViagem = PSV.IdSolicitacaoViagem INNER JOIN
					  dbo.PessoasSispad AS PS ON PS.IdPessoaSispad = PSV.IdPessoaPassageiro INNER JOIN
					  dbo.SituacoesSolicitacao AS SS ON PSV.IdSituacaoSolicitacao = SS.IdSituacaoSolicitacao LEFT OUTER JOIN
					  dbo.CentroCustos AS C ON C.IdCentroCusto = PSV.IdCentroCusto LEFT OUTER JOIN
					  dbo.TiposPessoa AS TP ON TP.IdTipoPessoa = PSV.IdTipoPessoa LEFT OUTER JOIN
					  dbo.Cargos AS CA ON CA.IdCargo = PS.IdCargo LEFT OUTER JOIN
					  dbo.Cidades AS CD ON CD.IdCidade = S.IdCidadeEvento
