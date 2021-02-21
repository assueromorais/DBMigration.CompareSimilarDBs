

CREATE PROCEDURE dbo.sp_DeletarDocumentoSisDoc @IdDocumento INTEGER
AS
SET NOCOUNT ON
DELETE DocumentosRelacionados   WHERE IdDocumento1 = @IdDocumento OR IdDocumento2 = @IdDocumento
DELETE Ocorrencias              WHERE IndPaiOcorrencia = 8 AND IdPaiOcorrencia = @IdDocumento
DELETE ComplementoDocEmitido    WHERE IdDocumento = @IdDocumento
DELETE Tramitacoes              WHERE IdDocumento = @IdDocumento
DELETE CaminhosEletronicos      WHERE IdDocumento = @IdDocumento
DELETE PalavrasChave            WHERE IdDocumento = @IdDocumento
DELETE DivAtiva_Documentos      WHERE IdDocumento = @IdDocumento
DELETE Fiscalizacoes_Documentos WHERE IdDocumento = @IdDocumento
DELETE Processos_Documentos     WHERE IdDocumento = @IdDocumento
DELETE DocumentosSisDoc         WHERE IdDocumento = @IdDocumento
SET NOCOUNT OFF




