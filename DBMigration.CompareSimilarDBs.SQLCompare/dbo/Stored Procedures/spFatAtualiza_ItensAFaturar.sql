/*Lucimara - 05/11/2010 - OC 65153*/

CREATE procedure [dbo].[spFatAtualiza_ItensAFaturar] (
@TipoAtualizacao tinyint, @IdItemAFaturar int, @IdUnidade int,
@IdItemProduto int, @IdTipoInclusao int, @IdSituacaoItemAFaturar int,
@Qtde real, @DataPedido datetime, @DataFaturamento datetime, 
@DataCancelamento datetime, @IdUsuarioCancelamento int, @MotivoCancelamento text)
as

  /* 
  Tipo Atualização
  1 - Inclusão
  2 - Alteração
  3 - Cancelamento
  
  Tipo Inclusão
  1 - GD Burti
  2 - Almoxarifado
  3 - Produto especial

  Situação do Item a Faturar
  1 - A Faturar
  2 - Apto A faturar
  3 - Faturado
  4 - Cancelado
  */
     
  Declare @CodErro tinyint, @MsgErro varchar(60)
   
  Set @CodErro = 0
  Set @MsgErro = 'Atualização com Sucesso'
   
  ---------------------  Inicio Validação  -----------------------
  
  IF @TipoAtualizacao NOT IN (1,2,3)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Tipo de atualização inválida.'
  End

  IF @IdTipoInclusao NOT IN (1,2,3) and @TipoAtualizacao = 1
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Tipo de inclusão do produto inválida'
  End

  IF @IdSituacaoItemAFaturar NOT IN (1,2,3,4) and @TipoAtualizacao = 2
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Situação do Item a faturar inválida'
  End

  IF Not Exists (Select 1 from dbo.FatItensAFaturar where IdItemAFaturar = @IdItemAFaturar) and
     @TipoAtualizacao in (2,3)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Item a faturar informado inválido'
  End
  

  IF Not Exists (Select 1 from dbo.Unidades where IdUnidade=@IdUnidade) and
     @TipoAtualizacao = 1
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conselho informado inválido'
  End

  IF (@DataPedido is null) and (@TipoAtualizacao = 1)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Data do Pedido inválida'
  End
  
  IF @IdTipoInclusao = 3 
    IF Not Exists (Select 1 from dbo.FatProdutosEspeciais where IdProduto=@IdItemProduto) and
       @TipoAtualizacao = 1
    Begin
       Set @CodErro = 1
	   Set @MsgErro = 'Produto informado inválido'
    End 
  
  IF @IdTipoInclusao in (1, 2)
    IF Not Exists (Select 1 from dbo.Itens where IdItem=@IdItemProduto) and
       @TipoAtualizacao = 1
    Begin
       Set @CodErro = 1
	   Set @MsgErro = 'Item informado inválido'
    End
  
  IF ((@Qtde is null) or (@Qtde <= 0)) and (@TipoAtualizacao = 1)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Qtde informada inválida'
  End
  
  IF (@DataFaturamento is null) and (@TipoAtualizacao = 2)
     and (@IdSituacaoItemAFaturar = 3)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Data do Faturamento inválida'
  End
  
  IF (@DataCancelamento is null) and (@TipoAtualizacao = 3)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Data do Cancelamento inválida'
  End
  
  IF Not Exists (Select 1 from dbo.Usuarios where IdUsuario=@IdUsuarioCancelamento)
      and (@TipoAtualizacao = 3) 
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Usuário reponsável pelo cancelamento inválido'
  End
  
  IF (@MotivoCancelamento is null) and (@TipoAtualizacao = 3)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Motivo do Cancelamento inválido'
  End
  
  ------------ Início Inclusão / Alteração / Cancelamento --------------
  IF @CodErro = 0
  Begin
    /* Inclusão */
	IF @TipoAtualizacao = 1
	Begin
		Insert into dbo.FatItensAFaturar (IdUnidade, IdItemProduto, IdTipoInclusao, IdSituacaoItemAFaturar, Qtde, DataPedido)
		Values (@IdUnidade, @IdItemProduto, @IdTipoInclusao, 1, @Qtde, @DataPedido)
     		Set @MsgErro = 'Item incluído com sucesso.'
        End
    
    /* Alteração */
	IF @TipoAtualizacao = 2
	Begin
       IF @IdSituacaoItemAFaturar = 3 /*Faturamento*/
       Begin
         Update dbo.FatItensAFaturar 
	 	 Set DataFaturamento = @DataFaturamento, 
             IdSituacaoItemAFaturar = @IdSituacaoItemAFaturar
		 Where IdItemAFaturar = @IdItemAFaturar 
	   End

       IF @IdSituacaoItemAFaturar not in (3,4) /*Alterando a Situação*/
       Begin
         Update dbo.FatItensAFaturar 
	 	 Set IdSituacaoItemAFaturar = @IdSituacaoItemAFaturar
		 Where IdItemAFaturar = @IdItemAFaturar 
	   End
		Set @MsgErro = 'Item atualizado com sucesso.'
    End
    
    /* Cancelamento */
    IF @TipoAtualizacao = 3
	Begin
       Update dbo.FatItensAFaturar 
	   Set DataCancelamento = @DataCancelamento,
           IdSituacaoItemAFaturar = 4,
           IdUsuarioCancelamento = @IdUsuarioCancelamento,
           MotivoCancelamento = @MotivoCancelamento
	   Where IdItemAFaturar = @IdItemAFaturar 
		Set @MsgErro = 'Item cancelado.'
	End     

  End 
--------------------- Retornando o Resultado ---------------------

Select CodErro=@CodErro, MsgErro=@MsgErro 
