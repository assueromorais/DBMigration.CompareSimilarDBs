/*Lucimara - 09/11/2010 - OC 65153*/
CREATE procedure [dbo].[spFatAtualiza_NotasDebito](
@TipoAtualizacao tinyint, @IdNotaDebito int, @IdSituacaoNotaDebito INT, 
@IdUsuarioEmissao INT, @ValorTotalNota MONEY, @HistoricoSolicitacao VARCHAR(4000),
@DataPagamento DATETIME, @ValorPago MONEY, @idContaReceita int, @IdContaBanco int,
@IdLancamentoRec INT, @HistoricoRec VARCHAR(2000), @DataCancelamento DATETIME, 
@IdUsuarioCancelamento INT, @MotivoCancelamento VARCHAR(4000))
AS
  /* 
  Tipo Atualização
  1 - Atualização (do valor total / Histórico / Situação da Nota)
  2 - Pagamento
  3 - Cancelamento
  4 - Exclusão
  5 - Estorno de Pagamento
  
  Situação da Nota de Débito
  1 - Gerada
  2 - Emitida e não paga
  3 - Paga
  4 - Cancelada
  */
       
  Declare @CodErro tinyint, @MsgErro varchar(60), @DataEmissao DATETIME,
		  @strSQL VARCHAR(2000), @intIdUnidade INT, @ComandoAnterior TINYINT,
		  @IdSituacaoNotaDebitoAtual INT, @intProximoNum INT, 
		  @IdReceita_incluido INT, @IdReceita_ant INT
   
  Set @CodErro = 0
  Set @MsgErro = 'Atualização com Sucesso.'
  Set @intProximoNum = 0
   
  ---------------------  Inicio Validação  -----------------------
  
  IF @TipoAtualizacao NOT IN (1,2,3,4,5)
  BEGIN
     Set @CodErro = 1
	 Set @MsgErro = 'Tipo de atualização inválida.'
  END 

  IF Not Exists (Select 1 from dbo.FatNotasDebito where IdNotaDebito=@IdNotaDebito)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Nota de Débito inválida.'
  End

  IF (@IdSituacaoNotaDebito IS NOT NULL) and (@IdSituacaoNotaDebito NOT IN (1,2,3,4)) 
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Situação da Nota de Débito inválida.'
  End

  --Conferir situação atual da nota para verificar se o tipo de operação é permitido 
  SET @IdSituacaoNotaDebitoAtual = (Select IdSituacaoNotaDebito from dbo.FatNotasDebito where IdNotaDebito=@IdNotaDebito)

  --Se operação = 'Atualização' e  Situação <> 'Gerada'
  IF @TipoAtualizacao = 1 AND @IdSituacaoNotaDebitoAtual <> 1 
  BEGIN    	
     Set @CodErro = 1
     Set @MsgErro = 'Operação de Atualização inválida. Nota de Débito deve estar na Situação "Gerada".'
  END
    
  --Se operação = 'Pagamento' e  Situação <> 'Emitida e Não Paga'
  IF @TipoAtualizacao = 2 AND @IdSituacaoNotaDebitoAtual <> 2 
  BEGIN    	
     Set @CodErro = 1
     Set @MsgErro = 'Operação de Pagamento inválida. Nota de Débito deve estar na Situação "Emitida e Não Paga".'
  END

  --Se operação = 'Cancelamento' e Situação <> 'Emitida e Não Paga'
  IF @TipoAtualizacao = 3 AND @IdSituacaoNotaDebitoAtual <> 2 
  BEGIN    	
     Set @CodErro = 1
     Set @MsgErro = 'Operação de Cancelamento inválida. Nota de Débito deve estar na Situação "Emitida e Não Paga".'
  END    
        
  --Se operação = 'Exclusão' e  Situação <> 'Gerada'
  IF @TipoAtualizacao = 4 AND @IdSituacaoNotaDebitoAtual <> 1 
  BEGIN    	
     Set @CodErro = 1
     Set @MsgErro = 'Operação de Exclusão inválida. Nota de Débito deve estar na Situação "Gerada".'
  END         

  --Se operação = 'Estorno de Recebimento' e Situação <> 'Paga'
  IF @TipoAtualizacao = 5 AND @IdSituacaoNotaDebitoAtual <> 3 
  BEGIN    	
     Set @CodErro = 1
     Set @MsgErro = 'Operação de Estorno de Recebimento inválida. Nota de Débito deve estar na Situação "Paga".'
  END 

  IF (@TipoAtualizacao = 1) AND (@ValorTotalNota IS NULL) AND (@IdSituacaoNotaDebito IS NULL)
  	 AND (@IdUsuarioEmissao IS NULL) AND (@HistoricoSolicitacao IS NULL)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Dados não preenchidos para atualização.'
  END  	    

  IF (@ValorTotalNota IS NOT NULL) AND (@ValorTotalNota <= 0) AND (@TipoAtualizacao = 1)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Valor Total da Nota informado inválido.'
  End
  
  --Ao emitir a nota (Situação = 2), é obrigatório informar o usuário
  IF Not Exists (Select 1 from dbo.Usuarios where IdUsuario=@IdUsuarioEmissao)
     and (@TipoAtualizacao = 1) AND (@IdSituacaoNotaDebito = 2) 
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Usuário responsável pela emissão da Nota inválido.'
  End 

  IF (@DataPagamento is null) and (@TipoAtualizacao = 2)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Data de Pagamento inválida.'
  End
  
  IF ((@ValorPago IS NULL) OR (@ValorPago <= 0)) AND (@TipoAtualizacao in (2,5))
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Valor Pago inválido.'
  End  
  
  IF (Not Exists (Select 1 from dbo.PlanoContas where IdConta=@IdContaReceita))
  AND (@TipoAtualizacao in (2,5))  
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conta Receita do Conselho inválida.'
  End
 
  IF (Not Exists (Select 1 from dbo.PlanoContas where IdConta=@IdContaBanco))
  AND (@TipoAtualizacao in (2,5))   
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conta Banco do Conselho inválida.'
  End
   
  IF (@HistoricoRec IS NULL) AND (@TipoAtualizacao in (2,5)) 
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Histórico inválido.'
  END  
  
  IF (@DataCancelamento is null) and (@TipoAtualizacao = 3)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Data de Cancelamento inválida.'
  End
  
  IF Not Exists (Select 1 from dbo.Usuarios where IdUsuario=@IdUsuarioCancelamento)
      and (@TipoAtualizacao = 3) 
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Usuário reponsável pelo cancelamento inválido.'
  End
  
  IF (@MotivoCancelamento is null) and (@TipoAtualizacao = 3)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Motivo do Cancelamento inválido.'
  End
  
  ---------------- Início - Atualização / Pagamento / Cancelamento / Exclusão -------------------
  IF @CodErro = 0
  Begin
    
    /* Atualização */
    IF @TipoAtualizacao = 1	     
    BEGIN
    	SET @ComandoAnterior = 0
		SET @strSQL = 'Update dbo.FatNotasDebito Set '
		
		IF @ValorTotalNota IS NOT NULL
		BEGIN
			SET @strSQL = @strSQL + 'ValorTotalNota = ' + cast (@ValorTotalNota AS varchar(20))
			SET @ComandoAnterior = 1
		END	
		IF @HistoricoSolicitacao IS NOT NULL
		BEGIN
		    IF @ComandoAnterior = 1 
		       SET @strSQL = @strSQL + ', '
       
			SET @strSQL = @strSQL + 'HistoricoSolicitacao = ''' + @HistoricoSolicitacao + ''''  
			SET @ComandoAnterior = 1
		END	
		IF @IdUsuarioEmissao IS NOT NULL
		BEGIN
		    IF @ComandoAnterior = 1 
		       SET @strSQL = @strSQL + ', '
	
			SET @strSQL = @strSQL + 'IdUsuarioEmissao = ' + cast(@IdUsuarioEmissao AS varchar(20))
			SET @ComandoAnterior = 1
		END	
		IF @IdSituacaoNotaDebito IS NOT NULL --Atualizar situação para Nota Emitida
		BEGIN
		    IF @ComandoAnterior = 1 
		       SET @strSQL = @strSQL + ', '

			SET @strSQL = @strSQL + 'IdSituacaoNotaDebito = ' + cast(@IdSituacaoNotaDebito AS varchar(20))			
		END	
	    SET @strSQL = @strSQL + ' WHERE IdNotaDebito = ' + cast(@IdNotaDebito AS varchar(20))

		EXEC( @strSQL )

	    if @IdSituacaoNotaDebito = 2
		Set @MsgErro = 'Nota de Débito emitida com sucesso!'    
            else
		Set @MsgErro = 'Nota de Débito atualizada com sucesso!'
    End
    
    /*Pagamento*/
	IF @TipoAtualizacao = 2
	BEGIN
		/*Incluindo a Receita*/
		
       SELECT @intProximoNum = ISNULL(MAX(NumeroReceita),0)+1 FROM Receitas WHERE AnoExercicio = YEAR(@DataPagamento)
	   
	   INSERT INTO Receitas
		(
		 NumeroReceita,	AnoExercicio, DataReceita, IdConta,IdContaBanco,
		 ValorReceita,	ValorUnitario,	IdLancamento, Historico, Estornado,
		 ValorCustoReceita, QtdReceita
		)
		VALUES
		(	
		@intProximoNum, YEAR(@DataPagamento), @DataPagamento, @idContaReceita, @IdContaBanco,
		@ValorPago, @ValorPago, @IdLancamentoRec, @HistoricoRec, 0, 0, 1 		
		)

		Set @IdReceita_incluido= SCOPE_IDENTITY()    			
		
        Update dbo.FatNotasDebito 
	 	Set DataPagamento = @DataPagamento, 
            IdSituacaoNotaDebito = 3,
            ValorPago = @ValorPago,
            IdReceita = @IdReceita_incluido
		Where IdNotaDebito = @IdNotaDebito 
		Set @MsgErro = 'Recebimento da Nota de Débito efetuado.'
	End
           
    /* Cancelamento */
    IF @TipoAtualizacao = 3
	BEGIN
		/*Retornando os itens para a tabela de Itens a Faturar*/
		SET @intIdUnidade = (SELECT IdUnidade FROM FatNotasDebito WHERE IdNotaDebito=@IdNotaDebito) 
		SET @DataEmissao = (SELECT DataEmissao FROM FatNotasDebito WHERE IdNotaDebito=@IdNotaDebito)		
		
		Insert into dbo.FatItensAFaturar (IdUnidade,IdItemProduto,IdTipoInclusao,IdSituacaoItemAFaturar,Qtde,DataPedido)
        Select @intIdUnidade,IdItemProduto,IdTipoInclusao,1,Qtde, @DataEmissao
        FROM FatItensNotasDebito
        Where IdNotaDebito=@IdNotaDebito	

        Update dbo.FatNotasDebito 
		Set DataCancelamento = @DataCancelamento,
           IdSituacaoNotaDebito = 4,
           IdUsuarioCancelamento = @IdUsuarioCancelamento,
           MotivoCancelamento = @MotivoCancelamento
        Where IdNotaDebito = @IdNotaDebito
		Set @MsgErro = 'Nota de Débito cancelada.'
	End       
    
    /* Exclusão */
	IF @TipoAtualizacao = 4
	Begin
		Delete dbo.FatNotasDebito 
		From dbo.FatNotasDebito
		Where IdNotaDebito=@IdNotaDebito
		Set @MsgErro = 'Nota de Débito excluída.'		
	END
	
	/*Estorno de Pagamento*/
	IF @TipoAtualizacao = 5
	BEGIN
		/*Incluindo a Receita Negativa*/
		
       SELECT @intProximoNum = ISNULL(MAX(NumeroReceita),0)+1 FROM Receitas WHERE AnoExercicio = YEAR(GETDATE())
	   SELECT @IdReceita_ant = IdReceita FROM FatNotasDebito  WHERE IdNotaDebito = @IdNotaDebito
	      
	   Update dbo.Receitas 
	 	Set Estornado = 1 
        Where IdReceita = @IdReceita_ant	   
	   
	   INSERT INTO Receitas
		(
		 NumeroReceita,	AnoExercicio, DataReceita, IdConta,IdContaBanco,
		 ValorReceita, ValorUnitario, IdLancamento, Historico, Estornado,
		 ValorCustoReceita, QtdReceita
		)
		VALUES
		(	
		@intProximoNum, YEAR(GetDate()), GETDATE(), @idContaReceita, @IdContaBanco,
		-@ValorPago, -@ValorPago, @IdLancamentoRec, @HistoricoRec, 0, 0, 1 		
		)
		
        Update dbo.FatNotasDebito 
	 	Set DataPagamento = NULL, 
            IdSituacaoNotaDebito = 2,
            ValorPago = NULL,
            IdReceita = NUll
		Where IdNotaDebito = @IdNotaDebito 
		Set @MsgErro = 'Estorno de Recebimento da Nota de Débito efetuado.'
	End

	  
  End 
--------------------- Retornando o Resultado ---------------------

Select CodErro=@CodErro, MsgErro=@MsgErro, NumeroReceita=@intProximoNum
