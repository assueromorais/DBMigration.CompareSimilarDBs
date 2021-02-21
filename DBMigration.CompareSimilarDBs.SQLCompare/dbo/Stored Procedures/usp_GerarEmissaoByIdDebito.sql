	

CREATE PROCEDURE dbo.usp_GerarEmissaoByIdDebito (	
    @IdBanco                       INT,
    @IdContaCorrente               INT,
    @IdConvenio                    INT,
    @TipoEmissao                   INT,
    @TipoComposicao                INT,
    @TipoDivisaoDesp               INT,
    @GerarNossoNumero              BIT,
    @EmissaoComDesconto            INT,
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
    @IdDebito                      INT,
    @Titulo                        VARCHAR(200),
    @TipoPessoa                    TINYINT,
    @IdRelatorio                   INT,
    @Chave                         UNIQUEIDENTIFIER = NULL,
    @Executar                      BIT
)
AS
BEGIN
	SET NOCOUNT ON
		
	DECLARE @ConfigEmissao     ConfigEmissao,
	        @Debitos           Debitos
	
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
	
	INSERT INTO @Debitos
	  (
	    IdDebito
	  )
	VALUES
	  (
	    @IdDebito
	  ) 
	
	EXEC dbo.usp_GerarEmissaoByUserType @ConfigEmissao, @Debitos, @Executar
END
