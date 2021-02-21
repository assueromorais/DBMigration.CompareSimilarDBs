/* Time 1 - task 7126 */
CREATE PROCEDURE [dbo].[stp_ConsultaSaldo_Aberto] @Database DATE, @AnoIncial INT
AS 

SELECT x.TipoDebito, x.Ano, sum(x.ValorNaoPago) ValorNaopago, sum(x.ValorPagoMenor) ValorPagoMenor, sum(x.ValorDivAtivaADM) ValorDAAdministrativa,
       sum(x.ValorDivAtivaEXE) ValorDAExecutiva, sum(x.ValorNaoPago)+sum(x.ValorPagoMenor)+sum(x.ValorDivAtivaADM)+sum(x.ValorDivAtivaEXE) AS ValorTotalAberto FROM 
(SELECT debitos.IdProfissional, idDebito, 'PROFISSIONAIS - ANUIDADES' AS TipoDebito , year(DataReferencia) AS ano, 
  CASE WHEN IdSituacaoAtual = 1 OR (IdSituacaoAtual IN (2,4, 5,8) AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorNaoPago,
  CASE WHEN IdSituacaoAtual = 3 AND CAST(DataPgto AS DATE) < @DataBase THEN ValorDevido - isnull(ValorPago,0)
       WHEN IdSituacaoAtual = 3 AND CAST(DataPgto AS DATE) >= @DataBase THEN ValorDevido 
  	ELSE 0
  END ValorPagoMenor,
  CASE WHEN (IdSituacaoAtual = 10 and TipoDividaAtiva = 1) OR (IdSituacaoAtual IN (11,15) and TipoDividaAtiva = 1 AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorDivAtivaADM,
  CASE WHEN (IdSituacaoAtual = 10 and TipoDividaAtiva = 2) OR (IdSituacaoAtual IN (11,15) and TipoDividaAtiva = 2 AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorDivAtivaEXE
  FROM debitos 
  JOIN profissionais p ON p.IdProfissional = debitos.IdProfissional AND p.RegistroConselhoAtual IS NOT null
  WHERE IdTipoDebito = 1 AND debitos.IdProfissional IS NOT NULL  
AND YEAR(DataReferencia) >= @AnoIncial AND YEAR(DataReferencia) < YEAR(@Database)
AND (IdSituacaoAtual in (1,3,10,15) OR (IdSituacaoAtual in (2,4, 5,8,11,15) AND DataPgto > @DataBase)) AND (NumeroParcela = 0 OR NPossuiCotaUnica = 1)
UNION ALL 
SELECT d.IdProfissional, d.idDebito, 'PROFISSIONAIS - ANUIDADES' AS TipoDebito, year(d.DataReferencia) AS ano, 
  CASE WHEN d.idSituacaoAtual = 6 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
   END ValorNaoPago,
  0 as ValorPagoMenor,
  CASE WHEN d.IdSituacaoAtual = 14 and d.TipoDividaAtiva = 1 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
  END ValorDivAtivaADM,
  CASE WHEN d.IdSituacaoAtual = 14 and d.TipoDividaAtiva = 2 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
  END ValorDivAtivaEXE
  FROM debitos d
JOIN profissionais p ON p.IdProfissional = d.IdProfissional AND p.RegistroConselhoAtual IS NOT null
JOIN ComposicoesDebito cd ON cd.IdDebitoOrigemRen = d.IdDebito
JOIN debitos d2 ON d2.iddebito = cd.iddebito
WHERE d.IdTipoDebito = 1 AND d.IdProfissional IS NOT NULL AND d.idSituacaoAtual IN (6, 14) 
AND YEAR(d.DataReferencia) >= @AnoIncial AND YEAR(d.DataReferencia) < YEAR(@Database) 
AND (d2.IdSituacaoAtual = 1 OR (d2.IdSituacaoAtual IN (2,3,4)AND d2.DataPgto > @Database ))
AND (d2.NumeroParcela = 0 OR d2.NPossuiCotaUnica = 1) 
) x
GROUP BY x.tipodebito, x.ano 

UNION

SELECT x.TipoDebito, x.Ano, sum(x.ValorNaoPago) ValorNaopago, sum(x.ValorPagoMenor) ValorPagoMenor, sum(x.ValorDivAtivaADM) ValorDAAdministrativa,
       sum(x.ValorDivAtivaEXE) ValorDAExecutiva, sum(x.ValorNaoPago)+sum(x.ValorPagoMenor)+sum(x.ValorDivAtivaADM)+sum(x.ValorDivAtivaEXE) AS ValorTotalAberto FROM 
(SELECT debitos.IdProfissional, idDebito, 'PROFISSIONAIS - FUNDO DE SEÇÃO' AS TipoDebito, year(DataReferencia) AS ano, 
  CASE WHEN IdSituacaoAtual = 1  OR (IdSituacaoAtual IN (2,4, 5,8) AND DataPgto > @DataBase) THEN ValorDevido 
  	ELSE 0
  END ValorNaoPago,
  CASE WHEN IdSituacaoAtual = 3 AND CAST(DataPgto AS DATE) < @DataBase THEN ValorDevido - isnull(ValorPago,0)
       WHEN IdSituacaoAtual = 3 AND CAST(DataPgto AS DATE) >= @DataBase THEN ValorDevido 
  	ELSE 0
  END ValorPagoMenor,
  CASE WHEN (IdSituacaoAtual = 10 and TipoDividaAtiva = 1) OR (IdSituacaoAtual = 11 and TipoDividaAtiva = 1 AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorDivAtivaADM,
  CASE WHEN (IdSituacaoAtual = 10 and TipoDividaAtiva = 2) OR (IdSituacaoAtual = 11 and TipoDividaAtiva = 2 AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorDivAtivaEXE
  FROM debitos 
JOIN profissionais p ON p.IdProfissional = debitos.IdProfissional AND p.RegistroConselhoAtual IS NOT null 
WHERE IdTipoDebito = 37 AND debitos.IdProfissional IS NOT NULL  
AND YEAR(DataReferencia) >= @AnoIncial AND YEAR(DataReferencia) < YEAR(@Database)
AND IdSituacaoAtual in (1,3,10,15) AND (NumeroParcela = 0 OR NPossuiCotaUnica = 1)
UNION ALL 
SELECT d.IdProfissional, d.idDebito, 'PROFISSIONAIS - FUNDO DE SEÇÃO' AS TipoDebito, year(d.DataReferencia) AS ano, 
  CASE WHEN d.idSituacaoAtual = 6 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
   END ValorNaoPago,
  0 as ValorPagoMenor,
  CASE WHEN d.IdSituacaoAtual = 14 and d.TipoDividaAtiva = 1 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
  END ValorDivAtivaADM,
  CASE WHEN d.IdSituacaoAtual = 14 and d.TipoDividaAtiva = 2 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
  END ValorDivAtivaEXE
  FROM debitos d
JOIN ComposicoesDebito cd ON cd.IdDebitoOrigemRen = d.IdDebito
JOIN debitos d2 ON d2.iddebito = cd.iddebito
JOIN profissionais p ON p.IdProfissional = d2.IdProfissional AND p.RegistroConselhoAtual IS NOT null
WHERE d.IdTipoDebito = 37 AND d.IdProfissional IS NOT NULL AND d.idSituacaoAtual IN (6, 14) 
AND YEAR(d.DataReferencia) >= @AnoIncial AND YEAR(d.DataReferencia) < YEAR(@Database)
AND (d2.IdSituacaoAtual = 1 OR (d2.IdSituacaoAtual IN (2,3,4)AND d2.DataPgto > @Database )) 
AND (d2.NumeroParcela = 0 OR d2.NPossuiCotaUnica = 1) 

) x
GROUP BY x.TipoDebito, x.ano 

UNION  

SELECT x.TipoDebito, x.Ano, sum(x.ValorNaoPago) ValorNaopago, sum(x.ValorPagoMenor) ValorPagoMenor, sum(x.ValorDivAtivaADM) ValorDAAdministrativa,
       sum(x.ValorDivAtivaEXE) ValorDAExecutiva, sum(x.ValorNaoPago)+sum(x.ValorPagoMenor)+sum(x.ValorDivAtivaADM)+sum(x.ValorDivAtivaEXE) AS ValorTotalAberto FROM 
(SELECT debitos.idPessoaJuridica, idDebito, 'PESSOAS JURÍDICAS - ANUIDADES' AS TipoDebito, year(DataReferencia) AS ano, 
  CASE WHEN IdSituacaoAtual = 1  OR (IdSituacaoAtual IN (2,4, 5,8) AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorNaoPago,
  CASE WHEN IdSituacaoAtual = 3 AND DataPgto < @DataBase THEN ValorDevido - isnull(ValorPago,0)
       WHEN IdSituacaoAtual = 3 AND DataPgto >= @DataBase THEN ValorDevido 
  	ELSE 0
  END ValorPagoMenor,
  CASE WHEN (IdSituacaoAtual = 10 and TipoDividaAtiva = 1) OR (IdSituacaoAtual = 11 and TipoDividaAtiva = 1 AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorDivAtivaADM,
  CASE WHEN (IdSituacaoAtual = 10 and TipoDividaAtiva = 2) OR (IdSituacaoAtual = 11 and TipoDividaAtiva = 2 AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorDivAtivaEXE
  FROM debitos 
JOIN PessoasJuridicas pj ON pj.IdPessoaJuridica = debitos.IdPessoaJuridica AND pj.RegistroConselhoAtual IS NOT NULL 
WHERE IdTipoDebito = 1 AND debitos.idPessoaJuridica IS NOT NULL  
AND YEAR(DataReferencia) >= @AnoIncial AND YEAR(DataReferencia) < YEAR(@Database)
AND IdSituacaoAtual in (1,3,10,15) AND (NumeroParcela = 0 OR NPossuiCotaUnica = 1)
UNION ALL 
SELECT d.idPessoaJuridica, d.idDebito, 'PESSOAS JURÍDICAS - ANUIDADES' AS TipoDebito, year(d.DataReferencia) AS ano, 
  CASE WHEN d.idSituacaoAtual = 6 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
   END ValorNaoPago,
  0 as ValorPagoMenor,
  CASE WHEN d.IdSituacaoAtual = 14 and d.TipoDividaAtiva = 1 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
  END ValorDivAtivaADM,
  CASE WHEN d.IdSituacaoAtual = 14 and d.TipoDividaAtiva = 2 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
  END ValorDivAtivaEXE
  FROM debitos d
JOIN PessoasJuridicas pj ON pj.IdPessoaJuridica = d.IdPessoaJuridica AND pj.RegistroConselhoAtual IS NOT NULL 
JOIN ComposicoesDebito cd ON cd.IdDebitoOrigemRen = d.IdDebito
JOIN debitos d2 ON d2.iddebito = cd.iddebito
WHERE d.IdTipoDebito = 1 AND d.idPessoaJuridica IS NOT NULL AND d.idSituacaoAtual IN (6, 14) 
AND YEAR(d.DataReferencia) >= @AnoIncial AND YEAR(d.DataReferencia) < YEAR(@Database)
AND (d2.IdSituacaoAtual = 1 OR (d2.IdSituacaoAtual IN (2,3,4)AND d2.DataPgto > @Database )) 
AND (d2.NumeroParcela = 0 OR d2.NPossuiCotaUnica = 1) 
) x
GROUP BY x.TipoDebito, x.ano

UNION  

SELECT x.TipoDebito, x.Ano, sum(x.ValorNaoPago) ValorNaopago, sum(x.ValorPagoMenor) ValorPagoMenor, sum(x.ValorDivAtivaADM) ValorDAAdministrativa,
       sum(x.ValorDivAtivaEXE) ValorDAExecutiva, sum(x.ValorNaoPago)+sum(x.ValorPagoMenor)+sum(x.ValorDivAtivaADM)+sum(x.ValorDivAtivaEXE) AS ValorTotalAberto FROM 
(SELECT debitos.idPessoaJuridica, idDebito, 'PESSOAS JURÍDICAS - FUNDO DE SEÇÃO' AS TipoDebito, year(DataReferencia) AS ano, 
  CASE WHEN IdSituacaoAtual = 1  OR (IdSituacaoAtual IN (2,4, 5,8) AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorNaoPago,
  CASE WHEN IdSituacaoAtual = 3 AND DataPgto < @DataBase THEN ValorDevido - isnull(ValorPago,0)
       WHEN IdSituacaoAtual = 3 AND DataPgto >= @DataBase THEN ValorDevido 
  	ELSE 0
  END ValorPagoMenor,
  CASE WHEN (IdSituacaoAtual = 10 and TipoDividaAtiva = 1) OR (IdSituacaoAtual = 11 and TipoDividaAtiva = 1 AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorDivAtivaADM,
  CASE WHEN (IdSituacaoAtual = 10 and TipoDividaAtiva = 2) OR (IdSituacaoAtual = 11 and TipoDividaAtiva = 2 AND DataPgto > @DataBase) THEN ValorDevido
  	ELSE 0
  END ValorDivAtivaEXE
  FROM debitos 
  JOIN PessoasJuridicas pj ON pj.IdPessoaJuridica = debitos.IdPessoaJuridica AND pj.RegistroConselhoAtual IS NOT NULL 
 WHERE IdTipoDebito = 37 AND debitos.idPessoaJuridica IS NOT NULL  
AND YEAR(DataReferencia) >= @AnoIncial AND YEAR(DataReferencia) < YEAR(@Database)
AND IdSituacaoAtual in (1,3,10,15) AND (NumeroParcela = 0 OR NPossuiCotaUnica = 1)
UNION ALL 
SELECT  d.idPessoaJuridica, d.idDebito, 'PESSOAS JURÍDICAS - FUNDO DE SEÇÃO' AS TipoDebito, year(d.DataReferencia) AS ano, 
  CASE WHEN d.idSituacaoAtual = 6 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
   END ValorNaoPago,
  0 as ValorPagoMenor,
  CASE WHEN d.IdSituacaoAtual = 14 and d.TipoDividaAtiva = 1 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
  END ValorDivAtivaADM,
  CASE WHEN d.IdSituacaoAtual = 14 and d.TipoDividaAtiva = 2 THEN cd.ValorEsperadoPrincipal
  	ELSE 0
  END ValorDivAtivaEXE
  FROM debitos d
JOIN PessoasJuridicas pj ON pj.IdPessoaJuridica = d.IdPessoaJuridica AND pj.RegistroConselhoAtual IS NOT NULL 
JOIN ComposicoesDebito cd ON cd.IdDebitoOrigemRen = d.IdDebito
JOIN debitos d2 ON d2.iddebito = cd.iddebito
WHERE d.IdTipoDebito = 37 AND d.idPessoaJuridica IS NOT NULL AND d.idSituacaoAtual IN (6, 14) 
AND YEAR(d.DataReferencia) >= @AnoIncial AND YEAR(d.DataReferencia) < YEAR(@Database) 
AND (d2.IdSituacaoAtual = 1 OR (d2.IdSituacaoAtual IN (2,3,4)AND d2.DataPgto > @Database ))
AND (d2.NumeroParcela = 0 OR d2.NPossuiCotaUnica = 1) 
) x
GROUP BY x.TipoDebito, x.ano
ORDER BY x.TipoDebito, x.ano
