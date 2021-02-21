



/*oc. 24711*/ 
CREATE PROCEDURE sp_PreparaDebitos
  @IdProfPj integer = 0,
  @Tipo varchar(2) = 'PF'
AS
BEGIN
  declare @Filtro varchar(40)
  set @Filtro = ''
  if @Tipo = 'PF'
  begin
    if @IdProfPj > 0
	  set @Filtro = ' AND Debitos.IdProfissional = ' +cast(@IdProfPJ as varchar) + ' '
    exec(' Update debitos set bacalhau = 1, RegistraLog = 0 where IdDebito IN '+
         '(                                                                              '+
         'select D.IdDebito from profissionais p ,debitos d, TiposDebito T              '+
         'where p.IdProfissional = D.Idprofissional                                     '+
         '  and T.IdTipoDebito = D.IdTipoDebito                                           '+
         '	and d.NumeroParcela <> 0                                                     '+
         '  and NomeDebito <> ''Renegociação'' '+
         '  and NomeDebito <> ''Recobrança'' '+
         '                                                                               '+
         '                                                                               '+
         'and NOT EXISTS(                                                               '+
         'SELECT IdDebito From Debitos DTodosSemParcela                             '+
         'where  DTodosSemParcela.IdProfissional = D.IdProfissional                  '+
         '                and DTodosSemParcela.NumConjTpDebito = D.NumConjTpDebito       '+
         '	              and DTodosSemParcela.NumeroParcela = 0 AND DTodosSemParcela.NumConjTpDebito is not null '+
         '                and DTodosSemParcela.IdSituacaoAtual <> 9 ' +
         ') '+
         ') '+
         @Filtro    +
         'Update debitos set bacalhau = 1, RegistraLog = 0 where IdDebito IN '+
         '( '+
         '	select D.IdDebito from profissionais p ,debitos d, TiposDebito T '+
         '	where p.IdProfissional = D.Idprofissional '+
         '  and T.IdTipoDebito = D.IdTipoDebito '+
         '  and d.NumeroParcela <> 0 '+
         '	and (NomeDebito = ''Renegociação''  or NomeDebito = ''Recobrança'') '+
         '  and NOT EXISTS( '+
         '			SELECT IdDebito From Debitos DTodosSemParcela '+
         'where  DTodosSemParcela.IdProfissional = D.IdProfissional '+
         '                 and DTodosSemParcela.NumConjReneg = D.NumConjReneg '+
         '                 and DTodosSemParcela.NumeroParcela = 0 '+
         '                 and DTodosSemParcela.IdTipoDebito = d.IdTipoDebito '+
         '                 and DTodosSemParcela.IdSituacaoAtual <> 9 ' +
         ') '+
         ')' +
         @Filtro)
  end
  if @Tipo = 'PJ'
  begin
    if @IdProfPj > 0
	  set @Filtro = ' AND Debitos.IdPessoaJuridica = ' + cast(@IdProfPJ as varchar) + ' '
    exec(' Update debitos set bacalhau = 1, RegistraLog = 0 where IdDebito IN '+
                            '(                                                                              '+
                            '	select D.IdDebito from PessoasJuridicas p ,debitos d, TiposDebito T              '+
                            '	where p.IdPessoaJuridica = D.IdPessoaJuridica                                     '+
                            '	and T.IdTipoDebito = D.IdTipoDebito                                           '+
                            '	and d.NumeroParcela <> 0                                                      '+
                            '	and NomeDebito <> ''Renegociação'' '+
                            ' and NomeDebito <> ''Recobrança'' '+
                            '                                                                               '+
                            '                                                                               '+
                            '	and NOT EXISTS(                                                               '+
                            '			SELECT IdDebito From Debitos DTodosSemParcela                             '+
                            '			where  DTodosSemParcela.IdProfissional is null and DTodosSemParcela.IdPessoaJuridica = D.IdPessoaJuridica                  '+
                            '	                and DTodosSemParcela.NumConjTpDebito = D.NumConjTpDebito       '+
                            '	                and DTodosSemParcela.NumeroParcela = 0 AND DTodosSemParcela.NumConjTpDebito is not null '+
                            '                 and DTodosSemParcela.IdSituacaoAtual <> 9 ' +
                            '	) '+
                            ') '+
                            @Filtro    +
                            'Update debitos set bacalhau = 1, RegistraLog = 0 where IdDebito IN '+
                            '( '+
                            '	select D.IdDebito from PessoasJuridicas p ,debitos d, TiposDebito T '+
                            '	where p.IdPessoaJuridica = D.IdPessoaJuridica '+
                            '	and T.IdTipoDebito = D.IdTipoDebito '+
                            '	and d.NumeroParcela <> 0 '+
                            '	and (NomeDebito = ''Renegociação'' or NomeDebito = ''Recobrança'') '+
                            '	and NOT EXISTS( '+
                            '			SELECT IdDebito From Debitos DTodosSemParcela '+
                            '			where  DTodosSemParcela.IdPessoaJuridica = D.IdPessoaJuridica '+
                            '                 and DTodosSemParcela.NumConjReneg = D.NumConjReneg '+
                            '	                and DTodosSemParcela.NumeroParcela = 0 '+
                            '			and DTodosSemParcela.IdTipoDebito = d.IdTipoDebito '+
                            '     and DTodosSemParcela.IdSituacaoAtual <> 9 ' +
                            '	) '+
                            ')'+
                            @Filtro)

  end
  exec('update debitos set RegistraLog = 1 where RegistraLog = 0')
END




