

CREATE PROCEDURE [dbo].[sp_SincronizaEnderecos] 
@NovoProf bit = 0,
@DbOrigem varchar(50) = 'Implanta_CoreconSP'
AS

If @NovoProf = 0 
Exec('	
	Update Enderecos Set
	Enderecos.Endereco = EC.Endereco, Enderecos.NomeBairro = EC.NomeBairro, Enderecos.NomeCidade = EC.NomeCidade,
	Enderecos.SiglaUf = EC.SiglaUf, Enderecos.CEP = EC.CEP, Enderecos.E_Exterior = EC.E_Exterior,
	Enderecos.E_Residencial = EC.E_Residencial, Enderecos.Correspondencia = EC.Correspondencia, Enderecos.Atualizado = EC.Atualizado,
	Enderecos.DataUltimaAtualizacao = EC.DataUltimaAtualizacao, Enderecos.CaixaPostal = EC.CaixaPostal, Enderecos.AtualizacaoWeb = EC.AtualizacaoWeb
	From Profissionais PS, ' + @DbOrigem + '.dbo.Profissionais PC,
	' + @DbOrigem + '.dbo.Enderecos EC, ControleSincronizacao CS
	Where CS.IdSindecon = PS.IdProfissional
	And PC.IdProfissional = CS.IdCorecon
	And Enderecos.Endereco = PS.Endereco
	And EC.Endereco = PC.Endereco
')
Else
	Insert Into Enderecos (IdProfissional, Endereco, NomeBairro, NomeCidade, SiglaUf, CEP, E_Exterior, E_Residencial, Correspondencia, Atualizado, DataUltimaAtualizacao, CaixaPostal, AtualizacaoWeb)
	Select Profissionais.IdProfissional, Profissionais.Endereco, Profissionais.NomeBairro, Profissionais.NomeCidade, IsNull(Profissionais.SiglaUf, ''), 
	Profissionais.CEP, Profissionais.E_Exterior, IsNull(Profissionais.E_Residencial, 0), 1, IsNull(Profissionais.Atualizado, 0), Profissionais.DataUltimaAtualizacao, Profissionais.CaixaPostal, Profissionais.AtualizacaoWeb
	From Profissionais 
	Left Join Enderecos On Enderecos.Endereco = Profissionais.Endereco
	Where Enderecos.IdEndereco Is Null
	And Profissionais.Endereco Is Not Null




