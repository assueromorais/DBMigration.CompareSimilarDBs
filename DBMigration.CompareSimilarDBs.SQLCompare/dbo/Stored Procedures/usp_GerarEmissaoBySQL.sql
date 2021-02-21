
CREATE PROCEDURE dbo.usp_GerarEmissaoBySQL (	
    @IdBanco                       INT,
    @IdContaCorrente               INT,
    @IdConvenio                    INT,
    @TipoEmissao                   INT,
    @TipoComposicao                INT,
    @TipoDivisaoDesp               INT,
    @GerarNossoNumero              BIT,
    @EmissaoComDesconto            INT, /* 0-Emissão normal; 1-Emissão com base no próximo desconto; 2-Emissao em 3 Guias (Até duas emissões com desconto e uma emissão na data de vencimento do débito) */    
    @EmissaoWeb                    BIT,
    @ValorDespBanco                MONEY,
    @ValorDespPostal               MONEY,
    @ValorDespAdv                  MONEY,
    @DataVencimentoBoleto          DATETIME,
    @DataAtualizacao               DATETIME,
    @NaoReceberAposVencimento      BIT,
    @IdProcedimentoAtraso          INT,
    @IdentificarDebitoNoBoleto     BIT,
    @ExibirComposicaoDebito        BIT,	/* 0-Não; 1-Sim; 2-Detalhado*/
    @IndicarDebitosEmAberto        BIT,	
    @InserirRTF_File               BIT,
    @Mensagem                      VARCHAR(4000),
    @Instrucao                     VARCHAR(1000),
    @SQL                           VARCHAR(MAX),
    @Titulo                        VARCHAR(200),
    @TipoPessoa                    TINYINT,
    @IdRelatorio                   INT,
    @Chave                         UNIQUEIDENTIFIER = NULL,
    @Executar                      BIT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ConfigEmissao ConfigEmissao,
			@Debitos       Debitos
	
	INSERT INTO @Debitos ( IdDebito )
	EXEC (@SQL)	 
		
	INSERT INTO @ConfigEmissao
		(
		Titulo,
		TipoPessoa,
		IdRelatorio,
	  	Chave,
		IdBanco,
		IdContaCorrente,
		IdConvenio,
		TipoEmissao,
		TipoComposicao,
		TipoDivisaoDesp,
		GerarNossoNumero,
		EmissaoComDesconto,
		EmissaoWeb,
		ValorDespBanco,
		ValorDespPostal,
		ValorDespAdv,
		DataVencimentoBoleto,
		DataAtualizacao,
		NaoReceberAposVencimento,
		IdProcedimentoAtraso,
		IdentificarDebitoNoBoleto,
		ExibirComposicaoDebito,
		IndicarDebitosEmAberto,
		InserirRTF_File,
		Mensagem, 
		Instrucao
		)
	VALUES
		(
		@Titulo,
		@TipoPessoa,
		@IdRelatorio,
	  	@Chave,
		@IdBanco,
		@IdContaCorrente,
		@IdConvenio,
		@TipoEmissao,
		@TipoComposicao,
		@TipoDivisaoDesp,
		@GerarNossoNumero,
		@EmissaoComDesconto,
		@EmissaoWeb,
		@ValorDespBanco,
		@ValorDespPostal,
		@ValorDespAdv,
		@DataVencimentoBoleto,
		@DataAtualizacao,
		@NaoReceberAposVencimento,
		@IdProcedimentoAtraso,
		@IdentificarDebitoNoBoleto,
		@ExibirComposicaoDebito,
		@IndicarDebitosEmAberto,
		@InserirRTF_File,
		@Mensagem,
		@Instrucao
		)	 	  	
		
	EXEC dbo.usp_GerarEmissaoByUserType @ConfigEmissao, @Debitos, @Executar		
END
