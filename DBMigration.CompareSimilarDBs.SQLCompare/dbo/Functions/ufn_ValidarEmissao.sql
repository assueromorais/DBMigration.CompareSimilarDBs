

CREATE FUNCTION dbo.ufn_ValidarEmissao (@IdDetalheEmissao INT)
RETURNS BIT
AS 
BEGIN 
	DECLARE @EmissaoValida BIT
	
	/* Compara valores das tabelas DetalhesEmissao e ComposicaoEmisao, estava acontecendo de na 
	*  DetalhesEmissao os valores ficarem zerados e na ComposicoesEmissao, os valores eram preenchidos 
	*  corretamente */
	IF NOT EXISTS(SELECT TOP 1 1 
	              FROM   DetalhesEmissao de 
	                     JOIN EmissoesConfig ec ON ec.IdEmissaoConfig = de.IdEmissaoConfig
	              WHERE  de.IdDetalheEmissao = @IdDetalheEmissao
	                AND  de.ValorEmissao = (SELECT SUM(ce.ValorDevido) 
	                                        FROM   ComposicoesEmissao ce
	                                        WHERE  ce.IdDetalheEmissao = de.IdDetalheEmissao)
	                AND  de.ValorEmissao   IS NOT NULL
	                AND  de.DataEmissao    IS NOT NULL
	                AND  de.DataVencimento IS NOT NULL
	                /* 1 -> Imprimir e Gerar PDF; 2 - Arquivo remessa; 4 - Impressão em boletas via web; 6 - Enviar e-mail */
	                AND  de.TipoEmissao    IN ( 1, 2, 4, 6 )
	                /* 0 -> Emissão normal; 1 - Emissão unificada*/
	                AND  de.TipoComposicao IN ( 0, 1 )
	                /* Seu número corretamente preenchido - não pode ser nulo, nem vazio nem só zero */
	                AND  REPLACE(ISNULL(de.SeuNumero, ''),'0','') <> ''
	                /* Nosso número corretamente preenchido (segue regra do seu número), exceto se a emissão
	                *  estiver marcada para não gerar nosso número */
	                AND  (REPLACE(ISNULL(de.NossoNumero, ''),'0','') <> '' OR ec.GerarNossoNumero = 0)
	                AND ISNULL(de.CodBanco, '') <> ''
	                AND ISNULL(de.CodAgencia, '') <> ''
	                AND ISNULL(de.CodCC_Conv_Ced, '') <> '')
		SET @EmissaoValida = 0
	ELSE
		SET @EmissaoValida = 1
		
	RETURN @EmissaoValida	
END		
