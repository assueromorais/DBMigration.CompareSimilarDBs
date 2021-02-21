/*Lucimara - 13/12/2010 - OC 65153*/

CREATE procedure [dbo].[spFatAtualiza_NotasDebitoLancamentos](
@TipoAtualizacao tinyint, @IdNotaDebito int, @IdContaPatrimonialUnidade int, @IdContaPatrimonial int, @IdContaReceita int,
@IdContaBanco int, @IdLancamentoPatrimonial int, @IdLancamentoRecebimento INT, @IdLancamentoPat_Inicial int
)
as 
  /* 
  Tipo Atualização
  1 - Inclusão após Emissão da Nota
  2 - Atualização ápós Recebimento da Nota
  3 - Duas Inclusões após Estorno do Recebimento
  4 - Atualização após cancelamento da Nota
  */
  Declare @CodErro tinyint, @MsgErro varchar(60), @IdNotaDebitoLancamento_incluido INT, @IdNotaDebito_Lancamentos INT,
		  @IdContaReceita_Ant int, @IdContaBanco_Ant int
          		     
  Set @CodErro = 0
  Set @MsgErro = 'Atualização com Sucesso.'
   
  ---------------------  Inicio Validação  -----------------------
  
  IF @TipoAtualizacao NOT IN (1,2,3,4)
  BEGIN
     Set @CodErro = 1
	 Set @MsgErro = 'Tipo de atualização inválida.'
  END         
        
  IF Not Exists (Select 1 from dbo.FatNotasDebito where IdNotaDebito=@IdNotaDebito)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Nota de Débito inválida.'
  End        
        
  IF (Not Exists (Select 1 from dbo.PlanoContas where IdConta=@IdContaPatrimonialUnidade))
  AND (@TipoAtualizacao IN (1,3))   
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conta Patrimonial do Conselho inválida.'
  End
 
  IF (Not Exists (Select 1 from dbo.PlanoContas where IdConta=@IdContaPatrimonial))
  AND (@TipoAtualizacao IN (1,3)) 
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conta Patrimonial do Faturamento inválida.'
  End
 
  IF (Not Exists (Select 1 from dbo.PlanoContas where IdConta=@IdContaReceita))
  AND (@TipoAtualizacao = 2)  
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conta Receita do Conselho inválida.'
  End
 
  IF (Not Exists (Select 1 from dbo.PlanoContas where IdConta=@IdContaBanco))
  AND (@TipoAtualizacao = 2)   
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conta Banco do Conselho inválida.'
  End

  IF (@IdLancamentoPatrimonial IS NULL) AND (@TipoAtualizacao IN (2, 3, 4)) 
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Lançamento Patrimonial inválido.'
  End

  IF (@IdLancamentoRecebimento IS NULL) AND (@TipoAtualizacao IN (2, 3))
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Lançamento do Recebimento inválido.'
  End

IF (@IdLancamentoPat_Inicial IS NULL) AND (@TipoAtualizacao = 1)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Lançamento Patrimonial Inicial inválido.'
  End

  ------------------ Início - Atualizações na tabela FatNotasDebitoLancamentos  --------------
  IF @CodErro = 0
  BEGIN 	 	
    /* 1 - Inclusão após Emissão da Nota */
    IF @TipoAtualizacao = 1	     
    BEGIN
        Insert into dbo.FatNotasDebitoLancamentos (IdNotaDebito, IdContaPatrimonialUnidade, IdContaPatrimonial)
		Values (@IdNotaDebito, @IdContaPatrimonialUnidade, @IdContaPatrimonial)

		Set @IdNotaDebitoLancamento_incluido = SCOPE_IDENTITY()    	
    	 
		UPDATE dbo.FatNotasDebito SET
			IdLancamentoPatrimonial_Emissao=@IdLancamentoPat_Inicial,
			IdNotaDebito_Lancamentos=@IdNotaDebitoLancamento_incluido
		WHERE IdNotaDebito=@IdNotaDebito    	    	  	
    END	
 	
	/* 2 - Atualização ápós Recebimento da Nota */
    IF @TipoAtualizacao = 2	     
    BEGIN
		SELECT @IdNotaDebito_Lancamentos = IdNotaDebito_Lancamentos
		FROM FatNotasDebito fnd
		WHERE fnd.IdNotaDebito = @IdNotaDebito    	
    	
    	Update dbo.FatNotasDebitoLancamentos 
    	SET IdContaReceita = @IdContaReceita, 
    	    IdContaBanco = @IdContaBanco,
    	    IdLancamentoPatrimonial = @IdLancamentoPatrimonial,
			IdLancamentoRecebimento = @IdLancamentoRecebimento    	    
    	WHERE IdNotaDebito_Lancamentos = @IdNotaDebito_Lancamentos    	    	    	    	  	
    END 	

    /* 3 - Duas Inclusões após Estorno do Recebimento */
    IF @TipoAtualizacao = 3	     
    BEGIN

        SELECT @IdNotaDebito_Lancamentos = IdNotaDebito_Lancamentos
		FROM FatNotasDebito fnd
		WHERE fnd.IdNotaDebito = @IdNotaDebito    	
		
		--Incluindo o lançamento referente ao estorno
		SELECT @IdContaReceita_Ant = IdContaReceita, 
    	       @IdContaBanco_Ant = IdContaBanco		       
		FROM dbo.FatNotasDebitoLancamentos
		WHERE IdNotaDebito_Lancamentos = @IdNotaDebito_Lancamentos
        
        Insert into dbo.FatNotasDebitoLancamentos (IdNotaDebito, IdContaPatrimonialUnidade, IdContaPatrimonial,
         IdContaReceita, IdContaBanco, IdLancamentoPatrimonial, IdLancamentoRecebimento)
		Values (@IdNotaDebito, @IdContaPatrimonialUnidade, @IdContaPatrimonial,
		 @IdContaReceita_Ant,@IdContaBanco_Ant, @IdLancamentoPatrimonial, @IdLancamentoRecebimento)

        --Incluindo novo lançamento deixando em aberto para futuro recebimento
        Insert into dbo.FatNotasDebitoLancamentos (IdNotaDebito, IdContaPatrimonialUnidade, IdContaPatrimonial)
		Values (@IdNotaDebito, @IdContaPatrimonialUnidade, @IdContaPatrimonial)

		Set @IdNotaDebitoLancamento_incluido= SCOPE_IDENTITY()    	
    	 
		UPDATE dbo.FatNotasDebito SET
            IdNotaDebito_Lancamentos=@IdNotaDebitoLancamento_incluido
		WHERE IdNotaDebito=@IdNotaDebito    	    	  	
    END	

	/* 4 - Atualização após cancelamento da Nota */
    IF @TipoAtualizacao = 4	     
    BEGIN
		SELECT @IdNotaDebito_Lancamentos = IdNotaDebito_Lancamentos
		FROM FatNotasDebito fnd
		WHERE fnd.IdNotaDebito = @IdNotaDebito    	
    	
    	Update dbo.FatNotasDebitoLancamentos 
    	SET IdLancamentoPatrimonial = @IdLancamentoPatrimonial    	    
    	WHERE IdNotaDebito_Lancamentos = @IdNotaDebito_Lancamentos    	    	    	    	  	
    END 	

	Set @MsgErro = 'Lançamentos registrados com sucesso.'		 
  END
   
--------------------- Retornando o Resultado ---------------------

Select CodErro=@CodErro, MsgErro=@MsgErro 
