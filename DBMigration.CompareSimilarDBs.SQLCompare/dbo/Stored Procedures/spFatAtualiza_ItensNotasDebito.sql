/*Lucimara - 04/11/2010 - OC 65153*/
CREATE procedure [dbo].[spFatAtualiza_ItensNotasDebito] (
@TipoAtualizacao tinyint, @IdNotaDebito int, @IdItemNotaDebito int, @IdItemProduto int, 
@IdTipoInclusao int, @Qtde real, @ValorUnitario money)
as

  /* 
  Tipo Atualização
  1 - Inclusão
  2 - Exclusão
  
  Tipo Inclusão
  1 - GD Burti
  2 - Almoxarifado
  3 - Produto especial
  */
     
  Declare @CodErro tinyint, @MsgErro varchar(100), @IdItemAAgrupar INT,
		  @intIdSituacaoNotaDebito INT, @RetornoParaItensAFaturar VARCHAR(3)
   
  Set @CodErro = 0
  Set @MsgErro = 'Atualização com Sucesso.'
   
  ---------------------  Inicio Validação  -----------------------
  
  IF @TipoAtualizacao NOT IN (1,2)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Tipo de atualização inválida.'
  End

  IF @IdTipoInclusao NOT IN (1,2,3) and @TipoAtualizacao = 1
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Tipo de inclusão do produto inválida.'
  End

  IF Not Exists (Select 1 from dbo.FatNotasDebito where IdNotaDebito=@IdNotaDebito)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Nota de Débito inválida.'
  End
  
  IF Not Exists (Select 1 from dbo.FatItensNotasDebito where IdItemNotaDebito = @IdItemNotaDebito) and
     @TipoAtualizacao = 2
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Item da Nota de Débito inválido.'
  End
  

  IF @IdTipoInclusao = 3 
    IF Not Exists (Select 1 from dbo.FatProdutosEspeciais where IdProduto=@IdItemProduto) and
       @TipoAtualizacao = 1
    Begin
       Set @CodErro = 1
	   Set @MsgErro = 'Produto informado inválido.'
    End 
  
  IF @IdTipoInclusao in (1, 2)
    IF Not Exists (Select 1 from dbo.Itens where IdItem=@IdItemProduto) and
       @TipoAtualizacao = 1
    Begin
       Set @CodErro = 1
	   Set @MsgErro = 'Item informado inválido.'
    End
  
  IF ((@Qtde is null) or (@Qtde <= 0)) and (@TipoAtualizacao = 1)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Qtde informada inválida.'
  End

  IF ((@ValorUnitario is null) or (@ValorUnitario <= 0)) and (@TipoAtualizacao = 1)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Valor Unitário informado inválido.'
  End
  
  ---------------- Início Inclusão / Exclusão -------------------
  IF @CodErro = 0
  Begin
    /* Inclusão */
	IF @TipoAtualizacao = 1
	BEGIN
		Set @IdItemAAgrupar = ISNULL(
			(SELECT IdItemNotaDebito 
			FROM dbo.FatItensNotasDebito
			Where IdNotaDebito = @IdNotaDebito and
 		          IdItemProduto = @IdItemProduto and
 		          IdTipoInclusao = @IdTipoInclusao and
 		          ValorUnitario = @ValorUnitario), 0)
		
		Set @IdItemNotaDebito = ISNULL(
			(SELECT Max(IdItemNotaDebito) + 1 
			 FROM dbo.FatItensNotasDebito
			 WHERE IdNotaDebito=@IdNotaDebito), 1)
			 
		IF @IdItemAAgrupar = 0
		   Insert into dbo.FatItensNotasDebito (IdNotaDebito,IdItemNotaDebito,IdItemProduto,IdTipoInclusao,Qtde,ValorUnitario)
		   Values (@IdNotaDebito,@IdItemNotaDebito,@IdItemProduto,@IdTipoInclusao,@Qtde,@ValorUnitario)
		ELSE   
		   UPDATE dbo.FatItensNotasDebito SET Qtde = Qtde + @Qtde WHERE IdNotaDebito = @IdNotaDebito and IdItemNotaDebito = @IdItemAAgrupar	   			
		Set @MsgErro = 'O Item foi incluído com sucesso.'
	END
    
    /* Exclusão */
	IF @TipoAtualizacao = 2
	BEGIN
		/*Retornando o item para a tabela de Itens a Faturar*/
		SET @intIdSituacaoNotaDebito = (SELECT IdSituacaoNotaDebito FROM FatNotasDebito WHERE IdNotaDebito=@IdNotaDebito) 
			
		IF @intIdSituacaoNotaDebito = 1
		BEGIN
			SET @RetornoParaItensAFaturar = 'NAO'
			
			IF EXISTS (SELECT 1 FROM FatItensAFaturar WHERE IdNotaDebito=@IdNotaDebito and
		               IdItemNotaDebito=@IdItemNotaDebito)
		    BEGIN    	
				UPDATE FatItensAFaturar
				SET IdNotaDebito = NULL, IdItemNotaDebito = NULL, IdSituacaoItemAFaturar = 1, DataFaturamento = NULL
				WHERE IdNotaDebito=@IdNotaDebito and
					  IdItemNotaDebito=@IdItemNotaDebito
					  
		    	SET @RetornoParaItensAFaturar = 'SIM'					  	
		    END        
					
			/*Apagando o item da tabela de Itens da Nota de Débito*/
			Delete dbo.FatItensNotasDebito 
			From dbo.FatItensNotasDebito
			Where IdNotaDebito=@IdNotaDebito and
				  IdItemNotaDebito=@IdItemNotaDebito
				  
			IF @RetornoParaItensAFaturar = 'SIM'	  
				Set @MsgErro = 'O Item foi excluído da Nota de débito e retornado para Itens a Faturar.'
			ELSE
				Set @MsgErro = 'O Item foi excluído da Nota de débito.'				
		END
		ELSE
		BEGIN
		    Set @CodErro = 1
			Set @MsgErro = 'Não é possível cancelar um item de uma nota de débito já emitida.'
		END		
	END  
  END 
--------------------- Retornando o Resultado ---------------------

Select CodErro=@CodErro, MsgErro=@MsgErro 
