

CREATE PROCEDURE [dbo].[sp_SincronizaOutrosDadosProfissionais] 
@DbOrigem varchar(50) = 'Implanta_CoreconSP'
AS

Delete From ControleSincronizacao
Where IdSindecon Not In (Select IdProfissional From Profissionais)

/* Alimenta tabela EspecialidadesProfissional */
Exec('
Insert Into EspecialidadesProfissional (IdProfissional, IdEspecialidade)
Select CS.IdSindecon, ES.IdEspecialidade From ' + @DbOrigem + '.dbo.EspecialidadesProfissional EP
Left Join ControleSincronizacao CS On CS.IdCorecon = EP.IdProfissional
Left Join ' + @DbOrigem + '.dbo.Especialidades EC On EC.IdEspecialidade = EP.IdEspecialidade
Left Join Especialidades ES On ES.NomeEspecialidade = EC.NomeEspecialidade
Left Join EspecialidadesProfissional EPS On EPS.IdProfissional = CS.IdSindecon And EPS.IdEspecialidade = ES.IdEspecialidade
Where EPS.IdEspecialidade Is Null
And CS.IdSindecon Is Not Null
')

/* Atualiza tabela CursosEventosRealizado */
Exec('
Update CursosEventosRealizado Set
IdPessoa = PS.IdPessoa, 
IdSituacaoCurso = SCS.IdSituacaoCurso, 
IdEspecialidade = ES.IdEspecialidade, 
TipoDocumento = CEC.TipoDocumento, 
DataExpedicaoDocumento = CEC.DataExpedicaoDocumento, 
Duracao = CEC.Duracao, 
UnidadeDuracao = CEC.UnidadeDuracao, 
PeriodoRealizacao = CEC.PeriodoRealizacao, 
DataConclusao = CEC.DataConclusao, 
DataColacaoGrau = CEC.DataColacaoGrau, 
Observacao = CEC.Observacao, 
E_CursoRegistro = CEC.E_CursoRegistro, 
E_Curso = CEC.E_Curso, 
AtualizacaoWeb = CEC.AtualizacaoWeb
From ' + @DbOrigem + '.dbo.CursosEventosRealizado CEC
Inner Join ControleSincronizacao CS On CS.IdCorecon = CEC.IdProfissional
Inner Join CursosEventos CES On CES.IdCursoEvento = CEC.IdCursoEvento
Inner Join CursosEventosRealizado CERS On CERS.IdProfissional = CS.IdSindecon And CERS.IdCursoEvento = CES.IdCursoEvento
Left Join ' + @DbOrigem + '.dbo.Pessoas PC On PC.IdPessoa = CEC.IdPessoa
Left Join Pessoas PS On PS.Nome = PC.Nome
Left Join ' + @DbOrigem + '.dbo.SituacoesCurso SCC On SCC.IdSituacaoCurso = CEC.IdSituacaoCurso
Left Join SituacoesCurso SCS On SCS.SituacaoCurso = SCC.SituacaoCurso
Left Join ' + @DbOrigem + '.dbo.Especialidades EC On EC.IdEspecialidade = CEC.IdEspecialidade
Left Join Especialidades ES On ES.NomeEspecialidade = EC.NomeEspecialidade
')

/* Alimenta tabela CursosEventosRealizado */
Exec('
Insert Into CursosEventosRealizado (IdProfissional, IdCursoEvento, IdPessoa, IdSituacaoCurso, IdEspecialidade, TipoDocumento, DataExpedicaoDocumento, Duracao, UnidadeDuracao, PeriodoRealizacao, DataConclusao, DataColacaoGrau, Observacao, E_CursoRegistro, E_Curso, AtualizacaoWeb)
Select 
CS.IdSindecon, 
CES.IdCursoEvento, 
PS.IdPessoa, 
SCS.IdSituacaoCurso, 
ES.IdEspecialidade, 
CEC.TipoDocumento, 
CEC.DataExpedicaoDocumento, 
CEC.Duracao, 
CEC.UnidadeDuracao, 
CEC.PeriodoRealizacao, 
CEC.DataConclusao, 
CEC.DataColacaoGrau, 
CEC.Observacao, 
CEC.E_CursoRegistro, 
CEC.E_Curso, 
CEC.AtualizacaoWeb
From ' + @DbOrigem + '.dbo.CursosEventosRealizado CEC
Left Join ControleSincronizacao CS On CS.IdCorecon = CEC.IdProfissional
Left Join CursosEventos CES On CES.IdCursoEvento = CEC.IdCursoEvento
Left Join CursosEventosRealizado CERS On CERS.IdProfissional = CS.IdSindecon And CERS.IdCursoEvento = CES.IdCursoEvento
Left Join ' + @DbOrigem + '.dbo.Pessoas PC On PC.IdPessoa = CEC.IdPessoa
Left Join Pessoas PS On PS.Nome = PC.Nome
Left Join ' + @DbOrigem + '.dbo.SituacoesCurso SCC On SCC.IdSituacaoCurso = CEC.IdSituacaoCurso
Left Join SituacoesCurso SCS On SCS.SituacaoCurso = SCC.SituacaoCurso
Left Join ' + @DbOrigem + '.dbo.Especialidades EC On EC.IdEspecialidade = CEC.IdEspecialidade
Left Join Especialidades ES On ES.NomeEspecialidade = EC.NomeEspecialidade
Where CERS.IdCursoEventoRealizado Is Null
And IdSindecon Is Not Null
')

/* Atualiza tabela ComplementosProfissional */
Exec('
Update ComplementosProfissional Set
IdCategoriaProfissional = CPS.IdCategoriaProf,
IdTipoInscricao = TIS.IdTipoInscricao,
IdSituacaoComplemento = SS.IdSituacaoPFPJ,
RegistroConselho = PC.RegistroConselhoAtual,
DataInscricaoConselho = PC.DataInscricaoConselho
From ComplementosProfissional CPRS
Inner Join Profissionais PS On PS.IdProfissional = CPRS.IdProfissional
Inner Join ControleSincronizacao CS On CS.IdSindecon = PS.IdProfissional
Inner Join ' + @DbOrigem + '.dbo.Profissionais PC On PC.IdProfissional = CS.IdCorecon
Left Join ' + @DbOrigem + '.dbo.SituacoesPFPJ SC On PC.SituacaoAtual = SC.NomeSituacao
Left Join ' + @DbOrigem + '.dbo.TiposInscricao TIC On TIC.IdTipoInscricao = PC.IdTipoInscricao
Left Join TiposInscricao TIS On TIS.TipoInscricao = TIC.TipoInscricao
Left Join SituacoesPFPJ SS On SS.NomeSituacao = SC.NomeSituacao
Inner Join ' + @DbOrigem + '.dbo.Pessoas PEC On PEC.IdPessoa = PC.IdSubRegiao
Inner Join Pessoas PES On PES.Nome = PEC.Nome
Inner Join ' + @DbOrigem + '.dbo.Pessoas PEC2 On PEC2.IdPessoa = PC.IdSubRegiao
Inner Join Pessoas PES2 On PES2.Nome = PEC2.Nome
Left Join CategoriasProf CPS On CPS.NomeCategoriaProf = PC.CategoriaAtual
')

/* Alimenta tabela ComplementosProfissional */
Exec('
Insert Into ComplementosProfissional (IdProfissional, IdUnidadeConselho, IdCategoriaProfissional, IdTipoInscricao, IdSituacaoComplemento, RegistroConselho, DataInscricaoConselho)
Select 
CS.IdSindecon, 
PES.IdPessoa, 
CPS.IdCategoriaProf,
TIS.IdTipoInscricao,
SS.IdSituacaoPFPJ,
PFC.RegistroConselhoAtual,
PFC.DataInscricaoConselho
From ' + @DbOrigem + '.dbo.Profissionais PFC
Left Join ControleSincronizacao CS On CS.IdCorecon = PFC.IdProfissional
Left Join ' + @DbOrigem + '.dbo.Pessoas PEC On PEC.IdPessoa = PFC.IdSubRegiao
Left Join Pessoas PES On PES.Nome = PEC.Nome
Left Join CategoriasProf CPS On CPS.NomeCategoriaProf = PFC.CategoriaAtual
Left Join ' + @DbOrigem + '.dbo.TiposInscricao TIC On TIC.IdTipoInscricao = PFC.IdTipoInscricao
Left Join TiposInscricao TIS On TIS.TipoInscricao = TIC.TipoInscricao
Left Join SituacoesPFPJ SS On SS.NomeSituacao = PFC.SituacaoAtual
Left Join ComplementosProfissional CPFS On CPFS.IdProfissional = CS.IdSindecon And CPFS.IdUnidadeConselho = PES.IdPessoa
Where CPFS.IdComplementoProfissional Is Null
And CS.IdSindecon Is Not Null
And PES.IdPessoa Is Not Null
')

/* Atualiza tabela Profissionais_SituacoesPF */
Exec('
Update Profissionais_SituacoesPF Set
DataInicioSituacao = PROFSC.DataInicioSituacao,
DataFimSituacao = PROFSC.DataFimSituacao,
DataValidade = PROFSC.DataValidade
From ' + @DbOrigem + '.dbo.Profissionais_SituacoesPF PROFSC
Inner Join ' + @DbOrigem + '.dbo.SituacoesPFPJ STC On STC.IdSituacaoPFPJ = PROFSC.IdSituacaoPFPJ
Inner Join SituacoesPFPJ STS On STS.NomeSituacao = STC.NomeSituacao
Inner Join ControleSincronizacao CSS On CSS.IdCorecon = PROFSC.IdProfissional
Inner Join Profissionais_SituacoesPF PROFSS On PROFSS.IdProfissional = CSS.IdSindecon And PROFSS.IdSituacaoPFPJ = STS.IdSituacaoPFPJ
')

/* Alimenta tabela Profissionais_SituacoesPF somente para Situação = FALECIDO */
Exec('
Insert Into Profissionais_SituacoesPF (IdProfissional, IdSituacaoPFPJ, DataInicioSituacao, DataFimSituacao, DataValidade)
Select 
CSS.IdSindecon,
STS.IdSituacaoPFPJ,
PROFSC.DataInicioSituacao,
PROFSC.DataFimSituacao,
PROFSC.DataValidade
From ' + @DbOrigem + '.dbo.Profissionais_SituacoesPF PROFSC
Left Join ' + @DbOrigem + '.dbo.SituacoesPFPJ STC On STC.IdSituacaoPFPJ = PROFSC.IdSituacaoPFPJ
Left Join SituacoesPFPJ STS On STS.NomeSituacao = STC.NomeSituacao
Left Join ControleSincronizacao CSS On CSS.IdCorecon = PROFSC.IdProfissional
Left Join Profissionais_SituacoesPF PROFSS On PROFSS.IdProfissional = CSS.IdSindecon And PROFSS.IdSituacaoPFPJ = STS.IdSituacaoPFPJ
Where PROFSS.IdProfissionalSituacaoPF Is Null
And CSS.IdSindecon Is Not Null
And STS.IdSituacaoPFPJ Is Not Null
And STS.NomeSituacao = ''FALECIDO''
')




