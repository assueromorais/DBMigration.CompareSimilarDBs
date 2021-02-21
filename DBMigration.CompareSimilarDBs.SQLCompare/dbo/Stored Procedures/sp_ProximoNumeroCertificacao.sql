CREATE  PROCEDURE dbo.sp_ProximoNumeroCertificacao

@IdPessoa int,
@IdLicitacao int
AS

SET NOCOUNT ON

DECLARE @PrefixoCertificacao varchar(6),@ProximoNumero int,@charProximoNumero char(2)
SELECT @PrefixoCertificacao = ISNULL(PrefixoCertificacao,'') FROM Configuracoes
SELECT @ProximoNumero = ISNULL(MAX(SUBSTRING(NumeroCertificacao,LEN(@PrefixoCertificacao)+1,2)),0)+1 FROM Certificacoes
WHERE IdPessoa = @IdPessoa
AND IdLicitacao = @IdLicitacao
AND SUBSTRING(NumeroCertificacao,1,LEN(@PrefixoCertificacao)) = @PrefixoCertificacao

IF @ProximoNumero < 10
	SET @charProximoNumero = '0'+CAST(@ProximoNumero As char(1))
ELSE
	SET @charProximoNumero = CAST(@ProximoNumero As char(2))

SELECT @PrefixoCertificacao+@charProximoNumero,@ProximoNumero,@IdPessoa,@PrefixoCertificacao
