/*Oc. 91714 - Gustavo*/
/*Oc. 112740 - Fabricio*/ 

CREATE VIEW [dbo].[vw_PesquisaDocumento] 
AS
 
SELECT dbo.DocumentosSisdoc.IdDocumento,
       dbo.DocumentosSisdoc.NumProtocolo,
       dbo.DocumentosSisdoc.AnoProtocolo,
       dbo.DocumentosSisdoc.NumeroDocumento,
       dbo.DocumentosSisdoc.IdTipoDocumento,
       dbo.DocumentosSisdoc.IdDepartamentoCriacao,
       dbo.DocumentosSisdoc.IdSituacaoDocumento,
       dbo.TiposDocumentos.TipoDocumento,
       (
           CASE dbo.DocumentosSisdoc.IndOrigemDoc
                WHEN 'E' THEN 'Entrada'
                WHEN 'S' THEN 'Saída'
                WHEN 'I' THEN 'Interno'
           END
       ) AS Origem,
       dbo.DocumentosSisdoc.DataDocumento,
       CASE 
            WHEN vw_BuscaPessoa.Nome IS NULL THEN DocumentosSisdoc.Pessoa
            ELSE vw_BuscaPessoa.Nome
       END AS Nome,
       dbo.vw_BuscaPessoa.RegistroConselhoAtual,
       CAST(dbo.DocumentosSisdoc.Assunto AS VARCHAR(100)) AS Assunto,
       dbo.SituacoesDocumento.SituacaoDocumento,
       dbo.DocumentosSisdoc.IdNivelDocumento,
       CAST(dbo.Processos.NumeroProc AS CHAR(18)) AS NumeroProc,
       dbo.TipoProcesso.ProcessoTipo,
       nDoc.NivelAcesso,
       pc.PalavraChave,
       dbo.TiposDocumentos.VerificarNivelConfidencialidade
FROM   dbo.DocumentosSisdoc
       LEFT OUTER JOIN dbo.TiposDocumentos
            ON  dbo.DocumentosSisdoc.IdTipoDocumento = dbo.TiposDocumentos.IdTipoDocumento
       LEFT OUTER JOIN dbo.SituacoesDocumento
            ON  dbo.DocumentosSisdoc.IdSituacaoDocumento = dbo.SituacoesDocumento.IdSituacaoDocumento
       LEFT OUTER JOIN dbo.vw_BuscaPessoa
            ON  dbo.vw_BuscaPessoa.IdPessoa = ISNULL(dbo.DocumentosSisdoc.IdPessoa, - 1)
            AND dbo.vw_BuscaPessoa.IdProfissional = ISNULL(dbo.DocumentosSisdoc.IdProfissional, - 1)
            AND dbo.vw_BuscaPessoa.IdPessoaJuridica = ISNULL(dbo.DocumentosSisdoc.IdPessoaJuridica, - 1)
       LEFT OUTER JOIN dbo.NiveisAcessoDocumento AS nDoc
            ON  nDoc.IdNivelAcessoDocumento = dbo.DocumentosSisdoc.IdNivelDocumento
       LEFT OUTER JOIN dbo.Processos_Documentos
            ON  dbo.DocumentosSisdoc.IdDocumento = dbo.Processos_Documentos.IdDocumento
       LEFT OUTER JOIN dbo.Processos
            ON  dbo.Processos.IdProcesso = dbo.Processos_Documentos.IdProcesso
       LEFT OUTER JOIN dbo.TipoProcesso
            ON  dbo.TipoProcesso.IdTipoProcesso = dbo.Processos.IDTIPOPROCESSO
       LEFT OUTER JOIN dbo.PalavrasChave AS pc
            ON  pc.IdDocumento = dbo.DocumentosSisdoc.IdDocumento
