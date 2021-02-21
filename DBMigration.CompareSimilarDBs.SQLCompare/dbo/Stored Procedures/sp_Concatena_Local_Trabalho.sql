/*
* OC84042
* STORED PROCEDURE responsável por concatenar o local de trabalho ao endereço do profissional nos boletos
*caso o endereço de trabalho esteja assinalado como "correspondência".
*Este script deve se adicionado ao DAT.
*/

CREATE PROCEDURE [dbo].[sp_Concatena_Local_Trabalho]
	@IdProfissional INT,
	@Endereco VARCHAR(200) OUTPUT
AS
IF 	EXISTS (SELECT     ConcatenarLocalTrabalho
FROM         dbo.ParametrosSiscafw WHERE (ConcatenarLocalTrabalho = 0)) SET @Endereco = '' 
ELSE 
	BEGIN
	SELECT CASE 
	            WHEN ISNULL(e.Endereco, '') = '' THEN ''
	            ELSE LTRIM(RTRIM(e.Endereco))
	       END + CASE 
	                  WHEN ISNULL(e.NomeBairro, '') = '' THEN ''
	                  ELSE ', ' + LTRIM(RTRIM(e.Nomebairro))
	             END AS Endereco,
	       ISNULL(
	           CASE 
	                WHEN e.IdPjTrabalho IS NOT NULL THEN (
	                         SELECT PJ.Nome
	                         FROM   PessoasJuridicas PJ
	                         WHERE  e.IdPjTrabalho = pj.IdPessoaJuridica
	                     )
	                ELSE (
	                         SELECT OP.Nome
	                         FROM   Pessoas OP
	                         WHERE  e.IdPessoa = OP.IdPessoa
	                     )
	           END,
	           ''
	       ) AS TRABALHO,
	       e.Correspondencia,
	       e.E_Residencial
	       INTO #T1
	FROM   Enderecos e
	       LEFT JOIN PessoasJuridicas pj
	            ON  e.IdPJTrabalho = pj.IdPessoaJuridica
	       LEFT JOIN Pessoas op
	            ON  e.IdPessoa = op.IdPessoa
	WHERE e.IdProfissional=@IdProfissional
	ORDER BY
	       e.Correspondencia DESC,
	       e.DataUltimaAtualizacao DESC
	
	SELECT TOP 1 @Endereco=CASE 
	                  WHEN Correspondencia = 1 AND E_Residencial = 0 THEN endereco + CASE 
	                                                                                      WHEN trabalho = '' THEN ''
	                                                                                      ELSE ' - ' + Trabalho
	                                                                                 END
	                  ELSE ''
	             END
	FROM   #T1
	END
