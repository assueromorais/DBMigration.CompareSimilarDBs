

/*André - 18/08/2008*/
CREATE   PROCEDURE [dbo].[sp_ConciliacaoRelacaoCredito]
@IdBanco INT,
@Valor MONEY,
@Data VARCHAR(8),
@ValorMenor BIT = 0,
@DataInicio VARCHAR(8) = '18990101'

AS

IF @ValorMenor = 0 
	SELECT IdRelacaoCredito Id, DataRelacaoCredito, NumRelacaoCredito, ValorRelacaoCredito FROM RelacoesCreditos
	WHERE ValorRelacaoCredito = @Valor
	AND DataRelacaoCredito <= @Data + ' 23:59:59'
	AND YEAR(DataRelacaoCredito) = YEAR(@Data)
	AND (Conciliado = 0 OR Conciliado IS NULL)
	ORDER BY DataRelacaoCredito DESC, NumRelacaoCredito
ELSE
	SELECT IdRelacaoCredito Id, DataRelacaoCredito, NumRelacaoCredito, ValorRelacaoCredito FROM RelacoesCreditos
	WHERE ValorRelacaoCredito <= @Valor
	AND DataRelacaoCredito <= @Data + ' 23:59:59'
	AND YEAR(DataRelacaoCredito) = YEAR(@Data)
	AND (Conciliado = 0 OR Conciliado IS NULL)
	ORDER BY DataRelacaoCredito DESC, NumRelacaoCredito




