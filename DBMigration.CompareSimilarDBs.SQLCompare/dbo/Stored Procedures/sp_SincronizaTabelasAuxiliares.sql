

CREATE PROCEDURE [dbo].[sp_SincronizaTabelasAuxiliares] 
@DbOrigem varchar(50) = 'Implanta_CoreconSP'
AS

/* Sincroniza a tabela Pessoas - IdUnidadeConselho da tabela de Profissionais*/
Exec('
Insert Into Pessoas (IdContaProvisao, IdFormaCredito, Nome, CNPJCPF, NomeFantasia, Endereco, NomeBairro, NomeCidade, SiglaUF, CEP, DataUltimaAtualizacaoEnd, Telefone, Email, Banco, Agencia, Conta, UsaBanco, Habilitado, Ativo, Atualizado, E_ConselhoProfissao, InscricaoEstadual, InscricaoMunicipal, DataRegistro, DataFundacao, TipoConselho, NaturezaJuridica, CapitalSocial, Codigo, Sigla, ObjetoSocial, Observacoes, E_PessoaJuridica, E_Fiscal, Assina, TipoConta, E_InstituicaoEnsino)
Select 
' + @DbOrigem + '.dbo.Pessoas.IdContaProvisao,
' + @DbOrigem + '.dbo.Pessoas.IdFormaCredito,
' + @DbOrigem + '.dbo.Pessoas.Nome,
' + @DbOrigem + '.dbo.Pessoas.CNPJCPF,
' + @DbOrigem + '.dbo.Pessoas.NomeFantasia,
' + @DbOrigem + '.dbo.Pessoas.Endereco,
' + @DbOrigem + '.dbo.Pessoas.NomeBairro,
' + @DbOrigem + '.dbo.Pessoas.NomeCidade,
' + @DbOrigem + '.dbo.Pessoas.SiglaUF,
' + @DbOrigem + '.dbo.Pessoas.CEP,
' + @DbOrigem + '.dbo.Pessoas.DataUltimaAtualizacaoEnd,
' + @DbOrigem + '.dbo.Pessoas.Telefone,
' + @DbOrigem + '.dbo.Pessoas.Email,
' + @DbOrigem + '.dbo.Pessoas.Banco,
' + @DbOrigem + '.dbo.Pessoas.Agencia,
' + @DbOrigem + '.dbo.Pessoas.Conta,
' + @DbOrigem + '.dbo.Pessoas.UsaBanco,
' + @DbOrigem + '.dbo.Pessoas.Habilitado,
' + @DbOrigem + '.dbo.Pessoas.Ativo,
' + @DbOrigem + '.dbo.Pessoas.Atualizado,
' + @DbOrigem + '.dbo.Pessoas.E_ConselhoProfissao,
' + @DbOrigem + '.dbo.Pessoas.InscricaoEstadual,
' + @DbOrigem + '.dbo.Pessoas.InscricaoMunicipal,
' + @DbOrigem + '.dbo.Pessoas.DataRegistro,
' + @DbOrigem + '.dbo.Pessoas.DataFundacao,
' + @DbOrigem + '.dbo.Pessoas.TipoConselho,
' + @DbOrigem + '.dbo.Pessoas.NaturezaJuridica,
' + @DbOrigem + '.dbo.Pessoas.CapitalSocial,
' + @DbOrigem + '.dbo.Pessoas.Codigo,
' + @DbOrigem + '.dbo.Pessoas.Sigla,
' + @DbOrigem + '.dbo.Pessoas.ObjetoSocial,
' + @DbOrigem + '.dbo.Pessoas.Observacoes,
' + @DbOrigem + '.dbo.Pessoas.E_PessoaJuridica,
' + @DbOrigem + '.dbo.Pessoas.E_Fiscal,
' + @DbOrigem + '.dbo.Pessoas.Assina,
' + @DbOrigem + '.dbo.Pessoas.TipoConta,
' + @DbOrigem + '.dbo.Pessoas.E_InstituicaoEnsino
From ' + @DbOrigem + '.dbo.Pessoas
Left Join Pessoas On Pessoas.Nome = ' + @DbOrigem + '.dbo.Pessoas.Nome
Where ' + @DbOrigem + '.dbo.Pessoas.IdPessoa In (Select Distinct IdUnidadeConselho From ' + @DbOrigem + '.dbo.Profissionais)
And Pessoas.Nome Is Null
')

/* Sincroniza a tabela Pessoas - IdSubRegiao da tabela de Profissionais*/
Exec('
Insert Into Pessoas (IdContaProvisao, IdFormaCredito, Nome, CNPJCPF, NomeFantasia, Endereco, NomeBairro, NomeCidade, SiglaUF, CEP, DataUltimaAtualizacaoEnd, Telefone, Email, Banco, Agencia, Conta, UsaBanco, Habilitado, Ativo, Atualizado, E_ConselhoProfissao, InscricaoEstadual, InscricaoMunicipal, DataRegistro, DataFundacao, TipoConselho, NaturezaJuridica, CapitalSocial, Codigo, Sigla, ObjetoSocial, Observacoes, E_PessoaJuridica, E_Fiscal, Assina, TipoConta, E_InstituicaoEnsino)
Select 
' + @DbOrigem + '.dbo.Pessoas.IdContaProvisao,
' + @DbOrigem + '.dbo.Pessoas.IdFormaCredito,
' + @DbOrigem + '.dbo.Pessoas.Nome,
' + @DbOrigem + '.dbo.Pessoas.CNPJCPF,
' + @DbOrigem + '.dbo.Pessoas.NomeFantasia,
' + @DbOrigem + '.dbo.Pessoas.Endereco,
' + @DbOrigem + '.dbo.Pessoas.NomeBairro,
' + @DbOrigem + '.dbo.Pessoas.NomeCidade,
' + @DbOrigem + '.dbo.Pessoas.SiglaUF,
' + @DbOrigem + '.dbo.Pessoas.CEP,
' + @DbOrigem + '.dbo.Pessoas.DataUltimaAtualizacaoEnd,
' + @DbOrigem + '.dbo.Pessoas.Telefone,
' + @DbOrigem + '.dbo.Pessoas.Email,
' + @DbOrigem + '.dbo.Pessoas.Banco,
' + @DbOrigem + '.dbo.Pessoas.Agencia,
' + @DbOrigem + '.dbo.Pessoas.Conta,
' + @DbOrigem + '.dbo.Pessoas.UsaBanco,
' + @DbOrigem + '.dbo.Pessoas.Habilitado,
' + @DbOrigem + '.dbo.Pessoas.Ativo,
' + @DbOrigem + '.dbo.Pessoas.Atualizado,
' + @DbOrigem + '.dbo.Pessoas.E_ConselhoProfissao,
' + @DbOrigem + '.dbo.Pessoas.InscricaoEstadual,
' + @DbOrigem + '.dbo.Pessoas.InscricaoMunicipal,
' + @DbOrigem + '.dbo.Pessoas.DataRegistro,
' + @DbOrigem + '.dbo.Pessoas.DataFundacao,
' + @DbOrigem + '.dbo.Pessoas.TipoConselho,
' + @DbOrigem + '.dbo.Pessoas.NaturezaJuridica,
' + @DbOrigem + '.dbo.Pessoas.CapitalSocial,
' + @DbOrigem + '.dbo.Pessoas.Codigo,
' + @DbOrigem + '.dbo.Pessoas.Sigla,
' + @DbOrigem + '.dbo.Pessoas.ObjetoSocial,
' + @DbOrigem + '.dbo.Pessoas.Observacoes,
' + @DbOrigem + '.dbo.Pessoas.E_PessoaJuridica,
' + @DbOrigem + '.dbo.Pessoas.E_Fiscal,
' + @DbOrigem + '.dbo.Pessoas.Assina,
' + @DbOrigem + '.dbo.Pessoas.TipoConta,
' + @DbOrigem + '.dbo.Pessoas.E_InstituicaoEnsino
From ' + @DbOrigem + '.dbo.Pessoas
Left Join Pessoas On Pessoas.Nome = ' + @DbOrigem + '.dbo.Pessoas.Nome
Where ' + @DbOrigem + '.dbo.Pessoas.IdPessoa In (Select Distinct IdSubRegiao From ' + @DbOrigem + '.dbo.Profissionais)
And Pessoas.Nome Is Null
')

/* Sincroniza a tabela Pessoas - IdSubRegiao da tabela de Profissionais*/
Exec('
Insert Into Pessoas (IdContaProvisao, IdFormaCredito, Nome, CNPJCPF, NomeFantasia, Endereco, NomeBairro, NomeCidade, SiglaUF, CEP, DataUltimaAtualizacaoEnd, Telefone, Email, Banco, Agencia, Conta, UsaBanco, Habilitado, Ativo, Atualizado, E_ConselhoProfissao, InscricaoEstadual, InscricaoMunicipal, DataRegistro, DataFundacao, TipoConselho, NaturezaJuridica, CapitalSocial, Codigo, Sigla, ObjetoSocial, Observacoes, E_PessoaJuridica, E_Fiscal, Assina, TipoConta, E_InstituicaoEnsino)
Select 
' + @DbOrigem + '.dbo.Pessoas.IdContaProvisao,
' + @DbOrigem + '.dbo.Pessoas.IdFormaCredito,
' + @DbOrigem + '.dbo.Pessoas.Nome,
' + @DbOrigem + '.dbo.Pessoas.CNPJCPF,
' + @DbOrigem + '.dbo.Pessoas.NomeFantasia,
' + @DbOrigem + '.dbo.Pessoas.Endereco,
' + @DbOrigem + '.dbo.Pessoas.NomeBairro,
' + @DbOrigem + '.dbo.Pessoas.NomeCidade,
' + @DbOrigem + '.dbo.Pessoas.SiglaUF,
' + @DbOrigem + '.dbo.Pessoas.CEP,
' + @DbOrigem + '.dbo.Pessoas.DataUltimaAtualizacaoEnd,
' + @DbOrigem + '.dbo.Pessoas.Telefone,
' + @DbOrigem + '.dbo.Pessoas.Email,
' + @DbOrigem + '.dbo.Pessoas.Banco,
' + @DbOrigem + '.dbo.Pessoas.Agencia,
' + @DbOrigem + '.dbo.Pessoas.Conta,
' + @DbOrigem + '.dbo.Pessoas.UsaBanco,
' + @DbOrigem + '.dbo.Pessoas.Habilitado,
' + @DbOrigem + '.dbo.Pessoas.Ativo,
' + @DbOrigem + '.dbo.Pessoas.Atualizado,
' + @DbOrigem + '.dbo.Pessoas.E_ConselhoProfissao,
' + @DbOrigem + '.dbo.Pessoas.InscricaoEstadual,
' + @DbOrigem + '.dbo.Pessoas.InscricaoMunicipal,
' + @DbOrigem + '.dbo.Pessoas.DataRegistro,
' + @DbOrigem + '.dbo.Pessoas.DataFundacao,
' + @DbOrigem + '.dbo.Pessoas.TipoConselho,
' + @DbOrigem + '.dbo.Pessoas.NaturezaJuridica,
' + @DbOrigem + '.dbo.Pessoas.CapitalSocial,
' + @DbOrigem + '.dbo.Pessoas.Codigo,
' + @DbOrigem + '.dbo.Pessoas.Sigla,
' + @DbOrigem + '.dbo.Pessoas.ObjetoSocial,
' + @DbOrigem + '.dbo.Pessoas.Observacoes,
' + @DbOrigem + '.dbo.Pessoas.E_PessoaJuridica,
' + @DbOrigem + '.dbo.Pessoas.E_Fiscal,
' + @DbOrigem + '.dbo.Pessoas.Assina,
' + @DbOrigem + '.dbo.Pessoas.TipoConta,
' + @DbOrigem + '.dbo.Pessoas.E_InstituicaoEnsino
From ' + @DbOrigem + '.dbo.Pessoas
Left Join Pessoas On Pessoas.Nome = ' + @DbOrigem + '.dbo.Pessoas.Nome
Where ' + @DbOrigem + '.dbo.Pessoas.IdPessoa In (Select Distinct IdPessoa From ' + @DbOrigem + '.dbo.CursosEventosRealizado)
And Pessoas.Nome Is Null
')

/* Sincroniza a tabela Pessoas - IdPessoaPrincipal*/
Exec('
Insert Into Pessoas (IdContaProvisao, IdFormaCredito, Nome, CNPJCPF, NomeFantasia, Endereco, NomeBairro, NomeCidade, SiglaUF, CEP, DataUltimaAtualizacaoEnd, Telefone, Email, Banco, Agencia, Conta, UsaBanco, Habilitado, Ativo, Atualizado, E_ConselhoProfissao, InscricaoEstadual, InscricaoMunicipal, DataRegistro, DataFundacao, TipoConselho, NaturezaJuridica, CapitalSocial, Codigo, Sigla, ObjetoSocial, Observacoes, E_PessoaJuridica, E_Fiscal, Assina, TipoConta, E_InstituicaoEnsino)
Select 
' + @DbOrigem + '.dbo.Pessoas.IdContaProvisao,
' + @DbOrigem + '.dbo.Pessoas.IdFormaCredito,
' + @DbOrigem + '.dbo.Pessoas.Nome,
' + @DbOrigem + '.dbo.Pessoas.CNPJCPF,
' + @DbOrigem + '.dbo.Pessoas.NomeFantasia,
' + @DbOrigem + '.dbo.Pessoas.Endereco,
' + @DbOrigem + '.dbo.Pessoas.NomeBairro,
' + @DbOrigem + '.dbo.Pessoas.NomeCidade,
' + @DbOrigem + '.dbo.Pessoas.SiglaUF,
' + @DbOrigem + '.dbo.Pessoas.CEP,
' + @DbOrigem + '.dbo.Pessoas.DataUltimaAtualizacaoEnd,
' + @DbOrigem + '.dbo.Pessoas.Telefone,
' + @DbOrigem + '.dbo.Pessoas.Email,
' + @DbOrigem + '.dbo.Pessoas.Banco,
' + @DbOrigem + '.dbo.Pessoas.Agencia,
' + @DbOrigem + '.dbo.Pessoas.Conta,
' + @DbOrigem + '.dbo.Pessoas.UsaBanco,
' + @DbOrigem + '.dbo.Pessoas.Habilitado,
' + @DbOrigem + '.dbo.Pessoas.Ativo,
' + @DbOrigem + '.dbo.Pessoas.Atualizado,
' + @DbOrigem + '.dbo.Pessoas.E_ConselhoProfissao,
' + @DbOrigem + '.dbo.Pessoas.InscricaoEstadual,
' + @DbOrigem + '.dbo.Pessoas.InscricaoMunicipal,
' + @DbOrigem + '.dbo.Pessoas.DataRegistro,
' + @DbOrigem + '.dbo.Pessoas.DataFundacao,
' + @DbOrigem + '.dbo.Pessoas.TipoConselho,
' + @DbOrigem + '.dbo.Pessoas.NaturezaJuridica,
' + @DbOrigem + '.dbo.Pessoas.CapitalSocial,
' + @DbOrigem + '.dbo.Pessoas.Codigo,
' + @DbOrigem + '.dbo.Pessoas.Sigla,
' + @DbOrigem + '.dbo.Pessoas.ObjetoSocial,
' + @DbOrigem + '.dbo.Pessoas.Observacoes,
' + @DbOrigem + '.dbo.Pessoas.E_PessoaJuridica,
' + @DbOrigem + '.dbo.Pessoas.E_Fiscal,
' + @DbOrigem + '.dbo.Pessoas.Assina,
' + @DbOrigem + '.dbo.Pessoas.TipoConta,
' + @DbOrigem + '.dbo.Pessoas.E_InstituicaoEnsino
From ' + @DbOrigem + '.dbo.Pessoas
Inner Join ' + @DbOrigem + '.dbo.Pessoas PC2 On PC2.IdPessoa = ' + @DbOrigem + '.dbo.Pessoas.IdPessoaPrincipal
Left Join Pessoas On Pessoas.Nome = PC2.Nome
Where Pessoas.Nome Is Null
')

/* Sincroniza a table Pessoas - Campo IdPessoaPrincipal */
Exec('
Update Pessoas 
Set IdPessoaPrincipal = P3.IdPessoa
From Pessoas, ' + @DbOrigem + '.dbo.Pessoas PC1 
Inner Join ' + @DbOrigem + '.dbo.Pessoas PC2 On PC2.IdPessoa = PC1.IdPessoaPrincipal
Inner Join Pessoas P3 On P3.Nome = PC2.Nome
Where PC1.Nome = Pessoas.Nome
')

/* Sincroniza a tabela Religioes */
Exec('
Insert Into Religioes (Religiao, IndCricacaoWeb, IndCriacaoWeb)
Select Religiao, NULL, NULL From ' + @DbOrigem + '.dbo.Religioes
Where Religiao Not In (Select Religiao From Religioes)
')

/* Sincroniza a tabela Cidades */
Exec('
Insert Into Cidades (NomeCidade, IndCricacaoWeb, IndCriacaoWeb )
Select NomeCidade, NULL, NULL From ' + @DbOrigem + '.dbo.Cidades
Where NomeCidade Not In (Select NomeCidade From Cidades)
')

/* Sincroniza a tabela Nacionalidades */
Exec('
Insert Into Nacionalidades (Nacionalidade, IndCricacaoWeb, IndCriacaoWeb)
Select Nacionalidade, NULL, NULL From ' + @DbOrigem + '.dbo.Nacionalidades
Where Nacionalidade Not In (Select Nacionalidade From Nacionalidades)
')

/* Sincroniza a tabela Bairros */
Exec('
Insert Into Bairros (NomeBairro, IndCricacaoWeb, IndCriacaoWeb)
Select NomeBairro, NULL, NULL From ' + @DbOrigem + '.dbo.Bairros
Where NomeBairro Not In (Select NomeBairro From Bairros)
')

/* Sincroniza a tabela Estados */
Exec('
Insert Into Estados (SiglaUF)
Select SiglaUF From ' + @DbOrigem + '.dbo.Estados
Where SiglaUF Not In (Select SiglaUF From Estados)
')

/* Sincroniza a tabela NiveisCurso*/
Exec('
Insert Into NiveisCurso (NivelCurso)
Select NivelCurso From ' + @DbOrigem + '.dbo.NiveisCurso
Where NivelCurso Not In (Select NivelCurso From NiveisCurso)
')

/* Sincroniza a tabela AreasAtuacao */
Exec('
Insert Into AreasAtuacao (AreaAtuacao)
Select AreaAtuacao From ' + @DbOrigem + '.dbo.AreasAtuacao
Where AreaAtuacao Not In (Select AreaAtuacao From AreasAtuacao)
')

/* Sincroniza a tabela CursosEventos */
Exec('
Insert Into CursosEventos (NomeCursoEvento,  IdNivelCurso, IdAreaCursoEvento, E_Curso, Observacoes, IndCricacaoWeb)
Select NomeCursoEvento,  NCS.IdNivelCurso, AAS.IdAreaAtuacao, E_Curso, Observacoes, IndCricacaoWeb From ' + @DbOrigem + '.dbo.CursosEventos CEC
Inner Join ' + @DbOrigem + '.dbo.NiveisCurso NCC On NCC.IdNivelCurso = CEC.IdNivelCurso
Inner Join NiveisCurso NCS On NCS.NivelCurso = NCC.NivelCurso
Inner Join ' + @DbOrigem + '.dbo.AreasAtuacao AAC On AAC.IdAreaAtuacao = CEC.IdAreaCursoEvento
Inner Join AreasAtuacao AAS On AAS.AreaAtuacao = AAC.AreaAtuacao
Where NomeCursoEvento Not In (Select NomeCursoEvento From CursosEventos)
')

/* Sincroniza a tabela SituacoesCurso */
Exec('
Insert Into SituacoesCurso (SituacaoCurso)
Select SituacaoCurso  From ' + @DbOrigem + '.dbo.SituacoesCurso
Where SituacaoCurso Not In (Select SituacaoCurso From SituacoesCurso)
')

/* Sincroniza a tabela Especialidades */
Exec('
Insert Into Especialidades (NomeEspecialidade, IndCriacaoWeb)
Select NomeEspecialidade, IndCriacaoWeb From ' + @DbOrigem + '.dbo.Especialidades
Where NomeEspecialidade Not In (Select NomeEspecialidade From Especialidades)
')

/* Sincroniza a tabela CategoriasProf */
Exec('
Insert Into CategoriasProf (NomeCategoriaProf, SiglaCategoriaProf)
Select NomeCategoriaProf, SiglaCategoriaProf From ' + @DbOrigem + '.dbo.CategoriasProf
Where NomeCategoriaProf Not In (Select NomeCategoriaProf From CategoriasProf)
')

/* Sincroniza a tabela TiposInscricao */
Exec('
Insert Into TiposInscricao (TipoInscricao, SiglaTipoInscricao, IndicativoPagamento, PercentualDesconto)
Select TipoInscricao, SiglaTipoInscricao, IndicativoPagamento, PercentualDesconto From ' + @DbOrigem + '.dbo.TiposInscricao
Where TipoInscricao Not In (Select TipoInscricao From TiposInscricao)
')

/* Sincroniza a tabela SituacoesPFPJ*/
Exec('
Insert Into SituacoesPFPJ (IdSituacaoRetorno, NomeSituacao, IndicativoPagamento, PercentualDesconto)
Select IdSituacaoRetorno, NomeSituacao, IndicativoPagamento, PercentualDesconto From ' + @DbOrigem + '.dbo.SituacoesPFPJ
Where NomeSituacao Not In (Select NomeSituacao From SituacoesPFPJ)
')




