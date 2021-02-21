

CREATE PROCEDURE [dbo].[sp_SincronizaTabelaProfissionais] 
@DbOrigem varchar(50) = 'Implanta_CoreconSP'
AS
Exec('
Update Profissionais Set
Profissionais.IdSubRegiao = PC.IdSubRegiao,
Profissionais.IdReligiao = RS.IdReligiao, Profissionais.IdCidadeNaturalidade = CS.IdCidade,
Profissionais.IdNacionalidade = NS.IdNacionalidade, Profissionais.NomeBairro = PC.NomeBairro,
Profissionais.NomeCidade = PC.NomeCidade, Profissionais.SiglaUF = PC.SiglaUF, 
Profissionais.SiglaUFNaturalidade = PC.SiglaUFNaturalidade, Profissionais.Endereco = PC.Endereco, 
Profissionais.CEP = PC.CEP, Profissionais.E_Exterior = PC.E_Exterior, 
Profissionais.E_Residencial = PC.E_Residencial, Profissionais.Atualizado = PC.Atualizado, 
Profissionais.DataUltimaAtualizacao = PC.DataUltimaAtualizacao, Profissionais.Sexo = PC.Sexo, 
Profissionais.DataNascimento = PC.DataNascimento, Profissionais.TipoSanguineo = PC.TipoSanguineo, 
Profissionais.CPF = PC.CPF, Profissionais.CTPS = PC.CTPS, Profissionais.SerieCTPS = PC.SerieCTPS, 
Profissionais.RG = PC.RG, Profissionais.RGDataEmissao = PC.RGDataEmissao, 
Profissionais.RGOrgaoEmissao = PC.RGOrgaoEmissao, Profissionais.SiglaUFRG = PC.SiglaUFRG, 
Profissionais.TipoCarteiraIdentidade = PC.TipoCarteiraIdentidade, Profissionais.CertificadoReserv = PC.CertificadoReserv, 
Profissionais.CertificadoReservCSM = PC.CertificadoReservCSM, Profissionais.CertificadoReservData = PC.CertificadoReservData, 
Profissionais.Civil_Militar = PC.Civil_Militar, Profissionais.TituloEleitorInscricao = PC.TituloEleitorInscricao, 
Profissionais.TituloEleitorZona = PC.TituloEleitorZona, Profissionais.TituloEleitorSecao = PC.TituloEleitorSecao, 
Profissionais.TituloEleitorDataEmissao = PC.TituloEleitorDataEmissao, Profissionais.NomeCidadeTitEleitor = PC.NomeCidadeTitEleitor, 
Profissionais.SiglaUFTituloEleitor = PC.SiglaUFTituloEleitor, Profissionais.NomePai = PC.NomePai, 
Profissionais.NomeMae = PC.NomeMae, Profissionais.Fotografia = PC.Fotografia, 
Profissionais.Raca = PC.Raca, Profissionais.EstadoCivil = PC.EstadoCivil, 
Profissionais.EnderecoEMail = PC.EnderecoEMail, Profissionais.TelefoneResid = PC.TelefoneResid, 
Profissionais.TelefoneTrab = PC.TelefoneTrab, Profissionais.ExibirDadosWeb = PC.ExibirDadosWeb, 
Profissionais.EnderecoEMail2 = PC.EnderecoEMail2, 
Profissionais.Site = PC.Site, Profissionais.Site2 = PC.Site2, 
Profissionais.NomeConjuge = PC.NomeConjuge, Profissionais.CaixaPostal = PC.CaixaPostal, 
Profissionais.E_Fiscal = PC.E_Fiscal, Profissionais.RNE = PC.RNE, 
Profissionais.IndicativoProf1 = PC.IndicativoProf1, Profissionais.IndicativoProf2 = PC.IndicativoProf2, 
Profissionais.IndicativoProf3 = PC.IndicativoProf3, Profissionais.AtualizacaoWeb = PC.AtualizacaoWeb 
From 
ControleSincronizacao CTS, 
' + @DbOrigem + '.dbo.Profissionais PC 
Left Join ' + @DbOrigem + '.dbo.Religioes RC On RC.IdReligiao = PC.IdReligiao 
Left Join Religioes RS On RS.Religiao = RC.Religiao 
Left Join ' + @DbOrigem + '.dbo.Cidades CC On CC.IdCidade = PC.IdCidadeNaturalidade 
Left Join Cidades CS On CS.NomeCidade = CC.NomeCidade 
Left Join ' + @DbOrigem + '.dbo.Nacionalidades NC On NC.IdNacionalidade = PC.IdNacionalidade
Left Join Nacionalidades NS On NS.Nacionalidade = NC.Nacionalidade
Where CTS.IdCorecon = PC.IdProfissional 
And Profissionais.IdProfissional = CTS.IdSindecon
')




