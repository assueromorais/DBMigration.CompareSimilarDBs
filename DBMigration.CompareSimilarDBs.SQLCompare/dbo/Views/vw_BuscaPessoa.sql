


CREATE VIEW dbo.vw_BuscaPessoa
AS
		SELECT
			PF.IdProfissional,
			-1 AS IdPessoaJuridica,
			-1 AS IdPessoa,
			PF.RegistroConselhoAtual,
			PF.Nome,
			PF.SituacaoAtual
		FROM
			dbo.Profissionais PF

		UNION

		SELECT
			-1 IdProfissional,
			PJ.IdPessoaJuridica AS IdPessoaJuridica,
			-1 AS IdPessoa,
			PJ.RegistroConselhoAtual,
			PJ.Nome,
			PJ.SituacaoAtual
		FROM
			dbo.PessoasJuridicas PJ

		UNION

		SELECT
			-1 IdProfissional,
			-1 AS IdPessoaJuridica,
			PS.IdPessoa AS IdPessoa,
			PS.Codigo AS RegistroConselhoAtual,
			PS.Nome,
			NULL AS SituacaoAtual
		FROM
			dbo.Pessoas PS



